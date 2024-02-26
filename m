Return-Path: <stable+bounces-23641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A141867142
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF331F2E17B
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC844F5FE;
	Mon, 26 Feb 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tcli2wAf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D4817
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943120; cv=none; b=tWWrxSMhX5HUKa2MJcTcZX+bxnwjExur2hxC3/yX0boyvZJqM9O5HSnaaDG0XPZynRyPKkE1501q6DmwKzIHeELEizAFHl08GhkbMT/bjqccAjdkGbqbuk6C1cIYiAjTiSCgULeG8+m+dO6RfgCbxLqU+alT3Ehj66RB1QO6O9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943120; c=relaxed/simple;
	bh=umThQ4KaW6sqb2xBS7HQ/oGE/Fh6w+VTDhgDSUwWwiQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Fed6cATiNTm+QrxjWN0ue1ZLWN8f2obGefFyOTeprC7vI5RaHeBwIONdKOAmNg5xN0/Xjr+sYb+gL8yl+rr+TD9km93QSm76QuEIOdjJOEoTcM5WZLd/gAcKXquI1YV3fMW3/XxgZbcz+vheJNucxmcaQaNoZSPsE3p7F1CQhq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tcli2wAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF7AC433F1;
	Mon, 26 Feb 2024 10:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943120;
	bh=umThQ4KaW6sqb2xBS7HQ/oGE/Fh6w+VTDhgDSUwWwiQ=;
	h=Subject:To:Cc:From:Date:From;
	b=tcli2wAftgPRNFvupUtZyuIksgwdY4wZgOxtFXwxQF1/3xt3ytHseRuz9VK5Or1dR
	 FYwl2OAyQY7fNpGz+wL6EPyQrQddWb4uK2jF1DKgJOJKh1nEtPAXuSJk/aHz3qdnzB
	 wGUZ/OEne1tNrjVRDz2twej10huWkxTxfgYA755o=
Subject: FAILED: patch "[PATCH] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via" failed to apply to 4.19-stable tree
To: bvanassche@acm.org,avi@scylladb.com,axboe@kernel.dk,brauner@kernel.org,dhavale@google.com,gregkh@linuxfoundation.org,hch@lst.de,kent.overstreet@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:25:02 +0100
Message-ID: <2024022602-unwrapped-haggler-daae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x b820de741ae48ccf50dd95e297889c286ff4f760
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022602-unwrapped-haggler-daae@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

b820de741ae4 ("fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via libaio")
9cf3516c29e6 ("fs: add IOCB flags related to passing back dio completions")
f6c73a11133e ("fs.h: Add TRACE_IOCB_STRINGS for use in trace points")
1da8cf961bb1 ("Merge tag 'io_uring-6.0-2022-08-13' of git://git.kernel.dk/linux-block")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b820de741ae48ccf50dd95e297889c286ff4f760 Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Thu, 15 Feb 2024 12:47:38 -0800
Subject: [PATCH] fs/aio: Restrict kiocb_set_cancel_fn() to I/O submitted via
 libaio

If kiocb_set_cancel_fn() is called for I/O submitted via io_uring, the
following kernel warning appears:

WARNING: CPU: 3 PID: 368 at fs/aio.c:598 kiocb_set_cancel_fn+0x9c/0xa8
Call trace:
 kiocb_set_cancel_fn+0x9c/0xa8
 ffs_epfile_read_iter+0x144/0x1d0
 io_read+0x19c/0x498
 io_issue_sqe+0x118/0x27c
 io_submit_sqes+0x25c/0x5fc
 __arm64_sys_io_uring_enter+0x104/0xab0
 invoke_syscall+0x58/0x11c
 el0_svc_common+0xb4/0xf4
 do_el0_svc+0x2c/0xb0
 el0_svc+0x2c/0xa4
 el0t_64_sync_handler+0x68/0xb4
 el0t_64_sync+0x1a4/0x1a8

Fix this by setting the IOCB_AIO_RW flag for read and write I/O that is
submitted by libaio.

Suggested-by: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>
Cc: Sandeep Dhavale <dhavale@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240215204739.2677806-2-bvanassche@acm.org
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/aio.c b/fs/aio.c
index bb2ff48991f3..da18dbcfcb22 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -593,6 +593,13 @@ void kiocb_set_cancel_fn(struct kiocb *iocb, kiocb_cancel_fn *cancel)
 	struct kioctx *ctx = req->ki_ctx;
 	unsigned long flags;
 
+	/*
+	 * kiocb didn't come from aio or is neither a read nor a write, hence
+	 * ignore it.
+	 */
+	if (!(iocb->ki_flags & IOCB_AIO_RW))
+		return;
+
 	if (WARN_ON_ONCE(!list_empty(&req->ki_list)))
 		return;
 
@@ -1509,7 +1516,7 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	req->ki_complete = aio_complete_rw;
 	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
-	req->ki_flags = req->ki_filp->f_iocb_flags;
+	req->ki_flags = req->ki_filp->f_iocb_flags | IOCB_AIO_RW;
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)
 		req->ki_flags |= IOCB_EVENTFD;
 	if (iocb->aio_flags & IOCB_FLAG_IOPRIO) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ed5966a70495..c2dcc98cb4c8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -352,6 +352,8 @@ enum rw_hint {
  * unrelated IO (like cache flushing, new IO generation, etc).
  */
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
+/* kiocb is a read or write operation submitted by fs/aio.c. */
+#define IOCB_AIO_RW		(1 << 23)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \


