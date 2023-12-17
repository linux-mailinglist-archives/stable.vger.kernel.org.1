Return-Path: <stable+bounces-6909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D75816166
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 18:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF0AB212F1
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 17:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B088646B81;
	Sun, 17 Dec 2023 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HMua7+/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1546549
	for <stable@vger.kernel.org>; Sun, 17 Dec 2023 17:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1353C433C7;
	Sun, 17 Dec 2023 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702835191;
	bh=RWbx3GqhH9qSh/GPajP70r0j2yt3otvoLYsvLzxSFhM=;
	h=Subject:To:Cc:From:Date:From;
	b=HMua7+/YiFrAyvXn1bh8GpiiFsluJEWtMEZK0hjM+2oiHPttyBb18aqmo/MrGCt5r
	 Lj3FdWPx+U45lxpZJ8O63HqaEzgVV1Ne4CR7i9KKRiQcqJSVnT7VplAamy1g6w1s3g
	 /VRJFKoBI7YZ+KuQUnCedbuQ2Th18aA4EPwgK/P8=
Subject: FAILED: patch "[PATCH] io_uring/af_unix: disable sending io_uring over sockets" failed to apply to 5.15-stable tree
To: asml.silence@gmail.com,davem@davemloft.net,jannh@google.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Dec 2023 18:46:23 +0100
Message-ID: <2023121723-exemption-flyer-502e@gregkh>
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
git cherry-pick -x 69db702c83874fbaa2a51af761e35a8e5a593b95
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023121723-exemption-flyer-502e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

69db702c8387 ("io_uring/af_unix: disable sending io_uring over sockets")
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

From 69db702c83874fbaa2a51af761e35a8e5a593b95 Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Wed, 6 Dec 2023 13:55:19 +0000
Subject: [PATCH] io_uring/af_unix: disable sending io_uring over sockets

File reference cycles have caused lots of problems for io_uring
in the past, and it still doesn't work exactly right and races with
unix_stream_read_generic(). The safest fix would be to completely
disallow sending io_uring files via sockets via SCM_RIGHT, so there
are no possible cycles invloving registered files and thus rendering
SCM accounting on the io_uring side unnecessary.

Cc: stable@vger.kernel.org
Fixes: 0091bfc81741b ("io_uring/af_unix: defer registered files gc to io_uring release")
Reported-and-suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>

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


