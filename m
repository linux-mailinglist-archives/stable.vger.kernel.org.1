Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1672B1CD
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjFKMOI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 11 Jun 2023 08:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjFKMOH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Jun 2023 08:14:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFACE72
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 05:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24A0A61BF4
        for <stable@vger.kernel.org>; Sun, 11 Jun 2023 12:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358A9C433D2;
        Sun, 11 Jun 2023 12:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686485645;
        bh=iIqrjyN2/O8S2ptc0pgIVasN9HkuUuuQi90EMOJmUpg=;
        h=Subject:To:Cc:From:Date:From;
        b=OCnmOLv2k7Ch3mpAPGT1/0ATQbB3QGe3O/4QU+n94Ep+bi41pBwIpfPze2tngGYSy
         VEy77ROJnnSuB3kyYWfw/YkJ2eKJgTnMYlIpMbL4O32ZQfSqJdRdVETvlNpEwko0Wz
         bBwTOSa7EwjmvP0efkFjs+kbl663rRb46teKImdo=
Subject: FAILED: patch "[PATCH] wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS" failed to apply to 6.1-stable tree
To:     pkshih@realtek.com, kvalo@kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 11 Jun 2023 14:14:00 +0200
Message-ID: <2023061100-swab-sultry-d7ef@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 3918dd0177ee08970683a2c22a3388825d82fd79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023061100-swab-sultry-d7ef@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3918dd0177ee08970683a2c22a3388825d82fd79 Mon Sep 17 00:00:00 2001
From: Ping-Ke Shih <pkshih@realtek.com>
Date: Sat, 27 May 2023 16:29:37 +0800
Subject: [PATCH] wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS

This driver relies on IEEE80211_CONF_PS of hw->conf.flags to turn off PS or
turn on dynamic PS controlled by driver and firmware. Though this would be
incorrect, it did work before because the flag is always recalculated until
the commit 28977e790b5d ("wifi: mac80211: skip powersave recalc if driver SUPPORTS_DYNAMIC_PS")
is introduced by kernel 5.20 to skip to recalculate IEEE80211_CONF_PS
of hw->conf.flags if driver sets SUPPORTS_DYNAMIC_PS.

Correct this by doing recalculation while BSS_CHANGED_PS is changed and
interface is added or removed. It is allowed to enter PS only if single
one station vif is working. Without this fix, driver doesn't enter PS
anymore that causes higher power consumption.

Fixes: bcde60e599fb ("rtw88: remove misleading module parameter rtw_fw_support_lps")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230527082939.11206-2-pkshih@realtek.com

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index a6c024cab7ee..144618bb94c8 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -88,15 +88,6 @@ static int rtw_ops_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_PS) {
-		if (hw->conf.flags & IEEE80211_CONF_PS) {
-			rtwdev->ps_enabled = true;
-		} else {
-			rtwdev->ps_enabled = false;
-			rtw_leave_lps(rtwdev);
-		}
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL)
 		rtw_set_channel(rtwdev);
 
@@ -213,6 +204,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 	rtw_core_port_switch(rtwdev, vif);
+	rtw_recalc_lps(rtwdev, vif);
 
 	mutex_unlock(&rtwdev->mutex);
 
@@ -244,6 +236,7 @@ static void rtw_ops_remove_interface(struct ieee80211_hw *hw,
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 	clear_bit(rtwvif->port, rtwdev->hw_port);
+	rtw_recalc_lps(rtwdev, NULL);
 
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -438,6 +431,9 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_ERP_SLOT)
 		rtw_conf_tx(rtwdev, rtwvif);
 
+	if (changed & BSS_CHANGED_PS)
+		rtw_recalc_lps(rtwdev, NULL);
+
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	mutex_unlock(&rtwdev->mutex);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index d30a191c9291..9447a3aae3b5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -271,8 +271,8 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	 * more than two stations associated to the AP, then we can not enter
 	 * lps, because fw does not handle the overlapped beacon interval
 	 *
-	 * mac80211 should iterate vifs and determine if driver can enter
-	 * ps by passing IEEE80211_CONF_PS to us, all we need to do is to
+	 * rtw_recalc_lps() iterate vifs and determine if driver can enter
+	 * ps by vif->type and vif->cfg.ps, all we need to do here is to
 	 * get that vif and check if device is having traffic more than the
 	 * threshold.
 	 */
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 996365575f44..53933fb38a33 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -299,3 +299,46 @@ void rtw_leave_lps_deep(struct rtw_dev *rtwdev)
 
 	__rtw_leave_lps_deep(rtwdev);
 }
+
+struct rtw_vif_recalc_lps_iter_data {
+	struct rtw_dev *rtwdev;
+	struct ieee80211_vif *found_vif;
+	int count;
+};
+
+static void __rtw_vif_recalc_lps(struct rtw_vif_recalc_lps_iter_data *data,
+				 struct ieee80211_vif *vif)
+{
+	if (data->count < 0)
+		return;
+
+	if (vif->type != NL80211_IFTYPE_STATION) {
+		data->count = -1;
+		return;
+	}
+
+	data->count++;
+	data->found_vif = vif;
+}
+
+static void rtw_vif_recalc_lps_iter(void *data, u8 *mac,
+				    struct ieee80211_vif *vif)
+{
+	__rtw_vif_recalc_lps(data, vif);
+}
+
+void rtw_recalc_lps(struct rtw_dev *rtwdev, struct ieee80211_vif *new_vif)
+{
+	struct rtw_vif_recalc_lps_iter_data data = { .rtwdev = rtwdev };
+
+	if (new_vif)
+		__rtw_vif_recalc_lps(&data, new_vif);
+	rtw_iterate_vifs(rtwdev, rtw_vif_recalc_lps_iter, &data);
+
+	if (data.count == 1 && data.found_vif->cfg.ps) {
+		rtwdev->ps_enabled = true;
+	} else {
+		rtwdev->ps_enabled = false;
+		rtw_leave_lps(rtwdev);
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index c194386f6db5..5ae83d2526cf 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -23,4 +23,6 @@ void rtw_enter_lps(struct rtw_dev *rtwdev, u8 port_id);
 void rtw_leave_lps(struct rtw_dev *rtwdev);
 void rtw_leave_lps_deep(struct rtw_dev *rtwdev);
 enum rtw_lps_deep_mode rtw_get_lps_deep_mode(struct rtw_dev *rtwdev);
+void rtw_recalc_lps(struct rtw_dev *rtwdev, struct ieee80211_vif *new_vif);
+
 #endif

