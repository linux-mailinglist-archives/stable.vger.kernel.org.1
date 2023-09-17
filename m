Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6767A3B41
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbjIQUO7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbjIQUOy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:14:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEEBF4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:14:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6B5C433C7;
        Sun, 17 Sep 2023 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981688;
        bh=ZPBc9MRMqMSlD+ZmJ3YSTJm9w3AV75V+BFYpq9Hrevg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vn110lHwQzK0v1BZeDfOj4loyH+c5iGOpZCBLJnEArUGyxP8ueItDHQfZ1wFEgY18
         e+8WQdBHSIbJKlCrrgMbdCgVypTxvWxW+w6CX6bPD/h1m6s6bRAx+zN5sKz7TbUSPa
         vy39/kuVBk7p/2l7oA4BT0fZTcI+bR66DFy8TmGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmitry Antipov <dmantipov@yandex.ru>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 093/511] wifi: mwifiex: fix error recovery in PCIE buffer descriptor management
Date:   Sun, 17 Sep 2023 21:08:40 +0200
Message-ID: <20230917191116.115059056@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 94a6bbcae2d38..8b3f46586654a 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -201,6 +201,8 @@ static int mwifiex_pcie_probe_of(struct device *dev)
 }
 
 static void mwifiex_pcie_work(struct work_struct *work);
+static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter);
+static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter);
 
 static int
 mwifiex_map_pci_memory(struct mwifiex_adapter *adapter, struct sk_buff *skb,
@@ -804,14 +806,15 @@ static int mwifiex_init_rxq_ring(struct mwifiex_adapter *adapter)
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
 
@@ -861,7 +864,6 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (!skb) {
 			mwifiex_dbg(adapter, ERROR,
 				    "Unable to allocate skb for EVENT buf.\n");
-			kfree(card->evtbd_ring_vbase);
 			return -ENOMEM;
 		}
 		skb_put(skb, MAX_EVENT_SIZE);
@@ -869,8 +871,7 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
 					   DMA_FROM_DEVICE)) {
 			kfree_skb(skb);
-			kfree(card->evtbd_ring_vbase);
-			return -1;
+			return -ENOMEM;
 		}
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -1070,6 +1071,7 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -1108,7 +1110,10 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 		    (u32)((u64)card->rxbd_ring_pbase >> 32),
 		    card->rxbd_ring_size);
 
-	return mwifiex_init_rxq_ring(adapter);
+	ret = mwifiex_init_rxq_ring(adapter);
+	if (ret)
+		mwifiex_pcie_delete_rxbd_ring(adapter);
+	return ret;
 }
 
 /*
@@ -1139,6 +1144,7 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
  */
 static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 {
+	int ret;
 	struct pcie_service_card *card = adapter->card;
 	const struct mwifiex_pcie_card_reg *reg = card->pcie.reg;
 
@@ -1173,7 +1179,10 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
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



