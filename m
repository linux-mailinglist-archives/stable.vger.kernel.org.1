Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B164972B1CA
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjFKMNy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 08:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKMNx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 08:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FCE72
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 05:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8F8661651
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 12:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0C4C433D2;
        Sun, 11 Jun 2023 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686485631;
        bh=QqIFPRQtsP2kf52TaoQihqEXDPi/ejw/bAUJbAOODhM=;
        h=Subject:To:Cc:From:Date:From;
        b=ZEl+RJmfgnnzqBDiM1Vec9OhWnzzUBrELeuMgDRKgeWb6AuibZh/IDxoSUgS+xwJ5
         nLZVdF8X9j1JXVUgY76R7otM2dKDduJW739Hmpxdqt/aCqL4+EVhn+1f+UNqCykluh
         KgbcAZmMSOLIw2+JL8pSCXOXKtO83WIg3EsTMHFo=
Subject: FAILED: patch "[PATCH] wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS" failed to apply to 6.3-stable tree
To:     pkshih@realtek.com, kvalo@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 11 Jun 2023 14:13:48 +0200
Message-ID: <2023061148-obsessive-robe-72b9@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 26a125f550a3bf86ac91d38752f4d446426dfe1c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061148-obsessive-robe-72b9@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26a125f550a3bf86ac91d38752f4d446426dfe1c Mon Sep 17 00:00:00 2001
From: Ping-Ke Shih <pkshih@realtek.com>
Date: Sat, 27 May 2023 16:29:38 +0800
Subject: [PATCH] wifi: rtw89: correct PS calculation for SUPPORTS_DYNAMIC_PS

This driver relies on IEEE80211_CONF_PS of hw->conf.flags to turn off PS or
turn on dynamic PS controlled by driver and firmware. Though this would be
incorrect, it did work before because the flag is always recalculated until
the commit 28977e790b5d ("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS")
is introduced by kernel 5.20 to skip to recalculate IEEE80211_CONF_PS
of hw->conf.flags if driver sets SUPPORTS_DYNAMIC_PS.

Correct this by doing recalculation while BSS_CHANGED_PS is changed and
interface is added or removed. For now, it is allowed to enter PS only if
single one station vif is working, and it could possible to have PS per
vif after firmware can support it. Without this fix, driver doesn't
enter PS anymore that causes higher power consumption.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230527082939.11206-3-pkshih@realtek.com

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index ee4588b61b8f..c42e31069035 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -89,15 +89,6 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 	    !(hw->conf.flags & IEEE80211_CONF_IDLE))
 		rtw89_leave_ips(rtwdev);
 
-	if (changed & IEEE80211_CONF_CHANGE_PS) {
-		if (hw->conf.flags & IEEE80211_CONF_PS) {
-			rtwdev->lps_enabled = true;
-		} else {
-			rtw89_leave_lps(rtwdev);
-			rtwdev->lps_enabled = false;
-		}
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		rtw89_config_entity_chandef(rtwdev, RTW89_SUB_ENTITY_0,
 					    &hw->conf.chandef);
@@ -168,6 +159,8 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtw89_core_txq_init(rtwdev, vif->txq);
 
 	rtw89_btc_ntfy_role_info(rtwdev, rtwvif, NULL, BTC_ROLE_START);
+
+	rtw89_recalc_lps(rtwdev);
 out:
 	mutex_unlock(&rtwdev->mutex);
 
@@ -192,6 +185,7 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	rtw89_mac_remove_vif(rtwdev, rtwvif);
 	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif->port);
 	list_del_init(&rtwvif->list);
+	rtw89_recalc_lps(rtwdev);
 	rtw89_enter_ips_by_hwflags(rtwdev);
 
 	mutex_unlock(&rtwdev->mutex);
@@ -451,6 +445,9 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_CQM)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
 
+	if (changed & BSS_CHANGED_PS)
+		rtw89_recalc_lps(rtwdev);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index fa94335f699a..84201ef19c17 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -252,3 +252,29 @@ void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 	rtw89_p2p_disable_all_noa(rtwdev, vif);
 	rtw89_p2p_update_noa(rtwdev, vif);
 }
+
+void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
+{
+	struct ieee80211_vif *vif, *found_vif = NULL;
+	struct rtw89_vif *rtwvif;
+	int count = 0;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		vif = rtwvif_to_vif(rtwvif);
+
+		if (vif->type != NL80211_IFTYPE_STATION) {
+			count = 0;
+			break;
+		}
+
+		count++;
+		found_vif = vif;
+	}
+
+	if (count == 1 && found_vif->cfg.ps) {
+		rtwdev->lps_enabled = true;
+	} else {
+		rtw89_leave_lps(rtwdev);
+		rtwdev->lps_enabled = false;
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 73c008db0426..4c18f49204b2 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -15,6 +15,7 @@ void rtw89_enter_ips(struct rtw89_dev *rtwdev);
 void rtw89_leave_ips(struct rtw89_dev *rtwdev);
 void rtw89_set_coex_ctrl_lps(struct rtw89_dev *rtwdev, bool btc_ctrl);
 void rtw89_process_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_recalc_lps(struct rtw89_dev *rtwdev);
 
 static inline void rtw89_leave_ips_by_hwflags(struct rtw89_dev *rtwdev)
 {

