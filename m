Return-Path: <stable+bounces-15060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6808384B4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7826BB2B9E5
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728E864CC1;
	Tue, 23 Jan 2024 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LhmkEZtF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F164AB0;
	Tue, 23 Jan 2024 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975045; cv=none; b=avPFnQtDvfmFsiP1yJshPPyFlchGK9YppLFXgqCqDImGqVbHpB15QmXKKzx2oUtkuOvTh7/7h+tOOEoRH/7KyivmrzjFHIueApE8nUPfHYlSnjqU2oh1Ugq0yY+j0CAdDam0wnSOnKBRSxGn5AxzEGLXSvKwbEEY398NyCkrFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975045; c=relaxed/simple;
	bh=DSBEri2wUMmxge5Sv9A5ESD/W/Aby4iUVcFvlf/G3TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsv1koqmZdb54bneS7BFaPBtGQofUBcbQAczaoKa68rjn/xpjr+Vgkp/q+KeP2rQvAfzt+gIIcqLVRRTJngO0LZ9rNPizBgxjA9E7Ex5fv/y8cMhAnU9HzjSEGvOu3JJd1nVKYZVAm+o091Tm7kUCQwqnGDTkXVtPJksmK5qPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LhmkEZtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE894C433F1;
	Tue, 23 Jan 2024 01:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975045;
	bh=DSBEri2wUMmxge5Sv9A5ESD/W/Aby4iUVcFvlf/G3TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhmkEZtFfHeQscsho+FDjObDyjj2wwN7EvjeJ45JB6pk7NzpKxSjw8O0XxKSbGo0k
	 Kk5Hhe/1oU7fkVrokMWfwQGEqL7XCLj9yOhqq2+5V40thIqu5phig1BSYQdzyaHSbd
	 RGoAFVzbouiG1ecZvIB4KCqZ46HLkrgtjhgW4mqA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Berg <benjamin.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 211/583] wifi: cfg80211: parse all ML elements in an ML probe response
Date: Mon, 22 Jan 2024 15:54:22 -0800
Message-ID: <20240122235818.470690949@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit d18125b640309e925441ce49559be33867ae6b29 ]

A probe response from a transmitting AP in an Multi-BSSID setup will
contain more than one Multi-Link element. Most likely, only one of these
elements contains per-STA profiles.

Fixes: 2481b5da9c6b ("wifi: cfg80211: handle BSS data contained in ML probe responses")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240102213313.6635eb152735.I94289002d4a2f7b6b44dfa428344854e37b0b29c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a7d7469b10a4..bd4dd75e446e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2569,10 +2569,12 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 	return false;
 }
 
-static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
-				       struct cfg80211_inform_single_bss_data *tx_data,
-				       struct cfg80211_bss *source_bss,
-				       gfp_t gfp)
+static void
+cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
+				struct cfg80211_inform_single_bss_data *tx_data,
+				struct cfg80211_bss *source_bss,
+				const struct element *elem,
+				gfp_t gfp)
 {
 	struct cfg80211_inform_single_bss_data data = {
 		.drv_data = tx_data->drv_data,
@@ -2581,7 +2583,6 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 		.bss_source = BSS_SOURCE_STA_PROFILE,
 	};
 	struct ieee80211_multi_link_elem *ml_elem;
-	const struct element *elem;
 	struct cfg80211_mle *mle;
 	u16 control;
 	u8 *new_ie;
@@ -2591,15 +2592,7 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 	const u8 *pos;
 	u8 i;
 
-	if (!source_bss)
-		return;
-
-	if (tx_data->ftype != CFG80211_BSS_FTYPE_PRESP)
-		return;
-
-	elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
-				      tx_data->ie, tx_data->ielen);
-	if (!elem || !ieee80211_mle_size_ok(elem->data + 1, elem->datalen - 1))
+	if (!ieee80211_mle_size_ok(elem->data + 1, elem->datalen - 1))
 		return;
 
 	ml_elem = (void *)elem->data + 1;
@@ -2734,6 +2727,25 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 	kfree(mle);
 }
 
+static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
+				       struct cfg80211_inform_single_bss_data *tx_data,
+				       struct cfg80211_bss *source_bss,
+				       gfp_t gfp)
+{
+	const struct element *elem;
+
+	if (!source_bss)
+		return;
+
+	if (tx_data->ftype != CFG80211_BSS_FTYPE_PRESP)
+		return;
+
+	for_each_element_extid(elem, WLAN_EID_EXT_EHT_MULTI_LINK,
+			       tx_data->ie, tx_data->ielen)
+		cfg80211_parse_ml_elem_sta_data(wiphy, tx_data, source_bss,
+						elem, gfp);
+}
+
 struct cfg80211_bss *
 cfg80211_inform_bss_data(struct wiphy *wiphy,
 			 struct cfg80211_inform_bss *data,
-- 
2.43.0




