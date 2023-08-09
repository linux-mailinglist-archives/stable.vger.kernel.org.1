Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E21775787
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjHIKrG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjHIKrF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:47:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE35D1999
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77E9E630EF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882A0C433C8;
        Wed,  9 Aug 2023 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578023;
        bh=0BbgaH9kEN4WENtJF+iWfHJd1rrrXHadjvcTaXh9tsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npDB3EiIIVT3ZSDP7wCRFJJJkVAUm4qqOnSwPrT/danr/WFx11uFvOFARu6yCgUJh
         1AteCtI/IBVOVcDSKcxoIP7XWxLV5PiIKFlVbTfLJR0Fejat5Lr8kQxyEqdQRQFmY0
         uxv+J9FRgEQsMiTJ6qvzX21WqoBmIwvYttxbyqKM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 079/165] bnxt_en: Fix page pool logic for page size >= 64K
Date:   Wed,  9 Aug 2023 12:40:10 +0200
Message-ID: <20230809103645.388232546@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
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
index 0b314bf4fbe65..81ed3744fa330 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -699,17 +699,24 @@ static void bnxt_tx_int(struct bnxt *bp, struct bnxt_napi *bnapi, int budget)
 
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
@@ -749,15 +756,16 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
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
 
@@ -817,7 +825,7 @@ static inline int bnxt_alloc_rx_page(struct bnxt *bp,
 	unsigned int offset = 0;
 
 	if (BNXT_RX_PAGE_MODE(bp)) {
-		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, gfp);
+		page = __bnxt_alloc_rx_page(bp, &mapping, rxr, &offset, gfp);
 
 		if (!page)
 			return -ENOMEM;
@@ -964,15 +972,15 @@ static struct sk_buff *bnxt_rx_multi_page_skb(struct bnxt *bp,
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
@@ -998,8 +1006,8 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 		return NULL;
 	}
 	dma_addr -= bp->rx_dma_offset;
-	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, PAGE_SIZE, bp->rx_dir,
-			     DMA_ATTR_WEAK_ORDERING);
+	dma_unmap_page_attrs(&bp->pdev->dev, dma_addr, BNXT_RX_PAGE_SIZE,
+			     bp->rx_dir, DMA_ATTR_WEAK_ORDERING);
 
 	if (unlikely(!payload))
 		payload = eth_get_headlen(bp->dev, data_ptr, len);
@@ -1012,7 +1020,7 @@ static struct sk_buff *bnxt_rx_page_skb(struct bnxt *bp,
 
 	skb_mark_for_recycle(skb);
 	off = (void *)data_ptr - page_address(page);
-	skb_add_rx_frag(skb, 0, page, off, len, PAGE_SIZE);
+	skb_add_rx_frag(skb, 0, page, off, len, BNXT_RX_PAGE_SIZE);
 	memcpy(skb->data - NET_IP_ALIGN, data_ptr - NET_IP_ALIGN,
 	       payload + NET_IP_ALIGN);
 
@@ -1147,7 +1155,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 
 	skb->data_len += total_frag_len;
 	skb->len += total_frag_len;
-	skb->truesize += PAGE_SIZE * agg_bufs;
+	skb->truesize += BNXT_RX_PAGE_SIZE * agg_bufs;
 	return skb;
 }
 
@@ -2949,8 +2957,8 @@ static void bnxt_free_one_rx_ring_skbs(struct bnxt *bp, int ring_nr)
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
@@ -3219,6 +3227,8 @@ static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 	pp.napi = &rxr->bnapi->napi;
 	pp.dev = &bp->pdev->dev;
 	pp.dma_dir = DMA_BIDIRECTIONAL;
+	if (PAGE_SIZE > BNXT_RX_PAGE_SIZE)
+		pp.flags |= PP_FLAG_PAGE_FRAG;
 
 	rxr->page_pool = page_pool_create(&pp);
 	if (IS_ERR(rxr->page_pool)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 7f2f9a317d473..fb43232310b2d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -186,8 +186,8 @@ void bnxt_xdp_buff_init(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			u16 cons, u8 *data_ptr, unsigned int len,
 			struct xdp_buff *xdp)
 {
+	u32 buflen = BNXT_RX_PAGE_SIZE;
 	struct bnxt_sw_rx_bd *rx_buf;
-	u32 buflen = PAGE_SIZE;
 	struct pci_dev *pdev;
 	dma_addr_t mapping;
 	u32 offset;
@@ -303,7 +303,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 		rx_buf = &rxr->rx_buf_ring[cons];
 		mapping = rx_buf->mapping - bp->rx_dma_offset;
 		dma_unmap_page_attrs(&pdev->dev, mapping,
-				     PAGE_SIZE, bp->rx_dir,
+				     BNXT_RX_PAGE_SIZE, bp->rx_dir,
 				     DMA_ATTR_WEAK_ORDERING);
 
 		/* if we are unable to allocate a new buffer, abort and reuse */
@@ -486,7 +486,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *skb, u8 num_frags,
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



