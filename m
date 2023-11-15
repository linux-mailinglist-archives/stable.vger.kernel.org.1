Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36BE7ECDEE
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjKOTjR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjKOTjQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42FFB9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B155C433C8;
        Wed, 15 Nov 2023 19:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077152;
        bh=WDy0XTXzku5+TgvOiisr9yp3kAMJktf+f+ZxPBECRbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnVvsmto1bkW0k/BEWtU2RDc0QMXHxaVNSTAREBwuAtgli+zwoznsdMt4EgpplPRx
         01xiuYs7tNNJ9a6w64xcjtQP0Cdec9mc2WwY+nbL2VPcJn3aBUiPso+Qmo+PPhDFim
         nWsPYnBSt+X/KsdTNkeyHLvYi/260/N8VG+1ssJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 140/603] wifi: iwlwifi: mvm: change iwl_mvm_flush_sta() API
Date:   Wed, 15 Nov 2023 14:11:25 -0500
Message-ID: <20231115191622.875957271@linuxfoundation.org>
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

[ Upstream commit 391762969769b089c808defc8fce5544a945f9eb ]

This API is type unsafe and needs an extra parameter to know
what kind of station was passed, so it has two, but really it
only needs two values. Just pass the values instead of doing
this type-unsafe dance, which will also make it better to use
for multi-link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231011130030.aeb3bf4204cd.I5b0e6d64a67455784bc8fbdaf9ceaf03699d9ce1@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 43874283ce6c ("wifi: iwlwifi: mvm: fix iwl_mvm_mac_flush_sta()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  |  6 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   |  9 ++++++---
 .../wireless/intel/iwlwifi/mvm/time-event.c    |  7 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    | 18 ++----------------
 6 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a3058d7c77574..e68026a657059 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5579,7 +5579,8 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		}
 
 		if (drop) {
-			if (iwl_mvm_flush_sta(mvm, mvmsta, false))
+			if (iwl_mvm_flush_sta(mvm, mvmsta->deflink.sta_id,
+					      mvmsta->tfd_queue_msk))
 				IWL_ERR(mvm, "flush request fail\n");
 		} else {
 			if (iwl_mvm_has_new_tx_api(mvm))
@@ -5616,7 +5617,8 @@ void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 		mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-		if (iwl_mvm_flush_sta(mvm, mvmsta, false))
+		if (iwl_mvm_flush_sta(mvm, mvmsta->deflink.sta_id,
+				      mvmsta->tfd_queue_msk))
 			IWL_ERR(mvm, "flush request fail\n");
 	}
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 524852cf5cd2d..56f51344c193c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -347,7 +347,7 @@ static int iwl_mvm_mld_rm_int_sta(struct iwl_mvm *mvm,
 		return -EINVAL;
 
 	if (flush)
-		iwl_mvm_flush_sta(mvm, int_sta, true);
+		iwl_mvm_flush_sta(mvm, int_sta->sta_id, int_sta->tfd_queue_msk);
 
 	iwl_mvm_mld_disable_txq(mvm, BIT(int_sta->sta_id), queuptr, tid);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b596eca562166..218f3bc31104b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1658,7 +1658,7 @@ const char *iwl_mvm_get_tx_fail_reason(u32 status);
 static inline const char *iwl_mvm_get_tx_fail_reason(u32 status) { return ""; }
 #endif
 int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk);
-int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal);
+int iwl_mvm_flush_sta(struct iwl_mvm *mvm, u32 sta_id, u32 tfd_queue_mask);
 int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids);
 
 /* Utils to extract sta related data */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 3b9a343d4f672..ebbe165510587 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2097,7 +2097,8 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		return ret;
 
 	/* flush its queues here since we are freeing mvm_sta */
-	ret = iwl_mvm_flush_sta(mvm, mvm_sta, false);
+	ret = iwl_mvm_flush_sta(mvm, mvm_sta->deflink.sta_id,
+				mvm_sta->tfd_queue_msk);
 	if (ret)
 		return ret;
 	if (iwl_mvm_has_new_tx_api(mvm)) {
@@ -2408,7 +2409,8 @@ void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	iwl_mvm_flush_sta(mvm, &mvmvif->deflink.bcast_sta, true);
+	iwl_mvm_flush_sta(mvm, mvmvif->deflink.bcast_sta.sta_id,
+			  mvmvif->deflink.bcast_sta.tfd_queue_msk);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
@@ -2664,7 +2666,8 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	iwl_mvm_flush_sta(mvm, &mvmvif->deflink.mcast_sta, true);
+	iwl_mvm_flush_sta(mvm, mvmvif->deflink.mcast_sta.sta_id,
+			  mvmvif->deflink.mcast_sta.tfd_queue_msk);
 
 	iwl_mvm_disable_txq(mvm, NULL, mvmvif->deflink.mcast_sta.sta_id,
 			    &mvmvif->deflink.cab_queue, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index ff213247569a7..158266719ffd7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -81,8 +81,8 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 			struct ieee80211_vif *vif = mvm->p2p_device_vif;
 
 			mvmvif = iwl_mvm_vif_from_mac80211(vif);
-			iwl_mvm_flush_sta(mvm, &mvmvif->deflink.bcast_sta,
-					  true);
+			iwl_mvm_flush_sta(mvm, mvmvif->deflink.bcast_sta.sta_id,
+					  mvmvif->deflink.bcast_sta.tfd_queue_msk);
 
 			if (mvm->mld_api_is_used) {
 				iwl_mvm_mld_rm_bcast_sta(mvm, vif,
@@ -113,7 +113,8 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 	 */
 	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status)) {
 		/* do the same in case of hot spot 2.0 */
-		iwl_mvm_flush_sta(mvm, &mvm->aux_sta, true);
+		iwl_mvm_flush_sta(mvm, mvm->aux_sta.sta_id,
+				  mvm->aux_sta.tfd_queue_msk);
 
 		if (mvm->mld_api_is_used) {
 			iwl_mvm_mld_rm_aux_sta(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 8158e6d9ef190..8bdb239295c39 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2297,24 +2297,10 @@ int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids)
 	return ret;
 }
 
-int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal)
+int iwl_mvm_flush_sta(struct iwl_mvm *mvm, u32 sta_id, u32 tfd_queue_mask)
 {
-	u32 sta_id, tfd_queue_msk;
-
-	if (internal) {
-		struct iwl_mvm_int_sta *int_sta = sta;
-
-		sta_id = int_sta->sta_id;
-		tfd_queue_msk = int_sta->tfd_queue_msk;
-	} else {
-		struct iwl_mvm_sta *mvm_sta = sta;
-
-		sta_id = mvm_sta->deflink.sta_id;
-		tfd_queue_msk = mvm_sta->tfd_queue_msk;
-	}
-
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return iwl_mvm_flush_sta_tids(mvm, sta_id, 0xffff);
 
-	return iwl_mvm_flush_tx_path(mvm, tfd_queue_msk);
+	return iwl_mvm_flush_tx_path(mvm, tfd_queue_mask);
 }
-- 
2.42.0



