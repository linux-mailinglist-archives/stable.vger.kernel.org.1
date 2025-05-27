Return-Path: <stable+bounces-147606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 253EFAC5864
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0204A41EE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A6327A900;
	Tue, 27 May 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DPXaDwiG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C9125A627;
	Tue, 27 May 2025 17:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367865; cv=none; b=pSAxsPxY7pDMNi/3CaFEei6Tlg6ad1kkABHoDYafFebpBfhHDTGoyNCRhoDTfmBa1/q1LAtwH+eRUN4CThwFybAsHK/8FUr4GAzORtXpiOcy1xxL1/aKU9oSnAfo9K2lnZQFpTr5AzrQLNYln+UGc/Argq6m7Nmsy8eoouI2PqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367865; c=relaxed/simple;
	bh=66iJR4OkmcM9Vpkn6vuzGIpka/1zGaC4/lD+7Xgyq3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5f6xVtWvda/QlcSzC84dNB0fN0NRQsbfthLDlTcyTSytwj3ndQMUN+6x2YxdTrvDuIWsB7dwPdF04K3d2AKrQJXvl8r8djj5gbR7Mh5dhO1WUS5wUfwXMWXJA4CVZbtEeMcNbTfJPtXt9PZH76imO8nabs737/WyvxRhPNU0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DPXaDwiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB98C4CEE9;
	Tue, 27 May 2025 17:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367865;
	bh=66iJR4OkmcM9Vpkn6vuzGIpka/1zGaC4/lD+7Xgyq3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DPXaDwiG7aet1fzGTC9LopNh845/o8/QjqU0wFcAZ2MwzdhXFox8mMzoqZ/paPL+x
	 0onYeMMHwwq10q4UD0O2cEICDUkOE+/t2gWBHCoAPNtrTo9WoGe9c0Coyo4kNKFDSf
	 0fRWCreFCT1/nTpfJP82nLUje9Cr2UuyOGEb7KUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 524/783] wifi: mac80211: add HT and VHT basic set verification
Date: Tue, 27 May 2025 18:25:21 +0200
Message-ID: <20250527162534.494805328@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 574faa0e936d12718e2cadad11ce1e184d9e5a32 ]

So far we did not verify the HT and VHT basic MCS set. However, in
P802.11REVme/D7.0 (6.5.4.2.4) says that the MLME-JOIN.request shall
return an error if the VHT and HT basic set requirements are not met.

Given broken APs, apply VHT basic MCS/NSS set checks only in
strict mode.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20250205110958.e2d8d4095f6b.I66bcf6c2de3b9d3325e4ffd9f573f4cd26ce5685@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 129 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8235400b7e5d8..ef65ae5137dcd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -345,6 +345,115 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	return IEEE80211_CONN_MODE_EHT;
 }
 
+static bool
+ieee80211_verify_sta_ht_mcs_support(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_ht_operation *ht_op)
+{
+	struct ieee80211_sta_ht_cap sta_ht_cap;
+	int i;
+
+	if (sband->band == NL80211_BAND_6GHZ)
+		return true;
+
+	if (!ht_op)
+		return false;
+
+	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
+	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+
+	/*
+	 * P802.11REVme/D7.0 - 6.5.4.2.4
+	 * ...
+	 * If the MLME of an HT STA receives an MLME-JOIN.request primitive
+	 * with the SelectedBSS parameter containing a Basic HT-MCS Set field
+	 * in the HT Operation parameter that contains any unsupported MCSs,
+	 * the MLME response in the resulting MLME-JOIN.confirm primitive shall
+	 * contain a ResultCode parameter that is not set to the value SUCCESS.
+	 * ...
+	 */
+
+	/* Simply check that all basic rates are in the STA RX mask */
+	for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++) {
+		if ((ht_op->basic_set[i] & sta_ht_cap.mcs.rx_mask[i]) !=
+		    ht_op->basic_set[i])
+			return false;
+	}
+
+	return true;
+}
+
+static bool
+ieee80211_verify_sta_vht_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     int link_id,
+				     struct ieee80211_supported_band *sband,
+				     const struct ieee80211_vht_operation *vht_op)
+{
+	struct ieee80211_sta_vht_cap sta_vht_cap;
+	u16 ap_min_req_set, sta_rx_mcs_map, sta_tx_mcs_map;
+	int nss;
+
+	if (sband->band != NL80211_BAND_5GHZ)
+		return true;
+
+	if (!vht_op)
+		return false;
+
+	memcpy(&sta_vht_cap, &sband->vht_cap, sizeof(sta_vht_cap));
+	ieee80211_apply_vhtcap_overrides(sdata, &sta_vht_cap);
+
+	ap_min_req_set = le16_to_cpu(vht_op->basic_mcs_set);
+	sta_rx_mcs_map = le16_to_cpu(sta_vht_cap.vht_mcs.rx_mcs_map);
+	sta_tx_mcs_map = le16_to_cpu(sta_vht_cap.vht_mcs.tx_mcs_map);
+
+	/*
+	 * Many APs are incorrectly advertising an all-zero value here,
+	 * which really means MCS 0-7 are required for 1-8 streams, but
+	 * they don't really mean it that way.
+	 * Some other APs are incorrectly advertising 3 spatial streams
+	 * with MCS 0-7 are required, but don't really mean it that way
+	 * and we'll connect only with HT, rather than even HE.
+	 * As a result, unfortunately the VHT basic MCS/NSS set cannot
+	 * be used at all, so check it only in strict mode.
+	 */
+	if (!ieee80211_hw_check(&sdata->local->hw, STRICT))
+		return true;
+
+	/*
+	 * P802.11REVme/D7.0 - 6.5.4.2.4
+	 * ...
+	 * If the MLME of a VHT STA receives an MLME-JOIN.request primitive
+	 * with a SelectedBSS parameter containing a Basic VHT-MCS And NSS Set
+	 * field in the VHT Operation parameter that contains any unsupported
+	 * <VHT-MCS, NSS> tuple, the MLME response in the resulting
+	 * MLME-JOIN.confirm primitive shall contain a ResultCode parameter
+	 * that is not set to the value SUCCESS.
+	 * ...
+	 */
+	for (nss = 8; nss > 0; nss--) {
+		u8 ap_op_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+		u8 sta_rx_val;
+		u8 sta_tx_val;
+
+		if (ap_op_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
+			continue;
+
+		sta_rx_val = (sta_rx_mcs_map >> (2 * (nss - 1))) & 3;
+		sta_tx_val = (sta_tx_mcs_map >> (2 * (nss - 1))) & 3;
+
+		if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    sta_rx_val < ap_op_val || sta_tx_val < ap_op_val) {
+			link_id_info(sdata, link_id,
+				     "Missing mandatory rates for %d Nss, rx %d, tx %d oper %d, disable VHT\n",
+				     nss, sta_rx_val, sta_tx_val, ap_op_val);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static bool
 ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
 				     int link_id,
@@ -1042,6 +1151,26 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		link_id_info(sdata, link_id,
 			     "regulatory prevented using AP config, downgraded\n");
 
+	if (conn->mode >= IEEE80211_CONN_MODE_HT &&
+	    !ieee80211_verify_sta_ht_mcs_support(sdata, sband,
+						 elems->ht_operation)) {
+		conn->mode = IEEE80211_CONN_MODE_LEGACY;
+		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
+		link_id_info(sdata, link_id,
+			     "required MCSes not supported, disabling HT\n");
+	}
+
+	if (conn->mode >= IEEE80211_CONN_MODE_VHT &&
+	    !ieee80211_verify_sta_vht_mcs_support(sdata, link_id, sband,
+						  elems->vht_operation)) {
+		conn->mode = IEEE80211_CONN_MODE_HT;
+		conn->bw_limit = min_t(enum ieee80211_conn_bw_limit,
+				       conn->bw_limit,
+				       IEEE80211_CONN_BW_LIMIT_40);
+		link_id_info(sdata, link_id,
+			     "required MCSes not supported, disabling VHT\n");
+	}
+
 	if (conn->mode >= IEEE80211_CONN_MODE_HE &&
 	    (!ieee80211_verify_peer_he_mcs_support(sdata, link_id,
 						   (void *)elems->he_cap,
-- 
2.39.5




