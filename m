Return-Path: <stable+bounces-100573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B959EC76A
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BB5F16A5CC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A51DB361;
	Wed, 11 Dec 2024 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="W5DWXQ0x"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E171CACF6;
	Wed, 11 Dec 2024 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906168; cv=none; b=oJ3x3A5zijoVUjb4ZfNla7B26srCu3qoTEMa4oTH3/oTV3iyEZoiTxd4QksDLQxKHUXDwR04NyWaKMfF0XIi1HjjjBrp4+36rh5OcLpTGa1NKJdbevzjHLL9JsryuMbQ4IWaHw8VVXfIAr+b/yGx0qiOBUCTqvnykTcnrLHOaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906168; c=relaxed/simple;
	bh=kVCtMddhmeZuKgDNYydzlRP10k8SWm+JKr21mzpHE68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N2FYUwY1iv6z72jb5N3kPc+usuf8TN14Uf89JyD6KTflqOPGopt9yMGNTJDVcDJQaVUP30TlxxkHOXI4nNN9rQGiySA2eV6r/GWVRCTJ03LhG4uFJjveL5kbaj5Ii/z9lkK/dMhw70X9J2/Z+H+2uGXYEHkd5rCiQ8sxoZGcInk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=W5DWXQ0x; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3w8pn
	8MwnQDCUe3z9br+oB87725N88Ju1DdIPaH510c=; b=W5DWXQ0x1q0+AMg6GActS
	WZ6y9942/Y69Ro0PSdKJweWZKiw0/Q8JU04OvZH8YRpH2NaxwJJTFfh0uSX2co2J
	bdxgjdb2ogSaIvfn231g1nGEfAUE2Psm8LEcdMT256f04+wb08tOH9W6CbFc9DCV
	9xUzD6fmjY4y13FV30XE7w=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnxZiRTllnFR66AA--.16830S4;
	Wed, 11 Dec 2024 16:34:36 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	make_ruc2021@163.com,
	shannon.nelson@amd.com,
	sd@queasysnail.net,
	u.kleine-koenig@baylibre.com,
	mdf@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: ethernet: fix NULL dereference in nixge_recv()
Date: Wed, 11 Dec 2024 16:34:24 +0800
Message-Id: <20241211083424.2580563-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnxZiRTllnFR66AA--.16830S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyUJrWkKFW8tr1xGw13CFg_yoWrArWfpa
	yrCasYqF47tr47trWkJrsxtry5A3W3uFy7WFZ7Gw4rA34xA3WrG3WqkFy29rykXrWDtFW3
	GrWYqFW3ur1kX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pREoGPUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizR2yC2dY-AfqwgADsG

In function nixge_recv() dereference of NULL pointer priv->rx_bd_v is
possible for the case of its allocation failure in netdev_priv(ndev).

Move while() loop with priv->rx_bd_v dereference under the check for
its validity.

Cc: stable@vger.kernel.org
Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/net/ethernet/ni/nixge.c | 86 ++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99dd7..2935ffd62e2a 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -603,64 +603,64 @@ static int nixge_recv(struct net_device *ndev, int budget)
 	u32 size = 0;
 
 	cur_p = &priv->rx_bd_v[priv->rx_bd_ci];
+	if (priv->rx_bd_v) {
+		while ((cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK &&
+			budget > packets)) {
+			tail_p = priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
+				 priv->rx_bd_ci;
 
-	while ((cur_p->status & XAXIDMA_BD_STS_COMPLETE_MASK &&
-		budget > packets)) {
-		tail_p = priv->rx_bd_p + sizeof(*priv->rx_bd_v) *
-			 priv->rx_bd_ci;
+			skb = (struct sk_buff *)(uintptr_t)
+				nixge_hw_dma_bd_get_addr(cur_p, sw_id_offset);
 
-		skb = (struct sk_buff *)(uintptr_t)
-			nixge_hw_dma_bd_get_addr(cur_p, sw_id_offset);
+			length = cur_p->status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
+			if (length > NIXGE_MAX_JUMBO_FRAME_SIZE)
+				length = NIXGE_MAX_JUMBO_FRAME_SIZE;
 
-		length = cur_p->status & XAXIDMA_BD_STS_ACTUAL_LEN_MASK;
-		if (length > NIXGE_MAX_JUMBO_FRAME_SIZE)
-			length = NIXGE_MAX_JUMBO_FRAME_SIZE;
+			dma_unmap_single(ndev->dev.parent,
+					 nixge_hw_dma_bd_get_addr(cur_p, phys),
+					 NIXGE_MAX_JUMBO_FRAME_SIZE,
+					 DMA_FROM_DEVICE);
 
-		dma_unmap_single(ndev->dev.parent,
-				 nixge_hw_dma_bd_get_addr(cur_p, phys),
-				 NIXGE_MAX_JUMBO_FRAME_SIZE,
-				 DMA_FROM_DEVICE);
+			skb_put(skb, length);
 
-		skb_put(skb, length);
+			skb->protocol = eth_type_trans(skb, ndev);
+			skb_checksum_none_assert(skb);
 
-		skb->protocol = eth_type_trans(skb, ndev);
-		skb_checksum_none_assert(skb);
+			/* For now mark them as CHECKSUM_NONE since
+			 * we don't have offload capabilities
+			 */
+			skb->ip_summed = CHECKSUM_NONE;
 
-		/* For now mark them as CHECKSUM_NONE since
-		 * we don't have offload capabilities
-		 */
-		skb->ip_summed = CHECKSUM_NONE;
+			napi_gro_receive(&priv->napi, skb);
 
-		napi_gro_receive(&priv->napi, skb);
+			size += length;
+			packets++;
 
-		size += length;
-		packets++;
+			new_skb = netdev_alloc_skb_ip_align(ndev,
+							    NIXGE_MAX_JUMBO_FRAME_SIZE);
+			if (!new_skb)
+				return packets;
 
-		new_skb = netdev_alloc_skb_ip_align(ndev,
-						    NIXGE_MAX_JUMBO_FRAME_SIZE);
-		if (!new_skb)
-			return packets;
-
-		cur_phys = dma_map_single(ndev->dev.parent, new_skb->data,
-					  NIXGE_MAX_JUMBO_FRAME_SIZE,
-					  DMA_FROM_DEVICE);
-		if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
-			/* FIXME: bail out and clean up */
-			netdev_err(ndev, "Failed to map ...\n");
+			cur_phys = dma_map_single(ndev->dev.parent, new_skb->data,
+						  NIXGE_MAX_JUMBO_FRAME_SIZE,
+						  DMA_FROM_DEVICE);
+			if (dma_mapping_error(ndev->dev.parent, cur_phys)) {
+				/* FIXME: bail out and clean up */
+				netdev_err(ndev, "Failed to map ...\n");
+			}
+			nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
+			cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
+			cur_p->status = 0;
+			nixge_hw_dma_bd_set_offset(cur_p, (uintptr_t)new_skb);
+
+			++priv->rx_bd_ci;
+			priv->rx_bd_ci %= RX_BD_NUM;
+			cur_p = &priv->rx_bd_v[priv->rx_bd_ci];
 		}
-		nixge_hw_dma_bd_set_phys(cur_p, cur_phys);
-		cur_p->cntrl = NIXGE_MAX_JUMBO_FRAME_SIZE;
-		cur_p->status = 0;
-		nixge_hw_dma_bd_set_offset(cur_p, (uintptr_t)new_skb);
-
-		++priv->rx_bd_ci;
-		priv->rx_bd_ci %= RX_BD_NUM;
-		cur_p = &priv->rx_bd_v[priv->rx_bd_ci];
 	}
 
 	ndev->stats.rx_packets += packets;
 	ndev->stats.rx_bytes += size;
-
 	if (tail_p)
 		nixge_dma_write_desc_reg(priv, XAXIDMA_RX_TDESC_OFFSET, tail_p);
 
-- 
2.25.1


