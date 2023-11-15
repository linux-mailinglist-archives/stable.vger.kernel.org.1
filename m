Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA697ECBA6
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjKOTXg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjKOTXe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:23:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3B112C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:23:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921EBC433C8;
        Wed, 15 Nov 2023 19:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076210;
        bh=EPjCkWqFoxrswzQ2azdRO8ejzngVu+T9oeaKZY3lsbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pafVwKVT0s5dolj5he83Vsp9cFMVoiNc+fxzZ0YmhhcmfGVHaBOHy8rzWSy5ms+wh
         EL0sZ+pQwkGF18TCfXHjdcVEXbtbzievnjSXxM98prEydn3pvl4PqCvYuShAg2xV6U
         tUprPOE/5fK4dAE2KipFeR/GZ/YXE4AWK2+D98Zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 138/550] wifi: iwlwifi: mvm: update IGTK in mvmvif upon D3 resume
Date:   Wed, 15 Nov 2023 14:12:02 -0500
Message-ID: <20231115191610.254028229@linuxfoundation.org>
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

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

[ Upstream commit ac0c6fdc4c56b669abc1c4a323f1c7a3a1422dd2 ]

During the D3 resume flow, all new rekeys are passed from the FW.
Because the FW supports only one IGTK at a time, every IGTK rekey
update should be done by removing the last IGTK. The mvmvif holds a
pointer to the last IGTK for that reason and thus should be updated
when a new IGTK is passed upon resume.

Fixes: 04f78e242fff ("wifi: iwlwifi: mvm: Add support for IGTK in D3 resume flow")
Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20231017115047.8ceaf7e5ece7.Ief444f6a2703ed76648b4d414f12bb4130bab36e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index f6488b4bbe68b..be2602d8c5bfa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2012,6 +2012,16 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 	if (IS_ERR(key_config))
 		return false;
 	ieee80211_set_key_rx_seq(key_config, 0, &seq);
+
+	if (key_config->keyidx == 4 || key_config->keyidx == 5) {
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+		int link_id = vif->active_links ? __ffs(vif->active_links) : 0;
+		struct iwl_mvm_vif_link_info *mvm_link =
+			mvmvif->link[link_id];
+
+		mvm_link->igtk = key_config;
+	}
+
 	return true;
 }
 
-- 
2.42.0



