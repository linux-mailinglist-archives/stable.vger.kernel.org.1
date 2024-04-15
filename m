Return-Path: <stable+bounces-39625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222818A53C5
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37B8282C84
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021B79945;
	Mon, 15 Apr 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BPnzXXMa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132B78C8A;
	Mon, 15 Apr 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191325; cv=none; b=J2r1WxXE1GwiIB8iZ1ooHulZY6Rl+HkFYs67/52+GRRdcGqvIexOlFbDOv4VH8znlnxCq0bTOBKxus0RPTeO6mqqhoiHU3luqcrk0/RqvYxMJD/zKDoEJ9Pymnuy5qdOSxkrtQwdlkY/hvEd/upzUXwg7lf1N6YZZ+hPmVGCZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191325; c=relaxed/simple;
	bh=TpzbVa7Kc76PoL/fqTn/K3hvYAL98e2ef/jyWbYuw9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPgNpmYOWOSUa+ea7xg7UgPlvVnzeLbar9X35UBDIah65cK/Dp8p9uagAy11iR4THZa8cgq6vVQih+Vze1XxuiFoGADPaRFBYBDCAq3do89iXqARktJSlGWNIB7owtyzeqSu6Z2q6oROgy6CvNNLX1y86BIuRhLPF8wvRJXK7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BPnzXXMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7ECC2BD11;
	Mon, 15 Apr 2024 14:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191324;
	bh=TpzbVa7Kc76PoL/fqTn/K3hvYAL98e2ef/jyWbYuw9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPnzXXMac7b6xfk531Jmi9qzG7kZqC9cZK00s5M8E+DrqnTZ+cSDfg3dntMXW4/I6
	 +jHl7TJHCIxWRE+q6O8FeNbl51/WGObA6OM1aJphCwQezza8NnVYpVBg1FOB2k9zfI
	 0FK3YTjA7/Yllk3/SIevqrheOioiW0QRWx+5WAHM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.8 107/172] io_uring: disable io-wq execution of multishot NOWAIT requests
Date: Mon, 15 Apr 2024 16:20:06 +0200
Message-ID: <20240415142003.641189253@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit bee1d5becdf5bf23d4ca0cd9c6b60bdf3c61d72b upstream.

Do the same check for direct io-wq execution for multishot requests that
commit 2a975d426c82 did for the inline execution, and disable multishot
mode (and revert to single shot) if the file type doesn't support NOWAIT,
and isn't opened in O_NONBLOCK mode. For multishot to work properly, it's
a requirement that nonblocking read attempts can be done.

Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/io_uring.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1964,10 +1964,15 @@ fail:
 		err = -EBADFD;
 		if (!file_can_poll(req->file))
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



