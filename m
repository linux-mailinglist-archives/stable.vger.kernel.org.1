Return-Path: <stable+bounces-19714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C878531A1
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7D31F2332F
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 13:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668E155780;
	Tue, 13 Feb 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s8uEry9y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F82BB14
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830387; cv=none; b=aapSf7ZUUy0qCG7XC+Wb9sAJ/3pVoEGsV39g/VXFMkqaWe/M81LMqFSPpYGWWxfDrCPMLDG7cEKqm0SnQ65dgLh+2ed1aayzjK0mUbENsPbUyE7Btt+LNGe4y4WFDHDKlkBhK9IRIkmkRsc5g7ntfczg1u3Gymsr+VXBOukBFPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830387; c=relaxed/simple;
	bh=rNjIU0xy0JKV6LyS5kUki5cfdXYeZk6XyF3czpkRWE4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WGP6T9R//py1AJLtJEHDNP+KXBape6YjxV6iFVzYF6uJXfFErmVHo3SKrHH0KXswrtMUGOSWQq/GNKqdGH159MeexMSTxOIIlejRPG7vtgCE3owrVFp+iZYfZlWG4Ybnu03jy64l3T7wF7rCfac0toOsDfppujAOAaAoHExEg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s8uEry9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41BB6C433F1;
	Tue, 13 Feb 2024 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707830386;
	bh=rNjIU0xy0JKV6LyS5kUki5cfdXYeZk6XyF3czpkRWE4=;
	h=Subject:To:Cc:From:Date:From;
	b=s8uEry9yAZcPUMCS7od6trzRBrA5Urw/RtqngMlIE9Rogo9COL3qyiBVe46hI1l/S
	 8+FMltApDejgmT1ZLIKC8qynDDBlDkvkbzMq+JEE8mN9qrYjkZGxUJfoOiOkpN5ocs
	 RMEynMp0VxaTuipoIwmaGceJKwy3jI+p0sJ4bfD8=
Subject: FAILED: patch "[PATCH] io_uring/net: limit inline multishot retries" failed to apply to 6.1-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 13 Feb 2024 14:19:31 +0100
Message-ID: <2024021331-stool-hash-b0c4@gregkh>
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
git cherry-pick -x 76b367a2d83163cf19173d5cb0b562acbabc8eac
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021331-stool-hash-b0c4@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

76b367a2d831 ("io_uring/net: limit inline multishot retries")
91e5d765a82f ("io_uring/net: un-indent mshot retry path in io_recv_finish()")
b6b2bb58a754 ("io_uring: never overflow io_aux_cqe")
b2e74db55dd9 ("io_uring/net: don't overflow multishot recv")
1bfed2334971 ("io_uring/net: don't overflow multishot accept")
b65db9211ecb ("io_uring/net: use proper value for msg_inq")
0aa69d53ac7c ("Merge tag 'for-6.5/io_uring-2023-06-23' of git://git.kernel.dk/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 76b367a2d83163cf19173d5cb0b562acbabc8eac Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 29 Jan 2024 12:00:58 -0700
Subject: [PATCH] io_uring/net: limit inline multishot retries

If we have multiple clients and some/all are flooding the receives to
such an extent that we can retry a LOT handling multishot receives, then
we can be starving some clients and hence serving traffic in an
imbalanced fashion.

Limit multishot retry attempts to some arbitrary value, whose only
purpose serves to ensure that we don't keep serving a single connection
for way too long. We default to 32 retries, which should be more than
enough to provide fairness, yet not so small that we'll spend too much
time requeuing rather than handling traffic.

Cc: stable@vger.kernel.org
Depends-on: 704ea888d646 ("io_uring/poll: add requeue return code from poll multishot handling")
Depends-on: 1e5d765a82f ("io_uring/net: un-indent mshot retry path in io_recv_finish()")
Depends-on: e84b01a880f6 ("io_uring/poll: move poll execution helpers higher up")
Fixes: b3fdea6ecb55 ("io_uring: multishot recv")
Fixes: 9bb66906f23e ("io_uring: support multishot in recvmsg")
Link: https://github.com/axboe/liburing/issues/1043
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index 740c6bfa5b59..a12ff69e6843 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -60,6 +60,7 @@ struct io_sr_msg {
 	unsigned			len;
 	unsigned			done_io;
 	unsigned			msg_flags;
+	unsigned			nr_multishot_loops;
 	u16				flags;
 	/* initialised and used only by !msg send variants */
 	u16				addr_len;
@@ -70,6 +71,13 @@ struct io_sr_msg {
 	struct io_kiocb 		*notif;
 };
 
+/*
+ * Number of times we'll try and do receives if there's more data. If we
+ * exceed this limit, then add us to the back of the queue and retry from
+ * there. This helps fairness between flooding clients.
+ */
+#define MULTISHOT_MAX_RETRY	32
+
 static inline bool io_check_multishot(struct io_kiocb *req,
 				      unsigned int issue_flags)
 {
@@ -611,6 +619,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		sr->msg_flags |= MSG_CMSG_COMPAT;
 #endif
 	sr->done_io = 0;
+	sr->nr_multishot_loops = 0;
 	return 0;
 }
 
@@ -654,12 +663,20 @@ static inline bool io_recv_finish(struct io_kiocb *req, int *ret,
 	 */
 	if (io_fill_cqe_req_aux(req, issue_flags & IO_URING_F_COMPLETE_DEFER,
 				*ret, cflags | IORING_CQE_F_MORE)) {
+		struct io_sr_msg *sr = io_kiocb_to_cmd(req, struct io_sr_msg);
+		int mshot_retry_ret = IOU_ISSUE_SKIP_COMPLETE;
+
 		io_recv_prep_retry(req);
 		/* Known not-empty or unknown state, retry */
-		if (cflags & IORING_CQE_F_SOCK_NONEMPTY || msg->msg_inq == -1)
-			return false;
+		if (cflags & IORING_CQE_F_SOCK_NONEMPTY || msg->msg_inq == -1) {
+			if (sr->nr_multishot_loops++ < MULTISHOT_MAX_RETRY)
+				return false;
+			/* mshot retries exceeded, force a requeue */
+			sr->nr_multishot_loops = 0;
+			mshot_retry_ret = IOU_REQUEUE;
+		}
 		if (issue_flags & IO_URING_F_MULTISHOT)
-			*ret = IOU_ISSUE_SKIP_COMPLETE;
+			*ret = mshot_retry_ret;
 		else
 			*ret = -EAGAIN;
 		return true;


