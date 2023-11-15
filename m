Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC57ECD69
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjKOTgd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjKOTgZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990649E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7C8C433C8;
        Wed, 15 Nov 2023 19:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076982;
        bh=RBuHHBR9UDHlapYKZyNnkHzAJYa4Siz7Cjz0n/K5m00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gHkO8AMA5h/ipoB+WHL2z3uIvgc+X2+MH6GQ6nnTuMD/ikLSfLYHY0fPgAwkNGsXN
         +q1ZVoV8QRMEqvxp0ZWnRUM5vFz7xHMNIecwBfq3xHkzarDX1eKIr5CZVFNGtkdY+5
         FT92YzjC8PV+bKS0lNzaDJIultDzObY7H7beG3NA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Chiu <chui-hao.chiu@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 086/603] wifi: mt76: mt7996: fix wmm queue mapping
Date:   Wed, 15 Nov 2023 14:10:31 -0500
Message-ID: <20231115191619.083855333@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit 9b11696e5c5bf6030a32571f3f88845226d8b662 ]

Firmware uses access class index (ACI) for wmm parameters update, so
convert mac80211 queue to ACI in mt7996_conf_tx().

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c  |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index c3a479dc3f533..600010cdb94e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -190,7 +190,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	mvif->mt76.omac_idx = idx;
 	mvif->phy = phy;
 	mvif->mt76.band_idx = band_idx;
-	mvif->mt76.wmm_idx = band_idx;
+	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
 
 	ret = mt7996_mcu_add_dev_info(phy, vif, true);
 	if (ret)
@@ -414,10 +414,16 @@ mt7996_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	       const struct ieee80211_tx_queue_params *params)
 {
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
+	const u8 mq_to_aci[] = {
+		[IEEE80211_AC_VO] = 3,
+		[IEEE80211_AC_VI] = 2,
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+	};
 
+	/* firmware uses access class index */
+	mvif->queue_params[mq_to_aci[queue]] = *params;
 	/* no need to update right away, we'll get BSS_CHANGED_QOS */
-	queue = mt76_connac_lmac_mapping(queue);
-	mvif->queue_params[queue] = *params;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 4ed1643818980..cf443748ef7cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2679,7 +2679,7 @@ int mt7996_mcu_set_tx(struct mt7996_dev *dev, struct ieee80211_vif *vif)
 
 		e = (struct edca *)tlv;
 		e->set = WMM_PARAM_SET;
-		e->queue = ac + mvif->mt76.wmm_idx * MT7996_MAX_WMM_SETS;
+		e->queue = ac;
 		e->aifs = q->aifs;
 		e->txop = cpu_to_le16(q->txop);
 
-- 
2.42.0



