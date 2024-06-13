Return-Path: <stable+bounces-51881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4141690720D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4B1D1F21580
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDF51428EF;
	Thu, 13 Jun 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JkwwDbbV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25CB12C47D;
	Thu, 13 Jun 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282590; cv=none; b=oDSWsx1OMI/RgH/kgTCPgoIes1xS1dWHprc6FC6UJ2V4xD7V5OhD25JFAj3rXn+lDtwB/o9L/bHtTXbErbuphyS+ds7ZyXcDSbg5YcGupWLq2wMtXDTDuQ/Eqn80R0Qh2E/s9024ysLCTtNq66ePfLhYCM8cNj1pHYGgyLKwabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282590; c=relaxed/simple;
	bh=xKdnjvrr3Iehzd3+r31LGkDTXKPp8N8AguJTlyeUd0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjQTgp8XI0prLkt+IXDF7h4SHp5/spkfTpdxR6quarLRhdScLe8ZVB3zWnBL6Rqypsvk+FbdT3YDynYS6SrFLXOvWAtS3919he209m9VsBNiR01VosfcplePTjxR4JLQaN718gqxy/iE42NTs1RzBWdWo/Du/URO9y11Z4FtSZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JkwwDbbV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679F4C2BBFC;
	Thu, 13 Jun 2024 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282589;
	bh=xKdnjvrr3Iehzd3+r31LGkDTXKPp8N8AguJTlyeUd0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JkwwDbbVSwr8Ga/U3JtUhVsMU1k0nlclkjgGFBWYePxheaA0BzWOa+g+LxiKX2Y0a
	 4O+CdHHqw68xQAfA2yTXAqx9SimwpozFPm1imMrIpFb8mRubq0Ofr8mzGX90/wowBN
	 uONtdzDh7Dh9LP/+/kcsnT/ycoyx9rqle5m5uWUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Shay Agroskin <shayagr@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 329/402] net: ena: Add dynamic recycling mechanism for rx buffers
Date: Thu, 13 Jun 2024 13:34:46 +0200
Message-ID: <20240613113314.971038711@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit f7d625adeb7bc6a9ec83d32d9615889969d64484 ]

The current implementation allocates page-sized rx buffers.
As traffic may consist of different types and sizes of packets,
in various cases, buffers are not fully used.

This change (Dynamic RX Buffers - DRB) uses part of the allocated rx
page needed for the incoming packet, and returns the rest of the
unused page to be used again as an rx buffer for future packets.
A threshold of 2K for unused space has been set in order to declare
whether the remainder of the page can be reused again as an rx buffer.

As a page may be reused, dma_sync_single_for_cpu() is added in order
to sync the memory to the CPU side after it was owned by the HW.
In addition, when the rx page can no longer be reused, it is being
unmapped using dma_page_unmap(), which implicitly syncs and then
unmaps the entire page. In case the kernel still handles the skbs
pointing to the previous buffers from that rx page, it may access
garbage pointers, caused by the implicit sync overwriting them.
The implicit dma sync is removed by replacing dma_page_unmap() with
dma_unmap_page_attrs() with DMA_ATTR_SKIP_CPU_SYNC flag.

The functionality is disabled for XDP traffic to avoid handling
several descriptors per packet.

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Link: https://lore.kernel.org/r/20230612121448.28829-1-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2dc8b1e7177d ("net: ena: Fix redundant device NUMA node override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../device_drivers/ethernet/amazon/ena.rst    |  32 +++++
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |   6 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  | 136 ++++++++++++------
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   4 +
 4 files changed, 136 insertions(+), 42 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 01b2a69b0cb03..a8a2aa2ae8975 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -205,6 +205,7 @@ Adaptive coalescing can be switched on/off through `ethtool(8)`'s
 More information about Adaptive Interrupt Moderation (DIM) can be found in
 Documentation/networking/net_dim.rst
 
+.. _`RX copybreak`:
 RX copybreak
 ============
 The rx_copybreak is initialized by default to ENA_DEFAULT_RX_COPYBREAK
@@ -315,3 +316,34 @@ Rx
 - The new SKB is updated with the necessary information (protocol,
   checksum hw verify result, etc), and then passed to the network
   stack, using the NAPI interface function :code:`napi_gro_receive()`.
+
+Dynamic RX Buffers (DRB)
+------------------------
+
+Each RX descriptor in the RX ring is a single memory page (which is either 4KB
+or 16KB long depending on system's configurations).
+To reduce the memory allocations required when dealing with a high rate of small
+packets, the driver tries to reuse the remaining RX descriptor's space if more
+than 2KB of this page remain unused.
+
+A simple example of this mechanism is the following sequence of events:
+
+::
+
+        1. Driver allocates page-sized RX buffer and passes it to hardware
+                +----------------------+
+                |4KB RX Buffer         |
+                +----------------------+
+
+        2. A 300Bytes packet is received on this buffer
+
+        3. The driver increases the ref count on this page and returns it back to
+           HW as an RX buffer of size 4KB - 300Bytes = 3796 Bytes
+               +----+--------------------+
+               |****|3796 Bytes RX Buffer|
+               +----+--------------------+
+
+This mechanism isn't used when an XDP program is loaded, or when the
+RX packet is less than rx_copybreak bytes (in which case the packet is
+copied out of the RX buffer into the linear part of a new skb allocated
+for it and the RX buffer remains the same size, see `RX copybreak`_).
diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 466ad9470d1f4..6de0d590be34f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -869,7 +869,9 @@ struct ena_admin_host_info {
 	 * 2 : interrupt_moderation
 	 * 3 : rx_buf_mirroring
 	 * 4 : rss_configurable_function_key
-	 * 31:5 : reserved
+	 * 5 : reserved
+	 * 6 : rx_page_reuse
+	 * 31:7 : reserved
 	 */
 	u32 driver_supported_features;
 };
@@ -1184,6 +1186,8 @@ struct ena_admin_ena_mmio_req_read_less_resp {
 #define ENA_ADMIN_HOST_INFO_RX_BUF_MIRRORING_MASK           BIT(3)
 #define ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_SHIFT 4
 #define ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK BIT(4)
+#define ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_SHIFT             6
+#define ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK              BIT(6)
 
 /* aenq_common_desc */
 #define ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK               BIT(0)
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index e2b43d0f90784..c407fad52aeb3 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1022,7 +1022,7 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 	int tailroom;
 
 	/* restore page offset value in case it has been changed by device */
-	rx_info->page_offset = headroom;
+	rx_info->buf_offset = headroom;
 
 	/* if previous allocated page is not used */
 	if (unlikely(rx_info->page))
@@ -1039,6 +1039,8 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 	tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	rx_info->page = page;
+	rx_info->dma_addr = dma;
+	rx_info->page_offset = 0;
 	ena_buf = &rx_info->ena_buf;
 	ena_buf->paddr = dma + headroom;
 	ena_buf->len = ENA_PAGE_SIZE - headroom - tailroom;
@@ -1046,14 +1048,12 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 	return 0;
 }
 
-static void ena_unmap_rx_buff(struct ena_ring *rx_ring,
-			      struct ena_rx_buffer *rx_info)
+static void ena_unmap_rx_buff_attrs(struct ena_ring *rx_ring,
+				    struct ena_rx_buffer *rx_info,
+				    unsigned long attrs)
 {
-	struct ena_com_buf *ena_buf = &rx_info->ena_buf;
-
-	dma_unmap_page(rx_ring->dev, ena_buf->paddr - rx_ring->rx_headroom,
-		       ENA_PAGE_SIZE,
-		       DMA_BIDIRECTIONAL);
+	dma_unmap_page_attrs(rx_ring->dev, rx_info->dma_addr, ENA_PAGE_SIZE,
+			     DMA_BIDIRECTIONAL, attrs);
 }
 
 static void ena_free_rx_page(struct ena_ring *rx_ring,
@@ -1067,7 +1067,7 @@ static void ena_free_rx_page(struct ena_ring *rx_ring,
 		return;
 	}
 
-	ena_unmap_rx_buff(rx_ring, rx_info);
+	ena_unmap_rx_buff_attrs(rx_ring, rx_info, 0);
 
 	__free_page(page);
 	rx_info->page = NULL;
@@ -1413,14 +1413,14 @@ static int ena_clean_tx_irq(struct ena_ring *tx_ring, u32 budget)
 	return tx_pkts;
 }
 
-static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag)
+static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag, u16 len)
 {
 	struct sk_buff *skb;
 
 	if (!first_frag)
-		skb = napi_alloc_skb(rx_ring->napi, rx_ring->rx_copybreak);
+		skb = napi_alloc_skb(rx_ring->napi, len);
 	else
-		skb = napi_build_skb(first_frag, ENA_PAGE_SIZE);
+		skb = napi_build_skb(first_frag, len);
 
 	if (unlikely(!skb)) {
 		ena_increase_stat(&rx_ring->rx_stats.skb_alloc_fail, 1,
@@ -1429,24 +1429,47 @@ static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag)
 		netif_dbg(rx_ring->adapter, rx_err, rx_ring->netdev,
 			  "Failed to allocate skb. first_frag %s\n",
 			  first_frag ? "provided" : "not provided");
-		return NULL;
 	}
 
 	return skb;
 }
 
+static bool ena_try_rx_buf_page_reuse(struct ena_rx_buffer *rx_info, u16 buf_len,
+				      u16 len, int pkt_offset)
+{
+	struct ena_com_buf *ena_buf = &rx_info->ena_buf;
+
+	/* More than ENA_MIN_RX_BUF_SIZE left in the reused buffer
+	 * for data + headroom + tailroom.
+	 */
+	if (SKB_DATA_ALIGN(len + pkt_offset) + ENA_MIN_RX_BUF_SIZE <= ena_buf->len) {
+		page_ref_inc(rx_info->page);
+		rx_info->page_offset += buf_len;
+		ena_buf->paddr += buf_len;
+		ena_buf->len -= buf_len;
+		return true;
+	}
+
+	return false;
+}
+
 static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 				  struct ena_com_rx_buf_info *ena_bufs,
 				  u32 descs,
 				  u16 *next_to_clean)
 {
+	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	bool is_xdp_loaded = ena_xdp_present_ring(rx_ring);
 	struct ena_rx_buffer *rx_info;
 	struct ena_adapter *adapter;
+	int page_offset, pkt_offset;
+	dma_addr_t pre_reuse_paddr;
 	u16 len, req_id, buf = 0;
+	bool reuse_rx_buf_page;
 	struct sk_buff *skb;
-	void *page_addr;
-	u32 page_offset;
-	void *data_addr;
+	void *buf_addr;
+	int buf_offset;
+	u16 buf_len;
 
 	len = ena_bufs[buf].len;
 	req_id = ena_bufs[buf].req_id;
@@ -1466,34 +1489,30 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		  "rx_info %p page %p\n",
 		  rx_info, rx_info->page);
 
-	/* save virt address of first buffer */
-	page_addr = page_address(rx_info->page);
+	buf_offset = rx_info->buf_offset;
+	pkt_offset = buf_offset - rx_ring->rx_headroom;
 	page_offset = rx_info->page_offset;
-	data_addr = page_addr + page_offset;
-
-	prefetch(data_addr);
+	buf_addr = page_address(rx_info->page) + page_offset;
 
 	if (len <= rx_ring->rx_copybreak) {
-		skb = ena_alloc_skb(rx_ring, NULL);
+		skb = ena_alloc_skb(rx_ring, NULL, len);
 		if (unlikely(!skb))
 			return NULL;
 
-		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
-			  "RX allocated small packet. len %d. data_len %d\n",
-			  skb->len, skb->data_len);
-
 		/* sync this buffer for CPU use */
 		dma_sync_single_for_cpu(rx_ring->dev,
-					dma_unmap_addr(&rx_info->ena_buf, paddr),
+					dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
 					len,
 					DMA_FROM_DEVICE);
-		skb_copy_to_linear_data(skb, data_addr, len);
+		skb_copy_to_linear_data(skb, buf_addr + buf_offset, len);
 		dma_sync_single_for_device(rx_ring->dev,
-					   dma_unmap_addr(&rx_info->ena_buf, paddr),
+					   dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
 					   len,
 					   DMA_FROM_DEVICE);
 
 		skb_put(skb, len);
+		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
+			  "RX allocated small packet. len %d.\n", skb->len);
 		skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 		rx_ring->free_ids[*next_to_clean] = req_id;
 		*next_to_clean = ENA_RX_RING_IDX_ADD(*next_to_clean, descs,
@@ -1501,14 +1520,28 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		return skb;
 	}
 
-	ena_unmap_rx_buff(rx_ring, rx_info);
+	buf_len = SKB_DATA_ALIGN(len + buf_offset + tailroom);
+
+	pre_reuse_paddr = dma_unmap_addr(&rx_info->ena_buf, paddr);
+
+	/* If XDP isn't loaded try to reuse part of the RX buffer */
+	reuse_rx_buf_page = !is_xdp_loaded &&
+			    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
 
-	skb = ena_alloc_skb(rx_ring, page_addr);
+	dma_sync_single_for_cpu(rx_ring->dev,
+				pre_reuse_paddr + pkt_offset,
+				len,
+				DMA_FROM_DEVICE);
+
+	if (!reuse_rx_buf_page)
+		ena_unmap_rx_buff_attrs(rx_ring, rx_info, DMA_ATTR_SKIP_CPU_SYNC);
+
+	skb = ena_alloc_skb(rx_ring, buf_addr, buf_len);
 	if (unlikely(!skb))
 		return NULL;
 
 	/* Populate skb's linear part */
-	skb_reserve(skb, page_offset);
+	skb_reserve(skb, buf_offset);
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 
@@ -1517,7 +1550,8 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 			  "RX skb updated. len %d. data_len %d\n",
 			  skb->len, skb->data_len);
 
-		rx_info->page = NULL;
+		if (!reuse_rx_buf_page)
+			rx_info->page = NULL;
 
 		rx_ring->free_ids[*next_to_clean] = req_id;
 		*next_to_clean =
@@ -1532,10 +1566,28 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 
 		rx_info = &rx_ring->rx_buffer_info[req_id];
 
-		ena_unmap_rx_buff(rx_ring, rx_info);
+		/* rx_info->buf_offset includes rx_ring->rx_headroom */
+		buf_offset = rx_info->buf_offset;
+		pkt_offset = buf_offset - rx_ring->rx_headroom;
+		buf_len = SKB_DATA_ALIGN(len + buf_offset + tailroom);
+		page_offset = rx_info->page_offset;
+
+		pre_reuse_paddr = dma_unmap_addr(&rx_info->ena_buf, paddr);
+
+		reuse_rx_buf_page = !is_xdp_loaded &&
+				    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
+
+		dma_sync_single_for_cpu(rx_ring->dev,
+					pre_reuse_paddr + pkt_offset,
+					len,
+					DMA_FROM_DEVICE);
+
+		if (!reuse_rx_buf_page)
+			ena_unmap_rx_buff_attrs(rx_ring, rx_info,
+						DMA_ATTR_SKIP_CPU_SYNC);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_info->page,
-				rx_info->page_offset, len, ENA_PAGE_SIZE);
+				page_offset + buf_offset, len, buf_len);
 
 	} while (1);
 
@@ -1641,14 +1693,14 @@ static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp, u
 
 	rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
 	xdp_prepare_buff(xdp, page_address(rx_info->page),
-			 rx_info->page_offset,
+			 rx_info->buf_offset,
 			 rx_ring->ena_bufs[0].len, false);
 
 	ret = ena_xdp_execute(rx_ring, xdp);
 
 	/* The xdp program might expand the headers */
 	if (ret == ENA_XDP_PASS) {
-		rx_info->page_offset = xdp->data - xdp->data_hard_start;
+		rx_info->buf_offset = xdp->data - xdp->data_hard_start;
 		rx_ring->ena_bufs[0].len = xdp->data_end - xdp->data;
 	}
 
@@ -1703,7 +1755,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 
 		/* First descriptor might have an offset set by the device */
 		rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
-		rx_info->page_offset += ena_rx_ctx.pkt_offset;
+		rx_info->buf_offset += ena_rx_ctx.pkt_offset;
 
 		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
 			  "rx_poll: q %d got packet from ena. descs #: %d l3 proto %d l4 proto %d hash: %x\n",
@@ -1733,8 +1785,9 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 				 * from RX side.
 				 */
 				if (xdp_verdict & ENA_XDP_FORWARDED) {
-					ena_unmap_rx_buff(rx_ring,
-							  &rx_ring->rx_buffer_info[req_id]);
+					ena_unmap_rx_buff_attrs(rx_ring,
+								&rx_ring->rx_buffer_info[req_id],
+								0);
 					rx_ring->rx_buffer_info[req_id].page = NULL;
 				}
 			}
@@ -3218,7 +3271,8 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 		ENA_ADMIN_HOST_INFO_RX_OFFSET_MASK |
 		ENA_ADMIN_HOST_INFO_INTERRUPT_MODERATION_MASK |
 		ENA_ADMIN_HOST_INFO_RX_BUF_MIRRORING_MASK |
-		ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK;
+		ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK |
+		ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK;
 
 	rc = ena_com_set_host_attributes(ena_dev);
 	if (rc) {
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 4ad5a086b47ea..de54815845ab3 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -50,6 +50,8 @@
 #define ENA_DEFAULT_RING_SIZE	(1024)
 #define ENA_MIN_RING_SIZE	(256)
 
+#define ENA_MIN_RX_BUF_SIZE (2048)
+
 #define ENA_MIN_NUM_IO_QUEUES	(1)
 
 #define ENA_TX_WAKEUP_THRESH		(MAX_SKB_FRAGS + 2)
@@ -186,7 +188,9 @@ struct ena_tx_buffer {
 struct ena_rx_buffer {
 	struct sk_buff *skb;
 	struct page *page;
+	dma_addr_t dma_addr;
 	u32 page_offset;
+	u32 buf_offset;
 	struct ena_com_buf ena_buf;
 } ____cacheline_aligned;
 
-- 
2.43.0




