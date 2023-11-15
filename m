Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1087ECD01
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjKOTdt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjKOTdt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6B11B1
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B01C433C8;
        Wed, 15 Nov 2023 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076824;
        bh=XLV2wulCV0P0n3vQlJ+OzBV0KzoBnPmQB7pToms1xQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqQGlPwT81XRQ/H5mG12J4UpR+HM+9ly7+bKC5RDcxoA7nly7UWYn7C3a3J416JBD
         1ksQoZbDUhSMEq2iXU9QzAAfLSGWgDMrN4j3SRHE77HRm3s1B/+QcyBHuc/d6ffrp6
         NDfVGYxkqnqzxVI9OwX5qf/81LnkgEShwgm5WV8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 038/603] wifi: mac80211: move radar detect work to wiphy work
Date:   Wed, 15 Nov 2023 14:09:43 -0500
Message-ID: <20231115191615.800267160@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 228e4f931b0e630dacca8dd867ddd863aea53913 ]

Move the radar detect work to wiphy work in order
to lock the wiphy for it without doing it manually.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: eadfb54756ae ("wifi: mac80211: move sched-scan stop work to wiphy work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h | 5 +++--
 net/mac80211/main.c        | 9 +++++----
 net/mac80211/util.c        | 7 +++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 98ef1fe1226e7..358c8865f909a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1406,7 +1406,7 @@ struct ieee80211_local {
 	/* wowlan is enabled -- don't reconfig on resume */
 	bool wowlan;
 
-	struct work_struct radar_detected_work;
+	struct wiphy_work radar_detected_work;
 
 	/* number of RX chains the hardware has */
 	u8 rx_chains;
@@ -2566,7 +2566,8 @@ bool ieee80211_is_radar_required(struct ieee80211_local *local);
 
 void ieee80211_dfs_cac_timer_work(struct work_struct *work);
 void ieee80211_dfs_cac_cancel(struct ieee80211_local *local);
-void ieee80211_dfs_radar_detected_work(struct work_struct *work);
+void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
+				       struct wiphy_work *work);
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 			      struct cfg80211_csa_settings *csa_settings);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 24315d7b31263..3bbd66e5a0df0 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -338,7 +338,6 @@ static void ieee80211_restart_work(struct work_struct *work)
 	/* wait for scan work complete */
 	flush_workqueue(local->workqueue);
 	flush_work(&local->sched_scan_stopped_work);
-	flush_work(&local->radar_detected_work);
 
 	rtnl_lock();
 	/* we might do interface manipulations, so need both */
@@ -813,8 +812,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	INIT_WORK(&local->restart_work, ieee80211_restart_work);
 
-	INIT_WORK(&local->radar_detected_work,
-		  ieee80211_dfs_radar_detected_work);
+	wiphy_work_init(&local->radar_detected_work,
+			ieee80211_dfs_radar_detected_work);
 
 	INIT_WORK(&local->reconfig_filter, ieee80211_reconfig_filter);
 	local->smps_mode = IEEE80211_SMPS_OFF;
@@ -1482,13 +1481,15 @@ void ieee80211_unregister_hw(struct ieee80211_hw *hw)
 	 */
 	ieee80211_remove_interfaces(local);
 
+	wiphy_lock(local->hw.wiphy);
+	wiphy_work_cancel(local->hw.wiphy, &local->radar_detected_work);
+	wiphy_unlock(local->hw.wiphy);
 	rtnl_unlock();
 
 	cancel_delayed_work_sync(&local->roc_work);
 	cancel_work_sync(&local->restart_work);
 	cancel_work_sync(&local->reconfig_filter);
 	flush_work(&local->sched_scan_stopped_work);
-	flush_work(&local->radar_detected_work);
 
 	ieee80211_clear_tx_pending(local);
 	rate_control_deinitialize(local);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8a6917cf63cf9..e878b6a27651a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4356,7 +4356,8 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 	mutex_unlock(&local->mtx);
 }
 
-void ieee80211_dfs_radar_detected_work(struct work_struct *work)
+void ieee80211_dfs_radar_detected_work(struct wiphy *wiphy,
+				       struct wiphy_work *work)
 {
 	struct ieee80211_local *local =
 		container_of(work, struct ieee80211_local, radar_detected_work);
@@ -4374,9 +4375,7 @@ void ieee80211_dfs_radar_detected_work(struct work_struct *work)
 	}
 	mutex_unlock(&local->chanctx_mtx);
 
-	wiphy_lock(local->hw.wiphy);
 	ieee80211_dfs_cac_cancel(local);
-	wiphy_unlock(local->hw.wiphy);
 
 	if (num_chanctx > 1)
 		/* XXX: multi-channel is not supported yet */
@@ -4391,7 +4390,7 @@ void ieee80211_radar_detected(struct ieee80211_hw *hw)
 
 	trace_api_radar_detected(local);
 
-	schedule_work(&local->radar_detected_work);
+	wiphy_work_queue(hw->wiphy, &local->radar_detected_work);
 }
 EXPORT_SYMBOL(ieee80211_radar_detected);
 
-- 
2.42.0



