Return-Path: <stable+bounces-127743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9672BA7AA4B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7163717A404
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7F5259C82;
	Thu,  3 Apr 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGZNIxUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8562586FE;
	Thu,  3 Apr 2025 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706995; cv=none; b=Tv3hXG65rT9mQjrwNL3lJZi40GnCLRqfCfFQWHIlc7SLeKvrTE1TiH1HKNYwTqpjA3Py/TgZRS0Q+aTjyjvhAtCUaub3mN8QPp1JT9U/8PdPyorKnwcSfIcEj1MPSl2l2VywGvPitSNursx8ls0k9t8nMLNaTtiY/JUSD0W1tFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706995; c=relaxed/simple;
	bh=S056xyS7+0wqKID83sat6Oc7O21GJX57wSaEQXXoVfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eeh3OS+mwX6xPr1S5wfgKQ0YEU5MnGFVRbW0pN/s2MotdFWXH+HgBWLF9LG1Zr/iMZ103K+MBZhPzs0C2HDWdFk4I7kMA2ictab1NtQ7o756iWnDuUofikhWvNbcGgYX98QcI6F3vFvFQIKIDuFRGvjCokbYcLWUAYIJO+MeGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGZNIxUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49DEC4CEE3;
	Thu,  3 Apr 2025 19:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706995;
	bh=S056xyS7+0wqKID83sat6Oc7O21GJX57wSaEQXXoVfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fGZNIxUYEVBg8LCcKXnzYQFP0K6Gmh6G842m6qzl3+8v9D6mmPzC3C6x7fFPfNh3G
	 SjOuGeLuzWgcxeqZwTIIlga01weCBJdysf0M7KHdnhN8CjBNihB25yzF+B5gMCFv/Z
	 9Y+/prhMd8m0Jk4twJYNz4HOzXr5yfH8rUIAGt3oIYj/8/SgLkwPTfwmNSdH6DuWh3
	 WFrVbGfFNxe2I7Ur4uKIlpmtad2UK6Ht016EfttJP6LabMpre2ENEthm2nPnnyhtvb
	 IECxKDYYkojWmIHEIyW+4fLhLlQ7pcm1S2ZIZ7fRLgXFqCUqKB0Vm3R8P28EmaWDBQ
	 7rQZXsiL3Jtqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Manish Dharanenthiran <quic_mdharane@quicinc.com>,
	Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 28/54] wifi: ath12k: Fix invalid data access in ath12k_dp_rx_h_undecap_nwifi
Date: Thu,  3 Apr 2025 15:01:43 -0400
Message-Id: <20250403190209.2675485-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
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
index dad35bfd83f62..a7fd836996560 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2530,6 +2530,29 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
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
@@ -2588,6 +2611,11 @@ static int ath12k_dp_rx_process_msdu(struct ath12k *ar,
 		}
 	}
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu))) {
+		ret = -EINVAL;
+		goto free_out;
+	}
+
 	ath12k_dp_rx_h_ppdu(ar, rx_desc, rx_status);
 	ath12k_dp_rx_h_mpdu(ar, msdu, rx_desc, rx_status);
 
@@ -2978,6 +3006,9 @@ static int ath12k_dp_rx_h_verify_tkip_mic(struct ath12k *ar, struct ath12k_peer
 		    RX_FLAG_IV_STRIPPED | RX_FLAG_DECRYPTED;
 	skb_pull(msdu, hal_rx_desc_sz);
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, rx_desc, msdu)))
+		return -EINVAL;
+
 	ath12k_dp_rx_h_ppdu(ar, rx_desc, rxs);
 	ath12k_dp_rx_h_undecap(ar, msdu, rx_desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, rxs, true);
@@ -3720,6 +3751,9 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 		skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 		skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 	}
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return -EINVAL;
+
 	ath12k_dp_rx_h_ppdu(ar, desc, status);
 
 	ath12k_dp_rx_h_mpdu(ar, msdu, desc, status);
@@ -3764,7 +3798,7 @@ static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
 	return drop;
 }
 
-static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
+static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 					struct ieee80211_rx_status *status)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -3782,6 +3816,9 @@ static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return true;
+
 	ath12k_dp_rx_h_ppdu(ar, desc, status);
 
 	status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
@@ -3789,6 +3826,7 @@ static void ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	ath12k_dp_rx_h_undecap(ar, msdu, desc,
 			       HAL_ENCRYPT_TYPE_TKIP_MIC, status, false);
+	return false;
 }
 
 static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
@@ -3807,7 +3845,7 @@ static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
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


