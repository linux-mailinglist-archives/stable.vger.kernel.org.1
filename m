Return-Path: <stable+bounces-189987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8626AC0E335
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A15426915
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F951D9A5D;
	Mon, 27 Oct 2025 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDIbr+tR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031142C0286
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572974; cv=none; b=LZ1/c96cTrjga+b/3sJXooJ2d2e3+H3r+Xn7R5takK39zxEu/heCrSsCguV3e5ijh0LL8wtpKX9GllyIJ4sDyJgqKlekovDgrOaJlEffW4t5i/p+WzU2sVOcOKsj9GNuzWjgxqjp9P8LGHpdX2yiSo2ItmRCW3xWvcvMe4TxGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572974; c=relaxed/simple;
	bh=ZmRDtIH7UFne65LYIRz+dz9yb7eX6N/umAFAAjQFEZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Imo0xaLlCRzXfS26owkChoGGj0bNFvwCAj1AygROv2HDN182zOSB9SLj4djRz3MofNLUWCw8l+5ZZ1tX2dGCxHP1z8P/E6eqXOdCy7uoL2FmMYS4hPffx77E3Mi5RZRtV0+ltoJuKp3PdhMfsQuZgSmx0aKkba2A3e2psWtwCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDIbr+tR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5181C4CEF1;
	Mon, 27 Oct 2025 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572973;
	bh=ZmRDtIH7UFne65LYIRz+dz9yb7eX6N/umAFAAjQFEZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDIbr+tRnxh5K+sZ0GHS/Ml2I0mwBPl/87fEnzXrdK4v3Pk3oIo6acHYtRJMpdgz9
	 00ahadCTuZ18voLYGzaxEXFYkYNJAJhTIY/86u64CJIBUBmZ9QikLwnJyz1WZqhUzm
	 8/+KINu7nZREbQ4yElWzq7FXdWWAmNZYoiyHzMUT8INu2XU459AcsGK7yvVb9s8O3X
	 Imsd10bD1goj+dkflhMVkBsjklfxOsz5EwgWtdESu/CHbVgWkRUG3+6JdMdb4LlQtH
	 +wIBlCK/qSYjfd3ui2xufWjeL/diyHl5PvQ0ZW6HLs4I9XNu4AXXBgjzlcmFrUeY3o
	 wY35+SVPUKLTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ravb: Exclude gPTP feature support for RZ/G2L
Date: Mon, 27 Oct 2025 09:49:30 -0400
Message-ID: <20251027134931.492032-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102623-footless-outcast-b793@gregkh>
References: <2025102623-footless-outcast-b793@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 7e09a052dc4e30ce07fd7b3aa58a7d993f73a9d7 ]

R-Car supports gPTP feature whereas RZ/G2L does not support it.
This patch excludes gtp feature support for RZ/G2L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 5370c31e84b0 ("net: ravb: Enforce descriptor type ordering")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/ravb_main.c | 85 ++++++++++++++----------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index eee446e500486..ad61226098973 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1321,6 +1321,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			    struct ethtool_ts_info *info)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *hw_info = priv->info;
 
 	info->so_timestamping =
 		SOF_TIMESTAMPING_TX_SOFTWARE |
@@ -1334,7 +1335,8 @@ static int ravb_get_ts_info(struct net_device *ndev,
 		(1 << HWTSTAMP_FILTER_NONE) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 		(1 << HWTSTAMP_FILTER_ALL);
-	info->phc_index = ptp_clock_index(priv->ptp.clock);
+	if (hw_info->gptp || hw_info->ccc_gac)
+		info->phc_index = ptp_clock_index(priv->ptp.clock);
 
 	return 0;
 }
@@ -1565,6 +1567,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	unsigned int num_tx_desc = priv->num_tx_desc;
 	u16 q = skb_get_queue_mapping(skb);
 	struct ravb_tstamp_skb *ts_skb;
@@ -1641,28 +1644,30 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	desc->dptr = cpu_to_le32(dma_addr);
 
 	/* TX timestamp required */
-	if (q == RAVB_NC) {
-		ts_skb = kmalloc(sizeof(*ts_skb), GFP_ATOMIC);
-		if (!ts_skb) {
-			if (num_tx_desc > 1) {
-				desc--;
-				dma_unmap_single(ndev->dev.parent, dma_addr,
-						 len, DMA_TO_DEVICE);
+	if (info->gptp || info->ccc_gac) {
+		if (q == RAVB_NC) {
+			ts_skb = kmalloc(sizeof(*ts_skb), GFP_ATOMIC);
+			if (!ts_skb) {
+				if (num_tx_desc > 1) {
+					desc--;
+					dma_unmap_single(ndev->dev.parent, dma_addr,
+							 len, DMA_TO_DEVICE);
+				}
+				goto unmap;
 			}
-			goto unmap;
+			ts_skb->skb = skb_get(skb);
+			ts_skb->tag = priv->ts_skb_tag++;
+			priv->ts_skb_tag &= 0x3ff;
+			list_add_tail(&ts_skb->list, &priv->ts_skb_list);
+
+			/* TAG and timestamp required flag */
+			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+			desc->tagh_tsr = (ts_skb->tag >> 4) | TX_TSR;
+			desc->ds_tagl |= cpu_to_le16(ts_skb->tag << 12);
 		}
-		ts_skb->skb = skb_get(skb);
-		ts_skb->tag = priv->ts_skb_tag++;
-		priv->ts_skb_tag &= 0x3ff;
-		list_add_tail(&ts_skb->list, &priv->ts_skb_list);
 
-		/* TAG and timestamp required flag */
-		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-		desc->tagh_tsr = (ts_skb->tag >> 4) | TX_TSR;
-		desc->ds_tagl |= cpu_to_le16(ts_skb->tag << 12);
+		skb_tx_timestamp(skb);
 	}
-
-	skb_tx_timestamp(skb);
 	/* Descriptor type must be set after all the above writes */
 	dma_wmb();
 	if (num_tx_desc > 1) {
@@ -1773,10 +1778,12 @@ static int ravb_close(struct net_device *ndev)
 			   "device will be stopped after h/w processes are done.\n");
 
 	/* Clear the timestamp list */
-	list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
-		list_del(&ts_skb->list);
-		kfree_skb(ts_skb->skb);
-		kfree(ts_skb);
+	if (info->gptp || info->ccc_gac) {
+		list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
+			list_del(&ts_skb->list);
+			kfree_skb(ts_skb->skb);
+			kfree(ts_skb);
+		}
 	}
 
 	/* PHY disconnect */
@@ -2108,9 +2115,11 @@ static void ravb_set_config_mode(struct net_device *ndev)
 		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
 		/* Set CSEL value */
 		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
-	} else {
+	} else if (info->ccc_gac) {
 		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG |
 			    CCC_GAC | CCC_CSEL_HPB);
+	} else {
+		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
 	}
 }
 
@@ -2298,13 +2307,15 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Set AVB config mode */
 	ravb_set_config_mode(ndev);
 
-	/* Set GTI value */
-	error = ravb_set_gti(ndev);
-	if (error)
-		goto out_disable_refclk;
+	if (info->gptp || info->ccc_gac) {
+		/* Set GTI value */
+		error = ravb_set_gti(ndev);
+		if (error)
+			goto out_disable_refclk;
 
-	/* Request GTI loading */
-	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+		/* Request GTI loading */
+		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+	}
 
 	if (info->internal_delay) {
 		ravb_parse_delay_mode(np, ndev);
@@ -2501,13 +2512,15 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	/* Set AVB config mode */
 	ravb_set_config_mode(ndev);
 
-	/* Set GTI value */
-	ret = ravb_set_gti(ndev);
-	if (ret)
-		return ret;
+	if (info->gptp || info->ccc_gac) {
+		/* Set GTI value */
+		ret = ravb_set_gti(ndev);
+		if (ret)
+			return ret;
 
-	/* Request GTI loading */
-	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+		/* Request GTI loading */
+		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+	}
 
 	if (info->internal_delay)
 		ravb_set_delay_mode(ndev);
-- 
2.51.0


