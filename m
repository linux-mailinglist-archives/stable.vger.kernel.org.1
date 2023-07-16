Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0D7551DB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjGPUBB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGPUA7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB1DE59
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92FB260E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E429C433C8;
        Sun, 16 Jul 2023 20:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537656;
        bh=62K0WszaT3mlMketJ5ZweNUrbkN1HHBvu6cDd0gDNZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BG/3MW4jAT8qLN1pAMEGWkz2KW0i04SfaSdrrr5CK59Xtmek/4yKPz3jTva5xMPXw
         FJfSYRs+3BqmnYLCbvlQ54p/ZdUqcGGyWF7EfrMEzRYbS46PgIVIb+VrQRc+/ywfvg
         USoKtXRm6fL8qgcGrdkH9l/81AqlxCm6sFFKd/ho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 173/800] wifi: iwlwifi: mvm: add support for Extra EHT LTF
Date:   Sun, 16 Jul 2023 21:40:26 +0200
Message-ID: <20230716194953.125711498@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

[ Upstream commit 18c0ffb404db2093b6afdc8ae15f18ba3975e1ed ]

Add support for Extra EHT LTF defined in 9.4.2.313
EHT Capabilities element.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230613155501.de019d7cc174.I806f0f6042b89274192701a60b4f7900822db666@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: f91295987576 ("wifi: iwlwifi: mvm: correctly access HE/EHT sband capa")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h    |  2 ++
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c    |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 15 +++++++++++++++
 include/linux/ieee80211.h                         |  1 +
 4 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index c9a48fc5fac88..a1a272433b09b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -21,6 +21,7 @@
  * @IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_2_MSK: enable HE Dual Carrier Modulation
  *					    for BPSK (MCS 0) with 2 spatial
  *					    streams
+ * @IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK: enable support for EHT extra LTF
  */
 enum iwl_tlc_mng_cfg_flags {
 	IWL_TLC_MNG_CFG_FLAGS_STBC_MSK			= BIT(0),
@@ -28,6 +29,7 @@ enum iwl_tlc_mng_cfg_flags {
 	IWL_TLC_MNG_CFG_FLAGS_HE_STBC_160MHZ_MSK	= BIT(2),
 	IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_1_MSK		= BIT(3),
 	IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_2_MSK		= BIT(4),
+	IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK		= BIT(6),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 7dcb1c3ab7282..be0eb69f2248a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -975,6 +975,8 @@ iwl_nvm_fixup_sband_iftd(struct iwl_trans *trans,
 		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[6] &=
 			~(IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK |
 			  IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP);
+		iftype_data->eht_cap.eht_cap_elem.phy_cap_info[5] |=
+			IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF;
 	}
 
 	if (fw_has_capa(&fw->ucode_capa, IWL_UCODE_TLV_CAPA_BROADCAST_TWT))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index f72d1ca3cfedc..8a5341c37aa21 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -591,6 +591,21 @@ void iwl_mvm_rs_fw_rate_init(struct iwl_mvm *mvm,
 	int cmd_ver;
 	int ret;
 
+	/* Enable external EHT LTF only for GL device and if there's
+	 * mutual support by AP and client
+	 */
+	if (CSR_HW_REV_TYPE(mvm->trans->hw_rev) == IWL_CFG_MAC_TYPE_GL &&
+	    sband->iftype_data->eht_cap.has_eht &&
+	    sband->iftype_data->eht_cap.eht_cap_elem.phy_cap_info[5] &
+	    IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF &&
+	    link_sta->eht_cap.has_eht &&
+	    link_sta->eht_cap.eht_cap_elem.phy_cap_info[5] &
+	    IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF) {
+		IWL_DEBUG_RATE(mvm, "Set support for Extra EHT LTF\n");
+		cfg_cmd.flags |=
+			cpu_to_le16(IWL_TLC_MNG_CFG_FLAGS_EHT_EXTRA_LTF_MSK);
+	}
+
 	rcu_read_lock();
 	mvm_link_sta = rcu_dereference(mvmsta->link[link_id]);
 	if (WARN_ON_ONCE(!mvm_link_sta)) {
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index c4cf296e7eafe..141c0cf65f2d9 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2856,6 +2856,7 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 
 /* Maximum number of supported EHT LTF is split */
 #define IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LTF_MASK	0xc0
+#define IEEE80211_EHT_PHY_CAP5_SUPP_EXTRA_EHT_LTF		0x40
 #define IEEE80211_EHT_PHY_CAP6_MAX_NUM_SUPP_EHT_LTF_MASK	0x07
 
 #define IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK			0x78
-- 
2.39.2



