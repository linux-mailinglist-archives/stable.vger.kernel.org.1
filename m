Return-Path: <stable+bounces-180330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9E2B7F187
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 15:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CB44A2353
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE093233EF;
	Wed, 17 Sep 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8nlMgwi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637B328995;
	Wed, 17 Sep 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114120; cv=none; b=Xizz0Uo4hE+NYnN9brRmKE2gHKQWRtmFTTTbGnuY5Rmi/A+8yZQO8aQHtb5DrFut2E4vp10KOtyg/bIWQ2oInbWx1uNrLosjVIBFIwFhwlA9g2kRKieR94aQKtz3z7XnkZduyHD1r7jJat6lcRBJufcblpzfLaoh8L/AWFqpv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114120; c=relaxed/simple;
	bh=yD71f/148iIRMecgCLpjaKm6WgSz2/BrJXwJhKNnUrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xeha5FmWX3ESwDLGD+G9R0jtD9PCTWGRMftL7CCGFOoH9Tnf0s0N9EpLXvGiqMgbxEYbebGQs7DuQd4PBVETC4DRxtDhHuEtJlVmXp1LBZd5OhHxopsA5vQiNRXBOqq1HDnomcfsLk9Cspu38k6QSf44mmkOUXB2P/RraS3oXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y8nlMgwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93066C4CEF0;
	Wed, 17 Sep 2025 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758114120;
	bh=yD71f/148iIRMecgCLpjaKm6WgSz2/BrJXwJhKNnUrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y8nlMgwib81lgd2PRS0ceW3/LpwxrOLXqV9bxHa133/6xrHeXkz38WYXiKMNPKNSX
	 vsPmM6jp0MPl+JBMXdmP7EDwJBXAjabL9vUNenzNayFpLSnAkSzj3UC/VivoKK3Vle
	 5KK4R74ijfoLapqUtCw5aAq3rjBrLJpBUI9f1JE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Moreno <amorenoz@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 52/78] tunnels: reset the GSO metadata before reusing the skb
Date: Wed, 17 Sep 2025 14:35:13 +0200
Message-ID: <20250917123330.836618422@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123329.576087662@linuxfoundation.org>
References: <20250917123329.576087662@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoine Tenart <atenart@kernel.org>

[ Upstream commit e3c674db356c4303804b2415e7c2b11776cdd8c3 ]

If a GSO skb is sent through a Geneve tunnel and if Geneve options are
added, the split GSO skb might not fit in the MTU anymore and an ICMP
frag needed packet can be generated. In such case the ICMP packet might
go through the segmentation logic (and dropped) later if it reaches a
path were the GSO status is checked and segmentation is required.

This is especially true when an OvS bridge is used with a Geneve tunnel
attached to it. The following set of actions could lead to the ICMP
packet being wrongfully segmented:

1. An skb is constructed by the TCP layer (e.g. gso_type SKB_GSO_TCPV4,
   segs >= 2).

2. The skb hits the OvS bridge where Geneve options are added by an OvS
   action before being sent through the tunnel.

3. When the skb is xmited in the tunnel, the split skb does not fit
   anymore in the MTU and iptunnel_pmtud_build_icmp is called to
   generate an ICMP fragmentation needed packet. This is done by reusing
   the original (GSO!) skb. The GSO metadata is not cleared.

4. The ICMP packet being sent back hits the OvS bridge again and because
   skb_is_gso returns true, it goes through queue_gso_packets...

5. ...where __skb_gso_segment is called. The skb is then dropped.

6. Note that in the above example on re-transmission the skb won't be a
   GSO one as it would be segmented (len > MSS) and the ICMP packet
   should go through.

Fix this by resetting the GSO information before reusing an skb in
iptunnel_pmtud_build_icmp and iptunnel_pmtud_build_icmpv6.

Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Reported-by: Adrian Moreno <amorenoz@redhat.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Link: https://patch.msgid.link/20250904125351.159740-1-atenart@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index deb08cab44640..75e3d7501752d 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -203,6 +203,9 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct iphdr)))
 		return -EINVAL;
 
+	if (skb_is_gso(skb))
+		skb_gso_reset(skb);
+
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
 	skb_reset_network_header(skb);
@@ -297,6 +300,9 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	if (!pskb_may_pull(skb, ETH_HLEN + sizeof(struct ipv6hdr)))
 		return -EINVAL;
 
+	if (skb_is_gso(skb))
+		skb_gso_reset(skb);
+
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
 	skb_reset_network_header(skb);
-- 
2.51.0




