Return-Path: <stable+bounces-70478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84FA960E55
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297751F23D52
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E111C6888;
	Tue, 27 Aug 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uo2ADVtM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF71C57BC;
	Tue, 27 Aug 2024 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770039; cv=none; b=Aca7ud/QxWGefrosr3AgNtKOpTWKSnbG3IL933mwl8hWEqHZorU397M74VkaTL0Z60LlDic2jcsr6A1WBdlCOjVSIqGmdRr0wzZh3wUipieoGhApNgl623VmU7fgGDJI70/gBM01GR9feU5dhvdnwKWZdXsRTUUZMirbWhkQqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770039; c=relaxed/simple;
	bh=cVS3yhCNrZ/+adeTf7Zs4KNOrPuBqiKuUdGnAofJ35A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoP1/Ivc7ieBv4QdsZv2AAU2e7nNcSvKP4dx5SzBU34VCIcrx8ZqtiRavdfEczAS5VyMm/UChcvrgUhFMuDGSHNgTMhVQirWRq9YDmqMtFPu019WctCQwA22NWLCu6WzVNg9jG9fYomJfvc6KzzlHYFBx3jrH1mNQeOAmpKWk5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uo2ADVtM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BB6C4AF11;
	Tue, 27 Aug 2024 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724770039;
	bh=cVS3yhCNrZ/+adeTf7Zs4KNOrPuBqiKuUdGnAofJ35A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uo2ADVtMobTu2QkYYHpMkBSsUZM2JaHHiMusYwAhmlOzDhQtlZA4Su7tcwI6FwNLj
	 dKVBStG/44BSz1G4jJ+bxapoKIbgJkfOMTxbWe5bPZkK40DmHKthayBGvriMwHSHtX
	 eQtcYOo1yHopD+HgJcvBLZGmRbDR8glJfg42stTE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryder Lee <Ryder.Lee@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 109/341] wifi: mt76: fix race condition related to checking tx queue fill status
Date: Tue, 27 Aug 2024 16:35:40 +0200
Message-ID: <20240827143847.558981607@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 0335c034e7265d36d956e806f33202c94a8a9860 ]

When drv_tx calls race against local tx scheduling, the queue fill status checks
can potentially race, leading to dma queue entries being overwritten.
Fix this by deferring packets from drv_tx calls to the tx worker, in order to
ensure that all regular queue tx comes from the same context.

Reported-by: Ryder Lee <Ryder.Lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  50 +++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  24 ++--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   4 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 108 ++++++++++++++----
 10 files changed, 155 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index dbab400969202..85bffcf4f6fbf 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -415,6 +415,9 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	struct mt76_dev *dev = phy->dev;
 	struct wiphy *wiphy = hw->wiphy;
 
+	INIT_LIST_HEAD(&phy->tx_list);
+	spin_lock_init(&phy->tx_lock);
+
 	SET_IEEE80211_DEV(hw, dev->dev);
 	SET_IEEE80211_PERM_ADDR(hw, phy->macaddr);
 
@@ -688,6 +691,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	int ret;
 
 	dev_set_drvdata(dev->dev, dev);
+	mt76_wcid_init(&dev->global_wcid);
 	ret = mt76_phy_init(phy, hw);
 	if (ret)
 		return ret;
@@ -743,6 +747,7 @@ void mt76_unregister_device(struct mt76_dev *dev)
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
 		mt76_led_cleanup(&dev->phy);
 	mt76_tx_status_check(dev, true);
+	mt76_wcid_cleanup(dev, &dev->global_wcid);
 	ieee80211_unregister_hw(hw);
 }
 EXPORT_SYMBOL_GPL(mt76_unregister_device);
@@ -1411,7 +1416,7 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	wcid->phy_idx = phy->band_idx;
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 
-	mt76_packet_id_init(wcid);
+	mt76_wcid_init(wcid);
 out:
 	mutex_unlock(&dev->mutex);
 
@@ -1430,7 +1435,7 @@ void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	if (dev->drv->sta_remove)
 		dev->drv->sta_remove(dev, vif, sta);
 
-	mt76_packet_id_flush(dev, wcid);
+	mt76_wcid_cleanup(dev, wcid);
 
 	mt76_wcid_mask_clear(dev->wcid_mask, idx);
 	mt76_wcid_mask_clear(dev->wcid_phy_mask, idx);
@@ -1486,6 +1491,47 @@ void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_sta_pre_rcu_remove);
 
+void mt76_wcid_init(struct mt76_wcid *wcid)
+{
+	INIT_LIST_HEAD(&wcid->tx_list);
+	skb_queue_head_init(&wcid->tx_pending);
+
+	INIT_LIST_HEAD(&wcid->list);
+	idr_init(&wcid->pktid);
+}
+EXPORT_SYMBOL_GPL(mt76_wcid_init);
+
+void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
+{
+	struct mt76_phy *phy = dev->phys[wcid->phy_idx];
+	struct ieee80211_hw *hw;
+	struct sk_buff_head list;
+	struct sk_buff *skb;
+
+	mt76_tx_status_lock(dev, &list);
+	mt76_tx_status_skb_get(dev, wcid, -1, &list);
+	mt76_tx_status_unlock(dev, &list);
+
+	idr_destroy(&wcid->pktid);
+
+	spin_lock_bh(&phy->tx_lock);
+
+	if (!list_empty(&wcid->tx_list))
+		list_del_init(&wcid->tx_list);
+
+	spin_lock(&wcid->tx_pending.lock);
+	skb_queue_splice_tail_init(&wcid->tx_pending, &list);
+	spin_unlock(&wcid->tx_pending.lock);
+
+	spin_unlock_bh(&phy->tx_lock);
+
+	while ((skb = __skb_dequeue(&list)) != NULL) {
+		hw = mt76_tx_status_get_hw(dev, skb);
+		ieee80211_free_txskb(hw, skb);
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_wcid_cleanup);
+
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     int *dbm)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 7f44736ca26f0..8b620d4fed439 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -334,6 +334,9 @@ struct mt76_wcid {
 	u32 tx_info;
 	bool sw_iv;
 
+	struct list_head tx_list;
+	struct sk_buff_head tx_pending;
+
 	struct list_head list;
 	struct idr pktid;
 
@@ -719,6 +722,8 @@ struct mt76_phy {
 	unsigned long state;
 	u8 band_idx;
 
+	spinlock_t tx_lock;
+	struct list_head tx_list;
 	struct mt76_queue *q_tx[__MT_TXQ_MAX];
 
 	struct cfg80211_chan_def chandef;
@@ -1599,22 +1604,7 @@ mt76_token_put(struct mt76_dev *dev, int token)
 	return txwi;
 }
 
-static inline void mt76_packet_id_init(struct mt76_wcid *wcid)
-{
-	INIT_LIST_HEAD(&wcid->list);
-	idr_init(&wcid->pktid);
-}
-
-static inline void
-mt76_packet_id_flush(struct mt76_dev *dev, struct mt76_wcid *wcid)
-{
-	struct sk_buff_head list;
-
-	mt76_tx_status_lock(dev, &list);
-	mt76_tx_status_skb_get(dev, wcid, -1, &list);
-	mt76_tx_status_unlock(dev, &list);
-
-	idr_destroy(&wcid->pktid);
-}
+void mt76_wcid_init(struct mt76_wcid *wcid);
+void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index c213fd2a5216b..89d738deea62e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -70,7 +70,7 @@ mt7603_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.vif = mvif;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	eth_broadcast_addr(bc_addr);
 	mt7603_wtbl_init(dev, idx, mvif->idx, bc_addr);
@@ -110,7 +110,7 @@ mt7603_remove_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	dev->mt76.vif_mask &= ~BIT_ULL(mvif->idx);
 	mutex_unlock(&dev->mt76.mutex);
 
-	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
+	mt76_wcid_cleanup(&dev->mt76, &mvif->sta.wcid);
 }
 
 void mt7603_init_edcca(struct mt7603_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 200b1752ca77f..dab16b5fc3861 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -226,7 +226,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7615_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -279,7 +279,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_packet_id_flush(&dev->mt76, &mvif->sta.wcid);
+	mt76_wcid_cleanup(&dev->mt76, &mvif->sta.wcid);
 }
 
 int mt7615_set_channel(struct mt7615_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index dcbb5c605dfe6..8a0e8124b8940 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -288,7 +288,7 @@ mt76x02_vif_init(struct mt76x02_dev *dev, struct ieee80211_vif *vif,
 	mvif->idx = idx;
 	mvif->group_wcid.idx = MT_VIF_WCID(idx);
 	mvif->group_wcid.hw_key_idx = -1;
-	mt76_packet_id_init(&mvif->group_wcid);
+	mt76_wcid_init(&mvif->group_wcid);
 
 	mtxq = (struct mt76_txq *)vif->txq->drv_priv;
 	rcu_assign_pointer(dev->mt76.wcid[MT_VIF_WCID(idx)], &mvif->group_wcid);
@@ -346,7 +346,7 @@ void mt76x02_remove_interface(struct ieee80211_hw *hw,
 
 	dev->mt76.vif_mask &= ~BIT_ULL(mvif->idx);
 	rcu_assign_pointer(dev->mt76.wcid[mvif->group_wcid.idx], NULL);
-	mt76_packet_id_flush(&dev->mt76, &mvif->group_wcid);
+	mt76_wcid_cleanup(&dev->mt76, &mvif->group_wcid);
 }
 EXPORT_SYMBOL_GPL(mt76x02_remove_interface);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3196f56cdf4ab..260fe00d7dc6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -253,7 +253,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.phy_idx = ext_phy;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7915_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -314,7 +314,7 @@ static void mt7915_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 
 int mt7915_set_channel(struct mt7915_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index d8851cb5f400b..6a5c2cae087d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -318,7 +318,7 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	mvif->sta.wcid.phy_idx = mvif->mt76.band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7921_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 2fb1141e5fa96..66806ed4f942d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -115,7 +115,7 @@ void mt792x_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 EXPORT_SYMBOL_GPL(mt792x_remove_interface);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 620880e560e00..7fea9f0d409bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -207,7 +207,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	mvif->sta.wcid.phy_idx = band_idx;
 	mvif->sta.wcid.hw_key_idx = -1;
 	mvif->sta.wcid.tx_info |= MT_WCID_TX_INFO_SET;
-	mt76_packet_id_init(&mvif->sta.wcid);
+	mt76_wcid_init(&mvif->sta.wcid);
 
 	mt7996_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
@@ -268,7 +268,7 @@ static void mt7996_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->wcid.poll_list);
 	spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
-	mt76_packet_id_flush(&dev->mt76, &msta->wcid);
+	mt76_wcid_cleanup(&dev->mt76, &msta->wcid);
 }
 
 int mt7996_set_channel(struct mt7996_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 6cc26cc6c5178..1809b03292c3d 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -329,40 +329,32 @@ void
 mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 	struct mt76_wcid *wcid, struct sk_buff *skb)
 {
-	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct mt76_queue *q;
-	int qid = skb_get_queue_mapping(skb);
 
 	if (mt76_testmode_enabled(phy)) {
 		ieee80211_free_txskb(phy->hw, skb);
 		return;
 	}
 
-	if (WARN_ON(qid >= MT_TXQ_PSD)) {
-		qid = MT_TXQ_BE;
-		skb_set_queue_mapping(skb, qid);
-	}
-
-	if ((dev->drv->drv_flags & MT_DRV_HW_MGMT_TXQ) &&
-	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
-	    !ieee80211_is_data(hdr->frame_control) &&
-	    !ieee80211_is_bufferable_mmpdu(skb)) {
-		qid = MT_TXQ_PSD;
-	}
+	if (WARN_ON(skb_get_queue_mapping(skb) >= MT_TXQ_PSD))
+		skb_set_queue_mapping(skb, MT_TXQ_BE);
 
 	if (wcid && !(wcid->tx_info & MT_WCID_TX_INFO_SET))
 		ieee80211_get_tx_rates(info->control.vif, sta, skb,
 				       info->control.rates, 1);
 
 	info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
-	q = phy->q_tx[qid];
 
-	spin_lock_bh(&q->lock);
-	__mt76_tx_queue_skb(phy, qid, skb, wcid, sta, NULL);
-	dev->queue_ops->kick(dev, q);
-	spin_unlock_bh(&q->lock);
+	spin_lock_bh(&wcid->tx_pending.lock);
+	__skb_queue_tail(&wcid->tx_pending, skb);
+	spin_unlock_bh(&wcid->tx_pending.lock);
+
+	spin_lock_bh(&phy->tx_lock);
+	if (list_empty(&wcid->tx_list))
+		list_add_tail(&wcid->tx_list, &phy->tx_list);
+	spin_unlock_bh(&phy->tx_lock);
+
+	mt76_worker_schedule(&phy->dev->tx_worker);
 }
 EXPORT_SYMBOL_GPL(mt76_tx);
 
@@ -593,10 +585,86 @@ void mt76_txq_schedule(struct mt76_phy *phy, enum mt76_txq_id qid)
 }
 EXPORT_SYMBOL_GPL(mt76_txq_schedule);
 
+static int
+mt76_txq_schedule_pending_wcid(struct mt76_phy *phy, struct mt76_wcid *wcid)
+{
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_sta *sta;
+	struct mt76_queue *q;
+	struct sk_buff *skb;
+	int ret = 0;
+
+	spin_lock(&wcid->tx_pending.lock);
+	while ((skb = skb_peek(&wcid->tx_pending)) != NULL) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+		int qid = skb_get_queue_mapping(skb);
+
+		if ((dev->drv->drv_flags & MT_DRV_HW_MGMT_TXQ) &&
+		    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) &&
+		    !ieee80211_is_data(hdr->frame_control) &&
+		    !ieee80211_is_bufferable_mmpdu(skb))
+			qid = MT_TXQ_PSD;
+
+		q = phy->q_tx[qid];
+		if (mt76_txq_stopped(q)) {
+			ret = -1;
+			break;
+		}
+
+		__skb_unlink(skb, &wcid->tx_pending);
+		spin_unlock(&wcid->tx_pending.lock);
+
+		sta = wcid_to_sta(wcid);
+		spin_lock(&q->lock);
+		__mt76_tx_queue_skb(phy, qid, skb, wcid, sta, NULL);
+		dev->queue_ops->kick(dev, q);
+		spin_unlock(&q->lock);
+
+		spin_lock(&wcid->tx_pending.lock);
+	}
+	spin_unlock(&wcid->tx_pending.lock);
+
+	return ret;
+}
+
+static void mt76_txq_schedule_pending(struct mt76_phy *phy)
+{
+	if (list_empty(&phy->tx_list))
+		return;
+
+	local_bh_disable();
+	rcu_read_lock();
+
+	spin_lock(&phy->tx_lock);
+	while (!list_empty(&phy->tx_list)) {
+		struct mt76_wcid *wcid = NULL;
+		int ret;
+
+		wcid = list_first_entry(&phy->tx_list, struct mt76_wcid, tx_list);
+		list_del_init(&wcid->tx_list);
+
+		spin_unlock(&phy->tx_lock);
+		ret = mt76_txq_schedule_pending_wcid(phy, wcid);
+		spin_lock(&phy->tx_lock);
+
+		if (ret) {
+			if (list_empty(&wcid->tx_list))
+				list_add_tail(&wcid->tx_list, &phy->tx_list);
+			break;
+		}
+	}
+	spin_unlock(&phy->tx_lock);
+
+	rcu_read_unlock();
+	local_bh_enable();
+}
+
 void mt76_txq_schedule_all(struct mt76_phy *phy)
 {
 	int i;
 
+	mt76_txq_schedule_pending(phy);
 	for (i = 0; i <= MT_TXQ_BK; i++)
 		mt76_txq_schedule(phy, i);
 }
-- 
2.43.0




