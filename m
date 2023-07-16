Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E694D7551DA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGPUA6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjGPUA5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0FAE6A
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C73EF60EAA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D157AC433C7;
        Sun, 16 Jul 2023 20:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537653;
        bh=xAQz2wMuVN2wSH7Gp+YYt9XtZxEW/mVQjQ4OxYgwcwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bLEUej8CCnYVcTY/bz8qE0/Rj3gd3j6MXDSrpluL5xXEr4xwHZh9LLtMZ8o3DlaQ7
         GqWSxIphKeWhPabqjjiUMZrd53KpN2eAFCOBL8H4HQlWk2Sv/jU7jBUKVCFIFGnyPk
         wl+NOe3g0YTJh4hiqvCxAzKOlY9qhse2ZZ70i/78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 172/800] wifi: mac80211: add helpers to access sband iftype data
Date:   Sun, 16 Jul 2023 21:40:25 +0200
Message-ID: <20230716194953.102572859@linuxfoundation.org>
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

[ Upstream commit 1ec7291e247055fab3a088e1a333a31e7c06e2dd ]

There's quite a bit of code accessing sband iftype data
(HE, HE 6 GHz, EHT) and we always need to remember to use
the ieee80211_vif_type_p2p() helper. Add new helpers to
directly get it from the sband/vif rather than having to
call ieee80211_vif_type_p2p().

Convert most code with the following spatch:

    @@
    expression vif, sband;
    @@
    -ieee80211_get_he_iftype_cap(sband, ieee80211_vif_type_p2p(vif))
    +ieee80211_get_he_iftype_cap_vif(sband, vif)

    @@
    expression vif, sband;
    @@
    -ieee80211_get_eht_iftype_cap(sband, ieee80211_vif_type_p2p(vif))
    +ieee80211_get_eht_iftype_cap_vif(sband, vif)

    @@
    expression vif, sband;
    @@
    -ieee80211_get_he_6ghz_capa(sband, ieee80211_vif_type_p2p(vif))
    +ieee80211_get_he_6ghz_capa_vif(sband, vif)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230604120651.db099f49e764.Ie892966c49e22c7b7ee1073bc684f142debfdc84@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: f91295987576 ("wifi: iwlwifi: mvm: correctly access HE/EHT sband capa")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  5 +--
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  5 +--
 include/net/mac80211.h                        | 44 ++++++++++++++++++-
 net/mac80211/eht.c                            |  5 +--
 net/mac80211/he.c                             |  3 +-
 net/mac80211/mlme.c                           | 30 +++++--------
 net/mac80211/util.c                           | 11 ++---
 8 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 17f788a5ff6ba..6c70ca1b524c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2285,8 +2285,7 @@ bool iwl_mvm_is_nic_ack_enabled(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * so take it from one of them.
 	 */
 	sband = mvm->hw->wiphy->bands[NL80211_BAND_2GHZ];
-	own_he_cap = ieee80211_get_he_iftype_cap(sband,
-						 ieee80211_vif_type_p2p(vif));
+	own_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 
 	return (own_he_cap && (own_he_cap->he_cap_elem.mac_cap_info[2] &
 			       IEEE80211_HE_MAC_CAP2_ACK_EN));
@@ -3468,8 +3467,7 @@ static void iwl_mvm_reset_cca_40mhz_workaround(struct iwl_mvm *mvm,
 
 	sband->ht_cap.cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 
 	if (he_cap) {
 		/* we know that ours is writable */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 32625bfacaaef..6ba4ad6b1380b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -192,8 +192,7 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 	WARN_ON(!(sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40));
 	sband->ht_cap.cap &= ~IEEE80211_HT_CAP_SUP_WIDTH_20_40;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 
 	if (he_cap) {
 		/* we know that ours is writable */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index c3a00bfbeef2c..f72d1ca3cfedc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include "rs.h"
 #include "fw-api.h"
@@ -94,8 +94,7 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
 	    IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
 		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
 
-	sband_he_cap = ieee80211_get_he_iftype_cap(sband,
-						   ieee80211_vif_type_p2p(vif));
+	sband_he_cap = ieee80211_get_he_iftype_cap_vif(sband, vif);
 	if (sband_he_cap &&
 	    !(sband_he_cap->he_cap_elem.phy_cap_info[1] &
 			IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac0370e768749..65510cfda37af 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7,7 +7,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2022 Intel Corporation
+ * Copyright (C) 2018 - 2023 Intel Corporation
  */
 
 #ifndef MAC80211_H
@@ -6861,6 +6861,48 @@ ieee80211_vif_type_p2p(struct ieee80211_vif *vif)
 	return ieee80211_iftype_p2p(vif->type, vif->p2p);
 }
 
+/**
+ * ieee80211_get_he_iftype_cap_vif - return HE capabilities for sband/vif
+ * @sband: the sband to search for the iftype on
+ * @vif: the vif to get the iftype from
+ *
+ * Return: pointer to the struct ieee80211_sta_he_cap, or %NULL is none found
+ */
+static inline const struct ieee80211_sta_he_cap *
+ieee80211_get_he_iftype_cap_vif(const struct ieee80211_supported_band *sband,
+				struct ieee80211_vif *vif)
+{
+	return ieee80211_get_he_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
+}
+
+/**
+ * ieee80211_get_he_6ghz_capa_vif - return HE 6 GHz capabilities
+ * @sband: the sband to search for the STA on
+ * @vif: the vif to get the iftype from
+ *
+ * Return: the 6GHz capabilities
+ */
+static inline __le16
+ieee80211_get_he_6ghz_capa_vif(const struct ieee80211_supported_band *sband,
+			       struct ieee80211_vif *vif)
+{
+	return ieee80211_get_he_6ghz_capa(sband, ieee80211_vif_type_p2p(vif));
+}
+
+/**
+ * ieee80211_get_eht_iftype_cap_vif - return ETH capabilities for sband/vif
+ * @sband: the sband to search for the iftype on
+ * @vif: the vif to get the iftype from
+ *
+ * Return: pointer to the struct ieee80211_sta_eht_cap, or %NULL is none found
+ */
+static inline const struct ieee80211_sta_eht_cap *
+ieee80211_get_eht_iftype_cap_vif(const struct ieee80211_supported_band *sband,
+				 struct ieee80211_vif *vif)
+{
+	return ieee80211_get_eht_iftype_cap(sband, ieee80211_vif_type_p2p(vif));
+}
+
 /**
  * ieee80211_update_mu_groups - set the VHT MU-MIMO groud data
  *
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 18bc6b78b2679..ddc7acc68335a 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -2,7 +2,7 @@
 /*
  * EHT handling
  *
- * Copyright(c) 2021-2022 Intel Corporation
+ * Copyright(c) 2021-2023 Intel Corporation
  */
 
 #include "ieee80211_i.h"
@@ -25,8 +25,7 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 	memset(eht_cap, 0, sizeof(*eht_cap));
 
 	if (!eht_cap_ie_elem ||
-	    !ieee80211_get_eht_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
+	    !ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif))
 		return;
 
 	mcs_nss_size = ieee80211_eht_mcs_nss_size(he_cap_ie_elem,
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 0322abae08250..9f5ffdc9db284 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -128,8 +128,7 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	own_he_cap_ptr =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (!own_he_cap_ptr)
 		return;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5a4303130ef22..93da8373583be 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -511,16 +511,14 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 
 	/* don't check HE if we associated as non-HE station */
 	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE ||
-	    !ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif))) {
+	    !ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif)) {
 		he_oper = NULL;
 		eht_oper = NULL;
 	}
 
 	/* don't check EHT if we associated as non-EHT station */
 	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT ||
-	    !ieee80211_get_eht_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
+	    !ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif))
 		eht_oper = NULL;
 
 	/*
@@ -776,8 +774,7 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_he_cap *he_cap;
 	u8 he_cap_size;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(&sdata->vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (WARN_ON(!he_cap))
 		return;
 
@@ -806,10 +803,8 @@ static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	u8 eht_cap_size;
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(&sdata->vif));
-	eht_cap = ieee80211_get_eht_iftype_cap(sband,
-					       ieee80211_vif_type_p2p(&sdata->vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
+	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
 
 	/*
 	 * EHT capabilities element is only added if the HE capabilities element
@@ -3949,8 +3944,7 @@ static bool ieee80211_twt_req_supported(struct ieee80211_sub_if_data *sdata,
 					const struct ieee802_11_elems *elems)
 {
 	const struct ieee80211_sta_he_cap *own_he_cap =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 
 	if (elems->ext_capab_len < 10)
 		return false;
@@ -3986,8 +3980,7 @@ static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
 					struct link_sta_info *link_sta)
 {
 	const struct ieee80211_sta_he_cap *own_he_cap =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 
 	return bss_conf->he_support &&
 		(link_sta->pub->he_cap.he_cap_elem.mac_cap_info[2] &
@@ -4624,8 +4617,7 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_he_operation *he_op)
 {
 	const struct ieee80211_sta_he_cap *sta_he_cap =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
+		ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	u16 ap_min_req_set;
 	int i;
 
@@ -4759,15 +4751,13 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
-	if (!ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif))) {
+	if (!ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif)) {
 		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
 		*conn_flags |= IEEE80211_CONN_DISABLE_HE;
 		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
 
-	if (!ieee80211_get_eht_iftype_cap(sband,
-					  ieee80211_vif_type_p2p(&sdata->vif))) {
+	if (!ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif)) {
 		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
 		*conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 3bd07a0a782f7..74bcc9590c759 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -6,7 +6,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  *
  * utilities for mac80211
  */
@@ -2121,8 +2121,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		*offset = noffset;
 	}
 
-	he_cap = ieee80211_get_he_iftype_cap(sband,
-					     ieee80211_vif_type_p2p(&sdata->vif));
+	he_cap = ieee80211_get_he_iftype_cap_vif(sband, &sdata->vif);
 	if (he_cap &&
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
 					 IEEE80211_CHAN_NO_HE)) {
@@ -2131,8 +2130,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 			goto out_err;
 	}
 
-	eht_cap = ieee80211_get_eht_iftype_cap(sband,
-					       ieee80211_vif_type_p2p(&sdata->vif));
+	eht_cap = ieee80211_get_eht_iftype_cap_vif(sband, &sdata->vif);
 
 	if (eht_cap &&
 	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
@@ -2150,8 +2148,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_supported_band *sband6;
 
 		sband6 = local->hw.wiphy->bands[NL80211_BAND_6GHZ];
-		he_cap = ieee80211_get_he_iftype_cap(sband6,
-				ieee80211_vif_type_p2p(&sdata->vif));
+		he_cap = ieee80211_get_he_iftype_cap_vif(sband6, &sdata->vif);
 
 		if (he_cap) {
 			enum nl80211_iftype iftype =
-- 
2.39.2



