Return-Path: <stable+bounces-7815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E80C817951
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0A4285CE3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 18:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCFE5D723;
	Mon, 18 Dec 2023 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbdYwCEx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D435BFB2;
	Mon, 18 Dec 2023 18:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D54C433C7;
	Mon, 18 Dec 2023 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702922402;
	bh=LzuQFZuOToTYP2V+5qmnHqtKbTLkIQfxAdwzBgY6S1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JbdYwCExYIdOY1mGmWfNBXg95sQUEk1oomHwpuLsIZebFoq18N486WPYzGBqDr1OG
	 Rzji+J6VNYfUnRsTri/0uethWy/ehg2Pt0GUGvulH3LZ3K0aBb8lKidK8N3M+QFFqr
	 T3pCfNoWGPqr0+dF6MSjyxOJYQ00K8CUBBxTSs5T9EUJmGwGbqu7DgcR9kjlKeAIY0
	 JRyDrr7eN4P1J3IhmyBMX7MRBufUq53/nUfU9uI/2hAHiGvIVyGhcaBRS1S7EAqVW0
	 9SCMib2QcbAwm5meqk2OoPuiz1SVsKJ1c80OLSFzxZK3FbobxzFW1YQS7fpJsKOe5f
	 8A+K1v1a7zA7g==
From: SeongJae Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	acsjakub@amazon.de,
	akpm@linux-foundation.org,
	changbin.du@intel.com,
	damon@lists.linux.dev
Subject: [PATCH 6.6.y] mm/damon/core: make damon_start() waits until kdamond_fn() starts
Date: Mon, 18 Dec 2023 17:59:59 +0000
Message-Id: <20231218175959.99278-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023121843-pension-tactile-868b@gregkh>
References: <2023121843-pension-tactile-868b@gregkh>
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

Link: https://lkml.kernel.org/r/20231208175018.63880-1-sj@kernel.org
Fixes: 0f91d13366a4 ("mm/damon: simplify stop mechanism")
Signed-off-by: SeongJae Park <sj@kernel.org>
Reported-by: Jakub Acs <acsjakub@amazon.de>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Jakub Acs <acsjakub@amazon.de>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 6376a824595607e99d032a39ba3394988b4fce96)
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c70cca8a839f..e9e8ed92567a 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -524,6 +524,8 @@ struct damon_ctx {
 /* private: internal use only */
 	struct timespec64 last_aggregation;
 	struct timespec64 last_ops_update;
+	/* for waiting until the execution of the kdamond_fn is started */
+	struct completion kdamond_started;
 
 /* public: */
 	struct task_struct *kdamond;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index fd5be73f699f..191bc87b2441 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -423,6 +423,8 @@ struct damon_ctx *damon_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
+	init_completion(&ctx->kdamond_started);
+
 	ctx->attrs.sample_interval = 5 * 1000;
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
@@ -626,11 +628,14 @@ static int __damon_start(struct damon_ctx *ctx)
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
@@ -1370,6 +1375,8 @@ static int kdamond_fn(void *data)
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
+	complete(&ctx->kdamond_started);
+
 	if (ctx->ops.init)
 		ctx->ops.init(ctx);
 	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
-- 
2.34.1


