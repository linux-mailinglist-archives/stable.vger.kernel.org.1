Return-Path: <stable+bounces-180778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63722B8DAF2
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7803BC5B5
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601CB72608;
	Sun, 21 Sep 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oG0faV9/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1FA1853
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457958; cv=none; b=NriYwQPacFbPQzqVIkAhAXxF6s9OX7IJlyUTg8idJKR+pMSaS5am32YTHnO1hDyFE4gvLzgQOjKJgEJiII8zwKU8kZY3ACsMtYD7w7W25lGlqzBQ6GMXC4CRjJeTzsfDlRBv12EFTf5/ta3+PDGKy5GVD8Qn9DMUMe+cgsaMWww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457958; c=relaxed/simple;
	bh=jzkWHeoEvANAmJGz9sVbpQIpa2U9JB+I17c2A4sMl78=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hQri+s4l46UIdjQHcmhWt6gjh7aHfGTEex+IqZz/fjedniQQwgwIymdjb9d26KYcOkpXssCpE9TaqfXZWJLlqQ9zP+FvkcPq64FTyBMKo/OJ7JOaumtu2i/rYkfFwErzgXQZ96NwiWPFQ4PIOhkJeFQgV6yvruUuIZbJGPp37L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oG0faV9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D1AC4CEE7;
	Sun, 21 Sep 2025 12:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457958;
	bh=jzkWHeoEvANAmJGz9sVbpQIpa2U9JB+I17c2A4sMl78=;
	h=Subject:To:Cc:From:Date:From;
	b=oG0faV9/QJUHzBo0XBbEE14u92Qenv9afE/3AgH6CVZHfDtI+VomaK9NAyB3y6Lqs
	 ynt+ypb1lfW/qWFEIxVI3fUpyQZo1ds7/QmA8xU66+a40GTXJ8Ve4jdMYeUWCKbDlW
	 otjHnKc0u3MneG9GqBrfHLT1fYyLjeZ/paKIJKZM=
Subject: FAILED: patch "[PATCH] io_uring: include dying ring in task_work "should cancel"" failed to apply to 6.6-stable tree
To: axboe@kernel.dk,thaler@thaler.hu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:32:27 +0200
Message-ID: <2025092127-emit-dean-5272@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092127-emit-dean-5272@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


