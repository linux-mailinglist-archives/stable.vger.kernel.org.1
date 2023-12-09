Return-Path: <stable+bounces-5117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4597E80B41B
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DFA28109B
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6051B1427E;
	Sat,  9 Dec 2023 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uN7RyPc0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE1B748C
	for <stable@vger.kernel.org>; Sat,  9 Dec 2023 12:03:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6EDC433C8;
	Sat,  9 Dec 2023 12:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702123403;
	bh=HTzdhXWVX1SJ1pxs5NJdHHyUafhEfBMw6gSy29jaevo=;
	h=Subject:To:Cc:From:Date:From;
	b=uN7RyPc0xrUcUbB3P2xNM94SHSIIkkiUzyDn1ueqFdxOVRcPzIOQF+2vM/dIeh/fj
	 rbs7DCdIccF2zGEIs/mfJ6Yij+DTIJzqC60QFiz53safUiATViRbThbA6ivKclSWxo
	 Bkl9pIczH/pvpmy0hnJiXyCFh1WidU1gCtTr+0DI=
Subject: FAILED: patch "[PATCH] io_uring/af_unix: disable sending io_uring over sockets" failed to apply to 5.10-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,jannh@google.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 09 Dec 2023 13:03:12 +0100
Message-ID: <2023120912-cabana-cartridge-5e80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 705318a99a138c29a512a72c3e0043b3cd7f55f4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120912-cabana-cartridge-5e80@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

705318a99a13 ("io_uring/af_unix: disable sending io_uring over sockets")
38eddb2c75fb ("io_uring: remove FFS_SCM")
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
99f15d8d6136 ("io_uring: move uring_cmd handling to its own file")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 705318a99a138c29a512a72c3e0043b3cd7f55f4 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Wed, 6 Dec 2023 13:26:47 +0000
Subject: [PATCH] io_uring/af_unix: disable sending io_uring over sockets

File reference cycles have caused lots of problems for io_uring
in the past, and it still doesn't work exactly right and races with
unix_stream_read_generic(). The safest fix would be to completely
disallow sending io_uring files via sockets via SCM_RIGHT, so there
are no possible cycles invloving registered files and thus rendering
SCM accounting on the io_uring side unnecessary.

Cc:  <stable@vger.kernel.org>
Fixes: 0091bfc81741b ("io_uring/af_unix: defer registered files gc to io_uring release")
Reported-and-suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/c716c88321939156909cfa1bd8b0faaf1c804103.1701868795.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 8625181fb87a..08ac0d8e07ef 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -77,17 +77,10 @@ int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 
 int __io_scm_file_account(struct io_ring_ctx *ctx, struct file *file);
 
-#if defined(CONFIG_UNIX)
-static inline bool io_file_need_scm(struct file *filp)
-{
-	return !!unix_get_socket(filp);
-}
-#else
 static inline bool io_file_need_scm(struct file *filp)
 {
 	return false;
 }
-#endif
 
 static inline int io_scm_file_account(struct io_ring_ctx *ctx,
 				      struct file *file)
diff --git a/net/core/scm.c b/net/core/scm.c
index 880027ecf516..7dc47c17d863 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -26,6 +26,7 @@
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/errqueue.h>
+#include <linux/io_uring.h>
 
 #include <linux/uaccess.h>
 
@@ -103,6 +104,11 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 
 		if (fd < 0 || !(file = fget_raw(fd)))
 			return -EBADF;
+		/* don't allow io_uring files */
+		if (io_uring_get_socket(file)) {
+			fput(file);
+			return -EINVAL;
+		}
 		*fpp++ = file;
 		fpl->count++;
 	}


