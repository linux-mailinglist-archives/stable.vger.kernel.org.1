Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A852F7758C7
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjHIKzX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjHIKzK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21F211F
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE64063126
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD885C433C8;
        Wed,  9 Aug 2023 10:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578427;
        bh=v47xBzXjD+GHjZL4ICjkuLE4qxgPP/0Aqz0GJvuScHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRIDTqt+/HqJW7DJwH4R6hmkWtzUXe7aU56unNysXq0nJwPmO9MyfF+qi44OWfBgr
         tYYeqNv8WC5rkL5PHcn3Hh8aKV0eUwvTqiX8HFbJUpE3ASzFx/Vk3ObtDfJ28Gxpz9
         pObzmsuRG3ng6TqgGS9JcxTBcD+V3rzWvHAx8g14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 055/127] bnxt_en: Fix page pool logic for page size >= 64K
Date:   Wed,  9 Aug 2023 12:40:42 +0200
Message-ID: <20230809103638.506475405@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Somnath Kotur <somnath.kotur@broadcom.com>

[ Upstream commit f6974b4c2d8e1062b5a52228ee47293c15b4ee1e ]

The RXBD length field on all bnxt chips is 16-bit and so we cannot
support a full page when the native page size is 64K or greater.
The non-XDP (non page pool) code path has logic to handle this but
the XDP page pool code path does not handle this.  Add the missing
logic to use page_pool_dev_alloc_frag() to allocate 32K chunks if
the page size is 64K or greater.

Fixes: 9f4b28301ce6 ("bnxt: XDP multibuffer enablement")
Link: https://lore.kernel.org/netdev/20230728231829.235716-2-michael.chan@broadcom.com/
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Link: https://lore.kernel.org/r/20230731142043.58855-2-michael.chan@broadcom.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 42 ++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  6 +--
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6469fb8a42a89..9bd18c2b10bc6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -721,17 +721,24 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int nr_pkts)
 
 static struct page *__bnxt_alloc_rx_page(struct bnxt *bp, dma_addr_t *mapping,
 					 struct bnxt_rx_ring_info *rxr,
+					 unsigned int *offset,
 					 gfp_t gfp)
 {
 	struct device *dev = &bp->pdev->dev;
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rxr->page_pool);
+	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE) {
+		page = page_pool_dev_alloc_frag(rxr->page_pool, offset,
+						BNXT_RX_PAGE_SIZE);
+	} else {
+		page = page_pool_dev_alloc_pages(rxr->page_pool);
+		*offset = 0;
+	}
 	if (!page)
 		return NULL;
 
-	*mapping = dma_map_page_attrs(dev, page, 0, PAGE_SIZE, bp->rx_dir,
-				      DMA_ATTR_WEAK_ORDERING);
+	*mapping = dma_map_page_attrs(dev, page, *offset, BNXT_RX_PAGE_SIZE,
+				      bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
 	if (dma_mapping_error(dev, *mapping)) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
@@ -771,15 +778,16 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	dma_addr_t mapping;
 
 	if (BNXT_RX_PAGE_MODE(bp)) {
+		unsigned int offset;
 		struct page *page =
-			__bnxt_alloc_rx_page(bp, &mapping, rxr, gfp);
+			__bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
 
 		if (!page)
 			return -ENOMEM;
 
 		mapping += bp->rx_dma_offset;
 		rx_buf->data = page;
-		rx_buf->data_ptr = page_address(page) + bp->rx_offset;
+		rx_buf->data_ptr = page_address(page) + offset + bp->rx_offset;
 	} else {
 		u8 *data = __bnxt_alloc_rx_frag(bp, &mapping, gfp);
 
@@ -839,7 +847,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	unsigned int offset = 0;
 
 	if (BNXT_RX_PAGE_MODE(bp)) {
-		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, gfp);
+		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
 
 		if (!page)
 			return -ENOMEM;
@@ -986,15 +994,15 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
-			     DMA_ATTR_WEAK_ORDERING);
-	skb = build_skb(page_address(page), PAGE_SIZE);
+	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+			     bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
+	skb = build_skb(data_ptr - bp->rx_offset, BNXT_RX_PAGE_SIZE);
 	if (!skb) {
 		page_pool_recycle_direct(rxr->page_pool, page);
 		return NULL;
 	}
 	skb_mark_for_recycle(skb);
-	skb_reserve(skb, bp->rx_dma_offset);
+	skb_reserve(skb, bp->rx_offset);
 	__skb_put(skb, len);
 
 	return skb;
@@ -1020,8 +1028,8 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
-			     DMA_ATTR_WEAK_ORDERING);
+	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+			     bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
 
 	if (unlikely(!payload))
 		payload = eth_get_headlen(bp->dev, data_ptr, len);
@@ -1034,7 +1042,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1169,7 +1177,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 
 	skb->data_len += total_frag_len;
 	skb->len += total_frag_len;
-	skb->truesize += PAGE_SIZE * agg_bufs;
+	skb->truesize += BNXT_RX_PAGE_SIZE * agg_bufs;
 	return skb;
 }
 
@@ -2972,8 +2980,8 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
 		rx_buf->data = NULL;
 		if (BNXT_RX_PAGE_MODE(bp)) {
 			mapping -= bp->rx_dma_offset;
-			dma_unmap_page_attrs(&pdev->dev, mapping, PAGE_SIZE,
-					     bp->rx_dir,
+			dma_unmap_page_attrs(&pdev->dev, mapping,
+					     BNXT_RX_PAGE_SIZE, bp->rx_dir,
 					     DMA_ATTR_WEAK_ORDERING);
 			page_pool_recycle_direct(rxr->page_pool, data);
 		} else {
@@ -3241,6 +3249,8 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.nid = dev_to_node(&bp->pdev->dev);
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = DMA_BIDIRECTIONAL;
+	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
+		pp.flags |= PP_FLAG_PAGE_FRAG;
 
 	rxr->page_pool = page_pool_create(&pp);
 	if (IS_ERR(rxr->page_pool)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 36d5202c0aeec..aa56db138d6b5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -180,8 +180,8 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
+	u32 buflen = BNXT_RX_PAGE_SIZE;
 	struct bnxt_sw_rx_bd *rx_buf;
-	u32 buflen = PAGE_SIZE;
 	struct pci_dev *pdev;
 	dma_addr_t mapping;
 	u32 offset;
@@ -297,7 +297,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		rx_buf = &rxr->rx_buf_ring[cons];
 		mapping = rx_buf->mapping - bp->rx_dma_offset;
 		dma_unmap_page_attrs(&pdev->dev, mapping,
-				     PAGE_SIZE, bp->rx_dir,
+				     BNXT_RX_PAGE_SIZE, bp->rx_dir,
 				     DMA_ATTR_WEAK_ORDERING);
 
 		/* if we are unable to allocate a new buffer, abort and reuse */
@@ -478,7 +478,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
 	}
 	xdp_update_skb_shared_info(skb, num_frags,
 				   sinfo->xdp_frags_size,
-				   PAGE_SIZE * sinfo->nr_frags,
+				   BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
 				   xdp_buff_is_frag_pfmemalloc(xdp));
 	return skb;
 }
-- 
2.40.1



