Return-Path: <stable+bounces-143181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDDAB3454
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F255118884B9
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF425F97A;
	Mon, 12 May 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ISwNTgsi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB525F79E
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044087; cv=none; b=GiXTV/HPF4pVynmQbQ6Cguc/pJluWSfTQDMvcXHEJ/7lEQWwP+0CgRoVcHAlT2lMyDgH2Ia2OwGWNyBed86TKKD4kYL2bamL4DLggzsInF521KgzcYpytBCDeXfZEI3JdmpRXMsBfPamRdIHcjWY6+ZjmZNgEKX3p+2X1dHjAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044087; c=relaxed/simple;
	bh=0FVNhHkBfIBu84S714kG6U1bF4yJhv0C9DxgARn0Kfc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ge87Cs1vHaj/jga9h6V+HyNYOQyhYGdSaJ0VeKbG2moskR3vXEoCPrhHJqyNZvBH8Wco+x08uWWCb/Kks+Ef6xC8v2XI6Iuocb2MOTs/uRUGVIichKZFpkzW+37fj7y7nt/l3do2LXt8QVzOX4WkkN+m96Tyyav7P4TXbDsPImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ISwNTgsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CCAC4CEE7;
	Mon, 12 May 2025 10:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044087;
	bh=0FVNhHkBfIBu84S714kG6U1bF4yJhv0C9DxgARn0Kfc=;
	h=Subject:To:Cc:From:Date:From;
	b=ISwNTgsiigJndAL2Drafm5J9ZTQLMpFFe0Quxjwh1VWkp2d/ERawLKobpAVrCTo3M
	 tgqjXvJf3132bwIgnXIZjgbprJ9ptTNOZeBtn9FX+S32RUIZcjY/ODFQR+W8qKryfT
	 YsrqXJ6RfwtWICEGVRpa9l+jBJ7ib/qXonsr0NXQ=
Subject: FAILED: patch "[PATCH] io_uring: always arm linked timeouts prior to issue" failed to apply to 6.14-stable tree
To: axboe@kernel.dk,chase@path.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:01:24 +0200
Message-ID: <2025051224-effects-slightly-6462@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x b53e523261bf058ea4a518b482222e7a277b186b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051224-effects-slightly-6462@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b53e523261bf058ea4a518b482222e7a277b186b Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 4 May 2025 08:06:28 -0600
Subject: [PATCH] io_uring: always arm linked timeouts prior to issue

There are a few spots where linked timeouts are armed, and not all of
them adhere to the pre-arm, attempt issue, post-arm pattern. This can
be problematic if the linked request returns that it will trigger a
callback later, and does so before the linked timeout is fully armed.

Consolidate all the linked timeout handling into __io_issue_sqe(),
rather than have it spread throughout the various issue entry points.

Cc: stable@vger.kernel.org
Link: https://github.com/axboe/liburing/issues/1390
Reported-by: Chase Hiltz <chase@path.net>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index a2b256e96d5d..769814d71153 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -448,24 +448,6 @@ static struct io_kiocb *__io_prep_linked_timeout(struct io_kiocb *req)
 	return req->link;
 }
 
-static inline struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
-{
-	if (likely(!(req->flags & REQ_F_ARM_LTIMEOUT)))
-		return NULL;
-	return __io_prep_linked_timeout(req);
-}
-
-static noinline void __io_arm_ltimeout(struct io_kiocb *req)
-{
-	io_queue_linked_timeout(__io_prep_linked_timeout(req));
-}
-
-static inline void io_arm_ltimeout(struct io_kiocb *req)
-{
-	if (unlikely(req->flags & REQ_F_ARM_LTIMEOUT))
-		__io_arm_ltimeout(req);
-}
-
 static void io_prep_async_work(struct io_kiocb *req)
 {
 	const struct io_issue_def *def = &io_issue_defs[req->opcode];
@@ -518,7 +500,6 @@ static void io_prep_async_link(struct io_kiocb *req)
 
 static void io_queue_iowq(struct io_kiocb *req)
 {
-	struct io_kiocb *link = io_prep_linked_timeout(req);
 	struct io_uring_task *tctx = req->tctx;
 
 	BUG_ON(!tctx);
@@ -543,8 +524,6 @@ static void io_queue_iowq(struct io_kiocb *req)
 
 	trace_io_uring_queue_async_work(req, io_wq_is_hashed(&req->work));
 	io_wq_enqueue(tctx->io_wq, &req->work);
-	if (link)
-		io_queue_linked_timeout(link);
 }
 
 static void io_req_queue_iowq_tw(struct io_kiocb *req, io_tw_token_t tw)
@@ -1724,15 +1703,22 @@ static bool io_assign_file(struct io_kiocb *req, const struct io_issue_def *def,
 	return !!req->file;
 }
 
+#define REQ_ISSUE_SLOW_FLAGS	(REQ_F_CREDS | REQ_F_ARM_LTIMEOUT)
+
 static inline int __io_issue_sqe(struct io_kiocb *req,
 				 unsigned int issue_flags,
 				 const struct io_issue_def *def)
 {
 	const struct cred *creds = NULL;
+	struct io_kiocb *link = NULL;
 	int ret;
 
-	if (unlikely((req->flags & REQ_F_CREDS) && req->creds != current_cred()))
-		creds = override_creds(req->creds);
+	if (unlikely(req->flags & REQ_ISSUE_SLOW_FLAGS)) {
+		if ((req->flags & REQ_F_CREDS) && req->creds != current_cred())
+			creds = override_creds(req->creds);
+		if (req->flags & REQ_F_ARM_LTIMEOUT)
+			link = __io_prep_linked_timeout(req);
+	}
 
 	if (!def->audit_skip)
 		audit_uring_entry(req->opcode);
@@ -1742,8 +1728,12 @@ static inline int __io_issue_sqe(struct io_kiocb *req,
 	if (!def->audit_skip)
 		audit_uring_exit(!ret, ret);
 
-	if (creds)
-		revert_creds(creds);
+	if (unlikely(creds || link)) {
+		if (creds)
+			revert_creds(creds);
+		if (link)
+			io_queue_linked_timeout(link);
+	}
 
 	return ret;
 }
@@ -1769,7 +1759,6 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (ret == IOU_ISSUE_SKIP_COMPLETE) {
 		ret = 0;
-		io_arm_ltimeout(req);
 
 		/* If the op doesn't have a file, we're not polling for it */
 		if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queue)
@@ -1824,8 +1813,6 @@ void io_wq_submit_work(struct io_wq_work *work)
 	else
 		req_ref_get(req);
 
-	io_arm_ltimeout(req);
-
 	/* either cancelled or io-wq is dying, so don't touch tctx->iowq */
 	if (atomic_read(&work->flags) & IO_WQ_WORK_CANCEL) {
 fail:
@@ -1941,15 +1928,11 @@ struct file *io_file_get_normal(struct io_kiocb *req, int fd)
 static void io_queue_async(struct io_kiocb *req, int ret)
 	__must_hold(&req->ctx->uring_lock)
 {
-	struct io_kiocb *linked_timeout;
-
 	if (ret != -EAGAIN || (req->flags & REQ_F_NOWAIT)) {
 		io_req_defer_failed(req, ret);
 		return;
 	}
 
-	linked_timeout = io_prep_linked_timeout(req);
-
 	switch (io_arm_poll_handler(req, 0)) {
 	case IO_APOLL_READY:
 		io_kbuf_recycle(req, 0);
@@ -1962,9 +1945,6 @@ static void io_queue_async(struct io_kiocb *req, int ret)
 	case IO_APOLL_OK:
 		break;
 	}
-
-	if (linked_timeout)
-		io_queue_linked_timeout(linked_timeout);
 }
 
 static inline void io_queue_sqe(struct io_kiocb *req)


