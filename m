Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A1C7A7F95
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbjITM2U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjITM2T (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:28:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74CBAD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:28:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E518C433C7;
        Wed, 20 Sep 2023 12:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212891;
        bh=OIyiCvxG0Q/pCB8rncHU8NwmIOBARJ3PIigro254c9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NONh9wdATdYllYe4xypVDtEs9lyr/t+1Ol1I57sVyX11Mza0RYFQW4NRbFjscjIom
         c+5H9nsm8egONSXZSvyuzyN+vcD9oZ7cq8Qygn5n7I3KGOY6Q5mRuHIXrq+f7IMOnd
         VHf5W3VK+vRtinfxtUGWvZS6o5BfbGea8f8MSBOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/367] mwifiex: switch from pci_ to dma_ API
Date:   Wed, 20 Sep 2023 13:27:23 +0200
Message-ID: <20230920112900.220716360@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 4cf975f640fefdfdf6168a79e882558478ce057a ]

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below and has been
hand modified to replace GFP_ with a correct flag.
It has been compile tested.

When memory is allocated in 'mwifiex_pcie_alloc_buffers()' (see details in
the call chain below) GFP_KERNEL can be used because both
'mwifiex_register()' and 'mwifiex_reinit_sw()' already use GFP_KERNEL.
(for 'mwifiex_reinit_sw()', it is hidden in a call to 'alloc_workqueue()')

The call chain is:
  mwifiex_register
    --> mwifiex_init_pcie        (.init_if function, see mwifiex_if_ops)
   [ or ]
  mwifiex_reinit_sw
    -->mwifiex_pcie_up_dev       (.up_dev function, see mwifiex_if_ops)

    [ then in both case ]
      -->mwifiex_pcie_alloc_buffers
        --> mwifiex_pcie_create_txbd_ring
        --> mwifiex_pcie_create_rxbd_ring
        --> mwifiex_pcie_create_evtbd_ring
        --> mwifiex_pcie_alloc_sleep_cookie_buf

@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200819070152.111522-1-christophe.jaillet@wanadoo.fr
Stable-dep-of: 288c63d5cb46 ("wifi: mwifiex: fix error recovery in PCIE buffer descriptor management")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 153 ++++++++++----------
 1 file changed, 78 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index b316e34917958..80dde94b65c87 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -58,8 +58,8 @@ mwifiex_map_pci_memory(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 	struct pcie_service_card *card = adapter->card;
 	struct mwifiex_dma_mapping mapping;
 
-	mapping.addr = pci_map_single(card->dev, skb->data, size, flags);
-	if (pci_dma_mapping_error(card->dev, mapping.addr)) {
+	mapping.addr = dma_map_single(&card->dev->dev, skb->data, size, flags);
+	if (dma_mapping_error(&card->dev->dev, mapping.addr)) {
 		mwifiex_dbg(adapter, ERROR, "failed to map pci memory!\n");
 		return -1;
 	}
@@ -75,7 +75,7 @@ static void mwifiex_unmap_pci_memory(struct mwifiex_adapter *adapter,
 	struct mwifiex_dma_mapping mapping;
 
 	mwifiex_get_mapping(skb, &mapping);
-	pci_unmap_single(card->dev, mapping.addr, mapping.len, flags);
+	dma_unmap_single(&card->dev->dev, mapping.addr, mapping.len, flags);
 }
 
 /*
@@ -465,10 +465,9 @@ static void mwifiex_delay_for_sleep_cookie(struct mwifiex_adapter *adapter,
 	struct sk_buff *cmdrsp = card->cmdrsp_buf;
 
 	for (count = 0; count < max_delay_loop_cnt; count++) {
-		pci_dma_sync_single_for_cpu(card->dev,
-					    MWIFIEX_SKB_DMA_ADDR(cmdrsp),
-					    sizeof(sleep_cookie),
-					    PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_cpu(&card->dev->dev,
+					MWIFIEX_SKB_DMA_ADDR(cmdrsp),
+					sizeof(sleep_cookie), DMA_FROM_DEVICE);
 		buffer = cmdrsp->data;
 		sleep_cookie = get_unaligned_le32(buffer);
 
@@ -477,10 +476,10 @@ static void mwifiex_delay_for_sleep_cookie(struct mwifiex_adapter *adapter,
 				    "sleep cookie found at count %d\n", count);
 			break;
 		}
-		pci_dma_sync_single_for_device(card->dev,
-					       MWIFIEX_SKB_DMA_ADDR(cmdrsp),
-					       sizeof(sleep_cookie),
-					       PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_device(&card->dev->dev,
+					   MWIFIEX_SKB_DMA_ADDR(cmdrsp),
+					   sizeof(sleep_cookie),
+					   DMA_FROM_DEVICE);
 		usleep_range(20, 30);
 	}
 
@@ -634,7 +633,7 @@ static int mwifiex_init_rxq_ring(struct mwifiex_adapter *adapter)
 
 		if (mwifiex_map_pci_memory(adapter, skb,
 					   MWIFIEX_RX_DATA_BUF_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -691,7 +690,7 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		skb_put(skb, MAX_EVENT_SIZE);
 
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
-					   PCI_DMA_FROMDEVICE)) {
+					   DMA_FROM_DEVICE)) {
 			kfree_skb(skb);
 			kfree(card->evtbd_ring_vbase);
 			return -1;
@@ -734,7 +733,7 @@ static void mwifiex_cleanup_txq_ring(struct mwifiex_adapter *adapter)
 			if (card->tx_buf_list[i]) {
 				skb = card->tx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc2, 0, sizeof(*desc2));
@@ -743,7 +742,7 @@ static void mwifiex_cleanup_txq_ring(struct mwifiex_adapter *adapter)
 			if (card->tx_buf_list[i]) {
 				skb = card->tx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc, 0, sizeof(*desc));
@@ -773,7 +772,7 @@ static void mwifiex_cleanup_rxq_ring(struct mwifiex_adapter *adapter)
 			if (card->rx_buf_list[i]) {
 				skb = card->rx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_FROMDEVICE);
+							 DMA_FROM_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc2, 0, sizeof(*desc2));
@@ -782,7 +781,7 @@ static void mwifiex_cleanup_rxq_ring(struct mwifiex_adapter *adapter)
 			if (card->rx_buf_list[i]) {
 				skb = card->rx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_FROMDEVICE);
+							 DMA_FROM_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc, 0, sizeof(*desc));
@@ -808,7 +807,7 @@ static void mwifiex_cleanup_evt_ring(struct mwifiex_adapter *adapter)
 		if (card->evt_buf_list[i]) {
 			skb = card->evt_buf_list[i];
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_FROMDEVICE);
+						 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 		}
 		card->evt_buf_list[i] = NULL;
@@ -849,9 +848,10 @@ static int mwifiex_pcie_create_txbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: txbd_ring: Allocating %d bytes\n",
 		    card->txbd_ring_size);
-	card->txbd_ring_vbase = pci_alloc_consistent(card->dev,
-						     card->txbd_ring_size,
-						     &card->txbd_ring_pbase);
+	card->txbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+						   card->txbd_ring_size,
+						   &card->txbd_ring_pbase,
+						   GFP_KERNEL);
 	if (!card->txbd_ring_vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate consistent memory (%d bytes) failed!\n",
@@ -875,9 +875,9 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_cleanup_txq_ring(adapter);
 
 	if (card->txbd_ring_vbase)
-		pci_free_consistent(card->dev, card->txbd_ring_size,
-				    card->txbd_ring_vbase,
-				    card->txbd_ring_pbase);
+		dma_free_coherent(&card->dev->dev, card->txbd_ring_size,
+				  card->txbd_ring_vbase,
+				  card->txbd_ring_pbase);
 	card->txbd_ring_size = 0;
 	card->txbd_wrptr = 0;
 	card->txbd_rdptr = 0 | reg->tx_rollover_ind;
@@ -913,9 +913,10 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: rxbd_ring: Allocating %d bytes\n",
 		    card->rxbd_ring_size);
-	card->rxbd_ring_vbase = pci_alloc_consistent(card->dev,
-						     card->rxbd_ring_size,
-						     &card->rxbd_ring_pbase);
+	card->rxbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+						   card->rxbd_ring_size,
+						   &card->rxbd_ring_pbase,
+						   GFP_KERNEL);
 	if (!card->rxbd_ring_vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate consistent memory (%d bytes) failed!\n",
@@ -943,9 +944,9 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_cleanup_rxq_ring(adapter);
 
 	if (card->rxbd_ring_vbase)
-		pci_free_consistent(card->dev, card->rxbd_ring_size,
-				    card->rxbd_ring_vbase,
-				    card->rxbd_ring_pbase);
+		dma_free_coherent(&card->dev->dev, card->rxbd_ring_size,
+				  card->rxbd_ring_vbase,
+				  card->rxbd_ring_pbase);
 	card->rxbd_ring_size = 0;
 	card->rxbd_wrptr = 0;
 	card->rxbd_rdptr = 0 | reg->rx_rollover_ind;
@@ -977,9 +978,10 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_dbg(adapter, INFO,
 		    "info: evtbd_ring: Allocating %d bytes\n",
 		card->evtbd_ring_size);
-	card->evtbd_ring_vbase = pci_alloc_consistent(card->dev,
-						      card->evtbd_ring_size,
-						      &card->evtbd_ring_pbase);
+	card->evtbd_ring_vbase = dma_alloc_coherent(&card->dev->dev,
+						    card->evtbd_ring_size,
+						    &card->evtbd_ring_pbase,
+						    GFP_KERNEL);
 	if (!card->evtbd_ring_vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "allocate consistent memory (%d bytes) failed!\n",
@@ -1007,9 +1009,9 @@ static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter)
 	mwifiex_cleanup_evt_ring(adapter);
 
 	if (card->evtbd_ring_vbase)
-		pci_free_consistent(card->dev, card->evtbd_ring_size,
-				    card->evtbd_ring_vbase,
-				    card->evtbd_ring_pbase);
+		dma_free_coherent(&card->dev->dev, card->evtbd_ring_size,
+				  card->evtbd_ring_vbase,
+				  card->evtbd_ring_pbase);
 	card->evtbd_wrptr = 0;
 	card->evtbd_rdptr = 0 | reg->evt_rollover_ind;
 	card->evtbd_ring_size = 0;
@@ -1036,7 +1038,7 @@ static int mwifiex_pcie_alloc_cmdrsp_buf(struct mwifiex_adapter *adapter)
 	}
 	skb_put(skb, MWIFIEX_UPLD_SIZE);
 	if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-				   PCI_DMA_FROMDEVICE)) {
+				   DMA_FROM_DEVICE)) {
 		kfree_skb(skb);
 		return -1;
 	}
@@ -1060,14 +1062,14 @@ static int mwifiex_pcie_delete_cmdrsp_buf(struct mwifiex_adapter *adapter)
 
 	if (card && card->cmdrsp_buf) {
 		mwifiex_unmap_pci_memory(adapter, card->cmdrsp_buf,
-					 PCI_DMA_FROMDEVICE);
+					 DMA_FROM_DEVICE);
 		dev_kfree_skb_any(card->cmdrsp_buf);
 		card->cmdrsp_buf = NULL;
 	}
 
 	if (card && card->cmd_buf) {
 		mwifiex_unmap_pci_memory(adapter, card->cmd_buf,
-					 PCI_DMA_TODEVICE);
+					 DMA_TO_DEVICE);
 		dev_kfree_skb_any(card->cmd_buf);
 		card->cmd_buf = NULL;
 	}
@@ -1082,8 +1084,10 @@ static int mwifiex_pcie_alloc_sleep_cookie_buf(struct mwifiex_adapter *adapter)
 	struct pcie_service_card *card = adapter->card;
 	u32 *cookie;
 
-	card->sleep_cookie_vbase = pci_alloc_consistent(card->dev, sizeof(u32),
-						     &card->sleep_cookie_pbase);
+	card->sleep_cookie_vbase = dma_alloc_coherent(&card->dev->dev,
+						      sizeof(u32),
+						      &card->sleep_cookie_pbase,
+						      GFP_KERNEL);
 	if (!card->sleep_cookie_vbase) {
 		mwifiex_dbg(adapter, ERROR,
 			    "pci_alloc_consistent failed!\n");
@@ -1111,9 +1115,9 @@ static int mwifiex_pcie_delete_sleep_cookie_buf(struct mwifiex_adapter *adapter)
 	card = adapter->card;
 
 	if (card && card->sleep_cookie_vbase) {
-		pci_free_consistent(card->dev, sizeof(u32),
-				    card->sleep_cookie_vbase,
-				    card->sleep_cookie_pbase);
+		dma_free_coherent(&card->dev->dev, sizeof(u32),
+				  card->sleep_cookie_vbase,
+				  card->sleep_cookie_pbase);
 		card->sleep_cookie_vbase = NULL;
 	}
 
@@ -1185,7 +1189,7 @@ static int mwifiex_pcie_send_data_complete(struct mwifiex_adapter *adapter)
 				    "SEND COMP: Detach skb %p at txbd_rdidx=%d\n",
 				    skb, wrdoneidx);
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_TODEVICE);
+						 DMA_TO_DEVICE);
 
 			unmap_count++;
 
@@ -1278,7 +1282,7 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 		put_unaligned_le16(MWIFIEX_TYPE_DATA, payload + 2);
 
 		if (mwifiex_map_pci_memory(adapter, skb, skb->len,
-					   PCI_DMA_TODEVICE))
+					   DMA_TO_DEVICE))
 			return -1;
 
 		wrindx = (card->txbd_wrptr & reg->tx_mask) >> reg->tx_start_ptr;
@@ -1368,7 +1372,7 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 
 	return -EINPROGRESS;
 done_unmap:
-	mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+	mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 	card->tx_buf_list[wrindx] = NULL;
 	atomic_dec(&adapter->tx_hw_pending);
 	if (reg->pfu_enabled)
@@ -1422,7 +1426,7 @@ static int mwifiex_pcie_process_recv_data(struct mwifiex_adapter *adapter)
 		if (!skb_data)
 			return -ENOMEM;
 
-		mwifiex_unmap_pci_memory(adapter, skb_data, PCI_DMA_FROMDEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb_data, DMA_FROM_DEVICE);
 		card->rx_buf_list[rd_index] = NULL;
 
 		/* Get data length from interface header -
@@ -1460,7 +1464,7 @@ static int mwifiex_pcie_process_recv_data(struct mwifiex_adapter *adapter)
 
 		if (mwifiex_map_pci_memory(adapter, skb_tmp,
 					   MWIFIEX_RX_DATA_BUF_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb_tmp);
@@ -1537,7 +1541,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		return -1;
 	}
 
-	if (mwifiex_map_pci_memory(adapter, skb, skb->len, PCI_DMA_TODEVICE))
+	if (mwifiex_map_pci_memory(adapter, skb, skb->len, DMA_TO_DEVICE))
 		return -1;
 
 	buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -1549,7 +1553,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write download command to boot code.\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1561,7 +1565,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write download command to boot code.\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1570,7 +1574,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write command len to cmd_size scratch reg\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1579,7 +1583,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 			      CPU_INTR_DOOR_BELL)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to assert door-bell intr\n", __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1638,7 +1642,7 @@ mwifiex_pcie_send_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 	put_unaligned_le16((u16)skb->len, &payload[0]);
 	put_unaligned_le16(MWIFIEX_TYPE_CMD, &payload[2]);
 
-	if (mwifiex_map_pci_memory(adapter, skb, skb->len, PCI_DMA_TODEVICE))
+	if (mwifiex_map_pci_memory(adapter, skb, skb->len, DMA_TO_DEVICE))
 		return -1;
 
 	card->cmd_buf = skb;
@@ -1738,17 +1742,16 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 		    "info: Rx CMD Response\n");
 
 	if (adapter->curr_cmd)
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_FROMDEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_FROM_DEVICE);
 	else
-		pci_dma_sync_single_for_cpu(card->dev,
-					    MWIFIEX_SKB_DMA_ADDR(skb),
-					    MWIFIEX_UPLD_SIZE,
-					    PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_cpu(&card->dev->dev,
+					MWIFIEX_SKB_DMA_ADDR(skb),
+					MWIFIEX_UPLD_SIZE, DMA_FROM_DEVICE);
 
 	/* Unmap the command as a response has been received. */
 	if (card->cmd_buf) {
 		mwifiex_unmap_pci_memory(adapter, card->cmd_buf,
-					 PCI_DMA_TODEVICE);
+					 DMA_TO_DEVICE);
 		dev_kfree_skb_any(card->cmd_buf);
 		card->cmd_buf = NULL;
 	}
@@ -1759,10 +1762,10 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 
 	if (!adapter->curr_cmd) {
 		if (adapter->ps_state == PS_STATE_SLEEP_CFM) {
-			pci_dma_sync_single_for_device(card->dev,
-						MWIFIEX_SKB_DMA_ADDR(skb),
-						MWIFIEX_SLEEP_COOKIE_SIZE,
-						PCI_DMA_FROMDEVICE);
+			dma_sync_single_for_device(&card->dev->dev,
+						   MWIFIEX_SKB_DMA_ADDR(skb),
+						   MWIFIEX_SLEEP_COOKIE_SIZE,
+						   DMA_FROM_DEVICE);
 			if (mwifiex_write_reg(adapter,
 					      PCIE_CPU_INT_EVENT,
 					      CPU_INTR_SLEEP_CFM_DONE)) {
@@ -1773,7 +1776,7 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 			mwifiex_delay_for_sleep_cookie(adapter,
 						       MWIFIEX_MAX_DELAY_COUNT);
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_FROMDEVICE);
+						 DMA_FROM_DEVICE);
 			skb_pull(skb, adapter->intf_hdr_len);
 			while (reg->sleep_cookie && (count++ < 10) &&
 			       mwifiex_pcie_ok_to_access_hw(adapter))
@@ -1789,7 +1792,7 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 		       min_t(u32, MWIFIEX_SIZE_OF_CMD_BUFFER, skb->len));
 		skb_push(skb, adapter->intf_hdr_len);
 		if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 	} else if (mwifiex_pcie_ok_to_access_hw(adapter)) {
 		skb_pull(skb, adapter->intf_hdr_len);
@@ -1831,7 +1834,7 @@ static int mwifiex_pcie_cmdrsp_complete(struct mwifiex_adapter *adapter,
 		card->cmdrsp_buf = skb;
 		skb_push(card->cmdrsp_buf, adapter->intf_hdr_len);
 		if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 	}
 
@@ -1886,7 +1889,7 @@ static int mwifiex_pcie_process_event_ready(struct mwifiex_adapter *adapter)
 		mwifiex_dbg(adapter, INFO,
 			    "info: Read Index: %d\n", rdptr);
 		skb_cmd = card->evt_buf_list[rdptr];
-		mwifiex_unmap_pci_memory(adapter, skb_cmd, PCI_DMA_FROMDEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb_cmd, DMA_FROM_DEVICE);
 
 		/* Take the pointer and set it to event pointer in adapter
 		   and will return back after event handling callback */
@@ -1966,7 +1969,7 @@ static int mwifiex_pcie_event_complete(struct mwifiex_adapter *adapter,
 		skb_put(skb, MAX_EVENT_SIZE - skb->len);
 		if (mwifiex_map_pci_memory(adapter, skb,
 					   MAX_EVENT_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 		card->evt_buf_list[rdptr] = skb;
 		desc = card->evtbd_ring[rdptr];
@@ -2248,7 +2251,7 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
 					    "interrupt status during fw dnld.\n",
 					    __func__);
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				ret = -1;
 				goto done;
 			}
@@ -2260,12 +2263,12 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
 			mwifiex_dbg(adapter, ERROR, "%s: Card failed to ACK download\n",
 				    __func__);
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_TODEVICE);
+						 DMA_TO_DEVICE);
 			ret = -1;
 			goto done;
 		}
 
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 
 		offset += txlen;
 	} while (true);
@@ -2935,13 +2938,13 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 
 	pci_set_master(pdev);
 
-	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		pr_err("set_dma_mask(32) failed: %d\n", ret);
 		goto err_set_dma_mask;
 	}
 
-	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(32));
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		pr_err("set_consistent_dma_mask(64) failed\n");
 		goto err_set_dma_mask;
-- 
2.40.1



