Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3F7ECDF8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbjKOTjb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjKOTja (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:39:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E825B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:39:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7AFC433C7;
        Wed, 15 Nov 2023 19:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077166;
        bh=nyXd9pkV2hyd0bW9i29JGQVGLxXfi1LeRhjedBp20oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WABVMcJgdYepIO9VwVTfkjWEoV5/hrHVWy67ofco7SCllGl8Yqcp4Zuppkve6L27q
         ONiBJd/MKKFi5TlKD1BxMvhZ4Mt1icfvZV7Tw9iOm2wNZWFj38JBOugwz9j/hkAnFU
         Ur/YVgQ/fB53ZOtPMt8MqLp03bErA+rfzteG820I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 142/603] wifi: iwlwifi: mvm: remove TDLS stations from FW
Date:   Wed, 15 Nov 2023 14:11:27 -0500
Message-ID: <20231115191623.020763884@linuxfoundation.org>
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

[ Upstream commit 7b404c5cff3d4270fcd5212b6776c8484623ac74 ]

When we remove TDLS stations, we need to remove them from FW
immediately, even while associated. Some previous refactoring
here lost the sta ID condition, add it back.

Fixes: 57974a55d995 ("wifi: iwlwifi: mvm: refactor iwl_mvm_mac_sta_state_common()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231011130030.933011e710a9.I77c069c781e8b2b698b86cc3f43fc3c7e2dde114@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ebbe165510587..2c231f4623893 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2059,7 +2059,8 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		*status = IWL_MVM_QUEUE_FREE;
 	}
 
-	if (vif->type == NL80211_IFTYPE_STATION) {
+	if (vif->type == NL80211_IFTYPE_STATION &&
+	    mvm_link->ap_sta_id == sta_id) {
 		/* if associated - we can't remove the AP STA now */
 		if (vif->cfg.assoc)
 			return true;
-- 
2.42.0



