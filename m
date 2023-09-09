Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90CA79981B
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 14:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjIIMxE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbjIIMxE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 08:53:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F699CE6
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 05:52:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C17C433C7;
        Sat,  9 Sep 2023 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694263979;
        bh=BCLKwi1Nzb1b9lhjZzDOUdQQaU8CxFYLe23xFtWLXk4=;
        h=Subject:To:Cc:From:Date:From;
        b=ExN/Zc7YoYDlJDIUrrqYKt0w8O3PwomxiVPuKLbFz9sHc+xGGii/lLLrnglXTvIXe
         h8rkGto5sJiVJ4ZKWGgJ91IR+HSr8wgk4umaTa8JCRdwNrWbCwTZH/sKKky+4kYM3N
         JrJ6cv1l5yQnWG7BTJoNXJWaHi8tOaEnU/a9cHOA=
Subject: FAILED: patch "[PATCH] io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL" failed to apply to 6.1-stable tree
To:     axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 13:52:56 +0100
Message-ID: <2023090956-immersion-calorie-81e9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ebdfefc09c6de7897962769bd3e63a2ff443ebf5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090956-immersion-calorie-81e9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

ebdfefc09c6d ("io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL is used")
eb47943f2238 ("io-wq: Drop struct io_wqe")
dfd63baf892c ("io-wq: Move wq accounting to io_wq")
da64d6db3bd3 ("io_uring: One wqe per wq")
01e68ce08a30 ("io_uring/io-wq: stop setting PF_NO_SETAFFINITY on io-wq workers")
88b80534f60f ("io_uring: make io_sqpoll_wait_sq return void")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ebdfefc09c6de7897962769bd3e63a2ff443ebf5 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 13 Aug 2023 11:05:36 -0600
Subject: [PATCH] io_uring/sqpoll: fix io-wq affinity when IORING_SETUP_SQPOLL
 is used

If we setup the ring with SQPOLL, then that polling thread has its
own io-wq setup. This means that if the application uses
IORING_REGISTER_IOWQ_AFF to set the io-wq affinity, we should not be
setting it for the invoking task, but rather the sqpoll task.

Add an sqpoll helper that parks the thread and updates the affinity,
and use that one if we're using SQPOLL.

Fixes: fe76421d1da1 ("io_uring: allow user configurable IO thread CPU affinity")
Cc: stable@vger.kernel.org # 5.10+
Link: https://github.com/axboe/liburing/discussions/884
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 2da0b1ba6a56..62f345587df5 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1306,13 +1306,16 @@ static int io_wq_cpu_offline(unsigned int cpu, struct hlist_node *node)
 	return __io_wq_cpu_online(wq, cpu, false);
 }
 
-int io_wq_cpu_affinity(struct io_wq *wq, cpumask_var_t mask)
+int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask)
 {
+	if (!tctx || !tctx->io_wq)
+		return -EINVAL;
+
 	rcu_read_lock();
 	if (mask)
-		cpumask_copy(wq->cpu_mask, mask);
+		cpumask_copy(tctx->io_wq->cpu_mask, mask);
 	else
-		cpumask_copy(wq->cpu_mask, cpu_possible_mask);
+		cpumask_copy(tctx->io_wq->cpu_mask, cpu_possible_mask);
 	rcu_read_unlock();
 
 	return 0;
diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
index 31228426d192..06d9ca90c577 100644
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -50,7 +50,7 @@ void io_wq_put_and_exit(struct io_wq *wq);
 void io_wq_enqueue(struct io_wq *wq, struct io_wq_work *work);
 void io_wq_hash_work(struct io_wq_work *work, void *val);
 
-int io_wq_cpu_affinity(struct io_wq *wq, cpumask_var_t mask);
+int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask);
 int io_wq_max_workers(struct io_wq *wq, int *new_count);
 
 static inline bool io_wq_is_hashed(struct io_wq_work *work)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e189158ebbdd..e1a23f4993d3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4183,16 +4183,28 @@ static int io_register_enable_rings(struct io_ring_ctx *ctx)
 	return 0;
 }
 
+static __cold int __io_register_iowq_aff(struct io_ring_ctx *ctx,
+					 cpumask_var_t new_mask)
+{
+	int ret;
+
+	if (!(ctx->flags & IORING_SETUP_SQPOLL)) {
+		ret = io_wq_cpu_affinity(current->io_uring, new_mask);
+	} else {
+		mutex_unlock(&ctx->uring_lock);
+		ret = io_sqpoll_wq_cpu_affinity(ctx, new_mask);
+		mutex_lock(&ctx->uring_lock);
+	}
+
+	return ret;
+}
+
 static __cold int io_register_iowq_aff(struct io_ring_ctx *ctx,
 				       void __user *arg, unsigned len)
 {
-	struct io_uring_task *tctx = current->io_uring;
 	cpumask_var_t new_mask;
 	int ret;
 
-	if (!tctx || !tctx->io_wq)
-		return -EINVAL;
-
 	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
 		return -ENOMEM;
 
@@ -4213,19 +4225,14 @@ static __cold int io_register_iowq_aff(struct io_ring_ctx *ctx,
 		return -EFAULT;
 	}
 
-	ret = io_wq_cpu_affinity(tctx->io_wq, new_mask);
+	ret = __io_register_iowq_aff(ctx, new_mask);
 	free_cpumask_var(new_mask);
 	return ret;
 }
 
 static __cold int io_unregister_iowq_aff(struct io_ring_ctx *ctx)
 {
-	struct io_uring_task *tctx = current->io_uring;
-
-	if (!tctx || !tctx->io_wq)
-		return -EINVAL;
-
-	return io_wq_cpu_affinity(tctx->io_wq, NULL);
+	return __io_register_iowq_aff(ctx, NULL);
 }
 
 static __cold int io_register_iowq_max_workers(struct io_ring_ctx *ctx,
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 5e329e3cd470..ee2d2c687fda 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -421,3 +421,18 @@ __cold int io_sq_offload_create(struct io_ring_ctx *ctx,
 	io_sq_thread_finish(ctx);
 	return ret;
 }
+
+__cold int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx,
+				     cpumask_var_t mask)
+{
+	struct io_sq_data *sqd = ctx->sq_data;
+	int ret = -EINVAL;
+
+	if (sqd) {
+		io_sq_thread_park(sqd);
+		ret = io_wq_cpu_affinity(sqd->thread->io_uring, mask);
+		io_sq_thread_unpark(sqd);
+	}
+
+	return ret;
+}
diff --git a/io_uring/sqpoll.h b/io_uring/sqpoll.h
index e1b8d508d22d..8df37e8c9149 100644
--- a/io_uring/sqpoll.h
+++ b/io_uring/sqpoll.h
@@ -27,3 +27,4 @@ void io_sq_thread_park(struct io_sq_data *sqd);
 void io_sq_thread_unpark(struct io_sq_data *sqd);
 void io_put_sq_data(struct io_sq_data *sqd);
 void io_sqpoll_wait_sq(struct io_ring_ctx *ctx);
+int io_sqpoll_wq_cpu_affinity(struct io_ring_ctx *ctx, cpumask_var_t mask);

