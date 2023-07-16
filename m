Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D727554F0
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjGPUfi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjGPUfg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:35:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1B5BC
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:35:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D182B60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF09CC433C7;
        Sun, 16 Jul 2023 20:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539731;
        bh=MRGMUS2RaAtFxeCc6uzqPu3vSm/eUgS2eJD4JKQ6ZDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LndtNfa8f7nav0z/IQeyuGT6U+Q7rHN7AddTE2qq3BLMuFLb9bm4m7XN6ozcd5Nwi
         SQPvg2LDJyw59R9NkgZT6LwJQtgdyx9aQP2APOZavJxHKiw/7ItbCzI1xin7MAlw+p
         wGB3hKvKa3y4XPCXh4oChoDYw7/EnT0XRYbV7ZuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 112/591] wifi: cfg80211: rewrite merging of inherited elements
Date:   Sun, 16 Jul 2023 21:44:11 +0200
Message-ID: <20230716194926.777120989@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

[ Upstream commit dfd9aa3e7a456d57b18021d66472ab7ff8373ab7 ]

The cfg80211_gen_new_ie function merges the IEs using inheritance rules.
Rewrite this function to fix issues around inheritance rules. In
particular, vendor elements do not require any special handling, as they
are either all inherited or overridden by the subprofile.
Also, add fragmentation handling as this may be needed in some cases.

This also changes the function to not require making a copy. The new
version could be optimized a bit by explicitly tracking which IEs have
been handled already rather than looking that up again every time.

Note that a small behavioural change is the removal of the SSID special
handling. This should be fine for the MBSSID element, as the SSID must
be included in the subelement.

Fixes: 0b8fb8235be8 ("cfg80211: Parsing of Multiple BSSID information in scanning")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20230616094949.bc6152e146db.I2b5f3bc45085e1901e5b5192a674436adaf94748@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 213 ++++++++++++++++++++++++++------------------
 1 file changed, 124 insertions(+), 89 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 6c2b73c0d36e8..9fcb6f06b8cbe 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -262,117 +262,152 @@ bool cfg80211_is_element_inherited(const struct element *elem,
 }
 EXPORT_SYMBOL(cfg80211_is_element_inherited);
 
-static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
-				  const u8 *subelement, size_t subie_len,
-				  u8 *new_ie, gfp_t gfp)
+static size_t cfg80211_copy_elem_with_frags(const struct element *elem,
+					    const u8 *ie, size_t ie_len,
+					    u8 **pos, u8 *buf, size_t buf_len)
 {
-	u8 *pos, *tmp;
-	const u8 *tmp_old, *tmp_new;
-	const struct element *non_inherit_elem;
-	u8 *sub_copy;
+	if (WARN_ON((u8 *)elem < ie || elem->data > ie + ie_len ||
+		    elem->data + elem->datalen > ie + ie_len))
+		return 0;
 
-	/* copy subelement as we need to change its content to
-	 * mark an ie after it is processed.
-	 */
-	sub_copy = kmemdup(subelement, subie_len, gfp);
-	if (!sub_copy)
+	if (elem->datalen + 2 > buf + buf_len - *pos)
 		return 0;
 
-	pos = &new_ie[0];
+	memcpy(*pos, elem, elem->datalen + 2);
+	*pos += elem->datalen + 2;
 
-	/* set new ssid */
-	tmp_new = cfg80211_find_ie(WLAN_EID_SSID, sub_copy, subie_len);
-	if (tmp_new) {
-		memcpy(pos, tmp_new, tmp_new[1] + 2);
-		pos += (tmp_new[1] + 2);
+	/* Finish if it is not fragmented  */
+	if (elem->datalen != 255)
+		return *pos - buf;
+
+	ie_len = ie + ie_len - elem->data - elem->datalen;
+	ie = (const u8 *)elem->data + elem->datalen;
+
+	for_each_element(elem, ie, ie_len) {
+		if (elem->id != WLAN_EID_FRAGMENT)
+			break;
+
+		if (elem->datalen + 2 > buf + buf_len - *pos)
+			return 0;
+
+		memcpy(*pos, elem, elem->datalen + 2);
+		*pos += elem->datalen + 2;
+
+		if (elem->datalen != 255)
+			break;
 	}
 
-	/* get non inheritance list if exists */
-	non_inherit_elem =
-		cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-				       sub_copy, subie_len);
+	return *pos - buf;
+}
 
-	/* go through IEs in ie (skip SSID) and subelement,
-	 * merge them into new_ie
+static size_t cfg80211_gen_new_ie(const u8 *ie, size_t ielen,
+				  const u8 *subie, size_t subie_len,
+				  u8 *new_ie, size_t new_ie_len)
+{
+	const struct element *non_inherit_elem, *parent, *sub;
+	u8 *pos = new_ie;
+	u8 id, ext_id;
+	unsigned int match_len;
+
+	non_inherit_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+						  subie, subie_len);
+
+	/* We copy the elements one by one from the parent to the generated
+	 * elements.
+	 * If they are not inherited (included in subie or in the non
+	 * inheritance element), then we copy all occurrences the first time
+	 * we see this element type.
 	 */
-	tmp_old = cfg80211_find_ie(WLAN_EID_SSID, ie, ielen);
-	tmp_old = (tmp_old) ? tmp_old + tmp_old[1] + 2 : ie;
-
-	while (tmp_old + 2 - ie <= ielen &&
-	       tmp_old + tmp_old[1] + 2 - ie <= ielen) {
-		if (tmp_old[0] == 0) {
-			tmp_old++;
+	for_each_element(parent, ie, ielen) {
+		if (parent->id == WLAN_EID_FRAGMENT)
 			continue;
+
+		if (parent->id == WLAN_EID_EXTENSION) {
+			if (parent->datalen < 1)
+				continue;
+
+			id = WLAN_EID_EXTENSION;
+			ext_id = parent->data[0];
+			match_len = 1;
+		} else {
+			id = parent->id;
+			match_len = 0;
 		}
 
-		if (tmp_old[0] == WLAN_EID_EXTENSION)
-			tmp = (u8 *)cfg80211_find_ext_ie(tmp_old[2], sub_copy,
-							 subie_len);
-		else
-			tmp = (u8 *)cfg80211_find_ie(tmp_old[0], sub_copy,
-						     subie_len);
+		/* Find first occurrence in subie */
+		sub = cfg80211_find_elem_match(id, subie, subie_len,
+					       &ext_id, match_len, 0);
 
-		if (!tmp) {
-			const struct element *old_elem = (void *)tmp_old;
+		/* Copy from parent if not in subie and inherited */
+		if (!sub &&
+		    cfg80211_is_element_inherited(parent, non_inherit_elem)) {
+			if (!cfg80211_copy_elem_with_frags(parent,
+							   ie, ielen,
+							   &pos, new_ie,
+							   new_ie_len))
+				return 0;
 
-			/* ie in old ie but not in subelement */
-			if (cfg80211_is_element_inherited(old_elem,
-							  non_inherit_elem)) {
-				memcpy(pos, tmp_old, tmp_old[1] + 2);
-				pos += tmp_old[1] + 2;
-			}
-		} else {
-			/* ie in transmitting ie also in subelement,
-			 * copy from subelement and flag the ie in subelement
-			 * as copied (by setting eid field to WLAN_EID_SSID,
-			 * which is skipped anyway).
-			 * For vendor ie, compare OUI + type + subType to
-			 * determine if they are the same ie.
-			 */
-			if (tmp_old[0] == WLAN_EID_VENDOR_SPECIFIC) {
-				if (tmp_old[1] >= 5 && tmp[1] >= 5 &&
-				    !memcmp(tmp_old + 2, tmp + 2, 5)) {
-					/* same vendor ie, copy from
-					 * subelement
-					 */
-					memcpy(pos, tmp, tmp[1] + 2);
-					pos += tmp[1] + 2;
-					tmp[0] = WLAN_EID_SSID;
-				} else {
-					memcpy(pos, tmp_old, tmp_old[1] + 2);
-					pos += tmp_old[1] + 2;
-				}
-			} else {
-				/* copy ie from subelement into new ie */
-				memcpy(pos, tmp, tmp[1] + 2);
-				pos += tmp[1] + 2;
-				tmp[0] = WLAN_EID_SSID;
-			}
+			continue;
 		}
 
-		if (tmp_old + tmp_old[1] + 2 - ie == ielen)
-			break;
+		/* Already copied if an earlier element had the same type */
+		if (cfg80211_find_elem_match(id, ie, (u8 *)parent - ie,
+					     &ext_id, match_len, 0))
+			continue;
 
-		tmp_old += tmp_old[1] + 2;
+		/* Not inheriting, copy all similar elements from subie */
+		while (sub) {
+			if (!cfg80211_copy_elem_with_frags(sub,
+							   subie, subie_len,
+							   &pos, new_ie,
+							   new_ie_len))
+				return 0;
+
+			sub = cfg80211_find_elem_match(id,
+						       sub->data + sub->datalen,
+						       subie_len + subie -
+						       (sub->data +
+							sub->datalen),
+						       &ext_id, match_len, 0);
+		}
 	}
 
-	/* go through subelement again to check if there is any ie not
-	 * copied to new ie, skip ssid, capability, bssid-index ie
+	/* The above misses elements that are included in subie but not in the
+	 * parent, so do a pass over subie and append those.
+	 * Skip the non-tx BSSID caps and non-inheritance element.
 	 */
-	tmp_new = sub_copy;
-	while (tmp_new + 2 - sub_copy <= subie_len &&
-	       tmp_new + tmp_new[1] + 2 - sub_copy <= subie_len) {
-		if (!(tmp_new[0] == WLAN_EID_NON_TX_BSSID_CAP ||
-		      tmp_new[0] == WLAN_EID_SSID)) {
-			memcpy(pos, tmp_new, tmp_new[1] + 2);
-			pos += tmp_new[1] + 2;
+	for_each_element(sub, subie, subie_len) {
+		if (sub->id == WLAN_EID_NON_TX_BSSID_CAP)
+			continue;
+
+		if (sub->id == WLAN_EID_FRAGMENT)
+			continue;
+
+		if (sub->id == WLAN_EID_EXTENSION) {
+			if (sub->datalen < 1)
+				continue;
+
+			id = WLAN_EID_EXTENSION;
+			ext_id = sub->data[0];
+			match_len = 1;
+
+			if (ext_id == WLAN_EID_EXT_NON_INHERITANCE)
+				continue;
+		} else {
+			id = sub->id;
+			match_len = 0;
 		}
-		if (tmp_new + tmp_new[1] + 2 - sub_copy == subie_len)
-			break;
-		tmp_new += tmp_new[1] + 2;
+
+		/* Processed if one was included in the parent */
+		if (cfg80211_find_elem_match(id, ie, ielen,
+					     &ext_id, match_len, 0))
+			continue;
+
+		if (!cfg80211_copy_elem_with_frags(sub, subie, subie_len,
+						   &pos, new_ie, new_ie_len))
+			return 0;
 	}
 
-	kfree(sub_copy);
 	return pos - new_ie;
 }
 
@@ -2224,7 +2259,7 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 			new_ie_len = cfg80211_gen_new_ie(ie, ielen,
 							 profile,
 							 profile_len, new_ie,
-							 gfp);
+							 IEEE80211_MAX_DATA_LEN);
 			if (!new_ie_len)
 				continue;
 
-- 
2.39.2



