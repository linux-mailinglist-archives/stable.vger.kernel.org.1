Return-Path: <stable+bounces-156097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58B0AE44ED
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 897C47AE511
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AFA253340;
	Mon, 23 Jun 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G8kYykPR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BF4253351;
	Mon, 23 Jun 2025 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686142; cv=none; b=laf3N7JgCiwufRK8MlFRoJxj0PbsP5RM8O7/0gt72C4rf6WQDxz5rzsyI4gZqf0fBfv0gPxVx0Zibe/cBsytn1cUUB+7IAuJBCFHkTU2o+HY2o4KrtIAe+kRh4GVSf/MUjDS1Oo6XDchsIaR6CjIs9ZbTI8D193j7IApaUCoGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686142; c=relaxed/simple;
	bh=W4fNNwsLiycWyBKBWkQlOEfda8p3vZqSfrl8YpHbkZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgCwWewlhtLWGPOkLCedzlFAZbJaW+GIHVbLTVLMqAdZ1wKIV1HuUCw9tgo2uKbKbBREBjrfqPwdvAz18Bxd3Rcx/zLOfK5i7l5TIpUKx1oBjTHhaxzabWLUfs+1XplCweKVrXXBYM/uRQVrQiwbVRGpd3Hu73/cO2VBpwkUNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G8kYykPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D820FC4CEEA;
	Mon, 23 Jun 2025 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750686142;
	bh=W4fNNwsLiycWyBKBWkQlOEfda8p3vZqSfrl8YpHbkZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G8kYykPRHwn2lnGSnCSjcN2Iyb0VUxut8J4cFsB5pj37vIqcx4pPPt5v/x1QwZVOG
	 Hu+MVDhYcNBEM/LD7tl6jFr9eAXA1jrYeRub0tBNYjKxVGMxSoiBMvyp2cr+Gs9L0L
	 wGzt2r/oL44ChncuRCdzDsVmlOttWK5AtSVJN7kI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ronak Doshi <ronak.doshi@broadcom.com>,
	Guolin Yang <guolin.yang@broadcom.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 104/355] vmxnet3: correctly report gso type for UDP tunnels
Date: Mon, 23 Jun 2025 15:05:05 +0200
Message-ID: <20250623130629.905766511@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronak Doshi <ronak.doshi@broadcom.com>

[ Upstream commit 982d30c30eaa2ec723df42e3bf526c014c1dbb88 ]

Commit 3d010c8031e3 ("udp: do not accept non-tunnel GSO skbs landing
in a tunnel") added checks in linux stack to not accept non-tunnel
GRO packets landing in a tunnel. This exposed an issue in vmxnet3
which was not correctly reporting GRO packets for tunnel packets.

This patch fixes this issue by setting correct GSO type for the
tunnel packets.

Currently, vmxnet3 does not support reporting inner fields for LRO
tunnel packets. The issue is not seen for egress drivers that do not
use skb inner fields. The workaround is to enable tnl-segmentation
offload on the egress interfaces if the driver supports it. This
problem pre-exists this patch fix and can be addressed as a separate
future patch.

Fixes: dacce2be3312 ("vmxnet3: add geneve and vxlan tunnel offload support")
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Guolin Yang <guolin.yang@broadcom.com>
Link: https://patch.msgid.link/20250530152701.70354-1-ronak.doshi@broadcom.com
[pabeni@redhat.com: dropped the changelog]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vmxnet3/vmxnet3_drv.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/vmxnet3/vmxnet3_drv.c b/drivers/net/vmxnet3/vmxnet3_drv.c
index 3b889fed98826..50a7a1abb90a0 100644
--- a/drivers/net/vmxnet3/vmxnet3_drv.c
+++ b/drivers/net/vmxnet3/vmxnet3_drv.c
@@ -1355,6 +1355,30 @@ vmxnet3_get_hdr_len(struct vmxnet3_adapter *adapter, struct sk_buff *skb,
 	return (hlen + (hdr.tcp->doff << 2));
 }
 
+static void
+vmxnet3_lro_tunnel(struct sk_buff *skb, __be16 ip_proto)
+{
+	struct udphdr *uh = NULL;
+
+	if (ip_proto == htons(ETH_P_IP)) {
+		struct iphdr *iph = (struct iphdr *)skb->data;
+
+		if (iph->protocol == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	} else {
+		struct ipv6hdr *iph = (struct ipv6hdr *)skb->data;
+
+		if (iph->nexthdr == IPPROTO_UDP)
+			uh = (struct udphdr *)(iph + 1);
+	}
+	if (uh) {
+		if (uh->check)
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL_CSUM;
+		else
+			skb_shinfo(skb)->gso_type |= SKB_GSO_UDP_TUNNEL;
+	}
+}
+
 static int
 vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 		       struct vmxnet3_adapter *adapter, int quota)
@@ -1591,6 +1615,8 @@ vmxnet3_rq_rx_complete(struct vmxnet3_rx_queue *rq,
 			if (segCnt != 0 && mss != 0) {
 				skb_shinfo(skb)->gso_type = rcd->v4 ?
 					SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+				if (encap_lro)
+					vmxnet3_lro_tunnel(skb, skb->protocol);
 				skb_shinfo(skb)->gso_size = mss;
 				skb_shinfo(skb)->gso_segs = segCnt;
 			} else if ((segCnt != 0 || skb->len > mtu) && !encap_lro) {
-- 
2.39.5




