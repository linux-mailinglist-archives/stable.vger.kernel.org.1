Return-Path: <stable+bounces-210333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4CD3A755
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C0D6B30022CE
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423CB318B87;
	Mon, 19 Jan 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MPcq4zl1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8F3148C8
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823291; cv=none; b=SJb8Cu1kqPK8rB7ibU0o7WW/V/Jzp4kwL4bHSc9IBK+L0fkWgP2nh+JPqKRcn/itt+CgfOL6EzbaLKTbMeNzWHvXKdOr+bJR19ZgkUibQkIg1ZDVKSGesd/81/ddIEXvosT1MONRGlZAO9FYDXu+N5KwTf34n0wpHpYLLnGteVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823291; c=relaxed/simple;
	bh=oK0XHW1mMDzTLPwvnaLJAs2nrLSEJhoqhf/gNm7ahEs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q7XViuGV0Xl4t/pfYCqhkNeUo/6wz+1hXVrpAnE5e2f7++gdpumgRf5zXfqMP7uUUU06yHLqdAbKfnTSUxmxbb6oZFJa5JD7suHOoSO+X1b9yBaw5MlvT1NLE0XEVCvRm0rSB9nz7C+nxHtd1Rpn1OztJbYjzyTtEzMs0Ki7amU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MPcq4zl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA25C116C6;
	Mon, 19 Jan 2026 11:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768823290;
	bh=oK0XHW1mMDzTLPwvnaLJAs2nrLSEJhoqhf/gNm7ahEs=;
	h=Subject:To:Cc:From:Date:From;
	b=MPcq4zl18ioed084WAqFsjubRpS7ELsnn43JGF+MQ8IdkoKfx9GsYUfpp0680ZIfX
	 EdMQbsaDcB2mfa3EFobvZBbb/CdZ77G0rP3v+AOXeiXyTA79LBmlxaqv9YK6O62Yti
	 QTrzN0SUtlXIFBxBf7xuHAy3lWQ79PVta7REJp+U=
Subject: FAILED: patch "[PATCH] io_uring: move local task_work in exit cancel loop" failed to apply to 6.1-stable tree
To: ming.lei@redhat.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Jan 2026 12:47:57 +0100
Message-ID: <2026011957-earful-capillary-a00a@gregkh>
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
git cherry-pick -x da579f05ef0faada3559e7faddf761c75cdf85e1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011957-earful-capillary-a00a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


