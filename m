Return-Path: <stable+bounces-127843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 697DBA7AC5F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 770667A7765
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28CC26FA79;
	Thu,  3 Apr 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7V5Ouiq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5BB26FA7A;
	Thu,  3 Apr 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707218; cv=none; b=MP1BgQ23Xm+sODhKnc9frHbieA1bheR1phEecknS4FXyxvMvgVJDrRiruTT3WhHTSm3POgyes7OHiKInfcBqGaklPN/5ApxsTRgphKsGU1MavYU9cC8ssGHpEC4tvG+ZdZonR6A9tpcBWRUim1rym69CuaM6WHtkAcAq/ykyGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707218; c=relaxed/simple;
	bh=GykWMv9yUeQ2ORZ2k4NJ2CoDTsehWfoqApw1vybybwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y7XpUsFb+u6Rp6mO/KBt0zokZYAVm+Vkor77MvQQ1PxBQbTIQD5R6QjEsqbbaD8BUE9F1heHC/oXg6tXtNGuNPXTzMtlVerb3gdW1S/XgoWrVh7Bhc/Ziwvdf0LhcfOHLgPwvbmBXb4kGQSIHDAFRMNdtGHjL9xgyI98yFM/8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7V5Ouiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC54C4CEE3;
	Thu,  3 Apr 2025 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707218;
	bh=GykWMv9yUeQ2ORZ2k4NJ2CoDTsehWfoqApw1vybybwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7V5OuiqQQfNKCGx2vs+jVB2yEDU30ddQPgJNMp8vKvtBWieJ9Ihtll28OR0L8gmF
	 1FwRXJitb3Ufb/hHxyBga4I15m1hIAgAtHQa0ikmvb+wqjrk0F5IiynTjsUVTm6iWM
	 qQSFzeiEquem+DCq9KrUKQ2M7BnTTeQoR1i2zpM18r553aG0Et3B9dtod2y2VVdUCm
	 FoTFYGFYUgymWDSP5CbSV+MBHCKPJsYPvXfA7MSMOy7Oag+fEMCRwSwNeYyi2Z5pGj
	 tC7i3lRULRYOKG2nMGXUJzgIQ/C3UChT2z1WOTIMiz74USomAwF/u+sSZzC+d/2l9u
	 iFGkheANcJ/0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manish Dharanenthiran <quic_mdharane@quicinc.com>,
	Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 25/47] wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi
Date: Thu,  3 Apr 2025 15:05:33 -0400
Message-Id: <20250403190555.2677001-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Manish Dharanenthiran <quic_mdharane@quicinc.com>

[ Upstream commit 9a0dddfb30f120db3851627935851d262e4e7acb ]

In certain cases, hardware might provide packets with a
length greater than the maximum native Wi-Fi header length.
This can lead to accessing and modifying fields in the header
within the ath12k_dp_rx_h_undecap_nwifi function for
DP_RX_DECAP_TYPE_NATIVE_WIFI decap type and
potentially resulting in invalid data access and memory corruption.

Add a sanity check before processing the SKB to prevent invalid
data access in the undecap native Wi-Fi function for the
DP_RX_DECAP_TYPE_NATIVE_WIFI decap type.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manish Dharanenthiran <quic_mdharane@quicinc.com>
Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Link: https://patch.msgid.link/20250211090302.4105141-1-tamizh.raja@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 42 +++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 91e3393f7b5f4..4cbba96121a11 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2470,6 +2470,29 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
 }
 
+static bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
+						   struct hal_rx_desc *rx_desc,
+						   struct sk_buff *msdu)
+{
+	struct ieee80211_hdr *hdr;
+	u8 decap_type;
+	u32 hdr_len;
+
+	decap_type = ath12k_dp_rx_h_decap_type(ab, rx_desc);
+	if (decap_type != DP_RX_DECAP_TYPE_NATIVE_WIFI)
+		return true;
+
+	hdr = (struct ieee80211_hdr *)msdu->data;
+	hdr_len = ieee80211_hdrlen(hdr->frame_control);
+
+	if ((likely(hdr_len <= DP_MAX_NWIFI_HDR_LEN)))
+		return true;
+
+	ab->soc_stats.invalid_rbm++;
+	WARN_ON_ONCE(1);
+	return false;
+}
+
 static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 				     struct sk_buff *msdu,
 				     struct sk_buff_head *msdu_list,
@@ -2528,6 +2551,11 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 		}
 	}
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu))) {
+		ret = -EINVAL;
+		goto free_out;
+	}
+
 	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
 	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
 
@@ -2880,6 +2908,9 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu)))
+		return -EINVAL;
+
 	ath12k_dp_rx_h_ppdu(ar, rx_desc, rxs);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
@@ -3600,6 +3631,9 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 	}
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return -EINVAL;
+
 	ath12k_dp_rx_h_ppdu(ar, desc, status);
 
 	ath12k_dp_rx_h_mpdu(ar, msdu, desc, status);
@@ -3644,7 +3678,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 	return drop;
 }
 
-static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
+static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 					struct ieee80211_rx_status *status)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -3662,6 +3696,9 @@ static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return true;
+
 	ath12k_dp_rx_h_ppdu(ar, desc, status);
 
 	status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
@@ -3669,6 +3706,7 @@ static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	ath12k_dp_rx_h_undecap(ar, msdu, desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, status, false);
+	return false;
 }
 
 static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
@@ -3687,7 +3725,7 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
 		err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
 		if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-			ath12k_dp_rx_h_tkip_mic_err(ar, msdu, status);
+			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, status);
 			break;
 		}
 		fallthrough;
-- 
2.39.5


