Return-Path: <stable+bounces-180779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE9B8DAF5
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA0617B36A
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B594252287;
	Sun, 21 Sep 2025 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="124hnaZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C31853
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457961; cv=none; b=HRrvUH6GE6gm6TLo5ZonSpU70nS2/Xy5HPBlkibHrr2L0VM3P9zdLSdLIDMkA6a5aaHD5bnfTZRVWZuqFGcEcwXN6kN6Jds/HISsAsTrdLbTnJi982IVj6T04Bx7eV75yFZ0dirVK0DobuIHK3/8tPLMviY6iYznCvwtJp0JZSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457961; c=relaxed/simple;
	bh=/njeYwb6Qdgew69n/ZTCtBgdCYV6XD1jshvFW2zD/i4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pjN8ziFOTsNxAoQ0eoFLxsr47THGcrz6gCHpwYgGHN2nKwSAffhFr0/X7CX6A/NWaybG7KtrQxvjg3f3AWo9yIaUUzjC5pcaULRX00MBcc59EAJSCS32cPqY7MtUKfmsZ0o+6IVl7P5wn1BPF9QAHKwi4nB8awtjijip9cNfZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=124hnaZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4667BC4CEE7;
	Sun, 21 Sep 2025 12:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457960;
	bh=/njeYwb6Qdgew69n/ZTCtBgdCYV6XD1jshvFW2zD/i4=;
	h=Subject:To:Cc:From:Date:From;
	b=124hnaZIhiQYZrXFNrX6gRtoWPzWLs35hTwXWCoMBJ7GbpfmDfVx2EoP0Rm3OM715
	 g588fBEhasRvq4lYx2knDt5mW8C5lEXHafAgQGalnyXoNRcvYE03Nh9CXMaxXDyGfu
	 foA1CXwAWz74n33JoaGHMH690/n6UiYC8vftniXY=
Subject: FAILED: patch "[PATCH] io_uring: include dying ring in task_work "should cancel"" failed to apply to 6.1-stable tree
To: axboe@kernel.dk,thaler@thaler.hu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:32:28 +0200
Message-ID: <2025092128-embassy-flyable-e3fb@gregkh>
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
git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092128-embassy-flyable-e3fb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3539b1467e94336d5854ebf976d9627bfb65d6c3 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 18 Sep 2025 10:21:14 -0600
Subject: [PATCH] io_uring: include dying ring in task_work "should cancel"
 state

When running task_work for an exiting task, rather than perform the
issue retry attempt, the task_work is canceled. However, this isn't
done for a ring that has been closed. This can lead to requests being
successfully completed post the ring being closed, which is somewhat
confusing and surprising to an application.

Rather than just check the task exit state, also include the ring
ref state in deciding whether or not to terminate a given request when
run from task_work.

Cc: stable@vger.kernel.org # 6.1+
Link: https://github.com/axboe/liburing/discussions/1459
Reported-by: Benedek Thaler <thaler@thaler.hu>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 93633613a165..bcec12256f34 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1406,8 +1406,10 @@ static void io_req_task_cancel(struct io_kiocb *req, io_tw_token_t tw)
 
 void io_req_task_submit(struct io_kiocb *req, io_tw_token_t tw)
 {
-	io_tw_lock(req->ctx, tw);
-	if (unlikely(io_should_terminate_tw()))
+	struct io_ring_ctx *ctx = req->ctx;
+
+	io_tw_lock(ctx, tw);
+	if (unlikely(io_should_terminate_tw(ctx)))
 		io_req_defer_failed(req, -EFAULT);
 	else if (req->flags & REQ_F_FORCE_ASYNC)
 		io_queue_iowq(req);
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index abc6de227f74..1880902be6fd 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -476,9 +476,9 @@ static inline bool io_allowed_run_tw(struct io_ring_ctx *ctx)
  * 2) PF_KTHREAD is set, in which case the invoker of the task_work is
  *    our fallback task_work.
  */
-static inline bool io_should_terminate_tw(void)
+static inline bool io_should_terminate_tw(struct io_ring_ctx *ctx)
 {
-	return current->flags & (PF_KTHREAD | PF_EXITING);
+	return (current->flags & (PF_KTHREAD | PF_EXITING)) || percpu_ref_is_dying(&ctx->refs);
 }
 
 static inline void io_req_queue_tw_complete(struct io_kiocb *req, s32 res)
diff --git a/io_uring/poll.c b/io_uring/poll.c
index c786e587563b..6090a26975d4 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -224,7 +224,7 @@ static int io_poll_check_events(struct io_kiocb *req, io_tw_token_t tw)
 {
 	int v;
 
-	if (unlikely(io_should_terminate_tw()))
+	if (unlikely(io_should_terminate_tw(req->ctx)))
 		return -ECANCELED;
 
 	do {
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 7f13bfa9f2b6..17e3aab0af36 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -324,7 +324,7 @@ static void io_req_task_link_timeout(struct io_kiocb *req, io_tw_token_t tw)
 	int ret;
 
 	if (prev) {
-		if (!io_should_terminate_tw()) {
+		if (!io_should_terminate_tw(req->ctx)) {
 			struct io_cancel_data cd = {
 				.ctx		= req->ctx,
 				.data		= prev->cqe.user_data,
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 053bac89b6c0..213716e10d70 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -118,7 +118,7 @@ static void io_uring_cmd_work(struct io_kiocb *req, io_tw_token_t tw)
 	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
 	unsigned int flags = IO_URING_F_COMPLETE_DEFER;
 
-	if (io_should_terminate_tw())
+	if (io_should_terminate_tw(req->ctx))
 		flags |= IO_URING_F_TASK_DEAD;
 
 	/* task_work executor checks the deffered list completion */


