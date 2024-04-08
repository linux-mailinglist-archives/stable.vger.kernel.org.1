Return-Path: <stable+bounces-36335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32A89BB47
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 11:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DA3B22011
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 09:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E373BB3D;
	Mon,  8 Apr 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Aid9UF9O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F34C3C470
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567490; cv=none; b=otxLa59N/wd0cjmAIRa5rElvYDq4zT/bjSnwbqvUM/9xViEpWka6KJwap9HwEB0GT1iyYIN3YaYL6N6B+uN0WNatYgexOSwfD4tXRCbpEOmiQUJTncRk7zBWOEishwXoG7ogSx12Tkku39yXnUd7sRCmfNLeifGtoY8dC+xyWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567490; c=relaxed/simple;
	bh=bSmWVy2QYZx3BJ5aP2qRkHn4Js8Qrk2ANCMa4XwDOpk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JSHebhvA5XQeKfksXMwoCmf177mIpAlp3Ff0XkiyHedjTXvsd0PO3BmVMtWSiNUTdL+Uoln/tuG+vDjjEY0A4gQUpw8RpnovS7GHr5rtH5oUEO2TBCsk5kfl8iw2EmhBhXnhdTOwlmfO/Vha+25mythq+c+8jQWhC5DldHQijBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Aid9UF9O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAA1C433C7;
	Mon,  8 Apr 2024 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712567490;
	bh=bSmWVy2QYZx3BJ5aP2qRkHn4Js8Qrk2ANCMa4XwDOpk=;
	h=Subject:To:Cc:From:Date:From;
	b=Aid9UF9OdL4dcPwx/0ugH8gmg0bZwfXtY5CMb9+GDZ+CJpGPaRScDtteh0v3twp5r
	 /PRehYO6i/e18+fo0EOkvQdMD7aokzG7sXZoKDX85bVDb+yu4jJf3lNxTjPnKvSl8Q
	 K4UlIaDc1zHWsoQGattPKFFBy8GZgB3mzQumG054=
Subject: FAILED: patch "[PATCH] io_uring: disable io-wq execution of multishot NOWAIT" failed to apply to 6.8-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Apr 2024 11:11:26 +0200
Message-ID: <2024040826-handbrake-five-e04e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x bee1d5becdf5bf23d4ca0cd9c6b60bdf3c61d72b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040826-handbrake-five-e04e@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

bee1d5becdf5 ("io_uring: disable io-wq execution of multishot NOWAIT requests")
e0e4ab52d170 ("io_uring: refactor DEFER_TASKRUN multishot checks")
3a96378e22cc ("io_uring: fix mshot io-wq checks")
eb18c29dd2a3 ("io_uring/net: move recv/recvmsg flags out of retry loop")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bee1d5becdf5bf23d4ca0cd9c6b60bdf3c61d72b Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 1 Apr 2024 11:30:06 -0600
Subject: [PATCH] io_uring: disable io-wq execution of multishot NOWAIT
 requests

Do the same check for direct io-wq execution for multishot requests that
commit 2a975d426c82 did for the inline execution, and disable multishot
mode (and revert to single shot) if the file type doesn't support NOWAIT,
and isn't opened in O_NONBLOCK mode. For multishot to work properly, it's
a requirement that nonblocking read attempts can be done.

Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 5d4b448fdc50..8baf8afb79c2 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1982,10 +1982,15 @@ void io_wq_submit_work(struct io_wq_work *work)
 		err = -EBADFD;
 		if (!io_file_can_poll(req))
 			goto fail;
-		err = -ECANCELED;
-		if (io_arm_poll_handler(req, issue_flags) != IO_APOLL_OK)
-			goto fail;
-		return;
+		if (req->file->f_flags & O_NONBLOCK ||
+		    req->file->f_mode & FMODE_NOWAIT) {
+			err = -ECANCELED;
+			if (io_arm_poll_handler(req, issue_flags) != IO_APOLL_OK)
+				goto fail;
+			return;
+		} else {
+			req->flags &= ~REQ_F_APOLL_MULTISHOT;
+		}
 	}
 
 	if (req->flags & REQ_F_FORCE_ASYNC) {


