Return-Path: <stable+bounces-133023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC7EA919D4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17FC19E479E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43E922AE74;
	Thu, 17 Apr 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bCP26YK+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE220C497
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744887287; cv=none; b=GPOuhCNXxSC7kqLBIf1OREKhGva841QLWyp0B831DklCpLMYMqv5twAytX2IqPn7YY1y7UegNIyE0VDJ5WYGKwqFcyBwjQbYbadKT3emJlSKgpI08TDF8WVBR8E9nDKWgR4H3KsQLNjWv81Hu43rXe2Rx2QGWOY7lyvMY/RHxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744887287; c=relaxed/simple;
	bh=ZiStr6YSO3C1uM66PMZrw2UOCK+hqj00hCnkepePpTw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WBddtnHXtNyHxwuFAiPW2HTVIyc8dwKgDjEKMF514yxkOS2BnTQsRqyokFlDRVWiFjeigtpRVW1FN3pnsI+rhwMRWoBL6v2PG8PNJjwWo5Dgp7iHoVsPHpqpDvjJnqYxY7IiAtQl8izeMjP5oRUVqbsXtmFoUZgrtJ2H6TqDHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bCP26YK+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6363CC4CEE4;
	Thu, 17 Apr 2025 10:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744887286;
	bh=ZiStr6YSO3C1uM66PMZrw2UOCK+hqj00hCnkepePpTw=;
	h=Subject:To:Cc:From:Date:From;
	b=bCP26YK+CVey7HSqqoCH+o4Rxc23jhbRshJ2ZHT/Tx37ImNSUp0QiXZkGbOqjnoqd
	 Mojqy5zxvdbyTjvCe4hQUUA1NI7EWBNDLfm4OEZ7NWAuvNpZr80DhHiXmeEeJDpIzR
	 vNkDZhX3e8UCpQePzsU4thCS7mtDSAmqR/iV1F+E=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7925: adjust rm BSS flow to prevent next" failed to apply to 6.12-stable tree
To: mingyen.hsieh@mediatek.com,cjorden@gmail.com,nbd@nbd.name,sean.wang@mediatek.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:54:43 +0200
Message-ID: <2025041743-unwoven-sizzle-ba8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0ebb60da8416c1d8e84c7e511a5687ce76a9467a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041743-unwoven-sizzle-ba8b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ebb60da8416c1d8e84c7e511a5687ce76a9467a Mon Sep 17 00:00:00 2001
From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Date: Tue, 4 Mar 2025 16:08:49 -0800
Subject: [PATCH] wifi: mt76: mt7925: adjust rm BSS flow to prevent next
 connection failure

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

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index dd886b39f550..2f6c687d0a05 100644
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
@@ -1212,44 +1242,14 @@ void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
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
index ebe7cc30aaf9..d970243d64ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2634,6 +2634,62 @@ int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+void mt7925_mcu_del_dev(struct mt76_dev *mdev,
+			struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
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
+	dev_req.hdr.omac_idx = mvif->omac_idx;
+	dev_req.hdr.band_idx = mvif->band_idx;
+
+	basic_req.hdr.bss_idx = mvif->idx;
+	basic_req.basic.omac_idx = mvif->omac_idx;
+	basic_req.basic.band_idx = mvif->band_idx;
+	basic_req.basic.link_idx = mvif->link_idx;
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
index 6bf1623e542e..8ac43feb26d6 100644
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


