Return-Path: <stable+bounces-127721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC3FA7A9DA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5057A6E31
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB870254863;
	Thu,  3 Apr 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duAUghh6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732725485E;
	Thu,  3 Apr 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743706943; cv=none; b=sDb26BeWp0b8oa4ST1SkzCWnKOeGzv2vituSyR/te6XQBjzdSxDQh9EvMnFkhv3rn7qC9XyMEpCq/MrW57NP91a4+JXA7xmaYONcQepmY80tyPAuQOktwKvqzzatF7xgguWw7O7DyhlGv1GiIQR4nSnk2pGAyE38HONQGmfyJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743706943; c=relaxed/simple;
	bh=BgErDSgBeeb6wxjPhG6xcF8F+i4hGMhDgySo+fTZnVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QvP0qs2Ghq2hdtGbMThXg59GEj/Vu8xFx84oTeNfYfuMs7lgxT8JxUPCBhVtNTJLy6BabzSMWY8LOwhge/xITUsfJu4wUgKUS9V2PAMzRzGBhZBEOvsw7I54kSG2MPP+8pERJ7CmamL2M78rA6TFp5jtE6a1F+9MzDvHXa+oy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duAUghh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BCDC4CEE3;
	Thu,  3 Apr 2025 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706942;
	bh=BgErDSgBeeb6wxjPhG6xcF8F+i4hGMhDgySo+fTZnVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duAUghh6yNtT0bqLdEcE2QL5B/g9Mr8xUTogZd42zS87cf28A9zuFOG0jYvSV9MuG
	 0mpWK6IbD25B4EzEtnQxMQYfbLH4V1JzUfJpW/yENuQxmucsF0tXO+C8CRMKAPAuQN
	 II1croF4ushPQN9JSLxc6tPvrxPGlvmIQZNTFw+NSHmoP+Ro7BWpQeTyEQKs0Hahy0
	 /55by98beYMGgPS1TevTOhkZAn43Sk3UPvmzoMUkxPoStVqhGue8coLYpyTVuYmhL0
	 ix0aPhVsiiJ3rsaS7laDX5kzBk1G+7FBXWNchlsp12d19bM6uQUUdUg/DrPVFp1XjD
	 XT+QGsEkrFGqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: P Praneesh <quic_ppranees@quicinc.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 06/54] wifi: ath12k: Avoid memory leak while enabling statistics
Date: Thu,  3 Apr 2025 15:01:21 -0400
Message-Id: <20250403190209.2675485-6-sashal@kernel.org>
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

From: P Praneesh <quic_ppranees@quicinc.com>

[ Upstream commit ecfc131389923405be8e7a6f4408fd9321e4d19b ]

Driver uses monitor destination rings for extended statistics mode and
standalone monitor mode. In extended statistics mode, TLVs are parsed from
the buffer received from the monitor destination ring and assigned to the
ppdu_info structure to update per-packet statistics. In standalone monitor
mode, along with per-packet statistics, the packet data (payload) is
captured, and the driver updates per MSDU to mac80211.

When the AP interface is enabled, only extended statistics mode is
activated. As part of enabling monitor rings for collecting statistics,
the driver subscribes to HAL_RX_MPDU_START TLV in the filter
configuration. This TLV is received from the monitor destination ring, and
kzalloc for the mon_mpdu object occurs, which is not freed, leading to a
memory leak. The kzalloc for the mon_mpdu object is only required while
enabling the standalone monitor interface. This causes a memory leak while
enabling extended statistics mode in the driver.

Fix this memory leak by removing the kzalloc for the mon_mpdu object in
the HAL_RX_MPDU_START TLV handling. Additionally, remove the standalone
monitor mode handlings in the HAL_MON_BUF_ADDR and HAL_RX_MSDU_END TLVs.
These TLV tags will be handled properly when enabling standalone monitor
mode in the future.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Link: https://patch.msgid.link/20241223060132.3506372-13-quic_ppranees@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/dp_mon.c | 64 ++++--------------------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  3 ++
 2 files changed, 12 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 252d8e8a2080e..0b089389087d3 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -743,7 +743,6 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 	}
 	case HAL_RX_MPDU_START: {
 		const struct hal_rx_mpdu_start *mpdu_start = tlv_data;
-		struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
 		u16 peer_id;
 
 		info[1] = __le32_to_cpu(mpdu_start->info1);
@@ -760,65 +759,17 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k_base *ab,
 				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO1_PEERID);
 		}
 
-		mon_mpdu = kzalloc(sizeof(*mon_mpdu), GFP_ATOMIC);
-		if (!mon_mpdu)
-			return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
-
 		break;
 	}
 	case HAL_RX_MSDU_START:
 		/* TODO: add msdu start parsing logic */
 		break;
-	case HAL_MON_BUF_ADDR: {
-		struct dp_rxdma_mon_ring *buf_ring = &ab->dp.rxdma_mon_buf_ring;
-		const struct dp_mon_packet_info *packet_info = tlv_data;
-		int buf_id = u32_get_bits(packet_info->cookie,
-					  DP_RXDMA_BUF_COOKIE_BUF_ID);
-		struct sk_buff *msdu;
-		struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
-		struct ath12k_skb_rxcb *rxcb;
-
-		spin_lock_bh(&buf_ring->idr_lock);
-		msdu = idr_remove(&buf_ring->bufs_idr, buf_id);
-		spin_unlock_bh(&buf_ring->idr_lock);
-
-		if (unlikely(!msdu)) {
-			ath12k_warn(ab, "monitor destination with invalid buf_id %d\n",
-				    buf_id);
-			return HAL_RX_MON_STATUS_PPDU_NOT_DONE;
-		}
-
-		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(ab->dev, rxcb->paddr,
-				 msdu->len + skb_tailroom(msdu),
-				 DMA_FROM_DEVICE);
-
-		if (mon_mpdu->tail)
-			mon_mpdu->tail->next = msdu;
-		else
-			mon_mpdu->tail = msdu;
-
-		ath12k_dp_mon_buf_replenish(ab, buf_ring, 1);
-
-		break;
-	}
-	case HAL_RX_MSDU_END: {
-		const struct rx_msdu_end_qcn9274 *msdu_end = tlv_data;
-		bool is_first_msdu_in_mpdu;
-		u16 msdu_end_info;
-
-		msdu_end_info = __le16_to_cpu(msdu_end->info5);
-		is_first_msdu_in_mpdu = u32_get_bits(msdu_end_info,
-						     RX_MSDU_END_INFO5_FIRST_MSDU);
-		if (is_first_msdu_in_mpdu) {
-			pmon->mon_mpdu->head = pmon->mon_mpdu->tail;
-			pmon->mon_mpdu->tail = NULL;
-		}
-		break;
-	}
+	case HAL_MON_BUF_ADDR:
+		return HAL_RX_MON_STATUS_BUF_ADDR;
+	case HAL_RX_MSDU_END:
+		return HAL_RX_MON_STATUS_MSDU_END;
 	case HAL_RX_MPDU_END:
-		list_add_tail(&pmon->mon_mpdu->list, &pmon->dp_rx_mon_mpdu_list);
-		break;
+		return HAL_RX_MON_STATUS_MPDU_END;
 	case HAL_DUMMY:
 		return HAL_RX_MON_STATUS_BUF_DONE;
 	case HAL_RX_PPDU_END_STATUS_DONE:
@@ -1216,7 +1167,10 @@ ath12k_dp_mon_parse_rx_dest(struct ath12k_base *ab, struct ath12k_mon_data *pmon
 		if ((ptr - skb->data) >= DP_RX_BUFFER_SIZE)
 			break;
 
-	} while (hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE);
+	} while ((hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE) ||
+		 (hal_status == HAL_RX_MON_STATUS_BUF_ADDR) ||
+		 (hal_status == HAL_RX_MON_STATUS_MPDU_END) ||
+		 (hal_status == HAL_RX_MON_STATUS_MSDU_END));
 
 	return hal_status;
 }
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index b08aa2e79f411..54f3eaeca8bb9 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -108,6 +108,9 @@ enum hal_rx_mon_status {
 	HAL_RX_MON_STATUS_PPDU_NOT_DONE,
 	HAL_RX_MON_STATUS_PPDU_DONE,
 	HAL_RX_MON_STATUS_BUF_DONE,
+	HAL_RX_MON_STATUS_BUF_ADDR,
+	HAL_RX_MON_STATUS_MPDU_END,
+	HAL_RX_MON_STATUS_MSDU_END,
 };
 
 #define HAL_RX_MAX_MPDU		256
-- 
2.39.5


