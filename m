Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5D77A3CDF
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbjIQUgT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241166AbjIQUf6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:35:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3820E10E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:35:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697B0C433C7;
        Sun, 17 Sep 2023 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982952;
        bh=Gq68qaohMe6KfSkcGzNwGpAaA9eK1ZyG8NQ63rlUU3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPDspKWOHYHZ8j1vxkKLQTHlau4E2o4NOoMWt+qAKLzc8XKG9GT79/Z8gycfIG9fc
         eT8GLNaAG6eEG5vHzUdf3j43y1sG7Q/A1+OyorXvNwm46Ii+MmQPqqOyYiCe2W6bTD
         juGKAcBO4IO/GU+9m202LCihs3naW9apbwur7MRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.15 374/511] io_uring: break out of iowq iopoll on teardown
Date:   Sun, 17 Sep 2023 21:13:21 +0200
Message-ID: <20230917191122.835361506@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

[ upstream commit 45500dc4e01c167ee063f3dcc22f51ced5b2b1e9 ]

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
 io_uring/io_uring.c |    3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -176,6 +176,16 @@ static void io_worker_ref_put(struct io_
 		complete(&wq->worker_done);
 }
 
+bool io_wq_worker_stopped(void)
+{
+	struct io_worker *worker = current->pf_io_worker;
+
+	if (WARN_ON_ONCE(!io_wq_current_is_worker()))
+		return true;
+
+	return test_bit(IO_WQ_BIT_EXIT, &worker->wqe->wq->state);
+}
+
 static void io_worker_cancel_cb(struct io_worker *worker)
 {
 	struct io_wqe_acct *acct = io_wqe_get_acct(worker);
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -129,6 +129,7 @@ void io_wq_hash_work(struct io_wq_work *
 
 int io_wq_cpu_affinity(struct io_wq *wq, cpumask_var_t mask);
 int io_wq_max_workers(struct io_wq *wq, int *new_count);
+bool io_wq_worker_stopped(void);
 
 static inline bool io_wq_is_hashed(struct io_wq_work *work)
 {
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -7069,7 +7069,8 @@ static void io_wq_submit_work(struct io_
 			 */
 			if (ret != -EAGAIN || !(req->ctx->flags & IORING_SETUP_IOPOLL))
 				break;
-
+			if (io_wq_worker_stopped())
+				break;
 			/*
 			 * If REQ_F_NOWAIT is set, then don't wait or retry with
 			 * poll. -EAGAIN is final for that case.


