Return-Path: <stable+bounces-122094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C31A59DF7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3E16FECF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C637923644D;
	Mon, 10 Mar 2025 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i5nGSlTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEE236446;
	Mon, 10 Mar 2025 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627509; cv=none; b=Voe3zdPRvf6lsCsK4v7TSRMryxef8tLsUb+LJf6ZAD22EecMzAXmKDNyMU8qHhjIV9xL7Iu8rznSPhsEmDlyLeqgyyBCLAkVU7YARCCUlTZOmZ9K7n9YhA/zTq7b//JaSC5zCK1igBEJp71LpJJ2CWrNXFHmRBuxobSqL6gy+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627509; c=relaxed/simple;
	bh=wDkQP6veLFt90WULYT/yFHOw6JGgaD6aJqJPpSaiPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VH93fK2al5GL9PSNL8qJivs3KVwgdxyv7rnx4R0QuFiRyYBdgcBBEWy4S//CWsEBSVaLqHmlA4VSsVhQoVTkW3j1wAPVTxfHpWHwGyhB13DvywSyqpzvgoHHA3yn8DOV9z5I8dWa7ZVyU80aPF+g5mK8VqDo6iuydPppAnifAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i5nGSlTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D8DC4CEEC;
	Mon, 10 Mar 2025 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627509;
	bh=wDkQP6veLFt90WULYT/yFHOw6JGgaD6aJqJPpSaiPNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5nGSlTX0Qw7q5bVdJmlzgL7Hq1pPnVFuuJVSv/nR7JCFIArnPLUeGxE5ydfI85Yu
	 ksiD1hHBcn0t+z5jJgFTt4AWx4m0PKqH1tdS/NrYzXCkGcbwW0tBLa9No0Yv7v/zQP
	 x4fRtWozxV68ry3If0mERmjJI9c54TGzOqBXznGU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 154/269] wifi: mac80211: fix MLE non-inheritance parsing
Date: Mon, 10 Mar 2025 18:05:07 +0100
Message-ID: <20250310170503.861396386@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 99ca2c28e6b68084a0fb65585df09b9e28c3ec16 ]

The code is erroneously applying the non-inheritance element
to the inner elements rather than the outer, which is clearly
completely wrong. Fix it by finding the MLE basic element at
the beginning, and then applying the non-inheritance for the
outer parsing.

While at it, do some general cleanups such as not allowing
callers to try looking for a specific non-transmitted BSS
and link at the same time.

Fixes: 45ebac4f059b ("wifi: mac80211: Parse station profile from association response")
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250221112451.b46d42f45b66.If5b95dc3c80208e0c62d8895fb6152aa54b6620b@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c  |   1 +
 net/mac80211/parse.c | 127 ++++++++++++++++++++++++++++---------------
 2 files changed, 83 insertions(+), 45 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 111066928b963..88751b0eb317a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4733,6 +4733,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		parse_params.start = bss_ies->data;
 		parse_params.len = bss_ies->len;
 		parse_params.bss = cbss;
+		parse_params.link_id = -1;
 		bss_elems = ieee802_11_parse_elems_full(&parse_params);
 		if (!bss_elems) {
 			ret = false;
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index cd318c1c67bec..3d5d6658fe8d5 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -47,6 +47,8 @@ struct ieee80211_elems_parse {
 	/* The EPCS Multi-Link element in the original elements */
 	const struct element *ml_epcs_elem;
 
+	bool multi_link_inner;
+
 	/*
 	 * scratch buffer that can be used for various element parsing related
 	 * tasks, e.g., element de-fragmentation etc.
@@ -152,12 +154,11 @@ ieee80211_parse_extension_element(u32 *crc,
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
-				if (elems_parse->ml_basic_elem) {
+				if (elems_parse->multi_link_inner) {
 					elems->parse_error |=
 						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
 					break;
 				}
-				elems_parse->ml_basic_elem = elem;
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
 				elems_parse->ml_reconf_elem = elem;
@@ -866,21 +867,36 @@ ieee80211_mle_get_sta_prof(struct ieee80211_elems_parse *elems_parse,
 	}
 }
 
-static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
-				     struct ieee80211_elems_parse_params *params)
+static const struct element *
+ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
+			      struct ieee80211_elems_parse_params *params,
+			      struct ieee80211_elems_parse_params *sub)
 {
 	struct ieee802_11_elems *elems = &elems_parse->elems;
 	struct ieee80211_mle_per_sta_profile *prof;
-	struct ieee80211_elems_parse_params sub = {
-		.mode = params->mode,
-		.action = params->action,
-		.from_ap = params->from_ap,
-		.link_id = -1,
-	};
-	ssize_t ml_len = elems->ml_basic_len;
-	const struct element *non_inherit = NULL;
+	const struct element *tmp;
+	ssize_t ml_len;
 	const u8 *end;
 
+	if (params->mode < IEEE80211_CONN_MODE_EHT)
+		return NULL;
+
+	for_each_element_extid(tmp, WLAN_EID_EXT_EHT_MULTI_LINK,
+			       elems->ie_start, elems->total_len) {
+		const struct ieee80211_multi_link_elem *mle =
+			(void *)tmp->data + 1;
+
+		if (!ieee80211_mle_size_ok(tmp->data + 1, tmp->datalen - 1))
+			continue;
+
+		if (le16_get_bits(mle->control, IEEE80211_ML_CONTROL_TYPE) !=
+		    IEEE80211_ML_CONTROL_TYPE_BASIC)
+			continue;
+
+		elems_parse->ml_basic_elem = tmp;
+		break;
+	}
+
 	ml_len = cfg80211_defragment_element(elems_parse->ml_basic_elem,
 					     elems->ie_start,
 					     elems->total_len,
@@ -891,26 +907,26 @@ static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 					     WLAN_EID_FRAGMENT);
 
 	if (ml_len < 0)
-		return;
+		return NULL;
 
 	elems->ml_basic = (const void *)elems_parse->scratch_pos;
 	elems->ml_basic_len = ml_len;
 	elems_parse->scratch_pos += ml_len;
 
 	if (params->link_id == -1)
-		return;
+		return NULL;
 
 	ieee80211_mle_get_sta_prof(elems_parse, params->link_id);
 	prof = elems->prof;
 
 	if (!prof)
-		return;
+		return NULL;
 
 	/* check if we have the 4 bytes for the fixed part in assoc response */
 	if (elems->sta_prof_len < sizeof(*prof) + prof->sta_info_len - 1 + 4) {
 		elems->prof = NULL;
 		elems->sta_prof_len = 0;
-		return;
+		return NULL;
 	}
 
 	/*
@@ -919,13 +935,17 @@ static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 	 * the -1 is because the 'sta_info_len' is accounted to as part of the
 	 * per-STA profile, but not part of the 'u8 variable[]' portion.
 	 */
-	sub.start = prof->variable + prof->sta_info_len - 1 + 4;
+	sub->start = prof->variable + prof->sta_info_len - 1 + 4;
 	end = (const u8 *)prof + elems->sta_prof_len;
-	sub.len = end - sub.start;
+	sub->len = end - sub->start;
 
-	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-					     sub.start, sub.len);
-	_ieee802_11_parse_elems_full(&sub, elems_parse, non_inherit);
+	sub->mode = params->mode;
+	sub->action = params->action;
+	sub->from_ap = params->from_ap;
+	sub->link_id = -1;
+
+	return cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+				      sub->start, sub->len);
 }
 
 static void
@@ -973,15 +993,19 @@ ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
+	struct ieee80211_elems_parse_params sub = {};
 	struct ieee80211_elems_parse *elems_parse;
-	struct ieee802_11_elems *elems;
 	const struct element *non_inherit = NULL;
-	u8 *nontransmitted_profile;
-	int nontransmitted_profile_len = 0;
+	struct ieee802_11_elems *elems;
 	size_t scratch_len = 3 * params->len;
+	bool multi_link_inner = false;
 
 	BUILD_BUG_ON(offsetof(typeof(*elems_parse), elems) != 0);
 
+	/* cannot parse for both a specific link and non-transmitted BSS */
+	if (WARN_ON(params->link_id >= 0 && params->bss))
+		return NULL;
+
 	elems_parse = kzalloc(struct_size(elems_parse, scratch, scratch_len),
 			      GFP_ATOMIC);
 	if (!elems_parse)
@@ -998,34 +1022,47 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	ieee80211_clear_tpe(&elems->tpe);
 	ieee80211_clear_tpe(&elems->csa_tpe);
 
-	nontransmitted_profile = elems_parse->scratch_pos;
-	nontransmitted_profile_len =
-		ieee802_11_find_bssid_profile(params->start, params->len,
-					      elems, params->bss,
-					      nontransmitted_profile);
-	elems_parse->scratch_pos += nontransmitted_profile_len;
-	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-					     nontransmitted_profile,
-					     nontransmitted_profile_len);
+	/*
+	 * If we're looking for a non-transmitted BSS then we cannot at
+	 * the same time be looking for a second link as the two can only
+	 * appear in the same frame carrying info for different BSSes.
+	 *
+	 * In any case, we only look for one at a time, as encoded by
+	 * the WARN_ON above.
+	 */
+	if (params->bss) {
+		int nontx_len =
+			ieee802_11_find_bssid_profile(params->start,
+						      params->len,
+						      elems, params->bss,
+						      elems_parse->scratch_pos);
+		sub.start = elems_parse->scratch_pos;
+		sub.mode = params->mode;
+		sub.len = nontx_len;
+		sub.action = params->action;
+		sub.link_id = params->link_id;
+
+		/* consume the space used for non-transmitted profile */
+		elems_parse->scratch_pos += nontx_len;
+
+		non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+						     sub.start, nontx_len);
+	} else {
+		/* must always parse to get elems_parse->ml_basic_elem */
+		non_inherit = ieee80211_prep_mle_link_parse(elems_parse, params,
+							    &sub);
+		multi_link_inner = true;
+	}
 
 	elems->crc = _ieee802_11_parse_elems_full(params, elems_parse,
 						  non_inherit);
 
-	/* Override with nontransmitted profile, if found */
-	if (nontransmitted_profile_len) {
-		struct ieee80211_elems_parse_params sub = {
-			.mode = params->mode,
-			.start = nontransmitted_profile,
-			.len = nontransmitted_profile_len,
-			.action = params->action,
-			.link_id = params->link_id,
-		};
-
+	/* Override with nontransmitted/per-STA profile if found */
+	if (sub.len) {
+		elems_parse->multi_link_inner = multi_link_inner;
 		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
 
-	ieee80211_mle_parse_link(elems_parse, params);
-
 	ieee80211_mle_defrag_reconf(elems_parse);
 
 	ieee80211_mle_defrag_epcs(elems_parse);
-- 
2.39.5




