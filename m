Return-Path: <stable+bounces-210436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53410D3BF52
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 200CE4F420A
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 06:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B983816F0;
	Tue, 20 Jan 2026 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTV2nKGk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB037F0FF
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890547; cv=none; b=b2mggme9yBIZp7+4xtRUsunFxgt1QKzm7uKA8Rn51KY5oK7Rr0hxOkktkc7k+SbVzCvkI1Tww6mMBHCGTbFGz8qSH4PWVesMycS5d4dPx25Yt+MUxX6WRrlhrxgyMIjsCGdaAeh7UO+hU6yj69OHMeabFdC8bDxPsLeKDG44L2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890547; c=relaxed/simple;
	bh=1vGbeUFHZoPrw+RBYT0ajksYNqGtsOHNrs6As9l5Mbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qpq19sHgJ1BhK0KjcYNzPMhg1i5JeBMIeshzH69Hh6IDVEV7cpBajbLDg2qWgI0y20wOzYW/TEXETD0PWQCnWO0DZKej/IEoQ+fXdD30S3TW3tE0D+TdW/nTKSWbBJsXm2MXFUFGSIqdIiscHBPMAztYtZHiz3zh1xj78D16CV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTV2nKGk; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zacbowling.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so602700eec.1
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 22:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768890544; x=1769495344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ1oBr1p2m8ckSj93rp5Wujk0nNyKJFebQgZ7BR/4/Q=;
        b=lTV2nKGk6aExKyZQK77rBUB+uSjBVHPPDDwTTYV1TAWr2qIY4jJQL/Q33SxaB6nDQS
         iz0URy336d+McnC++4k9XWujF9/xlf5LDX9hxBWLSxYD62Z1al+gjiwQUrM0TrdHsQfx
         MXF/CAvEnXWVCTVC//RCe2Uky2ocexpbvzAowVmtpecNNSe9a1qzFk/sz+GEnAy//EvT
         717RCZbUffaqaPRoVmuEpvQcpPtyC094ZdB8TMBfXTlbac3nltF521OTVmOZmCBS3/+C
         4to8zf55BaAaRWNLbnPg+iLRHTIk4I7spoYVpueTUzKbXzLrxgGs0gAH7DHx51kvm9WW
         olJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768890544; x=1769495344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZ1oBr1p2m8ckSj93rp5Wujk0nNyKJFebQgZ7BR/4/Q=;
        b=A1Q2IZNaZ5hnw6jsIeHKBwiaWj/MZlGlT1JlRcBWudW3ViNzhdcBN3PPY3aWitsHTn
         1OLZvFkvXT6D6DL8uRsjFkttxsWYSxPQPnSCHdDwEXMpyflHfvKsbpxzSUPDrdPxJFYj
         PnJBtypdAxz2sLWsLcVOyBh8jw/4vzA0C8Wk0MEGz88I0wz3PNagUqygRj/15B2BXM53
         W50WhCvmB47NU7tW6JpF91kuF2a7LE9BZiM5C4s4ENb3e/qsfKmBoxfc4kZVRvdE4AUB
         OenqyH9V9cfCBSL6isawZOyr8vyumxSleFLYCTPYRhs53ez7LRCuf5NLOf3NVrHtlXlL
         9Ouw==
X-Forwarded-Encrypted: i=1; AJvYcCVvZfF9fuLbxqMLdwhKwHyK/EBKjgbi6X8nfeVBmmh/54bglryXlIzGk2Qp1KzXYoUmcoUvbP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPtwL9Gj0Fvezu/IuN27GJnBIPBvFDBVXoGcSKOz//Uqh0O2ZH
	rLPl2IGU+YBXu/3i3Xvt3DGgurNrnluUVYfe7xp3iroWXCxWSvpbO2p5
X-Gm-Gg: AZuq6aKNhhMDV9fU+skA0Yxopme94Gf2ID04DP1YocdRs47FAot0KwoHkKOJcH++LW+
	4T3Gx3w09U7K8gmBmfinARvH6FPySHHtQ80AYcauU+mV7V2ILp8bGRDEh3yutiV/UqD2JN3yUPc
	tpF6e90tQskIXHgWzzVkRKKMrJIiMYGjCH49b4sf7JyL9hwBCpCy7lufMB9xiDmfvFlqcY54S/O
	QWess4wrrJk0ro4rUHC/o+6Cpr5NohgTxjeb36M7hlgUIipPV7d4xail+1Md1LxXaScDn7o7uFS
	Hgs/uRCALLPVts/Gf/N5GcgrwMrNcLWsEdWqTwOnbkudBZKLYJayaRW23LcoBQ4AgEkN11szQ1U
	q+Bw53PQgluyJVrVEi5UWmzjzgy0EWQtXGEjN90r78Dao7y6y5nGzhNWf5g3X7/xqp9n/+2dFxt
	wfaCeSktakg6QXDufqceTMBtaWglyjUifuhDtTLyerKm88hiR+JYaSyINcsJdK
X-Received: by 2002:a05:7301:3f16:b0:2ae:5552:b5ae with SMTP id 5a478bee46e88-2b6b411a106mr8033764eec.36.1768890543650;
        Mon, 19 Jan 2026 22:29:03 -0800 (PST)
Received: from zcache.home.zacbowling.com ([2001:5a8:60d:bc9:f31e:1cb:296a:cc2a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm15706784eec.9.2026.01.19.22.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 22:29:03 -0800 (PST)
Sender: Zac Bowling <zbowling@gmail.com>
From: Zac <zac@zacbowling.com>
To: sean.wang@kernel.org
Cc: deren.wu@mediatek.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lorenzo@kernel.org,
	nbd@nbd.name,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	stable@vger.kernel.org,
	linux@frame.work,
	zbowling@gmail.com,
	Zac Bowling <zac@zacbowling.com>
Subject: [PATCH 05/11] wifi: mt76: mt7925: add comprehensive NULL pointer protection for MLO
Date: Mon, 19 Jan 2026 22:28:48 -0800
Message-ID: <20260120062854.126501-6-zac@zacbowling.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120062854.126501-1-zac@zacbowling.com>
References: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
 <20260120062854.126501-1-zac@zacbowling.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zac Bowling <zac@zacbowling.com>

Add NULL pointer checks for functions that return pointers to link-related
structures throughout the mt7925 driver. During MLO state transitions,
these functions can return NULL when link configuration is not synchronized.

Functions protected:
- mt792x_vif_to_bss_conf(): Returns link BSS configuration
- mt792x_vif_to_link(): Returns driver link state
- mt792x_sta_to_link(): Returns station link state

Files updated:

1. mac.c:
   - mt7925_vif_connect_iter(): Check bss_conf before use
   - mt7925_mac_sta_assoc(): Check bss_conf before use

2. main.c:
   - mt7925_set_key(): Check link_conf and mlink
   - mt7925_mac_link_sta_add(): Check link_conf and mlink
   - mt7925_mac_link_sta_assoc(): Check bss_conf and mlink
   - mt7925_mac_link_sta_remove(): Check bss_conf and mlink
   - mt7925_change_vif_links(): Check conf before use
   - mt7925_assign_vif_chanctx(): Check mconf and mlink
   - mt7925_unassign_vif_chanctx(): Check mconf and mlink
   - mt7925_mgd_prepare_tx(): Check link_conf

3. mcu.c:
   - mt7925_mcu_sta_phy_tlv(): Check link_sta
   - mt7925_mcu_sta_amsdu_tlv(): Check link_sta
   - mt7925_mcu_sta_mld_tlv(): Check link_sta
   - mt7925_mcu_sta_cmd(): Check mlink
   - mt7925_mcu_add_bss_info(): Check link_conf
   - mt7925_mcu_set_chctx(): Check link_conf and mlink

Prevents crashes during:
- BSSID roaming transitions
- MLO setup and teardown
- Hardware reset operations
- Runtime power management

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 device")
Signed-off-by: Zac Bowling <zac@zacbowling.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  6 ++
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 82 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 22 ++++-
 3 files changed, 97 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 871b67101976..184efe8afa10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1271,6 +1271,12 @@ mt7925_vif_connect_iter(void *priv, u8 *mac,
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
 		mconf = mt792x_vif_to_link(mvif, i);
 
+		/* Skip links that don't have bss_conf set up yet in mac80211.
+		 * This can happen during HW reset when link state is inconsistent.
+		 */
+		if (!bss_conf)
+			continue;
+
 		mt76_connac_mcu_uni_add_dev(&dev->mphy, bss_conf, &mconf->mt76,
 					    &mvif->sta.deflink.wcid, true);
 		mt7925_mcu_set_tx(dev, bss_conf);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2d358a96640c..15d1b1b8d9f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -604,6 +604,10 @@ static int mt7925_set_link_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	link_sta = sta ? mt792x_sta_to_link_sta(vif, sta, link_id) : NULL;
 	mconf = mt792x_vif_to_link(mvif, link_id);
 	mlink = mt792x_sta_to_link(msta, link_id);
+
+	if (!link_conf || !mconf || !mlink)
+		return -EINVAL;
+
 	wcid = &mlink->wcid;
 	wcid_keyidx = &wcid->hw_key_idx;
 
@@ -856,12 +860,17 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return -EINVAL;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
 		return -ENOSPC;
 
 	mconf = mt792x_vif_to_link(mvif, link_id);
+	if (!mconf)
+		return -EINVAL;
+
 	mt76_wcid_init(&mlink->wcid, 0);
 	mlink->wcid.sta = 1;
 	mlink->wcid.idx = idx;
@@ -887,6 +896,8 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
+	if (!link_conf)
+		return -EINVAL;
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
@@ -993,18 +1004,29 @@ mt7925_mac_set_links(struct mt76_dev *mdev, struct ieee80211_vif *vif)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct ieee80211_bss_conf *link_conf =
-		mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
-	struct cfg80211_chan_def *chandef = &link_conf->chanreq.oper;
-	enum nl80211_band band = chandef->chan->band, secondary_band;
+	struct ieee80211_bss_conf *link_conf;
+	struct cfg80211_chan_def *chandef;
+	enum nl80211_band band, secondary_band;
+	u16 sel_links;
+	u8 secondary_link_id;
 
-	u16 sel_links = mt76_select_links(vif, 2);
-	u8 secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
+	link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
+	if (!link_conf)
+		return;
+
+	chandef = &link_conf->chanreq.oper;
+	band = chandef->chan->band;
+
+	sel_links = mt76_select_links(vif, 2);
+	secondary_link_id = __ffs(~BIT(mvif->deflink_id) & sel_links);
 
 	if (!ieee80211_vif_is_mld(vif) || hweight16(sel_links) < 2)
 		return;
 
 	link_conf = mt792x_vif_to_bss_conf(vif, secondary_link_id);
+	if (!link_conf)
+		return;
+
 	secondary_band = link_conf->chanreq.oper.chan->band;
 
 	if (band == NL80211_BAND_2GHZ ||
@@ -1032,6 +1054,8 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -1041,12 +1065,13 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 		link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
-		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-					link_conf, link_sta, true);
+		if (mconf)
+			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
+						link_conf, link_sta, true);
 	}
 
 	ewma_avg_signal_init(&mlink->avg_ack_signal);
@@ -1093,6 +1118,8 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 	mlink = mt792x_sta_to_link(msta, link_id);
+	if (!mlink)
+		return;
 
 	mt7925_roc_abort_sync(dev);
 
@@ -1106,10 +1133,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+	if (link_conf && vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_bss_conf *mconf;
 
 		mconf = mt792x_link_conf_to_mconf(link_conf);
+		if (!mconf)
+			goto out;
 
 		if (ieee80211_vif_is_mld(vif))
 			mt792x_mac_link_bss_remove(dev, mconf, mlink);
@@ -1117,6 +1146,7 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
 						link_sta, false);
 	}
+out:
 
 	spin_lock_bh(&mdev->sta_poll_lock);
 	if (!list_empty(&mlink->wcid.poll_list))
@@ -1304,6 +1334,8 @@ mt7925_mlo_pm_iter(void *priv, u8 *mac, struct ieee80211_vif *vif)
 	mt792x_mutex_acquire(dev);
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		if (!bss_conf)
+			continue;
 		mt7925_mcu_uni_bss_ps(dev, bss_conf);
 	}
 	mt792x_mutex_release(dev);
@@ -1630,6 +1662,8 @@ static void mt7925_ipv6_addr_change(struct ieee80211_hw *hw,
 
 	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 		bss_conf = mt792x_vif_to_bss_conf(vif, i);
+		if (!bss_conf)
+			continue;
 		__mt7925_ipv6_addr_change(hw, bss_conf, idev);
 	}
 }
@@ -1691,6 +1725,9 @@ mt7925_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		    [IEEE80211_AC_BK] = 1,
 	};
 
+	if (!mconf)
+		return -EINVAL;
+
 	/* firmware uses access class index */
 	mconf->queue_params[mq_to_aci[queue]] = *params;
 
@@ -1861,6 +1898,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ARP_FILTER) {
 		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 			bss_conf = mt792x_vif_to_bss_conf(vif, i);
+			if (!bss_conf)
+				continue;
 			mt7925_mcu_update_arp_filter(&dev->mt76, bss_conf);
 		}
 	}
@@ -1876,6 +1915,8 @@ static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
 			} else if (mvif->mlo_pm_state == MT792x_MLO_CHANGED_PS) {
 				for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
 					bss_conf = mt792x_vif_to_bss_conf(vif, i);
+					if (!bss_conf)
+						continue;
 					mt7925_mcu_uni_bss_ps(dev, bss_conf);
 				}
 			}
@@ -1897,7 +1938,12 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	struct ieee80211_bss_conf *link_conf;
 
 	mconf = mt792x_vif_to_link(mvif, info->link_id);
+	if (!mconf)
+		return;
+
 	link_conf = mt792x_vif_to_bss_conf(vif, mconf->link_id);
+	if (!link_conf)
+		return;
 
 	mt792x_mutex_acquire(dev);
 
@@ -2021,6 +2067,11 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mlink = mlinks[link_id];
 		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
+		if (!link_conf) {
+			err = -EINVAL;
+			goto free;
+		}
+
 		rcu_assign_pointer(mvif->link_conf[link_id], mconf);
 		rcu_assign_pointer(mvif->sta.link[link_id], mlink);
 
@@ -2101,9 +2152,14 @@ static int mt7925_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (ieee80211_vif_is_mld(vif)) {
 		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		if (!mconf) {
+			mutex_unlock(&dev->mt76.mutex);
+			return -EINVAL;
+		}
+
 		pri_link_conf = mt792x_vif_to_bss_conf(vif, mvif->deflink_id);
 
-		if (vif->type == NL80211_IFTYPE_STATION &&
+		if (pri_link_conf && vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
 			mt7925_mcu_add_bss_info(&dev->phy, NULL, pri_link_conf,
 						NULL, true);
@@ -2132,6 +2188,10 @@ static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	if (ieee80211_vif_is_mld(vif)) {
 		mconf = mt792x_vif_to_link(mvif, link_conf->link_id);
+		if (!mconf) {
+			mutex_unlock(&dev->mt76.mutex);
+			return;
+		}
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
 		    mconf == &mvif->bss_conf)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index cf0fdea45cf7..94ec62a4538a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1087,6 +1087,8 @@ mt7925_mcu_sta_hdr_trans_tlv(struct sk_buff *skb,
 		struct mt792x_link_sta *mlink;
 
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+		if (!mlink)
+			return;
 		wcid = &mlink->wcid;
 	} else {
 		wcid = &mvif->sta.deflink.wcid;
@@ -1120,6 +1122,9 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 	link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
 	mconf = mt792x_vif_to_link(mvif, link_id);
 
+	if (!mlink || !mconf)
+		return -EINVAL;
+
 	skb = __mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mconf->mt76,
 					      &mlink->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
@@ -1741,6 +1746,8 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 	amsdu->amsdu_en = true;
 
 	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	if (!mlink)
+		return;
 	mlink->wcid.amsdu = true;
 
 	switch (link_sta->agg.max_amsdu_len) {
@@ -1773,6 +1780,10 @@ mt7925_mcu_sta_phy_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 
@@ -1851,6 +1862,10 @@ mt7925_mcu_sta_rate_ctrl_tlv(struct sk_buff *skb,
 
 	link_conf = mt792x_vif_to_bss_conf(vif, link_sta->link_id);
 	mconf = mt792x_vif_to_link(mvif, link_sta->link_id);
+
+	if (!link_conf || !mconf)
+		return;
+
 	chandef = mconf->mt76.ctx ? &mconf->mt76.ctx->def :
 				    &link_conf->chanreq.oper;
 	band = chandef->chan->band;
@@ -1935,6 +1950,9 @@ mt7925_mcu_sta_mld_tlv(struct sk_buff *skb,
 
 		mconf = mt792x_vif_to_link(mvif, i);
 		mlink = mt792x_sta_to_link(msta, i);
+		if (!mconf || !mlink)
+			continue;
+
 		mld->link[cnt].wlan_id = cpu_to_le16(mlink->wcid.idx);
 		mld->link[cnt++].bss_idx = mconf->mt76.idx;
 
@@ -2027,13 +2045,13 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 		.rcpi = to_rcpi(rssi),
 	};
 	struct mt792x_sta *msta;
-	struct mt792x_link_sta *mlink;
+	struct mt792x_link_sta *mlink = NULL;
 
 	if (link_sta) {
 		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
 		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	}
-	info.wcid = link_sta ? &mlink->wcid : &mvif->sta.deflink.wcid;
+	info.wcid = (link_sta && mlink) ? &mlink->wcid : &mvif->sta.deflink.wcid;
 	info.newly = state != MT76_STA_INFO_STATE_ASSOC;
 
 	return mt7925_mcu_sta_cmd(&dev->mphy, &info);
-- 
2.52.0


