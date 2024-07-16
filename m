Return-Path: <stable+bounces-59746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D20BB932B8B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B821F210A7
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49019AD59;
	Tue, 16 Jul 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OXD9NEI7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B301DA4D;
	Tue, 16 Jul 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144783; cv=none; b=YQRU8e+yNX2jpcTV5a0ccJSsMul+NhdPuAxflSjexIzsPwK4vB9Tz2j9y5kJgRqv3qi66EV1546tEQYqcseNJwe6zhWkMtqFUNjflo5sUqxmPgRo4cDlPxCPjJcKECXr9BA0q6QGCRb5rwkaDQwBb52qgVVS1bODBUDp1V57nTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144783; c=relaxed/simple;
	bh=hFGe03lJKn54YUm+wGXDaTrOrhNHDn8sZdk6x8cCDks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2ajrT3Qt1+AcbseYj+ZWHFCQ8N7nQDgD+jYnhL1b01h/UJoFvsORD1ajhKqiXx/uVRz97sn7kMErfJJ77p4svuNzNDnJ2v1sV+yK0SZyT6sWehfejZoJtXuchC6xYTsLnX8UBRiI0UMbf/PWIpOHp/txk6L6zwd6nigeJoHt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OXD9NEI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100B1C116B1;
	Tue, 16 Jul 2024 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144783;
	bh=hFGe03lJKn54YUm+wGXDaTrOrhNHDn8sZdk6x8cCDks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXD9NEI7ozdLWXXUNg5TMf3AcGAc+fV+6xXu7r8I1oP2Y06RUtS2LuCwbOeskXDyW
	 KNs8a29jc/V9xMGlZTYq9fz8M/62yPiZpU6nGiWDzTpfY6Br096s4hbuBKIu9d6utV
	 Eaol1GdtCmMVfg2t89FarXgyonNflR934BF+Kmsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Subject: [PATCH 5.10 097/108] ipv6: prevent NULL dereference in ip6_output()
Date: Tue, 16 Jul 2024 17:31:52 +0200
Message-ID: <20240716152749.716198902@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 4db783d68b9b39a411a96096c10828ff5dfada7a upstream.

According to syzbot, there is a chance that ip6_dst_idev()
returns NULL in ip6_output(). Most places in IPv6 stack
deal with a NULL idev just fine, but not here.

syzbot reported:

general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
CPU: 0 PID: 9775 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller-00157-g6a30653b604a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:ip6_output+0x231/0x3f0 net/ipv6/ip6_output.c:237
Code: 3c 1e 00 49 89 df 74 08 4c 89 ef e8 19 58 db f7 48 8b 44 24 20 49 89 45 00 49 89 c5 48 8d 9d e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 4c 8b 74 24 28 0f 85 61 01 00 00 8b 1b 31 ff
RSP: 0018:ffffc9000927f0d8 EFLAGS: 00010202
RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000040000
RDX: ffffc900131f9000 RSI: 0000000000004f47 RDI: 0000000000004f48
RBP: 0000000000000000 R08: ffffffff8a1f0b9a R09: 1ffffffff1f51fad
R10: dffffc0000000000 R11: fffffbfff1f51fae R12: ffff8880293ec8c0
R13: ffff88805d7fc000 R14: 1ffff1100527d91a R15: dffffc0000000000
FS:  00007f135c6856c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000064096000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_xmit+0xefe/0x17f0 net/ipv6/ip6_output.c:358
  sctp_v6_xmit+0x9f2/0x13f0 net/sctp/ipv6.c:248
  sctp_packet_transmit+0x26ad/0x2ca0 net/sctp/output.c:653
  sctp_packet_singleton+0x22c/0x320 net/sctp/outqueue.c:783
  sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
  sctp_outq_flush+0x6d5/0x3e20 net/sctp/outqueue.c:1212
  sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
  sctp_do_sm+0x59cc/0x60c0 net/sctp/sm_sideeffect.c:1169
  sctp_primitive_ASSOCIATE+0x95/0xc0 net/sctp/primitive.c:73
  __sctp_connect+0x9cd/0xe30 net/sctp/socket.c:1234
  sctp_connect net/sctp/socket.c:4819 [inline]
  sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
  __sys_connect_file net/socket.c:2048 [inline]
  __sys_connect+0x2df/0x310 net/socket.c:2065
  __do_sys_connect net/socket.c:2075 [inline]
  __se_sys_connect net/socket.c:2072 [inline]
  __x64_sys_connect+0x7a/0x90 net/socket.c:2072
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 778d80be5269 ("ipv6: Add disable_ipv6 sysctl to disable IPv6 operaion on specific interface.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://lore.kernel.org/r/20240507161842.773961-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Ashwin: Regenerated the Patch for v5.10]
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -240,7 +240,7 @@ int ip6_output(struct net *net, struct s
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
+	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb(skb);
 		return 0;



