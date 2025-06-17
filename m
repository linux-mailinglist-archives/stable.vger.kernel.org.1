Return-Path: <stable+bounces-153651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD45ADD57C
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072777B01B1
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E72EA168;
	Tue, 17 Jun 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQjM6foE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999A2EA152;
	Tue, 17 Jun 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176651; cv=none; b=TcL1fbPRcsEC5kMsAmL//VeK3zDR9ypQjh4p6Gf5eHJGhfP1j8NvVv73mgalHf4tN0Fc+F9A+MGQCq9/WeQnBYnz4726l5lUWSrrgFnemAGwlIp/sc2tORc4ZLaiKr90OoVST+243rlDbNO8BdQVyaWpzT0OV62T8FJEGAdBp/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176651; c=relaxed/simple;
	bh=SM1a90iMrKhMYoUTmuqKmkTlJNCPe+fQGpI8JAnEkg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYIsmyY/PkqLynkVcGw+h18a0JXZTmmi2sZX4qX6I4OCo/m/6oGIU2t/lmvCknmF1NAtuQfR83udgKESZtWTe0gZBUUKV95VdOW/E3kLYvGTXeK5Vu+qcuvw4oC1ZnwTxY2YUq2XhcQ84gbCcWSCu7nQ2TmmVKf7jN+jiDo3qHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQjM6foE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6855C4CEE3;
	Tue, 17 Jun 2025 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176651;
	bh=SM1a90iMrKhMYoUTmuqKmkTlJNCPe+fQGpI8JAnEkg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQjM6foErUSjqmcP36zuOxb3FhHdudlhDjmwxdYDkspO/w+pWTro2MbIG+B1dGICD
	 KIJ1gLdLNUSsddmrrnyBLhpYzi6GKXK2Q3jLP9WqRzdbzQ5Rem38n7Z0c2Cg0pnpdH
	 AZNgsuSOsqK3x0mhRWM5wAbSRYWGVXXKznCBhANQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>,
	P Praneesh <praneesh.p@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 210/780] wifi: ath12k: add rx_info to capture required field from rx descriptor
Date: Tue, 17 Jun 2025 17:18:38 +0200
Message-ID: <20250617152500.015523466@linuxfoundation.org>
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

From: P Praneesh <praneesh.p@oss.qualcomm.com>

[ Upstream commit e88e6e3c9ada84ceed3fa223ce11af94fcaf3ad3 ]

In ath12k_dp_rx_h_mpdu(), as part of undecap to native wifi mode, the rx
descriptor memory is getting overwritten. After this function call, all
the rx descriptor related memory accesses give invalid values. To handle
this scenario, introduce a new structure ath12k_dp_rx_info which
pre-caches all the required fields from the rx descriptor before calling
ath12k_dp_rx_h_ppdu(). This rx_info structure will be used in the next
patch.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Co-developed-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250402182917.2715596-2-praneesh.p@oss.qualcomm.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Stable-dep-of: f5d6b15d9503 ("wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 80 ++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/dp_rx.h | 18 ++++++
 2 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index eaba698267685..dcbd97975f642 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2405,6 +2405,30 @@ static void ath12k_dp_rx_h_rate(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 	}
 }
 
+static void ath12k_dp_rx_h_fetch_info(struct ath12k_base *ab,
+				      struct hal_rx_desc *rx_desc,
+				      struct ath12k_dp_rx_info *rx_info)
+{
+	rx_info->ip_csum_fail = ath12k_dp_rx_h_ip_cksum_fail(ab, rx_desc);
+	rx_info->l4_csum_fail = ath12k_dp_rx_h_l4_cksum_fail(ab, rx_desc);
+	rx_info->is_mcbc = ath12k_dp_rx_h_is_da_mcbc(ab, rx_desc);
+	rx_info->decap_type = ath12k_dp_rx_h_decap_type(ab, rx_desc);
+	rx_info->pkt_type = ath12k_dp_rx_h_pkt_type(ab, rx_desc);
+	rx_info->sgi = ath12k_dp_rx_h_sgi(ab, rx_desc);
+	rx_info->rate_mcs = ath12k_dp_rx_h_rate_mcs(ab, rx_desc);
+	rx_info->bw = ath12k_dp_rx_h_rx_bw(ab, rx_desc);
+	rx_info->nss = ath12k_dp_rx_h_nss(ab, rx_desc);
+	rx_info->tid = ath12k_dp_rx_h_tid(ab, rx_desc);
+	rx_info->peer_id = ath12k_dp_rx_h_peer_id(ab, rx_desc);
+	rx_info->phy_meta_data = ath12k_dp_rx_h_freq(ab, rx_desc);
+
+	if (ath12k_dp_rxdesc_mac_addr2_valid(ab, rx_desc)) {
+		ether_addr_copy(rx_info->addr2,
+				ath12k_dp_rxdesc_get_mpdu_start_addr2(ab, rx_desc));
+		rx_info->addr2_present = true;
+	}
+}
+
 void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
 			 struct ieee80211_rx_status *rx_status)
 {
@@ -2567,7 +2591,7 @@ static bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
 static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 				     struct sk_buff *msdu,
 				     struct sk_buff_head *msdu_list,
-				     struct ieee80211_rx_status *rx_status)
+				     struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
@@ -2627,10 +2651,11 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 		goto free_out;
 	}
 
-	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
-	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
+	ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
+	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_info->rx_status);
+	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_info->rx_status);
 
-	rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
+	rx_info->rx_status->flag |= RX_FLAG_SKIP_MONITOR | RX_FLAG_DUP_VALIDATED;
 
 	return 0;
 
@@ -2650,12 +2675,16 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 	struct ath12k *ar;
 	struct ath12k_hw_link *hw_links = ag->hw_links;
 	struct ath12k_base *partner_ab;
+	struct ath12k_dp_rx_info rx_info;
 	u8 hw_link_id, pdev_id;
 	int ret;
 
 	if (skb_queue_empty(msdu_list))
 		return;
 
+	rx_info.addr2_present = false;
+	rx_info.rx_status = &rx_status;
+
 	rcu_read_lock();
 
 	while ((msdu = __skb_dequeue(msdu_list))) {
@@ -2676,7 +2705,7 @@ static void ath12k_dp_rx_process_received_packets(struct ath12k_base *ab,
 			continue;
 		}
 
-		ret = ath12k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_status);
+		ret = ath12k_dp_rx_process_msdu(ar, msdu, msdu_list, &rx_info);
 		if (ret) {
 			ath12k_dbg(ab, ATH12K_DBG_DATA,
 				   "Unable to process msdu %d", ret);
@@ -2977,6 +3006,7 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	struct ieee80211_rx_status *rxs = IEEE80211_SKB_RXCB(msdu);
 	struct ieee80211_key_conf *key_conf;
 	struct ieee80211_hdr *hdr;
+	struct ath12k_dp_rx_info rx_info;
 	u8 mic[IEEE80211_CCMP_MIC_LEN];
 	int head_len, tail_len, ret;
 	size_t data_len;
@@ -2987,6 +3017,9 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	if (ath12k_dp_rx_h_enctype(ab, rx_desc) != HAL_ENCRYPT_TYPE_TKIP_MIC)
 		return 0;
 
+	rx_info.addr2_present = false;
+	rx_info.rx_status = rxs;
+
 	hdr = (struct ieee80211_hdr *)(msdu->data + hal_rx_desc_sz);
 	hdr_len = ieee80211_hdrlen(hdr->frame_control);
 	head_len = hdr_len + hal_rx_desc_sz + IEEE80211_TKIP_IV_LEN;
@@ -3013,6 +3046,8 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 	(ATH12K_SKB_RXCB(msdu))->is_first_msdu = true;
 	(ATH12K_SKB_RXCB(msdu))->is_last_msdu = true;
 
+	ath12k_dp_rx_h_fetch_info(ab, rx_desc, &rx_info);
+
 	rxs->flag |= RX_FLAG_MMIC_ERROR | RX_FLAG_MMIC_STRIPPED |
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
@@ -3709,7 +3744,7 @@ static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
 }
 
 static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
-				      struct ieee80211_rx_status *status,
+				      struct ath12k_dp_rx_info *rx_info,
 				      struct sk_buff_head *msdu_list)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -3765,9 +3800,9 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
 		return -EINVAL;
 
-	ath12k_dp_rx_h_ppdu(ar, desc, status);
-
-	ath12k_dp_rx_h_mpdu(ar, msdu, desc, status);
+	ath12k_dp_rx_h_fetch_info(ab, desc, rx_info);
+	ath12k_dp_rx_h_ppdu(ar, desc, rx_info->rx_status);
+	ath12k_dp_rx_h_mpdu(ar, msdu, desc, rx_info->rx_status);
 
 	rxcb->tid = ath12k_dp_rx_h_tid(ab, desc);
 
@@ -3779,7 +3814,7 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 }
 
 static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
-				   struct ieee80211_rx_status *status,
+				   struct ath12k_dp_rx_info *rx_info,
 				   struct sk_buff_head *msdu_list)
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
@@ -3789,7 +3824,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	switch (rxcb->err_code) {
 	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
-		if (ath12k_dp_rx_h_null_q_desc(ar, msdu, status, msdu_list))
+		if (ath12k_dp_rx_h_null_q_desc(ar, msdu, rx_info, msdu_list))
 			drop = true;
 		break;
 	case HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED:
@@ -3810,7 +3845,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 }
 
 static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
-					struct ieee80211_rx_status *status)
+					struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	u16 msdu_len;
@@ -3839,18 +3874,18 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
 		return true;
 
-	ath12k_dp_rx_h_ppdu(ar, desc, status);
+	ath12k_dp_rx_h_ppdu(ar, desc, rx_info->rx_status);
 
-	status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
-			 RX_FLAG_DECRYPTED);
+	rx_info->rx_status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
+				     RX_FLAG_DECRYPTED);
 
 	ath12k_dp_rx_h_undecap(ar, msdu, desc,
-			       HAL_ENCRYPT_TYPE_TKIP_MIC, status, false);
+			       HAL_ENCRYPT_TYPE_TKIP_MIC, rx_info->rx_status, false);
 	return false;
 }
 
 static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
-				     struct ieee80211_rx_status *status)
+				     struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
@@ -3865,7 +3900,8 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
 	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
 		err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
 		if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, status);
+			ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
+			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, rx_info);
 			break;
 		}
 		fallthrough;
@@ -3887,14 +3923,18 @@ static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
 {
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
 	struct ieee80211_rx_status rxs = {0};
+	struct ath12k_dp_rx_info rx_info;
 	bool drop = true;
 
+	rx_info.addr2_present = false;
+	rx_info.rx_status = &rxs;
+
 	switch (rxcb->err_rel_src) {
 	case HAL_WBM_REL_SRC_MODULE_REO:
-		drop = ath12k_dp_rx_h_reo_err(ar, msdu, &rxs, msdu_list);
+		drop = ath12k_dp_rx_h_reo_err(ar, msdu, &rx_info, msdu_list);
 		break;
 	case HAL_WBM_REL_SRC_MODULE_RXDMA:
-		drop = ath12k_dp_rx_h_rxdma_err(ar, msdu, &rxs);
+		drop = ath12k_dp_rx_h_rxdma_err(ar, msdu, &rx_info);
 		break;
 	default:
 		/* msdu will get freed */
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 88e42365a9d8b..0e7cec42a8d13 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -65,6 +65,24 @@ struct ath12k_dp_rx_rfc1042_hdr {
 	__be16 snap_type;
 } __packed;
 
+struct ath12k_dp_rx_info {
+	struct ieee80211_rx_status *rx_status;
+	u32 phy_meta_data;
+	u16 peer_id;
+	u8 decap_type;
+	u8 pkt_type;
+	u8 sgi;
+	u8 rate_mcs;
+	u8 bw;
+	u8 nss;
+	u8 addr2[ETH_ALEN];
+	u8 tid;
+	bool ip_csum_fail;
+	bool l4_csum_fail;
+	bool is_mcbc;
+	bool addr2_present;
+};
+
 static inline u32 ath12k_he_gi_to_nl80211_he_gi(u8 sgi)
 {
 	u32 ret = 0;
-- 
2.39.5




