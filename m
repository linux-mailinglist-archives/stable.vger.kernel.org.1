Return-Path: <stable+bounces-81451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840F99350E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9885128498A
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88591DD869;
	Mon,  7 Oct 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Td3dr0nd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE61DD52D
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322236; cv=none; b=LLAmwxL911eqIvFoCOfxqKdKV1ofoOdZEK5avfHgFsmFjd+2V1P8+wJPsek0kxV6Nme5CCEgwEBI3iQsgvFcW7dLGH48FkWeTQsIqhAiTkAV0zZl3VgBGsnT+LXILTjZdMYzG9PYSCD2o6JtTrrOFnOwNT80M0xv76lUwC8ikU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322236; c=relaxed/simple;
	bh=GSJVy6Hsj5WzmyDfMsIYSPhPJRDkaPUWwwrTBwHimes=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lEaLGLKZWcN3KTFv+IW+AoJoiZNOWCzgjWQvRTk918h1dGlJ/gAgrOVhNAhJmRRmGubKwEiYZAHWB8zfGegeOO3iiaRE9J3PANz86hpAtgYjNsceDhdq38Q/NVBCcvmqHBP1AZp061AHrbUaie1YhiEieCVRrWU62H55dnIr+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Td3dr0nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9F4C4CEC6;
	Mon,  7 Oct 2024 17:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728322236;
	bh=GSJVy6Hsj5WzmyDfMsIYSPhPJRDkaPUWwwrTBwHimes=;
	h=Subject:To:Cc:From:Date:From;
	b=Td3dr0nd9pVYbF4eJFmlQffJtb95yBH73mFgxuTvSgV5U7gDbxsBnV/RHzRhVMJ+K
	 pO0HxvDMRt7sIXMKTBqUwH87vxtNKkCkuoBJmZU7x6sptuHZjL7bJiGBVd7aZR627Z
	 9+JidhGnsdLeVlgUPM7jgt5x/Cns+yM/fdGWncgs=
Subject: FAILED: patch "[PATCH] io_uring/net: harden multishot termination case for recv" failed to apply to 6.6-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:30:33 +0200
Message-ID: <2024100732-pessimist-ambiguous-58e3@gregkh>
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
git cherry-pick -x c314094cb4cfa6fc5a17f4881ead2dfebfa717a7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100732-pessimist-ambiguous-58e3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

c314094cb4cf ("io_uring/net: harden multishot termination case for recv")
4a3223f7bfda ("io_uring/net: switch io_recv() to using io_async_msghdr")
fb6328bc2ab5 ("io_uring/net: simplify msghd->msg_inq checking")
186daf238529 ("io_uring/kbuf: rename REQ_F_PARTIAL_IO to REQ_F_BL_NO_RECYCLE")
eb18c29dd2a3 ("io_uring/net: move recv/recvmsg flags out of retry loop")
c3f9109dbc9e ("io_uring/kbuf: flag request if buffer pool is empty after buffer pick")
95041b93e90a ("io_uring: add io_file_can_poll() helper")
521223d7c229 ("io_uring/cancel: don't default to setting req->work.cancel_seq")
4bcb982cce74 ("io_uring: expand main struct io_kiocb flags to 64-bits")
72bd80252fee ("io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buffers")
76b367a2d831 ("io_uring/net: limit inline multishot retries")
91e5d765a82f ("io_uring/net: un-indent mshot retry path in io_recv_finish()")
595e52284d24 ("io_uring/poll: don't enable lazy wake for POLLEXCLUSIVE")
89d528ba2f82 ("io_uring: indicate if io_kbuf_recycle did recycle anything")
4de520f1fcef ("Merge tag 'io_uring-futex-2023-10-30' of git://git.kernel.dk/linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c314094cb4cfa6fc5a17f4881ead2dfebfa717a7 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 26 Sep 2024 07:08:10 -0600
Subject: [PATCH] io_uring/net: harden multishot termination case for recv

If the recv returns zero, or an error, then it doesn't matter if more
data has already been received for this buffer. A condition like that
should terminate the multishot receive. Rather than pass in the
collected return value, pass in whether to terminate or keep the recv
going separately.

Note that this isn't a bug right now, as the only way to get there is
via setting MSG_WAITALL with multishot receive. And if an application
does that, then -EINVAL is returned anyway. But it seems like an easy
bug to introduce, so let's make it a bit more explicit.

Link: https://github.com/axboe/liburing/issues/1246
Cc: stable@vger.kernel.org
Fixes: b3fdea6ecb55 ("io_uring: multishot recv")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/net.c b/io_uring/net.c
index f10f5a22d66a..18507658a921 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1133,6 +1133,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	int ret, min_ret = 0;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
 	size_t len = sr->len;
+	bool mshot_finished;
 
 	if (!(req->flags & REQ_F_POLLED) &&
 	    (sr->flags & IORING_RECVSEND_POLL_FIRST))
@@ -1187,6 +1188,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 		req_set_fail(req);
 	}
 
+	mshot_finished = ret <= 0;
 	if (ret > 0)
 		ret += sr->done_io;
 	else if (sr->done_io)
@@ -1194,7 +1196,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 	else
 		io_kbuf_recycle(req, issue_flags);
 
-	if (!io_recv_finish(req, &ret, kmsg, ret <= 0, issue_flags))
+	if (!io_recv_finish(req, &ret, kmsg, mshot_finished, issue_flags))
 		goto retry_multishot;
 
 	return ret;


