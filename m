Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E816679BB95
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbjIKV4y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbjIKOeW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:34:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC51DE4D
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:34:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6ABC433C7;
        Mon, 11 Sep 2023 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442857;
        bh=5zOmlCbZrPaOrIgOGPRrEvssBlEVDdJ5qRLc82X4hwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6F8EV+miVeTCDaSK+ky2v2hO8ft7LskwaAu+A7EcJ0T7zJVHOEfney9m6zJwZZ6Z
         GE8JZn3L8MT0sNaaWdF9rwd+1Z9fghB7zQR7V4aAc04saWn8G/dXh0khyFMJ8cyczt
         oaDcexS9MHlp7vQu1s0ajDprx9gMRR8MHHWmkExE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 172/737] wifi: mt76: mt7915: fix capabilities in non-AP mode
Date:   Mon, 11 Sep 2023 15:40:31 +0200
Message-ID: <20230911134655.332460567@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 02a894046d5ab7d0010f39ea54fde7e167919d04 ]

Capabilities in vif->bss_conf are only initialized in AP mode.
For other modes, they should be enabled by default, in order to avoid a
mismatch.

Fixes: 885f7af7e544 ("wifi: mt76: mt7915: remove mt7915_mcu_beacon_check_caps()")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 21 +++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 27 ++++++++++---------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 14 ++++++++++
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 13d429bd44e28..ed345a0b931e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -269,6 +269,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
 
 	mt7915_init_bitrate_mask(vif);
+	memset(&mvif->cap, -1, sizeof(mvif->cap));
 
 	mt7915_mcu_add_bss_info(phy, vif, true);
 	mt7915_mcu_add_sta(dev, vif, NULL, true);
@@ -657,6 +658,24 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static void
+mt7915_vif_check_caps(struct mt7915_phy *phy, struct ieee80211_vif *vif)
+{
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
+	struct mt7915_vif_cap *vc = &mvif->cap;
+
+	vc->ht_ldpc = vif->bss_conf.ht_ldpc;
+	vc->vht_ldpc = vif->bss_conf.vht_ldpc;
+	vc->vht_su_ebfer = vif->bss_conf.vht_su_beamformer;
+	vc->vht_su_ebfee = vif->bss_conf.vht_su_beamformee;
+	vc->vht_mu_ebfer = vif->bss_conf.vht_mu_beamformer;
+	vc->vht_mu_ebfee = vif->bss_conf.vht_mu_beamformee;
+	vc->he_ldpc = vif->bss_conf.he_ldpc;
+	vc->he_su_ebfer = vif->bss_conf.he_su_beamformer;
+	vc->he_su_ebfee = vif->bss_conf.he_su_beamformee;
+	vc->he_mu_ebfer = vif->bss_conf.he_mu_beamformer;
+}
+
 static int
 mt7915_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_bss_conf *link_conf)
@@ -667,6 +686,8 @@ mt7915_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mt76.mutex);
 
+	mt7915_vif_check_caps(phy, vif);
+
 	err = mt7915_mcu_add_bss_info(phy, vif, true);
 	if (err)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 8da9c87e98042..a325066bf57e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -710,6 +710,7 @@ static void
 mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 		      struct ieee80211_vif *vif)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
 	struct ieee80211_he_mcs_nss_supp mcs_map;
 	struct sta_rec_he *he;
@@ -743,7 +744,7 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_RU_MAPPING_IN_5G))
 		cap |= STA_REC_HE_CAP_BW20_RU242_SUPPORT;
 
-	if (vif->bss_conf.he_ldpc &&
+	if (mvif->cap.he_ldpc &&
 	    (elem->phy_cap_info[1] &
 	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		cap |= STA_REC_HE_CAP_LDPC;
@@ -852,6 +853,7 @@ static void
 mt7915_mcu_sta_muru_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 			struct ieee80211_sta *sta, struct ieee80211_vif *vif)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct ieee80211_he_cap_elem *elem = &sta->deflink.he_cap.he_cap_elem;
 	struct sta_rec_muru *muru;
 	struct tlv *tlv;
@@ -864,9 +866,9 @@ mt7915_mcu_sta_muru_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	muru = (struct sta_rec_muru *)tlv;
 
-	muru->cfg.mimo_dl_en = vif->bss_conf.he_mu_beamformer ||
-			       vif->bss_conf.vht_mu_beamformer ||
-			       vif->bss_conf.vht_mu_beamformee;
+	muru->cfg.mimo_dl_en = mvif->cap.he_mu_ebfer ||
+			       mvif->cap.vht_mu_ebfer ||
+			       mvif->cap.vht_mu_ebfee;
 	if (!is_mt7915(&dev->mt76))
 		muru->cfg.mimo_ul_en = true;
 	muru->cfg.ofdma_dl_en = true;
@@ -999,8 +1001,8 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, wcid, tlv, wtbl_hdr);
 	if (sta)
 		mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, skb, sta, tlv,
-					    wtbl_hdr, vif->bss_conf.ht_ldpc,
-					    vif->bss_conf.vht_ldpc);
+					    wtbl_hdr, mvif->cap.ht_ldpc,
+					    mvif->cap.vht_ldpc);
 
 	return 0;
 }
@@ -1009,6 +1011,7 @@ static inline bool
 mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool bfee)
 {
+	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	int tx_ant = hweight8(phy->mt76->chainmask) - 1;
 
 	if (vif->type != NL80211_IFTYPE_STATION &&
@@ -1022,10 +1025,10 @@ mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		struct ieee80211_he_cap_elem *pe = &sta->deflink.he_cap.he_cap_elem;
 
 		if (bfee)
-			return vif->bss_conf.he_su_beamformee &&
+			return mvif->cap.he_su_ebfee &&
 			       HE_PHY(CAP3_SU_BEAMFORMER, pe->phy_cap_info[3]);
 		else
-			return vif->bss_conf.he_su_beamformer &&
+			return mvif->cap.he_su_ebfer &&
 			       HE_PHY(CAP4_SU_BEAMFORMEE, pe->phy_cap_info[4]);
 	}
 
@@ -1033,10 +1036,10 @@ mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 		u32 cap = sta->deflink.vht_cap.cap;
 
 		if (bfee)
-			return vif->bss_conf.vht_su_beamformee &&
+			return mvif->cap.vht_su_ebfee &&
 			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
 		else
-			return vif->bss_conf.vht_su_beamformer &&
+			return mvif->cap.vht_su_ebfer &&
 			       (cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
 	}
 
@@ -1531,7 +1534,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_TX_STBC;
 		if (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_RX_STBC)
 			cap |= STA_CAP_RX_STBC;
-		if (vif->bss_conf.ht_ldpc &&
+		if (mvif->cap.ht_ldpc &&
 		    (sta->deflink.ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING))
 			cap |= STA_CAP_LDPC;
 
@@ -1557,7 +1560,7 @@ mt7915_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb, struct mt7915_dev *dev,
 			cap |= STA_CAP_VHT_TX_STBC;
 		if (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXSTBC_1)
 			cap |= STA_CAP_VHT_RX_STBC;
-		if (vif->bss_conf.vht_ldpc &&
+		if (mvif->cap.vht_ldpc &&
 		    (sta->deflink.vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC))
 			cap |= STA_CAP_VHT_LDPC;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3053f4abf7dbe..0f76733c9c1ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -147,9 +147,23 @@ struct mt7915_sta {
 	} twt;
 };
 
+struct mt7915_vif_cap {
+	bool ht_ldpc:1;
+	bool vht_ldpc:1;
+	bool he_ldpc:1;
+	bool vht_su_ebfer:1;
+	bool vht_su_ebfee:1;
+	bool vht_mu_ebfer:1;
+	bool vht_mu_ebfee:1;
+	bool he_su_ebfer:1;
+	bool he_su_ebfee:1;
+	bool he_mu_ebfer:1;
+};
+
 struct mt7915_vif {
 	struct mt76_vif mt76; /* must be first */
 
+	struct mt7915_vif_cap cap;
 	struct mt7915_sta sta;
 	struct mt7915_phy *phy;
 
-- 
2.40.1



