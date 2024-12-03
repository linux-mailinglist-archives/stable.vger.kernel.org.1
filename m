Return-Path: <stable+bounces-97595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F639E24AE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537C2281F83
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A481F893B;
	Tue,  3 Dec 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RCOM3d6n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0E1F76CA;
	Tue,  3 Dec 2024 15:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241057; cv=none; b=XPrlE7TPTb8d954lCtdjXXk9dsNio09GJPyexaGQtlBtYNu1HQ+umIExaTZqxIfX+Z6UraDjV0JgUgNSFm20OqFFfYUA4S55aB8mGdBCDz7f/oJ+lsa4Q4yRnT/GpxGlixzmxnZ/7ReO5aPlQ2rztPQFP2lyk6aPoWk5Al+pNaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241057; c=relaxed/simple;
	bh=Wbj6OkP6Q6tTWiN0y4hmLlutwe/zVH3xrtzGKnrIM58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBcpSWdEgCvyb45o0o/wXf0lgjYKqk8IInfk6jzmAGKhbrN871wysQAeaOIBFSVpS5JwJ1F6nMSFv9Q3i4zlmBrW0Vx/WnMPHdU34Ticp5L3XWiTGBwYQIBpFV3P5uhYms9x26i4zNHhtPbaVZaUDKioIOAPBrRGHHOheqY/cz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RCOM3d6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22492C4CECF;
	Tue,  3 Dec 2024 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733241057;
	bh=Wbj6OkP6Q6tTWiN0y4hmLlutwe/zVH3xrtzGKnrIM58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RCOM3d6n+CqYKQrqjgK0zaB8xtyJm9Fvx65FHK2Dnp1YolWM9S0z5fMKiLr/06/NF
	 NC2R05y7UvFjJt0BO3VDNgqnMQQ+0GAsdGKGISMzNn3xxWJOWCB2nirPVSTsr5yrdd
	 Ddo9jVVNo6Oi3tWDRNXyzbLoRUiFQQlAD+j1SbNs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 271/826] wifi: rtw89: refactor VIF related func ahead for MLO
Date: Tue,  3 Dec 2024 15:39:58 +0100
Message-ID: <20241203144754.344645831@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit 26d460e13f84426fa7dd2c0c369676034c206161 ]

Refactor VIF related functions, e.g. add/remove/assoc/mapping
to separate most link stuffs into sub-functions for MLO reuse.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240916053158.47350-6-pkshih@realtek.com
Stable-dep-of: f16c40acd319 ("wifi: rtw89: Fix TX fail with A2DP after scanning")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  10 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   4 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |  28 +---
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 137 ++++++++++++------
 drivers/net/wireless/realtek/rtw89/phy.c      |   5 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |   3 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |   4 +-
 8 files changed, 112 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 84c1952fbea88..c6d3b8fd98b65 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3466,9 +3466,9 @@ int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 	case NL80211_IFTYPE_ ## _type:	\
 		rtwvif_link->wifi_role = RTW89_WIFI_ROLE_ ## _type;	\
 		break
-void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc)
+void rtw89_vif_type_mapping(struct rtw89_vif_link *rtwvif_link, bool assoc)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	const struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct ieee80211_bss_conf *bss_conf;
 
 	switch (vif->type) {
@@ -3638,7 +3638,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta_link->bssid_cam);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
-		rtw89_vif_type_mapping(vif, false);
+		rtw89_vif_type_mapping(rtwvif_link, false);
 		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif_link, true);
 	}
 
@@ -4785,9 +4785,9 @@ int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 EXPORT_SYMBOL(rtw89_chip_info_setup);
 
 void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
-				       struct ieee80211_vif *vif)
+				       struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_bss_conf *bss_conf;
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 274051e53f19c..2b3976c6daf72 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6702,10 +6702,10 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
 int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 				    struct rtw89_sta_link *rtwsta_link, u8 tid,
 				    u8 *cam_idx);
-void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc);
+void rtw89_vif_type_mapping(struct rtw89_vif_link *rtwvif_link, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
 void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
-				       struct ieee80211_vif *vif);
+				       struct rtw89_vif_link *rtwvif_link);
 bool rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate, u16 *bitrate);
 int rtw89_regd_setup(struct rtw89_dev *rtwdev);
 int rtw89_regd_init(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7ab2aac3c3d22..a7b89a25d7c46 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4697,9 +4697,9 @@ static void rtw89_mac_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
 }
 
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
-					struct ieee80211_vif *vif)
+					struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif_safe(rtwvif_link);
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct ieee80211_bss_conf *bss_conf;
@@ -4742,32 +4742,12 @@ void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_l
 
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	int ret;
-
-	rtwvif_link->mac_id = rtw89_acquire_mac_id(rtwdev);
-	if (rtwvif_link->mac_id == RTW89_MAX_MAC_ID_NUM)
-		return -ENOSPC;
-
-	ret = rtw89_mac_vif_init(rtwdev, rtwvif_link);
-	if (ret)
-		goto release_mac_id;
-
-	return 0;
-
-release_mac_id:
-	rtw89_release_mac_id(rtwdev, rtwvif_link->mac_id);
-
-	return ret;
+	return rtw89_mac_vif_init(rtwdev, rtwvif_link);
 }
 
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
 {
-	int ret;
-
-	ret = rtw89_mac_vif_deinit(rtwdev, rtwvif_link);
-	rtw89_release_mac_id(rtwdev, rtwvif_link->mac_id);
-
-	return ret;
+	return rtw89_mac_vif_deinit(rtwdev, rtwvif_link);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 3ea2dcbfa5b8c..f2a31cba226e9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1158,7 +1158,7 @@ int rtw89_mac_port_get_tsf(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 void rtw89_mac_port_cfg_rx_sync(struct rtw89_dev *rtwdev,
 				struct rtw89_vif_link *rtwvif_link, bool en);
 void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
-					struct ieee80211_vif *vif);
+					struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
 void rtw89_mac_enable_beacon_for_ap_vifs(struct rtw89_dev *rtwdev, bool en);
 int rtw89_mac_remove_vif(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f04032a8a8ec4..d3fad66e56cd8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -106,12 +106,60 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 	return 0;
 }
 
+static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
+				      struct rtw89_vif_link *rtwvif_link)
+{
+	struct ieee80211_bss_conf *bss_conf;
+	int ret;
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	rtw89_vif_type_mapping(rtwvif_link, false);
+
+	INIT_WORK(&rtwvif_link->update_beacon_work, rtw89_core_update_beacon_work);
+	INIT_LIST_HEAD(&rtwvif_link->general_pkt_list);
+
+	rtwvif_link->hit_rule = 0;
+	rtwvif_link->bcn_hit_cond = 0;
+	rtwvif_link->chanctx_assigned = false;
+	rtwvif_link->chanctx_idx = RTW89_CHANCTX_0;
+	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+
+	rcu_read_lock();
+
+	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
+	ether_addr_copy(rtwvif_link->mac_addr, bss_conf->addr);
+
+	rcu_read_unlock();
+
+	ret = rtw89_mac_add_vif(rtwdev, rtwvif_link);
+	if (ret)
+		return ret;
+
+	rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, NULL, BTC_ROLE_START);
+	return 0;
+}
+
+static void __rtw89_ops_remove_iface_link(struct rtw89_dev *rtwdev,
+					  struct rtw89_vif_link *rtwvif_link)
+{
+	mutex_unlock(&rtwdev->mutex);
+	cancel_work_sync(&rtwvif_link->update_beacon_work);
+	mutex_lock(&rtwdev->mutex);
+
+	rtw89_leave_ps_mode(rtwdev);
+
+	rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, NULL, BTC_ROLE_STOP);
+
+	rtw89_mac_remove_vif(rtwdev, rtwvif_link);
+}
+
 static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
-	struct ieee80211_bss_conf *bss_conf;
+	u8 mac_id, port;
 	int ret = 0;
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "add vif %pM type %d, p2p %d\n",
@@ -128,53 +176,47 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif_link->rtwdev = rtwdev;
 	rtwvif_link->roc.state = RTW89_ROC_IDLE;
 	rtwvif_link->offchan = false;
-	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif_link))
-		list_add_tail(&rtwvif_link->list, &rtwdev->rtwvifs_list);
-
-	INIT_WORK(&rtwvif_link->update_beacon_work, rtw89_core_update_beacon_work);
 	INIT_DELAYED_WORK(&rtwvif_link->roc.roc_work, rtw89_roc_work);
-	rtw89_leave_ps_mode(rtwdev);
 
 	rtw89_traffic_stats_init(rtwdev, &rtwvif_link->stats);
-	rtw89_vif_type_mapping(vif, false);
-	rtwvif_link->port = rtw89_core_acquire_bit_map(rtwdev->hw_port,
-						       RTW89_PORT_NUM);
-	if (rtwvif_link->port == RTW89_PORT_NUM) {
+
+	mac_id = rtw89_acquire_mac_id(rtwdev);
+	if (mac_id == RTW89_MAX_MAC_ID_NUM) {
 		ret = -ENOSPC;
-		list_del_init(&rtwvif_link->list);
-		goto out;
+		goto err;
+	}
+
+	port = rtw89_core_acquire_bit_map(rtwdev->hw_port, RTW89_PORT_NUM);
+	if (port == RTW89_PORT_NUM) {
+		ret = -ENOSPC;
+		goto release_macid;
 	}
 
-	rtwvif_link->bcn_hit_cond = 0;
 	rtwvif_link->mac_idx = RTW89_MAC_0;
 	rtwvif_link->phy_idx = RTW89_PHY_0;
-	rtwvif_link->chanctx_idx = RTW89_CHANCTX_0;
-	rtwvif_link->chanctx_assigned = false;
-	rtwvif_link->hit_rule = 0;
-	rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+	rtwvif_link->mac_id = mac_id;
+	rtwvif_link->port = port;
 
-	rcu_read_lock();
-
-	bss_conf = rtw89_vif_rcu_dereference_link(rtwvif_link, true);
-	ether_addr_copy(rtwvif_link->mac_addr, bss_conf->addr);
-
-	rcu_read_unlock();
+	rtw89_core_txq_init(rtwdev, vif->txq);
 
-	INIT_LIST_HEAD(&rtwvif_link->general_pkt_list);
+	if (!rtw89_rtwvif_in_list(rtwdev, rtwvif_link))
+		list_add_tail(&rtwvif_link->list, &rtwdev->rtwvifs_list);
 
-	ret = rtw89_mac_add_vif(rtwdev, rtwvif_link);
-	if (ret) {
-		rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
-		list_del_init(&rtwvif_link->list);
-		goto out;
-	}
+	ret = __rtw89_ops_add_iface_link(rtwdev, rtwvif_link);
+	if (ret)
+		goto release_port;
 
-	rtw89_core_txq_init(rtwdev, vif->txq);
+	rtw89_recalc_lps(rtwdev);
 
-	rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, NULL, BTC_ROLE_START);
+	mutex_unlock(&rtwdev->mutex);
+	return 0;
 
-	rtw89_recalc_lps(rtwdev);
-out:
+release_port:
+	list_del_init(&rtwvif_link->list);
+	rtw89_core_release_bit_map(rtwdev->hw_port, port);
+release_macid:
+	rtw89_release_mac_id(rtwdev, mac_id);
+err:
 	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
@@ -189,14 +231,14 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "remove vif %pM type %d p2p %d\n",
 		    vif->addr, vif->type, vif->p2p);
 
-	cancel_work_sync(&rtwvif_link->update_beacon_work);
 	cancel_delayed_work_sync(&rtwvif_link->roc.roc_work);
 
 	mutex_lock(&rtwdev->mutex);
-	rtw89_leave_ps_mode(rtwdev);
-	rtw89_btc_ntfy_role_info(rtwdev, rtwvif_link, NULL, BTC_ROLE_STOP);
-	rtw89_mac_remove_vif(rtwdev, rtwvif_link);
+
+	__rtw89_ops_remove_iface_link(rtwdev, rtwvif_link);
+
 	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif_link->port);
+	rtw89_release_mac_id(rtwdev, rtwvif_link->mac_id);
 	list_del_init(&rtwvif_link->list);
 	rtw89_recalc_lps(rtwdev);
 	rtw89_enter_ips_by_hwflags(rtwdev);
@@ -417,6 +459,7 @@ static void rtw89_conf_tx(struct rtw89_dev *rtwdev,
 static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
 					 struct ieee80211_vif *vif)
 {
+	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
 	struct ieee80211_sta *sta;
 
 	if (vif->type != NL80211_IFTYPE_STATION)
@@ -428,11 +471,20 @@ static void rtw89_station_mode_sta_assoc(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	rtw89_vif_type_mapping(vif, true);
+	rtw89_vif_type_mapping(rtwvif_link, true);
 
 	rtw89_core_sta_assoc(rtwdev, vif, sta);
 }
 
+static void __rtw89_ops_bss_link_assoc(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif_link *rtwvif_link)
+{
+	rtw89_phy_set_bss_color(rtwdev, rtwvif_link);
+	rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, rtwvif_link);
+	rtw89_mac_port_update(rtwdev, rtwvif_link);
+	rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, rtwvif_link);
+}
+
 static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif, u64 changed)
 {
@@ -445,10 +497,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ASSOC) {
 		if (vif->cfg.assoc) {
 			rtw89_station_mode_sta_assoc(rtwdev, vif);
-			rtw89_phy_set_bss_color(rtwdev, vif);
-			rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, vif);
-			rtw89_mac_port_update(rtwdev, rtwvif_link);
-			rtw89_mac_set_he_obss_narrow_bw_ru(rtwdev, vif);
+			__rtw89_ops_bss_link_assoc(rtwdev, rtwvif_link);
 
 			rtw89_queue_chanctx_work(rtwdev);
 		} else {
@@ -494,7 +543,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 		rtw89_conf_tx(rtwdev, rtwvif_link);
 
 	if (changed & BSS_CHANGED_HE_BSS_COLOR)
-		rtw89_phy_set_bss_color(rtwdev, vif);
+		rtw89_phy_set_bss_color(rtwdev, rtwvif_link);
 
 	if (changed & BSS_CHANGED_MU_GROUPS)
 		rtw89_mac_bf_set_gid_table(rtwdev, vif, conf);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a46f182633e92..f6f2b003c412f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6038,9 +6038,10 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_chip_cfg_txrx_path(rtwdev);
 }
 
-void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
+void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif_link *rtwvif_link)
 {
-	struct rtw89_vif_link *rtwvif_link = (struct rtw89_vif_link *)vif->drv_priv;
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_reg_def *bss_clr_vld = &chip->bss_clr_vld;
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index dc85840312da7..882a473ecf7bc 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -953,7 +953,8 @@ void rtw89_phy_antdiv_parse(struct rtw89_dev *rtwdev,
 			    struct rtw89_rx_phy_ppdu *phy_ppdu);
 void rtw89_phy_antdiv_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_antdiv_work(struct work_struct *work);
-void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif_link *rtwvif_link);
 void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 					  enum rtw89_mac_idx mac_idx,
 					  enum rtw89_tssi_bandedge_cfg bandedge_cfg);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 17e2d5cbb1e6a..20b776ae634ea 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -1268,8 +1268,8 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 			return ret;
 		}
 		rtw89_phy_ra_assoc(rtwdev, wow_sta);
-		rtw89_phy_set_bss_color(rtwdev, wow_vif);
-		rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, wow_vif);
+		rtw89_phy_set_bss_color(rtwdev, rtwvif_link);
+		rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, rtwvif_link);
 	}
 
 	if (chip_gen == RTW89_CHIP_BE)
-- 
2.43.0




