Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B56FA838
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjEHKiw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjEHKi3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A78226760
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59C660F9B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB88EC4339E;
        Mon,  8 May 2023 10:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542307;
        bh=1mLyHeASdB4L6W3qhb7YTJH6BEjeDBdUL0/BnVdGLr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSUcpeLSJThJ83SZ1w4vwPMOQs2VRZWyRuaG0oY4jnUZgY+tX4HXaGEbA9ucPOS0/
         XJ0Eg1LwBfGvzb05eFQvqJdbkLVEec8m55zG3d/NTAemXeuWV1DzmVRrHAF8YIF0/L
         mOll3cAJrUCj2dx5BD3B16MmppkFZG+3OGSHJjGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 394/663] wifi: mt76: mt7996: let non-bufferable MMPDUs use correct hw queue
Date:   Mon,  8 May 2023 11:43:40 +0200
Message-Id: <20230508094440.879996070@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shayne Chen <shayne.chen@mediatek.com>

[ Upstream commit d0b6f86fdbefa62fd4ad2acd1aea6c45f9b518ba ]

Pass qid into mt7996_mac_write_txwi() to let the tx descriptor of
non-bufferable MMPDUs be filled with correct hw queue index.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c    | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  5 +++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index c4567641210b1..17f0b287507d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -962,8 +962,9 @@ mt7996_mac_write_txwi_80211(struct mt7996_dev *dev, __le32 *txwi,
 }
 
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
-			   struct ieee80211_key_conf *key, u32 changed)
+			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key, int pid,
+			   enum mt76_txq_id qid, u32 changed)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
@@ -994,7 +995,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 	} else if (beacon) {
 		p_fmt = MT_TX_TYPE_FW;
 		q_idx = MT_LMAC_BCN0;
-	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
+	} else if (qid >= MT_TXQ_PSD) {
 		p_fmt = MT_TX_TYPE_CT;
 		q_idx = MT_LMAC_ALTX0;
 	} else {
@@ -1103,8 +1104,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	memset(txwi_ptr, 0, MT_TXD_SIZE);
 	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
 	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid,
-				      key, 0);
+		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
+				      pid, qid, 0);
 
 	txp = (struct mt7996_txp *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index d593ed9e3f73c..18c4e7bc4370d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1804,8 +1804,9 @@ mt7996_mcu_beacon_cont(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	buf = (u8 *)bcn + sizeof(*bcn) - MAX_BEACON_SIZE;
-	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
+	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0,
 			      BSS_CHANGED_BEACON);
+
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 }
 
@@ -1995,8 +1996,7 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 
 	buf = (u8 *)tlv + sizeof(*discov) - MAX_INBAND_FRAME_SIZE;
 
-	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, 0, NULL,
-			      changed);
+	mt7996_mac_write_txwi(dev, (__le32 *)buf, skb, wcid, NULL, 0, 0, changed);
 
 	memcpy(buf + MT_TXD_SIZE, skb->data, skb->len);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 725344791b4cd..e8eedae78479f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -472,8 +472,9 @@ void mt7996_mac_enable_nf(struct mt7996_dev *dev, u8 band);
 void mt7996_mac_enable_rtscts(struct mt7996_dev *dev,
 			      struct ieee80211_vif *vif, bool enable);
 void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
-			   struct sk_buff *skb, struct mt76_wcid *wcid, int pid,
-			   struct ieee80211_key_conf *key, u32 changed);
+			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key, int pid,
+			   enum mt76_txq_id qid, u32 changed);
 void mt7996_mac_set_timing(struct mt7996_phy *phy);
 int mt7996_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
-- 
2.39.2



