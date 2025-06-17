Return-Path: <stable+bounces-153641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E60ADD5BC
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A4B1945ACF
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB62F548D;
	Tue, 17 Jun 2025 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGYUXzM/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D72F5489;
	Tue, 17 Jun 2025 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176616; cv=none; b=sPU4VRNsDgIlRpgWdRFCXd4vcXXvHaZyn1dgf876HjYd7MALB8YKgtTpoXCQ8De9mi7ubLBRqxvV78ZzPX735sRS13NqfdMJkwzT2TSbCyDrOhtTj1K/dlqsykNyBrqCemgdFxIEp47NGuP5azJGMvGo9kzVZ3oqKR9UuJc/xNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176616; c=relaxed/simple;
	bh=Fw9xRX1FcVpFC27Z3aIQLLjnOUJahsNOTd2QdHMjtJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hcb7yiTr/JhqaeIY+4EzLtDK3x6M27EYFjGiNe6QVyKyEgymXx5GbgaSP5xwxxOahfxHmctmELcvL3qV92RpvVnq6JtqVVBnpyx5ToDSi4zqbnsRqLsTu/hU281wPp8jHJsCGcv8K3YSwjxTAf9jf7h7UMm41kfL/J7jJNrNrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGYUXzM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B91C4CEE3;
	Tue, 17 Jun 2025 16:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750176616;
	bh=Fw9xRX1FcVpFC27Z3aIQLLjnOUJahsNOTd2QdHMjtJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGYUXzM/GYzMGTcvW2DN2RtBPhxT2Ozzo8TsWZELAp1gsisf418jmt/Y1xC9751lk
	 M7vSOWVNO49ZHH2U/TbJb52nfLli7vEMRTl0B7Dqm+At+WFkgNZLJT/WgrWfCiqSLv
	 hs9zZy7aDQ2B+uKOzhaLWrCfcFXuJSAQyxtI3N1M=
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
Subject: [PATCH 6.15 207/780] wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
Date: Tue, 17 Jun 2025 17:18:35 +0200
Message-ID: <20250617152459.888225976@linuxfoundation.org>
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

[ Upstream commit a6621bf6397ae6981b5041ba0a127e7dbeade746 ]

Currently, error bitmap and decap format information are fetched from the
MSDU Rx TLV data. This logic is inherited from ath11k. However, for ath12k
802.11be hardware, the Rx TLV will not be present in the MSDU data.
Instead, this information is reported separately under the MSDU END TLV
tag. Therefore, remove the existing fetch code, handle the MSDU END TLV
tag and fetch the above information to store it in the mon_mpdu data
structure for use in the merge MSDU procedure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Tested-by: Nicolas Escande <nico.escande@gmail.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Link: https://patch.msgid.link/20250324062518.2752822-4-quic_periyasa@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Stable-dep-of: f5d6b15d9503 ("wifi: ath12k: fix wrong handling of CCMP256 and GCMP ciphers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 58 ++++++++++--------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 8c78f601f70aa..6fc3b92117656 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1702,30 +1702,26 @@ static void ath12k_dp_mon_rx_msdus_set_payload(struct ath12k *ar,
 
 static struct sk_buff *
 ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
-			    struct sk_buff *head_msdu, struct sk_buff *tail_msdu,
-			    struct ieee80211_rx_status *rxs, bool *fcs_err)
+			    struct dp_mon_mpdu *mon_mpdu,
+			    struct ieee80211_rx_status *rxs)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct sk_buff *msdu, *mpdu_buf, *prev_buf, *head_frag_list;
+	struct sk_buff *head_msdu, *tail_msdu;
 	struct hal_rx_desc *rx_desc, *tail_rx_desc;
-	u8 *hdr_desc, *dest, decap_format;
+	u8 *hdr_desc, *dest, decap_format = mon_mpdu->decap_format;
 	struct ieee80211_hdr_3addr *wh;
-	u32 err_bitmap, frag_list_sum_len = 0;
+	u32 frag_list_sum_len = 0;
 
 	mpdu_buf = NULL;
+	head_msdu = mon_mpdu->head;
+	tail_msdu = mon_mpdu->tail;
 
 	if (!head_msdu)
 		goto err_merge_fail;
 
-	rx_desc = (struct hal_rx_desc *)head_msdu->data;
 	tail_rx_desc = (struct hal_rx_desc *)tail_msdu->data;
 
-	err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, tail_rx_desc);
-	if (err_bitmap & HAL_RX_MPDU_ERR_FCS)
-		*fcs_err = true;
-
-	decap_format = ath12k_dp_rx_h_decap_type(ab, tail_rx_desc);
-
 	ath12k_dp_rx_h_ppdu(ar, tail_rx_desc, rxs);
 
 	if (decap_format == DP_RX_DECAP_TYPE_RAW) {
@@ -1954,7 +1950,8 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
 
 static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
 					  struct sk_buff *msdu,
-					  struct ieee80211_rx_status *status)
+					  struct ieee80211_rx_status *status,
+					  u8 decap)
 {
 	static const struct ieee80211_radiotap_he known = {
 		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
@@ -1966,7 +1963,6 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 	struct ieee80211_sta *pubsta = NULL;
 	struct ath12k_peer *peer;
 	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u8 decap = DP_RX_DECAP_TYPE_RAW;
 	bool is_mcbc = rxcb->is_mcbc;
 	bool is_eapol_tkip = rxcb->is_eapol;
 
@@ -1977,8 +1973,6 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 		status->flag |= RX_FLAG_RADIOTAP_HE;
 	}
 
-	if (!(status->flag & RX_FLAG_ONLY_MONITOR))
-		decap = ath12k_dp_rx_h_decap_type(ar->ab, rxcb->rx_desc);
 	spin_lock_bh(&ar->ab->base_lock);
 	peer = ath12k_dp_rx_h_find_peer(ar->ab, msdu);
 	if (peer && peer->sta) {
@@ -2035,25 +2029,23 @@ static void ath12k_dp_mon_rx_deliver_msdu(struct ath12k *ar, struct napi_struct
 }
 
 static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
-				    struct sk_buff *head_msdu, struct sk_buff *tail_msdu,
+				    struct dp_mon_mpdu *mon_mpdu,
 				    struct hal_rx_mon_ppdu_info *ppduinfo,
 				    struct napi_struct *napi)
 {
 	struct ath12k_pdev_dp *dp = &ar->dp;
 	struct sk_buff *mon_skb, *skb_next, *header;
 	struct ieee80211_rx_status *rxs = &dp->rx_status;
-	bool fcs_err = false;
+	u8 decap = DP_RX_DECAP_TYPE_RAW;
 
-	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar,
-					      head_msdu, tail_msdu,
-					      rxs, &fcs_err);
+	mon_skb = ath12k_dp_mon_rx_merg_msdus(ar, mon_mpdu, rxs);
 	if (!mon_skb)
 		goto mon_deliver_fail;
 
 	header = mon_skb;
 	rxs->flag = 0;
 
-	if (fcs_err)
+	if (mon_mpdu->err_bitmap & HAL_RX_MPDU_ERR_FCS)
 		rxs->flag = RX_FLAG_FAILED_FCS_CRC;
 
 	do {
@@ -2070,8 +2062,12 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 			rxs->flag |= RX_FLAG_ALLOW_SAME_PN;
 		}
 		rxs->flag |= RX_FLAG_ONLY_MONITOR;
+
+		if (!(rxs->flag & RX_FLAG_ONLY_MONITOR))
+			decap = mon_mpdu->decap_format;
+
 		ath12k_dp_mon_update_radiotap(ar, ppduinfo, mon_skb, rxs);
-		ath12k_dp_mon_rx_deliver_msdu(ar, napi, mon_skb, rxs);
+		ath12k_dp_mon_rx_deliver_msdu(ar, napi, mon_skb, rxs, decap);
 		mon_skb = skb_next;
 	} while (mon_skb);
 	rxs->flag = 0;
@@ -2079,7 +2075,7 @@ static int ath12k_dp_mon_rx_deliver(struct ath12k *ar,
 	return 0;
 
 mon_deliver_fail:
-	mon_skb = head_msdu;
+	mon_skb = mon_mpdu->head;
 	while (mon_skb) {
 		skb_next = mon_skb->next;
 		dev_kfree_skb_any(mon_skb);
@@ -2285,7 +2281,6 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
 	struct dp_mon_mpdu *tmp;
 	struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
-	struct sk_buff *head_msdu, *tail_msdu;
 	enum hal_rx_mon_status hal_status;
 
 	hal_status = ath12k_dp_mon_parse_rx_dest(ar, pmon, skb);
@@ -2294,13 +2289,9 @@ ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
 
 	list_for_each_entry_safe(mon_mpdu, tmp, &pmon->dp_rx_mon_mpdu_list, list) {
 		list_del(&mon_mpdu->list);
-		head_msdu = mon_mpdu->head;
-		tail_msdu = mon_mpdu->tail;
 
-		if (head_msdu && tail_msdu) {
-			ath12k_dp_mon_rx_deliver(ar, head_msdu,
-						 tail_msdu, ppdu_info, napi);
-		}
+		if (mon_mpdu->head && mon_mpdu->tail)
+			ath12k_dp_mon_rx_deliver(ar, mon_mpdu, ppdu_info, napi);
 
 		kfree(mon_mpdu);
 	}
@@ -2985,16 +2976,13 @@ ath12k_dp_mon_tx_process_ppdu_info(struct ath12k *ar,
 				   struct dp_mon_tx_ppdu_info *tx_ppdu_info)
 {
 	struct dp_mon_mpdu *tmp, *mon_mpdu;
-	struct sk_buff *head_msdu, *tail_msdu;
 
 	list_for_each_entry_safe(mon_mpdu, tmp,
 				 &tx_ppdu_info->dp_tx_mon_mpdu_list, list) {
 		list_del(&mon_mpdu->list);
-		head_msdu = mon_mpdu->head;
-		tail_msdu = mon_mpdu->tail;
 
-		if (head_msdu)
-			ath12k_dp_mon_rx_deliver(ar, head_msdu, tail_msdu,
+		if (mon_mpdu->head)
+			ath12k_dp_mon_rx_deliver(ar, mon_mpdu,
 						 &tx_ppdu_info->rx_status, napi);
 
 		kfree(mon_mpdu);
-- 
2.39.5




