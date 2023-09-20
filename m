Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB317A7F9E
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjITM2p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbjITM2o (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:28:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AB28F
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:28:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A77C433C8;
        Wed, 20 Sep 2023 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212918;
        bh=rctiPsA5SyCmduTWHkQ/LyynlBLXDrFSwU3ZGyQ7aYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+Th3j+U0nfyIFcXgGXydQ52luZi0uln79T11jB5OiZlos6OQWbJTo5t8/Uu3LhRY
         383+jj5LRG+OQrCjqF+gROf05x7ton6sO8JrxtpBMBgI5/+7XW1+K6vEBBgWTZEBvE
         EuOLoNfIrr22jvby39lESU1yZE58HnCXrCft2vEI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmitry Antipov <dmantipov@yandex.ru>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 067/367] wifi: mwifiex: fix error recovery in PCIE buffer descriptor management
Date:   Wed, 20 Sep 2023 13:27:24 +0200
Message-ID: <20230920112900.247774787@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 288c63d5cb4667a51a04668b3e2bb0ea499bc5f4 ]

Add missing 'kfree_skb()' in 'mwifiex_init_rxq_ring()' and never do
'kfree(card->rxbd_ring_vbase)' because this area is DMAed and should
be released with 'dma_free_coherent()'. The latter is performed in
'mwifiex_pcie_delete_rxbd_ring()', which is now called to recover
from possible errors in 'mwifiex_pcie_create_rxbd_ring()'. Likewise
for 'mwifiex_pcie_init_evt_ring()', 'kfree(card->evtbd_ring_vbase)'
'mwifiex_pcie_delete_evtbd_ring()' and 'mwifiex_pcie_create_rxbd_ring()'.

Fixes: d930faee141b ("mwifiex: add support for Marvell pcie8766 chipset")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230731074334.56463-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 25 ++++++++++++++-------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 80dde94b65c87..78d7674e71f9f 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -50,6 +50,8 @@ static int mwifiex_pcie_probe_of(struct device *dev)
 }
 
 static void mwifiex_pcie_work(struct work_struct *work);
+static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter);
+static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter);
 
 static int
 mwifiex_map_pci_memory(struct mwifiex_adapter *adapter, struct sk_buff *skb,
@@ -627,14 +629,15 @@ static int mwifiex_init_rxq_ring(struct mwifiex_adapter *adapter)
 		if (!skb) {
 			mwifiex_dbg(adapter, ERROR,
 				    "Unable to allocate skb for RX ring.\n");
-			kfree(card->rxbd_ring_vbase);
 			return -ENOMEM;
 		}
 
 		if (mwifiex_map_pci_memory(adapter, skb,
 					   MWIFIEX_RX_DATA_BUF_SIZE,
-					   DMA_FROM_DEVICE))
-			return -1;
+					   DMA_FROM_DEVICE)) {
+			kfree_skb(skb);
+			return -ENOMEM;
+		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
 
@@ -684,7 +687,6 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (!skb) {
 			mwifiex_dbg(adapter, ERROR,
 				    "Unable to allocate skb for EVENT buf.\n");
-			kfree(card->evtbd_ring_vbase);
 			return -ENOMEM;
 		}
 		skb_put(skb, MAX_EVENT_SIZE);
@@ -692,8 +694,7 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
 					   DMA_FROM_DEVICE)) {
 			kfree_skb(skb);
-			kfree(card->evtbd_ring_vbase);
-			return -1;
+			return -ENOMEM;
 		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -892,6 +893,7 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -930,7 +932,10 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 		    (u32)((u64)card->rxbd_ring_pbase >> 32),
 		    card->rxbd_ring_size);
 
-	return mwifiex_init_rxq_ring(adapter);
+	ret = mwifiex_init_rxq_ring(adapter);
+	if (ret)
+		mwifiex_pcie_delete_rxbd_ring(adapter);
+	return ret;
 }
 
 /*
@@ -961,6 +966,7 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -995,7 +1001,10 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 		    (u32)((u64)card->evtbd_ring_pbase >> 32),
 		    card->evtbd_ring_size);
 
-	return mwifiex_pcie_init_evt_ring(adapter);
+	ret = mwifiex_pcie_init_evt_ring(adapter);
+	if (ret)
+		mwifiex_pcie_delete_evtbd_ring(adapter);
+	return ret;
 }
 
 /*
-- 
2.40.1



