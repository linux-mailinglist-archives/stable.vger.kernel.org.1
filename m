Return-Path: <stable+bounces-119405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437EAA42B07
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873833B8368
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1892266569;
	Mon, 24 Feb 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXnGv36l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84363265604;
	Mon, 24 Feb 2025 18:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421172; cv=none; b=Q0bSqvAFiLkr2mcyyp/fzFypjq61OEFm7zccHEi7YR6382zOXOD0k35TP9m6np+C6HtzB2geb6NB4e+l8zfn/g6zn+15M85DzKagjZqSiQwL2XZ5hQpN2n71C9gYczcDY+KitoDzrQsg27uy/OzNvNXd1gZ90Ye2Fgmrv6koELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421172; c=relaxed/simple;
	bh=Ik5KcxOdBM/F5vV5+lATgGZEb3Liw9RgUd8HTlpzH+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PwzOpq05JCKP4T9jLXjbpqqtJkoG9Tgq25fdEao8zxO6bmTLXEMvZegZSDE/2jsQI09QZBghmYu3nzf5/Ad6v+ESn3jUZHjne+43nxrDTPDiZKMO3trI1h+6sQ/aRDqyoEJ6QtYIu2x3vYoNq8MN11w1qll1k0kR2THgn648g7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXnGv36l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C39C4CEED;
	Mon, 24 Feb 2025 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740421171;
	bh=Ik5KcxOdBM/F5vV5+lATgGZEb3Liw9RgUd8HTlpzH+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oXnGv36lyUdZtvzS5T6CvDOf+ZSRONp17h0ULPV5LZdOMEjsVe4/rN6ebQTR1z5ox
	 WOxyVGq4eUO/IPkKZ9UX94z5A8clIhqP/4Owj0seCIpX79xIoXDdebrWdZCeQgkbC/
	 sKadh77rzUyn2emDwRDD7oh8BiEiRTgEvv/mE+PBnEIsgf+KPytTrqIEjNeWv9W4io
	 XLw+Uscg8gkF1u3DgtK9wdNNmLlEQDo8MfqJCDMdWMy3a8u7/rmxgp2RxfD7ZdFV/2
	 vghu7ZYlW6n6BohcaVdfrNtrGQ7Q242SU5vGxsSmPSseRFYz8LpR4Zee6Cx7dGk8n4
	 /DF6wEwC/JKYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Feb 2025 19:11:50 +0100
Subject: [PATCH net 1/3] mptcp: always handle address removal under msk
 socket lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-net-mptcp-misc-fixes-v1-1-f550f636b435@kernel.org>
References: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
In-Reply-To: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+cd3ce3d03a3393ae9700@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5378; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=N617GDa06HVkbv2TZdEF1e4KCUtp3l7035G9g1HRT6k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvLbEvP9GGFr4OTtuOCxi+i1GNlUL8cQgsQadh
 iim8VvpNKmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7y2xAAKCRD2t4JPQmmg
 cz32D/9AnAVVcnkjSHPoYQvzU9djHZa7masy7+qU0gDbqhb+r7ARABvOz69M5Vs3JZC0oVWQUU7
 8xX//JDuAdNeERJANUBwKKgjGB3z1cCCyHN7piE4odMEyAEiksvNLa1X6Z0MHilFslB60hkmnw3
 MbG2QFjE48t0fX3uvpzHcragMEnfdp6CB4OA7ZFDAvjYrspzKNMqvWpzlsLHNhe43LgQtzlO2kC
 cLih87IMCw3B2PXHteV25wougqaSfBPhNqSGZ6u7Hr+dGHm2SxDxB1fW2xihww9qc2aSn9a/vjH
 TFbYWaQeaBdILl32fY9iQNYpFTNSutRufWmKqLI1/JBaS6/sfmpcRTvNvYgWG6QSBFMJnjkXANd
 1ODa/xBH5Vf8JJbHlXIGCPGElin9ATxG4rkqc5Khu7Z84VE9fBqhsQVCsuyolCz9cIsEn/DMlWB
 OvKkF3ZUBul6nMlbhr3Nu9TylX7tgGDX30tMWhYZ9PzC1F0QfR1PuAn/aRgGVX4sVlWcJKVXGId
 V8QG7rB6rBwQqDJxIQ4pWz4p8WHrPSMY0Fuik+NwDQ3sqm9Xuxu5FTscIzgwyD/d1zgHPulPtTg
 be0Jt8IWzxadghCj9qOhV73BjyUGa258E3K5EWrQsCMRfk/qG6VE3E9o1maiYJ/BWjJu2rmiDfJ
 s+NbCu+ylg9N/+g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Syzkaller reported a lockdep splat in the PM control path:

  WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 sock_owned_by_me include/net/sock.h:1711 [inline]
  WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 msk_owned_by_me net/mptcp/protocol.h:363 [inline]
  WARNING: CPU: 0 PID: 6693 at ./include/net/sock.h:1711 mptcp_pm_nl_addr_send_ack+0x57c/0x610 net/mptcp/pm_netlink.c:788
  Modules linked in:
  CPU: 0 UID: 0 PID: 6693 Comm: syz.0.205 Not tainted 6.14.0-rc2-syzkaller-00303-gad1b832bf1cf #0
  Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
  RIP: 0010:sock_owned_by_me include/net/sock.h:1711 [inline]
  RIP: 0010:msk_owned_by_me net/mptcp/protocol.h:363 [inline]
  RIP: 0010:mptcp_pm_nl_addr_send_ack+0x57c/0x610 net/mptcp/pm_netlink.c:788
  Code: 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 ca 7b d3 f5 eb b9 e8 c3 7b d3 f5 90 0f 0b 90 e9 dd fb ff ff e8 b5 7b d3 f5 90 <0f> 0b 90 e9 3e fb ff ff 44 89 f1 80 e1 07 38 c1 0f 8c eb fb ff ff
  RSP: 0000:ffffc900034f6f60 EFLAGS: 00010283
  RAX: ffffffff8bee3c2b RBX: 0000000000000001 RCX: 0000000000080000
  RDX: ffffc90004d42000 RSI: 000000000000a407 RDI: 000000000000a408
  RBP: ffffc900034f7030 R08: ffffffff8bee37f6 R09: 0100000000000000
  R10: dffffc0000000000 R11: ffffed100bcc62e4 R12: ffff88805e6316e0
  R13: ffff88805e630c00 R14: dffffc0000000000 R15: ffff88805e630c00
  FS:  00007f7e9a7e96c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000001b2fd18ff8 CR3: 0000000032c24000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   mptcp_pm_remove_addr+0x103/0x1d0 net/mptcp/pm.c:59
   mptcp_pm_remove_anno_addr+0x1f4/0x2f0 net/mptcp/pm_netlink.c:1486
   mptcp_nl_remove_subflow_and_signal_addr net/mptcp/pm_netlink.c:1518 [inline]
   mptcp_pm_nl_del_addr_doit+0x118d/0x1af0 net/mptcp/pm_netlink.c:1629
   genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
   genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
   genl_rcv_msg+0xb1f/0xec0 net/netlink/genetlink.c:1210
   netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2543
   genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
   netlink_unicast_kernel net/netlink/af_netlink.c:1322 [inline]
   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1348
   netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1892
   sock_sendmsg_nosec net/socket.c:718 [inline]
   __sock_sendmsg+0x221/0x270 net/socket.c:733
   ____sys_sendmsg+0x53a/0x860 net/socket.c:2573
   ___sys_sendmsg net/socket.c:2627 [inline]
   __sys_sendmsg+0x269/0x350 net/socket.c:2659
   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f7e9998cde9
  Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
  RSP: 002b:00007f7e9a7e9038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
  RAX: ffffffffffffffda RBX: 00007f7e99ba5fa0 RCX: 00007f7e9998cde9
  RDX: 000000002000c094 RSI: 0000400000000000 RDI: 0000000000000007
  RBP: 00007f7e99a0e2a0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
  R13: 0000000000000000 R14: 00007f7e99ba5fa0 R15: 00007fff49231088

Indeed the PM can try to send a RM_ADDR over a msk without acquiring
first the msk socket lock.

The bugged code-path comes from an early optimization: when there
are no subflows, the PM should (usually) not send RM_ADDR
notifications.

The above statement is incorrect, as without locks another process
could concurrent create a new subflow and cause the RM_ADDR generation.

Additionally the supposed optimization is not very effective even
performance-wise, as most mptcp sockets should have at least one
subflow: the MPC one.

Address the issue removing the buggy code path, the existing "slow-path"
will handle correctly even the edge case.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Cc: stable@vger.kernel.org
Reported-by: syzbot+cd3ce3d03a3393ae9700@syzkaller.appspotmail.com
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/546
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 572d160edca33c0a941203d8ae0b0bde0f2ef3e2..c0e47f4f7b1aa2fedf615c44ea595c1f9d2528f9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1514,11 +1514,6 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 		if (mptcp_pm_is_userspace(msk))
 			goto next;
 
-		if (list_empty(&msk->conn_list)) {
-			mptcp_pm_remove_anno_addr(msk, addr, false);
-			goto next;
-		}
-
 		lock_sock(sk);
 		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
 		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&

-- 
2.47.1


