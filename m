Return-Path: <stable+bounces-116724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A39A39ADD
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 12:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AA3188814E
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3229323C8A9;
	Tue, 18 Feb 2025 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EQPjshOi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366A22B8B6
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878145; cv=none; b=Sk1UnmZDM9qNEGJ1I5ipjuxUiwFVWP3dfLmv1eU19Yjw0EkY16TAxsvKDt8I++Fk7p5nPWdB6fvnfTo/Qw3NjUXGjBUdxVd0//tim7XbFG5+iNLhnMwlR30K+yogsDltbUgbsfL+g0L5fdrtNMCkyNZpOO1mNkTGm/1u2d/+sYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878145; c=relaxed/simple;
	bh=vwbBMe+SdzFz/ofIU1TsUuZR0A+Wa5TL3z85+W7ed2g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rUOlFtSSW/VFUBeyP2q53tpaNqOCFNEng5nqt4W8chKYAGyITfZXrGgpCgOdRiNC54v7QP3MMJ6p9/G+U4OFvEHitafdAQlV8+A/fvupmbhBOzCY/GHNTs1dnKVMgcfgh0/r8zq30s7d/u2ZaRLgb8GIqpZPaffay7YWd5lpItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EQPjshOi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7E5C4CEE2;
	Tue, 18 Feb 2025 11:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739878144;
	bh=vwbBMe+SdzFz/ofIU1TsUuZR0A+Wa5TL3z85+W7ed2g=;
	h=Subject:To:Cc:From:Date:From;
	b=EQPjshOiAeIFbPpgD7WNtxwvzaka0/3mWohJzDwa7wXT5172hULxPreEpeH3jJesj
	 uTYSu7P7A/5DR6HvBaiEc0D9zblG08d5Qd0gNl7/3zlytQJK8uobkt1c1ZF5ZTp3gl
	 gS7STVsvbFmXrP9jxZz/WDEb0cwK5C3LyaWb0090=
Subject: FAILED: patch "[PATCH] io_uring/kbuf: reallocate buf lists on upgrade" failed to apply to 6.12-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,pumpkin@devco.re
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Feb 2025 12:28:55 +0100
Message-ID: <2025021855-fancy-trough-87ae@gregkh>
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
git cherry-pick -x 8802766324e1f5d414a81ac43365c20142e85603
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021855-fancy-trough-87ae@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8802766324e1f5d414a81ac43365c20142e85603 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Wed, 12 Feb 2025 13:46:46 +0000
Subject: [PATCH] io_uring/kbuf: reallocate buf lists on upgrade

IORING_REGISTER_PBUF_RING can reuse an old struct io_buffer_list if it
was created for legacy selected buffer and has been emptied. It violates
the requirement that most of the field should stay stable after publish.
Always reallocate it instead.

Cc: stable@vger.kernel.org
Reported-by: Pumpkin Chang <pumpkin@devco.re>
Fixes: 2fcabce2d7d34 ("io_uring: disallow mixed provided buffer group registrations")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index 04bf493eecae..8e72de7712ac 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -415,6 +415,13 @@ void io_destroy_buffers(struct io_ring_ctx *ctx)
 	}
 }
 
+static void io_destroy_bl(struct io_ring_ctx *ctx, struct io_buffer_list *bl)
+{
+	scoped_guard(mutex, &ctx->mmap_lock)
+		WARN_ON_ONCE(xa_erase(&ctx->io_bl_xa, bl->bgid) != bl);
+	io_put_bl(ctx, bl);
+}
+
 int io_remove_buffers_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_provide_buf *p = io_kiocb_to_cmd(req, struct io_provide_buf);
@@ -636,12 +643,13 @@ int io_register_pbuf_ring(struct io_ring_ctx *ctx, void __user *arg)
 		/* if mapped buffer ring OR classic exists, don't allow */
 		if (bl->flags & IOBL_BUF_RING || !list_empty(&bl->buf_list))
 			return -EEXIST;
-	} else {
-		free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
-		if (!bl)
-			return -ENOMEM;
+		io_destroy_bl(ctx, bl);
 	}
 
+	free_bl = bl = kzalloc(sizeof(*bl), GFP_KERNEL);
+	if (!bl)
+		return -ENOMEM;
+
 	mmap_offset = (unsigned long)reg.bgid << IORING_OFF_PBUF_SHIFT;
 	ring_size = flex_array_size(br, bufs, reg.ring_entries);
 


