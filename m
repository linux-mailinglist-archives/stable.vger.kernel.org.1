Return-Path: <stable+bounces-158841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D6AECC9C
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 14:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD101890FD1
	for <lists+stable@lfdr.de>; Sun, 29 Jun 2025 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9CA21323C;
	Sun, 29 Jun 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ooZ45eFN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB8EEA9
	for <stable@vger.kernel.org>; Sun, 29 Jun 2025 12:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751201139; cv=none; b=oWh0AfjAgCbL8anRiCrTwRHFoE4qQCxcbGF7YdZvipJqwfWpy1lR9EQKKGE9yt8zinI6roTM85r4QUX2Up70Edn/zHlHW9AL9XGnZ5r+sMbQKJb9oM2UGvu2XZ5GLQjzuBty7h0ZU42Owwq0K9VW/Ys/6RiTY+OGk4DZUH9Ur10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751201139; c=relaxed/simple;
	bh=VLJiTnFfvzlWkfdX0+RYEUjvztI0vLxCfVuyV+5v37o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E8BjcabC73aCAzKlocGZOdf3U7rmfd36c89y5tKvrJIM+rQtIfr9U1+J7tIkmiz1GAjAZIcdtXl1AZWgnxLvhNH3cYpKStiWf8YI23D6zn1bwt71JwKFjIYFClZFezaXC/MoFzvu4+Ncao/wOKWa/XKf6QjPWjNQML65wxB7qlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ooZ45eFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCCCC4CEEB;
	Sun, 29 Jun 2025 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751201139;
	bh=VLJiTnFfvzlWkfdX0+RYEUjvztI0vLxCfVuyV+5v37o=;
	h=Subject:To:Cc:From:Date:From;
	b=ooZ45eFN+7SZmUiRpTCMLDuCvSpmfZWhR4BIuZiHfUx9dpyYPC/rMWW8GSR/4NPP7
	 zc1qiyTYf2IOSVwBqJRdFsg0ck8R6LVoeSzbTfFUicpMy3jZALNF6c8bVBSNexeOaH
	 khS4LG1VJ/g7tRDyO0+4UX2X2a2p8eruDvKhdLec=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: flag partial buffer mappings" failed to apply to 6.15-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 29 Jun 2025 14:42:20 +0200
Message-ID: <2025062920-conch-hypnotist-d63d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x 178b8ff66ff827c41b4fa105e9aabb99a0b5c537
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062920-conch-hypnotist-d63d@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 178b8ff66ff827c41b4fa105e9aabb99a0b5c537 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 26 Jun 2025 12:17:48 -0600
Subject: [PATCH] io_uring/kbuf: flag partial buffer mappings

A previous commit aborted mapping more for a non-incremental ring for
bundle peeking, but depending on where in the process this peeking
happened, it would not necessarily prevent a retry by the user. That can
create gaps in the received/read data.

Add struct buf_sel_arg->partial_map, which can pass this information
back. The networking side can then map that to internal state and use it
to gate retry as well.

Since this necessitates a new flag, change io_sr_msg->retry to a
retry_flags member, and store both the retry and partial map condition
in there.

Cc: stable@vger.kernel.org
Fixes: 26ec15e4b0c1 ("io_uring/kbuf: don't truncate end buffer for multiple buffer peeks")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index ce95e3af44a9..f2d2cc319faa 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -271,6 +271,7 @@ static int io_ring_buffers_peek(struct io_kiocb *req, struct buf_sel_arg *arg,
 		if (len > arg->max_len) {
 			len = arg->max_len;
 			if (!(bl->flags & IOBL_INC)) {
+				arg->partial_map = 1;
 				if (iov != arg->iovs)
 					break;
 				buf->len = len;
diff --git a/io_uring/kbuf.h b/io_uring/kbuf.h
index 5d83c7adc739..723d0361898e 100644
--- a/io_uring/kbuf.h
+++ b/io_uring/kbuf.h
@@ -58,7 +58,8 @@ struct buf_sel_arg {
 	size_t max_len;
 	unsigned short nr_iovs;
 	unsigned short mode;
-	unsigned buf_group;
+	unsigned short buf_group;
+	unsigned short partial_map;
 };
 
 void __user *io_buffer_select(struct io_kiocb *req, size_t *len,
diff --git a/io_uring/net.c b/io_uring/net.c
index 5c1e8c4ba468..43a43522f406 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -75,12 +75,17 @@ struct io_sr_msg {
 	u16				flags;
 	/* initialised and used only by !msg send variants */
 	u16				buf_group;
-	bool				retry;
+	unsigned short			retry_flags;
 	void __user			*msg_control;
 	/* used only for send zerocopy */
 	struct io_kiocb 		*notif;
 };
 
+enum sr_retry_flags {
+	IO_SR_MSG_RETRY		= 1,
+	IO_SR_MSG_PARTIAL_MAP	= 2,
+};
+
 /*
  * Number of times we'll try and do receives if there's more data. If we
  * exceed this limit, then add us to the back of the queue and retry from
@@ -187,7 +192,7 @@ static inline void io_mshot_prep_retry(struct io_kiocb *req,
 
 	req->flags &= ~REQ_F_BL_EMPTY;
 	sr->done_io = 0;
-	sr->retry = false;
+	sr->retry_flags = 0;
 	sr->len = 0; /* get from the provided buffer */
 }
 
@@ -397,7 +402,7 @@ int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 
 	sr->done_io = 0;
-	sr->retry = false;
+	sr->retry_flags = 0;
 	sr->len = READ_ONCE(sqe->len);
 	sr->flags = READ_ONCE(sqe->ioprio);
 	if (sr->flags & ~SENDMSG_FLAGS)
@@ -751,7 +756,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
 
 	sr->done_io = 0;
-	sr->retry = false;
+	sr->retry_flags = 0;
 
 	if (unlikely(sqe->file_index || sqe->addr2))
 		return -EINVAL;
@@ -823,7 +828,7 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 
 		cflags |= io_put_kbufs(req, this_ret, io_bundle_nbufs(kmsg, this_ret),
 				      issue_flags);
-		if (sr->retry)
+		if (sr->retry_flags & IO_SR_MSG_RETRY)
 			cflags = req->cqe.flags | (cflags & CQE_F_MASK);
 		/* bundle with no more immediate buffers, we're done */
 		if (req->flags & REQ_F_BL_EMPTY)
@@ -832,12 +837,12 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 		 * If more is available AND it was a full transfer, retry and
 		 * append to this one
 		 */
-		if (!sr->retry && kmsg->msg.msg_inq > 1 && this_ret > 0 &&
+		if (!sr->retry_flags && kmsg->msg.msg_inq > 1 && this_ret > 0 &&
 		    !iov_iter_count(&kmsg->msg.msg_iter)) {
 			req->cqe.flags = cflags & ~CQE_F_MASK;
 			sr->len = kmsg->msg.msg_inq;
 			sr->done_io += this_ret;
-			sr->retry = true;
+			sr->retry_flags |= IO_SR_MSG_RETRY;
 			return false;
 		}
 	} else {
@@ -1082,6 +1087,8 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 			kmsg->vec.iovec = arg.iovs;
 			req->flags |= REQ_F_NEED_CLEANUP;
 		}
+		if (arg.partial_map)
+			sr->retry_flags |= IO_SR_MSG_PARTIAL_MAP;
 
 		/* special case 1 vec, can be a fast path */
 		if (ret == 1) {
@@ -1276,7 +1283,7 @@ int io_send_zc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	int ret;
 
 	zc->done_io = 0;
-	zc->retry = false;
+	zc->retry_flags = 0;
 
 	if (unlikely(READ_ONCE(sqe->__pad2[0]) || READ_ONCE(sqe->addr3)))
 		return -EINVAL;


