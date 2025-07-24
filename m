Return-Path: <stable+bounces-164621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38140B10E01
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 738FA7AD6A9
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690B28D849;
	Thu, 24 Jul 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc8GiV3Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F85263C7F
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368595; cv=none; b=Aia5Ez6DVf2gz+uhxwAQhStwQr0/oLlfFyxz2PY86PtK/skSCK2DQXAnJEBy0nJkPPvS2vrfC/BEQZVJih+nqJjw0qWNyjuYnBhx7g4YDNAW7rRYoTe3AzNOW3O/xcMeqkunVlQizfY/xwGL6PefJqUmXmn4zT0tYdcoR7ej9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368595; c=relaxed/simple;
	bh=rT0ScjlITQv4nBcajBEquoHuVluuf/bFWqCQe5OUWqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBNrp3cspRbHe71F+2cRgxBni7At8bVJ4Zw+hIrGSBW7/bHb1wodgpD49r0xlG4SmWgHNnnckBilUODXCjfHna7m/rttGVIvOemAvhxCR6FhtVPq3L+AXQVtljG7PYN8XU4IM6fihTSZ3O3/aOqVNb975aAl7UGipOc/WQMSeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc8GiV3Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94038C4CEED;
	Thu, 24 Jul 2025 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753368594;
	bh=rT0ScjlITQv4nBcajBEquoHuVluuf/bFWqCQe5OUWqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qc8GiV3Zeb/3r2ZhFAwiURYsmE5GLpc/p6re+ULPCcb99sLorYLee2bFgCWM7L3Uo
	 7hvy9uAFsQTolsufOMl2W9RsUEFYfjSd+ray6f2IMWYmlFiOg4ZqNNA6tc930Chbxa
	 6xr1CJtDDQL9XCzuqdck03WORqZLwkuHE9h2TH8D2jg3nO4dvRC/iIzW0JnjZ0C10h
	 0bvswlmsSxsN/1HlSzBnPJRaW6WPNQGPpMsB9LXT+rmFly+4zu4TkBGFuf1mDTyTK8
	 Qr6/6btjmPi3LEWqbRoClwCzs6N31nry+/qNOg5TuPq68aLN+0MXrzn8cx9I/tv6/d
	 TICB/+rWX3Kvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Caleb Jorden <cjorden@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mt76: mt7925: adjust rm BSS flow to prevent next connection failure
Date: Thu, 24 Jul 2025 10:49:50 -0400
Message-Id: <20250724144950.1354067-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025041743-unwoven-sizzle-ba8b@gregkh>
References: <2025041743-unwoven-sizzle-ba8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit 0ebb60da8416c1d8e84c7e511a5687ce76a9467a ]

Removing BSS without removing STAREC first will cause firmware
abnormal and next connection fail.

Fixes: 816161051a03 ("wifi: mt76: mt7925: Cleanup MLO settings post-disconnection")
Cc: stable@vger.kernel.org
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Link: https://patch.msgid.link/20250305000851.493671-4-sean.wang@kernel.org
Signed-off-by: Felix Fietkau <nbd@nbd.name>
[ struct mt76_vif_link -> struct mt792x_vif  ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 66 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 56 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  2 +
 3 files changed, 91 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index ca5f1dc05815f..632caecdda042 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1155,7 +1155,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt792x_mac_link_bss_remove(dev, mconf, mlink);
+
+		if (ieee80211_vif_is_mld(vif))
+			mt792x_mac_link_bss_remove(dev, mconf, mlink);
+		else
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
+						link_sta, false);
 	}
 
 	spin_lock_bh(&mdev->sta_poll_lock);
@@ -1175,6 +1180,31 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 	struct mt76_wcid *wcid;
 	unsigned int link_id;
 
+	/* clean up bss before starec */
+	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta;
+		struct ieee80211_bss_conf *link_conf;
+		struct mt792x_bss_conf *mconf;
+		struct mt792x_link_sta *mlink;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+		if (!link_sta)
+			continue;
+
+		mlink = mt792x_sta_to_link(msta, link_id);
+		if (!mlink)
+			continue;
+
+		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+		if (!link_conf)
+			continue;
+
+		mconf = mt792x_link_conf_to_mconf(link_conf);
+
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
+					link_sta, false);
+	}
+
 	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_sta *link_sta;
 		struct mt792x_link_sta *mlink;
@@ -1213,44 +1243,14 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-	struct {
-		struct {
-			u8 omac_idx;
-			u8 band_idx;
-			__le16 pad;
-		} __packed hdr;
-		struct req_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 active;
-			u8 link_idx; /* hw link idx */
-			u8 omac_addr[ETH_ALEN];
-		} __packed tlv;
-	} dev_req = {
-		.hdr = {
-			.omac_idx = 0,
-			.band_idx = 0,
-		},
-		.tlv = {
-			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
-			.len = cpu_to_le16(sizeof(struct req_tlv)),
-			.active = true,
-		},
-	};
 	unsigned long rem;
 
 	rem = ieee80211_vif_is_mld(vif) ? msta->valid_links : BIT(0);
 
 	mt7925_mac_sta_remove_links(dev, vif, sta, rem);
 
-	if (ieee80211_vif_is_mld(vif)) {
-		mt7925_mcu_set_dbdc(&dev->mphy, false);
-
-		/* recovery omac address for the legacy interface */
-		memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
-		mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
-				  &dev_req, sizeof(dev_req), true);
-	}
+	if (ieee80211_vif_is_mld(vif))
+		mt7925_mcu_del_dev(mdev, vif);
 
 	if (vif->type == NL80211_IFTYPE_STATION) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 2aeb9ba4256ab..549705d5b565d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2694,6 +2694,62 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+void mt7925_mcu_del_dev(struct mt76_dev *mdev,
+			struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct {
+		struct {
+			u8 omac_idx;
+			u8 band_idx;
+			__le16 pad;
+		} __packed hdr;
+		struct req_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 active;
+			u8 link_idx; /* hw link idx */
+			u8 omac_addr[ETH_ALEN];
+		} __packed tlv;
+	} dev_req = {
+		.tlv = {
+			.tag = cpu_to_le16(DEV_INFO_ACTIVE),
+			.len = cpu_to_le16(sizeof(struct req_tlv)),
+			.active = true,
+		},
+	};
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		struct mt76_connac_bss_basic_tlv basic;
+	} basic_req = {
+		.basic = {
+			.tag = cpu_to_le16(UNI_BSS_INFO_BASIC),
+			.len = cpu_to_le16(sizeof(struct mt76_connac_bss_basic_tlv)),
+			.active = true,
+			.conn_state = 1,
+		},
+	};
+
+	dev_req.hdr.omac_idx = mvif->bss_conf.mt76.omac_idx;
+	dev_req.hdr.band_idx = mvif->bss_conf.mt76.band_idx;
+
+	basic_req.hdr.bss_idx = mvif->bss_conf.mt76.idx;
+	basic_req.basic.omac_idx = mvif->bss_conf.mt76.omac_idx;
+	basic_req.basic.band_idx = mvif->bss_conf.mt76.band_idx;
+	basic_req.basic.link_idx = mvif->bss_conf.mt76.link_idx;
+
+	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE),
+			  &basic_req, sizeof(basic_req), true);
+
+	/* recovery omac address for the legacy interface */
+	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
+	mt76_mcu_send_msg(mdev, MCU_UNI_CMD(DEV_INFO_UPDATE),
+			  &dev_req, sizeof(dev_req), true);
+}
+
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_bss_conf *link_conf,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 780c5921679aa..ee89d5778adfa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -627,6 +627,8 @@ int mt7925_mcu_sched_scan_req(struct mt76_phy *phy,
 int mt7925_mcu_sched_scan_enable(struct mt76_phy *phy,
 				 struct ieee80211_vif *vif,
 				 bool enable);
+void mt7925_mcu_del_dev(struct mt76_dev *mdev,
+			struct ieee80211_vif *vif);
 int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_chanctx_conf *ctx,
 			    struct ieee80211_bss_conf *link_conf,
-- 
2.39.5


