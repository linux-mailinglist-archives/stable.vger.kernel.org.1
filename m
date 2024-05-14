Return-Path: <stable+bounces-44653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5A8C53D2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49C511F23154
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2DC13AA4E;
	Tue, 14 May 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aR2RE+XJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7787A7F48C;
	Tue, 14 May 2024 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686783; cv=none; b=k7Z//4hswZ8RCeJ/lW+rtK1QILYgC9pfOOnscd3Bt9TrizlhfWYGRNOcsgd9RFeQbZ+6MXXu7vlJ2fnYByQll1itkCiXXVvQsEtMStu5P7dh4NyYhLGikX7huhFYTYnvUvi/wH3KUIq5FyN3BOp5SzvHz9skofyFQ0hVdF8A5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686783; c=relaxed/simple;
	bh=6m4LTsc24/mKzF2TsvsBwWST5LDzhmYBxsR1KGSK3nU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kP58WtbaM+JsGTMS1yaiU5ThqKDO9gwB4e5mN6Mrfvc6zFPX5OaY50X1dkVie8IDZnKyy7tPu3PliT0VoQ+ZwOlQCOJdbrPnzKBgk4RC56Xv+U+zr7hAtr2Ue94rsMHob5OTyB/ZGkZpmCaher7/84EOl4HWR3/OBYi0ed8deF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aR2RE+XJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA30CC2BD10;
	Tue, 14 May 2024 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686783;
	bh=6m4LTsc24/mKzF2TsvsBwWST5LDzhmYBxsR1KGSK3nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aR2RE+XJf+qAvZnlMhj5K7BlAOTXozdj4sz7dPSOaBFMTl83CaEu28CAQA3cstDTU
	 9FD22ISJF2lA6u/+AapqF3p3RSQV+P2rLHoyoQX8ig05oFCS04X0fqJzplV+d0yanP
	 Uz+o1IKGBdEgUYxIvgwWPHbXyxOZi09TVjFO1e/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 08/63] ethernet: Add helper for assigning packet type when dest address does not match device address
Date: Tue, 14 May 2024 12:19:29 +0200
Message-ID: <20240514100948.329175471@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100948.010148088@linuxfoundation.org>
References: <20240514100948.010148088@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 6e159fd653d7ebf6290358e0330a0cb8a75cf73b ]

Enable reuse of logic in eth_type_trans for determining packet type.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-3-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/etherdevice.h | 25 +++++++++++++++++++++++++
 net/ethernet/eth.c          | 12 +-----------
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index fef4bb77f7590..267b3cbc7ae13 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -543,6 +543,31 @@ static inline void eth_hw_addr_gen(struct net_device *dev, const u8 *base_addr,
 	eth_hw_addr_set(dev, addr);
 }
 
+/**
+ * eth_skb_pkt_type - Assign packet type if destination address does not match
+ * @skb: Assigned a packet type if address does not match @dev address
+ * @dev: Network device used to compare packet address against
+ *
+ * If the destination MAC address of the packet does not match the network
+ * device address, assign an appropriate packet type.
+ */
+static inline void eth_skb_pkt_type(struct sk_buff *skb,
+				    const struct net_device *dev)
+{
+	const struct ethhdr *eth = eth_hdr(skb);
+
+	if (unlikely(!ether_addr_equal_64bits(eth->h_dest, dev->dev_addr))) {
+		if (unlikely(is_multicast_ether_addr_64bits(eth->h_dest))) {
+			if (ether_addr_equal_64bits(eth->h_dest, dev->broadcast))
+				skb->pkt_type = PACKET_BROADCAST;
+			else
+				skb->pkt_type = PACKET_MULTICAST;
+		} else {
+			skb->pkt_type = PACKET_OTHERHOST;
+		}
+	}
+}
+
 /**
  * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
  * @skb: Buffer to pad
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 88a074dd983e6..31be0b426e839 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -165,17 +165,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	eth = (struct ethhdr *)skb->data;
 	skb_pull_inline(skb, ETH_HLEN);
 
-	if (unlikely(!ether_addr_equal_64bits(eth->h_dest,
-					      dev->dev_addr))) {
-		if (unlikely(is_multicast_ether_addr_64bits(eth->h_dest))) {
-			if (ether_addr_equal_64bits(eth->h_dest, dev->broadcast))
-				skb->pkt_type = PACKET_BROADCAST;
-			else
-				skb->pkt_type = PACKET_MULTICAST;
-		} else {
-			skb->pkt_type = PACKET_OTHERHOST;
-		}
-	}
+	eth_skb_pkt_type(skb, dev);
 
 	/*
 	 * Some variants of DSA tagging don't have an ethertype field
-- 
2.43.0




