Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B601E70C72E
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjEVT0r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjEVT0r (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF6BA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5457628B0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE42BC433D2;
        Mon, 22 May 2023 19:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783605;
        bh=ULgldKHcQe/oiOaENBpSwoJGPj/4CsTxUBA9RRpJm0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sIgj5gmhlc7G1F4hDVITQwRw8nxMZG6IMB+pim7XzHgah69gOvNyfZlvUBz6tnDoX
         ukR9/SBKuWO0gCfUT9JiF40Pqdu5ziZjtWN+TGTtyC0Ert9f/H8TZGqdIz0KymfzR8
         OO/RJu/n4TgLrNCDjVvLWJSF7wFlxzmm7y01Wfug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 101/292] wifi: iwlwifi: mvm: fix ptk_pn memory leak
Date:   Mon, 22 May 2023 20:07:38 +0100
Message-Id: <20230522190408.495957190@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d066a530af8e1833c7ea2cef7784004700c85f79 ]

If adding a key to firmware fails we leak the allocated ptk_pn.
This shouldn't happen in practice, but we should still fix it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230414130637.99446ffd02bc.I82a2ad6ec1395f188e0a1677cc619e3fcb1feac9@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a841268e0709f..801098c5183b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3445,7 +3445,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct iwl_mvm_sta *mvmsta = NULL;
-	struct iwl_mvm_key_pn *ptk_pn;
+	struct iwl_mvm_key_pn *ptk_pn = NULL;
 	int keyidx = key->keyidx;
 	int ret, i;
 	u8 key_offset;
@@ -3590,6 +3590,10 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		if (ret) {
 			IWL_WARN(mvm, "set key failed\n");
 			key->hw_key_idx = STA_KEY_IDX_INVALID;
+			if (ptk_pn) {
+				RCU_INIT_POINTER(mvmsta->ptk_pn[keyidx], NULL);
+				kfree(ptk_pn);
+			}
 			/*
 			 * can't add key for RX, but we don't need it
 			 * in the device for TX so still return 0,
-- 
2.39.2



