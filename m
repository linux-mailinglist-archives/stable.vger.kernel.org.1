Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B827ECD7C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbjKOTgu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbjKOTgu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:36:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B68B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:36:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8116FC433C9;
        Wed, 15 Nov 2023 19:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077006;
        bh=uL4NXqwVV6fn4RWsf5mzyDSlUEMsZhw0uh9grlLO+Vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXKtWHI9MsXM9MVod7UD7s8Lg01Gc0Lhhe8rPYXgODPLUsI0s2WGjztjw0T399kyr
         8ItUhR0nef69c0g1CoTKItTrOWd/MnNKvQlP0mdmAE3oTBmPCvxcUPrSQ229qA7vbi
         qwlVOr5wU084WJ/2Wyl3Bc9rfs7uuZrBK9wTwRBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>,
        David Ruth <druth@chromium.org>,
        Deren Wu <deren.wu@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 096/603] wifi: mt76: mt7921: fix the wrong rate selected in fw for the chanctx driver
Date:   Wed, 15 Nov 2023 14:10:41 -0500
Message-ID: <20231115191619.809965964@linuxfoundation.org>
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

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit c558d22e7a93affeb18aae1dcd777ddd1ad18da1 ]

The variable band should be determined by the ieee80211_chanctx_conf when
the driver is a kind of chanctx one e.g mt7921 and mt7922 driver so we
added the extension to mt76_connac2_mac_tx_rate_val and
mt76_connac_get_he_phy_cap for the firmware can select the proper rate.

Fixes: 41ac53c899bd ("wifi: mt76: mt7921: introduce chanctx support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: David Ruth <druth@chromium.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 0f0a519f956f8..8274a57e1f0fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -829,7 +829,9 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_vif *vif,
 			     u8 rcpi, u8 sta_state)
 {
-	struct cfg80211_chan_def *chandef = &mphy->chandef;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = mvif->ctx ?
+					    &mvif->ctx->def : &mphy->chandef;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_dev *dev = mphy->dev;
 	struct sta_rec_ra_info *ra_info;
@@ -1369,7 +1371,10 @@ EXPORT_SYMBOL_GPL(mt76_connac_get_phy_mode_ext);
 const struct ieee80211_sta_he_cap *
 mt76_connac_get_he_phy_cap(struct mt76_phy *phy, struct ieee80211_vif *vif)
 {
-	enum nl80211_band band = phy->chandef.chan->band;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	struct cfg80211_chan_def *chandef = mvif->ctx ?
+					    &mvif->ctx->def : &phy->chandef;
+	enum nl80211_band band = chandef->chan->band;
 	struct ieee80211_supported_band *sband;
 
 	sband = phy->hw->wiphy->bands[band];
-- 
2.42.0



