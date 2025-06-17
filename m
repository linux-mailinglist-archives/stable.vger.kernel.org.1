Return-Path: <stable+bounces-153648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE38ADD59B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E593B200C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6023F2EA146;
	Tue, 17 Jun 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YADsMHy+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4582E8E06;
	Tue, 17 Jun 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176641; cv=none; b=BqcO8QUsEF4Hb9zetWjkRFAvy91F7OXszPcVDpdAEcHz5NqmllvuXrEe2oC1ryDHHZ1fRWMx727QnsMSNYpO+l0CBOPmYOfl70R6A79pAcQcLnJjhwFLcoZYh7iHTQ890rWuADqvTBese1rJuR1b0RM7y70j5psQWvYaYS2B2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176641; c=relaxed/simple;
	bh=fiDgMpvi0ebwGwPG0bDt7jBrQkUzZh1qlOCESy10Wz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT1+uIjMJOOf/R+3BjhEEZwJxDONpP0xuo4OWgCZ04CXfBFtzvg0DpRPoCQGRwa2bsJQaUc7yYd/MMLmTEyUyLBTg0gVlCPt5G4tch9+oGBLNmFAT+Pr9+nbXewEJkfH3BSLOvac6qMnc+dDZOo12AlMXHZMo8uZbDlB/XZgoDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YADsMHy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE10C4CEE3;
	Tue, 17 Jun 2025 16:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176641;
	bh=fiDgMpvi0ebwGwPG0bDt7jBrQkUzZh1qlOCESy10Wz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YADsMHy+kVLpzLBZiTyJ+Ayqe6qsAnaxCYERC0QodtfvGLDs6IWdgUZExRWKt0Czc
	 uvVGoYiAUnNhpkuW6nMYlS3HAZnIlwhD0SURv569nv6tdtiQr6nw4a6LBVPlXsDwNt
	 Uq/MfK0RNWkbhmiAnXHUsocGLhPie7vTT8YahrHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	P Praneesh <quic_ppranees@quicinc.com>,
	Nicolas Escande <nico.escande@gmail.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 209/780] wifi: ath12k: change the status update in the monitor Rx
Date: Tue, 17 Jun 2025 17:18:37 +0200
Message-ID: <20250617152459.968124777@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit 5393dcb4520911f2b4a980e7e3c2c0de2bbf9ec7 ]

Currently, in the monitor Rx path, status is filled from the RX TLV header
present in the MSDU data. This logic is inherited from ath11k. However, in
the ath12k 802.11be hardware, the Rx TLV header is not present in the MSDU
data. This information is reported under various TLV tags. Therefore, avoid
the existing status filling by accumulating the needed information in the
PPDU information structure and fill the status.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Link: https://patch.msgid.link/20250324062518.2752822-6-quic_periyasa@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Stable-dep-of: f5d6b15d9503 ("wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.h   |  16 ++-
 drivers/net/wireless/ath/ath12k/dp_mon.c | 138 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h |   5 +-
 3 files changed, 151 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 2d91a6a4750ca..2ee83517eadc7 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -533,9 +533,19 @@ struct ath12k_sta {
 	enum ieee80211_sta_state state;
 };
 
-#define ATH12K_MIN_5GHZ_FREQ 4150
-#define ATH12K_MIN_6GHZ_FREQ 5925
-#define ATH12K_MAX_6GHZ_FREQ 7115
+#define ATH12K_HALF_20MHZ_BW	10
+#define ATH12K_2GHZ_MIN_CENTER	2412
+#define ATH12K_2GHZ_MAX_CENTER	2484
+#define ATH12K_5GHZ_MIN_CENTER	4900
+#define ATH12K_5GHZ_MAX_CENTER	5920
+#define ATH12K_6GHZ_MIN_CENTER	5935
+#define ATH12K_6GHZ_MAX_CENTER	7115
+#define ATH12K_MIN_2GHZ_FREQ	(ATH12K_2GHZ_MIN_CENTER - ATH12K_HALF_20MHZ_BW - 1)
+#define ATH12K_MAX_2GHZ_FREQ	(ATH12K_2GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW + 1)
+#define ATH12K_MIN_5GHZ_FREQ	(ATH12K_5GHZ_MIN_CENTER - ATH12K_HALF_20MHZ_BW)
+#define ATH12K_MAX_5GHZ_FREQ	(ATH12K_5GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW)
+#define ATH12K_MIN_6GHZ_FREQ	(ATH12K_6GHZ_MIN_CENTER - ATH12K_HALF_20MHZ_BW)
+#define ATH12K_MAX_6GHZ_FREQ	(ATH12K_6GHZ_MAX_CENTER + ATH12K_HALF_20MHZ_BW)
 #define ATH12K_NUM_CHANS 101
 #define ATH12K_MAX_5GHZ_CHAN 173
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 6fc3b92117656..9013c6ce94257 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1700,18 +1700,128 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
 	skb_pull(head_msdu, rx_pkt_offset + l2_hdr_offset);
 }
 
+static void
+ath12k_dp_mon_fill_rx_stats_info(struct ath12k *ar,
+				 struct hal_rx_mon_ppdu_info *ppdu_info,
+				 struct ieee80211_rx_status *rx_status)
+{
+	u32 center_freq = ppdu_info->freq;
+
+	rx_status->freq = center_freq;
+	rx_status->bw = ath12k_mac_bw_to_mac80211_bw(ppdu_info->bw);
+	rx_status->nss = ppdu_info->nss;
+	rx_status->rate_idx = 0;
+	rx_status->encoding = RX_ENC_LEGACY;
+	rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
+
+	if (center_freq >= ATH12K_MIN_6GHZ_FREQ &&
+	    center_freq <= ATH12K_MAX_6GHZ_FREQ) {
+		rx_status->band = NL80211_BAND_6GHZ;
+	} else if (center_freq >= ATH12K_MIN_2GHZ_FREQ &&
+		   center_freq <= ATH12K_MAX_2GHZ_FREQ) {
+		rx_status->band = NL80211_BAND_2GHZ;
+	} else if (center_freq >= ATH12K_MIN_5GHZ_FREQ &&
+		   center_freq <= ATH12K_MAX_5GHZ_FREQ) {
+		rx_status->band = NL80211_BAND_5GHZ;
+	} else {
+		rx_status->band = NUM_NL80211_BANDS;
+	}
+}
+
+static void
+ath12k_dp_mon_fill_rx_rate(struct ath12k *ar,
+			   struct hal_rx_mon_ppdu_info *ppdu_info,
+			   struct ieee80211_rx_status *rx_status)
+{
+	struct ieee80211_supported_band *sband;
+	enum rx_msdu_start_pkt_type pkt_type;
+	u8 rate_mcs, nss, sgi;
+	bool is_cck;
+
+	pkt_type = ppdu_info->preamble_type;
+	rate_mcs = ppdu_info->rate;
+	nss = ppdu_info->nss;
+	sgi = ppdu_info->gi;
+
+	switch (pkt_type) {
+	case RX_MSDU_START_PKT_TYPE_11A:
+	case RX_MSDU_START_PKT_TYPE_11B:
+		is_cck = (pkt_type == RX_MSDU_START_PKT_TYPE_11B);
+		if (rx_status->band < NUM_NL80211_BANDS) {
+			sband = &ar->mac.sbands[rx_status->band];
+			rx_status->rate_idx = ath12k_mac_hw_rate_to_idx(sband, rate_mcs,
+									is_cck);
+		}
+		break;
+	case RX_MSDU_START_PKT_TYPE_11N:
+		rx_status->encoding = RX_ENC_HT;
+		if (rate_mcs > ATH12K_HT_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in HT mode %d\n",
+				     rate_mcs);
+			break;
+		}
+		rx_status->rate_idx = rate_mcs + (8 * (nss - 1));
+		if (sgi)
+			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		break;
+	case RX_MSDU_START_PKT_TYPE_11AC:
+		rx_status->encoding = RX_ENC_VHT;
+		rx_status->rate_idx = rate_mcs;
+		if (rate_mcs > ATH12K_VHT_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in VHT mode %d\n",
+				     rate_mcs);
+			break;
+		}
+		if (sgi)
+			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		break;
+	case RX_MSDU_START_PKT_TYPE_11AX:
+		rx_status->rate_idx = rate_mcs;
+		if (rate_mcs > ATH12K_HE_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in HE mode %d\n",
+				    rate_mcs);
+			break;
+		}
+		rx_status->encoding = RX_ENC_HE;
+		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
+		break;
+	case RX_MSDU_START_PKT_TYPE_11BE:
+		rx_status->rate_idx = rate_mcs;
+		if (rate_mcs > ATH12K_EHT_MCS_MAX) {
+			ath12k_warn(ar->ab,
+				    "Received with invalid mcs in EHT mode %d\n",
+				    rate_mcs);
+			break;
+		}
+		rx_status->encoding = RX_ENC_EHT;
+		rx_status->he_gi = ath12k_he_gi_to_nl80211_he_gi(sgi);
+		break;
+	default:
+		ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+			   "monitor receives invalid preamble type %d",
+			    pkt_type);
+		break;
+	}
+}
+
 static struct sk_buff *
 ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 			    struct dp_mon_mpdu *mon_mpdu,
+			    struct hal_rx_mon_ppdu_info *ppdu_info,
 			    struct ieee80211_rx_status *rxs)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
 	struct sk_buff *head_msdu, *tail_msdu;
-	struct hal_rx_desc *rx_desc, *tail_rx_desc;
+	struct hal_rx_desc *rx_desc;
 	u8 *hdr_desc, *dest, decap_format = mon_mpdu->decap_format;
 	struct ieee80211_hdr_3addr *wh;
+	struct ieee80211_channel *channel;
 	u32 frag_list_sum_len = 0;
+	u8 channel_num = ppdu_info->chan_num;
 
 	mpdu_buf = NULL;
 	head_msdu = mon_mpdu->head;
@@ -1720,9 +1830,29 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
 	if (!head_msdu)
 		goto err_merge_fail;
 
-	tail_rx_desc = (struct hal_rx_desc *)tail_msdu->data;
+	ath12k_dp_mon_fill_rx_stats_info(ar, ppdu_info, rxs);
+
+	if (unlikely(rxs->band == NUM_NL80211_BANDS ||
+		     !ath12k_ar_to_hw(ar)->wiphy->bands[rxs->band])) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_DATA,
+			   "sband is NULL for status band %d channel_num %d center_freq %d pdev_id %d\n",
+			   rxs->band, channel_num, ppdu_info->freq, ar->pdev_idx);
+
+		spin_lock_bh(&ar->data_lock);
+		channel = ar->rx_channel;
+		if (channel) {
+			rxs->band = channel->band;
+			channel_num =
+				ieee80211_frequency_to_channel(channel->center_freq);
+		}
+		spin_unlock_bh(&ar->data_lock);
+	}
+
+	if (rxs->band < NUM_NL80211_BANDS)
+		rxs->freq = ieee80211_channel_to_frequency(channel_num,
+							   rxs->band);
 
-	ath12k_dp_rx_h_ppdu(ar, tail_rx_desc, rxs);
+	ath12k_dp_mon_fill_rx_rate(ar, ppdu_info, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
 		ath12k_dp_mon_rx_msdus_set_payload(ar, head_msdu, tail_msdu);
@@ -2038,7 +2168,7 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 	struct ieee80211_rx_status *rxs = &dp->rx_status;
 	u8 decap = DP_RX_DECAP_TYPE_RAW;
 
-	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mon_mpdu, rxs);
+	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mon_mpdu, ppduinfo, rxs);
 	if (!mon_skb)
 		goto mon_deliver_fail;
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index 6f10e4222ba6e..c753eb2a03ad2 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -509,7 +509,10 @@ struct hal_rx_mpdu_start {
 
 struct hal_rx_msdu_end {
 	__le32 info0;
-	__le32 rsvd0[18];
+	__le32 rsvd0[9];
+	__le16 info00;
+	__le16 info01;
+	__le32 rsvd00[8];
 	__le32 info1;
 	__le32 rsvd1[10];
 	__le32 info2;
-- 
2.39.5




