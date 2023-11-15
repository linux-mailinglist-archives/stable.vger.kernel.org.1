Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F317ECDD5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjKOTip (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbjKOTio (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F674A4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02747C433C7;
        Wed, 15 Nov 2023 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077121;
        bh=i8uKfHK23vQ0rdz2tVpVDmNrhSZGh7doKZ0humXa+0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p70Cp5NPLADiH8eCBfXWc77s8YQJDN3DXfeAQvP2mMtUG8dQk7FOM4eX+SltBYTEy
         xb3CHE8rV1rKn7lB3MDclR/sUJysh9CRvO0bN6wBKLJ1/lOluwB8ZQhD+aisPbEr1f
         lkorIbOZMDgP4tbg4swdH4ZiCJ7kNhlUWqEO1qsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 131/603] wifi: iwlwifi: mvm: update stations MFP flag after association
Date:   Wed, 15 Nov 2023 14:11:16 -0500
Message-ID: <20231115191622.314642681@linuxfoundation.org>
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

From: Avraham Stern <avraham.stern@intel.com>

[ Upstream commit 5a86dcb4a908845e6b7ff39b78fb1141b895408f ]

The management frames protection flag is always set when the station
is not yet authorized. However, it was not cleared after association
even if the association did not use MFP. As a result, all public
action frames are not parsed by fw (which will cause FTM to fail,
for example). Update the station MFP flag after the station is
authorized.

Fixes: 4c8d5c8d079e ("wifi: iwlwifi: mvm: tell firmware about per-STA MFP enablement")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230926110319.2488cbd01bde.Ic0f08b7d3efcbdce27ec897f84d740fec8d169ef@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5918c1f2b10c3..f852e5d770d9b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3791,6 +3791,12 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
 	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
 
+	/* MFP is set by default before the station is authorized.
+	 * Clear it here in case it's not used.
+	 */
+	if (!sta->mfp)
+		return callbacks->update_sta(mvm, vif, sta);
+
 	return 0;
 }
 
-- 
2.42.0



