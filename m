Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37C3791CE4
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbjIDScn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243928AbjIDScn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98480B2
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:32:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372D561988
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0DDC433C9;
        Mon,  4 Sep 2023 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852359;
        bh=BSTnDk34sV4jwTX5gvvAlX7ieRnjlashWPnClAVIFP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJ53HN4txUe/g+llGqhKDcPs12WheVgPZ8qv6ROPNVxkkzQ0yI5RsTCiygmFLZfcx
         8eQ2x01gpn67WVxUFkYEViZytFAWy3DhPFTfFddzKMeaK7gSCmkohQn7phhggLORQ3
         nxs7hpYco3Sraz9gWbjzxIWX1t5rc8lMUFMj8qY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sven Eckelmann <sven@narfation.org>,
        Kalle Valo <quic_kvalo@quicinc.com>
Subject: [PATCH 6.5 23/34] wifi: ath11k: Cleanup mac80211 references on failure during tx_complete
Date:   Mon,  4 Sep 2023 19:30:10 +0100
Message-ID: <20230904182949.678191131@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit 29d15589f084d71a4ea8c544039c5839db0236e2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -344,7 +344,7 @@ ath11k_dp_tx_htt_tx_complete_buf(struct
 	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	if (!skb_cb->vif) {
-		dev_kfree_skb_any(msdu);
+		ieee80211_free_txskb(ar->hw, msdu);
 		return;
 	}
 
@@ -566,12 +566,12 @@ static void ath11k_dp_tx_complete_msdu(s
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
 


