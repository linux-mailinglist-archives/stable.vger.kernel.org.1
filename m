Return-Path: <stable+bounces-6946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C10B816707
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 08:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA6EB208B4
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7494847F;
	Mon, 18 Dec 2023 07:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIj+CUHE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8934F846E
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC08CC433C8;
	Mon, 18 Dec 2023 07:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702883213;
	bh=xxWV2FBkSyuGl9JRUOHoSWsviIjCPjai3h2HRb2wNNs=;
	h=Subject:To:Cc:From:Date:From;
	b=RIj+CUHETrfPoU50Lp26/8eXL5EJnm/ENztZbc/whikC4PfkQSLGxF2wvcIIfpFWI
	 0r9qdKD9PkID2hKh6MWg1MQDDFBmfFrHWAEzg5g2KXQF+CEes3Wdp2cCQ066g5ORS2
	 eLjLfPRw4HSswUMaTA9QVBXThHsriawLA+tUHrQk=
Subject: FAILED: patch "[PATCH] mm/damon/core: make damon_start() waits until kdamond_fn()" failed to apply to 6.1-stable tree
To: sj@kernel.org,acsjakub@amazon.de,akpm@linux-foundation.org,changbin.du@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Dec 2023 08:06:50 +0100
Message-ID: <2023121849-ambulance-violate-e5b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6376a824595607e99d032a39ba3394988b4fce96
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121849-ambulance-violate-e5b2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6376a8245956 ("mm/damon/core: make damon_start() waits until kdamond_fn() starts")
4472edf63d66 ("mm/damon/core: use number of passed access sampling as a timer")
2f5bef5a590b ("mm/damon/core: update monitoring results for new monitoring attributes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6376a824595607e99d032a39ba3394988b4fce96 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Fri, 8 Dec 2023 17:50:18 +0000
Subject: [PATCH] mm/damon/core: make damon_start() waits until kdamond_fn()
 starts

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

diff --git a/include/linux/damon.h b/include/linux/damon.h
index ab2f17d9926b..e00ddf1ed39c 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -559,6 +559,8 @@ struct damon_ctx {
 	 * update
 	 */
 	unsigned long next_ops_update_sis;
+	/* for waiting until the execution of the kdamond_fn is started */
+	struct completion kdamond_started;
 
 /* public: */
 	struct task_struct *kdamond;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ce1562783e7e..3a05e71509b9 100644
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
@@ -1433,6 +1438,7 @@ static int kdamond_fn(void *data)
 
 	pr_debug("kdamond (%d) starts\n", current->pid);
 
+	complete(&ctx->kdamond_started);
 	kdamond_init_intervals_sis(ctx);
 
 	if (ctx->ops.init)


