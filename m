Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B407ECDDA
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbjKOTit (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjKOTis (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29641A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7DDC433C9;
        Wed, 15 Nov 2023 19:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077124;
        bh=YJnpRv/A/FXD0QiClyoamxD0soaZojfcKe5wL1xWyDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zL5XXRRm3wxZZifMnFl+8lhQRj8XT6aj+h2GQB3MkNWvqsGbbcKnL+GmUmvZLIs9P
         OSwmMeXk+HsQPS1+xJVg/5XEutvpxfY1T4pcTjUQ/oyv7R6JIRGlTiCI6fcflA+DAl
         vZYMnoYjvbk0kJ1lFB3hzKtH1P+a1E2a0BbSXXkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 132/603] wifi: iwlwifi: mvm: fix removing pasn station for responder
Date:   Wed, 15 Nov 2023 14:11:17 -0500
Message-ID: <20231115191622.394218436@linuxfoundation.org>
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

[ Upstream commit ff2687612c21a87a58c76099f3d59f8db376b995 ]

In case of MLD operation the station should be removed using the
mld api.

Fixes: fd940de72d49 ("wifi: iwlwifi: mvm: FTM responder MLO support")
Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230926110319.7eb353abb95c.I2b30be09b99f5a2379956e010bafaa465ff053ba@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
index b49781d1a07a7..10b9219b3bfd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include <linux/etherdevice.h>
@@ -302,7 +302,12 @@ static void iwl_mvm_resp_del_pasn_sta(struct iwl_mvm *mvm,
 				      struct iwl_mvm_pasn_sta *sta)
 {
 	list_del(&sta->list);
-	iwl_mvm_rm_sta_id(mvm, vif, sta->int_sta.sta_id);
+
+	if (iwl_mvm_has_mld_api(mvm->fw))
+		iwl_mvm_mld_rm_sta_id(mvm, sta->int_sta.sta_id);
+	else
+		iwl_mvm_rm_sta_id(mvm, vif, sta->int_sta.sta_id);
+
 	iwl_mvm_dealloc_int_sta(mvm, &sta->int_sta);
 	kfree(sta);
 }
-- 
2.42.0



