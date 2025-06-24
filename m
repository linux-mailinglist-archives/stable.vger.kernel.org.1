Return-Path: <stable+bounces-158067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C0AE56CC
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E577B36AF
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CAA22370A;
	Mon, 23 Jun 2025 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RR8gQyLK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F39222581;
	Mon, 23 Jun 2025 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717402; cv=none; b=BFTeCK9ditr4++DHanAFWNdYOM17sqbn6fnC/QVlvJ5iVTZmuCBkaQdDihz45UuWc1mfsllE+pcWDcUFz5uZhhPr0Qh2koMXkOQ3x82hfJjjZphrzUmctK1SQRQFsMQ5Twon/p96dq/qoNyeOH2+2HlUQ3vqDcgGBA/sE/zcG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717402; c=relaxed/simple;
	bh=jUx9cHGlmygyU3DV71dyVh3ILF/OiDNX8Im64OHlhYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSprKX3kqTDVxfRQujcE6ZIupce5N0Ef39Sh6pSP7bi0d8qdSMiuMr0qSC7uGjATx0NpkCZAKTaROB3dt/5ZHEsOa1Wy3stQbXx30hH7Yc1NywyGcTuPDopd95al32WvofTGgefz5B8Gd657iz+ev9E9DUrUA9e9cA38eBlxKws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RR8gQyLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AA9C4CEEA;
	Mon, 23 Jun 2025 22:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717401;
	bh=jUx9cHGlmygyU3DV71dyVh3ILF/OiDNX8Im64OHlhYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RR8gQyLKpBm8GfKQ2lV1h4ckFq+bn/JvTkxyvOQgzQL2Vb6K0BdvzUNp1ry263go2
	 8uWrt0qnUn7/VLTcwmOZkE/lpNm5h2+CPaJAXXT6j/fRICfOTUSidgZKLocBIDobjZ
	 rKEuWKMrCFyAIGm5laf69znq2klg8sO1+DSDn+n8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+8a583bdd1a5cc0b0e068@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 380/414] mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
Date: Mon, 23 Jun 2025 15:08:37 +0200
Message-ID: <20250623130651.451206585@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit 6dbb0d97c5096072c78a6abffe393584e57ae945 ]

As syzbot reported [0], mpls_route_input_rcu() can be called
from mpls_getroute(), where is under RTNL.

net->mpls.platform_label is only updated under RTNL.

Let's use rcu_dereference_rtnl() in mpls_route_input_rcu() to
silence the splat.

[0]:
WARNING: suspicious RCU usage
6.15.0-rc7-syzkaller-00082-g5cdb2c77c4c3 #0 Not tainted
 ----------------------------
net/mpls/af_mpls.c:84 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz.2.4451/17730:
 #0: ffffffff9012a3e8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff9012a3e8 (rtnl_mutex){+.+.}-{4:4}, at: rtnetlink_rcv_msg+0x371/0xe90 net/core/rtnetlink.c:6961

stack backtrace:
CPU: 1 UID: 0 PID: 17730 Comm: syz.2.4451 Not tainted 6.15.0-rc7-syzkaller-00082-g5cdb2c77c4c3 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x166/0x260 kernel/locking/lockdep.c:6865
 mpls_route_input_rcu+0x1d4/0x200 net/mpls/af_mpls.c:84
 mpls_getroute+0x621/0x1ea0 net/mpls/af_mpls.c:2381
 rtnetlink_rcv_msg+0x3c9/0xe90 net/core/rtnetlink.c:6964
 netlink_rcv_skb+0x16d/0x440 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmmsg+0x200/0x420 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0x9c/0x100 net/socket.c:2733
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0a2818e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0a28f52038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f0a283b5fa0 RCX: 00007f0a2818e969
RDX: 0000000000000003 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007f0a28210ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f0a283b5fa0 R15: 00007ffce5e9f268
 </TASK>

Fixes: 0189197f4416 ("mpls: Basic routing support")
Reported-by: syzbot+8a583bdd1a5cc0b0e068@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68507981.a70a0220.395abc.01ef.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20250616201532.1036568-1-kuni1840@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mpls/af_mpls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index df62638b64984..3373b6b34dc7d 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -81,8 +81,8 @@ static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned index)
 
 	if (index < net->mpls.platform_labels) {
 		struct mpls_route __rcu **platform_label =
-			rcu_dereference(net->mpls.platform_label);
-		rt = rcu_dereference(platform_label[index]);
+			rcu_dereference_rtnl(net->mpls.platform_label);
+		rt = rcu_dereference_rtnl(platform_label[index]);
 	}
 	return rt;
 }
-- 
2.39.5




