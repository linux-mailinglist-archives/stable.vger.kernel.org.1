Return-Path: <stable+bounces-44680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A360C8C53E8
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F38F2868C4
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA012FB3A;
	Tue, 14 May 2024 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gIYpU0iM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07EA5FDD2;
	Tue, 14 May 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686863; cv=none; b=pQD7L8Rq/svU9px3nEu5EvWzAEulGlITyuSe/tr3dLtqyoVcFiYD+TUmeS19orbP8PH5MjESVev9uwGJ4BxwblOBT1jbcvcjXk1lfmWgOO49tn2J5Bkb0/+lZd4w+RgxvuUkvJcH7VD3cQ4rBfoScjV3ZKpeKzDuXhnJjPzDRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686863; c=relaxed/simple;
	bh=++noMytVMH869Iqm042IZ48e36INGcdJ1Xlt3ORabBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPhSVmW4zP2eSMgxrpjkXaJCkpQcJcB7UqYeO/PHmyYeuUWaNrU+V2BzwQg2koiGW+JKakFBpqV2CZsSr7pR8Cy//TQtBWigBf79gQEBmsOatmmsXbAH8bCNJfpp49TM/zqppBmWlOYSTgbXRqpbaRQfHy744gKxi4aaYu7uVHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gIYpU0iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784CEC32781;
	Tue, 14 May 2024 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686862;
	bh=++noMytVMH869Iqm042IZ48e36INGcdJ1Xlt3ORabBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIYpU0iM08o5KSzPkmA0zbbI9H3f3sInAXLD6WaH1YCgRtgG/OoMvuj12/q2dbHEY
	 Khb567H+sie1p5XGGsUqPtYpkiQ/PWCNVqQ4ozp8XNLkX3PDHYIU3xnR636kMqkbTW
	 +fOMF/zzrHZFDZ13yzXmhnaQUUfUwrP238EwRbgs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 46/63] tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
Date: Tue, 14 May 2024 12:20:07 +0200
Message-ID: <20240514100949.753364959@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100948.010148088@linuxfoundation.org>
References: <20240514100948.010148088@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 94062790aedb505bdda209b10bea47b294d6394f ]

TCP_SYN_RECV state is really special, it is only used by
cross-syn connections, mostly used by fuzzers.

In the following crash [1], syzbot managed to trigger a divide
by zero in tcp_rcv_space_adjust()

A socket makes the following state transitions,
without ever calling tcp_init_transfer(),
meaning tcp_init_buffer_space() is also not called.

         TCP_CLOSE
connect()
         TCP_SYN_SENT
         TCP_SYN_RECV
shutdown() -> tcp_shutdown(sk, SEND_SHUTDOWN)
         TCP_FIN_WAIT1

To fix this issue, change tcp_shutdown() to not
perform a TCP_SYN_RECV -> TCP_FIN_WAIT1 transition,
which makes no sense anyway.

When tcp_rcv_state_process() later changes socket state
from TCP_SYN_RECV to TCP_ESTABLISH, then look at
sk->sk_shutdown to finally enter TCP_FIN_WAIT1 state,
and send a FIN packet from a sane socket state.

This means tcp_send_fin() can now be called from BH
context, and must use GFP_ATOMIC allocations.

[1]
divide error: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 PID: 5084 Comm: syz-executor358 Not tainted 6.9.0-rc6-syzkaller-00022-g98369dccd2f8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:tcp_rcv_space_adjust+0x2df/0x890 net/ipv4/tcp_input.c:767
Code: e3 04 4c 01 eb 48 8b 44 24 38 0f b6 04 10 84 c0 49 89 d5 0f 85 a5 03 00 00 41 8b 8e c8 09 00 00 89 e8 29 c8 48 0f af c3 31 d2 <48> f7 f1 48 8d 1c 43 49 8d 96 76 08 00 00 48 89 d0 48 c1 e8 03 48
RSP: 0018:ffffc900031ef3f0 EFLAGS: 00010246
RAX: 0c677a10441f8f42 RBX: 000000004fb95e7e RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000027d4b11f R08: ffffffff89e535a4 R09: 1ffffffff25e6ab7
R10: dffffc0000000000 R11: ffffffff8135e920 R12: ffff88802a9f8d30
R13: dffffc0000000000 R14: ffff88802a9f8d00 R15: 1ffff1100553f2da
FS:  00005555775c0380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1155bf2304 CR3: 000000002b9f2000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
  tcp_recvmsg_locked+0x106d/0x25a0 net/ipv4/tcp.c:2513
  tcp_recvmsg+0x25d/0x920 net/ipv4/tcp.c:2578
  inet6_recvmsg+0x16a/0x730 net/ipv6/af_inet6.c:680
  sock_recvmsg_nosec net/socket.c:1046 [inline]
  sock_recvmsg+0x109/0x280 net/socket.c:1068
  ____sys_recvmsg+0x1db/0x470 net/socket.c:2803
  ___sys_recvmsg net/socket.c:2845 [inline]
  do_recvmmsg+0x474/0xae0 net/socket.c:2939
  __sys_recvmmsg net/socket.c:3018 [inline]
  __do_sys_recvmmsg net/socket.c:3041 [inline]
  __se_sys_recvmmsg net/socket.c:3034 [inline]
  __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3034
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faeb6363db9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc1997168 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faeb6363db9
RDX: 0000000000000001 RSI: 0000000020000bc0 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000001c
R10: 0000000000000122 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Link: https://lore.kernel.org/r/20240501125448.896529-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c        | 4 ++--
 net/ipv4/tcp_input.c  | 2 ++
 net/ipv4/tcp_output.c | 4 +++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 54d6058dcb5cc..e3475f833f8fe 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2319,7 +2319,7 @@ void tcp_shutdown(struct sock *sk, int how)
 	/* If we've already sent a FIN, or it's a closed state, skip this. */
 	if ((1 << sk->sk_state) &
 	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
-	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
+	     TCPF_CLOSE_WAIT)) {
 		/* Clear out any half completed packets.  FIN if needed. */
 		if (tcp_close_state(sk))
 			tcp_send_fin(sk);
@@ -2404,7 +2404,7 @@ void __tcp_close(struct sock *sk, long timeout)
 		 * machine. State transitions:
 		 *
 		 * TCP_ESTABLISHED -> TCP_FIN_WAIT1
-		 * TCP_SYN_RECV	-> TCP_FIN_WAIT1 (forget it, it's impossible)
+		 * TCP_SYN_RECV	-> TCP_FIN_WAIT1 (it is difficult)
 		 * TCP_CLOSE_WAIT -> TCP_LAST_ACK
 		 *
 		 * are legal only when FIN has been sent (i.e. in window),
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 407ad07dc5985..6a8c7c521d36e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6212,6 +6212,8 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 
 		tcp_initialize_rcv_mss(sk);
 		tcp_fast_path_on(tp);
+		if (sk->sk_shutdown & SEND_SHUTDOWN)
+			tcp_shutdown(sk, SEND_SHUTDOWN);
 		break;
 
 	case TCP_FIN_WAIT1: {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8b78cb96a8461..fbeb40a481fcb 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3146,7 +3146,9 @@ void tcp_send_fin(struct sock *sk)
 			return;
 		}
 	} else {
-		skb = alloc_skb_fclone(MAX_TCP_HEADER, sk->sk_allocation);
+		skb = alloc_skb_fclone(MAX_TCP_HEADER,
+				       sk_gfp_mask(sk, GFP_ATOMIC |
+						       __GFP_NOWARN));
 		if (unlikely(!skb))
 			return;
 
-- 
2.43.0




