Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C976970C818
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjEVTfx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjEVTfw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:35:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CB5E6A
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FCDE62964
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80B7C433EF;
        Mon, 22 May 2023 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784070;
        bh=tLtxx7TmatftY7vMlkiUCET1TwiHB75Z7/U3cG+gl9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KF9LvGXyhmvjXCmb1DiUXSEwmyoeA09Rp+2ObWZd80jdH8FIc3f10WG0KvGziO/SO
         o3U37UZ+gT+O16dJBneIUn5E7SKlQDonzMg6LDndNa3u8qDO6gN5deVCno+mSr3iU+
         nxYvTDdlmCf/6Y9JwcDV1DoFZNgJCEHkGrfKZgcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 6.1 253/292] wifi: rtw88: use work to update rate to avoid RCU warning
Date:   Mon, 22 May 2023 20:10:10 +0100
Message-Id: <20230522190412.271310015@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

commit bcafcb959a57a6890e900199690c5fc47da1a304 upstream.

The ieee80211_ops::sta_rc_update must be atomic, because
ieee80211_chan_bw_change() holds rcu_read lock while calling
drv_sta_rc_update(), so create a work to do original things.

 Voluntary context switch within RCU read-side critical section!
 WARNING: CPU: 0 PID: 4621 at kernel/rcu/tree_plugin.h:318
 rcu_note_context_switch+0x571/0x5d0
 CPU: 0 PID: 4621 Comm: kworker/u16:2 Tainted: G        W  OE
 Workqueue: phy3 ieee80211_chswitch_work [mac80211]
 RIP: 0010:rcu_note_context_switch+0x571/0x5d0
 Call Trace:
  <TASK>
  __schedule+0xb0/0x1460
  ? __mod_timer+0x116/0x360
  schedule+0x5a/0xc0
  schedule_timeout+0x87/0x150
  ? trace_raw_output_tick_stop+0x60/0x60
  wait_for_completion_timeout+0x7b/0x140
  usb_start_wait_urb+0x82/0x160 [usbcore
  usb_control_msg+0xe3/0x140 [usbcore
  rtw_usb_read+0x88/0xe0 [rtw_usb
  rtw_usb_read8+0xf/0x10 [rtw_usb
  rtw_fw_send_h2c_command+0xa0/0x170 [rtw_core
  rtw_fw_send_ra_info+0xc9/0xf0 [rtw_core
  drv_sta_rc_update+0x7c/0x160 [mac80211
  ieee80211_chan_bw_change+0xfb/0x110 [mac80211
  ieee80211_change_chanctx+0x38/0x130 [mac80211
  ieee80211_vif_use_reserved_switch+0x34e/0x900 [mac80211
  ieee80211_link_use_reserved_context+0x88/0xe0 [mac80211
  ieee80211_chswitch_work+0x95/0x170 [mac80211
  process_one_work+0x201/0x410
  worker_thread+0x4a/0x3b0
  ? process_one_work+0x410/0x410
  kthread+0xe1/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Cc: stable@vger.kernel.org
Fixes: c1edc86472fc ("rtw88: add ieee80211:sta_rc_update ops")
Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/linux-wireless/f1e31e8e-f84e-3791-50fb-663a83c5c6e9@lwfinger.net/T/#t
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230508085429.46653-1-pkshih@realtek.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |    2 +-
 drivers/net/wireless/realtek/rtw88/main.c     |   15 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |    3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -891,7 +891,7 @@ static void rtw_ops_sta_rc_update(struct
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 
 	if (changed & IEEE80211_RC_BW_CHANGED)
-		rtw_update_sta_info(rtwdev, si, true);
+		ieee80211_queue_work(rtwdev->hw, &si->rc_work);
 }
 
 const struct ieee80211_ops rtw_ops = {
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -296,6 +296,17 @@ static u8 rtw_acquire_macid(struct rtw_d
 	return mac_id;
 }
 
+static void rtw_sta_rc_work(struct work_struct *work)
+{
+	struct rtw_sta_info *si = container_of(work, struct rtw_sta_info,
+					       rc_work);
+	struct rtw_dev *rtwdev = si->rtwdev;
+
+	mutex_lock(&rtwdev->mutex);
+	rtw_update_sta_info(rtwdev, si, true);
+	mutex_unlock(&rtwdev->mutex);
+}
+
 int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		struct ieee80211_vif *vif)
 {
@@ -306,12 +317,14 @@ int rtw_sta_add(struct rtw_dev *rtwdev,
 	if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
 		return -ENOSPC;
 
+	si->rtwdev = rtwdev;
 	si->sta = sta;
 	si->vif = vif;
 	si->init_ra_lv = 1;
 	ewma_rssi_init(&si->avg_rssi);
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw_txq_init(rtwdev, sta->txq[i]);
+	INIT_WORK(&si->rc_work, rtw_sta_rc_work);
 
 	rtw_update_sta_info(rtwdev, si, true);
 	rtw_fw_media_status_report(rtwdev, si->mac_id, true);
@@ -330,6 +343,8 @@ void rtw_sta_remove(struct rtw_dev *rtwd
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
 	int i;
 
+	cancel_work_sync(&si->rc_work);
+
 	rtw_release_macid(rtwdev, si->mac_id);
 	if (fw_exist)
 		rtw_fw_media_status_report(rtwdev, si->mac_id, false);
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -734,6 +734,7 @@ struct rtw_txq {
 DECLARE_EWMA(rssi, 10, 16);
 
 struct rtw_sta_info {
+	struct rtw_dev *rtwdev;
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 
@@ -758,6 +759,8 @@ struct rtw_sta_info {
 
 	bool use_cfg_mask;
 	struct cfg80211_bitrate_mask *mask;
+
+	struct work_struct rc_work;
 };
 
 enum rtw_bfee_role {


