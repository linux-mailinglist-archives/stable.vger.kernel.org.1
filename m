Return-Path: <stable+bounces-12758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C7A837283
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7667F1F25355
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697C83DBBB;
	Mon, 22 Jan 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BGMEl9nS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1903B790
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951641; cv=none; b=k45/WrhHFJAA3J4Ld+cgltALrpHLP7Ir0zndEa4dtolbbowNAhTA9CANXEyKgaygO3bW2E7ko2fRuleC5TIc4RdEfS4rEX/rdZeG5HkL/kbS552gc30+FOLJ7sBI/vX2GxfuKa0uP8hYEfLSlgPTXHT3dT7hA2bXy+Uu5Vdnbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951641; c=relaxed/simple;
	bh=wOKf2tEWE1qMY2oXnUaudAFrrON4GD8yi/FU5MdGF0g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hru1mdxKa+CiHoMfPrMzbND5N6fd65AK1Fby1UC6gvf99k1AdYXx/OY1RsENZlZ7pfXXG3auOe+SbdJAR67u/xOZNi2GHmS6On0XqQVW5nii69iiwsJNDJssb7h/5bL88aFbjfjv7kwd1ekFw7HlxUa2L0XYkacIjzDBDLtXwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BGMEl9nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA70C43390;
	Mon, 22 Jan 2024 19:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705951639;
	bh=wOKf2tEWE1qMY2oXnUaudAFrrON4GD8yi/FU5MdGF0g=;
	h=Subject:To:Cc:From:Date:From;
	b=BGMEl9nSMcCI9vxRZV+Q3u27v7FzUMbUiFIwXycrcCLbS8Ea0REjNK2brr0EuZwNQ
	 nyOg//wDE74OQvBf9rzmaUGpcDIfD21mbm8o8Q0k3mPD8nDfm9iilgdkuXycN/xa3Z
	 ESjO+3WNhv68JHp50EDZoR3sxjpvFULpNW6l3kr0=
Subject: FAILED: patch "[PATCH] io_uring/rw: ensure io->bytes_done is always initialized" failed to apply to 5.15-stable tree
To: axboe@kernel.dk,xrivendell7@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 11:27:16 -0800
Message-ID: <2024012216-depth-bartender-bc38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0a535eddbe0dc1de4386046ab849f08aeb2f8faf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012216-depth-bartender-bc38@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

0a535eddbe0d ("io_uring/rw: ensure io->bytes_done is always initialized")
f3b44f92e59a ("io_uring: move read/write related opcodes to its own file")
c98817e6cd44 ("io_uring: move remaining file table manipulation to filetable.c")
735729844819 ("io_uring: move rsrc related data, core, and commands")
3b77495a9723 ("io_uring: split provided buffers handling into its own file")
7aaff708a768 ("io_uring: move cancelation into its own file")
329061d3e2f9 ("io_uring: move poll handling into its own file")
cfd22e6b3319 ("io_uring: add opcode name to io_op_defs")
92ac8beaea1f ("io_uring: include and forward-declaration sanitation")
c9f06aa7de15 ("io_uring: move io_uring_task (tctx) helpers into its own file")
a4ad4f748ea9 ("io_uring: move fdinfo helpers to its own file")
e5550a1447bf ("io_uring: use io_is_uring_fops() consistently")
17437f311490 ("io_uring: move SQPOLL related handling into its own file")
59915143e89f ("io_uring: move timeout opcodes and handling into its own file")
e418bbc97bff ("io_uring: move our reference counting into a header")
36404b09aa60 ("io_uring: move msg_ring into its own file")
f9ead18c1058 ("io_uring: split network related opcodes into its own file")
e0da14def1ee ("io_uring: move statx handling to its own file")
a9c210cebe13 ("io_uring: move epoll handler to its own file")
4cf90495281b ("io_uring: add a dummy -EOPNOTSUPP prep handler")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0a535eddbe0dc1de4386046ab849f08aeb2f8faf Mon Sep 17 00:00:00 2001
From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 21 Dec 2023 08:49:18 -0700
Subject: [PATCH] io_uring/rw: ensure io->bytes_done is always initialized

If IOSQE_ASYNC is set and we fail importing an iovec for a readv or
writev request, then we leave ->bytes_done uninitialized and hence the
eventual failure CQE posted can potentially have a random res value
rather than the expected -EINVAL.

Setup ->bytes_done before potentially failing, so we have a consistent
value if we fail the request early.

Cc: stable@vger.kernel.org
Reported-by: xingwei lee <xrivendell7@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 4943d683508b..0c856726b15d 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -589,15 +589,19 @@ static inline int io_rw_prep_async(struct io_kiocb *req, int rw)
 	struct iovec *iov;
 	int ret;
 
+	iorw->bytes_done = 0;
+	iorw->free_iovec = NULL;
+
 	/* submission path, ->uring_lock should already be taken */
 	ret = io_import_iovec(rw, req, &iov, &iorw->s, 0);
 	if (unlikely(ret < 0))
 		return ret;
 
-	iorw->bytes_done = 0;
-	iorw->free_iovec = iov;
-	if (iov)
+	if (iov) {
+		iorw->free_iovec = iov;
 		req->flags |= REQ_F_NEED_CLEANUP;
+	}
+
 	return 0;
 }
 


