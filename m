Return-Path: <stable+bounces-180050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92014B7E80A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087793AB802
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D173090EC;
	Wed, 17 Sep 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="URfdybP1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF92F5A2E;
	Wed, 17 Sep 2025 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113221; cv=none; b=AWRO61T6MLPJGYGMHBwhFl4WLGrzJzclMT5puAg6TelW+A8TO8O2/VMLWSV7/wITGydKSEO3Gz+R0DgVsHkkwjtAwMtRdfiJ+2zhozzu8059aqZLPU7zlGnegmzvhOOjDyZH+6O8FUKDpee/Byv7Hwsavxm6PAYusP1Fs2I5xjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113221; c=relaxed/simple;
	bh=JPi7hEJ+Ir3BiDMQW5wJHEye8C30NwhNoLln+AndGYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fTH5xC2QzXQ84/JQyqLa4ERv0Lu1Hg9p/edHc6vaFNbbu/ufCfZXsraUvceWdPd4ODfBKnwS/2pudejdcX8vG/bsRwE2RXW4CYHhmxi1W0QQCjTNrejEUMo1cu4XCZ5CCIj74oSzvS8iGfsmS5Yn1FiMKttSUM0HAhpYznjTTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=URfdybP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8A1C4CEF0;
	Wed, 17 Sep 2025 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113221;
	bh=JPi7hEJ+Ir3BiDMQW5wJHEye8C30NwhNoLln+AndGYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URfdybP1vuT/+yI2v4c3+JR++uBfHriKmypnzAhrFvGZ0qO7H2H6iO9WwE/P9SmvR
	 dzmDQzYI15GeJX3cf8mMo7Of2PVPuXkcDevnbfVsryeXNj+Pg4k0GUK9KzwthldzSG
	 oD+7x/7bY+M6AxDfb1aFsG5tZXW0Pnz1iZLPVcOA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 002/140] dma-debug: store a phys_addr_t in struct dma_debug_entry
Date: Wed, 17 Sep 2025 14:32:54 +0200
Message-ID: <20250917123344.379486984@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 9d4f645a1fd49eea70a21e8671d358ebe1c08d02 ]

dma-debug goes to great length to split incoming physical addresses into
a PFN and offset to store them in struct dma_debug_entry, just to
recombine those for all meaningful uses.  Just store a phys_addr_t
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Stable-dep-of: 7e2368a21741 ("dma-debug: don't enforce dma mapping check on noncoherent allocations")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/debug.c | 79 ++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index f6f0387761d05..4e3692afdf0d2 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -59,8 +59,7 @@ enum map_err_types {
  * @direction: enum dma_data_direction
  * @sg_call_ents: 'nents' from dma_map_sg
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
- * @pfn: page frame of the start address
- * @offset: offset of mapping relative to pfn
+ * @paddr: physical start address of the mapping
  * @map_err_type: track whether dma_mapping_error() was checked
  * @stack_len: number of backtrace entries in @stack_entries
  * @stack_entries: stack of backtrace history
@@ -74,8 +73,7 @@ struct dma_debug_entry {
 	int              direction;
 	int		 sg_call_ents;
 	int		 sg_mapped_ents;
-	unsigned long	 pfn;
-	size_t		 offset;
+	phys_addr_t	 paddr;
 	enum map_err_types  map_err_type;
 #ifdef CONFIG_STACKTRACE
 	unsigned int	stack_len;
@@ -389,14 +387,6 @@ static void hash_bucket_del(struct dma_debug_entry *entry)
 	list_del(&entry->list);
 }
 
-static unsigned long long phys_addr(struct dma_debug_entry *entry)
-{
-	if (entry->type == dma_debug_resource)
-		return __pfn_to_phys(entry->pfn) + entry->offset;
-
-	return page_to_phys(pfn_to_page(entry->pfn)) + entry->offset;
-}
-
 /*
  * For each mapping (initial cacheline in the case of
  * dma_alloc_coherent/dma_map_page, initial cacheline in each page of a
@@ -428,8 +418,8 @@ static DEFINE_SPINLOCK(radix_lock);
 
 static phys_addr_t to_cacheline_number(struct dma_debug_entry *entry)
 {
-	return (entry->pfn << CACHELINE_PER_PAGE_SHIFT) +
-		(entry->offset >> L1_CACHE_SHIFT);
+	return ((entry->paddr >> PAGE_SHIFT) << CACHELINE_PER_PAGE_SHIFT) +
+		(offset_in_page(entry->paddr) >> L1_CACHE_SHIFT);
 }
 
 static int active_cacheline_read_overlap(phys_addr_t cln)
@@ -538,11 +528,11 @@ void debug_dma_dump_mappings(struct device *dev)
 			if (!dev || dev == entry->dev) {
 				cln = to_cacheline_number(entry);
 				dev_info(entry->dev,
-					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
+					 "%s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
 					 type2name[entry->type], idx,
-					 phys_addr(entry), entry->pfn,
-					 entry->dev_addr, entry->size,
-					 &cln, dir2name[entry->direction],
+					 &entry->paddr, entry->dev_addr,
+					 entry->size, &cln,
+					 dir2name[entry->direction],
 					 maperr2str[entry->map_err_type]);
 			}
 		}
@@ -569,13 +559,13 @@ static int dump_show(struct seq_file *seq, void *v)
 		list_for_each_entry(entry, &bucket->list, list) {
 			cln = to_cacheline_number(entry);
 			seq_printf(seq,
-				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
+				   "%s %s %s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
 				   dev_driver_string(entry->dev),
 				   dev_name(entry->dev),
 				   type2name[entry->type], idx,
-				   phys_addr(entry), entry->pfn,
-				   entry->dev_addr, entry->size,
-				   &cln, dir2name[entry->direction],
+				   &entry->paddr, entry->dev_addr,
+				   entry->size, &cln,
+				   dir2name[entry->direction],
 				   maperr2str[entry->map_err_type]);
 		}
 		spin_unlock_irqrestore(&bucket->lock, flags);
@@ -1003,16 +993,16 @@ static void check_unmap(struct dma_debug_entry *ref)
 			   "[mapped as %s] [unmapped as %s]\n",
 			   ref->dev_addr, ref->size,
 			   type2name[entry->type], type2name[ref->type]);
-	} else if ((entry->type == dma_debug_coherent) &&
-		   (phys_addr(ref) != phys_addr(entry))) {
+	} else if (entry->type == dma_debug_coherent &&
+		   ref->paddr != entry->paddr) {
 		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different CPU address "
 			   "[device address=0x%016llx] [size=%llu bytes] "
-			   "[cpu alloc address=0x%016llx] "
-			   "[cpu free address=0x%016llx]",
+			   "[cpu alloc address=0x%pa] "
+			   "[cpu free address=0x%pa]",
 			   ref->dev_addr, ref->size,
-			   phys_addr(entry),
-			   phys_addr(ref));
+			   &entry->paddr,
+			   &ref->paddr);
 	}
 
 	if (ref->sg_call_ents && ref->type == dma_debug_sg &&
@@ -1231,8 +1221,7 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 
 	entry->dev       = dev;
 	entry->type      = dma_debug_single;
-	entry->pfn	 = page_to_pfn(page);
-	entry->offset	 = offset;
+	entry->paddr	 = page_to_phys(page);
 	entry->dev_addr  = dma_addr;
 	entry->size      = size;
 	entry->direction = direction;
@@ -1327,8 +1316,7 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 
 		entry->type           = dma_debug_sg;
 		entry->dev            = dev;
-		entry->pfn	      = page_to_pfn(sg_page(s));
-		entry->offset	      = s->offset;
+		entry->paddr	      = sg_phys(s);
 		entry->size           = sg_dma_len(s);
 		entry->dev_addr       = sg_dma_address(s);
 		entry->direction      = direction;
@@ -1374,8 +1362,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(s),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = dir,
@@ -1414,16 +1401,12 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 
 	entry->type      = dma_debug_coherent;
 	entry->dev       = dev;
-	entry->offset	 = offset_in_page(virt);
+	entry->paddr	 = page_to_phys((is_vmalloc_addr(virt) ?
+				vmalloc_to_page(virt) : virt_to_page(virt)));
 	entry->size      = size;
 	entry->dev_addr  = dma_addr;
 	entry->direction = DMA_BIDIRECTIONAL;
 
-	if (is_vmalloc_addr(virt))
-		entry->pfn = vmalloc_to_pfn(virt);
-	else
-		entry->pfn = page_to_pfn(virt_to_page(virt));
-
 	add_dma_entry(entry, attrs);
 }
 
@@ -1433,7 +1416,6 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	struct dma_debug_entry ref = {
 		.type           = dma_debug_coherent,
 		.dev            = dev,
-		.offset		= offset_in_page(virt),
 		.dev_addr       = dma_addr,
 		.size           = size,
 		.direction      = DMA_BIDIRECTIONAL,
@@ -1443,10 +1425,8 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
 		return;
 
-	if (is_vmalloc_addr(virt))
-		ref.pfn = vmalloc_to_pfn(virt);
-	else
-		ref.pfn = page_to_pfn(virt_to_page(virt));
+	ref.paddr = page_to_phys((is_vmalloc_addr(virt) ?
+			vmalloc_to_page(virt) : virt_to_page(virt)));
 
 	if (unlikely(dma_debug_disabled()))
 		return;
@@ -1469,8 +1449,7 @@ void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
 
 	entry->type		= dma_debug_resource;
 	entry->dev		= dev;
-	entry->pfn		= PHYS_PFN(addr);
-	entry->offset		= offset_in_page(addr);
+	entry->paddr		= addr;
 	entry->size		= size;
 	entry->dev_addr		= dma_addr;
 	entry->direction	= direction;
@@ -1547,8 +1526,7 @@ void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(s),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = direction,
@@ -1579,8 +1557,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(sg),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = direction,
-- 
2.51.0




