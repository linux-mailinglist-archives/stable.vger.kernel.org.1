Return-Path: <stable+bounces-104827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EC29F532D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB606168AF2
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD891F63D5;
	Tue, 17 Dec 2024 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b4Muq8a1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24214A4E7;
	Tue, 17 Dec 2024 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456224; cv=none; b=MVuU75qv3OH4fSQHFNbGf4E4dFYklILRwsdSO1kGG0Q0YygTXfnOF0t3jFYAjJILyz65QiVArblCkNY2JzsHCgtCuePbBPyWNyPGoYCFnHJkFtSuARpqvJ3/BhFF6qm6JLzJpvapdhY9BRw1R0AV8MxYVcBrJ/DFIJU5/VVA094=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456224; c=relaxed/simple;
	bh=fHatg3Czbaws4tiWwrUqPMdXUfppGgf5bkcwcFFsQv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klmdP2qn9itBvzyxip2aL/sE+tdL1LewDDPKz/wI/Fh080E+6rH6wXUKFGqHSNYoYZwY5QxdoiP00YVOKH7WBy73dvt2TWhVPHu+++Wqn+RqFa4VnYcsiGTseV/U/ZKIAebAofdl178Xun5/Yz7kYsQ8rLu87tf7sjips3Gk4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b4Muq8a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF08C4CED3;
	Tue, 17 Dec 2024 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456224;
	bh=fHatg3Czbaws4tiWwrUqPMdXUfppGgf5bkcwcFFsQv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b4Muq8a1YXPQJC6Qs48sod6+ZFM+rPibG4HsRlpKrtYVHwABGIm5f58U/69O2Esw6
	 zNDUjFTeVV6+uJv+m3olRVlm0hphvA5K3mCkUF6RRpRHwENW3lCX79IjdudBtzQEim
	 kl9FtdGv+J61MhEWoJbYnsNTyoxtRqougpzzCHWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 070/109] net: rswitch: Use build_skb() for RX
Date: Tue, 17 Dec 2024 18:07:54 +0100
Message-ID: <20241217170536.306393834@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170533.329523616@linuxfoundation.org>
References: <20241217170533.329523616@linuxfoundation.org>
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

[ Upstream commit 6a203cb5165d2257e8d54193b69afdb480a17f6f ]

If this hardware receives a jumbo frame like 2KiB or more, it will be
split into multiple queues. In the near future, to support this, use
build_skb() instead of netdev_alloc_skb_ip_align().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 0c9547e6ccf4 ("net: renesas: rswitch: fix race window between tx start and complete")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/renesas/rswitch.c | 73 +++++++++++++++-----------
 drivers/net/ethernet/renesas/rswitch.h | 19 ++++++-
 2 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index d10af779ee89..989cfc86098f 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -234,19 +234,18 @@ static bool rswitch_is_queue_rxed(struct rswitch_gwca_queue *gq)
 	return false;
 }
 
-static int rswitch_gwca_queue_alloc_skb(struct rswitch_gwca_queue *gq,
-					unsigned int start_index,
-					unsigned int num)
+static int rswitch_gwca_queue_alloc_rx_buf(struct rswitch_gwca_queue *gq,
+					   unsigned int start_index,
+					   unsigned int num)
 {
 	unsigned int i, index;
 
 	for (i = 0; i < num; i++) {
 		index = (i + start_index) % gq->ring_size;
-		if (gq->skbs[index])
+		if (gq->rx_bufs[index])
 			continue;
-		gq->skbs[index] = netdev_alloc_skb_ip_align(gq->ndev,
-							    PKT_BUF_SZ + RSWITCH_ALIGN - 1);
-		if (!gq->skbs[index])
+		gq->rx_bufs[index] = netdev_alloc_frag(RSWITCH_BUF_SIZE);
+		if (!gq->rx_bufs[index])
 			goto err;
 	}
 
@@ -255,8 +254,8 @@ static int rswitch_gwca_queue_alloc_skb(struct rswitch_gwca_queue *gq,
 err:
 	for (; i-- > 0; ) {
 		index = (i + start_index) % gq->ring_size;
-		dev_kfree_skb(gq->skbs[index]);
-		gq->skbs[index] = NULL;
+		skb_free_frag(gq->rx_bufs[index]);
+		gq->rx_bufs[index] = NULL;
 	}
 
 	return -ENOMEM;
@@ -274,16 +273,17 @@ static void rswitch_gwca_queue_free(struct net_device *ndev,
 		gq->rx_ring = NULL;
 
 		for (i = 0; i < gq->ring_size; i++)
-			dev_kfree_skb(gq->skbs[i]);
+			skb_free_frag(gq->rx_bufs[i]);
+		kfree(gq->rx_bufs);
+		gq->rx_bufs = NULL;
 	} else {
 		dma_free_coherent(ndev->dev.parent,
 				  sizeof(struct rswitch_ext_desc) *
 				  (gq->ring_size + 1), gq->tx_ring, gq->ring_dma);
 		gq->tx_ring = NULL;
+		kfree(gq->skbs);
+		gq->skbs = NULL;
 	}
-
-	kfree(gq->skbs);
-	gq->skbs = NULL;
 }
 
 static void rswitch_gwca_ts_queue_free(struct rswitch_private *priv)
@@ -307,17 +307,20 @@ static int rswitch_gwca_queue_alloc(struct net_device *ndev,
 	gq->ring_size = ring_size;
 	gq->ndev = ndev;
 
-	gq->skbs = kcalloc(gq->ring_size, sizeof(*gq->skbs), GFP_KERNEL);
-	if (!gq->skbs)
-		return -ENOMEM;
-
 	if (!dir_tx) {
-		rswitch_gwca_queue_alloc_skb(gq, 0, gq->ring_size);
+		gq->rx_bufs = kcalloc(gq->ring_size, sizeof(*gq->rx_bufs), GFP_KERNEL);
+		if (!gq->rx_bufs)
+			return -ENOMEM;
+		if (rswitch_gwca_queue_alloc_rx_buf(gq, 0, gq->ring_size) < 0)
+			goto out;
 
 		gq->rx_ring = dma_alloc_coherent(ndev->dev.parent,
 						 sizeof(struct rswitch_ext_ts_desc) *
 						 (gq->ring_size + 1), &gq->ring_dma, GFP_KERNEL);
 	} else {
+		gq->skbs = kcalloc(gq->ring_size, sizeof(*gq->skbs), GFP_KERNEL);
+		if (!gq->skbs)
+			return -ENOMEM;
 		gq->tx_ring = dma_alloc_coherent(ndev->dev.parent,
 						 sizeof(struct rswitch_ext_desc) *
 						 (gq->ring_size + 1), &gq->ring_dma, GFP_KERNEL);
@@ -366,12 +369,13 @@ static int rswitch_gwca_queue_format(struct net_device *ndev,
 	for (i = 0, desc = gq->tx_ring; i < gq->ring_size; i++, desc++) {
 		if (!gq->dir_tx) {
 			dma_addr = dma_map_single(ndev->dev.parent,
-						  gq->skbs[i]->data, PKT_BUF_SZ,
+						  gq->rx_bufs[i] + RSWITCH_HEADROOM,
+						  RSWITCH_MAP_BUF_SIZE,
 						  DMA_FROM_DEVICE);
 			if (dma_mapping_error(ndev->dev.parent, dma_addr))
 				goto err;
 
-			desc->desc.info_ds = cpu_to_le16(PKT_BUF_SZ);
+			desc->desc.info_ds = cpu_to_le16(RSWITCH_DESC_BUF_SIZE);
 			rswitch_desc_set_dptr(&desc->desc, dma_addr);
 			desc->desc.die_dt = DT_FEMPTY | DIE;
 		} else {
@@ -394,8 +398,8 @@ static int rswitch_gwca_queue_format(struct net_device *ndev,
 	if (!gq->dir_tx) {
 		for (desc = gq->tx_ring; i-- > 0; desc++) {
 			dma_addr = rswitch_desc_get_dptr(&desc->desc);
-			dma_unmap_single(ndev->dev.parent, dma_addr, PKT_BUF_SZ,
-					 DMA_FROM_DEVICE);
+			dma_unmap_single(ndev->dev.parent, dma_addr,
+					 RSWITCH_MAP_BUF_SIZE, DMA_FROM_DEVICE);
 		}
 	}
 
@@ -432,12 +436,13 @@ static int rswitch_gwca_queue_ext_ts_fill(struct net_device *ndev,
 		desc = &gq->rx_ring[index];
 		if (!gq->dir_tx) {
 			dma_addr = dma_map_single(ndev->dev.parent,
-						  gq->skbs[index]->data, PKT_BUF_SZ,
+						  gq->rx_bufs[index] + RSWITCH_HEADROOM,
+						  RSWITCH_MAP_BUF_SIZE,
 						  DMA_FROM_DEVICE);
 			if (dma_mapping_error(ndev->dev.parent, dma_addr))
 				goto err;
 
-			desc->desc.info_ds = cpu_to_le16(PKT_BUF_SZ);
+			desc->desc.info_ds = cpu_to_le16(RSWITCH_DESC_BUF_SIZE);
 			rswitch_desc_set_dptr(&desc->desc, dma_addr);
 			dma_wmb();
 			desc->desc.die_dt = DT_FEMPTY | DIE;
@@ -455,8 +460,8 @@ static int rswitch_gwca_queue_ext_ts_fill(struct net_device *ndev,
 			index = (i + start_index) % gq->ring_size;
 			desc = &gq->rx_ring[index];
 			dma_addr = rswitch_desc_get_dptr(&desc->desc);
-			dma_unmap_single(ndev->dev.parent, dma_addr, PKT_BUF_SZ,
-					 DMA_FROM_DEVICE);
+			dma_unmap_single(ndev->dev.parent, dma_addr,
+					 RSWITCH_MAP_BUF_SIZE, DMA_FROM_DEVICE);
 		}
 	}
 
@@ -723,10 +728,15 @@ static bool rswitch_rx(struct net_device *ndev, int *quota)
 	while ((desc->desc.die_dt & DT_MASK) != DT_FEMPTY) {
 		dma_rmb();
 		pkt_len = le16_to_cpu(desc->desc.info_ds) & RX_DS;
-		skb = gq->skbs[gq->cur];
-		gq->skbs[gq->cur] = NULL;
 		dma_addr = rswitch_desc_get_dptr(&desc->desc);
-		dma_unmap_single(ndev->dev.parent, dma_addr, PKT_BUF_SZ, DMA_FROM_DEVICE);
+		dma_unmap_single(ndev->dev.parent, dma_addr,
+				 RSWITCH_MAP_BUF_SIZE, DMA_FROM_DEVICE);
+		skb = build_skb(gq->rx_bufs[gq->cur], RSWITCH_BUF_SIZE);
+		if (!skb)
+			goto out;
+		skb_reserve(skb, RSWITCH_HEADROOM);
+		skb_put(skb, pkt_len);
+
 		get_ts = rdev->priv->ptp_priv->tstamp_rx_ctrl & RCAR_GEN4_RXTSTAMP_TYPE_V2_L2_EVENT;
 		if (get_ts) {
 			struct skb_shared_hwtstamps *shhwtstamps;
@@ -738,12 +748,13 @@ static bool rswitch_rx(struct net_device *ndev, int *quota)
 			ts.tv_nsec = __le32_to_cpu(desc->ts_nsec & cpu_to_le32(0x3fffffff));
 			shhwtstamps->hwtstamp = timespec64_to_ktime(ts);
 		}
-		skb_put(skb, pkt_len);
 		skb->protocol = eth_type_trans(skb, ndev);
 		napi_gro_receive(&rdev->napi, skb);
 		rdev->ndev->stats.rx_packets++;
 		rdev->ndev->stats.rx_bytes += pkt_len;
 
+out:
+		gq->rx_bufs[gq->cur] = NULL;
 		gq->cur = rswitch_next_queue_index(gq, true, 1);
 		desc = &gq->rx_ring[gq->cur];
 
@@ -752,7 +763,7 @@ static bool rswitch_rx(struct net_device *ndev, int *quota)
 	}
 
 	num = rswitch_get_num_cur_queues(gq);
-	ret = rswitch_gwca_queue_alloc_skb(gq, gq->dirty, num);
+	ret = rswitch_gwca_queue_alloc_rx_buf(gq, gq->dirty, num);
 	if (ret < 0)
 		goto err;
 	ret = rswitch_gwca_queue_ext_ts_fill(ndev, gq, gq->dirty, num);
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 542328959530..e62c28a442b9 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -29,8 +29,13 @@
 #define RX_RING_SIZE		1024
 #define TS_RING_SIZE		(TX_RING_SIZE * RSWITCH_NUM_PORTS)
 
-#define PKT_BUF_SZ		1584
+#define RSWITCH_HEADROOM	(NET_SKB_PAD + NET_IP_ALIGN)
+#define RSWITCH_DESC_BUF_SIZE	2048
+#define RSWITCH_TAILROOM	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
 #define RSWITCH_ALIGN		128
+#define RSWITCH_BUF_SIZE	(RSWITCH_HEADROOM + RSWITCH_DESC_BUF_SIZE + \
+				 RSWITCH_TAILROOM + RSWITCH_ALIGN)
+#define RSWITCH_MAP_BUF_SIZE	(RSWITCH_BUF_SIZE - RSWITCH_HEADROOM)
 #define RSWITCH_MAX_CTAG_PCP	7
 
 #define RSWITCH_TIMEOUT_US	100000
@@ -945,8 +950,18 @@ struct rswitch_gwca_queue {
 	/* For [rt]x_ring */
 	unsigned int index;
 	bool dir_tx;
-	struct sk_buff **skbs;
 	struct net_device *ndev;	/* queue to ndev for irq */
+
+	union {
+		/* For TX */
+		struct {
+			struct sk_buff **skbs;
+		};
+		/* For RX */
+		struct {
+			void **rx_bufs;
+		};
+	};
 };
 
 struct rswitch_gwca_ts_info {
-- 
2.39.5




