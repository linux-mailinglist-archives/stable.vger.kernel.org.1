Return-Path: <stable+bounces-75400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CF097345A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191F71C24EFE
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAF190692;
	Tue, 10 Sep 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hTM213ok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946B75381A;
	Tue, 10 Sep 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964621; cv=none; b=NUFeM/VCFPV/sttVacxTyWGEDEM+OSeO2zh+nGuoL6pGG9lVEqHxQbgOk3gD90k9TPLgILxt8ZJzjyNKJ4yvGRSrAV+uIcXrcVuez8MUP8abIbdkABmFa15WFOlOYvRK94j0hkYLBlWdeo++KhjzKbEERKgg5c+mVqu/GJq9+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964621; c=relaxed/simple;
	bh=9E4JN7zdb2gkRjpecCIMWmT3wdyL3CPmFNuqUgR4Mhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg99y1OuA+6KwKEFM45l+Eh3LHHYNjFstjk/ZPLsPD3RBEkzhDsUjzwKOC+Oa3j1Y7/BHdENqN2XBvZcbi9jdDQXtlcvufuxCu1m68jxXP7obPW/XQtV4W53R21jX2pE7UaUbACBHsLAHadmf2YIG/OKIeSy7lnnkr6ARM52vIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hTM213ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C469EC4CEC3;
	Tue, 10 Sep 2024 10:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964621;
	bh=9E4JN7zdb2gkRjpecCIMWmT3wdyL3CPmFNuqUgR4Mhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTM213okq4V4me6iyQVtFbR7Jz/1pCJQ0xeHdXcR0m2G6rVNtKtDiezoX2IypdLxO
	 zh90iL/onyDBBIgkDZ3au/OvybMksQYL64EbsPQa5u9h73n5BfKs26h4IhGER3Z2XE
	 NbwBgQOLXxZQoVP3pWhVtgm0k+Kdb16IUbE0QAXs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 245/269] powerpc/64e: split out nohash Book3E 64-bit code
Date: Tue, 10 Sep 2024 11:33:52 +0200
Message-ID: <20240910092616.576456288@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit a898530eea3d0ba08c17a60865995a3bb468d1bc ]

A reasonable chunk of nohash/tlb.c is 64-bit only code, split it out into
a separate file.

Link: https://lkml.kernel.org/r/cb2b118f9d8a86f82d01bfb9ad309d1d304480a1.1719928057.git.christophe.leroy@csgroup.eu
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: d92b5cc29c79 ("powerpc/64e: Define mmu_pte_psize static")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/nohash/Makefile  |   2 +-
 arch/powerpc/mm/nohash/tlb.c     | 343 +----------------------------
 arch/powerpc/mm/nohash/tlb_64e.c | 361 +++++++++++++++++++++++++++++++
 3 files changed, 363 insertions(+), 343 deletions(-)
 create mode 100644 arch/powerpc/mm/nohash/tlb_64e.c

diff --git a/arch/powerpc/mm/nohash/Makefile b/arch/powerpc/mm/nohash/Makefile
index f3894e79d5f7..24b445a5fcac 100644
--- a/arch/powerpc/mm/nohash/Makefile
+++ b/arch/powerpc/mm/nohash/Makefile
@@ -3,7 +3,7 @@
 ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 
 obj-y				+= mmu_context.o tlb.o tlb_low.o kup.o
-obj-$(CONFIG_PPC_BOOK3E_64)  	+= tlb_low_64e.o book3e_pgtable.o
+obj-$(CONFIG_PPC_BOOK3E_64)  	+= tlb_64e.o tlb_low_64e.o book3e_pgtable.o
 obj-$(CONFIG_40x)		+= 40x.o
 obj-$(CONFIG_44x)		+= 44x.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index a5bb87ec8578..f57dc721d063 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -110,28 +110,6 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 };
 #endif
 
-/* The variables below are currently only used on 64-bit Book3E
- * though this will probably be made common with other nohash
- * implementations at some point
- */
-#ifdef CONFIG_PPC64
-
-int mmu_pte_psize;		/* Page size used for PTE pages */
-int mmu_vmemmap_psize;		/* Page size used for the virtual mem map */
-int book3e_htw_mode;		/* HW tablewalk?  Value is PPC_HTW_* */
-unsigned long linear_map_top;	/* Top of linear mapping */
-
-
-/*
- * Number of bytes to add to SPRN_SPRG_TLB_EXFRAME on crit/mcheck/debug
- * exceptions.  This is used for bolted and e6500 TLB miss handlers which
- * do not modify this SPRG in the TLB miss code; for other TLB miss handlers,
- * this is set to zero.
- */
-int extlb_level_exc;
-
-#endif /* CONFIG_PPC64 */
-
 #ifdef CONFIG_PPC_E500
 /* next_tlbcam_idx is used to round-robin tlbcam entry assignment */
 DEFINE_PER_CPU(int, next_tlbcam_idx);
@@ -358,326 +336,7 @@ void tlb_flush(struct mmu_gather *tlb)
 	flush_tlb_mm(tlb->mm);
 }
 
-/*
- * Below are functions specific to the 64-bit variant of Book3E though that
- * may change in the future
- */
-
-#ifdef CONFIG_PPC64
-
-/*
- * Handling of virtual linear page tables or indirect TLB entries
- * flushing when PTE pages are freed
- */
-void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
-{
-	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
-
-	if (book3e_htw_mode != PPC_HTW_NONE) {
-		unsigned long start = address & PMD_MASK;
-		unsigned long end = address + PMD_SIZE;
-		unsigned long size = 1UL << mmu_psize_defs[mmu_pte_psize].shift;
-
-		/* This isn't the most optimal, ideally we would factor out the
-		 * while preempt & CPU mask mucking around, or even the IPI but
-		 * it will do for now
-		 */
-		while (start < end) {
-			__flush_tlb_page(tlb->mm, start, tsize, 1);
-			start += size;
-		}
-	} else {
-		unsigned long rmask = 0xf000000000000000ul;
-		unsigned long rid = (address & rmask) | 0x1000000000000000ul;
-		unsigned long vpte = address & ~rmask;
-
-		vpte = (vpte >> (PAGE_SHIFT - 3)) & ~0xffful;
-		vpte |= rid;
-		__flush_tlb_page(tlb->mm, vpte, tsize, 0);
-	}
-}
-
-static void __init setup_page_sizes(void)
-{
-	unsigned int tlb0cfg;
-	unsigned int eptcfg;
-	int psize;
-
-#ifdef CONFIG_PPC_E500
-	unsigned int mmucfg = mfspr(SPRN_MMUCFG);
-	int fsl_mmu = mmu_has_feature(MMU_FTR_TYPE_FSL_E);
-
-	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) {
-		unsigned int tlb1cfg = mfspr(SPRN_TLB1CFG);
-		unsigned int min_pg, max_pg;
-
-		min_pg = (tlb1cfg & TLBnCFG_MINSIZE) >> TLBnCFG_MINSIZE_SHIFT;
-		max_pg = (tlb1cfg & TLBnCFG_MAXSIZE) >> TLBnCFG_MAXSIZE_SHIFT;
-
-		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
-			struct mmu_psize_def *def;
-			unsigned int shift;
-
-			def = &mmu_psize_defs[psize];
-			shift = def->shift;
-
-			if (shift == 0 || shift & 1)
-				continue;
-
-			/* adjust to be in terms of 4^shift Kb */
-			shift = (shift - 10) >> 1;
-
-			if ((shift >= min_pg) && (shift <= max_pg))
-				def->flags |= MMU_PAGE_SIZE_DIRECT;
-		}
-
-		goto out;
-	}
-
-	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
-		u32 tlb1cfg, tlb1ps;
-
-		tlb0cfg = mfspr(SPRN_TLB0CFG);
-		tlb1cfg = mfspr(SPRN_TLB1CFG);
-		tlb1ps = mfspr(SPRN_TLB1PS);
-		eptcfg = mfspr(SPRN_EPTCFG);
-
-		if ((tlb1cfg & TLBnCFG_IND) && (tlb0cfg & TLBnCFG_PT))
-			book3e_htw_mode = PPC_HTW_E6500;
-
-		/*
-		 * We expect 4K subpage size and unrestricted indirect size.
-		 * The lack of a restriction on indirect size is a Freescale
-		 * extension, indicated by PSn = 0 but SPSn != 0.
-		 */
-		if (eptcfg != 2)
-			book3e_htw_mode = PPC_HTW_NONE;
-
-		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
-			struct mmu_psize_def *def = &mmu_psize_defs[psize];
-
-			if (!def->shift)
-				continue;
-
-			if (tlb1ps & (1U << (def->shift - 10))) {
-				def->flags |= MMU_PAGE_SIZE_DIRECT;
-
-				if (book3e_htw_mode && psize == MMU_PAGE_2M)
-					def->flags |= MMU_PAGE_SIZE_INDIRECT;
-			}
-		}
-
-		goto out;
-	}
-#endif
-out:
-	/* Cleanup array and print summary */
-	pr_info("MMU: Supported page sizes\n");
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
-		struct mmu_psize_def *def = &mmu_psize_defs[psize];
-		const char *__page_type_names[] = {
-			"unsupported",
-			"direct",
-			"indirect",
-			"direct & indirect"
-		};
-		if (def->flags == 0) {
-			def->shift = 0;	
-			continue;
-		}
-		pr_info("  %8ld KB as %s\n", 1ul << (def->shift - 10),
-			__page_type_names[def->flags & 0x3]);
-	}
-}
-
-static void __init setup_mmu_htw(void)
-{
-	/*
-	 * If we want to use HW tablewalk, enable it by patching the TLB miss
-	 * handlers to branch to the one dedicated to it.
-	 */
-
-	switch (book3e_htw_mode) {
-#ifdef CONFIG_PPC_E500
-	case PPC_HTW_E6500:
-		extlb_level_exc = EX_TLB_SIZE;
-		patch_exception(0x1c0, exc_data_tlb_miss_e6500_book3e);
-		patch_exception(0x1e0, exc_instruction_tlb_miss_e6500_book3e);
-		break;
-#endif
-	}
-	pr_info("MMU: Book3E HW tablewalk %s\n",
-		book3e_htw_mode != PPC_HTW_NONE ? "enabled" : "not supported");
-}
-
-/*
- * Early initialization of the MMU TLB code
- */
-static void early_init_this_mmu(void)
-{
-	unsigned int mas4;
-
-	/* Set MAS4 based on page table setting */
-
-	mas4 = 0x4 << MAS4_WIMGED_SHIFT;
-	switch (book3e_htw_mode) {
-	case PPC_HTW_E6500:
-		mas4 |= MAS4_INDD;
-		mas4 |= BOOK3E_PAGESZ_2M << MAS4_TSIZED_SHIFT;
-		mas4 |= MAS4_TLBSELD(1);
-		mmu_pte_psize = MMU_PAGE_2M;
-		break;
-
-	case PPC_HTW_NONE:
-		mas4 |=	BOOK3E_PAGESZ_4K << MAS4_TSIZED_SHIFT;
-		mmu_pte_psize = mmu_virtual_psize;
-		break;
-	}
-	mtspr(SPRN_MAS4, mas4);
-
-#ifdef CONFIG_PPC_E500
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
-		unsigned int num_cams;
-		bool map = true;
-
-		/* use a quarter of the TLBCAM for bolted linear map */
-		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
-
-		/*
-		 * Only do the mapping once per core, or else the
-		 * transient mapping would cause problems.
-		 */
-#ifdef CONFIG_SMP
-		if (hweight32(get_tensr()) > 1)
-			map = false;
-#endif
-
-		if (map)
-			linear_map_top = map_mem_in_cams(linear_map_top,
-							 num_cams, false, true);
-	}
-#endif
-
-	/* A sync won't hurt us after mucking around with
-	 * the MMU configuration
-	 */
-	mb();
-}
-
-static void __init early_init_mmu_global(void)
-{
-	/* XXX This should be decided at runtime based on supported
-	 * page sizes in the TLB, but for now let's assume 16M is
-	 * always there and a good fit (which it probably is)
-	 *
-	 * Freescale booke only supports 4K pages in TLB0, so use that.
-	 */
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
-		mmu_vmemmap_psize = MMU_PAGE_4K;
-	else
-		mmu_vmemmap_psize = MMU_PAGE_16M;
-
-	/* XXX This code only checks for TLB 0 capabilities and doesn't
-	 *     check what page size combos are supported by the HW. It
-	 *     also doesn't handle the case where a separate array holds
-	 *     the IND entries from the array loaded by the PT.
-	 */
-	/* Look for supported page sizes */
-	setup_page_sizes();
-
-	/* Look for HW tablewalk support */
-	setup_mmu_htw();
-
-#ifdef CONFIG_PPC_E500
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
-		if (book3e_htw_mode == PPC_HTW_NONE) {
-			extlb_level_exc = EX_TLB_SIZE;
-			patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
-			patch_exception(0x1e0,
-				exc_instruction_tlb_miss_bolted_book3e);
-		}
-	}
-#endif
-
-	/* Set the global containing the top of the linear mapping
-	 * for use by the TLB miss code
-	 */
-	linear_map_top = memblock_end_of_DRAM();
-
-	ioremap_bot = IOREMAP_BASE;
-}
-
-static void __init early_mmu_set_memory_limit(void)
-{
-#ifdef CONFIG_PPC_E500
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
-		/*
-		 * Limit memory so we dont have linear faults.
-		 * Unlike memblock_set_current_limit, which limits
-		 * memory available during early boot, this permanently
-		 * reduces the memory available to Linux.  We need to
-		 * do this because highmem is not supported on 64-bit.
-		 */
-		memblock_enforce_memory_limit(linear_map_top);
-	}
-#endif
-
-	memblock_set_current_limit(linear_map_top);
-}
-
-/* boot cpu only */
-void __init early_init_mmu(void)
-{
-	early_init_mmu_global();
-	early_init_this_mmu();
-	early_mmu_set_memory_limit();
-}
-
-void early_init_mmu_secondary(void)
-{
-	early_init_this_mmu();
-}
-
-void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
-{
-	/* On non-FSL Embedded 64-bit, we adjust the RMA size to match
-	 * the bolted TLB entry. We know for now that only 1G
-	 * entries are supported though that may eventually
-	 * change.
-	 *
-	 * on FSL Embedded 64-bit, usually all RAM is bolted, but with
-	 * unusual memory sizes it's possible for some RAM to not be mapped
-	 * (such RAM is not used at all by Linux, since we don't support
-	 * highmem on 64-bit).  We limit ppc64_rma_size to what would be
-	 * mappable if this memblock is the only one.  Additional memblocks
-	 * can only increase, not decrease, the amount that ends up getting
-	 * mapped.  We still limit max to 1G even if we'll eventually map
-	 * more.  This is due to what the early init code is set up to do.
-	 *
-	 * We crop it to the size of the first MEMBLOCK to
-	 * avoid going over total available memory just in case...
-	 */
-#ifdef CONFIG_PPC_E500
-	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
-		unsigned long linear_sz;
-		unsigned int num_cams;
-
-		/* use a quarter of the TLBCAM for bolted linear map */
-		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
-
-		linear_sz = map_mem_in_cams(first_memblock_size, num_cams,
-					    true, true);
-
-		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
-	} else
-#endif
-		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
-
-	/* Finally limit subsequent allocations */
-	memblock_set_current_limit(first_memblock_base + ppc64_rma_size);
-}
-#else /* ! CONFIG_PPC64 */
+#ifndef CONFIG_PPC64
 void __init early_init_mmu(void)
 {
 	unsigned long root = of_get_flat_dt_root();
diff --git a/arch/powerpc/mm/nohash/tlb_64e.c b/arch/powerpc/mm/nohash/tlb_64e.c
new file mode 100644
index 000000000000..1dcda261554c
--- /dev/null
+++ b/arch/powerpc/mm/nohash/tlb_64e.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2008,2009 Ben Herrenschmidt <benh@kernel.crashing.org>
+ *                     IBM Corp.
+ *
+ *  Derived from arch/ppc/mm/init.c:
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
+ *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
+ *    Copyright (C) 1996 Paul Mackerras
+ *
+ *  Derived from "arch/i386/mm/init.c"
+ *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/pagemap.h>
+#include <linux/memblock.h>
+
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+#include <asm/code-patching.h>
+#include <asm/cputhreads.h>
+
+#include <mm/mmu_decl.h>
+
+/* The variables below are currently only used on 64-bit Book3E
+ * though this will probably be made common with other nohash
+ * implementations at some point
+ */
+int mmu_pte_psize;		/* Page size used for PTE pages */
+int mmu_vmemmap_psize;		/* Page size used for the virtual mem map */
+int book3e_htw_mode;		/* HW tablewalk?  Value is PPC_HTW_* */
+unsigned long linear_map_top;	/* Top of linear mapping */
+
+
+/*
+ * Number of bytes to add to SPRN_SPRG_TLB_EXFRAME on crit/mcheck/debug
+ * exceptions.  This is used for bolted and e6500 TLB miss handlers which
+ * do not modify this SPRG in the TLB miss code; for other TLB miss handlers,
+ * this is set to zero.
+ */
+int extlb_level_exc;
+
+/*
+ * Handling of virtual linear page tables or indirect TLB entries
+ * flushing when PTE pages are freed
+ */
+void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
+{
+	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
+
+	if (book3e_htw_mode != PPC_HTW_NONE) {
+		unsigned long start = address & PMD_MASK;
+		unsigned long end = address + PMD_SIZE;
+		unsigned long size = 1UL << mmu_psize_defs[mmu_pte_psize].shift;
+
+		/* This isn't the most optimal, ideally we would factor out the
+		 * while preempt & CPU mask mucking around, or even the IPI but
+		 * it will do for now
+		 */
+		while (start < end) {
+			__flush_tlb_page(tlb->mm, start, tsize, 1);
+			start += size;
+		}
+	} else {
+		unsigned long rmask = 0xf000000000000000ul;
+		unsigned long rid = (address & rmask) | 0x1000000000000000ul;
+		unsigned long vpte = address & ~rmask;
+
+		vpte = (vpte >> (PAGE_SHIFT - 3)) & ~0xffful;
+		vpte |= rid;
+		__flush_tlb_page(tlb->mm, vpte, tsize, 0);
+	}
+}
+
+static void __init setup_page_sizes(void)
+{
+	unsigned int tlb0cfg;
+	unsigned int eptcfg;
+	int psize;
+
+#ifdef CONFIG_PPC_E500
+	unsigned int mmucfg = mfspr(SPRN_MMUCFG);
+	int fsl_mmu = mmu_has_feature(MMU_FTR_TYPE_FSL_E);
+
+	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) {
+		unsigned int tlb1cfg = mfspr(SPRN_TLB1CFG);
+		unsigned int min_pg, max_pg;
+
+		min_pg = (tlb1cfg & TLBnCFG_MINSIZE) >> TLBnCFG_MINSIZE_SHIFT;
+		max_pg = (tlb1cfg & TLBnCFG_MAXSIZE) >> TLBnCFG_MAXSIZE_SHIFT;
+
+		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
+			struct mmu_psize_def *def;
+			unsigned int shift;
+
+			def = &mmu_psize_defs[psize];
+			shift = def->shift;
+
+			if (shift == 0 || shift & 1)
+				continue;
+
+			/* adjust to be in terms of 4^shift Kb */
+			shift = (shift - 10) >> 1;
+
+			if ((shift >= min_pg) && (shift <= max_pg))
+				def->flags |= MMU_PAGE_SIZE_DIRECT;
+		}
+
+		goto out;
+	}
+
+	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
+		u32 tlb1cfg, tlb1ps;
+
+		tlb0cfg = mfspr(SPRN_TLB0CFG);
+		tlb1cfg = mfspr(SPRN_TLB1CFG);
+		tlb1ps = mfspr(SPRN_TLB1PS);
+		eptcfg = mfspr(SPRN_EPTCFG);
+
+		if ((tlb1cfg & TLBnCFG_IND) && (tlb0cfg & TLBnCFG_PT))
+			book3e_htw_mode = PPC_HTW_E6500;
+
+		/*
+		 * We expect 4K subpage size and unrestricted indirect size.
+		 * The lack of a restriction on indirect size is a Freescale
+		 * extension, indicated by PSn = 0 but SPSn != 0.
+		 */
+		if (eptcfg != 2)
+			book3e_htw_mode = PPC_HTW_NONE;
+
+		for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
+			struct mmu_psize_def *def = &mmu_psize_defs[psize];
+
+			if (!def->shift)
+				continue;
+
+			if (tlb1ps & (1U << (def->shift - 10))) {
+				def->flags |= MMU_PAGE_SIZE_DIRECT;
+
+				if (book3e_htw_mode && psize == MMU_PAGE_2M)
+					def->flags |= MMU_PAGE_SIZE_INDIRECT;
+			}
+		}
+
+		goto out;
+	}
+#endif
+out:
+	/* Cleanup array and print summary */
+	pr_info("MMU: Supported page sizes\n");
+	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
+		struct mmu_psize_def *def = &mmu_psize_defs[psize];
+		const char *__page_type_names[] = {
+			"unsupported",
+			"direct",
+			"indirect",
+			"direct & indirect"
+		};
+		if (def->flags == 0) {
+			def->shift = 0;
+			continue;
+		}
+		pr_info("  %8ld KB as %s\n", 1ul << (def->shift - 10),
+			__page_type_names[def->flags & 0x3]);
+	}
+}
+
+static void __init setup_mmu_htw(void)
+{
+	/*
+	 * If we want to use HW tablewalk, enable it by patching the TLB miss
+	 * handlers to branch to the one dedicated to it.
+	 */
+
+	switch (book3e_htw_mode) {
+#ifdef CONFIG_PPC_E500
+	case PPC_HTW_E6500:
+		extlb_level_exc = EX_TLB_SIZE;
+		patch_exception(0x1c0, exc_data_tlb_miss_e6500_book3e);
+		patch_exception(0x1e0, exc_instruction_tlb_miss_e6500_book3e);
+		break;
+#endif
+	}
+	pr_info("MMU: Book3E HW tablewalk %s\n",
+		book3e_htw_mode != PPC_HTW_NONE ? "enabled" : "not supported");
+}
+
+/*
+ * Early initialization of the MMU TLB code
+ */
+static void early_init_this_mmu(void)
+{
+	unsigned int mas4;
+
+	/* Set MAS4 based on page table setting */
+
+	mas4 = 0x4 << MAS4_WIMGED_SHIFT;
+	switch (book3e_htw_mode) {
+	case PPC_HTW_E6500:
+		mas4 |= MAS4_INDD;
+		mas4 |= BOOK3E_PAGESZ_2M << MAS4_TSIZED_SHIFT;
+		mas4 |= MAS4_TLBSELD(1);
+		mmu_pte_psize = MMU_PAGE_2M;
+		break;
+
+	case PPC_HTW_NONE:
+		mas4 |=	BOOK3E_PAGESZ_4K << MAS4_TSIZED_SHIFT;
+		mmu_pte_psize = mmu_virtual_psize;
+		break;
+	}
+	mtspr(SPRN_MAS4, mas4);
+
+#ifdef CONFIG_PPC_E500
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+		unsigned int num_cams;
+		bool map = true;
+
+		/* use a quarter of the TLBCAM for bolted linear map */
+		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
+
+		/*
+		 * Only do the mapping once per core, or else the
+		 * transient mapping would cause problems.
+		 */
+#ifdef CONFIG_SMP
+		if (hweight32(get_tensr()) > 1)
+			map = false;
+#endif
+
+		if (map)
+			linear_map_top = map_mem_in_cams(linear_map_top,
+							 num_cams, false, true);
+	}
+#endif
+
+	/* A sync won't hurt us after mucking around with
+	 * the MMU configuration
+	 */
+	mb();
+}
+
+static void __init early_init_mmu_global(void)
+{
+	/* XXX This should be decided at runtime based on supported
+	 * page sizes in the TLB, but for now let's assume 16M is
+	 * always there and a good fit (which it probably is)
+	 *
+	 * Freescale booke only supports 4K pages in TLB0, so use that.
+	 */
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
+		mmu_vmemmap_psize = MMU_PAGE_4K;
+	else
+		mmu_vmemmap_psize = MMU_PAGE_16M;
+
+	/* XXX This code only checks for TLB 0 capabilities and doesn't
+	 *     check what page size combos are supported by the HW. It
+	 *     also doesn't handle the case where a separate array holds
+	 *     the IND entries from the array loaded by the PT.
+	 */
+	/* Look for supported page sizes */
+	setup_page_sizes();
+
+	/* Look for HW tablewalk support */
+	setup_mmu_htw();
+
+#ifdef CONFIG_PPC_E500
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+		if (book3e_htw_mode == PPC_HTW_NONE) {
+			extlb_level_exc = EX_TLB_SIZE;
+			patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
+			patch_exception(0x1e0,
+				exc_instruction_tlb_miss_bolted_book3e);
+		}
+	}
+#endif
+
+	/* Set the global containing the top of the linear mapping
+	 * for use by the TLB miss code
+	 */
+	linear_map_top = memblock_end_of_DRAM();
+
+	ioremap_bot = IOREMAP_BASE;
+}
+
+static void __init early_mmu_set_memory_limit(void)
+{
+#ifdef CONFIG_PPC_E500
+	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+		/*
+		 * Limit memory so we dont have linear faults.
+		 * Unlike memblock_set_current_limit, which limits
+		 * memory available during early boot, this permanently
+		 * reduces the memory available to Linux.  We need to
+		 * do this because highmem is not supported on 64-bit.
+		 */
+		memblock_enforce_memory_limit(linear_map_top);
+	}
+#endif
+
+	memblock_set_current_limit(linear_map_top);
+}
+
+/* boot cpu only */
+void __init early_init_mmu(void)
+{
+	early_init_mmu_global();
+	early_init_this_mmu();
+	early_mmu_set_memory_limit();
+}
+
+void early_init_mmu_secondary(void)
+{
+	early_init_this_mmu();
+}
+
+void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+				phys_addr_t first_memblock_size)
+{
+	/* On non-FSL Embedded 64-bit, we adjust the RMA size to match
+	 * the bolted TLB entry. We know for now that only 1G
+	 * entries are supported though that may eventually
+	 * change.
+	 *
+	 * on FSL Embedded 64-bit, usually all RAM is bolted, but with
+	 * unusual memory sizes it's possible for some RAM to not be mapped
+	 * (such RAM is not used at all by Linux, since we don't support
+	 * highmem on 64-bit).  We limit ppc64_rma_size to what would be
+	 * mappable if this memblock is the only one.  Additional memblocks
+	 * can only increase, not decrease, the amount that ends up getting
+	 * mapped.  We still limit max to 1G even if we'll eventually map
+	 * more.  This is due to what the early init code is set up to do.
+	 *
+	 * We crop it to the size of the first MEMBLOCK to
+	 * avoid going over total available memory just in case...
+	 */
+#ifdef CONFIG_PPC_E500
+	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+		unsigned long linear_sz;
+		unsigned int num_cams;
+
+		/* use a quarter of the TLBCAM for bolted linear map */
+		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
+
+		linear_sz = map_mem_in_cams(first_memblock_size, num_cams,
+					    true, true);
+
+		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
+	} else
+#endif
+		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+
+	/* Finally limit subsequent allocations */
+	memblock_set_current_limit(first_memblock_base + ppc64_rma_size);
+}
-- 
2.43.0




