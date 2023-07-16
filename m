Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4413C754DDA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGPIlc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 04:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPIlc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 04:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51AA10E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 01:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A89B60BD6
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 08:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DF6C433C8;
        Sun, 16 Jul 2023 08:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689496889;
        bh=sEHOX9Jk7QRD2NkwLoAN0cqFudib8HMe15dvJ9pq21g=;
        h=Subject:To:Cc:From:Date:From;
        b=qdK72M8WbtHuOcuc4NXcsUAZkvS3sV/jAwwW6gs4XMDfCerKPxkyzFEmGxmLqR5jk
         70fxmqzw0eSh1tH8xRuhTR1jyXpPeAwVWxGTOlb2uCkicmYdviOqT8vBfa7IcB8/8B
         FrOPStkfGSViaYcmmrC/VkA0zVlLSXSrbwVMAMmU=
Subject: FAILED: patch "[PATCH] io_uring: Use io_schedule* in cqring wait" failed to apply to 5.10-stable tree
To:     andres@anarazel.de, asml.silence@gmail.com, axboe@kernel.dk
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 10:41:23 +0200
Message-ID: <2023071623-deafness-gargle-5297@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
git cherry-pick -x 8a796565cec3601071cbbd27d6304e202019d014
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071623-deafness-gargle-5297@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8a796565cec3 ("io_uring: Use io_schedule* in cqring wait")
d33a39e57768 ("io_uring: keep timeout in io_wait_queue")
46ae7eef44f6 ("io_uring: optimise non-timeout waiting")
846072f16eed ("io_uring: mimimise io_cqring_wait_schedule")
3fcf19d592d5 ("io_uring: parse check_cq out of wq waiting")
12521a5d5cb7 ("io_uring: fix CQ waiting timeout handling")
52ea806ad983 ("io_uring: finish waiting before flushing overflow entries")
35d90f95cfa7 ("io_uring: include task_work run after scheduling in wait for events")
1b346e4aa8e7 ("io_uring: don't check overflow flush failures")
a85381d8326d ("io_uring: skip overflow CQE posting for dying ring")
c0e0d6ba25f1 ("io_uring: add IORING_SETUP_DEFER_TASKRUN")
b4c98d59a787 ("io_uring: introduce io_has_work")
78a861b94959 ("io_uring: add sync cancelation API through io_uring_register()")
c34398a8c018 ("io_uring: remove __io_req_task_work_add")
ed5ccb3beeba ("io_uring: remove priority tw list optimisation")
4a0fef62788b ("io_uring: optimize io_uring_task layout")
253993210bd8 ("io_uring: introduce locking helpers for CQE posting")
305bef988708 ("io_uring: hide eventfd assumptions in eventfd paths")
affa87db9010 ("io_uring: fix multi ctx cancellation")
d9dee4302a7c ("io_uring: remove ->flush_cqes optimisation")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8a796565cec3601071cbbd27d6304e202019d014 Mon Sep 17 00:00:00 2001
From: Andres Freund <andres@anarazel.de>
Date: Fri, 7 Jul 2023 09:20:07 -0700
Subject: [PATCH] io_uring: Use io_schedule* in cqring wait

I observed poor performance of io_uring compared to synchronous IO. That
turns out to be caused by deeper CPU idle states entered with io_uring,
due to io_uring using plain schedule(), whereas synchronous IO uses
io_schedule().

The losses due to this are substantial. On my cascade lake workstation,
t/io_uring from the fio repository e.g. yields regressions between 20%
and 40% with the following command:
./t/io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S$use_sync -R 0 /mnt/t2/fio/write.0.0

This is repeatable with different filesystems, using raw block devices
and using different block devices.

Use io_schedule_prepare() / io_schedule_finish() in
io_cqring_wait_schedule() to address the difference.

After that using io_uring is on par or surpassing synchronous IO (using
registered files etc makes it reliably win, but arguably is a less fair
comparison).

There are other calls to schedule() in io_uring/, but none immediately
jump out to be similarly situated, so I did not touch them. Similarly,
it's possible that mutex_lock_io() should be used, but it's not clear if
there are cases where that matters.

Cc: stable@vger.kernel.org # 5.10+
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andres Freund <andres@anarazel.de>
Link: https://lore.kernel.org/r/20230707162007.194068-1-andres@anarazel.de
[axboe: minor style fixup]
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index e8096d502a7c..7505de2428e0 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2489,6 +2489,8 @@ int io_run_task_work_sig(struct io_ring_ctx *ctx)
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq)
 {
+	int token, ret;
+
 	if (unlikely(READ_ONCE(ctx->check_cq)))
 		return 1;
 	if (unlikely(!llist_empty(&ctx->work_llist)))
@@ -2499,11 +2501,20 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		return -EINTR;
 	if (unlikely(io_should_wake(iowq)))
 		return 0;
+
+	/*
+	 * Use io_schedule_prepare/finish, so cpufreq can take into account
+	 * that the task is waiting for IO - turns out to be important for low
+	 * QD IO.
+	 */
+	token = io_schedule_prepare();
+	ret = 0;
 	if (iowq->timeout == KTIME_MAX)
 		schedule();
 	else if (!schedule_hrtimeout(&iowq->timeout, HRTIMER_MODE_ABS))
-		return -ETIME;
-	return 0;
+		ret = -ETIME;
+	io_schedule_finish(token);
+	return ret;
 }
 
 /*

