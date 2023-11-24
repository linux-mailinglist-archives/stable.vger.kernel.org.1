Return-Path: <stable+bounces-939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AE17F7D3A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B24282121
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5639FE7;
	Fri, 24 Nov 2023 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qQ/3fwm0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6D381D6;
	Fri, 24 Nov 2023 18:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA1EC433C8;
	Fri, 24 Nov 2023 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850157;
	bh=MOM+XhsyLC/EYGMjvJNiB9azfIdgGNaD+KJ/v7MvarI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQ/3fwm0dg0Z+IN2moC1ubpEpFFLjMvO/l/xtRfFiTaODwhS16Z/NEPg0TJaoSla9
	 gegXoXRVM0HnpyLhLP98hwxfXluL77V6y+CMQKB0VcCu+lwMJowtcO/3T+nODaZ5yG
	 EP/k4Ka8lRQZBEcWZywpo3VyPCLTuW95Vx5UwFQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6.6 468/530] swiotlb: do not free decrypted pages if dynamic
Date: Fri, 24 Nov 2023 17:50:34 +0000
Message-ID: <20231124172042.317504085@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Petr Tesarik <petrtesarik@huaweicloud.com>

commit a5e3b127455d073f146a2a4ea3e7117635d34c5c upstream.

Fix these two error paths:

1. When set_memory_decrypted() fails, pages may be left fully or partially
   decrypted.

2. Decrypted pages may be freed if swiotlb_alloc_tlb() determines that the
   physical address is too high.

To fix the first issue, call set_memory_encrypted() on the allocated region
after a failed decryption attempt. If that also fails, leak the pages.

To fix the second issue, check that the TLB physical address is below the
requested limit before decrypting.

Let the caller differentiate between unsuitable physical address (=> retry
from a lower zone) and allocation failures (=> no point in retrying).

Cc: stable@vger.kernel.org
Fixes: 79636caad361 ("swiotlb: if swiotlb is full, fall back to a transient memory pool")
Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/dma/swiotlb.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 26202274784f..71392c9fac10 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -558,29 +558,40 @@ void __init swiotlb_exit(void)
  * alloc_dma_pages() - allocate pages to be used for DMA
  * @gfp:	GFP flags for the allocation.
  * @bytes:	Size of the buffer.
+ * @phys_limit:	Maximum allowed physical address of the buffer.
  *
  * Allocate pages from the buddy allocator. If successful, make the allocated
  * pages decrypted that they can be used for DMA.
  *
- * Return: Decrypted pages, or %NULL on failure.
+ * Return: Decrypted pages, %NULL on allocation failure, or ERR_PTR(-EAGAIN)
+ * if the allocated physical address was above @phys_limit.
  */
-static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes)
+static struct page *alloc_dma_pages(gfp_t gfp, size_t bytes, u64 phys_limit)
 {
 	unsigned int order = get_order(bytes);
 	struct page *page;
+	phys_addr_t paddr;
 	void *vaddr;
 
 	page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
 
-	vaddr = page_address(page);
+	paddr = page_to_phys(page);
+	if (paddr + bytes - 1 > phys_limit) {
+		__free_pages(page, order);
+		return ERR_PTR(-EAGAIN);
+	}
+
+	vaddr = phys_to_virt(paddr);
 	if (set_memory_decrypted((unsigned long)vaddr, PFN_UP(bytes)))
 		goto error;
 	return page;
 
 error:
-	__free_pages(page, order);
+	/* Intentional leak if pages cannot be encrypted again. */
+	if (!set_memory_encrypted((unsigned long)vaddr, PFN_UP(bytes)))
+		__free_pages(page, order);
 	return NULL;
 }
 
@@ -618,11 +629,7 @@ static struct page *swiotlb_alloc_tlb(struct device *dev, size_t bytes,
 	else if (phys_limit <= DMA_BIT_MASK(32))
 		gfp |= __GFP_DMA32;
 
-	while ((page = alloc_dma_pages(gfp, bytes)) &&
-	       page_to_phys(page) + bytes - 1 > phys_limit) {
-		/* allocated, but too high */
-		__free_pages(page, get_order(bytes));
-
+	while (IS_ERR(page = alloc_dma_pages(gfp, bytes, phys_limit))) {
 		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
 		    phys_limit < DMA_BIT_MASK(64) &&
 		    !(gfp & (__GFP_DMA32 | __GFP_DMA)))
-- 
2.43.0




