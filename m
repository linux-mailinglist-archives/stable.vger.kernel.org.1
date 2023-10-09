Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5267BDDBF
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376973AbjJINNE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376979AbjJINMw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28B26BF
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19AAAC433CA;
        Mon,  9 Oct 2023 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857104;
        bh=7QApGY+JDX20LqJNBANXsKW8YSPFnoseVe9IM23s+Ho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRl5ti/rrlkKh2tzMtqiYhhDhA7Kr//9dMnXgu0XAocxZ2JtnLWssmFKVx0eUpi1z
         VHSKA3jokWYiilP3rcyEGuIzY3BbPiodVBytyZxm7oqgYDNm57pcCZmA/seiMIJ0AY
         J3xv6970/g/GGVE7yjyBuHMjmWolW9rlCuvhtDWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sultan Alsawaf <sultan@kerneltoast.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 061/163] iwlwifi: mvm: handle PS changes in vif_cfg_changed
Date:   Mon,  9 Oct 2023 15:00:25 +0200
Message-ID: <20231009130125.723224609@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gregory Greenman <gregory.greenman@intel.com>

[ Upstream commit 2d4caa1dbe915654d0e8845758d9c96e721377a8 ]

Handling of BSS_CHANGED_PS was missing in vif_cfg_changed
callback. Fix it.

Fixes: 22c588343529 ("wifi: iwlwifi: mvm: replace bss_info_changed() with vif_cfg/link_info_changed()")
Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230905162939.5ef0c8230de6.Ieed265014988c50ec68fbff6d33821e4215f987f@changeid
[note: patch looks bigger than it is due to reindentation]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 121 +++++++++---------
 1 file changed, 63 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 8b6c641772ee6..b719843e94576 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -731,73 +731,78 @@ static void iwl_mvm_mld_vif_cfg_changed_station(struct iwl_mvm *mvm,
 
 	mvmvif->associated = vif->cfg.assoc;
 
-	if (!(changes & BSS_CHANGED_ASSOC))
-		return;
-
-	if (vif->cfg.assoc) {
-		/* clear statistics to get clean beacon counter */
-		iwl_mvm_request_statistics(mvm, true);
-		iwl_mvm_sf_update(mvm, vif, false);
-		iwl_mvm_power_vif_assoc(mvm, vif);
-
-		for_each_mvm_vif_valid_link(mvmvif, i) {
-			memset(&mvmvif->link[i]->beacon_stats, 0,
-			       sizeof(mvmvif->link[i]->beacon_stats));
+	if (changes & BSS_CHANGED_ASSOC) {
+		if (vif->cfg.assoc) {
+			/* clear statistics to get clean beacon counter */
+			iwl_mvm_request_statistics(mvm, true);
+			iwl_mvm_sf_update(mvm, vif, false);
+			iwl_mvm_power_vif_assoc(mvm, vif);
+
+			for_each_mvm_vif_valid_link(mvmvif, i) {
+				memset(&mvmvif->link[i]->beacon_stats, 0,
+				       sizeof(mvmvif->link[i]->beacon_stats));
+
+				if (vif->p2p) {
+					iwl_mvm_update_smps(mvm, vif,
+							    IWL_MVM_SMPS_REQ_PROT,
+							    IEEE80211_SMPS_DYNAMIC, i);
+				}
+
+				rcu_read_lock();
+				link_conf = rcu_dereference(vif->link_conf[i]);
+				if (link_conf && !link_conf->dtim_period)
+					protect = true;
+				rcu_read_unlock();
+			}
 
-			if (vif->p2p) {
-				iwl_mvm_update_smps(mvm, vif,
-						    IWL_MVM_SMPS_REQ_PROT,
-						    IEEE80211_SMPS_DYNAMIC, i);
+			if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
+			    protect) {
+				/* If we're not restarting and still haven't
+				 * heard a beacon (dtim period unknown) then
+				 * make sure we still have enough minimum time
+				 * remaining in the time event, since the auth
+				 * might actually have taken quite a while
+				 * (especially for SAE) and so the remaining
+				 * time could be small without us having heard
+				 * a beacon yet.
+				 */
+				iwl_mvm_protect_assoc(mvm, vif, 0);
 			}
 
-			rcu_read_lock();
-			link_conf = rcu_dereference(vif->link_conf[i]);
-			if (link_conf && !link_conf->dtim_period)
-				protect = true;
-			rcu_read_unlock();
-		}
+			iwl_mvm_sf_update(mvm, vif, false);
+
+			/* FIXME: need to decide about misbehaving AP handling */
+			iwl_mvm_power_vif_assoc(mvm, vif);
+		} else if (iwl_mvm_mld_vif_have_valid_ap_sta(mvmvif)) {
+			iwl_mvm_mei_host_disassociated(mvm);
 
-		if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
-		    protect) {
-			/* If we're not restarting and still haven't
-			 * heard a beacon (dtim period unknown) then
-			 * make sure we still have enough minimum time
-			 * remaining in the time event, since the auth
-			 * might actually have taken quite a while
-			 * (especially for SAE) and so the remaining
-			 * time could be small without us having heard
-			 * a beacon yet.
+			/* If update fails - SF might be running in associated
+			 * mode while disassociated - which is forbidden.
 			 */
-			iwl_mvm_protect_assoc(mvm, vif, 0);
+			ret = iwl_mvm_sf_update(mvm, vif, false);
+			WARN_ONCE(ret &&
+				  !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
+					    &mvm->status),
+				  "Failed to update SF upon disassociation\n");
+
+			/* If we get an assert during the connection (after the
+			 * station has been added, but before the vif is set
+			 * to associated), mac80211 will re-add the station and
+			 * then configure the vif. Since the vif is not
+			 * associated, we would remove the station here and
+			 * this would fail the recovery.
+			 */
+			iwl_mvm_mld_vif_delete_all_stas(mvm, vif);
 		}
 
-		iwl_mvm_sf_update(mvm, vif, false);
-
-		/* FIXME: need to decide about misbehaving AP handling */
-		iwl_mvm_power_vif_assoc(mvm, vif);
-	} else if (iwl_mvm_mld_vif_have_valid_ap_sta(mvmvif)) {
-		iwl_mvm_mei_host_disassociated(mvm);
-
-		/* If update fails - SF might be running in associated
-		 * mode while disassociated - which is forbidden.
-		 */
-		ret = iwl_mvm_sf_update(mvm, vif, false);
-		WARN_ONCE(ret &&
-			  !test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-				    &mvm->status),
-			  "Failed to update SF upon disassociation\n");
-
-		/* If we get an assert during the connection (after the
-		 * station has been added, but before the vif is set
-		 * to associated), mac80211 will re-add the station and
-		 * then configure the vif. Since the vif is not
-		 * associated, we would remove the station here and
-		 * this would fail the recovery.
-		 */
-		iwl_mvm_mld_vif_delete_all_stas(mvm, vif);
+		iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
 	}
 
-	iwl_mvm_bss_info_changed_station_assoc(mvm, vif, changes);
+	if (changes & BSS_CHANGED_PS) {
+		ret = iwl_mvm_power_update_mac(mvm);
+		if (ret)
+			IWL_ERR(mvm, "failed to update power mode\n");
+	}
 }
 
 static void
-- 
2.40.1



