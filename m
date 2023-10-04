Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A7E7B884E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243754AbjJDSOs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244011AbjJDSOr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420BCBF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D77C433CA;
        Wed,  4 Oct 2023 18:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443283;
        bh=F0ibeR8ECU0J0WFVN7V0331aJS63tTJeff99TEjkskA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvLqNZn7tqU9TdIEdgyRz6VdBqVWR8oNq0omJN8RVbBRGbdYZj0/pmssAvGSM3BqW
         ErEV1fkHh7Dhtsa/HTZfO9OLJHQoRSXAP034F021wiO8202Y8g6MD3DN/F0ZhJGS3e
         wQvFSYZIfeuLM10KVoE+vhpG/JzwAdATOL0N14PA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sven Eckelmann <sven@narfation.org>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 102/259] wifi: ath11k: Cleanup mac80211 references on failure during tx_complete
Date:   Wed,  4 Oct 2023 19:54:35 +0200
Message-ID: <20231004175222.028578328@linuxfoundation.org>
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

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit 29d15589f084d71a4ea8c544039c5839db0236e2 ]

When a function is using functions from mac80211 to free an skb then it
should do it consistently and not switch to the generic dev_kfree_skb_any
(or similar functions). Otherwise (like in the error handlers), mac80211
will will not be aware of the freed skb and thus not clean up related
information in its internal data structures.

Not doing so lead in the past to filled up structure which then prevented
new clients to connect.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Fixes: 6257c702264c ("wifi: ath11k: fix tx status reporting in encap offload mode")
Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230802-ath11k-ack_status_leak-v2-2-c0af729d6229@narfation.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 08a28464eb7a9..64c8ccac22d27 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -344,7 +344,7 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	if (!skb_cb->vif) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 
@@ -566,12 +566,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	if (unlikely(!rcu_access_pointer(ab->pdevs_active[ar->pdev_idx]))) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 
 	if (unlikely(!skb_cb->vif)) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 
-- 
2.40.1



