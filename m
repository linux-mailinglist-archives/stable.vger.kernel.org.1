Return-Path: <stable+bounces-22747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942F85DD9C
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179191F233A8
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451827E567;
	Wed, 21 Feb 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tSczVeEB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BD27E105;
	Wed, 21 Feb 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524380; cv=none; b=XZjkSRRYYURuAeIbusqYsgTNZwCMtsuNyTj4wHD8BcGQagSrpXzPEtmotP4SakpRMO/B3IBUYyxPEaWRXNSam8luTXFLWSXcE8rNN5wwEOcjdJMjyQXCjmkcsKUWD209Csljcklx9+KmAaSG4IQiHHFCsHrj+AtUIq7DfnRWFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524380; c=relaxed/simple;
	bh=fLbb8Je6uNYJ3JfVFbcdhA6svwF0aM5ZhwIwbSMjSFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJTQUPCrgTjFD9F950TaYDnu0Mso/mSEbZzKehHPrqqcoTS2WhyIQCuQ/7fkLL+CbSZ44JvM0YEaTMLb6MWaoNKZPiu9uaZXdmKJSALCb/E6szG1Tr57ikLFRoQm2BI67GkHAI0+8dI84qHg1mL6fdJV5B2AYc+Gc5StPIwYo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tSczVeEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23930C433F1;
	Wed, 21 Feb 2024 14:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524379;
	bh=fLbb8Je6uNYJ3JfVFbcdhA6svwF0aM5ZhwIwbSMjSFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tSczVeEBLceoHwYcXTMWx2Hw/e7duyzkn/4NxUTPlFhOwCMBz4KZRqz1vH6Dj4e6i
	 cCyrxgNHi84nBqxD0T5v5H8itwEGbcnl82RaBMx3kHa3fFPyPNWa+1TZzEqU0pH1qB
	 sMFuxOpYNkEmRvkmXb7mUGwBIL1EU+i0WO8tp4J4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzkaller@googlegroups.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 227/379] ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
Date: Wed, 21 Feb 2024 14:06:46 +0100
Message-ID: <20240221130001.613605615@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
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

[ Upstream commit 8d975c15c0cd744000ca386247432d57b21f9df0 ]

syzbot found __ip6_tnl_rcv() could access unitiliazed data [1].

Call pskb_inet_may_pull() to fix this, and initialize ipv6h
variable after this call as it can change skb->head.

[1]
 BUG: KMSAN: uninit-value in __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
 BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
 BUG: KMSAN: uninit-value in IP6_ECN_decapsulate+0x7df/0x1e50 include/net/inet_ecn.h:321
  __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
  INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
  IP6_ECN_decapsulate+0x7df/0x1e50 include/net/inet_ecn.h:321
  ip6ip6_dscp_ecn_decapsulate+0x178/0x1b0 net/ipv6/ip6_tunnel.c:727
  __ip6_tnl_rcv+0xd4e/0x1590 net/ipv6/ip6_tunnel.c:845
  ip6_tnl_rcv+0xce/0x100 net/ipv6/ip6_tunnel.c:888
 gre_rcv+0x143f/0x1870
  ip6_protocol_deliver_rcu+0xda6/0x2a60 net/ipv6/ip6_input.c:438
  ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
  ip6_mc_input+0xa7e/0xc80 net/ipv6/ip6_input.c:586
  dst_input include/net/dst.h:461 [inline]
  ip6_rcv_finish+0x5db/0x870 net/ipv6/ip6_input.c:79
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ipv6_rcv+0xda/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5532 [inline]
  __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5646
  netif_receive_skb_internal net/core/dev.c:5732 [inline]
  netif_receive_skb+0x58/0x660 net/core/dev.c:5791
  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
  tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2084 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0x786/0x1200 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
  slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
  slab_alloc_node mm/slub.c:3478 [inline]
  kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
  __alloc_skb+0x318/0x740 net/core/skbuff.c:651
  alloc_skb include/linux/skbuff.h:1286 [inline]
  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2787
  tun_alloc_skb drivers/net/tun.c:1531 [inline]
  tun_get_user+0x1e8a/0x66d0 drivers/net/tun.c:1846
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2084 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0x786/0x1200 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5034 Comm: syz-executor331 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

Fixes: 0d3c703a9d17 ("ipv6: Cleanup IPv6 tunnel receive path")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240125170557.2663942-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_tunnel.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9b8b209b780a..d1f819238414 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -829,8 +829,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 						struct sk_buff *skb),
 			 bool log_ecn_err)
 {
-	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
-	int err;
+	const struct ipv6hdr *ipv6h;
+	int nh, err;
 
 	if ((!(tpi->flags & TUNNEL_CSUM) &&
 	     (tunnel->parms.i_flags & TUNNEL_CSUM)) ||
@@ -862,14 +862,29 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 			goto drop;
 		}
 
-		ipv6h = ipv6_hdr(skb);
 		skb->protocol = eth_type_trans(skb, tunnel->dev);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 	} else {
 		skb->dev = tunnel->dev;
 	}
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
+
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(tunnel->dev, rx_length_errors);
+		DEV_STATS_INC(tunnel->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	ipv6h = (struct ipv6hdr *)(skb->head + nh);
+
 	memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 
 	__skb_tunnel_rx(skb, tunnel->dev, tunnel->net);
-- 
2.43.0




