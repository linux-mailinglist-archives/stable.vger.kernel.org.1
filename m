Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66F27ECB95
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjKOTXN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjKOTXL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9175819E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12316C433CA;
        Wed, 15 Nov 2023 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076188;
        bh=/VJ2ZdzkLDG/+6dYMv2r52/RVYnEa5UOZtcu3boNoQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnCS7FnPviykLlrOygPgBKaV8srtoIRb2LRkJ6UBXdDAmsxzI1Jc0ekv7olPD2lFv
         e3zmEhVgi+eiRPg921C3scyOxmP2HUzslge++DLAIb5X0p94Oe4aJtacgPuA9QLnNH
         R015np6iF/RCLY5AvE8M3EQjvD9xw9CxtAtrjNeM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 130/550] wifi: iwlwifi: mvm: Fix key flags for IGTK on AP interface
Date:   Wed, 15 Nov 2023 14:11:54 -0500
Message-ID: <20231115191609.694084438@linuxfoundation.org>
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

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 8f9a791a8edd87fa64b35037d9c3bce89a1b8d21 ]

When an IGTK is installed for an AP interface, there is no station
associated with it. However, the MFP flag must be set for the installed
key as otherwise the FW wouldn't use it.

Fix the security key flag to set the MFP flag also when the AP is
an AP interface and the key index matches that of an IGTK.

Fixes: 5c75a208c244 ("wifi: iwlwifi: mvm: support new key API")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231011130030.f67005e2d4d2.I6832c6e87f3c79fff00689eb10a3a30810e1ee83@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index f498206470410..ea3e9e9c6e26c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -96,7 +96,12 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 	if (!sta && vif->type == NL80211_IFTYPE_STATION)
 		sta = mvmvif->ap_sta;
 
-	if (!IS_ERR_OR_NULL(sta) && sta->mfp)
+	/* Set the MFP flag also for an AP interface where the key is an IGTK
+	 * key as in such a case the station would always be NULL
+	 */
+	if ((!IS_ERR_OR_NULL(sta) && sta->mfp) ||
+	    (vif->type == NL80211_IFTYPE_AP &&
+	     (keyconf->keyidx == 4 || keyconf->keyidx == 5)))
 		flags |= IWL_SEC_KEY_FLAG_MFP;
 
 	return flags;
-- 
2.42.0



