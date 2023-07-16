Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5897551FF
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGPUCg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjGPUCf (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97B5FD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5730B60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B76C433C8;
        Sun, 16 Jul 2023 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537753;
        bh=cIZMKgaPfxPDrswJ7WQS5iw93ukMLhGl6OpqzQADUuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TG2zrkebveM5w4zUJ9f6FDMSZm/CNbcLVd3FmkipAVXcjsuCl5RAfma6xgOXNgNge
         HLjgCdu4/ICja3B7tqQAw+1WaVaxDFfOvKqsf1kDjP0hjlqHAg7J7Gk6fGNJwDELwK
         FJLMpt6SClPwVghX9MNf2RRPVVjzAqtQd+xktzQo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 179/800] wifi: cfg80211: drop incorrect nontransmitted BSS update code
Date:   Sun, 16 Jul 2023 21:40:32 +0200
Message-ID: <20230716194953.262106556@linuxfoundation.org>
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

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 39432f8a3752a87a53fd8d5e51824a43aaae5cab ]

The removed code ran for any BSS that was not included in the MBSSID
element in order to update it. However, instead of using the correct
inheritance rules, it would simply copy the elements from the
transmitting AP. The result is that we would report incorrect elements
in this case.

After some discussions, it seems that there are likely not even APs
actually using this feature. Either way, removing the code decreases
complexity and makes the cfg80211 behaviour more correct.

Fixes: 0b8fb8235be8 ("cfg80211: Parsing of Multiple BSSID information in scanning")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230616094949.cfd6d8db1f26.Ia1044902b86cd7d366400a4bfb93691b8f05d68c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 154 ++++----------------------------------------
 1 file changed, 11 insertions(+), 143 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index ae1f249d04ab3..396c63431e1f3 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2296,118 +2296,6 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_inform_bss_data);
 
-static void
-cfg80211_parse_mbssid_frame_data(struct wiphy *wiphy,
-				 struct cfg80211_inform_bss *data,
-				 struct ieee80211_mgmt *mgmt, size_t len,
-				 struct cfg80211_non_tx_bss *non_tx_data,
-				 gfp_t gfp)
-{
-	enum cfg80211_bss_frame_type ftype;
-	const u8 *ie = mgmt->u.probe_resp.variable;
-	size_t ielen = len - offsetof(struct ieee80211_mgmt,
-				      u.probe_resp.variable);
-
-	ftype = ieee80211_is_beacon(mgmt->frame_control) ?
-		CFG80211_BSS_FTYPE_BEACON : CFG80211_BSS_FTYPE_PRESP;
-
-	cfg80211_parse_mbssid_data(wiphy, data, ftype, mgmt->bssid,
-				   le64_to_cpu(mgmt->u.probe_resp.timestamp),
-				   le16_to_cpu(mgmt->u.probe_resp.beacon_int),
-				   ie, ielen, non_tx_data, gfp);
-}
-
-static void
-cfg80211_update_notlisted_nontrans(struct wiphy *wiphy,
-				   struct cfg80211_bss *nontrans_bss,
-				   struct ieee80211_mgmt *mgmt, size_t len)
-{
-	u8 *ie, *new_ie, *pos;
-	const struct element *nontrans_ssid;
-	const u8 *trans_ssid, *mbssid;
-	size_t ielen = len - offsetof(struct ieee80211_mgmt,
-				      u.probe_resp.variable);
-	size_t new_ie_len;
-	struct cfg80211_bss_ies *new_ies;
-	const struct cfg80211_bss_ies *old;
-	size_t cpy_len;
-
-	lockdep_assert_held(&wiphy_to_rdev(wiphy)->bss_lock);
-
-	ie = mgmt->u.probe_resp.variable;
-
-	new_ie_len = ielen;
-	trans_ssid = cfg80211_find_ie(WLAN_EID_SSID, ie, ielen);
-	if (!trans_ssid)
-		return;
-	new_ie_len -= trans_ssid[1];
-	mbssid = cfg80211_find_ie(WLAN_EID_MULTIPLE_BSSID, ie, ielen);
-	/*
-	 * It's not valid to have the MBSSID element before SSID
-	 * ignore if that happens - the code below assumes it is
-	 * after (while copying things inbetween).
-	 */
-	if (!mbssid || mbssid < trans_ssid)
-		return;
-	new_ie_len -= mbssid[1];
-
-	nontrans_ssid = ieee80211_bss_get_elem(nontrans_bss, WLAN_EID_SSID);
-	if (!nontrans_ssid)
-		return;
-
-	new_ie_len += nontrans_ssid->datalen;
-
-	/* generate new ie for nontrans BSS
-	 * 1. replace SSID with nontrans BSS' SSID
-	 * 2. skip MBSSID IE
-	 */
-	new_ie = kzalloc(new_ie_len, GFP_ATOMIC);
-	if (!new_ie)
-		return;
-
-	new_ies = kzalloc(sizeof(*new_ies) + new_ie_len, GFP_ATOMIC);
-	if (!new_ies)
-		goto out_free;
-
-	pos = new_ie;
-
-	/* copy the nontransmitted SSID */
-	cpy_len = nontrans_ssid->datalen + 2;
-	memcpy(pos, nontrans_ssid, cpy_len);
-	pos += cpy_len;
-	/* copy the IEs between SSID and MBSSID */
-	cpy_len = trans_ssid[1] + 2;
-	memcpy(pos, (trans_ssid + cpy_len), (mbssid - (trans_ssid + cpy_len)));
-	pos += (mbssid - (trans_ssid + cpy_len));
-	/* copy the IEs after MBSSID */
-	cpy_len = mbssid[1] + 2;
-	memcpy(pos, mbssid + cpy_len, ((ie + ielen) - (mbssid + cpy_len)));
-
-	/* update ie */
-	new_ies->len = new_ie_len;
-	new_ies->tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
-	new_ies->from_beacon = ieee80211_is_beacon(mgmt->frame_control);
-	memcpy(new_ies->data, new_ie, new_ie_len);
-	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
-		old = rcu_access_pointer(nontrans_bss->proberesp_ies);
-		rcu_assign_pointer(nontrans_bss->proberesp_ies, new_ies);
-		rcu_assign_pointer(nontrans_bss->ies, new_ies);
-		if (old)
-			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
-	} else {
-		old = rcu_access_pointer(nontrans_bss->beacon_ies);
-		rcu_assign_pointer(nontrans_bss->beacon_ies, new_ies);
-		cfg80211_update_hidden_bsses(bss_from_pub(nontrans_bss),
-					     new_ies, old);
-		rcu_assign_pointer(nontrans_bss->ies, new_ies);
-		if (old)
-			kfree_rcu((struct cfg80211_bss_ies *)old, rcu_head);
-	}
-
-out_free:
-	kfree(new_ie);
-}
-
 /* cfg80211_inform_bss_width_frame helper */
 static struct cfg80211_bss *
 cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
@@ -2540,51 +2428,31 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 			       struct ieee80211_mgmt *mgmt, size_t len,
 			       gfp_t gfp)
 {
-	struct cfg80211_bss *res, *tmp_bss;
+	struct cfg80211_bss *res;
 	const u8 *ie = mgmt->u.probe_resp.variable;
-	const struct cfg80211_bss_ies *ies1, *ies2;
 	size_t ielen = len - offsetof(struct ieee80211_mgmt,
 				      u.probe_resp.variable);
+	enum cfg80211_bss_frame_type ftype;
 	struct cfg80211_non_tx_bss non_tx_data = {};
 
 	res = cfg80211_inform_single_bss_frame_data(wiphy, data, mgmt,
 						    len, gfp);
+	if (!res)
+		return NULL;
 
 	/* don't do any further MBSSID handling for S1G */
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control))
 		return res;
 
-	if (!res || !wiphy->support_mbssid ||
-	    !cfg80211_find_elem(WLAN_EID_MULTIPLE_BSSID, ie, ielen))
-		return res;
-	if (wiphy->support_only_he_mbssid &&
-	    !cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ie, ielen))
-		return res;
-
+	ftype = ieee80211_is_beacon(mgmt->frame_control) ?
+		CFG80211_BSS_FTYPE_BEACON : CFG80211_BSS_FTYPE_PRESP;
 	non_tx_data.tx_bss = res;
-	/* process each non-transmitting bss */
-	cfg80211_parse_mbssid_frame_data(wiphy, data, mgmt, len,
-					 &non_tx_data, gfp);
-
-	spin_lock_bh(&wiphy_to_rdev(wiphy)->bss_lock);
 
-	/* check if the res has other nontransmitting bss which is not
-	 * in MBSSID IE
-	 */
-	ies1 = rcu_access_pointer(res->ies);
-
-	/* go through nontrans_list, if the timestamp of the BSS is
-	 * earlier than the timestamp of the transmitting BSS then
-	 * update it
-	 */
-	list_for_each_entry(tmp_bss, &res->nontrans_list,
-			    nontrans_list) {
-		ies2 = rcu_access_pointer(tmp_bss->ies);
-		if (ies2->tsf < ies1->tsf)
-			cfg80211_update_notlisted_nontrans(wiphy, tmp_bss,
-							   mgmt, len);
-	}
-	spin_unlock_bh(&wiphy_to_rdev(wiphy)->bss_lock);
+	/* process each non-transmitting bss */
+	cfg80211_parse_mbssid_data(wiphy, data, ftype, mgmt->bssid,
+				   le64_to_cpu(mgmt->u.probe_resp.timestamp),
+				   le16_to_cpu(mgmt->u.probe_resp.beacon_int),
+				   ie, ielen, &non_tx_data, gfp);
 
 	return res;
 }
-- 
2.39.2



