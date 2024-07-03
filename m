Return-Path: <stable+bounces-57605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD06925D31
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B7D1F21C04
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFBB18FDCC;
	Wed,  3 Jul 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="03NiEOVT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778BA17C9F2;
	Wed,  3 Jul 2024 11:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005385; cv=none; b=Is4wXsuALty8GeoUon31F1pls5Gam/Sblr+iBIk7secU1p84Kma2Jlnjg+oIzAiaH3sbF8jAdhlz/EqnKoK0R9eg+8LqOSjkY2cuAz9jnfOaIIH5ZiCg5ZCca6uytK5Z9TVOwQBK+4qbwSkKy3N+oqa5Dn4GZzwXH1GQt0HaNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005385; c=relaxed/simple;
	bh=lBGAqXnOx8Z9ggVnYAzX4PKk6rrtluSmxfzUn8u79Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxKQRNLvex8o0cN73zMFjNIgnESaqQF1idH5nK0VdhIZaxP/2k4VrCn8OZMYAKRvXtQ3QoIC5bD2b//67nE+dk7PtHQKtSTDg9QW56DcBcDxeMIc+TEhW5Kp4FX7Gs0CvQXaI1z9WqUYy/VRi/sODKTFH3g7VxkZa2JRb68EMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=03NiEOVT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70C0C2BD10;
	Wed,  3 Jul 2024 11:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005385;
	bh=lBGAqXnOx8Z9ggVnYAzX4PKk6rrtluSmxfzUn8u79Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=03NiEOVTewCQUWAEAFmP5O0m5AAhZvG+5Kwo8+TkNMc6PVyDg7Ju/DWZKwxD6zr+5
	 7tQp1uB7dgao5qJEMRNj7GxtCCyc7lmYem7nPrGahnAIyRG/5sLyqe4VtNNzYmD+Rs
	 SWfEPWHr5UebQf3oVp5pq5M3lskWdi6w/03pkV7k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Minchan Kim <minchan@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	John Garry via iommu <iommu@lists.linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 063/356] cma: factor out minimum alignment requirement
Date: Wed,  3 Jul 2024 12:36:39 +0200
Message-ID: <20240703102915.484016457@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

From: David Hildenbrand <david@redhat.com>

[ Upstream commit e16faf26780fc0c8dd693ea9ee8420a7706cb2f5 ]

Patch series "mm: enforce pageblock_order < MAX_ORDER".

Having pageblock_order >= MAX_ORDER seems to be able to happen in corner
cases and some parts of the kernel are not prepared for it.

For example, Aneesh has shown [1] that such kernels can be compiled on
ppc64 with 64k base pages by setting FORCE_MAX_ZONEORDER=8, which will
run into a WARN_ON_ONCE(order >= MAX_ORDER) in comapction code right
during boot.

We can get pageblock_order >= MAX_ORDER when the default hugetlb size is
bigger than the maximum allocation granularity of the buddy, in which
case we are no longer talking about huge pages but instead gigantic
pages.

Having pageblock_order >= MAX_ORDER can only make alloc_contig_range()
of such gigantic pages more likely to succeed.

Reliable use of gigantic pages either requires boot time allcoation or
CMA, no need to overcomplicate some places in the kernel to optimize for
corner cases that are broken in other areas of the kernel.

This patch (of 2):

Let's enforce pageblock_order < MAX_ORDER and simplify.

Especially patch #1 can be regarded a cleanup before:
	[PATCH v5 0/6] Use pageblock_order for cma and alloc_contig_range
	alignment. [2]

[1] https://lkml.kernel.org/r/87r189a2ks.fsf@linux.ibm.com
[2] https://lkml.kernel.org/r/20220211164135.1803616-1-zi.yan@sent.com

Link: https://lkml.kernel.org/r/20220214174132.219303-2-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: John Garry via iommu <iommu@lists.linux-foundation.org>

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: b174f139bdc8 ("mm/cma: drop incorrect alignment check in cma_init_reserved_mem")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/fadump-internal.h |  5 -----
 arch/powerpc/kernel/fadump.c               |  2 +-
 drivers/of/of_reserved_mem.c               |  9 +++------
 include/linux/cma.h                        |  9 +++++++++
 kernel/dma/contiguous.c                    |  4 +---
 mm/cma.c                                   | 20 +++++---------------
 6 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/fadump-internal.h b/arch/powerpc/include/asm/fadump-internal.h
index 8d61c8f3fec47..d06b2be645326 100644
--- a/arch/powerpc/include/asm/fadump-internal.h
+++ b/arch/powerpc/include/asm/fadump-internal.h
@@ -19,11 +19,6 @@
 
 #define memblock_num_regions(memblock_type)	(memblock.memblock_type.cnt)
 
-/* Alignment per CMA requirement. */
-#define FADUMP_CMA_ALIGNMENT	(PAGE_SIZE <<				\
-				 max_t(unsigned long, MAX_ORDER - 1,	\
-				 pageblock_order))
-
 /* FAD commands */
 #define FADUMP_REGISTER			1
 #define FADUMP_UNREGISTER		2
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index d496dc5151aa1..35b142ad0e40e 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -544,7 +544,7 @@ int __init fadump_reserve_mem(void)
 		if (!fw_dump.nocma) {
 			fw_dump.boot_memory_size =
 				ALIGN(fw_dump.boot_memory_size,
-				      FADUMP_CMA_ALIGNMENT);
+				      CMA_MIN_ALIGNMENT_BYTES);
 		}
 #endif
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9e949ddcb1464..6ec668ae2d6fa 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/cma.h>
 
 #include "of_private.h"
 
@@ -117,12 +118,8 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 	if (IS_ENABLED(CONFIG_CMA)
 	    && of_flat_dt_is_compatible(node, "shared-dma-pool")
 	    && of_get_flat_dt_prop(node, "reusable", NULL)
-	    && !nomap) {
-		unsigned long order =
-			max_t(unsigned long, MAX_ORDER - 1, pageblock_order);
-
-		align = max(align, (phys_addr_t)PAGE_SIZE << order);
-	}
+	    && !nomap)
+		align = max_t(phys_addr_t, align, CMA_MIN_ALIGNMENT_BYTES);
 
 	prop = of_get_flat_dt_prop(node, "alloc-ranges", &len);
 	if (prop) {
diff --git a/include/linux/cma.h b/include/linux/cma.h
index 53fd8c3cdbd04..1b302e204c09b 100644
--- a/include/linux/cma.h
+++ b/include/linux/cma.h
@@ -20,6 +20,15 @@
 
 #define CMA_MAX_NAME 64
 
+/*
+ * TODO: once the buddy -- especially pageblock merging and alloc_contig_range()
+ * -- can deal with only some pageblocks of a higher-order page being
+ *  MIGRATE_CMA, we can use pageblock_nr_pages.
+ */
+#define CMA_MIN_ALIGNMENT_PAGES max_t(phys_addr_t, MAX_ORDER_NR_PAGES, \
+				      pageblock_nr_pages)
+#define CMA_MIN_ALIGNMENT_BYTES (PAGE_SIZE * CMA_MIN_ALIGNMENT_PAGES)
+
 struct cma;
 
 extern unsigned long totalcma_pages;
diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 3d63d91cba5cf..6ea80ae426228 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -399,8 +399,6 @@ static const struct reserved_mem_ops rmem_cma_ops = {
 
 static int __init rmem_cma_setup(struct reserved_mem *rmem)
 {
-	phys_addr_t align = PAGE_SIZE << max(MAX_ORDER - 1, pageblock_order);
-	phys_addr_t mask = align - 1;
 	unsigned long node = rmem->fdt_node;
 	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
 	struct cma *cma;
@@ -416,7 +414,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
 	    of_get_flat_dt_prop(node, "no-map", NULL))
 		return -EINVAL;
 
-	if ((rmem->base & mask) || (rmem->size & mask)) {
+	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
 		pr_err("Reserved memory: incorrect alignment of CMA region\n");
 		return -EINVAL;
 	}
diff --git a/mm/cma.c b/mm/cma.c
index 26967c70e9c73..5208aee4f45ad 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -169,7 +169,6 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 				 struct cma **res_cma)
 {
 	struct cma *cma;
-	phys_addr_t alignment;
 
 	/* Sanity checks */
 	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
@@ -180,15 +179,12 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	if (!size || !memblock_is_region_reserved(base, size))
 		return -EINVAL;
 
-	/* ensure minimal alignment required by mm core */
-	alignment = PAGE_SIZE <<
-			max_t(unsigned long, MAX_ORDER - 1, pageblock_order);
-
 	/* alignment should be aligned with order_per_bit */
-	if (!IS_ALIGNED(alignment >> PAGE_SHIFT, 1 << order_per_bit))
+	if (!IS_ALIGNED(CMA_MIN_ALIGNMENT_PAGES, 1 << order_per_bit))
 		return -EINVAL;
 
-	if (ALIGN(base, alignment) != base || ALIGN(size, alignment) != size)
+	/* ensure minimal alignment required by mm core */
+	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
 		return -EINVAL;
 
 	/*
@@ -263,14 +259,8 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
 	if (alignment && !is_power_of_2(alignment))
 		return -EINVAL;
 
-	/*
-	 * Sanitise input arguments.
-	 * Pages both ends in CMA area could be merged into adjacent unmovable
-	 * migratetype page by page allocator's buddy algorithm. In the case,
-	 * you couldn't get a contiguous memory, which is not what we want.
-	 */
-	alignment = max(alignment,  (phys_addr_t)PAGE_SIZE <<
-			  max_t(unsigned long, MAX_ORDER - 1, pageblock_order));
+	/* Sanitise input arguments. */
+	alignment = max_t(phys_addr_t, alignment, CMA_MIN_ALIGNMENT_BYTES);
 	if (fixed && base & (alignment - 1)) {
 		ret = -EINVAL;
 		pr_err("Region at %pa must be aligned to %pa bytes\n",
-- 
2.43.0




