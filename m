Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846F272C255
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjFLLER (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbjFLLD7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589EF83DF
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:52:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D18EA6255B
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0BAC433EF;
        Mon, 12 Jun 2023 10:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567122;
        bh=QCagV4Rf2K+9vllhzKZ+3MxAYw0Sm1wngR3cNiRO4gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QN4vwkvdpBPW6sCArV12MHphcI68zOOQC1IZgFvpEANsHhvestGa3zMcQrIstBQna
         Osc3Ptaw7mc/Oe4wIV8Id3qEO8onyuumapqSwEAeFTEPGO5OX3/1VMNQvRj2dLfe2G
         vXYDQ0JT0H1GZlN/Dv3wTOL1DiqS2Q9hQPjUqzGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.3 159/160] wifi: rtw88: correct PS calculation for SUPPORTS_DYNAMIC_PS
Date:   Mon, 12 Jun 2023 12:28:11 +0200
Message-ID: <20230612101722.364231859@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ping-Ke Shih <pkshih@realtek.com>

commit 3918dd0177ee08970683a2c22a3388825d82fd79 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |   14 +++-----
 drivers/net/wireless/realtek/rtw88/main.c     |    4 +-
 drivers/net/wireless/realtek/rtw88/ps.c       |   43 ++++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/ps.h       |    2 +
 4 files changed, 52 insertions(+), 11 deletions(-)

--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -88,15 +88,6 @@ static int rtw_ops_config(struct ieee802
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
 
@@ -206,6 +197,7 @@ static int rtw_ops_add_interface(struct
 	rtwvif->bcn_ctrl = bcn_ctrl;
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
+	rtw_recalc_lps(rtwdev, vif);
 
 	mutex_unlock(&rtwdev->mutex);
 
@@ -236,6 +228,7 @@ static void rtw_ops_remove_interface(str
 	rtwvif->bcn_ctrl = 0;
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
+	rtw_recalc_lps(rtwdev, NULL);
 
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -428,6 +421,9 @@ static void rtw_ops_bss_info_changed(str
 	if (changed & BSS_CHANGED_ERP_SLOT)
 		rtw_conf_tx(rtwdev, rtwvif);
 
+	if (changed & BSS_CHANGED_PS)
+		rtw_recalc_lps(rtwdev, NULL);
+
 	rtw_vif_port_config(rtwdev, rtwvif, config);
 
 	mutex_unlock(&rtwdev->mutex);
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -250,8 +250,8 @@ static void rtw_watch_dog_work(struct wo
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
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -299,3 +299,46 @@ void rtw_leave_lps_deep(struct rtw_dev *
 
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
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -23,4 +23,6 @@ void rtw_enter_lps(struct rtw_dev *rtwde
 void rtw_leave_lps(struct rtw_dev *rtwdev);
 void rtw_leave_lps_deep(struct rtw_dev *rtwdev);
 enum rtw_lps_deep_mode rtw_get_lps_deep_mode(struct rtw_dev *rtwdev);
+void rtw_recalc_lps(struct rtw_dev *rtwdev, struct ieee80211_vif *new_vif);
+
 #endif


