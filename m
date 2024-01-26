Return-Path: <stable+bounces-15948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C783E4FB
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD9FB26A39
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 22:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DF224A02;
	Fri, 26 Jan 2024 22:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ftCmOM4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7B223758
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 22:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307301; cv=none; b=POA2/g8OR3j/wvXXPfhsZt97GwuO48Kvfkyxrj2ZAIFP9uFv0V1j+5mWowWLpkbGoae/Sb04PorNBc/X1bDRA8pJZXtSXY3mpsRWtARhNZrWObTeNB2k8KDRyzQJnSTmVyj7wy0ZIs25Ksiwggea60zNI3cONZ3WvevEcBf5msY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307301; c=relaxed/simple;
	bh=50yrglA+byJ/FCwsAzSvWytEUYOPwTGOz3EVFWE38lA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IvdnIVqyKYYBa3BTB0baOpUyucpEqEX2IowyPzK5rGmCS6b39QlXXJYlCCb/SAz+yFikHzews0+/903cdk7tU8Zi8hOYzAR8mxBuIOqe2UbXr8e4schXxQWAY9dtBEeAU+lK7CpZ/GVP+eLJttnIKSBQnqpuO2JZwP1dwIeBs/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ftCmOM4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 311FFC43394;
	Fri, 26 Jan 2024 22:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706307301;
	bh=50yrglA+byJ/FCwsAzSvWytEUYOPwTGOz3EVFWE38lA=;
	h=Subject:To:Cc:From:Date:From;
	b=ftCmOM4YBVD6RdA4jIqj8MitRk/PY3X7ZhvqlE3HV/aBbKkAFFuR6agEUKn5IgziA
	 YFj+FkgOp5z8i9UeJnsQ0bgDu3WcKWEDlE+/7T9T8dZ5MXFcmNjdmXwPDFTVLtzh3K
	 V6vH16DhgWDhS24rd/Ef0h+G5VQ9sXsxBtjHgbsE=
Subject: FAILED: patch "[PATCH] nbd: always initialize struct msghdr completely" failed to apply to 6.1-stable tree
To: edumazet@google.com,axboe@kernel.dk,horms@kernel.org,josef@toxicpanda.com,syzkaller@googlegroups.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 14:14:55 -0800
Message-ID: <2024012655-dwelled-unlinked-8b2c@gregkh>
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
git cherry-pick -x 78fbb92af27d0982634116c7a31065f24d092826
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012655-dwelled-unlinked-8b2c@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

78fbb92af27d ("nbd: always initialize struct msghdr completely")
98123866fcf3 ("Treewide: Stop corrupting socket's task_frag")
c3d88dfd1583 ("fs: dlm: cleanup listen sock handling")
4f567acb0b86 ("fs: dlm: remove socket shutdown handling")
1037c2a94ab5 ("fs: dlm: use listen sock as dlm running indicator")
08ae0547e75e ("fs: dlm: fix sock release if listen fails")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78fbb92af27d0982634116c7a31065f24d092826 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 12 Jan 2024 13:26:57 +0000
Subject: [PATCH] nbd: always initialize struct msghdr completely

syzbot complains that msg->msg_get_inq value can be uninitialized [1]

struct msghdr got many new fields recently, we should always make
sure their values is zero by default.

[1]
 BUG: KMSAN: uninit-value in tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
  tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
  inet_recvmsg+0x131/0x580 net/ipv4/af_inet.c:879
  sock_recvmsg_nosec net/socket.c:1044 [inline]
  sock_recvmsg+0x12b/0x1e0 net/socket.c:1066
  __sock_xmit+0x236/0x5c0 drivers/block/nbd.c:538
  nbd_read_reply drivers/block/nbd.c:732 [inline]
  recv_work+0x262/0x3100 drivers/block/nbd.c:863
  process_one_work kernel/workqueue.c:2627 [inline]
  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
  worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
  kthread+0x3ed/0x540 kernel/kthread.c:388
  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Local variable msg created at:
  __sock_xmit+0x4c/0x5c0 drivers/block/nbd.c:513
  nbd_read_reply drivers/block/nbd.c:732 [inline]
  recv_work+0x262/0x3100 drivers/block/nbd.c:863

CPU: 1 PID: 7465 Comm: kworker/u5:1 Not tainted 6.7.0-rc7-syzkaller-00041-gf016f7547aee #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: nbd5-recv recv_work

Fixes: f94fd25cb0aa ("tcp: pass back data left in socket after receive")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: nbd@other.debian.org
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240112132657.647112-1-edumazet@google.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4e72ec4e25ac..33a8f37bb6a1 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -508,7 +508,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		       struct iov_iter *iter, int msg_flags, int *sent)
 {
 	int result;
-	struct msghdr msg;
+	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
 
 	if (unlikely(!sock)) {
@@ -524,10 +524,6 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	do {
 		sock->sk->sk_allocation = GFP_NOIO | __GFP_MEMALLOC;
 		sock->sk->sk_use_task_frag = false;
-		msg.msg_name = NULL;
-		msg.msg_namelen = 0;
-		msg.msg_control = NULL;
-		msg.msg_controllen = 0;
 		msg.msg_flags = msg_flags | MSG_NOSIGNAL;
 
 		if (send)


