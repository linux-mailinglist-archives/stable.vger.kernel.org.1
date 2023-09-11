Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E171579BF4D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379396AbjIKWnz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjIKOWf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:22:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB570DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:22:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F241C433C7;
        Mon, 11 Sep 2023 14:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442150;
        bh=MzGDNy/nWTNHARTxsGApr5PJydIXRWRpRPSTXnIYfVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=toZ3oetb5Qk9xgT7bXovFAxmdTCFQucHqxlKsjOeK4x02aK+CG9rmvug8Of5TMJpO
         nR1dJKJ9nNsTTtFoeCwP8LRaWw/x4QU70k/PqpKqlF2EG2QLKc7KVx7ecpV/gnSB5M
         kpgINEAHF+Z9P6M8Z6IZZ3kYAF+CKdwJ9SnCnzZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.5 663/739] io_uring: break out of iowq iopoll on teardown
Date:   Mon, 11 Sep 2023 15:47:42 +0200
Message-ID: <20230911134709.625544972@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit 45500dc4e01c167ee063f3dcc22f51ced5b2b1e9 upstream.

io-wq will retry iopoll even when it failed with -EAGAIN. If that
races with task exit, which sets TIF_NOTIFY_SIGNAL for all its workers,
such workers might potentially infinitely spin retrying iopoll again and
again and each time failing on some allocation / waiting / etc. Don't
keep spinning if io-wq is dying.

Fixes: 561fb04a6a225 ("io_uring: replace workqueue usage with io-wq")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io-wq.c    |   10 ++++++++++
 io_uring/io-wq.h    |    1 +
 io_uring/io_uring.c |    2 ++
 3 files changed, 13 insertions(+)

--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -174,6 +174,16 @@ static void io_worker_ref_put(struct io_
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
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -52,6 +52,7 @@ void io_wq_hash_work(struct io_wq_work *
 
 int io_wq_cpu_affinity(struct io_uring_task *tctx, cpumask_var_t mask);
 int io_wq_max_workers(struct io_wq *wq, int *new_count);
+bool io_wq_worker_stopped(void);
 
 static inline bool io_wq_is_hashed(struct io_wq_work *work)
 {
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1966,6 +1966,8 @@ fail:
 		if (!needs_poll) {
 			if (!(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
+			if (io_wq_worker_stopped())
+				break;
 			cond_resched();
 			continue;
 		}


