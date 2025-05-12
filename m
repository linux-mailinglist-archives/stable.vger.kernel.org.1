Return-Path: <stable+bounces-143924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEA9AB42B7
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B57171382
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C9B298CAD;
	Mon, 12 May 2025 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+XpWxZG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD9296FDB;
	Mon, 12 May 2025 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073308; cv=none; b=evGBbSUsndfqFc6sa+BUNzJuzMwl0utUL199RBV02T8h/y+bloPuXzHrp+bb0ARKiuejLBRw/UFwaMWwkE6hggfym+OHFBuP03qHh3Lf55huuv1vKGlz160hXMTVStXRfo5XyHeWxxGLpDv/rxP15odCKjrYM0dgnFiuIXjEL8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073308; c=relaxed/simple;
	bh=Ki0kcMlThHVDxm/EL66gl1HAHlxM6VaElW/qKixlOx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=or17XGhMmanMEAGuV0cEpIZbX7ktx+/X3h3JLNh1HsvyPfF54YP9vHSd6a7GOdXIGC0guykC4wycBb6+UXQEkiR8Asrlq3b1dETYA9nTfkm5eJfmQ2apZCKP375p6RikHOEanftgWc4gAJeHBv8g6U6znvYiIi4u+O5UZSUHe7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+XpWxZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3850C4CEE7;
	Mon, 12 May 2025 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747073308;
	bh=Ki0kcMlThHVDxm/EL66gl1HAHlxM6VaElW/qKixlOx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+XpWxZGf4yhMLRDfMPnVHFHnSCukUCdaHLyAAYnQgkFaZ7aeGpueBUN9NdQFnDr/
	 wjqxzrMSAf69x3YPXxQSE952gnHQusR5F3Do/NQ/LEisc1rHantN8tsB1UqkeBXI6c
	 sCERKN+UxUpCMYUhb1kXpmWboZeJsmnxIHOWPKcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+04b9a82855c8aed20860@syzkaller.appspotmail.com,
	Julian Anastasov <ja@ssi.bg>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 017/113] ipvs: fix uninit-value for saddr in do_output_route4
Date: Mon, 12 May 2025 19:45:06 +0200
Message-ID: <20250512172028.392509748@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172027.691520737@linuxfoundation.org>
References: <20250512172027.691520737@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Anastasov <ja@ssi.bg>

[ Upstream commit e34090d7214e0516eb8722aee295cb2507317c07 ]

syzbot reports for uninit-value for the saddr argument [1].
commit 4754957f04f5 ("ipvs: do not use random local source address for
tunnels") already implies that the input value of saddr
should be ignored but the code is still reading it which can prevent
to connect the route. Fix it by changing the argument to ret_saddr.

[1]
BUG: KMSAN: uninit-value in do_output_route4+0x42c/0x4d0 net/netfilter/ipvs/ip_vs_xmit.c:147
 do_output_route4+0x42c/0x4d0 net/netfilter/ipvs/ip_vs_xmit.c:147
 __ip_vs_get_out_rt+0x403/0x21d0 net/netfilter/ipvs/ip_vs_xmit.c:330
 ip_vs_tunnel_xmit+0x205/0x2380 net/netfilter/ipvs/ip_vs_xmit.c:1136
 ip_vs_in_hook+0x1aa5/0x35b0 net/netfilter/ipvs/ip_vs_core.c:2063
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf7/0x400 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 __ip_local_out+0x758/0x7e0 net/ipv4/ip_output.c:118
 ip_local_out net/ipv4/ip_output.c:127 [inline]
 ip_send_skb+0x6a/0x3c0 net/ipv4/ip_output.c:1501
 udp_send_skb+0xfda/0x1b70 net/ipv4/udp.c:1195
 udp_sendmsg+0x2fe3/0x33c0 net/ipv4/udp.c:1483
 inet_sendmsg+0x1fc/0x280 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x267/0x380 net/socket.c:727
 ____sys_sendmsg+0x91b/0xda0 net/socket.c:2566
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2620
 __sys_sendmmsg+0x41d/0x880 net/socket.c:2702
 __compat_sys_sendmmsg net/compat.c:360 [inline]
 __do_compat_sys_sendmmsg net/compat.c:367 [inline]
 __se_compat_sys_sendmmsg net/compat.c:364 [inline]
 __ia32_compat_sys_sendmmsg+0xc8/0x140 net/compat.c:364
 ia32_sys_call+0x3ffa/0x41f0 arch/x86/include/generated/asm/syscalls_32.h:346
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4167 [inline]
 slab_alloc_node mm/slub.c:4210 [inline]
 __kmalloc_cache_noprof+0x8fa/0xe00 mm/slub.c:4367
 kmalloc_noprof include/linux/slab.h:905 [inline]
 ip_vs_dest_dst_alloc net/netfilter/ipvs/ip_vs_xmit.c:61 [inline]
 __ip_vs_get_out_rt+0x35d/0x21d0 net/netfilter/ipvs/ip_vs_xmit.c:323
 ip_vs_tunnel_xmit+0x205/0x2380 net/netfilter/ipvs/ip_vs_xmit.c:1136
 ip_vs_in_hook+0x1aa5/0x35b0 net/netfilter/ipvs/ip_vs_core.c:2063
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xf7/0x400 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 __ip_local_out+0x758/0x7e0 net/ipv4/ip_output.c:118
 ip_local_out net/ipv4/ip_output.c:127 [inline]
 ip_send_skb+0x6a/0x3c0 net/ipv4/ip_output.c:1501
 udp_send_skb+0xfda/0x1b70 net/ipv4/udp.c:1195
 udp_sendmsg+0x2fe3/0x33c0 net/ipv4/udp.c:1483
 inet_sendmsg+0x1fc/0x280 net/ipv4/af_inet.c:851
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x267/0x380 net/socket.c:727
 ____sys_sendmsg+0x91b/0xda0 net/socket.c:2566
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2620
 __sys_sendmmsg+0x41d/0x880 net/socket.c:2702
 __compat_sys_sendmmsg net/compat.c:360 [inline]
 __do_compat_sys_sendmmsg net/compat.c:367 [inline]
 __se_compat_sys_sendmmsg net/compat.c:364 [inline]
 __ia32_compat_sys_sendmmsg+0xc8/0x140 net/compat.c:364
 ia32_sys_call+0x3ffa/0x41f0 arch/x86/include/generated/asm/syscalls_32.h:346
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb0/0x110 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x38/0x80 arch/x86/entry/syscall_32.c:331
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/syscall_32.c:369
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

CPU: 0 UID: 0 PID: 22408 Comm: syz.4.5165 Not tainted 6.15.0-rc3-syzkaller-00019-gbc3372351d0c #0 PREEMPT(undef)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025

Reported-by: syzbot+04b9a82855c8aed20860@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68138dfa.050a0220.14dd7d.0017.GAE@google.com/
Fixes: 4754957f04f5 ("ipvs: do not use random local source address for tunnels")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
Acked-by: Simon Horman <horms@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipvs/ip_vs_xmit.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 5cd511162bc03..0103c4a4d10a5 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -119,13 +119,12 @@ __mtu_check_toobig_v6(const struct sk_buff *skb, u32 mtu)
 	return false;
 }
 
-/* Get route to daddr, update *saddr, optionally bind route to saddr */
+/* Get route to daddr, optionally bind route to saddr */
 static struct rtable *do_output_route4(struct net *net, __be32 daddr,
-				       int rt_mode, __be32 *saddr)
+				       int rt_mode, __be32 *ret_saddr)
 {
 	struct flowi4 fl4;
 	struct rtable *rt;
-	bool loop = false;
 
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.daddr = daddr;
@@ -135,23 +134,17 @@ static struct rtable *do_output_route4(struct net *net, __be32 daddr,
 retry:
 	rt = ip_route_output_key(net, &fl4);
 	if (IS_ERR(rt)) {
-		/* Invalid saddr ? */
-		if (PTR_ERR(rt) == -EINVAL && *saddr &&
-		    rt_mode & IP_VS_RT_MODE_CONNECT && !loop) {
-			*saddr = 0;
-			flowi4_update_output(&fl4, 0, daddr, 0);
-			goto retry;
-		}
 		IP_VS_DBG_RL("ip_route_output error, dest: %pI4\n", &daddr);
 		return NULL;
-	} else if (!*saddr && rt_mode & IP_VS_RT_MODE_CONNECT && fl4.saddr) {
+	}
+	if (rt_mode & IP_VS_RT_MODE_CONNECT && fl4.saddr) {
 		ip_rt_put(rt);
-		*saddr = fl4.saddr;
 		flowi4_update_output(&fl4, 0, daddr, fl4.saddr);
-		loop = true;
+		rt_mode = 0;
 		goto retry;
 	}
-	*saddr = fl4.saddr;
+	if (ret_saddr)
+		*ret_saddr = fl4.saddr;
 	return rt;
 }
 
@@ -344,19 +337,15 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 		if (ret_saddr)
 			*ret_saddr = dest_dst->dst_saddr.ip;
 	} else {
-		__be32 saddr = htonl(INADDR_ANY);
-
 		noref = 0;
 
 		/* For such unconfigured boxes avoid many route lookups
 		 * for performance reasons because we do not remember saddr
 		 */
 		rt_mode &= ~IP_VS_RT_MODE_CONNECT;
-		rt = do_output_route4(net, daddr, rt_mode, &saddr);
+		rt = do_output_route4(net, daddr, rt_mode, ret_saddr);
 		if (!rt)
 			goto err_unreach;
-		if (ret_saddr)
-			*ret_saddr = saddr;
 	}
 
 	local = (rt->rt_flags & RTCF_LOCAL) ? 1 : 0;
-- 
2.39.5




