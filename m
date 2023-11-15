Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B977ECB8C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjKOTXB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjKOTXA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE5919F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:22:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7596C433C9;
        Wed, 15 Nov 2023 19:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076176;
        bh=j/qFsTwM+y2PlXrmdCjiOcmAcbwwBSSrJfAl3tyqCWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qs412+dOyfkcPoDn1ty5wnevDknK9I8h/iXa9zXgHlROIluJmFEgdH2WXEWPe7p/y
         7QKxZRvM0M4DDXbgOJ2Tw1+pDgUoeUK7MsDHUc70rhmtToz4ze2iimaOzei6IdbEWJ
         ni1oeJ60xE7gDQsPJih9X15UA3K2CEeBCmJNWtuU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 123/550] wifi: iwlwifi: mvm: update stations MFP flag after association
Date:   Wed, 15 Nov 2023 14:11:47 -0500
Message-ID: <20231115191609.216853369@linuxfoundation.org>
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
index ce7905faa08ff..81b0b4284882e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3790,6 +3790,12 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 
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



