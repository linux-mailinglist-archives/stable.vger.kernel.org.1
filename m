Return-Path: <stable+bounces-54549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC390EEC8
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A431C24140
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB4814D6EF;
	Wed, 19 Jun 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7el5uWs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1A14B963;
	Wed, 19 Jun 2024 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803908; cv=none; b=CLBv/Ya4PJ5oX/xAf3qZjre0lIhlEHx6gZVmbWFMsrkIMueSVCPtYVIb2CltkMBF5p/L+bHLBaAvxlRd87e97Im4DBzYl5y9ykDOljWs9xdTgaUjHz+2/Ocu6SQgbqhhaSOH4BczF1ogjIrwQWQ0m8G4DPodbhr4sQXhfMGtmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803908; c=relaxed/simple;
	bh=lrF1OKvhArM0cvRAycJ42iAm6hHGMHYvys74+welJlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bfqq65ik8Cu3NRpWPgzihvJ+yM58k93Q7kiXc7Xp21dcS1s6D7A0AGvjZOOTIVjQ5SCqDHGZ/4MVHiQLlKTO2EBk8Eg69b/JKdkYuAyl2sqsnafxA1PN0DjmL8bp4ac8c0D3EXUXxvXGP2i2DQFFdRGPzPX1foRBzd9fTKASzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P7el5uWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44DAC2BBFC;
	Wed, 19 Jun 2024 13:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803908;
	bh=lrF1OKvhArM0cvRAycJ42iAm6hHGMHYvys74+welJlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P7el5uWsG70xw/JAkPoTZ94mhs9pNf1qebgL6PZjt1SPkASclY6s+QMHjahuS4dMM
	 tZoGfuzlzqkqUXcUKzx3XwyG1xdinEY2oDUCk5dVQYch6zqmKJGw73nvHyOFpV7smT
	 wVkTsxcQnsjS5A5E12U+ClZdJn5VYXPIeGZbmiuo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 145/217] geneve: Fix incorrect inner network header offset when innerprotoinherit is set
Date: Wed, 19 Jun 2024 14:56:28 +0200
Message-ID: <20240619125602.285987377@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
References: <20240619125556.491243678@linuxfoundation.org>
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

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit c6ae073f5903f6c6439d0ac855836a4da5c0a701 ]

When innerprotoinherit is set, the tunneled packets do not have an inner
Ethernet header.
Change 'maclen' to not always assume the header length is ETH_HLEN, as
there might not be a MAC header.

This resolves issues with drivers (e.g. mlx5, in
mlx5e_tx_tunnel_accel()) who rely on the skb inner network header offset
to be correct, and use it for TX offloads.

Fixes: d8a6213d70ac ("geneve: fix header validation in geneve[6]_xmit_skb")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/geneve.c     | 10 ++++++----
 include/net/ip_tunnels.h |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 488ca1c854962..c4a49a75250e3 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -919,6 +919,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			   struct geneve_dev *geneve,
 			   const struct ip_tunnel_info *info)
 {
+	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
 	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
 	const struct ip_tunnel_key *key = &info->key;
@@ -930,7 +931,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb))
+	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
@@ -1003,7 +1004,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	err = geneve_build_skb(&rt->dst, skb, info, xnet, sizeof(struct iphdr),
-			       geneve->cfg.inner_proto_inherit);
+			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
 
@@ -1019,6 +1020,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    struct geneve_dev *geneve,
 			    const struct ip_tunnel_info *info)
 {
+	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
 	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
 	const struct ip_tunnel_key *key = &info->key;
@@ -1028,7 +1030,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (!skb_vlan_inet_prepare(skb))
+	if (!skb_vlan_inet_prepare(skb, inner_proto_inherit))
 		return -EINVAL;
 
 	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
@@ -1083,7 +1085,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		ttl = ttl ? : ip6_dst_hoplimit(dst);
 	}
 	err = geneve_build_skb(dst, skb, info, xnet, sizeof(struct ipv6hdr),
-			       geneve->cfg.inner_proto_inherit);
+			       inner_proto_inherit);
 	if (unlikely(err))
 		return err;
 
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index f9906b73e7ff4..0cc077c3dda30 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -353,9 +353,10 @@ static inline bool pskb_inet_may_pull(struct sk_buff *skb)
 
 /* Variant of pskb_inet_may_pull().
  */
-static inline bool skb_vlan_inet_prepare(struct sk_buff *skb)
+static inline bool skb_vlan_inet_prepare(struct sk_buff *skb,
+					 bool inner_proto_inherit)
 {
-	int nhlen = 0, maclen = ETH_HLEN;
+	int nhlen = 0, maclen = inner_proto_inherit ? 0 : ETH_HLEN;
 	__be16 type = skb->protocol;
 
 	/* Essentially this is skb_protocol(skb, true)
-- 
2.43.0




