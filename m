Return-Path: <stable+bounces-73890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A99970757
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935DE1C20D05
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEB9157485;
	Sun,  8 Sep 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0NdsalL/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D04E1366
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725797951; cv=none; b=q0pTOJ8ehLxvocidrkCz3AOhO6hYnGUCoTZ0u6sJRDeC+1HUFHENPOSxTXoDo8Tzcqnm7JBzrw71OWJO5VTslJvS8C15aqEb58dje+SC6U5TzRXoMKeOXMrrDShJ9n0MGDPZ3IGmJJIRw4e7KGso+akWXnLM+xnzUAgDrRKBwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725797951; c=relaxed/simple;
	bh=67TVGOFNP/7QivHVgbxfEZc1v4n+sXxTUObe4uGczAM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UhiIOSAW6MuDMpZpUPHnzNzRuGbisDTemJiO8YIjQR5EJ3j96zuciaX3FhdJKJFKDLBVso11f5vGpWKl36NZpEW1yQLBjEzqujP8tfYy7vrPMyVf/DtKLYBwJft1mI1gn84FL0mgnnCJIoTYluW/oJCYBRHR5AeddNde1nGH9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0NdsalL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3DCC4CEC3;
	Sun,  8 Sep 2024 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725797951;
	bh=67TVGOFNP/7QivHVgbxfEZc1v4n+sXxTUObe4uGczAM=;
	h=Subject:To:Cc:From:Date:From;
	b=0NdsalL/zkwJ7xuS+ANlRr+ZbKcjX6ZRMI4da7H5zOjsMsiUgSmHyMC3kcLiDUDZR
	 43wly04AeMWdzX3IaqAE8V/nIdSh1eZLTMCKGJRPy0C2sVN+TvDGgOdoMjEcZtGQQA
	 FCDfteyLulOPyOgzlX3nEg9Hb+I0aW1AYxc0645g=
Subject: FAILED: patch "[PATCH] tcp_bpf: fix return value of tcp_bpf_sendmsg()" failed to apply to 4.19-stable tree
To: cong.wang@bytedance.com,jakub@cloudflare.com,john.fastabend@gmail.com,kuba@kernel.org,martin.lau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:19:08 +0200
Message-ID: <2024090808-unpiloted-crinkly-e9c7@gregkh>
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
git cherry-pick -x fe1910f9337bd46a9343967b547ccab26b4b2c6e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090808-unpiloted-crinkly-e9c7@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

fe1910f9337b ("tcp_bpf: fix return value of tcp_bpf_sendmsg()")
604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
1243a51f6c05 ("tcp, ulp: remove ulp bits from sockmap")
8b9088f806e1 ("tcp, ulp: enforce sock_owned_by_me upon ulp init and cleanup")
3b4a63f674e9 ("bpf: return EOPNOTSUPP when map lookup isn't supported")
105bc1306e9b ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe1910f9337bd46a9343967b547ccab26b4b2c6e Mon Sep 17 00:00:00 2001
From: Cong Wang <cong.wang@bytedance.com>
Date: Tue, 20 Aug 2024 20:07:44 -0700
Subject: [PATCH] tcp_bpf: fix return value of tcp_bpf_sendmsg()

When we cork messages in psock->cork, the last message triggers the
flushing will result in sending a sk_msg larger than the current
message size. In this case, in tcp_bpf_send_verdict(), 'copied' becomes
negative at least in the following case:

468         case __SK_DROP:
469         default:
470                 sk_msg_free_partial(sk, msg, tosend);
471                 sk_msg_apply_bytes(psock, tosend);
472                 *copied -= (tosend + delta); // <==== HERE
473                 return -EACCES;

Therefore, it could lead to the following BUG with a proper value of
'copied' (thanks to syzbot). We should not use negative 'copied' as a
return value here.

  ------------[ cut here ]------------
  kernel BUG at net/socket.c:733!
  Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
  Modules linked in:
  CPU: 0 UID: 0 PID: 3265 Comm: syz-executor510 Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3 #0
  Hardware name: linux,dummy-virt (DT)
  pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  pc : sock_sendmsg_nosec net/socket.c:733 [inline]
  pc : sock_sendmsg_nosec net/socket.c:728 [inline]
  pc : __sock_sendmsg+0x5c/0x60 net/socket.c:745
  lr : sock_sendmsg_nosec net/socket.c:730 [inline]
  lr : __sock_sendmsg+0x54/0x60 net/socket.c:745
  sp : ffff800088ea3b30
  x29: ffff800088ea3b30 x28: fbf00000062bc900 x27: 0000000000000000
  x26: ffff800088ea3bc0 x25: ffff800088ea3bc0 x24: 0000000000000000
  x23: f9f00000048dc000 x22: 0000000000000000 x21: ffff800088ea3d90
  x20: f9f00000048dc000 x19: ffff800088ea3d90 x18: 0000000000000001
  x17: 0000000000000000 x16: 0000000000000000 x15: 000000002002ffaf
  x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
  x11: 0000000000000000 x10: ffff8000815849c0 x9 : ffff8000815b49c0
  x8 : 0000000000000000 x7 : 000000000000003f x6 : 0000000000000000
  x5 : 00000000000007e0 x4 : fff07ffffd239000 x3 : fbf00000062bc900
  x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffdef
  Call trace:
   sock_sendmsg_nosec net/socket.c:733 [inline]
   __sock_sendmsg+0x5c/0x60 net/socket.c:745
   ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
   ___sys_sendmsg+0xac/0x100 net/socket.c:2651
   __sys_sendmsg+0x84/0xe0 net/socket.c:2680
   __do_sys_sendmsg net/socket.c:2689 [inline]
   __se_sys_sendmsg net/socket.c:2687 [inline]
   __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
   el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
   el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
   el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
   el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
  Code: f9404463 d63f0060 3108441f 54fffe81 (d4210000)
  ---[ end trace 0000000000000000 ]---

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Reported-by: syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20240821030744.320934-1-xiyou.wangcong@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 53b0d62fd2c2..fe6178715ba0 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -577,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		err = sk_stream_error(sk, msg->msg_flags, err);
 	release_sock(sk);
 	sk_psock_put(sk, psock);
-	return copied ? copied : err;
+	return copied > 0 ? copied : err;
 }
 
 enum {


