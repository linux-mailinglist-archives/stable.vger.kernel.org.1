Return-Path: <stable+bounces-5051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525A380AB29
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 18:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C07B281764
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC13B795;
	Fri,  8 Dec 2023 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlSeOLw2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81AA39ADA;
	Fri,  8 Dec 2023 17:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAA8C433C7;
	Fri,  8 Dec 2023 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702057824;
	bh=cE24g6fBBFjzqibu8azeRT7zJ49z9KZ0TlE0lX4ftds=;
	h=From:To:Cc:Subject:Date:From;
	b=UlSeOLw24RssSEoLnv7u5w3h+UtuX6mWYBL9Sh+sfakwDsCwpeUev4OhHzla9QVIF
	 bmw0uUM0zMIhikMsVXI4flrGhT7nrWczvLfnLb1tmAkKqRyW14rS7PD6Z5Ry7jdCsq
	 T31MPJj9y5Fb8f1Mr6tYtVu+EIl+OHlkmWh8HltLCarJhdvkHS0bABlmDzQUyLNme5
	 doKc+VWZ76L7RKDPwaz0dnscdzGMwkMtCW0hA9iauFmt54bTg+k2cPE6iXNd0Kdj7X
	 PPJOahPakyNBrLKKgly1pY+FieuiY/zJxO5qc0fKD5sIqAG7IlfdYpioRXermCrnOS
	 0tBPI3pUhujig==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Changbin Du <changbin.du@intel.com>,
	Jakub Acs <acsjakub@amazon.de>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/core: make damon_start() waits until kdamond_fn() starts
Date: Fri,  8 Dec 2023 17:50:18 +0000
Message-Id: <20231208175018.63880-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cleanup tasks of kdamond threads including reset of corresponding
DAMON context's ->kdamond field and decrease of global nr_running_ctxs
counter is supposed to be executed by kdamond_fn().  However, commit
0f91d13366a4 ("mm/damon: simplify stop mechanism") made neither
damon_start() nor damon_stop() ensure the corresponding kdamond has
started the execution of kdamond_fn().

As a result, the cleanup can be skipped if damon_stop() is called fast
enough after the previous damon_start().  Especially the skipped reset
of ->kdamond could cause a use-after-free.

Fix it by waiting for start of kdamond_fn() execution from
damon_start().

Fixes: 0f91d13366a4 ("mm/damon: simplify stop mechanism")
Reported-by: Jakub Acs <acsjakub@amazon.de>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Note that the report has not publicly made, so this patch doesn't have a
Closes: tag.

 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index aa34ab433bc5..12510d8c51c6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -579,6 +579,8 @@ struct damon_ctx {
 	 * update
 	 */
 	unsigned long next_ops_update_sis;
+	/* for waiting until the execution of the kdamond_fn is started */
+	struct completion kdamond_started;
 
 /* public: */
 	struct task_struct *kdamond;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index f91715a58dc7..2c0cc65d041e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -445,6 +445,8 @@ struct damon_ctx *damon_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
+	init_completion(&ctx->kdamond_started);
+
 	ctx->attrs.sample_interval = 5 * 1000;
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
@@ -668,11 +670,14 @@ static int __damon_start(struct damon_ctx *ctx)
 	mutex_lock(&ctx->kdamond_lock);
 	if (!ctx->kdamond) {
 		err = 0;
+		reinit_completion(&ctx->kdamond_started);
 		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond.%d",
 				nr_running_ctxs);
 		if (IS_ERR(ctx->kdamond)) {
 			err = PTR_ERR(ctx->kdamond);
 			ctx->kdamond = NULL;
+		} else {
+			wait_for_completion(&ctx->kdamond_started);
 		}
 	}
 	mutex_unlock(&ctx->kdamond_lock);
@@ -1483,6 +1488,7 @@ static int kdamond_fn(void *data)
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
+	complete(&ctx->kdamond_started);
 	kdamond_init_intervals_sis(ctx);
 
 	if (ctx->ops.init)
-- 
2.34.1


