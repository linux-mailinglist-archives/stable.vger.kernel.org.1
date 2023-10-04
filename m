Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA077B886E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbjJDSQI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244054AbjJDSQH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:16:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E2D9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:16:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2DBC433C7;
        Wed,  4 Oct 2023 18:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443362;
        bh=xeqXZBhkU0rOLYeiuXw2fLbVPGLK4GjG7t3cSL5AqTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AExg7wNip12+CEIaCtftBQT2yjS5L+awJgL6Y4lzH5WXqcKwx+aoeCyX0Aft7gMca
         eV9CS+LOfRg+krj357KkpzbdToYwPvCUW7Nr4goJBrN8UyPtrTy0YXo7sfqBp1yGC7
         Qe0sdZDGd8njK05pLW9FC3cAZpih9FtYUaJ9xCOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 101/259] wifi: ath11k: fix tx status reporting in encap offload mode
Date:   Wed,  4 Oct 2023 19:54:34 +0200
Message-ID: <20231004175221.987489708@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

[ Upstream commit 6257c702264c44d74c6b71f0c62a7665da2dc356 ]

ieee80211_tx_status() treats packets in 802.11 frame format and
tries to extract sta address from packet header. When tx encap
offload is enabled, this becomes invalid operation. Hence, switch
to using ieee80211_tx_status_ext() after filling in station
address for handling both 802.11 and 802.3 frames.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230403195738.25367-2-quic_pradeepc@quicinc.com
Stable-dep-of: 29d15589f084 ("wifi: ath11k: Cleanup mac80211 references on failure during tx_complete")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp.h    |  4 +++
 drivers/net/wireless/ath/ath11k/dp_tx.c | 33 ++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.h |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index be9eafc872b3b..232fd2e638bf6 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -303,12 +303,16 @@ struct ath11k_dp {
 
 #define HTT_TX_WBM_COMP_STATUS_OFFSET 8
 
+#define HTT_INVALID_PEER_ID	0xffff
+
 /* HTT tx completion is overlaid in wbm_release_ring */
 #define HTT_TX_WBM_COMP_INFO0_STATUS		GENMASK(12, 9)
 #define HTT_TX_WBM_COMP_INFO0_REINJECT_REASON	GENMASK(16, 13)
 #define HTT_TX_WBM_COMP_INFO0_REINJECT_REASON	GENMASK(16, 13)
 
 #define HTT_TX_WBM_COMP_INFO1_ACK_RSSI		GENMASK(31, 24)
+#define HTT_TX_WBM_COMP_INFO2_SW_PEER_ID	GENMASK(15, 0)
+#define HTT_TX_WBM_COMP_INFO2_VALID		BIT(21)
 
 struct htt_tx_wbm_completion {
 	u32 info0;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8afbba2369354..08a28464eb7a9 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -316,10 +316,12 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 				 struct dp_tx_ring *tx_ring,
 				 struct ath11k_dp_htt_wbm_tx_status *ts)
 {
+	struct ieee80211_tx_status status = { 0 };
 	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
 	struct ath11k_skb_cb *skb_cb;
 	struct ath11k *ar;
+	struct ath11k_peer *peer;
 
 	spin_lock(&tx_ring->tx_idr_lock);
 	msdu = idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
@@ -341,6 +343,11 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
+	if (!skb_cb->vif) {
+		dev_kfree_skb_any(msdu);
+		return;
+	}
+
 	memset(&info->status, 0, sizeof(info->status));
 
 	if (ts->acked) {
@@ -355,7 +362,23 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 		}
 	}
 
-	ieee80211_tx_status(ar->hw, msdu);
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath11k_dbg(ab, ATH11K_DBG_DATA,
+			   "dp_tx: failed to find the peer with peer_id %d\n",
+			    ts->peer_id);
+		spin_unlock_bh(&ab->base_lock);
+		dev_kfree_skb_any(msdu);
+		return;
+	}
+	spin_unlock_bh(&ab->base_lock);
+
+	status.sta = peer->sta;
+	status.info = info;
+	status.skb = msdu;
+
+	ieee80211_tx_status_ext(ar->hw, &status);
 }
 
 static void
@@ -379,7 +402,15 @@ ath11k_dp_tx_process_htt_tx_complete(struct ath11k_base *ab,
 		ts.msdu_id = msdu_id;
 		ts.ack_rssi = FIELD_GET(HTT_TX_WBM_COMP_INFO1_ACK_RSSI,
 					status_desc->info1);
+
+		if (FIELD_GET(HTT_TX_WBM_COMP_INFO2_VALID, status_desc->info2))
+			ts.peer_id = FIELD_GET(HTT_TX_WBM_COMP_INFO2_SW_PEER_ID,
+					       status_desc->info2);
+		else
+			ts.peer_id = HTT_INVALID_PEER_ID;
+
 		ath11k_dp_tx_htt_tx_complete_buf(ab, tx_ring, &ts);
+
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
index e87d65bfbf06e..68a21ea9b9346 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -13,6 +13,7 @@ struct ath11k_dp_htt_wbm_tx_status {
 	u32 msdu_id;
 	bool acked;
 	int ack_rssi;
+	u16 peer_id;
 };
 
 void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts);
-- 
2.40.1



