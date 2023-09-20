Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4A37A7DA5
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjITMLD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbjITMK7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:10:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC2C12B
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:10:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B99DC433C7;
        Wed, 20 Sep 2023 12:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211847;
        bh=L6nZSvE3rbBw2XCwnV3zh4CGoeTfw7n050lhJYdoRU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWu1Kb5AFDYUIHor0KXcpgVCxy9U+6P8z6mLK2wolegy56o9h+jEw0CnPGOwePjaR
         P7BWXL6qMlCsYJp6AvfkgpOUbYBKlBQYTQnoqL4soPXdvB8w0ij2aMMHMKaq6UbXjs
         f2TDvC913UhtsYge3BNLCCgsaUzDJiYMVMcZ5KyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 057/273] mwifiex: switch from pci_ to dma_ API
Date:   Wed, 20 Sep 2023 13:28:17 +0200
Message-ID: <20230920112848.204278644@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 6712b5097bcca..4fce133c3dcac 100644
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
@@ -469,10 +469,9 @@ static void mwifiex_delay_for_sleep_cookie(struct mwifiex_adapter *adapter,
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
 
@@ -481,10 +480,10 @@ static void mwifiex_delay_for_sleep_cookie(struct mwifiex_adapter *adapter,
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
 
@@ -638,7 +637,7 @@ static int mwifiex_init_rxq_ring(struct mwifiex_adapter *adapter)
 
 		if (mwifiex_map_pci_memory(adapter, skb,
 					   MWIFIEX_RX_DATA_BUF_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -695,7 +694,7 @@ static int mwifiex_pcie_init_evt_ring(struct mwifiex_adapter *adapter)
 		skb_put(skb, MAX_EVENT_SIZE);
 
 		if (mwifiex_map_pci_memory(adapter, skb, MAX_EVENT_SIZE,
-					   PCI_DMA_FROMDEVICE)) {
+					   DMA_FROM_DEVICE)) {
 			kfree_skb(skb);
 			kfree(card->evtbd_ring_vbase);
 			return -1;
@@ -738,7 +737,7 @@ static void mwifiex_cleanup_txq_ring(struct mwifiex_adapter *adapter)
 			if (card->tx_buf_list[i]) {
 				skb = card->tx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc2, 0, sizeof(*desc2));
@@ -747,7 +746,7 @@ static void mwifiex_cleanup_txq_ring(struct mwifiex_adapter *adapter)
 			if (card->tx_buf_list[i]) {
 				skb = card->tx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc, 0, sizeof(*desc));
@@ -777,7 +776,7 @@ static void mwifiex_cleanup_rxq_ring(struct mwifiex_adapter *adapter)
 			if (card->rx_buf_list[i]) {
 				skb = card->rx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_FROMDEVICE);
+							 DMA_FROM_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc2, 0, sizeof(*desc2));
@@ -786,7 +785,7 @@ static void mwifiex_cleanup_rxq_ring(struct mwifiex_adapter *adapter)
 			if (card->rx_buf_list[i]) {
 				skb = card->rx_buf_list[i];
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_FROMDEVICE);
+							 DMA_FROM_DEVICE);
 				dev_kfree_skb_any(skb);
 			}
 			memset(desc, 0, sizeof(*desc));
@@ -812,7 +811,7 @@ static void mwifiex_cleanup_evt_ring(struct mwifiex_adapter *adapter)
 		if (card->evt_buf_list[i]) {
 			skb = card->evt_buf_list[i];
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_FROMDEVICE);
+						 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 		}
 		card->evt_buf_list[i] = NULL;
@@ -853,9 +852,10 @@ static int mwifiex_pcie_create_txbd_ring(struct mwifiex_adapter *adapter)
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
@@ -879,9 +879,9 @@ static int mwifiex_pcie_delete_txbd_ring(struct mwifiex_adapter *adapter)
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
@@ -917,9 +917,10 @@ static int mwifiex_pcie_create_rxbd_ring(struct mwifiex_adapter *adapter)
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
@@ -947,9 +948,9 @@ static int mwifiex_pcie_delete_rxbd_ring(struct mwifiex_adapter *adapter)
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
@@ -981,9 +982,10 @@ static int mwifiex_pcie_create_evtbd_ring(struct mwifiex_adapter *adapter)
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
@@ -1011,9 +1013,9 @@ static int mwifiex_pcie_delete_evtbd_ring(struct mwifiex_adapter *adapter)
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
@@ -1040,7 +1042,7 @@ static int mwifiex_pcie_alloc_cmdrsp_buf(struct mwifiex_adapter *adapter)
 	}
 	skb_put(skb, MWIFIEX_UPLD_SIZE);
 	if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-				   PCI_DMA_FROMDEVICE)) {
+				   DMA_FROM_DEVICE)) {
 		kfree_skb(skb);
 		return -1;
 	}
@@ -1064,14 +1066,14 @@ static int mwifiex_pcie_delete_cmdrsp_buf(struct mwifiex_adapter *adapter)
 
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
@@ -1086,8 +1088,10 @@ static int mwifiex_pcie_alloc_sleep_cookie_buf(struct mwifiex_adapter *adapter)
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
@@ -1115,9 +1119,9 @@ static int mwifiex_pcie_delete_sleep_cookie_buf(struct mwifiex_adapter *adapter)
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
 
@@ -1189,7 +1193,7 @@ static int mwifiex_pcie_send_data_complete(struct mwifiex_adapter *adapter)
 				    "SEND COMP: Detach skb %p at txbd_rdidx=%d\n",
 				    skb, wrdoneidx);
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_TODEVICE);
+						 DMA_TO_DEVICE);
 
 			unmap_count++;
 
@@ -1282,7 +1286,7 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 		put_unaligned_le16(MWIFIEX_TYPE_DATA, payload + 2);
 
 		if (mwifiex_map_pci_memory(adapter, skb, skb->len,
-					   PCI_DMA_TODEVICE))
+					   DMA_TO_DEVICE))
 			return -1;
 
 		wrindx = (card->txbd_wrptr & reg->tx_mask) >> reg->tx_start_ptr;
@@ -1372,7 +1376,7 @@ mwifiex_pcie_send_data(struct mwifiex_adapter *adapter, struct sk_buff *skb,
 
 	return -EINPROGRESS;
 done_unmap:
-	mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+	mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 	card->tx_buf_list[wrindx] = NULL;
 	atomic_dec(&adapter->tx_hw_pending);
 	if (reg->pfu_enabled)
@@ -1426,7 +1430,7 @@ static int mwifiex_pcie_process_recv_data(struct mwifiex_adapter *adapter)
 		if (!skb_data)
 			return -ENOMEM;
 
-		mwifiex_unmap_pci_memory(adapter, skb_data, PCI_DMA_FROMDEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb_data, DMA_FROM_DEVICE);
 		card->rx_buf_list[rd_index] = NULL;
 
 		/* Get data length from interface header -
@@ -1464,7 +1468,7 @@ static int mwifiex_pcie_process_recv_data(struct mwifiex_adapter *adapter)
 
 		if (mwifiex_map_pci_memory(adapter, skb_tmp,
 					   MWIFIEX_RX_DATA_BUF_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 
 		buf_pa = MWIFIEX_SKB_DMA_ADDR(skb_tmp);
@@ -1541,7 +1545,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		return -1;
 	}
 
-	if (mwifiex_map_pci_memory(adapter, skb, skb->len, PCI_DMA_TODEVICE))
+	if (mwifiex_map_pci_memory(adapter, skb, skb->len, DMA_TO_DEVICE))
 		return -1;
 
 	buf_pa = MWIFIEX_SKB_DMA_ADDR(skb);
@@ -1553,7 +1557,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write download command to boot code.\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1565,7 +1569,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write download command to boot code.\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1574,7 +1578,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to write command len to cmd_size scratch reg\n",
 			    __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1583,7 +1587,7 @@ mwifiex_pcie_send_boot_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 			      CPU_INTR_DOOR_BELL)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "%s: failed to assert door-bell intr\n", __func__);
-		mwifiex_unmap_pci_memory(adapter, skb, PCI_DMA_TODEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb, DMA_TO_DEVICE);
 		return -1;
 	}
 
@@ -1642,7 +1646,7 @@ mwifiex_pcie_send_cmd(struct mwifiex_adapter *adapter, struct sk_buff *skb)
 	put_unaligned_le16((u16)skb->len, &payload[0]);
 	put_unaligned_le16(MWIFIEX_TYPE_CMD, &payload[2]);
 
-	if (mwifiex_map_pci_memory(adapter, skb, skb->len, PCI_DMA_TODEVICE))
+	if (mwifiex_map_pci_memory(adapter, skb, skb->len, DMA_TO_DEVICE))
 		return -1;
 
 	card->cmd_buf = skb;
@@ -1742,17 +1746,16 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
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
@@ -1763,10 +1766,10 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 
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
@@ -1777,7 +1780,7 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 			mwifiex_delay_for_sleep_cookie(adapter,
 						       MWIFIEX_MAX_DELAY_COUNT);
 			mwifiex_unmap_pci_memory(adapter, skb,
-						 PCI_DMA_FROMDEVICE);
+						 DMA_FROM_DEVICE);
 			skb_pull(skb, adapter->intf_hdr_len);
 			while (reg->sleep_cookie && (count++ < 10) &&
 			       mwifiex_pcie_ok_to_access_hw(adapter))
@@ -1793,7 +1796,7 @@ static int mwifiex_pcie_process_cmd_complete(struct mwifiex_adapter *adapter)
 		       min_t(u32, MWIFIEX_SIZE_OF_CMD_BUFFER, skb->len));
 		skb_push(skb, adapter->intf_hdr_len);
 		if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 	} else if (mwifiex_pcie_ok_to_access_hw(adapter)) {
 		skb_pull(skb, adapter->intf_hdr_len);
@@ -1835,7 +1838,7 @@ static int mwifiex_pcie_cmdrsp_complete(struct mwifiex_adapter *adapter,
 		card->cmdrsp_buf = skb;
 		skb_push(card->cmdrsp_buf, adapter->intf_hdr_len);
 		if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 	}
 
@@ -1890,7 +1893,7 @@ static int mwifiex_pcie_process_event_ready(struct mwifiex_adapter *adapter)
 		mwifiex_dbg(adapter, INFO,
 			    "info: Read Index: %d\n", rdptr);
 		skb_cmd = card->evt_buf_list[rdptr];
-		mwifiex_unmap_pci_memory(adapter, skb_cmd, PCI_DMA_FROMDEVICE);
+		mwifiex_unmap_pci_memory(adapter, skb_cmd, DMA_FROM_DEVICE);
 
 		/* Take the pointer and set it to event pointer in adapter
 		   and will return back after event handling callback */
@@ -1970,7 +1973,7 @@ static int mwifiex_pcie_event_complete(struct mwifiex_adapter *adapter,
 		skb_put(skb, MAX_EVENT_SIZE - skb->len);
 		if (mwifiex_map_pci_memory(adapter, skb,
 					   MAX_EVENT_SIZE,
-					   PCI_DMA_FROMDEVICE))
+					   DMA_FROM_DEVICE))
 			return -1;
 		card->evt_buf_list[rdptr] = skb;
 		desc = card->evtbd_ring[rdptr];
@@ -2252,7 +2255,7 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
 					    "interrupt status during fw dnld.\n",
 					    __func__);
 				mwifiex_unmap_pci_memory(adapter, skb,
-							 PCI_DMA_TODEVICE);
+							 DMA_TO_DEVICE);
 				ret = -1;
 				goto done;
 			}
@@ -2264,12 +2267,12 @@ static int mwifiex_prog_fw_w_helper(struct mwifiex_adapter *adapter,
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
@@ -2939,13 +2942,13 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 
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



