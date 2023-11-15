Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3C7ECB35
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbjKOTU7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjKOTUx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:20:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9EC19E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:20:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0502C433C9;
        Wed, 15 Nov 2023 19:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076046;
        bh=+wfoxxy9mKY6O89jjzE4Hm8NmGPhrHWBki3FYctZA1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fL1iB7u8sxwgXmmZehL9K630/oPYUpEShb/wr7AiVGoOJdCfdRBx6Fa4JDkQzc6yc
         smbFhUGZzhn3NJOyw6GZoGBJI2JcBfoDo4zBXjdi0zR1GwtTO5WgYl8o/5qv60HL/9
         OStsiKyz5BcA0HDqMBJfSzT5x5JALldVxPvya3M0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 042/550] wifi: mac80211: move sched-scan stop work to wiphy work
Date:   Wed, 15 Nov 2023 14:10:26 -0500
Message-ID: <20231115191603.623666971@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit eadfb54756aea5610d8d0a467f66305f777c85dd ]

This also has the wiphy locked here then. We need to use
the _locked version of cfg80211_sched_scan_stopped() now,
which also fixes an old deadlock there.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h | 5 +++--
 net/mac80211/main.c        | 6 +++---
 net/mac80211/scan.c        | 7 ++++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 10ad1d8f9ba83..8032167e15332 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1483,7 +1483,7 @@ struct ieee80211_local {
 	int hw_scan_ies_bufsize;
 	struct cfg80211_scan_info scan_info;
 
-	struct work_struct sched_scan_stopped_work;
+	struct wiphy_work sched_scan_stopped_work;
 	struct ieee80211_sub_if_data __rcu *sched_scan_sdata;
 	struct cfg80211_sched_scan_request __rcu *sched_scan_req;
 	u8 scan_addr[ETH_ALEN];
@@ -1963,7 +1963,8 @@ int ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 				       struct cfg80211_sched_scan_request *req);
 int ieee80211_request_sched_scan_stop(struct ieee80211_local *local);
 void ieee80211_sched_scan_end(struct ieee80211_local *local);
-void ieee80211_sched_scan_stopped_work(struct work_struct *work);
+void ieee80211_sched_scan_stopped_work(struct wiphy *wiphy,
+				       struct wiphy_work *work);
 
 /* off-channel/mgmt-tx */
 void ieee80211_offchannel_stop_vifs(struct ieee80211_local *local);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index f1cbb7c5d4ac3..4548f84451095 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -822,8 +822,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 		  ieee80211_dynamic_ps_disable_work);
 	timer_setup(&local->dynamic_ps_timer, ieee80211_dynamic_ps_timer, 0);
 
-	INIT_WORK(&local->sched_scan_stopped_work,
-		  ieee80211_sched_scan_stopped_work);
+	wiphy_work_init(&local->sched_scan_stopped_work,
+			ieee80211_sched_scan_stopped_work);
 
 	spin_lock_init(&local->ack_status_lock);
 	idr_init(&local->ack_status_frames);
@@ -1481,13 +1481,13 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 
 	wiphy_lock(local->hw.wiphy);
 	wiphy_delayed_work_cancel(local->hw.wiphy, &local->roc_work);
+	wiphy_work_cancel(local->hw.wiphy, &local->sched_scan_stopped_work);
 	wiphy_work_cancel(local->hw.wiphy, &local->radar_detected_work);
 	wiphy_unlock(local->hw.wiphy);
 	rtnl_unlock();
 
 	cancel_work_sync(&local->restart_work);
 	cancel_work_sync(&local->reconfig_filter);
-	flush_work(&local->sched_scan_stopped_work);
 
 	ieee80211_clear_tx_pending(local);
 	rate_control_deinitialize(local);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 2117cb2a916ac..68ec2124c3db5 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -1422,10 +1422,11 @@ void ieee80211_sched_scan_end(struct ieee80211_local *local)
 
 	mutex_unlock(&local->mtx);
 
-	cfg80211_sched_scan_stopped(local->hw.wiphy, 0);
+	cfg80211_sched_scan_stopped_locked(local->hw.wiphy, 0);
 }
 
-void ieee80211_sched_scan_stopped_work(struct work_struct *work)
+void ieee80211_sched_scan_stopped_work(struct wiphy *wiphy,
+				       struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local,
@@ -1448,6 +1449,6 @@ void ieee80211_sched_scan_stopped(struct ieee80211_hw *hw)
 	if (local->in_reconfig)
 		return;
 
-	schedule_work(&local->sched_scan_stopped_work);
+	wiphy_work_queue(hw->wiphy, &local->sched_scan_stopped_work);
 }
 EXPORT_SYMBOL(ieee80211_sched_scan_stopped);
-- 
2.42.0



