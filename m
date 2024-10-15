Return-Path: <stable+bounces-85533-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D899E7B9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FB41F22C56
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ACA1E764B;
	Tue, 15 Oct 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQ0QZ+6Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCF1D0492;
	Tue, 15 Oct 2024 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993434; cv=none; b=aT8fBwflV9opx1fn5sUqrDdUOjxCjfOz75Wy0BbdDii6Qw7mYJmnD9oeonmNTTQNHOlWQdDgay6I1TVBd7K4pz73ySz8hGjtKzzUUAfC9jPHbSehpN8aMcogOZthXkEDM1SRQlb6Pcwu9ulL197P3kuNEBImA5+ObvllHIlG6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993434; c=relaxed/simple;
	bh=f7zuK0ToUc44FfnTdtMfovPWTtLWK9dbTO+8+ZVOvS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrKSSCNQ+2TgTZeYysII6hnyxA9513m+lWSebWUFalruZB+p4DoWC9Yse56QwKxkRHIMhuGqgeBrX0n/Jc8X0G+sXRIpN1LUlZpFr7fTN6xln6nvRyJd7SJIHvqjSRxUOyzaEvT2Gw59k5jpCp7JPhtZUdmX1sswe4H4Apoc+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQ0QZ+6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A363EC4CEC6;
	Tue, 15 Oct 2024 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728993434;
	bh=f7zuK0ToUc44FfnTdtMfovPWTtLWK9dbTO+8+ZVOvS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQ0QZ+6Qr4jx5q8rFYiJdrs8SSC+982IThLCNMpqE0oL6hDMsxIbFIwVcb6ZpcLb/
	 t0NvpVvLLIi/UqxfbVt1iYY5jeouQfzyjRkYJOD96nIeDwuItojWFOgorP9F5NcyQT
	 VxRgWa/V4UkOUQpvbnoYqs43cVUv1RQyYPehkufE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 383/691] netfilter: nf_tables: prevent nf_skb_duplicated corruption
Date: Tue, 15 Oct 2024 13:25:31 +0200
Message-ID: <20241015112455.544604300@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 92ceba94de6fb4cee2bf40b485979c342f44a492 ]

syzbot found that nf_dup_ipv4() or nf_dup_ipv6() could write
per-cpu variable nf_skb_duplicated in an unsafe way [1].

Disabling preemption as hinted by the splat is not enough,
we have to disable soft interrupts as well.

[1]
BUG: using __this_cpu_write() in preemptible [00000000] code: syz.4.282/6316
 caller is nf_dup_ipv4+0x651/0x8f0 net/ipv4/netfilter/nf_dup_ipv4.c:87
CPU: 0 UID: 0 PID: 6316 Comm: syz.4.282 Not tainted 6.11.0-rc7-syzkaller-00104-g7052622fccb1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:93 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
  check_preemption_disabled+0x10e/0x120 lib/smp_processor_id.c:49
  nf_dup_ipv4+0x651/0x8f0 net/ipv4/netfilter/nf_dup_ipv4.c:87
  nft_dup_ipv4_eval+0x1db/0x300 net/ipv4/netfilter/nft_dup_ipv4.c:30
  expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
  nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
  nft_do_chain_ipv4+0x202/0x320 net/netfilter/nft_chain_filter.c:23
  nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
  nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
  nf_hook+0x2c4/0x450 include/linux/netfilter.h:269
  NF_HOOK_COND include/linux/netfilter.h:302 [inline]
  ip_output+0x185/0x230 net/ipv4/ip_output.c:433
  ip_local_out net/ipv4/ip_output.c:129 [inline]
  ip_send_skb+0x74/0x100 net/ipv4/ip_output.c:1495
  udp_send_skb+0xacf/0x1650 net/ipv4/udp.c:981
  udp_sendmsg+0x1c21/0x2a60 net/ipv4/udp.c:1269
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x1a6/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2597
  ___sys_sendmsg net/socket.c:2651 [inline]
  __sys_sendmmsg+0x3b2/0x740 net/socket.c:2737
  __do_sys_sendmmsg net/socket.c:2766 [inline]
  __se_sys_sendmmsg net/socket.c:2763 [inline]
  __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2763
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ce4f7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4ce5d4a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f4ce5135f80 RCX: 00007f4ce4f7def9
RDX: 0000000000000001 RSI: 0000000020005d40 RDI: 0000000000000006
RBP: 00007f4ce4ff0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f4ce5135f80 R15: 00007ffd4cbc6d68
 </TASK>

Fixes: d877f07112f1 ("netfilter: nf_tables: add nft_dup expression")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/nf_dup_ipv4.c | 7 +++++--
 net/ipv6/netfilter/nf_dup_ipv6.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 6cc5743c553a0..9a21175693db5 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -52,8 +52,9 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 {
 	struct iphdr *iph;
 
+	local_bh_disable();
 	if (this_cpu_read(nf_skb_duplicated))
-		return;
+		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
 	 * the original skb, which should continue on its way as if nothing has
@@ -61,7 +62,7 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	 */
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
-		return;
+		goto out;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	/* Avoid counting cloned packets towards the original connection. */
@@ -90,6 +91,8 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	} else {
 		kfree_skb(skb);
 	}
+out:
+	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(nf_dup_ipv4);
 
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index a0a2de30be3e7..0c39c77fe8a8a 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -47,11 +47,12 @@ static bool nf_dup_ipv6_route(struct net *net, struct sk_buff *skb,
 void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		 const struct in6_addr *gw, int oif)
 {
+	local_bh_disable();
 	if (this_cpu_read(nf_skb_duplicated))
-		return;
+		goto out;
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
-		return;
+		goto out;
 
 #if IS_ENABLED(CONFIG_NF_CONNTRACK)
 	nf_reset_ct(skb);
@@ -69,6 +70,8 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	} else {
 		kfree_skb(skb);
 	}
+out:
+	local_bh_enable();
 }
 EXPORT_SYMBOL_GPL(nf_dup_ipv6);
 
-- 
2.43.0




