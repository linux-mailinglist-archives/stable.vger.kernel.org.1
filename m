Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B497BDDAE
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376804AbjJINMT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376800AbjJINME (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA419B6
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0946EC433C8;
        Mon,  9 Oct 2023 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857060;
        bh=uq6lWoexhtWqsiwc+344JxPIJcCbrnMWqrYWyQQN7pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9XKTMPXqtyR7cU2cR3IXalvvW4YkgeeFqYpRp9Wxehnu8WuzuQ2Mtl5gR0XT3F1Q
         iyDQEmjaaEqFVxQCWkWLNLRnSpJJwurnrjGZjVFKV103Q9Sd1V5vBCyYKio4BGspmp
         vXOhlR3FB7ieF7BvDjYnc3Vx9Vrfu38G2HOnh1uo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shiji Yang <yangshiji66@outlook.com>,
        Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 082/163] wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling
Date:   Mon,  9 Oct 2023 15:00:46 +0200
Message-ID: <20231009130126.312126296@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 684e45e120b82deccaf8b85633905304a3bbf56d ]

On MT76x0, LNA gain should be applied for both external and internal LNA.
On MT76x2, LNA gain should be treated as 0 for external LNA.
Move the LNA type based logic to mt76x2 in order to fix mt76x0.

Fixes: 2daa67588f34 ("mt76x0: unify lna_gain parsing")
Reported-by: Shiji Yang <yangshiji66@outlook.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230919194747.31647-1-nbd@nbd.name
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c |  7 -------
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c  | 13 +++++++++++--
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index 0acabba2d1a50..5d402cf2951cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -131,15 +131,8 @@ u8 mt76x02_get_lna_gain(struct mt76x02_dev *dev,
 			s8 *lna_2g, s8 *lna_5g,
 			struct ieee80211_channel *chan)
 {
-	u16 val;
 	u8 lna;
 
-	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_2G)
-		*lna_2g = 0;
-	if (val & MT_EE_NIC_CONF_1_LNA_EXT_5G)
-		memset(lna_5g, 0, sizeof(s8) * 3);
-
 	if (chan->band == NL80211_BAND_2GHZ)
 		lna = *lna_2g;
 	else if (chan->hw_value <= 64)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
index d5809408d1d37..8c01855885ce3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c
@@ -256,7 +256,8 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 	struct ieee80211_channel *chan = dev->mphy.chandef.chan;
 	int channel = chan->hw_value;
 	s8 lna_5g[3], lna_2g;
-	u8 lna;
+	bool use_lna;
+	u8 lna = 0;
 	u16 val;
 
 	if (chan->band == NL80211_BAND_2GHZ)
@@ -275,7 +276,15 @@ void mt76x2_read_rx_gain(struct mt76x02_dev *dev)
 	dev->cal.rx.mcu_gain |= (lna_5g[1] & 0xff) << 16;
 	dev->cal.rx.mcu_gain |= (lna_5g[2] & 0xff) << 24;
 
-	lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+	val = mt76x02_eeprom_get(dev, MT_EE_NIC_CONF_1);
+	if (chan->band == NL80211_BAND_2GHZ)
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_2G);
+	else
+		use_lna = !(val & MT_EE_NIC_CONF_1_LNA_EXT_5G);
+
+	if (use_lna)
+		lna = mt76x02_get_lna_gain(dev, &lna_2g, lna_5g, chan);
+
 	dev->cal.rx.lna_gain = mt76x02_sign_extend(lna, 8);
 }
 EXPORT_SYMBOL_GPL(mt76x2_read_rx_gain);
-- 
2.40.1



