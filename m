Return-Path: <stable+bounces-44188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AAE8C51A3
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F751C2160B
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422D13AA38;
	Tue, 14 May 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yw652tW+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6F168C7;
	Tue, 14 May 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715684821; cv=none; b=d9ZMWs/i65rGDapye4S73IEBb9yxF1BMeeeYGMl5BfvRH5XY9QZGzS8PujA91IBf3J0Hk/7CGCICdYe+1BcpE88DyqyxFmaiZgkUYeQw7+3iB3NlGAS0honpCg0ARY1j1ekLa6pxyF/pPt708QSOFG7L5xgbFw7oDC2JOofjDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715684821; c=relaxed/simple;
	bh=Ui01BzRuuDg+KfdctzG8oeyiBMzb4Xc5XwiDmhlGNVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPfXpHKkiJaBNb0xMfK1SopVZklZiYHiI4Hy5Sfl2osCYB2cpR6EHs0jUelNDJi6blS0Gmuap1chrs23mxd12eISzQAf7gooPL7p9qk/IDKyStHocc0gkSRjiFMfY8RloJVVIS5HLNxziMj10ArmDlr8DOw4p7vw0NmqJYOulHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yw652tW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C10C2BD10;
	Tue, 14 May 2024 11:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715684821;
	bh=Ui01BzRuuDg+KfdctzG8oeyiBMzb4Xc5XwiDmhlGNVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yw652tW+6m9t2RqG8jrwWzaMkYuHwBS0Bj/yiOjTHPbheY9KSxLO8pVynqtAeSHUu
	 xIP0N2OVW0K1iiMCURJXPpSf9Ke+UzmVm50ooDsRZFssyUZRy8xI6ITSUxMejqNVvy
	 nuAxJCNy9sroie+3xOjU7pTGbtUlxYF7YG8/7xAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guillaume Nault <gnault@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 063/301] vxlan: Fix racy device stats updates.
Date: Tue, 14 May 2024 12:15:34 +0200
Message-ID: <20240514101034.622496019@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 6dee402daba4eb8677a9438ebdcd8fe90ddd4326 ]

VXLAN devices update their stats locklessly. Therefore these counters
should either be stored in per-cpu data structures or the updates
should be done using atomic increments.

Since the net_device_core_stats infrastructure is already used in
vxlan_rcv(), use it for the other rx_dropped and tx_dropped counter
updates. Update the other counters atomically using DEV_STATS_INC().

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vxlan/vxlan_core.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ecdf0276004f9..3d3c11e61f9de 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1766,8 +1766,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	if (!vxlan_ecn_decapsulate(vs, oiph, skb)) {
-		++vxlan->dev->stats.rx_frame_errors;
-		++vxlan->dev->stats.rx_errors;
+		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
+		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, vni, vninode,
 				      VXLAN_VNI_STATS_RX_ERRORS, 0);
 		goto drop;
@@ -1837,7 +1837,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		goto out;
 
 	if (!pskb_may_pull(skb, arp_hdr_len(dev))) {
-		dev->stats.tx_dropped++;
+		dev_core_stats_tx_dropped_inc(dev);
 		goto out;
 	}
 	parp = arp_hdr(skb);
@@ -1893,7 +1893,7 @@ static int arp_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 		reply->pkt_type = PACKET_HOST;
 
 		if (netif_rx(reply) == NET_RX_DROP) {
-			dev->stats.rx_dropped++;
+			dev_core_stats_rx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
@@ -2052,7 +2052,7 @@ static int neigh_reduce(struct net_device *dev, struct sk_buff *skb, __be32 vni)
 			goto out;
 
 		if (netif_rx(reply) == NET_RX_DROP) {
-			dev->stats.rx_dropped++;
+			dev_core_stats_rx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_RX_DROPS, 0);
 		}
@@ -2371,7 +2371,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 				      len);
 	} else {
 drop:
-		dev->stats.rx_dropped++;
+		dev_core_stats_rx_dropped_inc(dev);
 		vxlan_vnifilter_count(dst_vxlan, vni, NULL,
 				      VXLAN_VNI_STATS_RX_DROPS, 0);
 	}
@@ -2403,7 +2403,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 					   daddr->sa.sa_family, dst_port,
 					   vxlan->cfg.flags);
 		if (!dst_vxlan) {
-			dev->stats.tx_errors++;
+			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
 			kfree_skb(skb);
@@ -2664,7 +2664,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 drop:
-	dev->stats.tx_dropped++;
+	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
 	return;
@@ -2672,11 +2672,11 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 tx_error:
 	rcu_read_unlock();
 	if (err == -ELOOP)
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
-		dev->stats.tx_carrier_errors++;
+		DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_release(ndst);
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	vxlan_vnifilter_count(vxlan, vni, NULL, VXLAN_VNI_STATS_TX_ERRORS, 0);
 	kfree_skb(skb);
 }
@@ -2709,7 +2709,7 @@ static void vxlan_xmit_nh(struct sk_buff *skb, struct net_device *dev,
 	return;
 
 drop:
-	dev->stats.tx_dropped++;
+	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
@@ -2747,7 +2747,7 @@ static netdev_tx_t vxlan_xmit_nhid(struct sk_buff *skb, struct net_device *dev,
 	return NETDEV_TX_OK;
 
 drop:
-	dev->stats.tx_dropped++;
+	dev_core_stats_tx_dropped_inc(dev);
 	vxlan_vnifilter_count(netdev_priv(dev), vni, NULL,
 			      VXLAN_VNI_STATS_TX_DROPS, 0);
 	dev_kfree_skb(skb);
@@ -2844,7 +2844,7 @@ static netdev_tx_t vxlan_xmit(struct sk_buff *skb, struct net_device *dev)
 			    !is_multicast_ether_addr(eth->h_dest))
 				vxlan_fdb_miss(vxlan, eth->h_dest);
 
-			dev->stats.tx_dropped++;
+			dev_core_stats_tx_dropped_inc(dev);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_DROPS, 0);
 			kfree_skb(skb);
-- 
2.43.0




