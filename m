Return-Path: <stable+bounces-210331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 942F8D3A767
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFE2530A7BDD
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E4318B87;
	Mon, 19 Jan 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wI4ccc1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28A031690D
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823279; cv=none; b=ZtNm/BLC44+Z/TgX3I39zJ6e9pzeRh6vYWrlXRhW9tbU0yOCVCT37/1lHVtpiASpSAALdDzXuaY7byiUv6VW0wRjnG3qH6gX52P2Kq61NT2VhdqyjVFYmdnKA1aeV1ljtrPi/WPipGmpC/aGkkdPY1If43chLEK9Q8/x8yzrUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823279; c=relaxed/simple;
	bh=eeFi7cXmZ0+wC59zJg27YxZQDKDMA8MQ91g7Gz+IxRo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dw+wlQ+modkYXdvcacOi+uc02osDJDWTKw+oT3tZJ+tPv2Mvw1ZDqaogUTvg+H4qZijqmORUEI9JbHx0e/GeOrijHnIMswe7Y3cbpbxhxsXUecTE77C7JUCnq9n1tMOJKcA8B9r8GQDT9n+rgcjbexxpSOo73OhzGHcOSLJ2xtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wI4ccc1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B7AC116C6;
	Mon, 19 Jan 2026 11:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768823278;
	bh=eeFi7cXmZ0+wC59zJg27YxZQDKDMA8MQ91g7Gz+IxRo=;
	h=Subject:To:Cc:From:Date:From;
	b=wI4ccc1RSlkRXpqVpbzAFg0NEcNGIH3A4woS0qh0O9Fqgj/bpoEJwgfoojFIpWHau
	 EKD5CoyqBZ1Ozog5VZQ+2zjWT/PuW6PMnFqL49ZgH/xYBqYuDojP1toygg3GBVth9K
	 wlMu8j0wSab7RKd/qD79iwZpCzevz2D8uaLqIn3Y=
Subject: FAILED: patch "[PATCH] io_uring: move local task_work in exit cancel loop" failed to apply to 6.12-stable tree
To: ming.lei@redhat.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Jan 2026 12:47:56 +0100
Message-ID: <2026011955-pulmonary-transpire-4456@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x da579f05ef0faada3559e7faddf761c75cdf85e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011955-pulmonary-transpire-4456@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From da579f05ef0faada3559e7faddf761c75cdf85e1 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 14 Jan 2026 16:54:05 +0800
Subject: [PATCH] io_uring: move local task_work in exit cancel loop

With IORING_SETUP_DEFER_TASKRUN, task work is queued to ctx->work_llist
(local work) rather than the fallback list. During io_ring_exit_work(),
io_move_task_work_from_local() was called once before the cancel loop,
moving work from work_llist to fallback_llist.

However, task work can be added to work_llist during the cancel loop
itself. There are two cases:

1) io_kill_timeouts() is called from io_uring_try_cancel_requests() to
cancel pending timeouts, and it adds task work via io_req_queue_tw_complete()
for each cancelled timeout:

2) URING_CMD requests like ublk can be completed via
io_uring_cmd_complete_in_task() from ublk_queue_rq() during canceling,
given ublk request queue is only quiesced when canceling the 1st uring_cmd.

Since io_allowed_defer_tw_run() returns false in io_ring_exit_work()
(kworker != submitter_task), io_run_local_work() is never invoked,
and the work_llist entries are never processed. This causes
io_uring_try_cancel_requests() to loop indefinitely, resulting in
100% CPU usage in kworker threads.

Fix this by moving io_move_task_work_from_local() inside the cancel
loop, ensuring any work on work_llist is moved to fallback before
each cancel attempt.

Cc: stable@vger.kernel.org
Fixes: c0e0d6ba25f1 ("io_uring: add IORING_SETUP_DEFER_TASKRUN")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 87a87396e940..b7a077c11c21 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3003,12 +3003,12 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 			mutex_unlock(&ctx->uring_lock);
 		}
 
-		if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
-			io_move_task_work_from_local(ctx);
-
 		/* The SQPOLL thread never reaches this path */
-		while (io_uring_try_cancel_requests(ctx, NULL, true, false))
+		do {
+			if (ctx->flags & IORING_SETUP_DEFER_TASKRUN)
+				io_move_task_work_from_local(ctx);
 			cond_resched();
+		} while (io_uring_try_cancel_requests(ctx, NULL, true, false));
 
 		if (ctx->sq_data) {
 			struct io_sq_data *sqd = ctx->sq_data;


