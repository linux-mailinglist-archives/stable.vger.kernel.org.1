Return-Path: <stable+bounces-7294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F448171E2
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49AA5B220A9
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F383789C;
	Mon, 18 Dec 2023 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bfzpxXgx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FF1D157;
	Mon, 18 Dec 2023 14:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52769C433CA;
	Mon, 18 Dec 2023 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908081;
	bh=NTue5DdLPl9rddN4WOocw721iU5BempdJlC8q/c+NQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfzpxXgx+8+51CU2w/d5S+kmEVrr5H79skzAeuLlH3pdrFNoHfUECGV63nALk+IvA
	 AjMUCB3vCn11K7vAnWrPSXWe0MXUhki/5f8xYpC8uHlolGNPsZ2jTr6L1KOL4frTX+
	 2XclzRoJws65AlDZH+FuROCbELJAD1AxJcyFb5ug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 046/166] net: ena: Fix DMA syncing in XDP path when SWIOTLB is on
Date: Mon, 18 Dec 2023 14:50:12 +0100
Message-ID: <20231218135107.076766125@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Arinzon <darinzon@amazon.com>

[ Upstream commit d760117060cf2e90b5c59c5492cab179a4dbce01 ]

This patch fixes two issues:

Issue 1
-------
Description
```````````
Current code does not call dma_sync_single_for_cpu() to sync data from
the device side memory to the CPU side memory before the XDP code path
uses the CPU side data.
This causes the XDP code path to read the unset garbage data in the CPU
side memory, resulting in incorrect handling of the packet by XDP.

Solution
````````
1. Add a call to dma_sync_single_for_cpu() before the XDP code starts to
   use the data in the CPU side memory.
2. The XDP code verdict can be XDP_PASS, in which case there is a
   fallback to the non-XDP code, which also calls
   dma_sync_single_for_cpu().
   To avoid calling dma_sync_single_for_cpu() twice:
2.1. Put the dma_sync_single_for_cpu() in the code in such a place where
     it happens before XDP and non-XDP code.
2.2. Remove the calls to dma_sync_single_for_cpu() in the non-XDP code
     for the first buffer only (rx_copybreak and non-rx_copybreak
     cases), since the new call that was added covers these cases.
     The call to dma_sync_single_for_cpu() for the second buffer and on
     stays because only the first buffer is handled by the newly added
     dma_sync_single_for_cpu(). And there is no need for special
     handling of the second buffer and on for the XDP path since
     currently the driver supports only single buffer packets.

Issue 2
-------
Description
```````````
In case the XDP code forwarded the packet (ENA_XDP_FORWARDED),
ena_unmap_rx_buff_attrs() is called with attrs set to 0.
This means that before unmapping the buffer, the internal function
dma_unmap_page_attrs() will also call dma_sync_single_for_cpu() on
the whole buffer (not only on the data part of it).
This sync is both wasteful (since a sync was already explicitly
called before) and also causes a bug, which will be explained
using the below diagram.

The following diagram shows the flow of events causing the bug.
The order of events is (1)-(4) as shown in the diagram.

CPU side memory area

     (3)convert_to_xdp_frame() initializes the
        headroom with xdpf metadata
                      ||
                      \/
          ___________________________________
         |                                   |
 0       |                                   V                       4K
 ---------------------------------------------------------------------
 | xdpf->data      | other xdpf       |   < data >   | tailroom ||...|
 |                 | fields           |              | GARBAGE  ||   |
 ---------------------------------------------------------------------

                   /\                        /\
                   ||                        ||
   (4)ena_unmap_rx_buff_attrs() calls     (2)dma_sync_single_for_cpu()
      dma_sync_single_for_cpu() on the       copies data from device
      whole buffer page, overwriting         side to CPU side memory
      the xdpf->data with GARBAGE.           ||
 0                                                                   4K
 ---------------------------------------------------------------------
 | headroom                           |   < data >   | tailroom ||...|
 | GARBAGE                            |              | GARBAGE  ||   |
 ---------------------------------------------------------------------

Device side memory area                      /\
                                             ||
                               (1) device writes RX packet data

After the call to ena_unmap_rx_buff_attrs() in (4), the xdpf->data
becomes corrupted, and so when it is later accessed in
ena_clean_xdp_irq()->xdp_return_frame(), it causes a page fault,
crashing the kernel.

Solution
````````
Explicitly tell ena_unmap_rx_buff_attrs() not to call
dma_sync_single_for_cpu() by passing it the ENA_DMA_ATTR_SKIP_CPU_SYNC
flag.

Fixes: f7d625adeb7b ("net: ena: Add dynamic recycling mechanism for rx buffers")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>
Link: https://lore.kernel.org/r/20231211062801.27891-4-darinzon@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 23 ++++++++------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index b638e1d3d151a..14e41eb57731b 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1493,11 +1493,6 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		if (unlikely(!skb))
 			return NULL;
 
-		/* sync this buffer for CPU use */
-		dma_sync_single_for_cpu(rx_ring->dev,
-					dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
-					len,
-					DMA_FROM_DEVICE);
 		skb_copy_to_linear_data(skb, buf_addr + buf_offset, len);
 		dma_sync_single_for_device(rx_ring->dev,
 					   dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
@@ -1516,17 +1511,10 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 
 	buf_len = SKB_DATA_ALIGN(len + buf_offset + tailroom);
 
-	pre_reuse_paddr = dma_unmap_addr(&rx_info->ena_buf, paddr);
-
 	/* If XDP isn't loaded try to reuse part of the RX buffer */
 	reuse_rx_buf_page = !is_xdp_loaded &&
 			    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
 
-	dma_sync_single_for_cpu(rx_ring->dev,
-				pre_reuse_paddr + pkt_offset,
-				len,
-				DMA_FROM_DEVICE);
-
 	if (!reuse_rx_buf_page)
 		ena_unmap_rx_buff_attrs(rx_ring, rx_info, DMA_ATTR_SKIP_CPU_SYNC);
 
@@ -1723,6 +1711,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	int xdp_flags = 0;
 	int total_len = 0;
 	int xdp_verdict;
+	u8 pkt_offset;
 	int rc = 0;
 	int i;
 
@@ -1749,13 +1738,19 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 
 		/* First descriptor might have an offset set by the device */
 		rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
-		rx_info->buf_offset += ena_rx_ctx.pkt_offset;
+		pkt_offset = ena_rx_ctx.pkt_offset;
+		rx_info->buf_offset += pkt_offset;
 
 		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
 			  "rx_poll: q %d got packet from ena. descs #: %d l3 proto %d l4 proto %d hash: %x\n",
 			  rx_ring->qid, ena_rx_ctx.descs, ena_rx_ctx.l3_proto,
 			  ena_rx_ctx.l4_proto, ena_rx_ctx.hash);
 
+		dma_sync_single_for_cpu(rx_ring->dev,
+					dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
+					rx_ring->ena_bufs[0].len,
+					DMA_FROM_DEVICE);
+
 		if (ena_xdp_present_ring(rx_ring))
 			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp, ena_rx_ctx.descs);
 
@@ -1781,7 +1776,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 				if (xdp_verdict & ENA_XDP_FORWARDED) {
 					ena_unmap_rx_buff_attrs(rx_ring,
 								&rx_ring->rx_buffer_info[req_id],
-								0);
+								DMA_ATTR_SKIP_CPU_SYNC);
 					rx_ring->rx_buffer_info[req_id].page = NULL;
 				}
 			}
-- 
2.43.0




