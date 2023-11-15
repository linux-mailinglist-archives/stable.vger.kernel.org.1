Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A07ECB98
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjKOTXR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjKOTXQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F5AA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D39CC433CB;
        Wed, 15 Nov 2023 19:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076192;
        bh=xNYMBtgbdPBeoI751MeIS7J3GxXu2qUGRW2D6AV/Qa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=we/mqiiu5VMVqRGLzg/BzqccgWovJ3Y0En5kBlxwgqATlvuJVU2oXu6y5kTEA2jcr
         1HMMzvB/huy0Z6543tiNYeDFYX/4IF7gvHsHR4ZYUCyuXM//9+FCUC6FJbDH8xhm/Z
         23pEsmUYW4BpJ5hVHMCJd1hU7Fg17QwoW3O6FKag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 133/550] wifi: iwlwifi: mvm: fix iwl_mvm_mac_flush_sta()
Date:   Wed, 15 Nov 2023 14:11:57 -0500
Message-ID: <20231115191609.905375365@linuxfoundation.org>
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

[ Upstream commit 43874283ce6c5bd32ac9d30878b2c96a974357cb ]

When I implemented iwl_mvm_mac_flush_sta() I completely botched it;
it basically always happens after the iwl_mvm_sta_pre_rcu_remove()
call, and that already clears mvm->fw_id_to_mac_id[] entries, so we
cannot rely on those at iwl_mvm_mac_flush_sta() time. This means it
never did anything.

Fix this by just going through the station IDs and now with the new
API for iwl_mvm_flush_sta(), call those.

Fixes: a6cc6ccb1c8a ("wifi: iwlwifi: mvm: support new flush_sta method")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231011130030.0b5878e93118.I1093e60163052e7be64d2b01424097cd6a272979@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 069aba0e064aa..e2288fd601a6a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5607,22 +5607,20 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
+	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	int i;
+	struct iwl_mvm_link_sta *mvm_link_sta;
+	struct ieee80211_link_sta *link_sta;
+	int link_id;
 
 	mutex_lock(&mvm->mutex);
-	for (i = 0; i < mvm->fw->ucode_capa.num_stations; i++) {
-		struct iwl_mvm_sta *mvmsta;
-		struct ieee80211_sta *tmp;
-
-		tmp = rcu_dereference_protected(mvm->fw_id_to_mac_id[i],
-						lockdep_is_held(&mvm->mutex));
-		if (tmp != sta)
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
+		mvm_link_sta = rcu_dereference_protected(mvmsta->link[link_id],
+							 lockdep_is_held(&mvm->mutex));
+		if (!mvm_link_sta)
 			continue;
 
-		mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
-		if (iwl_mvm_flush_sta(mvm, mvmsta->deflink.sta_id,
+		if (iwl_mvm_flush_sta(mvm, mvm_link_sta->sta_id,
 				      mvmsta->tfd_queue_msk))
 			IWL_ERR(mvm, "flush request fail\n");
 	}
-- 
2.42.0



