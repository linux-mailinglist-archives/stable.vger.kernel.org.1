Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE77ED4A1
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbjKOU6m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344699AbjKOU5o (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FE6199B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9C6C4167D;
        Wed, 15 Nov 2023 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081268;
        bh=7keaF0ttptvYCFb/Ozf2wPoMeIfMp45UVwK0h0MqhFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCFYvUg0dQkkhZ1qExbSPkaXDRWiGaPpYPAxxM7EvBGylO8B1Uggvn4WXC4zYFjR1
         wVMIzjD4M94pGNv9HFLiNpLTXdcrO+ooKRbOq90jx4ZxRX3CgSBMtas1HwFRX+WaiX
         gd6DN/jT/VgStHNeNVhTc6ab40ds561fZPUg3tdA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 027/244] mt76: pass original queue id from __mt76_tx_queue_skb to the driver
Date:   Wed, 15 Nov 2023 15:33:39 -0500
Message-ID: <20231115203549.998873750@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit d08295f5be8e63e64f9e664572f1b582ede7958b ]

MT7615 and newer map multiple software tx queues to the hardware id

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 317620593349 ("wifi: mt76: mt7603: improve stuck beacon handling")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/dma.c           | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76.h          | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c  | 3 ++-
 drivers/net/wireless/mediatek/mt76/sdio.c          | 6 +++---
 drivers/net/wireless/mediatek/mt76/testmode.c      | 4 ++--
 drivers/net/wireless/mediatek/mt76/tx.c            | 2 +-
 drivers/net/wireless/mediatek/mt76/usb.c           | 6 +++---
 8 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index 71a04c92117a6..f225a34e21861 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -349,8 +349,8 @@ mt76_dma_tx_queue_skb_raw(struct mt76_dev *dev, struct mt76_queue *q,
 
 static int
 mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		      struct sk_buff *skb, struct mt76_wcid *wcid,
-		      struct ieee80211_sta *sta)
+		      enum mt76_txq_id qid, struct sk_buff *skb,
+		      struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct ieee80211_tx_status status = {
 		.sta = sta,
@@ -406,7 +406,7 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 
 	dma_sync_single_for_cpu(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				DMA_TO_DEVICE);
-	ret = dev->drv->tx_prepare_skb(dev, txwi, q->qid, wcid, sta, &tx_info);
+	ret = dev->drv->tx_prepare_skb(dev, txwi, qid, wcid, sta, &tx_info);
 	dma_sync_single_for_device(dev->dma_dev, t->dma_addr, dev->drv->txwi_size,
 				   DMA_TO_DEVICE);
 	if (ret < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 87ae528581bbf..27f04fb2796d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -195,8 +195,8 @@ struct mt76_queue_ops {
 		     u32 ring_base);
 
 	int (*tx_queue_skb)(struct mt76_dev *dev, struct mt76_queue *q,
-			    struct sk_buff *skb, struct mt76_wcid *wcid,
-			    struct ieee80211_sta *sta);
+			    enum mt76_txq_id qid, struct sk_buff *skb,
+			    struct mt76_wcid *wcid, struct ieee80211_sta *sta);
 
 	int (*tx_queue_skb_raw)(struct mt76_dev *dev, struct mt76_queue *q,
 				struct sk_buff *skb, u32 tx_info);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 5d4522f440b74..e35e0a68c6e48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -24,8 +24,8 @@ mt7603_update_beacon_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	if (!skb)
 		return;
 
-	mt76_tx_queue_skb(dev, dev->mphy.q_tx[MT_TXQ_BEACON], skb,
-			  &mvif->sta.wcid, NULL);
+	mt76_tx_queue_skb(dev, dev->mphy.q_tx[MT_TXQ_BEACON],
+			  MT_TXQ_BEACON, skb, &mvif->sta.wcid, NULL);
 
 	spin_lock_bh(&dev->ps_lock);
 	mt76_wr(dev, MT_DMA_FQCR0, MT_DMA_FQCR0_BUSY |
@@ -123,7 +123,7 @@ void mt7603_pre_tbtt_tasklet(struct tasklet_struct *t)
 		struct ieee80211_vif *vif = info->control.vif;
 		struct mt7603_vif *mvif = (struct mt7603_vif *)vif->drv_priv;
 
-		mt76_tx_queue_skb(dev, q, skb, &mvif->sta.wcid, NULL);
+		mt76_tx_queue_skb(dev, q, MT_TXQ_CAB, skb, &mvif->sta.wcid, NULL);
 	}
 	mt76_queue_kick(dev, q);
 	spin_unlock_bh(&q->lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index b50084bbe83de..6ba3a7975e1bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -59,7 +59,8 @@ static void mt76x02_pre_tbtt_tasklet(struct tasklet_struct *t)
 		struct ieee80211_vif *vif = info->control.vif;
 		struct mt76x02_vif *mvif = (struct mt76x02_vif *)vif->drv_priv;
 
-		mt76_tx_queue_skb(dev, q, skb, &mvif->group_wcid, NULL);
+		mt76_tx_queue_skb(dev, q, MT_TXQ_PSD, skb, &mvif->group_wcid,
+				  NULL);
 	}
 	spin_unlock_bh(&q->lock);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wireless/mediatek/mt76/sdio.c
index 9e639d0b9c631..4964f19558be2 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio.c
@@ -243,8 +243,8 @@ static void mt76s_tx_status_data(struct work_struct *work)
 
 static int
 mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		   struct sk_buff *skb, struct mt76_wcid *wcid,
-		   struct ieee80211_sta *sta)
+		   enum mt76_txq_id qid, struct sk_buff *skb,
+		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
@@ -256,7 +256,7 @@ mt76s_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		return -ENOSPC;
 
 	skb->prev = skb->next = NULL;
-	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
+	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/testmode.c b/drivers/net/wireless/mediatek/mt76/testmode.c
index 0109433e8c2fe..12b13946fba18 100644
--- a/drivers/net/wireless/mediatek/mt76/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/testmode.c
@@ -49,8 +49,8 @@ void mt76_testmode_tx_pending(struct mt76_phy *phy)
 	       q->queued < q->ndesc / 2) {
 		int ret;
 
-		ret = dev->queue_ops->tx_queue_skb(dev, q, skb_get(skb), wcid,
-						   NULL);
+		ret = dev->queue_ops->tx_queue_skb(dev, q, qid, skb_get(skb),
+						   wcid, NULL);
 		if (ret < 0)
 			break;
 
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 7d126634547f1..134a735a06329 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -259,7 +259,7 @@ __mt76_tx_queue_skb(struct mt76_phy *phy, int qid, struct sk_buff *skb,
 	int idx;
 
 	non_aql = !info->tx_time_est;
-	idx = dev->queue_ops->tx_queue_skb(dev, q, skb, wcid, sta);
+	idx = dev->queue_ops->tx_queue_skb(dev, q, qid, skb, wcid, sta);
 	if (idx < 0 || !sta)
 		return idx;
 
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index b47343e321b81..392632c3f1b1d 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -901,8 +901,8 @@ mt76u_tx_setup_buffers(struct mt76_dev *dev, struct sk_buff *skb,
 
 static int
 mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
-		   struct sk_buff *skb, struct mt76_wcid *wcid,
-		   struct ieee80211_sta *sta)
+		   enum mt76_txq_id qid, struct sk_buff *skb,
+		   struct mt76_wcid *wcid, struct ieee80211_sta *sta)
 {
 	struct mt76_tx_info tx_info = {
 		.skb = skb,
@@ -914,7 +914,7 @@ mt76u_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 		return -ENOSPC;
 
 	skb->prev = skb->next = NULL;
-	err = dev->drv->tx_prepare_skb(dev, NULL, q->qid, wcid, sta, &tx_info);
+	err = dev->drv->tx_prepare_skb(dev, NULL, qid, wcid, sta, &tx_info);
 	if (err < 0)
 		return err;
 
-- 
2.42.0



