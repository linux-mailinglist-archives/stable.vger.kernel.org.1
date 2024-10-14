Return-Path: <stable+bounces-83780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F299C95E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE141F23210
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E4119F421;
	Mon, 14 Oct 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yO3YkIQD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CF519E96E
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906625; cv=none; b=CL+A6iqgXie10AHnyzhY4aEskN1M8RqakOxGUznIAEW7RYruQQD3Ji4priHK0J+/8VCaehXlAmPsMJkX9UMkqVqaWUBDqCeqKW64AUTrCWV48ukL+HGidKARedfPD1utsVxSLDgajRX69+wIzdN2AW1gQ8Yp93d15rob2UsL43Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906625; c=relaxed/simple;
	bh=B/CHMM9im4jXWSxUcmXTH4e6CGPHSRroEs+W/z/DXFs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GvnugEeG0jUj2lvjnIdu1T8LZ22I3kfRrdYddK/AkFotAR16QS4y2ZrUc3AdEzey8coR+4yMgZwiwrtltB9FQHEBnLDiQastPmcAR93EM8rV/nub79lFu3VzqonjMWFun599kL3NzxuZo5G39ZUjYC3jwJO9v0th2GDt6voU4ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yO3YkIQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD270C4CEC3;
	Mon, 14 Oct 2024 11:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728906625;
	bh=B/CHMM9im4jXWSxUcmXTH4e6CGPHSRroEs+W/z/DXFs=;
	h=Subject:To:Cc:From:Date:From;
	b=yO3YkIQDDR24vxCbh9kz5QFT57OuR7Q6vL5DtDSpPmDFJlgpXywWBffJVKjgIYKEW
	 YycwtLQrl6157d4M7UdmITwIneR5AYYbb/JMefV/7Da5VT5blqaXzhETtB+yIArS2+
	 FEs1xDUvXNlSUxLhdpTJsXaHi3EN1mq0Bb7a6eXU=
Subject: FAILED: patch "[PATCH] io_uring/rw: fix cflags posting for single issue multishot" failed to apply to 6.11-stable tree
To: axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 13:48:36 +0200
Message-ID: <2024101436-avalanche-approach-5c90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x c9d952b9103b600ddafc5d1c0e2f2dbd30f0b805
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101436-avalanche-approach-5c90@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

c9d952b9103b ("io_uring/rw: fix cflags posting for single issue multishot read")
6733e678ba12 ("io_uring/kbuf: pass in 'len' argument for buffer commit")
ecd5c9b29643 ("io_uring/kbuf: add io_kbuf_commit() helper")
03e02e8f95fe ("io_uring/kbuf: use 'bl' directly rather than req->buf_list")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9d952b9103b600ddafc5d1c0e2f2dbd30f0b805 Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Sat, 5 Oct 2024 19:06:50 -0600
Subject: [PATCH] io_uring/rw: fix cflags posting for single issue multishot
 read

If multishot gets disabled, and hence the request will get terminated
rather than persist for more iterations, then posting the CQE with the
right cflags is still important. Most notably, the buffer reference
needs to be included.

Refactor the return of __io_read() a bit, so that the provided buffer
is always put correctly, and hence returned to the application.

Reported-by: Sharon Rosner <Sharon Rosner>
Link: https://github.com/axboe/liburing/issues/1257
Cc: stable@vger.kernel.org
Fixes: 2a975d426c82 ("io_uring/rw: don't allow multishot reads without NOWAIT support")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rw.c b/io_uring/rw.c
index f023ff49c688..93ad92605884 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -972,17 +972,21 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 		if (issue_flags & IO_URING_F_MULTISHOT)
 			return IOU_ISSUE_SKIP_COMPLETE;
 		return -EAGAIN;
-	}
-
-	/*
-	 * Any successful return value will keep the multishot read armed.
-	 */
-	if (ret > 0 && req->flags & REQ_F_APOLL_MULTISHOT) {
+	} else if (ret <= 0) {
+		io_kbuf_recycle(req, issue_flags);
+		if (ret < 0)
+			req_set_fail(req);
+	} else {
 		/*
-		 * Put our buffer and post a CQE. If we fail to post a CQE, then
+		 * Any successful return value will keep the multishot read
+		 * armed, if it's still set. Put our buffer and post a CQE. If
+		 * we fail to post a CQE, or multishot is no longer set, then
 		 * jump to the termination path. This request is then done.
 		 */
 		cflags = io_put_kbuf(req, ret, issue_flags);
+		if (!(req->flags & REQ_F_APOLL_MULTISHOT))
+			goto done;
+
 		rw->len = 0; /* similarly to above, reset len to 0 */
 
 		if (io_req_post_cqe(req, ret, cflags | IORING_CQE_F_MORE)) {
@@ -1003,6 +1007,7 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 	 * Either an error, or we've hit overflow posting the CQE. For any
 	 * multishot request, hitting overflow will terminate it.
 	 */
+done:
 	io_req_set_res(req, ret, cflags);
 	io_req_rw_cleanup(req, issue_flags);
 	if (issue_flags & IO_URING_F_MULTISHOT)


