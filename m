Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4C4775DEF
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjHILmg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjHILmf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E118B1FDE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73F6D636D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F38C433C8;
        Wed,  9 Aug 2023 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581353;
        bh=uc0N3ZPxqF39p4g1zFbBw/a9elrWOT+SHfZ9zUA/1C4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B36win40EtBNa0AJ4t/oFQNqJzNJpmxslXgwwRjaXb5mT4qrPJ/iZF5wNzOYx8TXZ
         7zwhOLZvTy/Y9hjN8gVwb9K1ivJOldQc0oNv7nzPq6FWYy0e7gLI7j7I/yIPBIdUqM
         p+pgP/P7bL0ASPUWMvpGkBa2kefe+30O7wzkZ/bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 196/201] mt76: move band capabilities in mt76_phy
Date:   Wed,  9 Aug 2023 12:43:18 +0200
Message-ID: <20230809103650.438067267@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 48dbce5cb1ba3ce5b2ed3e997bcb1e4697d41b71 ]

This is a preliminary patch to move properly support mt7915 dbdc

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 421033deb915 ("wifi: mt76: mt7615: do not advertise 5 GHz on first phy of MT7615D (DBDC)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt76.h        |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/eeprom.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/eeprom.c   | 16 ++++++++--------
 .../net/wireless/mediatek/mt76/mt76x0/eeprom.c   |  6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.c  |  8 ++++----
 .../net/wireless/mediatek/mt76/mt7915/eeprom.c   |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/init.c |  5 ++---
 11 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 81ff3b4c6c1b3..dc1191aa0443e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -160,9 +160,9 @@ static void mt76_init_stream_cap(struct mt76_phy *phy,
 
 void mt76_set_stream_caps(struct mt76_phy *phy, bool vht)
 {
-	if (phy->dev->cap.has_2ghz)
+	if (phy->cap.has_2ghz)
 		mt76_init_stream_cap(phy, &phy->sband_2g.sband, false);
-	if (phy->dev->cap.has_5ghz)
+	if (phy->cap.has_5ghz)
 		mt76_init_stream_cap(phy, &phy->sband_5g.sband, vht);
 }
 EXPORT_SYMBOL_GPL(mt76_set_stream_caps);
@@ -463,13 +463,13 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	dev_set_drvdata(dev->dev, dev);
 	mt76_phy_init(dev, hw);
 
-	if (dev->cap.has_2ghz) {
+	if (phy->cap.has_2ghz) {
 		ret = mt76_init_sband_2g(dev, rates, n_rates);
 		if (ret)
 			return ret;
 	}
 
-	if (dev->cap.has_5ghz) {
+	if (phy->cap.has_5ghz) {
 		ret = mt76_init_sband_5g(dev, rates + 4, n_rates - 4, vht);
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 5a8060790a61f..16e65020a242d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -561,6 +561,7 @@ struct mt76_phy {
 	struct mt76_channel_state *chan_state;
 	ktime_t survey_time;
 
+	struct mt76_hw_cap cap;
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
 
@@ -630,7 +631,6 @@ struct mt76_dev {
 
 	struct debugfs_blob_wrapper eeprom;
 	struct debugfs_blob_wrapper otp;
-	struct mt76_hw_cap cap;
 
 	struct mt76_rate_power rate_power;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 01f1e0da5ee1e..a6df733aca492 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -170,7 +170,7 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 	}
 
 	eeprom = (u8 *)dev->mt76.eeprom.data;
-	dev->mt76.cap.has_2ghz = true;
+	dev->mphy.cap.has_2ghz = true;
 	memcpy(dev->mt76.macaddr, eeprom + MT_EE_MAC_ADDR, ETH_ALEN);
 
 	/* Check for 1SS devices */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index bf8ae14121dba..637ef0882436c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -202,7 +202,7 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 	int ret;
 
 	/* Increase buffer size to receive large VHT MPDUs */
-	if (dev->mt76.cap.has_5ghz)
+	if (dev->mphy.cap.has_5ghz)
 		rx_buf_size *= 2;
 
 	mt76_dma_attach(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index e9cdcdc54d5c3..714d1ff69c560 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -100,20 +100,20 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 
 	if (is_mt7663(&dev->mt76)) {
 		/* dual band */
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		return;
 	}
 
 	if (is_mt7622(&dev->mt76)) {
 		/* 2GHz only */
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		return;
 	}
 
 	if (is_mt7611(&dev->mt76)) {
 		/* 5GHz only */
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		return;
 	}
 
@@ -121,17 +121,17 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 			eeprom[MT_EE_WIFI_CONF]);
 	switch (val) {
 	case MT_EE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case MT_EE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		break;
 	case MT_EE_DBDC:
 		dev->dbdc_support = true;
 		/* fall through */
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
index 9087607b621e8..ebf4c96532d31 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c
@@ -52,15 +52,15 @@ static void mt76x0_set_chip_cap(struct mt76x02_dev *dev)
 
 	mt76x02_eeprom_parse_hw_cap(dev);
 	dev_dbg(dev->mt76.dev, "2GHz %d 5GHz %d\n",
-		dev->mt76.cap.has_2ghz, dev->mt76.cap.has_5ghz);
+		dev->mphy.cap.has_2ghz, dev->mphy.cap.has_5ghz);
 
 	if (dev->no_2ghz) {
-		dev->mt76.cap.has_2ghz = false;
+		dev->mphy.cap.has_2ghz = false;
 		dev_dbg(dev->mt76.dev, "mask out 2GHz support\n");
 	}
 
 	if (is_mt7630(dev)) {
-		dev->mt76.cap.has_5ghz = false;
+		dev->mphy.cap.has_5ghz = false;
 		dev_dbg(dev->mt76.dev, "mask out 5GHz support\n");
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
index d78866bf41ba3..0bac39bf3b66d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/init.c
@@ -245,7 +245,7 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	if (dev->mt76.cap.has_5ghz) {
+	if (dev->mphy.cap.has_5ghz) {
 		struct ieee80211_supported_band *sband;
 
 		sband = &dev->mphy.sband_5g.sband;
@@ -253,7 +253,7 @@ int mt76x0_register_device(struct mt76x02_dev *dev)
 		mt76x0_init_txpower(dev, sband);
 	}
 
-	if (dev->mt76.cap.has_2ghz)
+	if (dev->mphy.cap.has_2ghz)
 		mt76x0_init_txpower(dev, &dev->mphy.sband_2g.sband);
 
 	mt76x02_init_debugfs(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 3de33aadf7941..e91c314cdfac5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -447,11 +447,11 @@ static void mt76x0_phy_ant_select(struct mt76x02_dev *dev)
 		else
 			coex3 |= BIT(4);
 		coex3 |= BIT(3);
-		if (dev->mt76.cap.has_2ghz)
+		if (dev->mphy.cap.has_2ghz)
 			wlan |= BIT(6);
 	} else {
 		/* sigle antenna mode */
-		if (dev->mt76.cap.has_5ghz) {
+		if (dev->mphy.cap.has_5ghz) {
 			coex3 |= BIT(3) | BIT(4);
 		} else {
 			wlan |= BIT(6);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
index c54c50fd639a9..0acabba2d1a50 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c
@@ -75,14 +75,14 @@ void mt76x02_eeprom_parse_hw_cap(struct mt76x02_dev *dev)
 
 	switch (FIELD_GET(MT_EE_NIC_CONF_0_BOARD_TYPE, val)) {
 	case BOARD_TYPE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case BOARD_TYPE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		break;
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index e4c5f968f706d..5f6c527611f20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -57,14 +57,14 @@ static void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *dev)
 	val = FIELD_GET(MT_EE_WIFI_CONF_BAND_SEL, val);
 	switch (val) {
 	case MT_EE_5GHZ:
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	case MT_EE_2GHZ:
-		dev->mt76.cap.has_2ghz = true;
+		dev->mphy.cap.has_2ghz = true;
 		break;
 	default:
-		dev->mt76.cap.has_2ghz = true;
-		dev->mt76.cap.has_5ghz = true;
+		dev->mphy.cap.has_2ghz = true;
+		dev->mphy.cap.has_5ghz = true;
 		break;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 8f01ca1694bca..99683688a8363 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -528,10 +528,9 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 {
 	struct ieee80211_sband_iftype_data *data;
 	struct ieee80211_supported_band *band;
-	struct mt76_dev *mdev = &phy->dev->mt76;
 	int n;
 
-	if (mdev->cap.has_2ghz) {
+	if (phy->mt76->cap.has_2ghz) {
 		data = phy->iftype[NL80211_BAND_2GHZ];
 		n = mt7915_init_he_caps(phy, NL80211_BAND_2GHZ, data);
 
@@ -540,7 +539,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy)
 		band->n_iftype_data = n;
 	}
 
-	if (mdev->cap.has_5ghz) {
+	if (phy->mt76->cap.has_5ghz) {
 		data = phy->iftype[NL80211_BAND_5GHZ];
 		n = mt7915_init_he_caps(phy, NL80211_BAND_5GHZ, data);
 
-- 
2.40.1



