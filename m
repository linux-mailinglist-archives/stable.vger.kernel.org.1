Return-Path: <stable+bounces-26396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126E4870E64
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 22:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE0A284369
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 21:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B6279DCE;
	Mon,  4 Mar 2024 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vZhI6oAn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C48F58;
	Mon,  4 Mar 2024 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588612; cv=none; b=MyDE0cWandepZMc4gEkSMKUxiNRdX1+L8ZhfO6UW2YPozknN/9khndGuU2BLfVc8JwLx1o4YSERVK4/RcrhKddWBI4AqzOXOdqeS62Kzm/+a/tV03zJ7cbeJIZzrkMQX/Si8qhzZke0I7qGMb+L2MaGT+I/iL0BV9XIqNmferv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588612; c=relaxed/simple;
	bh=1p7wvH2+dGnQ7S852jhSGCwbyw0/ocF3cB7SjeIJju0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kG2hEA0eI2kB5aA5usyH0j3qP1uywzKhMlcXShQghSYFELuL6IRM5oD/8mAdx7yf16mjhl9S8FPUJ74Mfm6kArOs8VlPIeTIfl6+PBcscfSyg5+SZ3MBePn6lmV2YV/01yTWgmX3HEKXHusfmXIedN9qCfo1pEHpfEwSh/tdTR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vZhI6oAn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD8FC433F1;
	Mon,  4 Mar 2024 21:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709588611;
	bh=1p7wvH2+dGnQ7S852jhSGCwbyw0/ocF3cB7SjeIJju0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vZhI6oAnjh1Spl2+7y/EiX4ySWOq2BOE9uET4n7B13v6vwrCRaitUDryQAv4Kgyhh
	 nU8cLlMDgUXTQdhIVY0ujYvhsUzOZy1ijWJduUJrQod0IgSYAUEPBBq1muZeApBFDQ
	 TLUdwgzTiX6bbdygXxhESNTwM2yS9z3yp3n1C8Zg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com
Subject: [PATCH 6.1 030/215] net: ip_tunnel: prevent perpetual headroom growth
Date: Mon,  4 Mar 2024 21:21:33 +0000
Message-ID: <20240304211557.944727006@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
References: <20240304211556.993132804@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 5ae1e9922bbdbaeb9cfbe91085ab75927488ac0f ]

syzkaller triggered following kasan splat:
BUG: KASAN: use-after-free in __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
Read of size 1 at addr ffff88812fb4000e by task syz-executor183/5191
[..]
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 __skb_flow_dissect+0x19d1/0x7a50 net/core/flow_dissector.c:1170
 skb_flow_dissect_flow_keys include/linux/skbuff.h:1514 [inline]
 ___skb_get_hash net/core/flow_dissector.c:1791 [inline]
 __skb_get_hash+0xc7/0x540 net/core/flow_dissector.c:1856
 skb_get_hash include/linux/skbuff.h:1556 [inline]
 ip_tunnel_xmit+0x1855/0x33c0 net/ipv4/ip_tunnel.c:748
 ipip_tunnel_xmit+0x3cc/0x4e0 net/ipv4/ipip.c:308
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
 __dev_queue_xmit+0x7c1/0x3d60 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 neigh_connected_output+0x42c/0x5d0 net/core/neighbour.c:1592
 ...
 ip_finish_output2+0x833/0x2550 net/ipv4/ip_output.c:235
 ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:323
 ..
 iptunnel_xmit+0x5b4/0x9b0 net/ipv4/ip_tunnel_core.c:82
 ip_tunnel_xmit+0x1dbc/0x33c0 net/ipv4/ip_tunnel.c:831
 ipgre_xmit+0x4a1/0x980 net/ipv4/ip_gre.c:665
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x13d/0x6d0 net/core/dev.c:3564
 ...

The splat occurs because skb->data points past skb->head allocated area.
This is because neigh layer does:
  __skb_pull(skb, skb_network_offset(skb));

... but skb_network_offset() returns a negative offset and __skb_pull()
arg is unsigned.  IOW, we skb->data gets "adjusted" by a huge value.

The negative value is returned because skb->head and skb->data distance is
more than 64k and skb->network_header (u16) has wrapped around.

The bug is in the ip_tunnel infrastructure, which can cause
dev->needed_headroom to increment ad infinitum.

The syzkaller reproducer consists of packets getting routed via a gre
tunnel, and route of gre encapsulated packets pointing at another (ipip)
tunnel.  The ipip encapsulation finds gre0 as next output device.

This results in the following pattern:

1). First packet is to be sent out via gre0.
Route lookup found an output device, ipip0.

2).
ip_tunnel_xmit for gre0 bumps gre0->needed_headroom based on the future
output device, rt.dev->needed_headroom (ipip0).

3).
ip output / start_xmit moves skb on to ipip0. which runs the same
code path again (xmit recursion).

4).
Routing step for the post-gre0-encap packet finds gre0 as output device
to use for ipip0 encapsulated packet.

tunl0->needed_headroom is then incremented based on the (already bumped)
gre0 device headroom.

This repeats for every future packet:

gre0->needed_headroom gets inflated because previous packets' ipip0 step
incremented rt->dev (gre0) headroom, and ipip0 incremented because gre0
needed_headroom was increased.

For each subsequent packet, gre/ipip0->needed_headroom grows until
post-expand-head reallocations result in a skb->head/data distance of
more than 64k.

Once that happens, skb->network_header (u16) wraps around when
pskb_expand_head tries to make sure that skb_network_offset() is unchanged
after the headroom expansion/reallocation.

After this skb_network_offset(skb) returns a different (and negative)
result post headroom expansion.

The next trip to neigh layer (or anything else that would __skb_pull the
network header) makes skb->data point to a memory location outside
skb->head area.

v2: Cap the needed_headroom update to an arbitarily chosen upperlimit to
prevent perpetual increase instead of dropping the headroom increment
completely.

Reported-and-tested-by: syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com
Closes: https://groups.google.com/g/syzkaller-bugs/c/fL9G6GtWskY/m/VKk_PR5FBAAJ
Fixes: 243aad830e8a ("ip_gre: include route header_len in max_headroom calculation")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240220135606.4939-1-fw@strlen.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 24961b304dad0..328f9068c6a43 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -540,6 +540,20 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 	return 0;
 }
 
+static void ip_tunnel_adj_headroom(struct net_device *dev, unsigned int headroom)
+{
+	/* we must cap headroom to some upperlimit, else pskb_expand_head
+	 * will overflow header offsets in skb_headers_offset_update().
+	 */
+	static const unsigned int max_allowed = 512;
+
+	if (headroom > max_allowed)
+		headroom = max_allowed;
+
+	if (headroom > READ_ONCE(dev->needed_headroom))
+		WRITE_ONCE(dev->needed_headroom, headroom);
+}
+
 void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 		       u8 proto, int tunnel_hlen)
 {
@@ -614,13 +628,13 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	headroom += LL_RESERVED_SPACE(rt->dst.dev) + rt->dst.header_len;
-	if (headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, headroom);
-
-	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom))) {
+	if (skb_cow_head(skb, headroom)) {
 		ip_rt_put(rt);
 		goto tx_dropped;
 	}
+
+	ip_tunnel_adj_headroom(dev, headroom);
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, proto, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return;
@@ -800,16 +814,16 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	max_headroom = LL_RESERVED_SPACE(rt->dst.dev) + sizeof(struct iphdr)
 			+ rt->dst.header_len + ip_encap_hlen(&tunnel->encap);
-	if (max_headroom > READ_ONCE(dev->needed_headroom))
-		WRITE_ONCE(dev->needed_headroom, max_headroom);
 
-	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom))) {
+	if (skb_cow_head(skb, max_headroom)) {
 		ip_rt_put(rt);
 		dev->stats.tx_dropped++;
 		kfree_skb(skb);
 		return;
 	}
 
+	ip_tunnel_adj_headroom(dev, max_headroom);
+
 	iptunnel_xmit(NULL, rt, skb, fl4.saddr, fl4.daddr, protocol, tos, ttl,
 		      df, !net_eq(tunnel->net, dev_net(dev)));
 	return;
-- 
2.43.0




