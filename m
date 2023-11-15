Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF267ECD15
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbjKOTeV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjKOTeQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:34:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28169D59
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:34:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6EC433CC;
        Wed, 15 Nov 2023 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076852;
        bh=Svh4VBjL1vGekOSyhGtAd2P1uns8ImDTTNYplEiszgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHI9pd/CvbNZhKbpdS69zNCfD4eq5rQ6Fi1HzwTaTUpmfEehXX3rxvIHia7EzkQ1s
         DK5I+ZepPZNmFb0i7KNJZww5deUNyLMjtLJ/LgeMEUsUV15ZR9cG2r5Rrqa4kMCTVY
         TTRePTPJDldyWDF9R6xJYMmGDSVNsMXODz32FSGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 046/603] wifi: iwlwifi: dont use an uninitialized variable
Date:   Wed, 15 Nov 2023 14:09:51 -0500
Message-ID: <20231115191616.380055314@linuxfoundation.org>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit c46fcc6e43d617252945e706f04e5f82a59f2b8e ]

Don't use variable err uninitialized.
The reason for removing the check instead of initializing it
in the beginning of the function is because that way
static checkers will be able to catch issues if we do something
wrong in the future.

Fixes: bf976c814c86 ("wifi: iwlwifi: mvm: implement link change ops")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230830112059.431b01bd8779.I31fc4ab35f551b85a10f974a6b18fc30191e9c35@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index b719843e94576..778a311b500bc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -1089,9 +1089,6 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 		}
 	}
 
-	if (err)
-		goto out_err;
-
 	err = 0;
 	if (new_links == 0) {
 		mvmvif->link[0] = &mvmvif->deflink;
-- 
2.42.0



