Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5679B8DA
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbjIKWKJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjIKNzb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:55:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46262FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:55:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F80BC433C9;
        Mon, 11 Sep 2023 13:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440525;
        bh=FPlFrjoMWinjkwITt9Prp4I9ZZJNd4tQWTRXi/CMa6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdtcegVFlzmvLGdFuZ/E5waunuIpugYqCy1NcEikgw8DmAtvGpAfku8IgLIsoIuCb
         lgkuimuIvjjEKL2xZpR72w1QfUh47pe1S+rBffGwBqp9Ju4a5RzwyQo+9VLIHEPP02
         wKyo/h/HEa/rlSR9+nSCb6lphyk9lhWlkOrOFBZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rany Hany <rany_hany@riseup.net>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 093/739] wifi: mt76: mt7915: fix command timeout in AP stop period
Date:   Mon, 11 Sep 2023 15:38:12 +0200
Message-ID: <20230911134653.700857996@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rany Hany <rany_hany@riseup.net>

[ Upstream commit c4f0755823045b66484fb53d686f85d3151400f4 ]

Due to AP stop improperly, mt7915 driver would face random command timeout
by chip fw problem. Migrate AP start/stop process to .start_ap/.stop_ap and
congiure BSS network settings in both hooks.

The new flow is shown below.
* AP start
    .start_ap()
      configure BSS network resource
      set BSS to connected state
    .bss_info_changed()
      enable fw beacon offload

* AP stop
    .bss_info_changed()
      disable fw beacon offload (skip this command)
    .stop_ap()
      set BSS to disconnected state (beacon offload disabled automatically)
      destroy BSS network resource

Based on "mt76: mt7921: fix command timeout in AP stop period"

Signed-off-by: Rany Hany <rany_hany@riseup.net>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Stable-dep-of: 02a894046d5a ("wifi: mt76: mt7915: fix capabilities in non-AP mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 63 +++++++++++++++----
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2da57357c4174..13d429bd44e28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -599,6 +599,7 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	int set_bss_info = -1, set_sta = -1;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -607,15 +608,18 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 	 * and then peer references bss_info_rfch to set bandwidth cap.
 	 */
 	if (changed & BSS_CHANGED_BSSID &&
-	    vif->type == NL80211_IFTYPE_STATION) {
-		bool join = !is_zero_ether_addr(info->bssid);
-
-		mt7915_mcu_add_bss_info(phy, vif, join);
-		mt7915_mcu_add_sta(dev, vif, NULL, join);
-	}
-
+	    vif->type == NL80211_IFTYPE_STATION)
+		set_bss_info = set_sta = !is_zero_ether_addr(info->bssid);
 	if (changed & BSS_CHANGED_ASSOC)
-		mt7915_mcu_add_bss_info(phy, vif, vif->cfg.assoc);
+		set_bss_info = vif->cfg.assoc;
+	if (changed & BSS_CHANGED_BEACON_ENABLED &&
+	    vif->type != NL80211_IFTYPE_AP)
+		set_bss_info = set_sta = info->enable_beacon;
+
+	if (set_bss_info == 1)
+		mt7915_mcu_add_bss_info(phy, vif, true);
+	if (set_sta == 1)
+		mt7915_mcu_add_sta(dev, vif, NULL, true);
 
 	if (changed & BSS_CHANGED_ERP_CTS_PROT)
 		mt7915_mac_enable_rtscts(dev, vif, info->use_cts_prot);
@@ -629,11 +633,6 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (changed & BSS_CHANGED_BEACON_ENABLED && info->enable_beacon) {
-		mt7915_mcu_add_bss_info(phy, vif, true);
-		mt7915_mcu_add_sta(dev, vif, NULL, true);
-	}
-
 	/* ensure that enable txcmd_mode after bss_info */
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7915_mcu_set_tx(dev, vif);
@@ -650,6 +649,42 @@ static void mt7915_bss_info_changed(struct ieee80211_hw *hw,
 		       BSS_CHANGED_FILS_DISCOVERY))
 		mt7915_mcu_add_beacon(hw, vif, info->enable_beacon, changed);
 
+	if (set_bss_info == 0)
+		mt7915_mcu_add_bss_info(phy, vif, false);
+	if (set_sta == 0)
+		mt7915_mcu_add_sta(dev, vif, NULL, false);
+
+	mutex_unlock(&dev->mt76.mutex);
+}
+
+static int
+mt7915_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		struct ieee80211_bss_conf *link_conf)
+{
+	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	int err;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	err = mt7915_mcu_add_bss_info(phy, vif, true);
+	if (err)
+		goto out;
+	err = mt7915_mcu_add_sta(dev, vif, NULL, true);
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return err;
+}
+
+static void
+mt7915_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_bss_conf *link_conf)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+
+	mutex_lock(&dev->mt76.mutex);
+	mt7915_mcu_add_sta(dev, vif, NULL, false);
 	mutex_unlock(&dev->mt76.mutex);
 }
 
@@ -1528,6 +1563,8 @@ const struct ieee80211_ops mt7915_ops = {
 	.conf_tx = mt7915_conf_tx,
 	.configure_filter = mt7915_configure_filter,
 	.bss_info_changed = mt7915_bss_info_changed,
+	.start_ap = mt7915_start_ap,
+	.stop_ap = mt7915_stop_ap,
 	.sta_add = mt7915_sta_add,
 	.sta_remove = mt7915_sta_remove,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
-- 
2.40.1



