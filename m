Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B777676A884
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 07:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjHAFx7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 01:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHAFx6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 01:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD98DE7D
        for <stable@vger.kernel.org>; Mon, 31 Jul 2023 22:53:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291F86146F
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 05:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC50C433C8;
        Tue,  1 Aug 2023 05:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690869236;
        bh=WYSWY2rQWISC7pbippvLrt0e6pU9gItTYd33Fd7G5qw=;
        h=Subject:To:Cc:From:Date:From;
        b=Gvid/3VtoBbYuN4IYj85OKx2DeztqqRX3nkPtLJoa0VcIkDSl/2WdD/AAPvesbik7
         VImkya+dsR81R7UUGXZhJ+QSnstEqiFg5yolaHYm+yWujoXHSM5KOHtKCLWMbh9ILR
         xqK85XmlpDiPtoiLf2qM+LB/9OBif5vN8IJNWmK0=
Subject: FAILED: patch "[PATCH] io_uring: gate iowait schedule on having pending requests" failed to apply to 6.1-stable tree
To:     axboe@kernel.dk, andres@anarazel.de, oleksandr@natalenko.name,
        phil@raspberrypi.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Tue, 01 Aug 2023 07:53:53 +0200
Message-ID: <2023080153-turkey-reload-8fa7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
git cherry-pick -x 7b72d661f1f2f950ab8c12de7e2bc48bdac8ed69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080153-turkey-reload-8fa7@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

7b72d661f1f2 ("io_uring: gate iowait schedule on having pending requests")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b72d661f1f2f950ab8c12de7e2bc48bdac8ed69 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 24 Jul 2023 11:28:17 -0600
Subject: [PATCH] io_uring: gate iowait schedule on having pending requests

A previous commit made all cqring waits marked as iowait, as a way to
improve performance for short schedules with pending IO. However, for
use cases that have a special reaper thread that does nothing but
wait on events on the ring, this causes a cosmetic issue where we
know have one core marked as being "busy" with 100% iowait.

While this isn't a grave issue, it is confusing to users. Rather than
always mark us as being in iowait, gate setting of current->in_iowait
to 1 by whether or not the waiting task has pending requests.

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/io-uring/CAMEGJJ2RxopfNQ7GNLhr7X9=bHXKo+G5OOe0LUq=+UgLXsv1Xg@mail.gmail.com/
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217699
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217700
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reported-by: Phil Elwell <phil@raspberrypi.com>
Tested-by: Andres Freund <andres@anarazel.de>
Fixes: 8a796565cec3 ("io_uring: Use io_schedule* in cqring wait")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 89a611541bc4..f4591b912ea8 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2493,11 +2493,20 @@ int io_run_task_work_sig(struct io_ring_ctx *ctx)
 	return 0;
 }
 
+static bool current_pending_io(void)
+{
+	struct io_uring_task *tctx = current->io_uring;
+
+	if (!tctx)
+		return false;
+	return percpu_counter_read_positive(&tctx->inflight);
+}
+
 /* when returns >0, the caller should retry */
 static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 					  struct io_wait_queue *iowq)
 {
-	int token, ret;
+	int io_wait, ret;
 
 	if (unlikely(READ_ONCE(ctx->check_cq)))
 		return 1;
@@ -2511,17 +2520,19 @@ static inline int io_cqring_wait_schedule(struct io_ring_ctx *ctx,
 		return 0;
 
 	/*
-	 * Use io_schedule_prepare/finish, so cpufreq can take into account
-	 * that the task is waiting for IO - turns out to be important for low
-	 * QD IO.
+	 * Mark us as being in io_wait if we have pending requests, so cpufreq
+	 * can take into account that the task is waiting for IO - turns out
+	 * to be important for low QD IO.
 	 */
-	token = io_schedule_prepare();
+	io_wait = current->in_iowait;
+	if (current_pending_io())
+		current->in_iowait = 1;
 	ret = 0;
 	if (iowq->timeout == KTIME_MAX)
 		schedule();
 	else if (!schedule_hrtimeout(&iowq->timeout, HRTIMER_MODE_ABS))
 		ret = -ETIME;
-	io_schedule_finish(token);
+	current->in_iowait = io_wait;
 	return ret;
 }
 

