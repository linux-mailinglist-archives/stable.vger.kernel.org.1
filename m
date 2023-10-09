Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F107BDF25
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376556AbjJIN0u (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376490AbjJIN0t (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:26:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D394
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:26:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271B3C433C7;
        Mon,  9 Oct 2023 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858007;
        bh=kiSSt3jErTOA9XLm8f6tT5XaXR9ecvM3qmx8oIBFZxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3GjgwcXvUdn7kfuzkRXLpuZELQFmnwH2SNMHc6AyswUS5NOZEmXsqXUUqyHUFySN
         GiQnJ28G0rDM53YoIHmd3HcDLefRbSte0a4OOgHuVbQKouIpoH8RW3k1kq9rBhy2Sy
         n9W/jEvHwjYkny6e71HRNl0mjMMEvDwwcILpXQwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shiji Yang <yangshiji66@outlook.com>,
        Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 36/75] wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling
Date:   Mon,  9 Oct 2023 15:01:58 +0200
Message-ID: <20231009130112.493936862@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index c57e05a5c65e4..91807bf662dde 100644
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



