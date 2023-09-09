Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB01799823
	for <lists+stable@lfdr.de>; Sat,  9 Sep 2023 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbjIIMyC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 9 Sep 2023 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjIIMyB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 9 Sep 2023 08:54:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E50ACD6
        for <stable@vger.kernel.org>; Sat,  9 Sep 2023 05:53:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CC0C433C8;
        Sat,  9 Sep 2023 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694264037;
        bh=1QjV3cy8aZmFP24c94CVOmt21zvnmeS61mxYcaYUF8w=;
        h=Subject:To:Cc:From:Date:From;
        b=zKAdjg1VcAwcnQ4SmGKU3T42TM75pAwkkzx6QyzPjZvCknYYIJsBNf2VOUV+AvL/M
         RVUysXU2hGH1VOEbq2++M3zhVnDvKRjKIiJAIz2nc/qoiEzzk4CqtPc1Y6gMEixBdT
         D2aq0VAmRDAnNlaW1c5EW3TDdN8N7eO6ggSch/oI=
Subject: FAILED: patch "[PATCH] io_uring: break out of iowq iopoll on teardown" failed to apply to 5.10-stable tree
To:     asml.silence@gmail.com, axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 09 Sep 2023 13:53:46 +0100
Message-ID: <2023090946-waking-jokester-8c89@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 45500dc4e01c167ee063f3dcc22f51ced5b2b1e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023090946-waking-jokester-8c89@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

45500dc4e01c ("io_uring: break out of iowq iopoll on teardown")
ed29b0b4fd83 ("io_uring: move to separate directory")
e0deb6a025ae ("io_uring: avoid io-wq -EAGAIN looping for !IOPOLL")
1d5f5ea7cb7d ("io-wq: remove worker to owner tw dependency")
d01905db14eb ("io_uring: clean iowq submit work cancellation")
255657d23704 ("io_uring: clean io_wq_submit_work()'s main loop")
90fa02883f06 ("io_uring: implement async hybrid mode for pollable requests")
3b44b3712c5b ("io_uring: split logic of force_nonblock")
9882131cd9de ("io_uring: kill io_wq_current_is_worker() in iopoll")
9983028e7660 ("io_uring: optimise req->ctx reloads")
5e49c973fc39 ("io_uring: clean up io_import_iovec")
51aac424aef9 ("io_uring: optimise io_import_iovec nonblock passing")
c88598a92a58 ("io_uring: optimise read/write iov state storing")
538941e2681c ("io_uring: encapsulate rw state")
d886e185a128 ("io_uring: control ->async_data with a REQ_F flag")
30d51dd4ad20 ("io_uring: clean up buffer select")
ef05d9ebcc92 ("io_uring: kill off ->inflight_entry field")
6f33b0bc4ea4 ("io_uring: use slist for completion batching")
c450178d9be9 ("io_uring: dedup CQE flushing non-empty checks")
4c928904ff77 ("block: move CONFIG_BLOCK guard to top Makefile")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45500dc4e01c167ee063f3dcc22f51ced5b2b1e9 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Thu, 7 Sep 2023 13:50:07 +0100
Subject: [PATCH] io_uring: break out of iowq iopoll on teardown

io-wq will retry iopoll even when it failed with -EAGAIN. If that
races with task exit, which sets TIF_NOTIFY_SIGNAL for all its workers,
such workers might potentially infinitely spin retrying iopoll again and
again and each time failing on some allocation / waiting / etc. Don't
keep spinning if io-wq is dying.

Fixes: 561fb04a6a225 ("io_uring: replace workqueue usage with io-wq")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 62f345587df5..1ecc8c748768 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -174,6 +174,16 @@ static void io_worker_ref_put(struct io_wq *wq)
 		complete(&wq->worker_done);
 }
 
+bool io_wq_worker_stopped(void)
+{
+	struct io_worker *worker = current->worker_private;
+
+	if (WARN_ON_ONCE(!io_wq_current_is_worker()))
+		return true;
+
+	return test_bit(IO_WQ_BIT_EXIT, &worker->wq->state);
+}
+
 static void io_worker_cancel_cb(struct io_worker *worker)
 {
 	struct io_wq_acct *acct = io_wq_get_acct(worker);
diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
index 06d9ca90c577..2b2a6406dd8e 100644
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -52,6 +52,7 @@ void io_wq_hash_work(struct io_wq_work *work, void *val);
 
 int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask);
 int io_wq_max_workers(struct io_wq *wq, int *new_count);
+bool io_wq_worker_stopped(void);
 
 static inline bool io_wq_is_hashed(struct io_wq_work *work)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 0f0ba31c3850..58d8dd34a45f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1975,6 +1975,8 @@ void io_wq_submit_work(struct io_wq_work *work)
 		if (!needs_poll) {
 			if (!(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
+			if (io_wq_worker_stopped())
+				break;
 			cond_resched();
 			continue;
 		}

