Return-Path: <stable+bounces-48607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288CF8FE9B7
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F5F81C25DE9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDB219B3D9;
	Thu,  6 Jun 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U8GEzp8Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DEA19B3D5;
	Thu,  6 Jun 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683058; cv=none; b=hGOzoFqlEg90u2kc92zYCOL17u/hn89ApU1FK4yYxz1vhIky/fBArZSiRANc6masse/+mAjkpIWThQYoRl3ttxGsgMpxqAziKN1WRmQ8x5brypTXHKADnciIAIT3uaO8UIjMQXeqOOGNCZz6oWT4ffWWgq4q59bmfR7V2F7PlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683058; c=relaxed/simple;
	bh=uOnZD2DyxXy1N3jHMgLI6hQtz5jhSAspqqDe+KzJd/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxvlyiN2iv5+teFI4INd6kSGlWeHKQjyN0C7krTmQMf9hEuD0kjvFqC58kBK876TUyV23Dut3lO5pkIyImW0A37f1l5I+OTByJrcGsT3vBTVOwQo+/mOuqVcdBVy7M0eYFiBrbWtRc3ook9F96dA6/M7qZHHt5bBxaVfeoXyVdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U8GEzp8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B530CC4AF11;
	Thu,  6 Jun 2024 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683058;
	bh=uOnZD2DyxXy1N3jHMgLI6hQtz5jhSAspqqDe+KzJd/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U8GEzp8ZdZARNUqyFMud0kIR1UfTJqTbRTfPj4A2y9EMoVo0pY2sz5abigEFbHyWG
	 abbG8dhpjm5PKEIzEK090qn418vqHiKP8uAFITML7E9+nmVtBR/H+WUAtXmw1TSSTZ
	 oWsWCUCfmBwZ04X3DFjXgHOA8WLnMHexRJ88YCWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 306/374] netkit: Fix pkt_type override upon netkit pass verdict
Date: Thu,  6 Jun 2024 16:04:45 +0200
Message-ID: <20240606131702.096992188@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 3998d184267dfcff858aaa84d3de17429253629d ]

When running Cilium connectivity test suite with netkit in L2 mode, we
found that compared to tcx a few tests were failing which pushed traffic
into an L7 proxy sitting in host namespace. The problem in particular is
around the invocation of eth_type_trans() in netkit.

In case of tcx, this is run before the tcx ingress is triggered inside
host namespace and thus if the BPF program uses the bpf_skb_change_type()
helper the newly set type is retained. However, in case of netkit, the
late eth_type_trans() invocation overrides the earlier decision from the
BPF program which eventually leads to the test failure.

Instead of eth_type_trans(), split out the relevant parts, meaning, reset
of mac header and call to eth_skb_pkt_type() before the BPF program is run
in order to have the same behavior as with tcx, and refactor a small helper
called eth_skb_pull_mac() which is run in case it's passed up the stack
where the mac header must be pulled. With this all connectivity tests pass.

Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20240524163619.26001-2-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netkit.c        | 4 +++-
 include/linux/etherdevice.h | 8 ++++++++
 net/ethernet/eth.c          | 4 +---
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index 272894053e2c4..16789cd446e9e 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -55,6 +55,7 @@ static void netkit_prep_forward(struct sk_buff *skb, bool xnet)
 	skb_scrub_packet(skb, xnet);
 	skb->priority = 0;
 	nf_skip_egress(skb, true);
+	skb_reset_mac_header(skb);
 }
 
 static struct netkit *netkit_priv(const struct net_device *dev)
@@ -78,6 +79,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 		     skb_orphan_frags(skb, GFP_ATOMIC)))
 		goto drop;
 	netkit_prep_forward(skb, !net_eq(dev_net(dev), dev_net(peer)));
+	eth_skb_pkt_type(skb, peer);
 	skb->dev = peer;
 	entry = rcu_dereference(nk->active);
 	if (entry)
@@ -85,7 +87,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	switch (ret) {
 	case NETKIT_NEXT:
 	case NETKIT_PASS:
-		skb->protocol = eth_type_trans(skb, skb->dev);
+		eth_skb_pull_mac(skb);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 		if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
 			dev_sw_netstats_tx_add(dev, 1, len);
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 297231854ada5..e44913a8200fd 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -632,6 +632,14 @@ static inline void eth_skb_pkt_type(struct sk_buff *skb,
 	}
 }
 
+static inline struct ethhdr *eth_skb_pull_mac(struct sk_buff *skb)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb->data;
+
+	skb_pull_inline(skb, ETH_HLEN);
+	return eth;
+}
+
 /**
  * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
  * @skb: Buffer to pad
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 049c3adeb8504..4e3651101b866 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -161,9 +161,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	skb->dev = dev;
 	skb_reset_mac_header(skb);
 
-	eth = (struct ethhdr *)skb->data;
-	skb_pull_inline(skb, ETH_HLEN);
-
+	eth = eth_skb_pull_mac(skb);
 	eth_skb_pkt_type(skb, dev);
 
 	/*
-- 
2.43.0




