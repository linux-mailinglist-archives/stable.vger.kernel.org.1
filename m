Return-Path: <stable+bounces-90996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1179BEBFB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35151C2131A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0781F12F1;
	Wed,  6 Nov 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kxVbpYe6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791331DE3B5;
	Wed,  6 Nov 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897432; cv=none; b=VWJu1enczC0xuXc5JT6Nc5XSpC5fk/6z+8zmgQ545CV1wUQkHVe7MJdr08cTtusK/jJoe+jIaLgQJPaVrvworL1GPDlljoZnvNhtFBHXs+OSCkTuh+uxYfrSPZbC95ZIRzx7disU5JVzoshm8iAceuLXoRCm7rbezJkyptjp2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897432; c=relaxed/simple;
	bh=ohtfN00Whm0YWCJcZKOiavRVJH+nVkFAZJXxf15sYoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNKf/Znvr5Tb555tG31LhH7LPnxPCwB2WFnM594ytYMNpUQ7GJWKPc9Kwi3s848pkGJ7dDsRWC/fIslIjx/E5+j77ldmxbCyQ/FmuNsuygih8+FY86AfhhsqJDoAV3Z7GDmI0ZOYj3UI5A2uJzLosJQ7ojOizWAiJwsFuRuDKaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kxVbpYe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000CAC4CECD;
	Wed,  6 Nov 2024 12:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897432;
	bh=ohtfN00Whm0YWCJcZKOiavRVJH+nVkFAZJXxf15sYoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxVbpYe6AcHKdM6OfT05iqW0OWvx3aCYWWN2bvGp/tRr0ABut+Ce4TD6bO5rGbDP1
	 qMSefkH/PUsxuAZnPDsIc+kJGyVHjid4/yTBNHYFcgkN9MS1mcTe8Rzylw7qJl8E3q
	 dNSRCzc842UvRlrpJjExWjHSd7jGLo7wSYx7Da9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 034/151] netfilter: nf_reject_ipv6: fix potential crash in nf_send_reset6()
Date: Wed,  6 Nov 2024 13:03:42 +0100
Message-ID: <20241106120309.774381273@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
References: <20241106120308.841299741@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 4ed234fe793f27a3b151c43d2106df2ff0d81aac ]

I got a syzbot report without a repro [1] crashing in nf_send_reset6()

I think the issue is that dev->hard_header_len is zero, and we attempt
later to push an Ethernet header.

Use LL_MAX_HEADER, as other functions in net/ipv6/netfilter/nf_reject_ipv6.c.

[1]

skbuff: skb_under_panic: text:ffffffff89b1d008 len:74 put:14 head:ffff88803123aa00 data:ffff88803123a9f2 tail:0x3c end:0x140 dev:syz_tun
 kernel BUG at net/core/skbuff.c:206 !
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 7373 Comm: syz.1.568 Not tainted 6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
 RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
 RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0d 8d 48 c7 c6 60 a6 29 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 ba 30 38 02 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900045269b0 EFLAGS: 00010282
RAX: 0000000000000088 RBX: dffffc0000000000 RCX: cd66dacdc5d8e800
RDX: 0000000000000000 RSI: 0000000000000200 RDI: 0000000000000000
RBP: ffff88802d39a3d0 R08: ffffffff8174afec R09: 1ffff920008a4ccc
R10: dffffc0000000000 R11: fffff520008a4ccd R12: 0000000000000140
R13: ffff88803123aa00 R14: ffff88803123a9f2 R15: 000000000000003c
FS:  00007fdbee5ff6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000005d322000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  skb_push+0xe5/0x100 net/core/skbuff.c:2636
  eth_header+0x38/0x1f0 net/ethernet/eth.c:83
  dev_hard_header include/linux/netdevice.h:3208 [inline]
  nf_send_reset6+0xce6/0x1270 net/ipv6/netfilter/nf_reject_ipv6.c:358
  nft_reject_inet_eval+0x3b9/0x690 net/netfilter/nft_reject_inet.c:48
  expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
  nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
  nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
  nf_hook include/linux/netfilter.h:269 [inline]
  NF_HOOK include/linux/netfilter.h:312 [inline]
  br_nf_pre_routing_ipv6+0x63e/0x770 net/bridge/br_netfilter_ipv6.c:184
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_bridge_pre net/bridge/br_input.c:277 [inline]
  br_handle_frame+0x9fd/0x1530 net/bridge/br_input.c:424
  __netif_receive_skb_core+0x13e8/0x4570 net/core/dev.c:5562
  __netif_receive_skb_one_core net/core/dev.c:5666 [inline]
  __netif_receive_skb+0x12f/0x650 net/core/dev.c:5781
  netif_receive_skb_internal net/core/dev.c:5867 [inline]
  netif_receive_skb+0x1e8/0x890 net/core/dev.c:5926
  tun_rx_batched+0x1b7/0x8f0 drivers/net/tun.c:1550
  tun_get_user+0x3056/0x47e0 drivers/net/tun.c:2007
  tun_chr_write_iter+0x10d/0x1f0 drivers/net/tun.c:2053
  new_sync_write fs/read_write.c:590 [inline]
  vfs_write+0xa6d/0xc90 fs/read_write.c:683
  ksys_write+0x183/0x2b0 fs/read_write.c:736
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdbeeb7d1ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 c9 8d 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 1c 8e 02 00 48
RSP: 002b:00007fdbee5ff000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fdbeed36058 RCX: 00007fdbeeb7d1ff
RDX: 000000000000008e RSI: 0000000020000040 RDI: 00000000000000c8
RBP: 00007fdbeebf12be R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000008e R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fdbeed36058 R15: 00007ffc38de06e8
 </TASK>

Fixes: c8d7b98bec43 ("netfilter: move nf_send_resetX() code to nf_reject_ipvX modules")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/netfilter/nf_reject_ipv6.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 4e0976534648c..e4776bd2ed89b 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -268,12 +268,12 @@ static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
-	struct sk_buff *nskb;
-	struct tcphdr _otcph;
-	const struct tcphdr *otcph;
-	unsigned int otcplen, hh_len;
 	const struct ipv6hdr *oip6h = ipv6_hdr(oldskb);
 	struct dst_entry *dst = NULL;
+	const struct tcphdr *otcph;
+	struct sk_buff *nskb;
+	struct tcphdr _otcph;
+	unsigned int otcplen;
 	struct flowi6 fl6;
 
 	if ((!(ipv6_addr_type(&oip6h->saddr) & IPV6_ADDR_UNICAST)) ||
@@ -312,9 +312,8 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	if (IS_ERR(dst))
 		return;
 
-	hh_len = (dst->dev->hard_header_len + 15)&~15;
-	nskb = alloc_skb(hh_len + 15 + dst->header_len + sizeof(struct ipv6hdr)
-			 + sizeof(struct tcphdr) + dst->trailer_len,
+	nskb = alloc_skb(LL_MAX_HEADER + sizeof(struct ipv6hdr) +
+			 sizeof(struct tcphdr) + dst->trailer_len,
 			 GFP_ATOMIC);
 
 	if (!nskb) {
@@ -327,7 +326,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 
 	nskb->mark = fl6.flowi6_mark;
 
-	skb_reserve(nskb, hh_len + dst->header_len);
+	skb_reserve(nskb, LL_MAX_HEADER);
 	nf_reject_ip6hdr_put(nskb, oldskb, IPPROTO_TCP, ip6_dst_hoplimit(dst));
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, otcph, otcplen);
 
-- 
2.43.0




