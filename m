Return-Path: <stable+bounces-179970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF5AB7E30C
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAFB1BC0CCA
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634581DE894;
	Wed, 17 Sep 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YR+AH6nc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102C1F873B;
	Wed, 17 Sep 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112970; cv=none; b=OBtY2UEbqzCQc9mgfYzSg/T6ojAkt7Bna28uNFI3DBUWdlgewGi4HBNwWW+JG/nSkvPAW447Vugn83iH9snSa/pGJe53z99HzM7JFrpRp1PfeE/AbIBcXHBH8gdngdKHf6zA4BtFDCu6XyuGOe+hLiV69zkWG4yA3P41b2GwTAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112970; c=relaxed/simple;
	bh=u5c7F3GAA/mwgpYl/kTGpe3wfnXatGErvlw76a6qV8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V5uxBYpPPkVe5AiEupkdIsUsqYstNDFu7dFScGCcQwz4LjBF4bSTEyBMe97Jj8O+4HSI7sYBd2x8ZM5vX4N//Ev8LcrDce2jcmK2mZFaB5BoUMPDTDkfeZFsFGgatl152nNloRzChghfepZYhn03zNpfzIGpQI/im4NqSR55hCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YR+AH6nc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DF6C4CEF0;
	Wed, 17 Sep 2025 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112970;
	bh=u5c7F3GAA/mwgpYl/kTGpe3wfnXatGErvlw76a6qV8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YR+AH6nc+LOqqgflezwAz+IIOuwksJr1xFbWdYvUEsz0VRextCEhA7y5AiqiYr40q
	 4BkbGlfv9LMZlNUH0OXsA2pqJpETBUudUhLG9Va/xGoODn9U6v6xlbJk2iEzwRtPew
	 80TVLdvQDGtqhkHTlUjGWTRq/RUwOM6Fcn8hUaPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sarika Sharma <quic_sarishar@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 131/189] wifi: ath12k: add link support for multi-link in arsta
Date: Wed, 17 Sep 2025 14:34:01 +0200
Message-ID: <20250917123355.058842908@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sarika Sharma <quic_sarishar@quicinc.com>

[ Upstream commit 3b8aa249d0fce93590888a6ed3d22b458091ecb9 ]

Currently, statistics in arsta are updated at deflink for both non-ML
and multi-link(ML) station. Link statistics are not updated for
multi-link operation(MLO).

Hence, add support to correctly obtain the link ID if the peer is ML,
fetch the arsta from the appropriate link ID, and update the
statistics in the corresponding arsta.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250701105927.803342-3-quic_sarishar@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Stable-dep-of: 82e2be57d544 ("wifi: ath12k: fix WMI TLV header misalignment")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 22 ++++++++++++++------
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 11 +++++-----
 drivers/net/wireless/ath/ath12k/peer.h   | 26 ++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 91f4e3aff74c3..6a0915a0c7aae 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -3610,7 +3610,6 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 				   struct hal_rx_mon_ppdu_info *ppdu_info,
 				   u32 uid)
 {
-	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_rx_peer_stats *rx_stats = NULL;
 	struct hal_rx_user_status *user_stats = &ppdu_info->userstats[uid];
@@ -3628,8 +3627,13 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
 		return;
 	}
 
-	ahsta = ath12k_sta_to_ahsta(peer->sta);
-	arsta = &ahsta->deflink;
+	arsta = ath12k_peer_get_link_sta(ar->ab, peer);
+	if (!arsta) {
+		ath12k_warn(ar->ab, "link sta not found on peer %pM id %d\n",
+			    peer->addr, peer->peer_id);
+		return;
+	}
+
 	arsta->rssi_comb = ppdu_info->rssi_comb;
 	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
 	rx_stats = arsta->rx_stats;
@@ -3742,7 +3746,6 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 	struct dp_srng *mon_dst_ring;
 	struct hal_srng *srng;
 	struct dp_rxdma_mon_ring *buf_ring;
-	struct ath12k_sta *ahsta = NULL;
 	struct ath12k_link_sta *arsta;
 	struct ath12k_peer *peer;
 	struct sk_buff_head skb_list;
@@ -3868,8 +3871,15 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
 		}
 
 		if (ppdu_info->reception_type == HAL_RX_RECEPTION_TYPE_SU) {
-			ahsta = ath12k_sta_to_ahsta(peer->sta);
-			arsta = &ahsta->deflink;
+			arsta = ath12k_peer_get_link_sta(ar->ab, peer);
+			if (!arsta) {
+				ath12k_warn(ar->ab, "link sta not found on peer %pM id %d\n",
+					    peer->addr, peer->peer_id);
+				spin_unlock_bh(&ab->base_lock);
+				rcu_read_unlock();
+				dev_kfree_skb_any(skb);
+				continue;
+			}
 			ath12k_dp_mon_rx_update_peer_su_stats(ar, arsta,
 							      ppdu_info);
 		} else if ((ppdu_info->fc_valid) &&
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index bd95dc88f9b21..e9137ffeb5ab4 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1418,8 +1418,6 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_peer *peer;
-	struct ieee80211_sta *sta;
-	struct ath12k_sta *ahsta;
 	struct ath12k_link_sta *arsta;
 	struct htt_ppdu_stats_user_rate *user_rate;
 	struct ath12k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
@@ -1500,9 +1498,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 		return;
 	}
 
-	sta = peer->sta;
-	ahsta = ath12k_sta_to_ahsta(sta);
-	arsta = &ahsta->deflink;
+	arsta = ath12k_peer_get_link_sta(ab, peer);
+	if (!arsta) {
+		spin_unlock_bh(&ab->base_lock);
+		rcu_read_unlock();
+		return;
+	}
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
 
diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
index f3a5e054d2b55..92c4988df2f16 100644
--- a/drivers/net/wireless/ath/ath12k/peer.h
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -91,5 +91,31 @@ struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash
 int ath12k_peer_ml_create(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_ml_delete(struct ath12k_hw *ah, struct ieee80211_sta *sta);
 int ath12k_peer_mlo_link_peers_delete(struct ath12k_vif *ahvif, struct ath12k_sta *ahsta);
+static inline
+struct ath12k_link_sta *ath12k_peer_get_link_sta(struct ath12k_base *ab,
+						 struct ath12k_peer *peer)
+{
+	struct ath12k_sta *ahsta;
+	struct ath12k_link_sta *arsta;
+
+	if (!peer->sta)
+		return NULL;
+
+	ahsta = ath12k_sta_to_ahsta(peer->sta);
+	if (peer->ml_id & ATH12K_PEER_ML_ID_VALID) {
+		if (!(ahsta->links_map & BIT(peer->link_id))) {
+			ath12k_warn(ab, "peer %pM id %d link_id %d can't found in STA link_map 0x%x\n",
+				    peer->addr, peer->peer_id, peer->link_id,
+				    ahsta->links_map);
+			return NULL;
+		}
+		arsta = rcu_dereference(ahsta->link[peer->link_id]);
+		if (!arsta)
+			return NULL;
+	} else {
+		arsta =  &ahsta->deflink;
+	}
+	return arsta;
+}
 
 #endif /* _PEER_H_ */
-- 
2.51.0




