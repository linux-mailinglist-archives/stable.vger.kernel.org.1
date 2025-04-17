Return-Path: <stable+bounces-134470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26020A92B5B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BB43B25B4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96510257AD3;
	Thu, 17 Apr 2025 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S226L13o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510822571DB;
	Thu, 17 Apr 2025 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916222; cv=none; b=i+WxIDFBwgan4/PmYrVcZwWSnjKqjRSmUOvSD928e08+w5MOG7w7deAGktQqokw7RVJjjz685kHOIPIf0t1QtMGhVE71gppECAby1AyGcnWAaWOki+4MsHbx7m9T+YP83I7rcUI6H8dUojTZfZewr0LKv2XNvdLx2/fqMdsCmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916222; c=relaxed/simple;
	bh=lSnLDAMtZQDNIPXb2XPK+p18qN4lmuF2cSNwLsNVOgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRpRq1LdB7KjsKk2ZQjQqF+miR5e7rGlB4L3fV249gOwAFLXJUxLKcxkMhmKL6A3EnQ+pkAyzPKUIuSzFTBW+JM1xG0sdpdRTEulfoWgULO9/El3H6NgbKpnVNwPM37s7XMGhmfzGQoOpHsDQQrPLkDcCRUpT9LpqcM3LsoAt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S226L13o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994EEC4CEE7;
	Thu, 17 Apr 2025 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744916222;
	bh=lSnLDAMtZQDNIPXb2XPK+p18qN4lmuF2cSNwLsNVOgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S226L13oIhTxWUME6+qFLZzF6Ksgd4CbdfgZz1l4eDJp/fOgUvrqrE/ylxMSBZfOx
	 dOmWTVeZhrKbB5tVAtgmPfnojnoT3e3n1O7i/6Z3a4v3pObw1Ij1y2NmOZMHWWZHQ8
	 DteeZrxvVHozLFf+OwRukVYvqLSH0/x3VrF2/vwg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 355/393] net: mana: Switch to page pool for jumbo frames
Date: Thu, 17 Apr 2025 19:52:44 +0200
Message-ID: <20250417175121.877588734@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haiyang Zhang <haiyangz@microsoft.com>

commit fa37a8849634db2dd3545116873da8cf4b1e67c6 upstream.

Frag allocators, such as netdev_alloc_frag(), were not designed to
work for fragsz > PAGE_SIZE.

So, switch to page pool for jumbo frames instead of using page frag
allocators. This driver is using page pool for smaller MTUs already.

Cc: stable@vger.kernel.org
Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Long Li <longli@microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Link: https://patch.msgid.link/1742920357-27263-1-git-send-email-haiyangz@microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c |   46 +++++---------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -636,30 +636,16 @@ int mana_pre_alloc_rxbufs(struct mana_po
 	mpc->rxbpre_total = 0;
 
 	for (i = 0; i < num_rxb; i++) {
-		if (mpc->rxbpre_alloc_size > PAGE_SIZE) {
-			va = netdev_alloc_frag(mpc->rxbpre_alloc_size);
-			if (!va)
-				goto error;
-
-			page = virt_to_head_page(va);
-			/* Check if the frag falls back to single page */
-			if (compound_order(page) <
-			    get_order(mpc->rxbpre_alloc_size)) {
-				put_page(page);
-				goto error;
-			}
-		} else {
-			page = dev_alloc_page();
-			if (!page)
-				goto error;
+		page = dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
+		if (!page)
+			goto error;
 
-			va = page_to_virt(page);
-		}
+		va = page_to_virt(page);
 
 		da = dma_map_single(dev, va + mpc->rxbpre_headroom,
 				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
 		if (dma_mapping_error(dev, da)) {
-			put_page(virt_to_head_page(va));
+			put_page(page);
 			goto error;
 		}
 
@@ -1618,7 +1604,7 @@ drop:
 }
 
 static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
-			     dma_addr_t *da, bool *from_pool, bool is_napi)
+			     dma_addr_t *da, bool *from_pool)
 {
 	struct page *page;
 	void *va;
@@ -1629,21 +1615,6 @@ static void *mana_get_rxfrag(struct mana
 	if (rxq->xdp_save_va) {
 		va = rxq->xdp_save_va;
 		rxq->xdp_save_va = NULL;
-	} else if (rxq->alloc_size > PAGE_SIZE) {
-		if (is_napi)
-			va = napi_alloc_frag(rxq->alloc_size);
-		else
-			va = netdev_alloc_frag(rxq->alloc_size);
-
-		if (!va)
-			return NULL;
-
-		page = virt_to_head_page(va);
-		/* Check if the frag falls back to single page */
-		if (compound_order(page) < get_order(rxq->alloc_size)) {
-			put_page(page);
-			return NULL;
-		}
 	} else {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
 		if (!page)
@@ -1676,7 +1647,7 @@ static void mana_refill_rx_oob(struct de
 	dma_addr_t da;
 	void *va;
 
-	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, true);
+	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 	if (!va)
 		return;
 
@@ -2083,7 +2054,7 @@ static int mana_fill_rx_oob(struct mana_
 	if (mpc->rxbufs_pre)
 		va = mana_get_rxbuf_pre(rxq, &da);
 	else
-		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, false);
+		va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
 
 	if (!va)
 		return -ENOMEM;
@@ -2169,6 +2140,7 @@ static int mana_create_page_pool(struct
 	pprm.nid = gc->numa_node;
 	pprm.napi = &rxq->rx_cq.napi;
 	pprm.netdev = rxq->ndev;
+	pprm.order = get_order(rxq->alloc_size);
 
 	rxq->page_pool = page_pool_create(&pprm);
 



