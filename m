Return-Path: <stable+bounces-1513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FF27F8014
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9FB1C21435
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7E7381D4;
	Fri, 24 Nov 2023 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbFyzaWT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1633075;
	Fri, 24 Nov 2023 18:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070ADC433C9;
	Fri, 24 Nov 2023 18:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851588;
	bh=Oo9IUZWlf+m609phwSnLi0cjwJWS5FHy38A9MwVqBeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wbFyzaWThGbDpV2YtjHzC8j9SrYz+CB7ekMHLjREDUOYVkAaUY20xWzdY8PlbXcx8
	 e2nAV4coMko9WrbQZRrjj7DdKluwzw43i46XSZUkjqJ+01W1P9n8nDgSQAe1YJF+72
	 czvGcuqUY23mPNAxHslQ3j2Yi2xsIryRg92vVM8Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sieng-Piaw Liew <liew.s.piaw@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 016/372] atl1c: Work around the DMA RX overflow issue
Date: Fri, 24 Nov 2023 17:46:43 +0000
Message-ID: <20231124172011.005328150@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sieng-Piaw Liew <liew.s.piaw@gmail.com>

[ Upstream commit 86565682e9053e5deb128193ea9e88531bbae9cf ]

This is based on alx driver commit 881d0327db37 ("net: alx: Work around
the DMA RX overflow issue").

The alx and atl1c drivers had RX overflow error which was why a custom
allocator was created to avoid certain addresses. The simpler workaround
then created for alx driver, but not for atl1c due to lack of tester.

Instead of using a custom allocator, check the allocated skb address and
use skb_reserve() to move away from problematic 0x...fc0 address.

Tested on AR8131 on Acer 4540.

Signed-off-by: Sieng-Piaw Liew <liew.s.piaw@gmail.com>
Link: https://lore.kernel.org/r/20230912010711.12036-1-liew.s.piaw@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atl1c/atl1c.h    |  3 -
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 67 +++++--------------
 2 files changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c.h b/drivers/net/ethernet/atheros/atl1c/atl1c.h
index 43d821fe7a542..63ba64dbb7310 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c.h
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c.h
@@ -504,15 +504,12 @@ struct atl1c_rrd_ring {
 	u16 next_to_use;
 	u16 next_to_clean;
 	struct napi_struct napi;
-	struct page *rx_page;
-	unsigned int rx_page_offset;
 };
 
 /* board specific private data structure */
 struct atl1c_adapter {
 	struct net_device   *netdev;
 	struct pci_dev      *pdev;
-	unsigned int	    rx_frag_size;
 	struct atl1c_hw        hw;
 	struct atl1c_hw_stats  hw_stats;
 	struct mii_if_info  mii;    /* MII interface info */
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 7762e532c6a4f..6eb86d75955fe 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -493,15 +493,10 @@ static int atl1c_set_mac_addr(struct net_device *netdev, void *p)
 static void atl1c_set_rxbufsize(struct atl1c_adapter *adapter,
 				struct net_device *dev)
 {
-	unsigned int head_size;
 	int mtu = dev->mtu;
 
 	adapter->rx_buffer_len = mtu > AT_RX_BUF_SIZE ?
 		roundup(mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN, 8) : AT_RX_BUF_SIZE;
-
-	head_size = SKB_DATA_ALIGN(adapter->rx_buffer_len + NET_SKB_PAD + NET_IP_ALIGN) +
-		    SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	adapter->rx_frag_size = roundup_pow_of_two(head_size);
 }
 
 static netdev_features_t atl1c_fix_features(struct net_device *netdev,
@@ -974,7 +969,6 @@ static void atl1c_init_ring_ptrs(struct atl1c_adapter *adapter)
 static void atl1c_free_ring_resources(struct atl1c_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
-	int i;
 
 	dma_free_coherent(&pdev->dev, adapter->ring_header.size,
 			  adapter->ring_header.desc, adapter->ring_header.dma);
@@ -987,12 +981,6 @@ static void atl1c_free_ring_resources(struct atl1c_adapter *adapter)
 		kfree(adapter->tpd_ring[0].buffer_info);
 		adapter->tpd_ring[0].buffer_info = NULL;
 	}
-	for (i = 0; i < adapter->rx_queue_count; ++i) {
-		if (adapter->rrd_ring[i].rx_page) {
-			put_page(adapter->rrd_ring[i].rx_page);
-			adapter->rrd_ring[i].rx_page = NULL;
-		}
-	}
 }
 
 /**
@@ -1764,48 +1752,11 @@ static inline void atl1c_rx_checksum(struct atl1c_adapter *adapter,
 	skb_checksum_none_assert(skb);
 }
 
-static struct sk_buff *atl1c_alloc_skb(struct atl1c_adapter *adapter,
-				       u32 queue, bool napi_mode)
-{
-	struct atl1c_rrd_ring *rrd_ring = &adapter->rrd_ring[queue];
-	struct sk_buff *skb;
-	struct page *page;
-
-	if (adapter->rx_frag_size > PAGE_SIZE) {
-		if (likely(napi_mode))
-			return napi_alloc_skb(&rrd_ring->napi,
-					      adapter->rx_buffer_len);
-		else
-			return netdev_alloc_skb_ip_align(adapter->netdev,
-							 adapter->rx_buffer_len);
-	}
-
-	page = rrd_ring->rx_page;
-	if (!page) {
-		page = alloc_page(GFP_ATOMIC);
-		if (unlikely(!page))
-			return NULL;
-		rrd_ring->rx_page = page;
-		rrd_ring->rx_page_offset = 0;
-	}
-
-	skb = build_skb(page_address(page) + rrd_ring->rx_page_offset,
-			adapter->rx_frag_size);
-	if (likely(skb)) {
-		skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
-		rrd_ring->rx_page_offset += adapter->rx_frag_size;
-		if (rrd_ring->rx_page_offset >= PAGE_SIZE)
-			rrd_ring->rx_page = NULL;
-		else
-			get_page(page);
-	}
-	return skb;
-}
-
 static int atl1c_alloc_rx_buffer(struct atl1c_adapter *adapter, u32 queue,
 				 bool napi_mode)
 {
 	struct atl1c_rfd_ring *rfd_ring = &adapter->rfd_ring[queue];
+	struct atl1c_rrd_ring *rrd_ring = &adapter->rrd_ring[queue];
 	struct pci_dev *pdev = adapter->pdev;
 	struct atl1c_buffer *buffer_info, *next_info;
 	struct sk_buff *skb;
@@ -1824,13 +1775,27 @@ static int atl1c_alloc_rx_buffer(struct atl1c_adapter *adapter, u32 queue,
 	while (next_info->flags & ATL1C_BUFFER_FREE) {
 		rfd_desc = ATL1C_RFD_DESC(rfd_ring, rfd_next_to_use);
 
-		skb = atl1c_alloc_skb(adapter, queue, napi_mode);
+		/* When DMA RX address is set to something like
+		 * 0x....fc0, it will be very likely to cause DMA
+		 * RFD overflow issue.
+		 *
+		 * To work around it, we apply rx skb with 64 bytes
+		 * longer space, and offset the address whenever
+		 * 0x....fc0 is detected.
+		 */
+		if (likely(napi_mode))
+			skb = napi_alloc_skb(&rrd_ring->napi, adapter->rx_buffer_len + 64);
+		else
+			skb = netdev_alloc_skb(adapter->netdev, adapter->rx_buffer_len + 64);
 		if (unlikely(!skb)) {
 			if (netif_msg_rx_err(adapter))
 				dev_warn(&pdev->dev, "alloc rx buffer failed\n");
 			break;
 		}
 
+		if (((unsigned long)skb->data & 0xfff) == 0xfc0)
+			skb_reserve(skb, 64);
+
 		/*
 		 * Make buffer alignment 2 beyond a 16 byte boundary
 		 * this will result in a 16 byte aligned IP header after
-- 
2.42.0




