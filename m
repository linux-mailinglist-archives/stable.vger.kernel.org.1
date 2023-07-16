Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4990C7551ED
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjGPUBq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjGPUBp (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49457EE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:01:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF1560E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF151C433C8;
        Sun, 16 Jul 2023 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537703;
        bh=RQuXPQ014WmnIqQk4dKJOy0/ksOV6VUVIbaw/n7+mec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hj5RkmUwmg76k8SYyzjcriDA874Kk/12Uud7+oYcZjunFTzDGJMm/tF/9MSeIxWaU
         zy6PpmsEVIoiOklZOK7FvvA4Yd4FE39cW6tyJLLZJrv8HGwW8/3lH1zM7JWT726ggQ
         mFYR85uDq6icRXC9MeD3zwyQiZG7HZCnoSKz7FBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 191/800] wifi: iwlwifi: mvm: check only affected links
Date:   Sun, 16 Jul 2023 21:40:44 +0200
Message-ID: <20230716194953.540306061@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit de1076008148460fe273e6d39158faffcc954991 ]

When hostapd starts up, it may start up with only one link
while the other is still scanning for overlapping BSSes. A
station might start to connect at this point, but we run
into this warning instead. Since there's no need to check
for _all_ links, restrict the check to just the affected
links that the STA will be using.

Fixes: 57974a55d995 ("wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()")
Reported-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230620125813.c3d5a006ec21.Ib4715381f598f4c18d67cd9598ebd5cdbe7d2b09@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 6c70ca1b524c4..f23cd100cf252 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3846,6 +3846,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
+	struct ieee80211_link_sta *link_sta;
 	unsigned int link_id;
 	int ret;
 
@@ -3887,7 +3888,7 @@ int iwl_mvm_mac_sta_state_common(struct ieee80211_hw *hw,
 	mutex_lock(&mvm->mutex);
 
 	/* this would be a mac80211 bug ... but don't crash */
-	for_each_mvm_vif_valid_link(mvmvif, link_id) {
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		if (WARN_ON_ONCE(!mvmvif->link[link_id]->phy_ctxt)) {
 			mutex_unlock(&mvm->mutex);
 			return test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED,
-- 
2.39.2



