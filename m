Return-Path: <stable+bounces-75991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F3C976836
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 13:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D80DAB23BD1
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20F1A42B0;
	Thu, 12 Sep 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a3DjyP+s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AD1A2636;
	Thu, 12 Sep 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141730; cv=none; b=ke3TdZXG5yvi0RMXboxyZVAQfqqOeED5Qw4T15TZ966ZNzUA2WFgXz/ENxGRLOEQdpOGuVwNmCOWkuvbenFu98+DhC7lcxG38P6LHWe7g7YB96p2xU6XCf5QIKVCb4HjrS0TO6arZXE+3A5fX3dl3GMsLV8hE8JoUWaLNp4h89A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141730; c=relaxed/simple;
	bh=Hz0x4ncnRt1s0i+jYRsstCQ3m1VIemxqAhyaK5y9K4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qr51ayzVPVRU7XFyDzT1vwpEYRVDmd02rrKC9uJtREQBG/xI6M0cAo0T3OnoWO7YqUnGrD6WT8rgfIYQA7f9oUo+r2FE0ZXzvcgReT4WEDJWT6zvGGOoHVBaDY8X/NyxMcWM1H82GdoOLsND9qvO9EhJ/V0ZqXwZC9GtxvVLWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3DjyP+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5620DC4CEC4;
	Thu, 12 Sep 2024 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726141730;
	bh=Hz0x4ncnRt1s0i+jYRsstCQ3m1VIemxqAhyaK5y9K4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a3DjyP+s12X5RiU4JdNKZ5iwEEGr6E5tmsCwDwdUdy5yYNz/vNHZVFbYLPyQDmoT4
	 jlrJ5SsuQw/2AcmltzO4djiKYG2iFiIts82Qw7NC0rjMpvtebGX+fEvMvdSN6HNeJt
	 h8L1VdlTYlhmxmFxaKWXL2UoSwH8PuSTckbbYt9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.110
Date: Thu, 12 Sep 2024 13:48:35 +0200
Message-ID: <2024091235-crummy-scrap-a770@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024091235-unharmed-depress-a08d@gregkh>
References: <2024091235-unharmed-depress-a08d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 59c1ac88c57d..0e055579c721 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 109
+SUBLEVEL = 110
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bd68e1b7f29f..702587fda70c 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -97,6 +97,18 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
 	return	acpi_cpu_get_madt_gicc(cpu)->uid;
 }
 
+static inline int get_cpu_for_acpi_id(u32 uid)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		if (acpi_cpu_get_madt_gicc(cpu) &&
+		    uid == get_acpi_id_for_cpu(cpu))
+			return cpu;
+
+	return -EINVAL;
+}
+
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
 int apei_claim_sea(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
index ccbff21ce1fa..2465f291c7e1 100644
--- a/arch/arm64/kernel/acpi_numa.c
+++ b/arch/arm64/kernel/acpi_numa.c
@@ -34,17 +34,6 @@ int __init acpi_numa_get_nid(unsigned int cpu)
 	return acpi_early_node_map[cpu];
 }
 
-static inline int get_cpu_for_acpi_id(u32 uid)
-{
-	int cpu;
-
-	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
-		if (uid == get_acpi_id_for_cpu(cpu))
-			return cpu;
-
-	return -EINVAL;
-}
-
 static int __init acpi_parse_gicc_pxm(union acpi_subtable_headers *header,
 				      const unsigned long end)
 {
diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
index 32ec67c9ab67..77028aa8c107 100644
--- a/arch/mips/kernel/cevt-r4k.c
+++ b/arch/mips/kernel/cevt-r4k.c
@@ -303,13 +303,6 @@ int r4k_clockevent_init(void)
 	if (!c0_compare_int_usable())
 		return -ENXIO;
 
-	/*
-	 * With vectored interrupts things are getting platform specific.
-	 * get_c0_compare_int is a hook to allow a platform to return the
-	 * interrupt number of its liking.
-	 */
-	irq = get_c0_compare_int();
-
 	cd = &per_cpu(mips_clockevent_device, cpu);
 
 	cd->name		= "MIPS";
@@ -320,7 +313,6 @@ int r4k_clockevent_init(void)
 	min_delta		= calculate_min_delta();
 
 	cd->rating		= 300;
-	cd->irq			= irq;
 	cd->cpumask		= cpumask_of(cpu);
 	cd->set_next_event	= mips_next_event;
 	cd->event_handler	= mips_event_handler;
@@ -332,6 +324,13 @@ int r4k_clockevent_init(void)
 
 	cp0_timer_irq_installed = 1;
 
+	/*
+	 * With vectored interrupts things are getting platform specific.
+	 * get_c0_compare_int is a hook to allow a platform to return the
+	 * interrupt number of its liking.
+	 */
+	irq = get_c0_compare_int();
+
 	if (request_irq(irq, c0_compare_interrupt, flags, "timer",
 			c0_compare_interrupt))
 		pr_err("Failed to request irq %d (timer)\n", irq);
diff --git a/arch/powerpc/include/asm/nohash/mmu-e500.h b/arch/powerpc/include/asm/nohash/mmu-e500.h
index e43a418d3ccd..9b5ba73d33d6 100644
--- a/arch/powerpc/include/asm/nohash/mmu-e500.h
+++ b/arch/powerpc/include/asm/nohash/mmu-e500.h
@@ -303,8 +303,7 @@ extern unsigned long linear_map_top;
 extern int book3e_htw_mode;
 
 #define PPC_HTW_NONE	0
-#define PPC_HTW_IBM	1
-#define PPC_HTW_E6500	2
+#define PPC_HTW_E6500	1
 
 /*
  * 64-bit booke platforms don't load the tlb in the tlb miss handler code.
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
index 2c15c86c7015..c0b643d30fcc 100644
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
@@ -361,381 +339,7 @@ void tlb_flush(struct mmu_gather *tlb)
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
-	unsigned int tlb0ps;
-	unsigned int eptcfg;
-	int i, psize;
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
-
-	tlb0cfg = mfspr(SPRN_TLB0CFG);
-	tlb0ps = mfspr(SPRN_TLB0PS);
-	eptcfg = mfspr(SPRN_EPTCFG);
-
-	/* Look for supported direct sizes */
-	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
-		struct mmu_psize_def *def = &mmu_psize_defs[psize];
-
-		if (tlb0ps & (1U << (def->shift - 10)))
-			def->flags |= MMU_PAGE_SIZE_DIRECT;
-	}
-
-	/* Indirect page sizes supported ? */
-	if ((tlb0cfg & TLBnCFG_IND) == 0 ||
-	    (tlb0cfg & TLBnCFG_PT) == 0)
-		goto out;
-
-	book3e_htw_mode = PPC_HTW_IBM;
-
-	/* Now, we only deal with one IND page size for each
-	 * direct size. Hopefully all implementations today are
-	 * unambiguous, but we might want to be careful in the
-	 * future.
-	 */
-	for (i = 0; i < 3; i++) {
-		unsigned int ps, sps;
-
-		sps = eptcfg & 0x1f;
-		eptcfg >>= 5;
-		ps = eptcfg & 0x1f;
-		eptcfg >>= 5;
-		if (!ps || !sps)
-			continue;
-		for (psize = 0; psize < MMU_PAGE_COUNT; psize++) {
-			struct mmu_psize_def *def = &mmu_psize_defs[psize];
-
-			if (ps == (def->shift - 10))
-				def->flags |= MMU_PAGE_SIZE_INDIRECT;
-			if (sps == (def->shift - 10))
-				def->ind = ps + 10;
-		}
-	}
-
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
-	case PPC_HTW_IBM:
-		patch_exception(0x1c0, exc_data_tlb_miss_htw_book3e);
-		patch_exception(0x1e0, exc_instruction_tlb_miss_htw_book3e);
-		break;
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
-	case PPC_HTW_IBM:
-		mas4 |= MAS4_INDD;
-		mas4 |=	BOOK3E_PAGESZ_1M << MAS4_TSIZED_SHIFT;
-		mmu_pte_psize = MMU_PAGE_1M;
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
 #ifdef CONFIG_PPC_47x
diff --git a/arch/powerpc/mm/nohash/tlb_64e.c b/arch/powerpc/mm/nohash/tlb_64e.c
new file mode 100644
index 000000000000..b6af3ec4d001
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
+static int mmu_pte_psize;	/* Page size used for PTE pages */
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
diff --git a/arch/powerpc/mm/nohash/tlb_low_64e.S b/arch/powerpc/mm/nohash/tlb_low_64e.S
index 76cf456d7976..d831a111eaba 100644
--- a/arch/powerpc/mm/nohash/tlb_low_64e.S
+++ b/arch/powerpc/mm/nohash/tlb_low_64e.S
@@ -893,201 +893,6 @@ virt_page_table_tlb_miss_whacko_fault:
 	TLB_MISS_EPILOG_ERROR
 	b	exc_data_storage_book3e
 
-
-/**************************************************************
- *                                                            *
- * TLB miss handling for Book3E with hw page table support    *
- *                                                            *
- **************************************************************/
-
-
-/* Data TLB miss */
-	START_EXCEPTION(data_tlb_miss_htw)
-	TLB_MISS_PROLOG
-
-	/* Now we handle the fault proper. We only save DEAR in normal
-	 * fault case since that's the only interesting values here.
-	 * We could probably also optimize by not saving SRR0/1 in the
-	 * linear mapping case but I'll leave that for later
-	 */
-	mfspr	r14,SPRN_ESR
-	mfspr	r16,SPRN_DEAR		/* get faulting address */
-	srdi	r11,r16,44		/* get region */
-	xoris	r11,r11,0xc
-	cmpldi	cr0,r11,0		/* linear mapping ? */
-	beq	tlb_load_linear		/* yes -> go to linear map load */
-	cmpldi	cr1,r11,1		/* vmalloc mapping ? */
-
-	/* We do the user/kernel test for the PID here along with the RW test
-	 */
-	srdi.	r11,r16,60		/* Check for user region */
-	ld	r15,PACAPGD(r13)	/* Load user pgdir */
-	beq	htw_tlb_miss
-
-	/* XXX replace the RMW cycles with immediate loads + writes */
-1:	mfspr	r10,SPRN_MAS1
-	rlwinm	r10,r10,0,16,1		/* Clear TID */
-	mtspr	SPRN_MAS1,r10
-	ld	r15,PACA_KERNELPGD(r13)	/* Load kernel pgdir */
-	beq+	cr1,htw_tlb_miss
-
-	/* We got a crappy address, just fault with whatever DEAR and ESR
-	 * are here
-	 */
-	TLB_MISS_EPILOG_ERROR
-	b	exc_data_storage_book3e
-
-/* Instruction TLB miss */
-	START_EXCEPTION(instruction_tlb_miss_htw)
-	TLB_MISS_PROLOG
-
-	/* If we take a recursive fault, the second level handler may need
-	 * to know whether we are handling a data or instruction fault in
-	 * order to get to the right store fault handler. We provide that
-	 * info by keeping a crazy value for ESR in r14
-	 */
-	li	r14,-1	/* store to exception frame is done later */
-
-	/* Now we handle the fault proper. We only save DEAR in the non
-	 * linear mapping case since we know the linear mapping case will
-	 * not re-enter. We could indeed optimize and also not save SRR0/1
-	 * in the linear mapping case but I'll leave that for later
-	 *
-	 * Faulting address is SRR0 which is already in r16
-	 */
-	srdi	r11,r16,44		/* get region */
-	xoris	r11,r11,0xc
-	cmpldi	cr0,r11,0		/* linear mapping ? */
-	beq	tlb_load_linear		/* yes -> go to linear map load */
-	cmpldi	cr1,r11,1		/* vmalloc mapping ? */
-
-	/* We do the user/kernel test for the PID here along with the RW test
-	 */
-	srdi.	r11,r16,60		/* Check for user region */
-	ld	r15,PACAPGD(r13)		/* Load user pgdir */
-	beq	htw_tlb_miss
-
-	/* XXX replace the RMW cycles with immediate loads + writes */
-1:	mfspr	r10,SPRN_MAS1
-	rlwinm	r10,r10,0,16,1			/* Clear TID */
-	mtspr	SPRN_MAS1,r10
-	ld	r15,PACA_KERNELPGD(r13)		/* Load kernel pgdir */
-	beq+	htw_tlb_miss
-
-	/* We got a crappy address, just fault */
-	TLB_MISS_EPILOG_ERROR
-	b	exc_instruction_storage_book3e
-
-
-/*
- * This is the guts of the second-level TLB miss handler for direct
- * misses. We are entered with:
- *
- * r16 = virtual page table faulting address
- * r15 = PGD pointer
- * r14 = ESR
- * r13 = PACA
- * r12 = TLB exception frame in PACA
- * r11 = crap (free to use)
- * r10 = crap (free to use)
- *
- * It can be re-entered by the linear mapping miss handler. However, to
- * avoid too much complication, it will save/restore things for us
- */
-htw_tlb_miss:
-#ifdef CONFIG_PPC_KUAP
-	mfspr	r10,SPRN_MAS1
-	rlwinm.	r10,r10,0,0x3fff0000
-	beq-	htw_tlb_miss_fault /* KUAP fault */
-#endif
-	/* Search if we already have a TLB entry for that virtual address, and
-	 * if we do, bail out.
-	 *
-	 * MAS1:IND should be already set based on MAS4
-	 */
-	PPC_TLBSRX_DOT(0,R16)
-	beq	htw_tlb_miss_done
-
-	/* Now, we need to walk the page tables. First check if we are in
-	 * range.
-	 */
-	rldicl.	r10,r16,64-PGTABLE_EADDR_SIZE,PGTABLE_EADDR_SIZE+4
-	bne-	htw_tlb_miss_fault
-
-	/* Get the PGD pointer */
-	cmpldi	cr0,r15,0
-	beq-	htw_tlb_miss_fault
-
-	/* Get to PGD entry */
-	rldicl	r11,r16,64-(PGDIR_SHIFT-3),64-PGD_INDEX_SIZE-3
-	clrrdi	r10,r11,3
-	ldx	r15,r10,r15
-	cmpdi	cr0,r15,0
-	bge	htw_tlb_miss_fault
-
-	/* Get to PUD entry */
-	rldicl	r11,r16,64-(PUD_SHIFT-3),64-PUD_INDEX_SIZE-3
-	clrrdi	r10,r11,3
-	ldx	r15,r10,r15
-	cmpdi	cr0,r15,0
-	bge	htw_tlb_miss_fault
-
-	/* Get to PMD entry */
-	rldicl	r11,r16,64-(PMD_SHIFT-3),64-PMD_INDEX_SIZE-3
-	clrrdi	r10,r11,3
-	ldx	r15,r10,r15
-	cmpdi	cr0,r15,0
-	bge	htw_tlb_miss_fault
-
-	/* Ok, we're all right, we can now create an indirect entry for
-	 * a 1M or 256M page.
-	 *
-	 * The last trick is now that because we use "half" pages for
-	 * the HTW (1M IND is 2K and 256M IND is 32K) we need to account
-	 * for an added LSB bit to the RPN. For 64K pages, there is no
-	 * problem as we already use 32K arrays (half PTE pages), but for
-	 * 4K page we need to extract a bit from the virtual address and
-	 * insert it into the "PA52" bit of the RPN.
-	 */
-	rlwimi	r15,r16,32-9,20,20
-	/* Now we build the MAS:
-	 *
-	 * MAS 0   :	Fully setup with defaults in MAS4 and TLBnCFG
-	 * MAS 1   :	Almost fully setup
-	 *               - PID already updated by caller if necessary
-	 *               - TSIZE for now is base ind page size always
-	 * MAS 2   :	Use defaults
-	 * MAS 3+7 :	Needs to be done
-	 */
-	ori	r10,r15,(BOOK3E_PAGESZ_4K << MAS3_SPSIZE_SHIFT)
-
-	srdi	r16,r10,32
-	mtspr	SPRN_MAS3,r10
-	mtspr	SPRN_MAS7,r16
-
-	tlbwe
-
-htw_tlb_miss_done:
-	/* We don't bother with restoring DEAR or ESR since we know we are
-	 * level 0 and just going back to userland. They are only needed
-	 * if you are going to take an access fault
-	 */
-	TLB_MISS_EPILOG_SUCCESS
-	rfi
-
-htw_tlb_miss_fault:
-	/* We need to check if it was an instruction miss. We know this
-	 * though because r14 would contain -1
-	 */
-	cmpdi	cr0,r14,-1
-	beq	1f
-	mtspr	SPRN_DEAR,r16
-	mtspr	SPRN_ESR,r14
-	TLB_MISS_EPILOG_ERROR
-	b	exc_data_storage_book3e
-1:	TLB_MISS_EPILOG_ERROR
-	b	exc_instruction_storage_book3e
-
 /*
  * This is the guts of "any" level TLB miss handler for kernel linear
  * mapping misses. We are entered with:
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 4bf6c449d78b..1a017ad53343 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -307,6 +307,9 @@ clear_bss_done:
 #else
 	mv a0, s1
 #endif /* CONFIG_BUILTIN_DTB */
+	/* Set trap vector to spin forever to help debug */
+	la a3, .Lsecondary_park
+	csrw CSR_TVEC, a3
 	call setup_vm
 #ifdef CONFIG_MMU
 	la a0, early_pg_dir
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 729d4f949cfe..52d6e5d1b453 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -71,6 +71,15 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	__end_ro_after_init = .;
 
+	.data.rel.ro : {
+		*(.data.rel.ro .data.rel.ro.*)
+	}
+	.got : {
+		__got_start = .;
+		*(.got)
+		__got_end = .;
+	}
+
 	RW_DATA(0x100, PAGE_SIZE, THREAD_SIZE)
 	BOOT_DATA_PRESERVED
 
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 95ad6b190d1d..6b4faca401ea 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -383,6 +383,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			parse_chan_pair(NULL, line, n, opts, error_out);
 			err = 0;
 		}
+		*error_out = "configured as 'none'";
 	} else {
 		char *new = kstrdup(init, GFP_KERNEL);
 		if (!new) {
@@ -406,6 +407,7 @@ int setup_one_line(struct line *lines, int n, char *init,
 			}
 		}
 		if (err) {
+			*error_out = "failed to parse channel pair";
 			line->init_str = NULL;
 			line->valid = 0;
 			kfree(new);
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 4692450aeb4d..b9da467bd222 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -328,7 +328,6 @@ static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 		.r12 = size,
 		.r13 = EPT_READ,
 		.r14 = addr,
-		.r15 = *val,
 	};
 
 	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 949129443b1c..27968d10dd0b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4352,6 +4352,25 @@ static u8 adl_get_hybrid_cpu_type(void)
 	return hybrid_big;
 }
 
+static inline bool erratum_hsw11(struct perf_event *event)
+{
+	return (event->hw.config & INTEL_ARCH_EVENT_MASK) ==
+		X86_CONFIG(.event=0xc0, .umask=0x01);
+}
+
+/*
+ * The HSW11 requires a period larger than 100 which is the same as the BDM11.
+ * A minimum period of 128 is enforced as well for the INST_RETIRED.ALL.
+ *
+ * The message 'interrupt took too long' can be observed on any counter which
+ * was armed with a period < 32 and two events expired in the same NMI.
+ * A minimum period of 32 is enforced for the rest of the events.
+ */
+static void hsw_limit_period(struct perf_event *event, s64 *left)
+{
+	*left = max(*left, erratum_hsw11(event) ? 128 : 32);
+}
+
 /*
  * Broadwell:
  *
@@ -4369,8 +4388,7 @@ static u8 adl_get_hybrid_cpu_type(void)
  */
 static void bdw_limit_period(struct perf_event *event, s64 *left)
 {
-	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
-			X86_CONFIG(.event=0xc0, .umask=0x01)) {
+	if (erratum_hsw11(event)) {
 		if (*left < 128)
 			*left = 128;
 		*left &= ~0x3fULL;
@@ -6180,6 +6198,7 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.hw_config = hsw_hw_config;
 		x86_pmu.get_event_constraints = hsw_get_event_constraints;
+		x86_pmu.limit_period = hsw_limit_period;
 		x86_pmu.lbr_double_abort = true;
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			hsw_format_attr : nhm_format_attr;
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index eb7cd1139d97..b85af124f899 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -577,6 +577,13 @@ struct fpu_state_config {
 	 * even without XSAVE support, i.e. legacy features FP + SSE
 	 */
 	u64 legacy_features;
+	/*
+	 * @independent_features:
+	 *
+	 * Features that are supported by XSAVES, but not managed as part of
+	 * the FPU core, such as LBR
+	 */
+	u64 independent_features;
 };
 
 /* FPU state configuration information */
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 198e03e59ca1..554af02a0526 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -17,6 +17,7 @@ extern unsigned long phys_base;
 extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
+extern unsigned long physmem_end;
 
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 04f36063ad54..6c7f7c526450 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -139,6 +139,10 @@ extern unsigned int ptrs_per_p4d;
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
+#ifdef CONFIG_RANDOMIZE_MEMORY
+# define PHYSMEM_END		physmem_end
+#endif
+
 /*
  * End of the region for which vmalloc page tables are pre-allocated.
  * For non-KMSAN builds, this is the same as VMALLOC_END.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 2aa849705bb6..d18594343745 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -792,6 +792,9 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		goto out_disable;
 	}
 
+	fpu_kernel_cfg.independent_features = fpu_kernel_cfg.max_features &
+					      XFEATURE_MASK_INDEPENDENT;
+
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 19ca623ffa2a..544224611e23 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -64,9 +64,9 @@ static inline u64 xfeatures_mask_supervisor(void)
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+		return fpu_kernel_cfg.independent_features & ~XFEATURE_MASK_LBR;
 
-	return XFEATURE_MASK_INDEPENDENT;
+	return fpu_kernel_cfg.independent_features;
 }
 
 /* XSAVE/XRSTOR wrapper functions */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4a663812562d..a96facc05139 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2756,6 +2756,12 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_CSTAR:
 		msr_info->data = svm->vmcb01.ptr->save.cstar;
 		break;
+	case MSR_GS_BASE:
+		msr_info->data = svm->vmcb01.ptr->save.gs.base;
+		break;
+	case MSR_FS_BASE:
+		msr_info->data = svm->vmcb01.ptr->save.fs.base;
+		break;
 	case MSR_KERNEL_GS_BASE:
 		msr_info->data = svm->vmcb01.ptr->save.kernel_gs_base;
 		break;
@@ -2982,6 +2988,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 	case MSR_CSTAR:
 		svm->vmcb01.ptr->save.cstar = data;
 		break;
+	case MSR_GS_BASE:
+		svm->vmcb01.ptr->save.gs.base = data;
+		break;
+	case MSR_FS_BASE:
+		svm->vmcb01.ptr->save.fs.base = data;
+		break;
 	case MSR_KERNEL_GS_BASE:
 		svm->vmcb01.ptr->save.kernel_gs_base = data;
 		break;
@@ -4960,6 +4972,9 @@ static __init void svm_set_cpu_caps(void)
 
 	/* CPUID 0x8000001F (SME/SEV features) */
 	sev_set_cpu_caps();
+
+	/* Don't advertise Bus Lock Detect to guest if SVM support is absent */
+	kvm_cpu_cap_clear(X86_FEATURE_BUS_LOCK_DETECT);
 }
 
 static __init int svm_hardware_setup(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 658a88483d8b..4e778ba6a5d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5747,7 +5747,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&events, argp, sizeof(struct kvm_vcpu_events)))
 			break;
 
+		kvm_vcpu_srcu_read_lock(vcpu);
 		r = kvm_vcpu_ioctl_x86_set_vcpu_events(vcpu, &events);
+		kvm_vcpu_srcu_read_unlock(vcpu);
 		break;
 	}
 	case KVM_GET_DEBUGREGS: {
diff --git a/arch/x86/lib/iomem.c b/arch/x86/lib/iomem.c
index e0411a3774d4..5eecb45d05d5 100644
--- a/arch/x86/lib/iomem.c
+++ b/arch/x86/lib/iomem.c
@@ -25,6 +25,9 @@ static __always_inline void rep_movs(void *to, const void *from, size_t n)
 
 static void string_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
+	const void *orig_to = to;
+	const size_t orig_n = n;
+
 	if (unlikely(!n))
 		return;
 
@@ -39,7 +42,7 @@ static void string_memcpy_fromio(void *to, const volatile void __iomem *from, si
 	}
 	rep_movs(to, (const void *)from, n);
 	/* KMSAN must treat values read from devices as initialized. */
-	kmsan_unpoison_memory(to, n);
+	kmsan_unpoison_memory(orig_to, orig_n);
 }
 
 static void string_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3f040c6e5d13..6d294d24e488 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -950,8 +950,12 @@ static void update_end_of_memory_vars(u64 start, u64 size)
 int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	      struct mhp_params *params)
 {
+	unsigned long end = ((start_pfn + nr_pages) << PAGE_SHIFT) - 1;
 	int ret;
 
+	if (WARN_ON_ONCE(end > PHYSMEM_END))
+		return -ERANGE;
+
 	ret = __add_pages(nid, start_pfn, nr_pages, params);
 	WARN_ON_ONCE(ret);
 
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 37db264866b6..230f1dee4f09 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -47,13 +47,24 @@ static const unsigned long vaddr_end = CPU_ENTRY_AREA_BASE;
  */
 static __initdata struct kaslr_memory_region {
 	unsigned long *base;
+	unsigned long *end;
 	unsigned long size_tb;
 } kaslr_regions[] = {
-	{ &page_offset_base, 0 },
-	{ &vmalloc_base, 0 },
-	{ &vmemmap_base, 0 },
+	{
+		.base	= &page_offset_base,
+		.end	= &physmem_end,
+	},
+	{
+		.base	= &vmalloc_base,
+	},
+	{
+		.base	= &vmemmap_base,
+	},
 };
 
+/* The end of the possible address space for physical memory */
+unsigned long physmem_end __ro_after_init;
+
 /* Get size in bytes used by the memory region */
 static inline unsigned long get_padding(struct kaslr_memory_region *region)
 {
@@ -82,6 +93,8 @@ void __init kernel_randomize_memory(void)
 	BUILD_BUG_ON(vaddr_end != CPU_ENTRY_AREA_BASE);
 	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
 
+	/* Preset the end of the possible address space for physical memory */
+	physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
 	if (!kaslr_memory_enabled())
 		return;
 
@@ -128,11 +141,18 @@ void __init kernel_randomize_memory(void)
 		vaddr += entropy;
 		*kaslr_regions[i].base = vaddr;
 
+		/* Calculate the end of the region */
+		vaddr += get_padding(&kaslr_regions[i]);
 		/*
-		 * Jump the region and add a minimum padding based on
-		 * randomization alignment.
+		 * KASLR trims the maximum possible size of the
+		 * direct-map. Update the physmem_end boundary.
+		 * No rounding required as the region starts
+		 * PUD aligned and size is in units of TB.
 		 */
-		vaddr += get_padding(&kaslr_regions[i]);
+		if (kaslr_regions[i].end)
+			*kaslr_regions[i].end = __pa_nodebug(vaddr - 1);
+
+		/* Add a minimum padding based on randomization alignment. */
 		vaddr = round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -= entropy;
 	}
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 7b804c34c020..d5f702ea4c78 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -241,7 +241,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
  *
  * Returns a pointer to a PTE on success, or NULL on failure.
  */
-static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
+static pte_t *pti_user_pagetable_walk_pte(unsigned long address, bool late_text)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	pmd_t *pmd;
@@ -251,10 +251,15 @@ static pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 	if (!pmd)
 		return NULL;
 
-	/* We can't do anything sensible if we hit a large mapping. */
+	/* Large PMD mapping found */
 	if (pmd_large(*pmd)) {
-		WARN_ON(1);
-		return NULL;
+		/* Clear the PMD if we hit a large mapping from the first round */
+		if (late_text) {
+			set_pmd(pmd, __pmd(0));
+		} else {
+			WARN_ON_ONCE(1);
+			return NULL;
+		}
 	}
 
 	if (pmd_none(*pmd)) {
@@ -283,7 +288,7 @@ static void __init pti_setup_vsyscall(void)
 	if (!pte || WARN_ON(level != PG_LEVEL_4K) || pte_none(*pte))
 		return;
 
-	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR);
+	target_pte = pti_user_pagetable_walk_pte(VSYSCALL_ADDR, false);
 	if (WARN_ON(!target_pte))
 		return;
 
@@ -301,7 +306,7 @@ enum pti_clone_level {
 
 static void
 pti_clone_pgtable(unsigned long start, unsigned long end,
-		  enum pti_clone_level level)
+		  enum pti_clone_level level, bool late_text)
 {
 	unsigned long addr;
 
@@ -390,7 +395,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 				return;
 
 			/* Allocate PTE in the user page-table */
-			target_pte = pti_user_pagetable_walk_pte(addr);
+			target_pte = pti_user_pagetable_walk_pte(addr, late_text);
 			if (WARN_ON(!target_pte))
 				return;
 
@@ -452,7 +457,7 @@ static void __init pti_clone_user_shared(void)
 		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
 		pte_t *target_pte;
 
-		target_pte = pti_user_pagetable_walk_pte(va);
+		target_pte = pti_user_pagetable_walk_pte(va, false);
 		if (WARN_ON(!target_pte))
 			return;
 
@@ -475,7 +480,7 @@ static void __init pti_clone_user_shared(void)
 	start = CPU_ENTRY_AREA_BASE;
 	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
 
-	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
+	pti_clone_pgtable(start, end, PTI_CLONE_PMD, false);
 }
 #endif /* CONFIG_X86_64 */
 
@@ -492,11 +497,11 @@ static void __init pti_setup_espfix64(void)
 /*
  * Clone the populated PMDs of the entry text and force it RO.
  */
-static void pti_clone_entry_text(void)
+static void pti_clone_entry_text(bool late)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_LEVEL_KERNEL_IMAGE);
+			  PTI_LEVEL_KERNEL_IMAGE, late);
 }
 
 /*
@@ -571,7 +576,7 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
+	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE, false);
 
 	/*
 	 * pti_clone_pgtable() will set the global bit in any PMDs
@@ -638,8 +643,15 @@ void __init pti_init(void)
 
 	/* Undo all global bits from the init pagetables in head_64.S: */
 	pti_set_kernel_image_nonglobal();
+
 	/* Replace some of the global bits just for shared entry text: */
-	pti_clone_entry_text();
+	/*
+	 * This is very early in boot. Device and Late initcalls can do
+	 * modprobe before free_initmem() and mark_readonly(). This
+	 * pti_clone_entry_text() allows those user-mode-helpers to function,
+	 * but notably the text is still RW.
+	 */
+	pti_clone_entry_text(false);
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
 }
@@ -656,10 +668,11 @@ void pti_finalize(void)
 	if (!boot_cpu_has(X86_FEATURE_PTI))
 		return;
 	/*
-	 * We need to clone everything (again) that maps parts of the
-	 * kernel image.
+	 * This is after free_initmem() (all initcalls are done) and we've done
+	 * mark_readonly(). Text is now NX which might've split some PMDs
+	 * relative to the early clone.
 	 */
-	pti_clone_entry_text();
+	pti_clone_entry_text(true);
 	pti_clone_kernel_text();
 
 	debug_checkwx_user();
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 6737b1cbf6d6..8bd5c4fa91f2 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -373,7 +373,7 @@ static int acpi_processor_add(struct acpi_device *device,
 
 	result = acpi_processor_get_info(device);
 	if (result) /* Processor is not physically present or unavailable */
-		return 0;
+		goto err_clear_driver_data;
 
 	BUG_ON(pr->id >= nr_cpu_ids);
 
@@ -388,7 +388,7 @@ static int acpi_processor_add(struct acpi_device *device,
 			"BIOS reported wrong ACPI id %d for the processor\n",
 			pr->id);
 		/* Give up, but do not abort the namespace scan. */
-		goto err;
+		goto err_clear_driver_data;
 	}
 	/*
 	 * processor_device_array is not cleared on errors to allow buggy BIOS
@@ -400,12 +400,12 @@ static int acpi_processor_add(struct acpi_device *device,
 	dev = get_cpu_device(pr->id);
 	if (!dev) {
 		result = -ENODEV;
-		goto err;
+		goto err_clear_per_cpu;
 	}
 
 	result = acpi_bind_one(dev, device);
 	if (result)
-		goto err;
+		goto err_clear_per_cpu;
 
 	pr->dev = dev;
 
@@ -416,10 +416,11 @@ static int acpi_processor_add(struct acpi_device *device,
 	dev_err(dev, "Processor driver could not be attached\n");
 	acpi_unbind_one(dev);
 
- err:
-	free_cpumask_var(pr->throttling.shared_cpu_map);
-	device->driver_data = NULL;
+ err_clear_per_cpu:
 	per_cpu(processors, pr->id) = NULL;
+ err_clear_driver_data:
+	device->driver_data = NULL;
+	free_cpumask_var(pr->throttling.shared_cpu_map);
  err_free_pr:
 	kfree(pr);
 	return result;
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e0ef648df265..931aa2609f3b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3329,6 +3329,7 @@ static void binder_transaction(struct binder_proc *proc,
 		 */
 		copy_size = object_offset - user_offset;
 		if (copy_size && (user_offset > object_offset ||
+				object_offset > tr->data_size ||
 				binder_alloc_copy_user_to_buffer(
 					&target_proc->alloc,
 					t->buffer, user_offset,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 826d9a102a51..14bcfebf20b8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5532,8 +5532,10 @@ struct ata_host *ata_host_alloc(struct device *dev, int max_ports)
 	}
 
 	dr = devres_alloc(ata_devres_release, 0, GFP_KERNEL);
-	if (!dr)
+	if (!dr) {
+		kfree(host);
 		goto err_out;
+	}
 
 	devres_add(dev, dr);
 	dev_set_drvdata(dev, host);
diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 9ccaac9e2bc3..f19ede2965a1 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -540,7 +540,8 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 
 		while (sg_len) {
 			/* table overflow should never happen */
-			BUG_ON (pi++ >= MAX_DCMDS);
+			if (WARN_ON_ONCE(pi >= MAX_DCMDS))
+				return AC_ERR_SYSTEM;
 
 			len = (sg_len < MAX_DBDMA_SEG) ? sg_len : MAX_DBDMA_SEG;
 			table->command = cpu_to_le16(write ? OUTPUT_MORE: INPUT_MORE);
@@ -552,11 +553,13 @@ static enum ata_completion_errors pata_macio_qc_prep(struct ata_queued_cmd *qc)
 			addr += len;
 			sg_len -= len;
 			++table;
+			++pi;
 		}
 	}
 
 	/* Should never happen according to Tejun */
-	BUG_ON(!pi);
+	if (WARN_ON_ONCE(!pi))
+		return AC_ERR_SYSTEM;
 
 	/* Convert the last command to an input/output */
 	table--;
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index f9add2ecdc55..35d1e2864696 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -564,6 +564,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3fa74051f31b..bfd643856f64 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1915,6 +1915,8 @@ static int ublk_ctrl_start_recovery(struct ublk_device *ub,
 	mutex_lock(&ub->mutex);
 	if (!ublk_can_use_recovery(ub))
 		goto out_unlock;
+	if (!ub->nr_queues_ready)
+		goto out_unlock;
 	/*
 	 * START_RECOVERY is only allowd after:
 	 *
diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 1973d79c9465..391b8da8849b 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -40,7 +40,7 @@
 
 #define PLL_USER_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_USER_CTL])
 # define PLL_POST_DIV_SHIFT	8
-# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width, 0)
+# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width - 1, 0)
 # define PLL_ALPHA_EN		BIT(24)
 # define PLL_ALPHA_MODE		BIT(25)
 # define PLL_VCO_SHIFT		20
@@ -1421,8 +1421,8 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	return regmap_update_bits(regmap, PLL_USER_CTL(pll),
-				  PLL_POST_DIV_MASK(pll) << PLL_POST_DIV_SHIFT,
-				  val << PLL_POST_DIV_SHIFT);
+				  PLL_POST_DIV_MASK(pll) << pll->post_div_shift,
+				  val << pll->post_div_shift);
 }
 
 const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index bd64a8a8427f..92c025b70eb6 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -83,20 +83,28 @@ static u64 notrace tpm_read_sched_clock(void)
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)
 {
-	unsigned long next, now;
+	unsigned long next, prev, now;
 
-	next = tpm_read_counter();
-	next += delta;
+	prev = tpm_read_counter();
+	next = prev + delta;
 	writel(next, timer_base + TPM_C0V);
 	now = tpm_read_counter();
 
+	/*
+	 * Need to wait CNT increase at least 1 cycle to make sure
+	 * the C0V has been updated into HW.
+	 */
+	if ((next & 0xffffffff) != readl(timer_base + TPM_C0V))
+		while (now == tpm_read_counter())
+			;
+
 	/*
 	 * NOTE: We observed in a very small probability, the bus fabric
 	 * contention between GPU and A7 may results a few cycles delay
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)(next - now) <= 0 ? -ETIME : 0;
+	return (now - prev) >= delta ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index c3f54d9912be..420202bf76e4 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -25,10 +25,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
 
 	struct clock_event_device *clkevt = &to->clkevt;
 
-	if (of_irq->percpu)
-		free_percpu_irq(of_irq->irq, clkevt);
-	else
-		free_irq(of_irq->irq, clkevt);
+	free_irq(of_irq->irq, clkevt);
 }
 
 /**
@@ -42,9 +39,6 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
  * - Get interrupt number by name
  * - Get interrupt number by index
  *
- * When the interrupt is per CPU, 'request_percpu_irq()' is called,
- * otherwise 'request_irq()' is used.
- *
  * Returns 0 on success, < 0 otherwise
  */
 static __init int timer_of_irq_init(struct device_node *np,
@@ -69,12 +63,9 @@ static __init int timer_of_irq_init(struct device_node *np,
 		return -EINVAL;
 	}
 
-	ret = of_irq->percpu ?
-		request_percpu_irq(of_irq->irq, of_irq->handler,
-				   np->full_name, clkevt) :
-		request_irq(of_irq->irq, of_irq->handler,
-			    of_irq->flags ? of_irq->flags : IRQF_TIMER,
-			    np->full_name, clkevt);
+	ret = request_irq(of_irq->irq, of_irq->handler,
+			  of_irq->flags ? of_irq->flags : IRQF_TIMER,
+			  np->full_name, clkevt);
 	if (ret) {
 		pr_err("Failed to request irq %d for %pOF\n", of_irq->irq, np);
 		return ret;
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3e8589..01a2c6b7db06 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -11,7 +11,6 @@
 struct of_timer_irq {
 	int irq;
 	int index;
-	int percpu;
 	const char *name;
 	unsigned long flags;
 	irq_handler_t handler;
diff --git a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
index 70ef11963938..43af81fcab86 100644
--- a/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
+++ b/drivers/crypto/qat/qat_common/adf_gen2_pfvf.c
@@ -100,7 +100,9 @@ static u32 adf_gen2_disable_pending_vf2pf_interrupts(void __iomem *pmisc_addr)
 	errmsk3 |= ADF_GEN2_ERR_MSK_VF2PF(ADF_GEN2_VF_MSK);
 	ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK3, errmsk3);
 
-	errmsk3 &= ADF_GEN2_ERR_MSK_VF2PF(sources | disabled);
+	/* Update only section of errmsk3 related to VF2PF */
+	errmsk3 &= ~ADF_GEN2_ERR_MSK_VF2PF(ADF_GEN2_VF_MSK);
+	errmsk3 |= ADF_GEN2_ERR_MSK_VF2PF(sources | disabled);
 	ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK3, errmsk3);
 
 	/* Return the sources of the (new) interrupt(s) */
diff --git a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
index cb3bdd3618fb..85295c7ee0e0 100644
--- a/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
+++ b/drivers/crypto/qat/qat_dh895xcc/adf_dh895xcc_hw_data.c
@@ -180,8 +180,12 @@ static u32 disable_pending_vf2pf_interrupts(void __iomem *pmisc_addr)
 	ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK3, errmsk3);
 	ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK5, errmsk5);
 
-	errmsk3 &= ADF_DH895XCC_ERR_MSK_VF2PF_L(sources | disabled);
-	errmsk5 &= ADF_DH895XCC_ERR_MSK_VF2PF_U(sources | disabled);
+	/* Update only section of errmsk3 and errmsk5 related to VF2PF */
+	errmsk3 &= ~ADF_DH895XCC_ERR_MSK_VF2PF_L(ADF_DH895XCC_VF_MSK);
+	errmsk5 &= ~ADF_DH895XCC_ERR_MSK_VF2PF_U(ADF_DH895XCC_VF_MSK);
+
+	errmsk3 |= ADF_DH895XCC_ERR_MSK_VF2PF_L(sources | disabled);
+	errmsk5 |= ADF_DH895XCC_ERR_MSK_VF2PF_U(sources | disabled);
 	ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK3, errmsk3);
 	ADF_CSR_WR(pmisc_addr, ADF_GEN2_ERRMSK5, errmsk5);
 
diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 68005cce0136..cf4f4da0cb87 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -764,6 +764,9 @@ int cs_dsp_coeff_write_ctrl(struct cs_dsp_coeff_ctl *ctl,
 
 	lockdep_assert_held(&ctl->dsp->pwr_lock);
 
+	if (ctl->flags && !(ctl->flags & WMFW_CTL_FLAG_WRITEABLE))
+		return -EPERM;
+
 	if (len + off * sizeof(u32) > ctl->len)
 		return -EINVAL;
 
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 200e43a6f4b4..3c1e303aaca8 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -713,6 +713,7 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	pctldev = of_pinctrl_get(pctlnp);
+	of_node_put(pctlnp);
 	if (!pctldev)
 		return -EPROBE_DEFER;
 
diff --git a/drivers/gpio/gpio-zynqmp-modepin.c b/drivers/gpio/gpio-zynqmp-modepin.c
index a0d69387c153..2f3c9ebfa78d 100644
--- a/drivers/gpio/gpio-zynqmp-modepin.c
+++ b/drivers/gpio/gpio-zynqmp-modepin.c
@@ -146,6 +146,7 @@ static const struct of_device_id modepin_platform_id[] = {
 	{ .compatible = "xlnx,zynqmp-gpio-modepin", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, modepin_platform_id);
 
 static struct platform_driver modepin_platform_driver = {
 	.driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index aabde6ebb190..cd0bccc95205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -873,8 +873,7 @@ static int check_tiling_flags_gfx6(struct amdgpu_framebuffer *afb)
 {
 	u64 micro_tile_mode;
 
-	/* Zero swizzle mode means linear */
-	if (AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0)
+	if (AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) == 1) /* LINEAR_ALIGNED */
 		return 0;
 
 	micro_tile_mode = AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE);
@@ -998,6 +997,30 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 			block_width = 256 / format_info->cpp[i];
 			block_height = 1;
 			block_size_log2 = 8;
+		} else if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) >= AMD_FMT_MOD_TILE_VER_GFX12) {
+			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
+
+			switch (swizzle) {
+			case AMD_FMT_MOD_TILE_GFX12_256B_2D:
+				block_size_log2 = 8;
+				break;
+			case AMD_FMT_MOD_TILE_GFX12_4K_2D:
+				block_size_log2 = 12;
+				break;
+			case AMD_FMT_MOD_TILE_GFX12_64K_2D:
+				block_size_log2 = 16;
+				break;
+			case AMD_FMT_MOD_TILE_GFX12_256K_2D:
+				block_size_log2 = 18;
+				break;
+			default:
+				drm_dbg_kms(rfb->base.dev,
+					    "Gfx12 swizzle mode with unknown block size: %d\n", swizzle);
+				return -EINVAL;
+			}
+
+			get_block_dimensions(block_size_log2, format_info->cpp[i],
+					     &block_width, &block_height);
 		} else {
 			int swizzle = AMD_FMT_MOD_GET(TILE, modifier);
 
@@ -1033,7 +1056,8 @@ static int amdgpu_display_verify_sizes(struct amdgpu_framebuffer *rfb)
 			return ret;
 	}
 
-	if (AMD_FMT_MOD_GET(DCC, modifier)) {
+	if (AMD_FMT_MOD_GET(TILE_VERSION, modifier) <= AMD_FMT_MOD_TILE_VER_GFX11 &&
+	    AMD_FMT_MOD_GET(DCC, modifier)) {
 		if (AMD_FMT_MOD_GET(DCC_RETILE, modifier)) {
 			block_size_log2 = get_dcc_block_size(modifier, false, false);
 			get_block_dimensions(block_size_log2 + 8, format_info->cpp[0],
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index af50e6ce39e1..d7b76a3d2d55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -132,8 +132,10 @@ int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init)
 
 	if (virt->ops && virt->ops->req_full_gpu) {
 		r = virt->ops->req_full_gpu(adev, init);
-		if (r)
+		if (r) {
+			adev->no_hw_access = true;
 			return r;
+		}
 
 		adev->virt.caps &= ~AMDGPU_SRIOV_CAPS_RUNTIME;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1f9f7fdd4b8e..c76895cca4d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4330,11 +4330,11 @@ static int gfx_v11_0_hw_init(void *handle)
 			/* RLC autoload sequence 1: Program rlc ram */
 			if (adev->gfx.imu.funcs->program_rlc_ram)
 				adev->gfx.imu.funcs->program_rlc_ram(adev);
+			/* rlc autoload firmware */
+			r = gfx_v11_0_rlc_backdoor_autoload_enable(adev);
+			if (r)
+				return r;
 		}
-		/* rlc autoload firmware */
-		r = gfx_v11_0_rlc_backdoor_autoload_enable(adev);
-		if (r)
-			return r;
 	} else {
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
 			if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 657e4ca6f9dd..fccbec438bbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -135,6 +135,34 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
 
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
+
+	if (enable) {
+		/* Unset the CLEAR_OVERFLOW bit to make sure the next step
+		 * is switching the bit from 0 to 1
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Clear RB_OVERFLOW bit */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	}
+
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0be1a1149a3f..393e32259a77 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6767,7 +6767,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 			}
 		}
 
-		if (j == dc_state->stream_count)
+		if (j == dc_state->stream_count || pbn_div == 0)
 			continue;
 
 		slot_num = DIV_ROUND_UP(pbn, pbn_div);
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 1ddb4f5eac8e..93c0455766dd 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -433,17 +433,20 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 	}
 
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
+		if (!mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
 				&input->bstatus_read, &status,
-				hdcp, "bstatus_read");
+				hdcp, "bstatus_read"))
+			goto out;
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(check_link_integrity_dp,
+		if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
 				&input->link_integrity_check, &status,
-				hdcp, "link_integrity_check");
+				hdcp, "link_integrity_check"))
+			goto out;
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
+		if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
 				&input->reauth_request_check, &status,
-				hdcp, "reauth_request_check");
+				hdcp, "reauth_request_check"))
+			goto out;
 out:
 	return status;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5d193872fd1a..dfd653e1b6ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1871,7 +1871,8 @@ static int smu_adjust_power_state_dynamic(struct smu_context *smu,
 		smu_dpm_ctx->dpm_level = level;
 	}
 
-	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
+	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
+		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM) {
 		index = fls(smu->workload_mask);
 		index = index > 0 && index <= WORKLOAD_POLICY_MAX ? index - 1 : 0;
 		workload[0] = smu->workload_setting[index];
@@ -1950,7 +1951,8 @@ static int smu_switch_power_profile(void *handle,
 		workload[0] = smu->workload_setting[index];
 	}
 
-	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
+	if (smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL &&
+		smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM)
 		smu_bump_power_profile_mode(smu, workload, 0);
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 6fc0d1b89690..e664f8e461e6 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -51,7 +51,7 @@ static inline void debug_fence_init(struct i915_sw_fence *fence)
 	debug_object_init(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_init_onstack(struct i915_sw_fence *fence)
 {
 	debug_object_init_on_stack(fence, &i915_sw_fence_debug_descr);
 }
@@ -77,7 +77,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 	debug_object_destroy(fence, &i915_sw_fence_debug_descr);
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 	debug_object_free(fence, &i915_sw_fence_debug_descr);
 	smp_wmb(); /* flush the change in state before reallocation */
@@ -94,7 +94,7 @@ static inline void debug_fence_init(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_init_onstack(struct i915_sw_fence *fence)
 {
 }
 
@@ -115,7 +115,7 @@ static inline void debug_fence_destroy(struct i915_sw_fence *fence)
 {
 }
 
-static inline void debug_fence_free(struct i915_sw_fence *fence)
+static inline __maybe_unused void debug_fence_free(struct i915_sw_fence *fence)
 {
 }
 
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
index 1b18291fc5af..d682b99c25b1 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_hid.c
@@ -171,11 +171,13 @@ int amdtp_hid_probe(u32 cur_hid_dev, struct amdtp_cl_data *cli_data)
 void amdtp_hid_remove(struct amdtp_cl_data *cli_data)
 {
 	int i;
+	struct amdtp_hid_data *hid_data;
 
 	for (i = 0; i < cli_data->num_hid_devices; ++i) {
 		if (cli_data->hid_sensor_hubs[i]) {
-			kfree(cli_data->hid_sensor_hubs[i]->driver_data);
+			hid_data = cli_data->hid_sensor_hubs[i]->driver_data;
 			hid_destroy_device(cli_data->hid_sensor_hubs[i]);
+			kfree(hid_data);
 			cli_data->hid_sensor_hubs[i] = NULL;
 		}
 	}
diff --git a/drivers/hid/hid-cougar.c b/drivers/hid/hid-cougar.c
index cb8bd8aae15b..0fa785f52707 100644
--- a/drivers/hid/hid-cougar.c
+++ b/drivers/hid/hid-cougar.c
@@ -106,7 +106,7 @@ static void cougar_fix_g6_mapping(void)
 static __u8 *cougar_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				 unsigned int *rsize)
 {
-	if (rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
+	if (*rsize >= 117 && rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
 	    (rdesc[115] | rdesc[116] << 8) >= HID_MAX_USAGES) {
 		hid_info(hdev,
 			"usage count exceeds max: fixing up report descriptor\n");
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e9c3f1e826ba..a2191bc5c153 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1977,6 +1977,7 @@ static umode_t vmbus_chan_attr_is_visible(struct kobject *kobj,
 
 	return attr->mode;
 }
+EXPORT_SYMBOL_GPL(vmbus_device_unregister);
 
 static struct attribute_group vmbus_chan_group = {
 	.attrs = vmbus_chan_attrs,
diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
index 97b330b6c165..bad2d39d9733 100644
--- a/drivers/hwmon/adc128d818.c
+++ b/drivers/hwmon/adc128d818.c
@@ -176,7 +176,7 @@ static ssize_t adc128_in_store(struct device *dev,
 
 	mutex_lock(&data->update_lock);
 	/* 10 mV LSB on limit registers */
-	regval = clamp_val(DIV_ROUND_CLOSEST(val, 10), 0, 255);
+	regval = DIV_ROUND_CLOSEST(clamp_val(val, 0, 2550), 10);
 	data->in[index][nr] = regval << 4;
 	reg = index == 1 ? ADC128_REG_IN_MIN(nr) : ADC128_REG_IN_MAX(nr);
 	i2c_smbus_write_byte_data(data->client, reg, regval);
@@ -214,7 +214,7 @@ static ssize_t adc128_temp_store(struct device *dev,
 		return err;
 
 	mutex_lock(&data->update_lock);
-	regval = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	regval = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
 	data->temp[index] = regval << 1;
 	i2c_smbus_write_byte_data(data->client,
 				  index == 1 ? ADC128_REG_TEMP_MAX
diff --git a/drivers/hwmon/lm95234.c b/drivers/hwmon/lm95234.c
index b4a9d0c223c4..db570fe84132 100644
--- a/drivers/hwmon/lm95234.c
+++ b/drivers/hwmon/lm95234.c
@@ -301,7 +301,8 @@ static ssize_t tcrit2_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, index ? 255 : 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, (index ? 255 : 127) * 1000),
+				1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit2[index] = val;
@@ -350,7 +351,7 @@ static ssize_t tcrit1_store(struct device *dev, struct device_attribute *attr,
 	if (ret < 0)
 		return ret;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 255);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 255000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->tcrit1[index] = val;
@@ -391,7 +392,7 @@ static ssize_t tcrit1_hyst_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	val = DIV_ROUND_CLOSEST(val, 1000);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -255000, 255000), 1000);
 	val = clamp_val((int)data->tcrit1[index] - val, 0, 31);
 
 	mutex_lock(&data->update_lock);
@@ -431,7 +432,7 @@ static ssize_t offset_store(struct device *dev, struct device_attribute *attr,
 		return ret;
 
 	/* Accuracy is 1/2 degrees C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 500), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -64000, 63500), 500);
 
 	mutex_lock(&data->update_lock);
 	data->toffset[index] = val;
diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 9720ad214c20..83e424945b59 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -2171,7 +2171,7 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), -128, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, -128000, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = val;
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 939d4c35e713..66d71aba4171 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -895,7 +895,7 @@ store_target_temp(struct device *dev, struct device_attribute *attr,
 	if (err < 0)
 		return err;
 
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 127);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 127000), 1000);
 
 	mutex_lock(&data->update_lock);
 	data->target_temp[nr] = val;
@@ -920,7 +920,7 @@ store_tolerance(struct device *dev, struct device_attribute *attr,
 		return err;
 
 	/* Limit the temp to 0C - 15C */
-	val = clamp_val(DIV_ROUND_CLOSEST(val, 1000), 0, 15);
+	val = DIV_ROUND_CLOSEST(clamp_val(val, 0, 15000), 1000);
 
 	mutex_lock(&data->update_lock);
 	reg = w83627ehf_read_value(data, W83627EHF_REG_TOLERANCE[nr]);
diff --git a/drivers/i3c/master/mipi-i3c-hci/dma.c b/drivers/i3c/master/mipi-i3c-hci/dma.c
index 337c95d43f3f..edc3a69bfe31 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dma.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dma.c
@@ -291,7 +291,10 @@ static int hci_dma_init(struct i3c_hci *hci)
 
 		rh->ibi_chunk_sz = dma_get_cache_alignment();
 		rh->ibi_chunk_sz *= IBI_CHUNK_CACHELINES;
-		BUG_ON(rh->ibi_chunk_sz > 256);
+		if (rh->ibi_chunk_sz > 256) {
+			ret = -EINVAL;
+			goto err_out;
+		}
 
 		ibi_status_ring_sz = rh->ibi_status_sz * rh->ibi_status_entries;
 		ibi_data_ring_sz = rh->ibi_chunk_sz * rh->ibi_chunks_total;
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 4088786e1026..deaf600d96fb 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -146,15 +146,18 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	bool live;
 	unsigned int cfg_slot;
-	enum ad7124_ref_sel refsel;
-	bool bipolar;
-	bool buf_positive;
-	bool buf_negative;
-	unsigned int vref_mv;
-	unsigned int pga_bits;
-	unsigned int odr;
-	unsigned int odr_sel_bits;
-	unsigned int filter_type;
+	/* Following fields are used to compare equality. */
+	struct_group(config_props,
+		enum ad7124_ref_sel refsel;
+		bool bipolar;
+		bool buf_positive;
+		bool buf_negative;
+		unsigned int vref_mv;
+		unsigned int pga_bits;
+		unsigned int odr;
+		unsigned int odr_sel_bits;
+		unsigned int filter_type;
+	);
 };
 
 struct ad7124_channel {
@@ -333,11 +336,12 @@ static struct ad7124_channel_config *ad7124_find_similar_live_cfg(struct ad7124_
 	ptrdiff_t cmp_size;
 	int i;
 
-	cmp_size = (u8 *)&cfg->live - (u8 *)cfg;
+	cmp_size = sizeof_field(struct ad7124_channel_config, config_props);
 	for (i = 0; i < st->num_channels; i++) {
 		cfg_aux = &st->channels[i].cfg;
 
-		if (cfg_aux->live && !memcmp(cfg, cfg_aux, cmp_size))
+		if (cfg_aux->live &&
+		    !memcmp(&cfg->config_props, &cfg_aux->config_props, cmp_size))
 			return cfg_aux;
 	}
 
@@ -761,6 +765,7 @@ static int ad7124_soft_reset(struct ad7124_state *st)
 	if (ret < 0)
 		return ret;
 
+	fsleep(200);
 	timeout = 100;
 	do {
 		ret = ad_sd_read_reg(&st->sd, AD7124_STATUS, 1, &readval);
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index ba24f99523e0..00df4fc5a51f 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -49,7 +49,7 @@ static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
-static int ad7606_reset(struct ad7606_state *st)
+int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
 		gpiod_set_value(st->gpio_reset, 1);
@@ -60,6 +60,7 @@ static int ad7606_reset(struct ad7606_state *st)
 
 	return -ENODEV;
 }
+EXPORT_SYMBOL_NS_GPL(ad7606_reset, IIO_AD7606);
 
 static int ad7606_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
@@ -88,31 +89,6 @@ static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels - 1;
 	u16 *data = st->data;
-	int ret;
-
-	/*
-	 * The frstdata signal is set to high while and after reading the sample
-	 * of the first channel and low for all other channels. This can be used
-	 * to check that the incoming data is correctly aligned. During normal
-	 * operation the data should never become unaligned, but some glitch or
-	 * electrostatic discharge might cause an extra read or clock cycle.
-	 * Monitoring the frstdata signal allows to recover from such failure
-	 * situations.
-	 */
-
-	if (st->gpio_frstdata) {
-		ret = st->bops->read_block(st->dev, 1, data);
-		if (ret)
-			return ret;
-
-		if (!gpiod_get_value(st->gpio_frstdata)) {
-			ad7606_reset(st);
-			return -EIO;
-		}
-
-		data++;
-		num--;
-	}
 
 	return st->bops->read_block(st->dev, num, data);
 }
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 2dc4f599f9df..9d8520b8bada 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -153,6 +153,8 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops);
 
+int ad7606_reset(struct ad7606_state *st);
+
 enum ad7606_supported_device_ids {
 	ID_AD7605_4,
 	ID_AD7606_8,
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index b912b4df9b56..0827d5535584 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -7,6 +7,7 @@
 
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/err.h>
@@ -21,8 +22,29 @@ static int ad7606_par16_read_block(struct device *dev,
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	insw((unsigned long)st->base_address, buf, count);
 
+	/*
+	 * On the parallel interface, the frstdata signal is set to high while
+	 * and after reading the sample of the first channel and low for all
+	 * other channels.  This can be used to check that the incoming data is
+	 * correctly aligned.  During normal operation the data should never
+	 * become unaligned, but some glitch or electrostatic discharge might
+	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
+	 * allows to recover from such failure situations.
+	 */
+	int num = count;
+	u16 *_buf = buf;
+
+	if (st->gpio_frstdata) {
+		insw((unsigned long)st->base_address, _buf, 1);
+		if (!gpiod_get_value(st->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+		_buf++;
+		num--;
+	}
+	insw((unsigned long)st->base_address, _buf, num);
 	return 0;
 }
 
@@ -35,8 +57,28 @@ static int ad7606_par8_read_block(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
-
-	insb((unsigned long)st->base_address, buf, count * 2);
+	/*
+	 * On the parallel interface, the frstdata signal is set to high while
+	 * and after reading the sample of the first channel and low for all
+	 * other channels.  This can be used to check that the incoming data is
+	 * correctly aligned.  During normal operation the data should never
+	 * become unaligned, but some glitch or electrostatic discharge might
+	 * cause an extra read or clock cycle.  Monitoring the frstdata signal
+	 * allows to recover from such failure situations.
+	 */
+	int num = count;
+	u16 *_buf = buf;
+
+	if (st->gpio_frstdata) {
+		insb((unsigned long)st->base_address, _buf, 2);
+		if (!gpiod_get_value(st->gpio_frstdata)) {
+			ad7606_reset(st);
+			return -EIO;
+		}
+		_buf++;
+		num--;
+	}
+	insb((unsigned long)st->base_address, _buf, num * 2);
 
 	return 0;
 }
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index f744b62a636a..3d2ccae1e58d 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -180,7 +180,7 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	ret = dma_get_slave_caps(chan, &caps);
 	if (ret < 0)
-		goto err_free;
+		goto err_release;
 
 	/* Needs to be aligned to the maximum of the minimums */
 	if (caps.src_addr_widths)
@@ -206,6 +206,8 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct device *dev,
 
 	return &dmaengine_buffer->queue.buffer;
 
+err_release:
+	dma_release_channel(chan);
 err_free:
 	kfree(dmaengine_buffer);
 	return ERR_PTR(ret);
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index bd854e92c6f8..81344ceac951 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -679,17 +679,17 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000LL);
 		break;
 	case IIO_VAL_INT_PLUS_NANO:
 		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val;
+			*processed = -raw64 * scale_val * scale;
 		else
-			*processed = raw64 * scale_val;
+			*processed = raw64 * scale_val * scale;
 		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
 				      1000000000LL);
 		break;
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index f2593133e524..790db3ceb208 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -416,6 +416,20 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 		return -EINVAL;
 	}
 
+	/*
+	 * Limit number of contacts to a reasonable value (100). This
+	 * ensures that we need less than 2 pages for struct input_mt
+	 * (we are not using in-kernel slot assignment so not going to
+	 * allocate memory for the "red" table), and we should have no
+	 * trouble getting this much memory.
+	 */
+	if (code == ABS_MT_SLOT && max > 99) {
+		printk(KERN_DEBUG
+		       "%s: unreasonably large number of slots requested: %d\n",
+		       UINPUT_NAME, max);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index e3a36cd3656c..8c8eea5173f7 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -586,7 +586,7 @@ static int ili251x_firmware_to_buffer(const struct firmware *fw,
 	 * once, copy them all into this buffer at the right locations, and then
 	 * do all operations on this linear buffer.
 	 */
-	fw_buf = kzalloc(SZ_64K, GFP_KERNEL);
+	fw_buf = kvmalloc(SZ_64K, GFP_KERNEL);
 	if (!fw_buf)
 		return -ENOMEM;
 
@@ -616,7 +616,7 @@ static int ili251x_firmware_to_buffer(const struct firmware *fw,
 	return 0;
 
 err_big:
-	kfree(fw_buf);
+	kvfree(fw_buf);
 	return error;
 }
 
@@ -859,7 +859,7 @@ static ssize_t ili210x_firmware_update_store(struct device *dev,
 	ili210x_hardware_reset(priv->reset_gpio);
 	dev_dbg(dev, "Firmware update ended, error=%i\n", error);
 	enable_irq(client->irq);
-	kfree(fwbuf);
+	kvfree(fwbuf);
 	return error;
 }
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 4759f79ad7b9..345c161ffb27 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1402,7 +1402,7 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
 	 */
 	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
 
-	while (qi->desc_status[wait_index] != QI_DONE) {
+	while (READ_ONCE(qi->desc_status[wait_index]) != QI_DONE) {
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
 		 * context to queue another cmd while a cmd is already submitted
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 5b585eace3d4..e8dc1a7d9491 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -449,6 +449,7 @@ static int sun50i_iommu_enable(struct sun50i_iommu *iommu)
 		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(3) |
 		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(4) |
 		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(5));
+	iommu_write(iommu, IOMMU_BYPASS_REG, 0);
 	iommu_write(iommu, IOMMU_INT_ENABLE_REG, IOMMU_INT_MASK);
 	iommu_write(iommu, IOMMU_DM_AUT_CTRL_REG(SUN50I_IOMMU_ACI_NONE),
 		    IOMMU_DM_AUT_CTRL_RD_UNAVAIL(SUN50I_IOMMU_ACI_NONE, 0) |
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index ee18eb3e72b7..ab02b44a3b4e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -567,6 +567,10 @@ static struct irq_chip armada_370_xp_irq_chip = {
 static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 				      unsigned int virq, irq_hw_number_t hw)
 {
+	/* IRQs 0 and 1 cannot be mapped, they are handled internally */
+	if (hw <= 1)
+		return -EINVAL;
+
 	armada_370_xp_irq_mask(irq_get_irq_data(virq));
 	if (!is_percpu_irq(hw))
 		writel(hw, per_cpu_int_base +
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 6e1ac330d7a6..414cd925064f 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -438,12 +438,12 @@ static int __init gicv2m_of_init(struct fwnode_handle *parent_handle,
 
 		ret = gicv2m_init_one(&child->fwnode, spi_start, nr_spis,
 				      &res, 0);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			break;
-		}
 	}
 
+	if (ret && child)
+		of_node_put(child);
 	if (!ret)
 		ret = gicv2m_allocate_domains(parent);
 	if (ret)
diff --git a/drivers/leds/leds-spi-byte.c b/drivers/leds/leds-spi-byte.c
index 2bc5c99daf51..6883d3ba382f 100644
--- a/drivers/leds/leds-spi-byte.c
+++ b/drivers/leds/leds-spi-byte.c
@@ -91,7 +91,6 @@ static int spi_byte_probe(struct spi_device *spi)
 		dev_err(dev, "Device must have exactly one LED sub-node.");
 		return -EINVAL;
 	}
-	child = of_get_next_available_child(dev_of_node(dev), NULL);
 
 	led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 	if (!led)
@@ -107,11 +106,13 @@ static int spi_byte_probe(struct spi_device *spi)
 	led->ldev.max_brightness = led->cdef->max_value - led->cdef->off_value;
 	led->ldev.brightness_set_blocking = spi_byte_brightness_set_blocking;
 
+	child = of_get_next_available_child(dev_of_node(dev), NULL);
 	state = of_get_property(child, "default-state", NULL);
 	if (state) {
 		if (!strcmp(state, "on")) {
 			led->ldev.brightness = led->ldev.max_brightness;
 		} else if (strcmp(state, "off")) {
+			of_node_put(child);
 			/* all other cases except "off" */
 			dev_err(dev, "default-state can only be 'on' or 'off'");
 			return -EINVAL;
@@ -122,9 +123,12 @@ static int spi_byte_probe(struct spi_device *spi)
 
 	ret = devm_led_classdev_register(&spi->dev, &led->ldev);
 	if (ret) {
+		of_node_put(child);
 		mutex_destroy(&led->mutex);
 		return ret;
 	}
+
+	of_node_put(child);
 	spi_set_drvdata(spi, led);
 
 	return 0;
diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index dc4381d68313..6e9e73a55874 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -213,8 +213,10 @@ static char __init *dm_parse_device_entry(struct dm_device *dev, char *str)
 	strscpy(dev->dmi.uuid, field[1], sizeof(dev->dmi.uuid));
 	/* minor */
 	if (strlen(field[2])) {
-		if (kstrtoull(field[2], 0, &dev->dmi.dev))
+		if (kstrtoull(field[2], 0, &dev->dmi.dev) ||
+		    dev->dmi.dev >= (1 << MINORBITS))
 			return ERR_PTR(-EINVAL);
+		dev->dmi.dev = huge_encode_dev((dev_t)dev->dmi.dev);
 		dev->dmi.flags |= DM_PERSISTENT_DEV_FLAG;
 	}
 	/* flags */
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index a30461de3e84..d173ac80e01c 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1038,8 +1038,11 @@ static int camss_of_parse_endpoint_node(struct device *dev,
 	struct v4l2_mbus_config_mipi_csi2 *mipi_csi2;
 	struct v4l2_fwnode_endpoint vep = { { 0 } };
 	unsigned int i;
+	int ret;
 
-	v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(node), &vep);
+	if (ret)
+		return ret;
 
 	csd->interface.csiphy_id = vep.base.port;
 
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index c0999581c599..3864df45077d 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -113,8 +113,9 @@ static int vid_cap_queue_setup(struct vb2_queue *vq,
 		if (*nplanes != buffers)
 			return -EINVAL;
 		for (p = 0; p < buffers; p++) {
-			if (sizes[p] < tpg_g_line_width(&dev->tpg, p) * h +
-						dev->fmt_cap->data_offset[p])
+			if (sizes[p] < tpg_g_line_width(&dev->tpg, p) * h /
+					dev->fmt_cap->vdownsampling[p] +
+					dev->fmt_cap->data_offset[p])
 				return -EINVAL;
 		}
 	} else {
@@ -1809,8 +1810,10 @@ int vidioc_s_edid(struct file *file, void *_fh,
 		return -EINVAL;
 	if (edid->blocks == 0) {
 		dev->edid_blocks = 0;
-		v4l2_ctrl_s_ctrl(dev->ctrl_tx_edid_present, 0);
-		v4l2_ctrl_s_ctrl(dev->ctrl_tx_hotplug, 0);
+		if (dev->num_outputs) {
+			v4l2_ctrl_s_ctrl(dev->ctrl_tx_edid_present, 0);
+			v4l2_ctrl_s_ctrl(dev->ctrl_tx_hotplug, 0);
+		}
 		phys_addr = CEC_PHYS_ADDR_INVALID;
 		goto set_phys_addr;
 	}
@@ -1834,8 +1837,10 @@ int vidioc_s_edid(struct file *file, void *_fh,
 			display_present |=
 				dev->display_present[i] << j++;
 
-	v4l2_ctrl_s_ctrl(dev->ctrl_tx_edid_present, display_present);
-	v4l2_ctrl_s_ctrl(dev->ctrl_tx_hotplug, display_present);
+	if (dev->num_outputs) {
+		v4l2_ctrl_s_ctrl(dev->ctrl_tx_edid_present, display_present);
+		v4l2_ctrl_s_ctrl(dev->ctrl_tx_hotplug, display_present);
+	}
 
 set_phys_addr:
 	/* TODO: a proper hotplug detect cycle should be emulated here */
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-out.c b/drivers/media/test-drivers/vivid/vivid-vid-out.c
index 9f731f085179..e96d3d014143 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-out.c
@@ -63,14 +63,16 @@ static int vid_out_queue_setup(struct vb2_queue *vq,
 		if (sizes[0] < size)
 			return -EINVAL;
 		for (p = 1; p < planes; p++) {
-			if (sizes[p] < dev->bytesperline_out[p] * h +
-				       vfmt->data_offset[p])
+			if (sizes[p] < dev->bytesperline_out[p] * h /
+					vfmt->vdownsampling[p] +
+					vfmt->data_offset[p])
 				return -EINVAL;
 		}
 	} else {
 		for (p = 0; p < planes; p++)
-			sizes[p] = p ? dev->bytesperline_out[p] * h +
-				       vfmt->data_offset[p] : size;
+			sizes[p] = p ? dev->bytesperline_out[p] * h /
+					vfmt->vdownsampling[p] +
+					vfmt->data_offset[p] : size;
 	}
 
 	if (vq->num_buffers + *nbuffers < 2)
@@ -127,7 +129,7 @@ static int vid_out_buf_prepare(struct vb2_buffer *vb)
 
 	for (p = 0; p < planes; p++) {
 		if (p)
-			size = dev->bytesperline_out[p] * h;
+			size = dev->bytesperline_out[p] * h / vfmt->vdownsampling[p];
 		size += vb->planes[p].data_offset;
 
 		if (vb2_get_plane_payload(vb, p) < size) {
@@ -334,8 +336,8 @@ int vivid_g_fmt_vid_out(struct file *file, void *priv,
 	for (p = 0; p < mp->num_planes; p++) {
 		mp->plane_fmt[p].bytesperline = dev->bytesperline_out[p];
 		mp->plane_fmt[p].sizeimage =
-			mp->plane_fmt[p].bytesperline * mp->height +
-			fmt->data_offset[p];
+			mp->plane_fmt[p].bytesperline * mp->height /
+			fmt->vdownsampling[p] + fmt->data_offset[p];
 	}
 	for (p = fmt->buffers; p < fmt->planes; p++) {
 		unsigned stride = dev->bytesperline_out[p];
diff --git a/drivers/misc/vmw_vmci/vmci_resource.c b/drivers/misc/vmw_vmci/vmci_resource.c
index 692daa9eff34..19c9d2cdd277 100644
--- a/drivers/misc/vmw_vmci/vmci_resource.c
+++ b/drivers/misc/vmw_vmci/vmci_resource.c
@@ -144,7 +144,8 @@ void vmci_resource_remove(struct vmci_resource *resource)
 	spin_lock(&vmci_resource_table.lock);
 
 	hlist_for_each_entry(r, &vmci_resource_table.entries[idx], node) {
-		if (vmci_handle_is_equal(r->handle, resource->handle)) {
+		if (vmci_handle_is_equal(r->handle, resource->handle) &&
+		    resource->type == r->type) {
 			hlist_del_init_rcu(&r->node);
 			break;
 		}
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index ec760ac0b397..4b327b481526 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,19 @@
 
 #include "card.h"
 
+static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
+	/*
+	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
+	 * This has so far only been observed on cards from 11/2019, while new
+	 * cards from 2023/05 do not exhibit this behavior.
+	 */
+	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
+		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
+		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
+
+	END_FIXUP
+};
+
 static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 #define INAND_CMD38_ARG_EXT_CSD  113
 #define INAND_CMD38_ARG_ERASE    0x00
@@ -53,15 +66,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_BLK_NO_CMD23),
 
-	/*
-	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
-	 * This has so far only been observed on cards from 11/2019, while new
-	 * cards from 2023/05 do not exhibit this behavior.
-	 */
-	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
-		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
-		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
-
 	/*
 	 * Some SD cards lockup while using CMD23 multiblock transfers.
 	 */
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 246ce027ae0a..30f6dbaa712f 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -26,6 +26,7 @@
 #include "host.h"
 #include "bus.h"
 #include "mmc_ops.h"
+#include "quirks.h"
 #include "sd.h"
 #include "sd_ops.h"
 
@@ -1475,6 +1476,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
+	/* Apply quirks prior to card setup */
+	mmc_fixup_device(card, mmc_sd_fixups);
+
 	err = mmc_sd_setup_card(host, card, oldcard != NULL);
 	if (err)
 		goto free_card;
diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index 41e94cd14109..fe7a4eac9595 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -612,7 +612,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		cqhci_writel(cq_host, 0, CQHCI_CTL);
 		mmc->cqe_on = true;
 		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
-		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
+		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
 			pr_err("%s: cqhci: CQE failed to exit halt state\n",
 			       mmc_hostname(mmc));
 		}
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d0da4573b38c..121e833efe28 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2952,8 +2952,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
 	if (host->use_dma == TRANS_MODE_IDMAC) {
 		mmc->max_segs = host->ring_size;
 		mmc->max_blk_size = 65535;
-		mmc->max_seg_size = 0x1000;
-		mmc->max_req_size = mmc->max_seg_size * host->ring_size;
+		mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
+		mmc->max_seg_size = mmc->max_req_size;
 		mmc->max_blk_count = mmc->max_req_size / 512;
 	} else if (host->use_dma == TRANS_MODE_EDMAC) {
 		mmc->max_segs = 64;
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index ba6677bf7372..e60a2525e35b 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -513,6 +513,7 @@ static const struct of_device_id aspeed_sdhci_of_match[] = {
 	{ .compatible = "aspeed,ast2600-sdhci", .data = &ast2600_sdhci_pdata, },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, aspeed_sdhci_of_match);
 
 static struct platform_driver aspeed_sdhci_driver = {
 	.driver		= {
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 683203f87ae2..277493e41b07 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -82,7 +82,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 
 		if (skb_copy_bits(skb, BAREUDP_BASE_HLEN, &ipversion,
 				  sizeof(ipversion))) {
-			bareudp->dev->stats.rx_dropped++;
+			DEV_STATS_INC(bareudp->dev, rx_dropped);
 			goto drop;
 		}
 		ipversion >>= 4;
@@ -92,7 +92,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		} else if (ipversion == 6 && bareudp->multi_proto_mode) {
 			proto = htons(ETH_P_IPV6);
 		} else {
-			bareudp->dev->stats.rx_dropped++;
+			DEV_STATS_INC(bareudp->dev, rx_dropped);
 			goto drop;
 		}
 	} else if (bareudp->ethertype == htons(ETH_P_MPLS_UC)) {
@@ -106,7 +106,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   ipv4_is_multicast(tunnel_hdr->daddr)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				bareudp->dev->stats.rx_dropped++;
+				DEV_STATS_INC(bareudp->dev, rx_dropped);
 				goto drop;
 			}
 		} else {
@@ -122,7 +122,7 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				   (addr_type & IPV6_ADDR_MULTICAST)) {
 				proto = htons(ETH_P_MPLS_MC);
 			} else {
-				bareudp->dev->stats.rx_dropped++;
+				DEV_STATS_INC(bareudp->dev, rx_dropped);
 				goto drop;
 			}
 		}
@@ -134,12 +134,12 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 				 proto,
 				 !net_eq(bareudp->net,
 				 dev_net(bareudp->dev)))) {
-		bareudp->dev->stats.rx_dropped++;
+		DEV_STATS_INC(bareudp->dev, rx_dropped);
 		goto drop;
 	}
 	tun_dst = udp_tun_rx_dst(skb, family, TUNNEL_KEY, 0, 0);
 	if (!tun_dst) {
-		bareudp->dev->stats.rx_dropped++;
+		DEV_STATS_INC(bareudp->dev, rx_dropped);
 		goto drop;
 	}
 	skb_dst_set(skb, &tun_dst->dst);
@@ -165,8 +165,8 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 						     &((struct ipv6hdr *)oiph)->saddr);
 		}
 		if (err > 1) {
-			++bareudp->dev->stats.rx_frame_errors;
-			++bareudp->dev->stats.rx_errors;
+			DEV_STATS_INC(bareudp->dev, rx_frame_errors);
+			DEV_STATS_INC(bareudp->dev, rx_errors);
 			goto drop;
 		}
 	}
@@ -462,11 +462,11 @@ static netdev_tx_t bareudp_xmit(struct sk_buff *skb, struct net_device *dev)
 	dev_kfree_skb(skb);
 
 	if (err == -ELOOP)
-		dev->stats.collisions++;
+		DEV_STATS_INC(dev, collisions);
 	else if (err == -ENETUNREACH)
-		dev->stats.tx_carrier_errors++;
+		DEV_STATS_INC(dev, tx_carrier_errors);
 
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2de998b98cb5..561f25cdad3f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1815,7 +1815,7 @@ static int m_can_open(struct net_device *dev)
 	/* start the m_can controller */
 	err = m_can_start(dev);
 	if (err)
-		goto exit_irq_fail;
+		goto exit_start_fail;
 
 	if (!cdev->is_peripheral)
 		napi_enable(&cdev->napi);
@@ -1824,6 +1824,9 @@ static int m_can_open(struct net_device *dev)
 
 	return 0;
 
+exit_start_fail:
+	if (cdev->is_peripheral || dev->irq)
+		free_irq(dev->irq, dev);
 exit_irq_fail:
 	if (cdev->is_peripheral)
 		destroy_workqueue(cdev->tx_wq);
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 79c4bab5f724..8c56f85e87c1 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -753,7 +753,7 @@ static int mcp251x_hw_wake(struct spi_device *spi)
 	int ret;
 
 	/* Force wakeup interrupt to wake device, but don't execute IST */
-	disable_irq(spi->irq);
+	disable_irq_nosync(spi->irq);
 	mcp251x_write_2regs(spi, CANINTE, CANINTE_WAKIE, CANINTF_WAKIF);
 
 	/* Wait for oscillator startup timer after wake up */
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1665f78abb5c..a9bafa96e2f9 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2019, 2020, 2021 Pengutronix,
+// Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 // Based on:
@@ -867,18 +867,18 @@ static int mcp251xfd_get_berr_counter(const struct net_device *ndev,
 
 static struct sk_buff *
 mcp251xfd_alloc_can_err_skb(struct mcp251xfd_priv *priv,
-			    struct can_frame **cf, u32 *timestamp)
+			    struct can_frame **cf, u32 *ts_raw)
 {
 	struct sk_buff *skb;
 	int err;
 
-	err = mcp251xfd_get_timestamp(priv, timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, ts_raw);
 	if (err)
 		return NULL;
 
 	skb = alloc_can_err_skb(priv->ndev, cf);
 	if (skb)
-		mcp251xfd_skb_set_timestamp(priv, skb, *timestamp);
+		mcp251xfd_skb_set_timestamp_raw(priv, skb, *ts_raw);
 
 	return skb;
 }
@@ -889,7 +889,7 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 	struct mcp251xfd_rx_ring *ring;
 	struct sk_buff *skb;
 	struct can_frame *cf;
-	u32 timestamp, rxovif;
+	u32 ts_raw, rxovif;
 	int err, i;
 
 	stats->rx_over_errors++;
@@ -924,14 +924,14 @@ static int mcp251xfd_handle_rxovif(struct mcp251xfd_priv *priv)
 			return err;
 	}
 
-	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &ts_raw);
 	if (!skb)
 		return 0;
 
 	cf->can_id |= CAN_ERR_CRTL;
 	cf->data[1] = CAN_ERR_CRTL_RX_OVERFLOW;
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -948,12 +948,12 @@ static int mcp251xfd_handle_txatif(struct mcp251xfd_priv *priv)
 static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 {
 	struct net_device_stats *stats = &priv->ndev->stats;
-	u32 bdiag1, timestamp;
+	u32 bdiag1, ts_raw;
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
 	int err;
 
-	err = mcp251xfd_get_timestamp(priv, &timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, &ts_raw);
 	if (err)
 		return err;
 
@@ -1035,8 +1035,8 @@ static int mcp251xfd_handle_ivmif(struct mcp251xfd_priv *priv)
 	if (!cf)
 		return 0;
 
-	mcp251xfd_skb_set_timestamp(priv, skb, timestamp);
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	mcp251xfd_skb_set_timestamp_raw(priv, skb, ts_raw);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
@@ -1049,7 +1049,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 	struct sk_buff *skb;
 	struct can_frame *cf = NULL;
 	enum can_state new_state, rx_state, tx_state;
-	u32 trec, timestamp;
+	u32 trec, ts_raw;
 	int err;
 
 	err = regmap_read(priv->map_reg, MCP251XFD_REG_TREC, &trec);
@@ -1079,7 +1079,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 	/* The skb allocation might fail, but can_change_state()
 	 * handles cf == NULL.
 	 */
-	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &timestamp);
+	skb = mcp251xfd_alloc_can_err_skb(priv, &cf, &ts_raw);
 	can_change_state(priv->ndev, cf, tx_state, rx_state);
 
 	if (new_state == CAN_STATE_BUS_OFF) {
@@ -1110,7 +1110,7 @@ static int mcp251xfd_handle_cerrif(struct mcp251xfd_priv *priv)
 		cf->data[7] = bec.rxerr;
 	}
 
-	err = can_rx_offload_queue_timestamp(&priv->offload, skb, timestamp);
+	err = can_rx_offload_queue_timestamp(&priv->offload, skb, ts_raw);
 	if (err)
 		stats->rx_fifo_errors++;
 
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c
index 9e8e82cdba46..61b0d6fa52dd 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ram.c
@@ -97,7 +97,16 @@ void can_ram_get_layout(struct can_ram_layout *layout,
 	if (ring) {
 		u8 num_rx_coalesce = 0, num_tx_coalesce = 0;
 
-		num_rx = can_ram_rounddown_pow_of_two(config, &config->rx, 0, ring->rx_pending);
+		/* If the ring parameters have been configured in
+		 * CAN-CC mode, but and we are in CAN-FD mode now,
+		 * they might be to big. Use the default CAN-FD values
+		 * in this case.
+		 */
+		num_rx = ring->rx_pending;
+		if (num_rx > layout->max_rx)
+			num_rx = layout->default_rx;
+
+		num_rx = can_ram_rounddown_pow_of_two(config, &config->rx, 0, num_rx);
 
 		/* The ethtool doc says:
 		 * To disable coalescing, set usecs = 0 and max_frames = 1.
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
index 4d0246a0779a..0fde8154a649 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-ring.c
@@ -196,6 +196,7 @@ mcp251xfd_ring_init_rx(struct mcp251xfd_priv *priv, u16 *base, u8 *fifo_nr)
 	int i, j;
 
 	mcp251xfd_for_each_rx_ring(priv, rx_ring, i) {
+		rx_ring->last_valid = timecounter_read(&priv->tc);
 		rx_ring->head = 0;
 		rx_ring->tail = 0;
 		rx_ring->base = *base;
@@ -458,11 +459,25 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 
 	/* switching from CAN-2.0 to CAN-FD mode or vice versa */
 	if (fd_mode != test_bit(MCP251XFD_FLAGS_FD_MODE, priv->flags)) {
+		const struct ethtool_ringparam ring = {
+			.rx_pending = priv->rx_obj_num,
+			.tx_pending = priv->tx->obj_num,
+		};
+		const struct ethtool_coalesce ec = {
+			.rx_coalesce_usecs_irq = priv->rx_coalesce_usecs_irq,
+			.rx_max_coalesced_frames_irq = priv->rx_obj_num_coalesce_irq,
+			.tx_coalesce_usecs_irq = priv->tx_coalesce_usecs_irq,
+			.tx_max_coalesced_frames_irq = priv->tx_obj_num_coalesce_irq,
+		};
 		struct can_ram_layout layout;
 
-		can_ram_get_layout(&layout, &mcp251xfd_ram_config, NULL, NULL, fd_mode);
-		priv->rx_obj_num = layout.default_rx;
-		tx_ring->obj_num = layout.default_tx;
+		can_ram_get_layout(&layout, &mcp251xfd_ram_config, &ring, &ec, fd_mode);
+
+		priv->rx_obj_num = layout.cur_rx;
+		priv->rx_obj_num_coalesce_irq = layout.rx_coalesce;
+
+		tx_ring->obj_num = layout.cur_tx;
+		priv->tx_obj_num_coalesce_irq = layout.tx_coalesce;
 	}
 
 	if (fd_mode) {
@@ -499,6 +514,8 @@ int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv)
 		}
 
 		rx_ring->obj_num = rx_obj_num;
+		rx_ring->obj_num_shift_to_u8 = BITS_PER_TYPE(rx_ring->obj_num_shift_to_u8) -
+			ilog2(rx_obj_num);
 		rx_ring->obj_size = rx_obj_size;
 		priv->rx[i] = rx_ring;
 	}
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
index ced8d9c81f8c..fe897f3e4c12 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-rx.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2019, 2020, 2021 Pengutronix,
+// Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 // Based on:
@@ -16,23 +16,14 @@
 
 #include "mcp251xfd.h"
 
-static inline int
-mcp251xfd_rx_head_get_from_chip(const struct mcp251xfd_priv *priv,
-				const struct mcp251xfd_rx_ring *ring,
-				u8 *rx_head, bool *fifo_empty)
+static inline bool mcp251xfd_rx_fifo_sta_empty(const u32 fifo_sta)
 {
-	u32 fifo_sta;
-	int err;
-
-	err = regmap_read(priv->map_reg, MCP251XFD_REG_FIFOSTA(ring->fifo_nr),
-			  &fifo_sta);
-	if (err)
-		return err;
-
-	*rx_head = FIELD_GET(MCP251XFD_REG_FIFOSTA_FIFOCI_MASK, fifo_sta);
-	*fifo_empty = !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+}
 
-	return 0;
+static inline bool mcp251xfd_rx_fifo_sta_full(const u32 fifo_sta)
+{
+	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
 }
 
 static inline int
@@ -80,29 +71,49 @@ mcp251xfd_check_rx_tail(const struct mcp251xfd_priv *priv,
 }
 
 static int
-mcp251xfd_rx_ring_update(const struct mcp251xfd_priv *priv,
-			 struct mcp251xfd_rx_ring *ring)
+mcp251xfd_get_rx_len(const struct mcp251xfd_priv *priv,
+		     const struct mcp251xfd_rx_ring *ring,
+		     u8 *len_p)
 {
-	u32 new_head;
-	u8 chip_rx_head;
-	bool fifo_empty;
+	const u8 shift = ring->obj_num_shift_to_u8;
+	u8 chip_head, tail, len;
+	u32 fifo_sta;
 	int err;
 
-	err = mcp251xfd_rx_head_get_from_chip(priv, ring, &chip_rx_head,
-					      &fifo_empty);
-	if (err || fifo_empty)
+	err = regmap_read(priv->map_reg, MCP251XFD_REG_FIFOSTA(ring->fifo_nr),
+			  &fifo_sta);
+	if (err)
+		return err;
+
+	if (mcp251xfd_rx_fifo_sta_empty(fifo_sta)) {
+		*len_p = 0;
+		return 0;
+	}
+
+	if (mcp251xfd_rx_fifo_sta_full(fifo_sta)) {
+		*len_p = ring->obj_num;
+		return 0;
+	}
+
+	chip_head = FIELD_GET(MCP251XFD_REG_FIFOSTA_FIFOCI_MASK, fifo_sta);
+
+	err =  mcp251xfd_check_rx_tail(priv, ring);
+	if (err)
 		return err;
+	tail = mcp251xfd_get_rx_tail(ring);
 
-	/* chip_rx_head, is the next RX-Object filled by the HW.
-	 * The new RX head must be >= the old head.
+	/* First shift to full u8. The subtraction works on signed
+	 * values, that keeps the difference steady around the u8
+	 * overflow. The right shift acts on len, which is an u8.
 	 */
-	new_head = round_down(ring->head, ring->obj_num) + chip_rx_head;
-	if (new_head <= ring->head)
-		new_head += ring->obj_num;
+	BUILD_BUG_ON(sizeof(ring->obj_num) != sizeof(chip_head));
+	BUILD_BUG_ON(sizeof(ring->obj_num) != sizeof(tail));
+	BUILD_BUG_ON(sizeof(ring->obj_num) != sizeof(len));
 
-	ring->head = new_head;
+	len = (chip_head << shift) - (tail << shift);
+	*len_p = len >> shift;
 
-	return mcp251xfd_check_rx_tail(priv, ring);
+	return 0;
 }
 
 static void
@@ -148,8 +159,6 @@ mcp251xfd_hw_rx_obj_to_skb(const struct mcp251xfd_priv *priv,
 
 	if (!(hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_RTR))
 		memcpy(cfd->data, hw_rx_obj->data, cfd->len);
-
-	mcp251xfd_skb_set_timestamp(priv, skb, hw_rx_obj->ts);
 }
 
 static int
@@ -160,8 +169,26 @@ mcp251xfd_handle_rxif_one(struct mcp251xfd_priv *priv,
 	struct net_device_stats *stats = &priv->ndev->stats;
 	struct sk_buff *skb;
 	struct canfd_frame *cfd;
+	u64 timestamp;
 	int err;
 
+	/* According to mcp2518fd erratum DS80000789E 6. the FIFOCI
+	 * bits of a FIFOSTA register, here the RX FIFO head index
+	 * might be corrupted and we might process past the RX FIFO's
+	 * head into old CAN frames.
+	 *
+	 * Compare the timestamp of currently processed CAN frame with
+	 * last valid frame received. Abort with -EBADMSG if an old
+	 * CAN frame is detected.
+	 */
+	timestamp = timecounter_cyc2time(&priv->tc, hw_rx_obj->ts);
+	if (timestamp <= ring->last_valid) {
+		stats->rx_fifo_errors++;
+
+		return -EBADMSG;
+	}
+	ring->last_valid = timestamp;
+
 	if (hw_rx_obj->flags & MCP251XFD_OBJ_FLAGS_FDF)
 		skb = alloc_canfd_skb(priv->ndev, &cfd);
 	else
@@ -172,6 +199,7 @@ mcp251xfd_handle_rxif_one(struct mcp251xfd_priv *priv,
 		return 0;
 	}
 
+	mcp251xfd_skb_set_timestamp(skb, timestamp);
 	mcp251xfd_hw_rx_obj_to_skb(priv, hw_rx_obj, skb);
 	err = can_rx_offload_queue_timestamp(&priv->offload, skb, hw_rx_obj->ts);
 	if (err)
@@ -197,52 +225,81 @@ mcp251xfd_rx_obj_read(const struct mcp251xfd_priv *priv,
 	return err;
 }
 
+static int
+mcp251xfd_handle_rxif_ring_uinc(const struct mcp251xfd_priv *priv,
+				struct mcp251xfd_rx_ring *ring,
+				u8 len)
+{
+	int offset;
+	int err;
+
+	if (!len)
+		return 0;
+
+	ring->head += len;
+
+	/* Increment the RX FIFO tail pointer 'len' times in a
+	 * single SPI message.
+	 *
+	 * Note:
+	 * Calculate offset, so that the SPI transfer ends on
+	 * the last message of the uinc_xfer array, which has
+	 * "cs_change == 0", to properly deactivate the chip
+	 * select.
+	 */
+	offset = ARRAY_SIZE(ring->uinc_xfer) - len;
+	err = spi_sync_transfer(priv->spi,
+				ring->uinc_xfer + offset, len);
+	if (err)
+		return err;
+
+	ring->tail += len;
+
+	return 0;
+}
+
 static int
 mcp251xfd_handle_rxif_ring(struct mcp251xfd_priv *priv,
 			   struct mcp251xfd_rx_ring *ring)
 {
 	struct mcp251xfd_hw_rx_obj_canfd *hw_rx_obj = ring->obj;
-	u8 rx_tail, len;
+	u8 rx_tail, len, l;
 	int err, i;
 
-	err = mcp251xfd_rx_ring_update(priv, ring);
+	err = mcp251xfd_get_rx_len(priv, ring, &len);
 	if (err)
 		return err;
 
-	while ((len = mcp251xfd_get_rx_linear_len(ring))) {
-		int offset;
-
+	while ((l = mcp251xfd_get_rx_linear_len(ring, len))) {
 		rx_tail = mcp251xfd_get_rx_tail(ring);
 
 		err = mcp251xfd_rx_obj_read(priv, ring, hw_rx_obj,
-					    rx_tail, len);
+					    rx_tail, l);
 		if (err)
 			return err;
 
-		for (i = 0; i < len; i++) {
+		for (i = 0; i < l; i++) {
 			err = mcp251xfd_handle_rxif_one(priv, ring,
 							(void *)hw_rx_obj +
 							i * ring->obj_size);
-			if (err)
+
+			/* -EBADMSG means we're affected by mcp2518fd
+			 * erratum DS80000789E 6., i.e. the timestamp
+			 * in the RX object is older that the last
+			 * valid received CAN frame. Don't process any
+			 * further and mark processed frames as good.
+			 */
+			if (err == -EBADMSG)
+				return mcp251xfd_handle_rxif_ring_uinc(priv, ring, i);
+			else if (err)
 				return err;
 		}
 
-		/* Increment the RX FIFO tail pointer 'len' times in a
-		 * single SPI message.
-		 *
-		 * Note:
-		 * Calculate offset, so that the SPI transfer ends on
-		 * the last message of the uinc_xfer array, which has
-		 * "cs_change == 0", to properly deactivate the chip
-		 * select.
-		 */
-		offset = ARRAY_SIZE(ring->uinc_xfer) - len;
-		err = spi_sync_transfer(priv->spi,
-					ring->uinc_xfer + offset, len);
+		err = mcp251xfd_handle_rxif_ring_uinc(priv, ring, l);
 		if (err)
 			return err;
 
-		ring->tail += len;
+		len -= l;
 	}
 
 	return 0;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index 902eb767426d..8f39730f3122 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -97,7 +97,7 @@ mcp251xfd_handle_tefif_one(struct mcp251xfd_priv *priv,
 	tef_tail = mcp251xfd_get_tef_tail(priv);
 	skb = priv->can.echo_skb[tef_tail];
 	if (skb)
-		mcp251xfd_skb_set_timestamp(priv, skb, hw_tef_obj->ts);
+		mcp251xfd_skb_set_timestamp_raw(priv, skb, hw_tef_obj->ts);
 	stats->tx_bytes +=
 		can_rx_offload_get_echo_skb(&priv->offload,
 					    tef_tail, hw_tef_obj->ts,
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
index 712e09186987..1db99aabe85c 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-timestamp.c
@@ -2,7 +2,7 @@
 //
 // mcp251xfd - Microchip MCP251xFD Family CAN controller driver
 //
-// Copyright (c) 2021 Pengutronix,
+// Copyright (c) 2021, 2023 Pengutronix,
 //               Marc Kleine-Budde <kernel@pengutronix.de>
 //
 
@@ -11,20 +11,20 @@
 
 #include "mcp251xfd.h"
 
-static u64 mcp251xfd_timestamp_read(const struct cyclecounter *cc)
+static u64 mcp251xfd_timestamp_raw_read(const struct cyclecounter *cc)
 {
 	const struct mcp251xfd_priv *priv;
-	u32 timestamp = 0;
+	u32 ts_raw = 0;
 	int err;
 
 	priv = container_of(cc, struct mcp251xfd_priv, cc);
-	err = mcp251xfd_get_timestamp(priv, &timestamp);
+	err = mcp251xfd_get_timestamp_raw(priv, &ts_raw);
 	if (err)
 		netdev_err(priv->ndev,
 			   "Error %d while reading timestamp. HW timestamps may be inaccurate.",
 			   err);
 
-	return timestamp;
+	return ts_raw;
 }
 
 static void mcp251xfd_timestamp_work(struct work_struct *work)
@@ -39,21 +39,11 @@ static void mcp251xfd_timestamp_work(struct work_struct *work)
 			      MCP251XFD_TIMESTAMP_WORK_DELAY_SEC * HZ);
 }
 
-void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
-				 struct sk_buff *skb, u32 timestamp)
-{
-	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
-	u64 ns;
-
-	ns = timecounter_cyc2time(&priv->tc, timestamp);
-	hwtstamps->hwtstamp = ns_to_ktime(ns);
-}
-
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv)
 {
 	struct cyclecounter *cc = &priv->cc;
 
-	cc->read = mcp251xfd_timestamp_read;
+	cc->read = mcp251xfd_timestamp_raw_read;
 	cc->mask = CYCLECOUNTER_MASK(32);
 	cc->shift = 1;
 	cc->mult = clocksource_hz2mult(priv->can.clock.freq, cc->shift);
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
index 78d12dda08a0..c07300443c6a 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd.h
@@ -2,7 +2,7 @@
  *
  * mcp251xfd - Microchip MCP251xFD Family CAN controller driver
  *
- * Copyright (c) 2019, 2020, 2021 Pengutronix,
+ * Copyright (c) 2019, 2020, 2021, 2023 Pengutronix,
  *               Marc Kleine-Budde <kernel@pengutronix.de>
  * Copyright (c) 2019 Martin Sperl <kernel@martin.sperl.org>
  */
@@ -549,10 +549,14 @@ struct mcp251xfd_rx_ring {
 	unsigned int head;
 	unsigned int tail;
 
+	/* timestamp of the last valid received CAN frame */
+	u64 last_valid;
+
 	u16 base;
 	u8 nr;
 	u8 fifo_nr;
 	u8 obj_num;
+	u8 obj_num_shift_to_u8;
 	u8 obj_size;
 
 	union mcp251xfd_write_reg_buf irq_enable_buf;
@@ -793,10 +797,27 @@ mcp251xfd_spi_cmd_write(const struct mcp251xfd_priv *priv,
 	return data;
 }
 
-static inline int mcp251xfd_get_timestamp(const struct mcp251xfd_priv *priv,
-					  u32 *timestamp)
+static inline int mcp251xfd_get_timestamp_raw(const struct mcp251xfd_priv *priv,
+					      u32 *ts_raw)
+{
+	return regmap_read(priv->map_reg, MCP251XFD_REG_TBC, ts_raw);
+}
+
+static inline void mcp251xfd_skb_set_timestamp(struct sk_buff *skb, u64 ns)
+{
+	struct skb_shared_hwtstamps *hwtstamps = skb_hwtstamps(skb);
+
+	hwtstamps->hwtstamp = ns_to_ktime(ns);
+}
+
+static inline
+void mcp251xfd_skb_set_timestamp_raw(const struct mcp251xfd_priv *priv,
+				     struct sk_buff *skb, u32 ts_raw)
 {
-	return regmap_read(priv->map_reg, MCP251XFD_REG_TBC, timestamp);
+	u64 ns;
+
+	ns = timecounter_cyc2time(&priv->tc, ts_raw);
+	mcp251xfd_skb_set_timestamp(skb, ns);
 }
 
 static inline u16 mcp251xfd_get_tef_obj_addr(u8 n)
@@ -889,18 +910,9 @@ static inline u8 mcp251xfd_get_rx_tail(const struct mcp251xfd_rx_ring *ring)
 	return ring->tail & (ring->obj_num - 1);
 }
 
-static inline u8 mcp251xfd_get_rx_len(const struct mcp251xfd_rx_ring *ring)
-{
-	return ring->head - ring->tail;
-}
-
 static inline u8
-mcp251xfd_get_rx_linear_len(const struct mcp251xfd_rx_ring *ring)
+mcp251xfd_get_rx_linear_len(const struct mcp251xfd_rx_ring *ring, u8 len)
 {
-	u8 len;
-
-	len = mcp251xfd_get_rx_len(ring);
-
 	return min_t(u8, len, ring->obj_num - mcp251xfd_get_rx_tail(ring));
 }
 
@@ -926,8 +938,6 @@ void mcp251xfd_ring_free(struct mcp251xfd_priv *priv);
 int mcp251xfd_ring_alloc(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_rxif(struct mcp251xfd_priv *priv);
 int mcp251xfd_handle_tefif(struct mcp251xfd_priv *priv);
-void mcp251xfd_skb_set_timestamp(const struct mcp251xfd_priv *priv,
-				 struct sk_buff *skb, u32 timestamp);
 void mcp251xfd_timestamp_init(struct mcp251xfd_priv *priv);
 void mcp251xfd_timestamp_stop(struct mcp251xfd_priv *priv);
 
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index c8e9ca5d5c28..de444d201e0f 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -35,7 +35,7 @@
 #define VSC73XX_BLOCK_ANALYZER	0x2 /* Only subblock 0 */
 #define VSC73XX_BLOCK_MII	0x3 /* Subblocks 0 and 1 */
 #define VSC73XX_BLOCK_MEMINIT	0x3 /* Only subblock 2 */
-#define VSC73XX_BLOCK_CAPTURE	0x4 /* Only subblock 2 */
+#define VSC73XX_BLOCK_CAPTURE	0x4 /* Subblocks 0-4, 6, 7 */
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
@@ -371,13 +371,19 @@ int vsc73xx_is_addr_valid(u8 block, u8 subblock)
 		break;
 
 	case VSC73XX_BLOCK_MII:
-	case VSC73XX_BLOCK_CAPTURE:
 	case VSC73XX_BLOCK_ARBITER:
 		switch (subblock) {
 		case 0 ... 1:
 			return 1;
 		}
 		break;
+	case VSC73XX_BLOCK_CAPTURE:
+		switch (subblock) {
+		case 0 ... 4:
+		case 6 ... 7:
+			return 1;
+		}
+		break;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 981cc3248047..19506f2be4d4 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -916,14 +916,18 @@ static inline void dpaa_setup_egress(const struct dpaa_priv *priv,
 	}
 }
 
-static void dpaa_fq_setup(struct dpaa_priv *priv,
-			  const struct dpaa_fq_cbs *fq_cbs,
-			  struct fman_port *tx_port)
+static int dpaa_fq_setup(struct dpaa_priv *priv,
+			 const struct dpaa_fq_cbs *fq_cbs,
+			 struct fman_port *tx_port)
 {
 	int egress_cnt = 0, conf_cnt = 0, num_portals = 0, portal_cnt = 0, cpu;
 	const cpumask_t *affine_cpus = qman_affine_cpus();
-	u16 channels[NR_CPUS];
 	struct dpaa_fq *fq;
+	u16 *channels;
+
+	channels = kcalloc(num_possible_cpus(), sizeof(u16), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
 
 	for_each_cpu_and(cpu, affine_cpus, cpu_online_mask)
 		channels[num_portals++] = qman_affine_channel(cpu);
@@ -982,6 +986,10 @@ static void dpaa_fq_setup(struct dpaa_priv *priv,
 				break;
 		}
 	}
+
+	kfree(channels);
+
+	return 0;
 }
 
 static inline int dpaa_tx_fq_to_id(const struct dpaa_priv *priv,
@@ -3454,7 +3462,9 @@ static int dpaa_eth_probe(struct platform_device *pdev)
 	 */
 	dpaa_eth_add_channel(priv->channel, &pdev->dev);
 
-	dpaa_fq_setup(priv, &dpaa_fq_cbs, priv->mac_dev->port[TX]);
+	err = dpaa_fq_setup(priv, &dpaa_fq_cbs, priv->mac_dev->port[TX]);
+	if (err)
+		goto free_dpaa_bps;
 
 	/* Create a congestion group for this netdev, with
 	 * dynamically-allocated CGR ID.
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
index 769e936a263c..fcb0cba4611e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
@@ -515,12 +515,16 @@ static int dpaa_set_coalesce(struct net_device *dev,
 			     struct netlink_ext_ack *extack)
 {
 	const cpumask_t *cpus = qman_affine_cpus();
-	bool needs_revert[NR_CPUS] = {false};
 	struct qman_portal *portal;
 	u32 period, prev_period;
 	u8 thresh, prev_thresh;
+	bool *needs_revert;
 	int cpu, res;
 
+	needs_revert = kcalloc(num_possible_cpus(), sizeof(bool), GFP_KERNEL);
+	if (!needs_revert)
+		return -ENOMEM;
+
 	period = c->rx_coalesce_usecs;
 	thresh = c->rx_max_coalesced_frames;
 
@@ -543,6 +547,8 @@ static int dpaa_set_coalesce(struct net_device *dev,
 		needs_revert[cpu] = true;
 	}
 
+	kfree(needs_revert);
+
 	return 0;
 
 revert_values:
@@ -556,6 +562,8 @@ static int dpaa_set_coalesce(struct net_device *dev,
 		qman_dqrr_set_ithresh(portal, prev_thresh);
 	}
 
+	kfree(needs_revert);
+
 	return res;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 9dbfbc90485e..3f01942e4982 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -611,6 +611,9 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 			memset(&vsi->mqprio_qopt, 0, sizeof(vsi->mqprio_qopt));
 		}
 	}
+
+	if (vsi->netdev)
+		netif_device_detach(vsi->netdev);
 skip:
 
 	/* clear SW filtering DB */
@@ -2630,11 +2633,11 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
 	int i;
 
 	old_prog = xchg(&vsi->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);
-
 	ice_for_each_rxq(vsi, i)
 		WRITE_ONCE(vsi->rx_rings[i]->xdp_prog, vsi->xdp_prog);
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
 }
 
 /**
@@ -2883,6 +2886,18 @@ int ice_vsi_determine_xdp_res(struct ice_vsi *vsi)
 	return 0;
 }
 
+/**
+ * ice_max_xdp_frame_size - returns the maximum allowed frame size for XDP
+ * @vsi: Pointer to VSI structure
+ */
+static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
+{
+	if (test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
+		return ICE_RXBUF_1664;
+	else
+		return ICE_RXBUF_3072;
+}
+
 /**
  * ice_xdp_setup_prog - Add or remove XDP eBPF program
  * @vsi: VSI to setup XDP for
@@ -2893,17 +2908,26 @@ static int
 ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		   struct netlink_ext_ack *extack)
 {
-	int frame_size = vsi->netdev->mtu + ICE_ETH_PKT_HDR_PAD;
-	bool if_running = netif_running(vsi->netdev);
+	unsigned int frame_size = vsi->netdev->mtu + ICE_ETH_PKT_HDR_PAD;
 	int ret = 0, xdp_ring_err = 0;
+	bool if_running;
 
-	if (frame_size > vsi->rx_buf_len) {
+	if (frame_size > ice_max_xdp_frame_size(vsi)) {
 		NL_SET_ERR_MSG_MOD(extack, "MTU too large for loading XDP");
 		return -EOPNOTSUPP;
 	}
 
+	/* hot swap progs and avoid toggling link */
+	if (ice_is_xdp_ena_vsi(vsi) == !!prog) {
+		ice_vsi_assign_bpf_prog(vsi, prog);
+		return 0;
+	}
+
+	if_running = netif_running(vsi->netdev) &&
+		     !test_and_set_bit(ICE_VSI_DOWN, vsi->state);
+
 	/* need to stop netdev while setting up the program for Rx rings */
-	if (if_running && !test_and_set_bit(ICE_VSI_DOWN, vsi->state)) {
+	if (if_running) {
 		ret = ice_down(vsi);
 		if (ret) {
 			NL_SET_ERR_MSG_MOD(extack, "Preparing device for XDP attach failed");
@@ -2932,13 +2956,6 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		xdp_ring_err = ice_realloc_zc_buf(vsi, false);
 		if (xdp_ring_err)
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Rx resources failed");
-	} else {
-		/* safe to call even when prog == vsi->xdp_prog as
-		 * dev_xdp_install in net/core/dev.c incremented prog's
-		 * refcount so corresponding bpf_prog_put won't cause
-		 * underflow
-		 */
-		ice_vsi_assign_bpf_prog(vsi, prog);
 	}
 
 	if (if_running)
@@ -7140,6 +7157,7 @@ static void ice_update_pf_netdev_link(struct ice_pf *pf)
  */
 static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 {
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	bool dvm;
@@ -7292,6 +7310,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_rebuild_arfs(pf);
 	}
 
+	if (vsi && vsi->netdev)
+		netif_device_attach(vsi->netdev);
+
 	ice_update_pf_netdev_link(pf);
 
 	/* tell the firmware we are up */
@@ -7322,18 +7343,6 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	dev_err(dev, "Rebuild failed, unload and reload driver\n");
 }
 
-/**
- * ice_max_xdp_frame_size - returns the maximum allowed frame size for XDP
- * @vsi: Pointer to VSI structure
- */
-static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
-{
-	if (test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
-		return ICE_RXBUF_1664;
-	else
-		return ICE_RXBUF_3072;
-}
-
 /**
  * ice_change_mtu - NDO callback to change the MTU
  * @netdev: network interface device structure
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 81d9a5338be5..76bd41058f3a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6925,10 +6925,20 @@ static void igb_extts(struct igb_adapter *adapter, int tsintr_tt)
 
 static void igb_tsync_interrupt(struct igb_adapter *adapter)
 {
+	const u32 mask = (TSINTR_SYS_WRAP | E1000_TSICR_TXTS |
+			  TSINTR_TT0 | TSINTR_TT1 |
+			  TSINTR_AUTT0 | TSINTR_AUTT1);
 	struct e1000_hw *hw = &adapter->hw;
 	u32 tsicr = rd32(E1000_TSICR);
 	struct ptp_clock_event event;
 
+	if (hw->mac.type == e1000_82580) {
+		/* 82580 has a hardware bug that requires an explicit
+		 * write to clear the TimeSync interrupt cause.
+		 */
+		wr32(E1000_TSICR, tsicr & mask);
+	}
+
 	if (tsicr & TSINTR_SYS_WRAP) {
 		event.type = PTP_CLOCK_PPS;
 		if (adapter->ptp_caps.pps)
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 39f8f28288aa..6ae2d0b723c8 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7063,6 +7063,7 @@ static void igc_io_resume(struct pci_dev *pdev)
 	rtnl_lock();
 	if (netif_running(netdev)) {
 		if (igc_open(netdev)) {
+			rtnl_unlock();
 			netdev_err(netdev, "igc_open failed after reset\n");
 			return;
 		}
diff --git a/drivers/net/ethernet/microsoft/mana/mana.h b/drivers/net/ethernet/microsoft/mana/mana.h
index 41c99eabf40a..2b00d6a29117 100644
--- a/drivers/net/ethernet/microsoft/mana/mana.h
+++ b/drivers/net/ethernet/microsoft/mana/mana.h
@@ -86,6 +86,8 @@ struct mana_txq {
 
 	atomic_t pending_sends;
 
+	bool napi_initialized;
+
 	struct mana_stats_tx stats;
 };
 
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index e7d1ce68f05e..b52612eef0a6 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1391,10 +1391,12 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 
 	for (i = 0; i < apc->num_queues; i++) {
 		napi = &apc->tx_qp[i].tx_cq.napi;
-		napi_synchronize(napi);
-		napi_disable(napi);
-		netif_napi_del(napi);
-
+		if (apc->tx_qp[i].txq.napi_initialized) {
+			napi_synchronize(napi);
+			napi_disable(napi);
+			netif_napi_del(napi);
+			apc->tx_qp[i].txq.napi_initialized = false;
+		}
 		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
@@ -1450,6 +1452,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 		txq->ndev = net;
 		txq->net_txq = netdev_get_tx_queue(net, i);
 		txq->vp_offset = apc->tx_vp_offset;
+		txq->napi_initialized = false;
 		skb_queue_head_init(&txq->pending_skbs);
 
 		memset(&spec, 0, sizeof(spec));
@@ -1514,6 +1517,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 
 		netif_napi_add_tx(net, &cq->napi, mana_poll);
 		napi_enable(&cq->napi);
+		txq->napi_initialized = true;
 
 		mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 	}
@@ -1525,7 +1529,7 @@ static int mana_create_txq(struct mana_port_context *apc,
 }
 
 static void mana_destroy_rxq(struct mana_port_context *apc,
-			     struct mana_rxq *rxq, bool validate_state)
+			     struct mana_rxq *rxq, bool napi_initialized)
 
 {
 	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
@@ -1539,15 +1543,15 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
 
 	napi = &rxq->rx_cq.napi;
 
-	if (validate_state)
+	if (napi_initialized) {
 		napi_synchronize(napi);
 
-	napi_disable(napi);
+		napi_disable(napi);
 
+		netif_napi_del(napi);
+	}
 	xdp_rxq_info_unreg(&rxq->xdp_rxq);
 
-	netif_napi_del(napi);
-
 	mana_destroy_wq_obj(apc, GDMA_RQ, rxq->rxobj);
 
 	mana_deinit_cq(apc, &rxq->rx_cq);
diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
index 9f9eaf896047..fae9628f9615 100644
--- a/drivers/net/mctp/mctp-serial.c
+++ b/drivers/net/mctp/mctp-serial.c
@@ -91,8 +91,8 @@ static int next_chunk_len(struct mctp_serial *dev)
 	 * will be those non-escaped bytes, and does not include the escaped
 	 * byte.
 	 */
-	for (i = 1; i + dev->txpos + 1 < dev->txlen; i++) {
-		if (needs_escape(dev->txbuf[dev->txpos + i + 1]))
+	for (i = 1; i + dev->txpos < dev->txlen; i++) {
+		if (needs_escape(dev->txbuf[dev->txpos + i]))
 			break;
 	}
 
diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index 6a769df0b421..13381d87eeb0 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -353,8 +353,8 @@ static int ipheth_close(struct net_device *net)
 {
 	struct ipheth_device *dev = netdev_priv(net);
 
-	cancel_delayed_work_sync(&dev->carrier_work);
 	netif_stop_queue(net);
+	cancel_delayed_work_sync(&dev->carrier_work);
 	return 0;
 }
 
diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 405e588f8a3a..0f848d318544 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -61,9 +61,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-// randomly generated ethernet address
-static u8	node_id [ETH_ALEN];
-
 /* use ethtool to change the level for any given device */
 static int msg_level = -1;
 module_param (msg_level, int, 0);
@@ -1726,7 +1723,6 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 
 	dev->net = net;
 	strscpy(net->name, "usb%d", sizeof(net->name));
-	eth_hw_addr_set(net, node_id);
 
 	/* rx and tx sides can use different message sizes;
 	 * bind() should set rx_urb_size in that case.
@@ -1800,9 +1796,9 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		goto out4;
 	}
 
-	/* let userspace know we have a random address */
-	if (ether_addr_equal(net->dev_addr, node_id))
-		net->addr_assign_type = NET_ADDR_RANDOM;
+	/* this flags the device for user space */
+	if (!is_valid_ether_addr(net->dev_addr))
+		eth_hw_addr_random(net);
 
 	if ((dev->driver_info->flags & FLAG_WLAN) != 0)
 		SET_NETDEV_DEVTYPE(net, &wlan_type);
@@ -2212,7 +2208,6 @@ static int __init usbnet_init(void)
 	BUILD_BUG_ON(
 		sizeof_field(struct sk_buff, cb) < sizeof(struct skb_data));
 
-	eth_random_addr(node_id);
 	return 0;
 }
 module_init(usbnet_init);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index a4034d44609b..94b1e4f15b41 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -1089,6 +1089,7 @@ static int ieee_hw_init(struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 	ieee80211_hw_set(hw, SIGNAL_DBM);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
 
 	hw->extra_tx_headroom = brcms_c_get_header_len();
 	hw->queues = N_TX_QUEUES;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 63f861e6b28a..fb98eb342bd9 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1301,6 +1301,9 @@ mwifiex_get_priv_by_id(struct mwifiex_adapter *adapter,
 
 	for (i = 0; i < adapter->priv_num; i++) {
 		if (adapter->priv[i]) {
+			if (adapter->priv[i]->bss_mode == NL80211_IFTYPE_UNSPECIFIED)
+				continue;
+
 			if ((adapter->priv[i]->bss_num == bss_num) &&
 			    (adapter->priv[i]->bss_type == bss_type))
 				break;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c309709ac9b5..54a969aa72be 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3107,6 +3107,17 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x144d && pdev->device == 0xa80d) {
+		/*
+		 * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
+		 * because of high power consumption (> 2 Watt) in s2idle
+		 * sleep. Only some boards with Intel CPU are affected.
+		 */
+		if (dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
+		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
+			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
 	/*
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 76b9eb438268..81574500a57c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1816,8 +1816,10 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 	}
 
 	queue->nr_cmds = sq->size * 2;
-	if (nvmet_tcp_alloc_cmds(queue))
+	if (nvmet_tcp_alloc_cmds(queue)) {
+		queue->nr_cmds = 0;
 		return NVME_SC_INTERNAL;
+	}
 	return 0;
 }
 
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f06058394102..ad897b2c0b14 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1092,13 +1092,13 @@ void nvmem_device_put(struct nvmem_device *nvmem)
 EXPORT_SYMBOL_GPL(nvmem_device_put);
 
 /**
- * devm_nvmem_device_get() - Get nvmem cell of device form a given id
+ * devm_nvmem_device_get() - Get nvmem device of device form a given id
  *
  * @dev: Device that requests the nvmem device.
  * @id: name id for the requested nvmem device.
  *
- * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_cell
- * on success.  The nvmem_cell will be freed by the automatically once the
+ * Return: ERR_PTR() on error or a valid pointer to a struct nvmem_device
+ * on success.  The nvmem_device will be freed by the automatically once the
  * device is freed.
  */
 struct nvmem_device *devm_nvmem_device_get(struct device *dev, const char *id)
diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 88c24d88c4b9..a8e306606c4b 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -344,7 +344,8 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 	struct device_node *p;
 	const __be32 *addr;
 	u32 intsize;
-	int i, res;
+	int i, res, addr_len;
+	__be32 addr_buf[3] = { 0 };
 
 	pr_debug("of_irq_parse_one: dev=%pOF, index=%d\n", device, index);
 
@@ -353,13 +354,19 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 		return of_irq_parse_oldworld(device, index, out_irq);
 
 	/* Get the reg property (if any) */
-	addr = of_get_property(device, "reg", NULL);
+	addr = of_get_property(device, "reg", &addr_len);
+
+	/* Prevent out-of-bounds read in case of longer interrupt parent address size */
+	if (addr_len > (3 * sizeof(__be32)))
+		addr_len = 3 * sizeof(__be32);
+	if (addr)
+		memcpy(addr_buf, addr, addr_len);
 
 	/* Try the new-style interrupts-extended first */
 	res = of_parse_phandle_with_args(device, "interrupts-extended",
 					"#interrupt-cells", index, out_irq);
 	if (!res)
-		return of_irq_parse_raw(addr, out_irq);
+		return of_irq_parse_raw(addr_buf, out_irq);
 
 	/* Look for the interrupt parent. */
 	p = of_irq_find_parent(device);
@@ -389,7 +396,7 @@ int of_irq_parse_one(struct device_node *device, int index, struct of_phandle_ar
 
 
 	/* Check if there are any interrupt-map translations to process */
-	res = of_irq_parse_raw(addr, out_irq);
+	res = of_irq_parse_raw(addr_buf, out_irq);
  out:
 	of_node_put(p);
 	return res;
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 6007ffcb4752..e738013c6d4f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -35,6 +35,11 @@
 #define PCIE_DEVICEID_SHIFT	16
 
 /* Application registers */
+#define PID				0x000
+#define RTL				GENMASK(15, 11)
+#define RTL_SHIFT			11
+#define AM6_PCI_PG1_RTL_VER		0x15
+
 #define CMD_STATUS			0x004
 #define LTSSM_EN_VAL		        BIT(0)
 #define OB_XLAT_EN_VAL		        BIT(1)
@@ -105,6 +110,8 @@
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
+#define PCI_DEVICE_ID_TI_AM654X		0xb00c
+
 struct ks_pcie_of_data {
 	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
@@ -519,7 +526,11 @@ static int ks_pcie_start_link(struct dw_pcie *pci)
 static void ks_pcie_quirk(struct pci_dev *dev)
 {
 	struct pci_bus *bus = dev->bus;
+	struct keystone_pcie *ks_pcie;
+	struct device *bridge_dev;
 	struct pci_dev *bridge;
+	u32 val;
+
 	static const struct pci_device_id rc_pci_devids[] = {
 		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCIE_RC_K2HK),
 		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
@@ -531,6 +542,11 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 		 .class = PCI_CLASS_BRIDGE_PCI_NORMAL, .class_mask = ~0, },
 		{ 0, },
 	};
+	static const struct pci_device_id am6_pci_devids[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654X),
+		 .class = PCI_CLASS_BRIDGE_PCI << 8, .class_mask = ~0, },
+		{ 0, },
+	};
 
 	if (pci_is_root_bus(bus))
 		bridge = dev;
@@ -552,10 +568,36 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 	 */
 	if (pci_match_id(rc_pci_devids, bridge)) {
 		if (pcie_get_readrq(dev) > 256) {
-			dev_info(&dev->dev, "limiting MRRS to 256\n");
+			dev_info(&dev->dev, "limiting MRRS to 256 bytes\n");
 			pcie_set_readrq(dev, 256);
 		}
 	}
+
+	/*
+	 * Memory transactions fail with PCI controller in AM654 PG1.0
+	 * when MRRS is set to more than 128 bytes. Force the MRRS to
+	 * 128 bytes in all downstream devices.
+	 */
+	if (pci_match_id(am6_pci_devids, bridge)) {
+		bridge_dev = pci_get_host_bridge_device(dev);
+		if (!bridge_dev && !bridge_dev->parent)
+			return;
+
+		ks_pcie = dev_get_drvdata(bridge_dev->parent);
+		if (!ks_pcie)
+			return;
+
+		val = ks_pcie_app_readl(ks_pcie, PID);
+		val &= RTL;
+		val >>= RTL_SHIFT;
+		if (val != AM6_PCI_PG1_RTL_VER)
+			return;
+
+		if (pcie_get_readrq(dev) > 128) {
+			dev_info(&dev->dev, "limiting MRRS to 128 bytes\n");
+			pcie_set_readrq(dev, 128);
+		}
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index 881d420637bf..092c9ac0d26d 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -39,7 +39,6 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 				bool disable_device)
 {
 	struct pci_dev *pdev = php_slot->pdev;
-	int irq = php_slot->irq;
 	u16 ctrl;
 
 	if (php_slot->irq > 0) {
@@ -58,7 +57,7 @@ static void pnv_php_disable_irq(struct pnv_php_slot *php_slot,
 		php_slot->wq = NULL;
 	}
 
-	if (disable_device || irq > 0) {
+	if (disable_device) {
 		if (pdev->msix_enabled)
 			pci_disable_msix(pdev);
 		else if (pdev->msi_enabled)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2d373ab3ccb3..f7592348ebee 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5584,10 +5584,12 @@ static void pci_bus_lock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
 
@@ -5599,8 +5601,10 @@ static void pci_bus_unlock(struct pci_bus *bus)
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
@@ -5608,15 +5612,15 @@ static int pci_bus_trylock(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
+	if (!pci_dev_trylock(bus->self))
+		return 0;
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				pci_dev_unlock(dev);
+			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
-			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
 
@@ -5624,8 +5628,10 @@ static int pci_bus_trylock(struct pci_bus *bus)
 	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
+	pci_dev_unlock(bus->self);
 	return 0;
 }
 
@@ -5657,9 +5663,10 @@ static void pci_slot_lock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		pci_dev_lock(dev);
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
+		else
+			pci_dev_lock(dev);
 	}
 }
 
@@ -5685,14 +5692,13 @@ static int pci_slot_trylock(struct pci_slot *slot)
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		if (!pci_dev_trylock(dev))
-			goto unlock;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate)) {
 				pci_dev_unlock(dev);
 				goto unlock;
 			}
-		}
+		} else if (!pci_dev_trylock(dev))
+			goto unlock;
 	}
 	return 1;
 
@@ -5703,7 +5709,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
 			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
-		pci_dev_unlock(dev);
+		else
+			pci_dev_unlock(dev);
 	}
 	return 0;
 }
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 3966a6ceb1ac..a1c16352c01c 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -638,11 +638,11 @@ static int yenta_search_one_res(struct resource *root, struct resource *res,
 		start = PCIBIOS_MIN_CARDBUS_IO;
 		end = ~0U;
 	} else {
-		unsigned long avail = root->end - root->start;
+		unsigned long avail = resource_size(root);
 		int i;
 		size = BRIDGE_MEM_MAX;
-		if (size > avail/8) {
-			size = (avail+1)/8;
+		if (size > (avail - 1) / 8) {
+			size = avail / 8;
 			/* round size down to next power of 2 */
 			i = 0;
 			while ((size /= 2) != 0)
diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index ac9a9124a36d..cc36fb7616ae 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -847,6 +847,7 @@ static struct phy *xpsgtr_xlate(struct device *dev,
 	phy_type = args->args[1];
 	phy_instance = args->args[2];
 
+	guard(mutex)(&gtr_phy->phy->mutex);
 	ret = xpsgtr_set_lane_type(gtr_phy, phy_type, phy_instance);
 	if (ret < 0) {
 		dev_err(gtr_dev->dev, "Invalid PHY type and/or instance\n");
diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
index 86b95206cb1b..6fb538a13868 100644
--- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -590,7 +590,10 @@ static int __init dell_smbios_init(void)
 	return 0;
 
 fail_sysfs:
-	free_group(platform_device);
+	if (!wmi)
+		exit_dell_smbios_wmi();
+	if (!smm)
+		exit_dell_smbios_smm();
 
 fail_create_group:
 	platform_device_del(platform_device);
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index cd726d4e8fbf..1b65e5e4e40f 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -701,3 +701,95 @@ struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
 
 	return c_rdev;
 }
+
+/*
+ * Check if name is a supply name according to the '*-supply' pattern
+ * return 0 if false
+ * return length of supply name without the -supply
+ */
+static int is_supply_name(const char *name)
+{
+	int strs, i;
+
+	strs = strlen(name);
+	/* string need to be at minimum len(x-supply) */
+	if (strs < 8)
+		return 0;
+	for (i = strs - 6; i > 0; i--) {
+		/* find first '-' and check if right part is supply */
+		if (name[i] != '-')
+			continue;
+		if (strcmp(name + i + 1, "supply") != 0)
+			return 0;
+		return i;
+	}
+	return 0;
+}
+
+/*
+ * of_regulator_bulk_get_all - get multiple regulator consumers
+ *
+ * @dev:	Device to supply
+ * @np:		device node to search for consumers
+ * @consumers:  Configuration of consumers; clients are stored here.
+ *
+ * @return number of regulators on success, an errno on failure.
+ *
+ * This helper function allows drivers to get several regulator
+ * consumers in one operation.  If any of the regulators cannot be
+ * acquired then any regulators that were allocated will be freed
+ * before returning to the caller.
+ */
+int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
+			      struct regulator_bulk_data **consumers)
+{
+	int num_consumers = 0;
+	struct regulator *tmp;
+	struct property *prop;
+	int i, n = 0, ret;
+	char name[64];
+
+	*consumers = NULL;
+
+	/*
+	 * first pass: get numbers of xxx-supply
+	 * second pass: fill consumers
+	 */
+restart:
+	for_each_property_of_node(np, prop) {
+		i = is_supply_name(prop->name);
+		if (i == 0)
+			continue;
+		if (!*consumers) {
+			num_consumers++;
+			continue;
+		} else {
+			memcpy(name, prop->name, i);
+			name[i] = '\0';
+			tmp = regulator_get(dev, name);
+			if (IS_ERR(tmp)) {
+				ret = -EINVAL;
+				goto error;
+			}
+			(*consumers)[n].consumer = tmp;
+			n++;
+			continue;
+		}
+	}
+	if (*consumers)
+		return num_consumers;
+	if (num_consumers == 0)
+		return 0;
+	*consumers = kmalloc_array(num_consumers,
+				   sizeof(struct regulator_bulk_data),
+				   GFP_KERNEL);
+	if (!*consumers)
+		return -ENOMEM;
+	goto restart;
+
+error:
+	while (--n >= 0)
+		regulator_put(consumers[n]->consumer);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_regulator_bulk_get_all);
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 79242dc5272d..dbefc7e77313 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -976,14 +976,16 @@ static int rockchip_spi_suspend(struct device *dev)
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	ret = spi_controller_suspend(ctlr);
 	if (ret < 0)
 		return ret;
 
-	clk_disable_unprepare(rs->spiclk);
-	clk_disable_unprepare(rs->apb_pclk);
+	ret = pm_runtime_force_suspend(dev);
+	if (ret < 0) {
+		spi_controller_resume(ctlr);
+		return ret;
+	}
 
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -994,25 +996,14 @@ static int rockchip_spi_resume(struct device *dev)
 {
 	int ret;
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct rockchip_spi *rs = spi_controller_get_devdata(ctlr);
 
 	pinctrl_pm_select_default_state(dev);
 
-	ret = clk_prepare_enable(rs->apb_pclk);
+	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
 		return ret;
 
-	ret = clk_prepare_enable(rs->spiclk);
-	if (ret < 0)
-		clk_disable_unprepare(rs->apb_pclk);
-
-	ret = spi_controller_resume(ctlr);
-	if (ret < 0) {
-		clk_disable_unprepare(rs->spiclk);
-		clk_disable_unprepare(rs->apb_pclk);
-	}
-
-	return 0;
+	return spi_controller_resume(ctlr);
 }
 #endif /* CONFIG_PM_SLEEP */
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 2b4267a87e65..89abb0709260 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -114,7 +114,7 @@ static int ad9834_write_frequency(struct ad9834_state *st,
 
 	clk_freq = clk_get_rate(st->mclk);
 
-	if (fout > (clk_freq / 2))
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
 	regval = ad9834_calc_freqreg(clk_freq, fout);
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index e5789dfcaff6..d6472de1d4b0 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -104,10 +104,11 @@ static void hv_uio_channel_cb(void *context)
 
 /*
  * Callback from vmbus_event when channel is rescinded.
+ * It is meant for rescind of primary channels only.
  */
 static void hv_uio_rescind(struct vmbus_channel *channel)
 {
-	struct hv_device *hv_dev = channel->primary_channel->device_obj;
+	struct hv_device *hv_dev = channel->device_obj;
 	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
 
 	/*
@@ -118,6 +119,14 @@ static void hv_uio_rescind(struct vmbus_channel *channel)
 
 	/* Wake up reader */
 	uio_event_notify(&pdata->info);
+
+	/*
+	 * With rescind callback registered, rescind path will not unregister the device
+	 * from vmbus when the primary channel is rescinded.
+	 * Without it, rescind handling is incomplete and next onoffer msg does not come.
+	 * Unregister the device from vmbus here.
+	 */
+	vmbus_device_unregister(channel->device_obj);
 }
 
 /* Sysfs API to allow mmap of the ring buffers
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5b761a2a87a7..2cd780c74381 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1305,6 +1305,21 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
+	/*
+	 * STAR 9001285599: This issue affects DWC_usb3 version 3.20a
+	 * only. If the PM TIMER ECM is enabled through GUCTL2[19], the
+	 * link compliance test (TD7.21) may fail. If the ECN is not
+	 * enabled (GUCTL2[19] = 0), the controller will use the old timer
+	 * value (5us), which is still acceptable for the link compliance
+	 * test. Therefore, do not enable PM TIMER ECM in 3.20a by
+	 * setting GUCTL2[19] by default; instead, use GUCTL2[19] = 0.
+	 */
+	if (DWC3_VER_IS(DWC3, 320A)) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg &= ~DWC3_GUCTL2_LC_TIMER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
 	/*
 	 * When configured in HOST mode, after issuing U3/L2 exit controller
 	 * fails to send proper CRC checksum in CRC5 feild. Because of this
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 472a6a7e1558..251bc438bf40 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -404,6 +404,7 @@
 
 /* Global User Control Register 2 */
 #define DWC3_GUCTL2_RST_ACTBITLATER		BIT(14)
+#define DWC3_GUCTL2_LC_TIMER			BIT(19)
 
 /* Global User Control Register 3 */
 #define DWC3_GUCTL3_SPLITDISABLE		BIT(14)
@@ -1232,6 +1233,7 @@ struct dwc3 {
 #define DWC3_REVISION_290A	0x5533290a
 #define DWC3_REVISION_300A	0x5533300a
 #define DWC3_REVISION_310A	0x5533310a
+#define DWC3_REVISION_320A	0x5533320a
 #define DWC3_REVISION_330A	0x5533330a
 
 #define DWC31_REVISION_ANY	0x0
diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index cedf17e38245..1a5a1115c1d9 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -1009,6 +1009,8 @@ static void ast_udc_getstatus(struct ast_udc_dev *udc)
 		break;
 	case USB_RECIP_ENDPOINT:
 		epnum = crq.wIndex & USB_ENDPOINT_NUMBER_MASK;
+		if (epnum >= AST_UDC_NUM_ENDPOINTS)
+			goto stall;
 		status = udc->ep[epnum].stopped;
 		break;
 	default:
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index af619efe8eab..b565c1eb84b3 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -422,6 +422,7 @@ static void uas_data_cmplt(struct urb *urb)
 			uas_log_cmd_state(cmnd, "data cmplt err", status);
 		/* error: no data transfered */
 		scsi_set_resid(cmnd, sdb->length);
+		set_host_byte(cmnd, DID_ERROR);
 	} else {
 		scsi_set_resid(cmnd, sdb->length - urb->actual_length);
 	}
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e6c9c0e08448..89e7e4826efc 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1009,7 +1009,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1301,7 +1302,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e08688844f1e..66d1f34c3fc6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -324,8 +324,16 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 	}
 
 	owner = btrfs_header_owner(buf);
-	BUG_ON(owner == BTRFS_TREE_RELOC_OBJECTID &&
-	       !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF));
+	if (unlikely(owner == BTRFS_TREE_RELOC_OBJECTID &&
+		     !(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF))) {
+		btrfs_crit(fs_info,
+"found tree block at bytenr %llu level %d root %llu refs %llu flags %llx without full backref flag set",
+			   buf->start, btrfs_header_level(buf),
+			   btrfs_root_id(root), refs, flags);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
 
 	if (refs > 1) {
 		if ((owner == root->root_key.objectid ||
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 853b1f96b1fd..cca1acf2e037 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1553,7 +1553,6 @@ struct btrfs_drop_extents_args {
 struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
-	bool fsync_skip_inode_lock;
 };
 
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 528cd88a77fd..0d97c8ee6b4f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5141,7 +5141,15 @@ static noinline void reada_walk_down(struct btrfs_trans_handle *trans,
 		/* We don't care about errors in readahead. */
 		if (ret < 0)
 			continue;
-		BUG_ON(refs == 0);
+
+		/*
+		 * This could be racey, it's conceivable that we raced and end
+		 * up with a bogus refs count, if that's the case just skip, if
+		 * we are actually corrupt we will notice when we look up
+		 * everything again with our locks.
+		 */
+		if (refs == 0)
+			continue;
 
 		if (wc->stage == DROP_REFERENCE) {
 			if (refs == 1)
@@ -5200,7 +5208,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 	if (lookup_info &&
 	    ((wc->stage == DROP_REFERENCE && wc->refs[level] != 1) ||
 	     (wc->stage == UPDATE_BACKREF && !(wc->flags[level] & flag)))) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_lookup_extent_info(trans, fs_info,
 					       eb->start, level, 1,
 					       &wc->refs[level],
@@ -5208,7 +5216,11 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 		BUG_ON(ret == -ENOMEM);
 		if (ret)
 			return ret;
-		BUG_ON(wc->refs[level] == 0);
+		if (unlikely(wc->refs[level] == 0)) {
+			btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+				  eb->start);
+			return -EUCLEAN;
+		}
 	}
 
 	if (wc->stage == DROP_REFERENCE) {
@@ -5224,7 +5236,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 
 	/* wc->stage == UPDATE_BACKREF */
 	if (!(wc->flags[level] & flag)) {
-		BUG_ON(!path->locks[level]);
+		ASSERT(path->locks[level]);
 		ret = btrfs_inc_ref(trans, root, eb, 1);
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_dec_ref(trans, root, eb, 0);
@@ -5338,8 +5350,9 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 		goto out_unlock;
 
 	if (unlikely(wc->refs[level - 1] == 0)) {
-		btrfs_err(fs_info, "Missing references.");
-		ret = -EIO;
+		btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+			  bytenr);
+		ret = -EUCLEAN;
 		goto out_unlock;
 	}
 	*lookup_info = 0;
@@ -5540,7 +5553,12 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
 				path->locks[level] = 0;
 				return ret;
 			}
-			BUG_ON(wc->refs[level] == 0);
+			if (unlikely(wc->refs[level] == 0)) {
+				btrfs_tree_unlock_rw(eb, path->locks[level]);
+				btrfs_err(fs_info, "bytenr %llu has 0 references, expect > 0",
+					  eb->start);
+				return -EUCLEAN;
+			}
 			if (wc->refs[level] == 1) {
 				btrfs_tree_unlock_rw(eb, path->locks[level]);
 				path->locks[level] = 0;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e23d178f9778..c8231677c79e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1534,13 +1534,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_ERR_OR_NULL(dio)) {
 		err = PTR_ERR_OR_ZERO(dio);
 	} else {
-		struct btrfs_file_private stack_private = { 0 };
-		struct btrfs_file_private *private;
-		const bool have_private = (file->private_data != NULL);
-
-		if (!have_private)
-			file->private_data = &stack_private;
-
 		/*
 		 * If we have a synchoronous write, we must make sure the fsync
 		 * triggered by the iomap_dio_complete() call below doesn't
@@ -1549,13 +1542,10 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		 * partial writes due to the input buffer (or parts of it) not
 		 * being already faulted in.
 		 */
-		private = file->private_data;
-		private->fsync_skip_inode_lock = true;
+		ASSERT(current->journal_info == NULL);
+		current->journal_info = BTRFS_TRANS_DIO_WRITE_STUB;
 		err = iomap_dio_complete(dio);
-		private->fsync_skip_inode_lock = false;
-
-		if (!have_private)
-			file->private_data = NULL;
+		current->journal_info = NULL;
 	}
 
 	/* No increment (+=) because iomap returns a cumulative value. */
@@ -1795,7 +1785,6 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
  */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct btrfs_file_private *private = file->private_data;
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -1805,7 +1794,13 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret = 0, err;
 	u64 len;
 	bool full_sync;
-	const bool skip_ilock = (private ? private->fsync_skip_inode_lock : false);
+	bool skip_ilock = false;
+
+	if (current->journal_info == BTRFS_TRANS_DIO_WRITE_STUB) {
+		skip_ilock = true;
+		current->journal_info = NULL;
+		lockdep_assert_held(&inode->i_rwsem);
+	}
 
 	trace_btrfs_sync_file(file, datasync);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 934e360d1aef..e5017b2ade57 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5890,7 +5890,7 @@ struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry)
 	struct inode *inode;
 	struct btrfs_root *root = BTRFS_I(dir)->root;
 	struct btrfs_root *sub_root = root;
-	struct btrfs_key location;
+	struct btrfs_key location = { 0 };
 	u8 di_type = 0;
 	int ret = 0;
 
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 970ff316069d..8b88446df36d 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -11,6 +11,12 @@
 #include "delayed-ref.h"
 #include "ctree.h"
 
+/*
+ * Signal that a direct IO write is in progress, to avoid deadlock for sync
+ * direct IO writes when fsync is called during the direct IO write path.
+ */
+#define BTRFS_TRANS_DIO_WRITE_STUB	((void *) 1)
+
 enum btrfs_trans_state {
 	TRANS_STATE_RUNNING,
 	TRANS_STATE_COMMIT_START,
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 19353a2f44bb..2ef773d40ffd 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -353,7 +353,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 		read_unlock(&sbi->s_journal->j_state_lock);
 	}
 	spin_lock(&sbi->s_fc_lock);
-	if (sbi->s_fc_ineligible_tid < tid)
+	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
 		sbi->s_fc_ineligible_tid = tid;
 	spin_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
@@ -1235,7 +1235,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 	if (ret == -EALREADY) {
 		/* There was an ongoing commit, check if we need to restart */
 		if (atomic_read(&sbi->s_fc_subtid) <= subtid &&
-			commit_tid > journal->j_commit_sequence)
+		    tid_gt(commit_tid, journal->j_commit_sequence))
 			goto restart_fc;
 		ext4_fc_update_stats(sb, EXT4_FC_STATUS_SKIPPED, 0, 0,
 				commit_tid);
@@ -1310,7 +1310,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (iter->i_sync_tid <= tid)
+		if (tid_geq(tid, iter->i_sync_tid))
 			ext4_fc_reset_inode(&iter->vfs_inode);
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
@@ -1341,7 +1341,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
 				&sbi->s_fc_q[FC_Q_MAIN]);
 
-	if (tid >= sbi->s_fc_ineligible_tid) {
+	if (tid_geq(tid, sbi->s_fc_ineligible_tid)) {
 		sbi->s_fc_ineligible_tid = 0;
 		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 96a717f73ce3..7e0d4f08a0cf 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -476,6 +476,8 @@ static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 	req->in.h.opcode = args->opcode;
 	req->in.h.nodeid = args->nodeid;
 	req->args = args;
+	if (args->is_ext)
+		req->in.h.total_extlen = args->in_args[args->ext_idx].size / 8;
 	if (args->end)
 		__set_bit(FR_ASYNC, &req->flags);
 }
@@ -1498,7 +1500,7 @@ static int fuse_notify_inval_entry(struct fuse_conn *fc, unsigned int size,
 	buf[outarg.namelen] = 0;
 
 	down_read(&fc->killsb);
-	err = fuse_reverse_inval_entry(fc, outarg.parent, 0, &name);
+	err = fuse_reverse_inval_entry(fc, outarg.parent, 0, &name, outarg.flags);
 	up_read(&fc->killsb);
 	kfree(buf);
 	return err;
@@ -1546,7 +1548,7 @@ static int fuse_notify_delete(struct fuse_conn *fc, unsigned int size,
 	buf[outarg.namelen] = 0;
 
 	down_read(&fc->killsb);
-	err = fuse_reverse_inval_entry(fc, outarg.parent, outarg.child, &name);
+	err = fuse_reverse_inval_entry(fc, outarg.parent, outarg.child, &name, 0);
 	up_read(&fc->killsb);
 	kfree(buf);
 	return err;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 936a24b646ce..aa2be4c1ea8f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -470,7 +470,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 }
 
 static int get_security_context(struct dentry *entry, umode_t mode,
-				void **security_ctx, u32 *security_ctxlen)
+				struct fuse_in_arg *ext)
 {
 	struct fuse_secctx *fctx;
 	struct fuse_secctx_header *header;
@@ -517,14 +517,42 @@ static int get_security_context(struct dentry *entry, umode_t mode,
 
 		memcpy(ptr, ctx, ctxlen);
 	}
-	*security_ctxlen = total_len;
-	*security_ctx = header;
+	ext->size = total_len;
+	ext->value = header;
 	err = 0;
 out_err:
 	kfree(ctx);
 	return err;
 }
 
+static int get_create_ext(struct fuse_args *args, struct dentry *dentry,
+			  umode_t mode)
+{
+	struct fuse_conn *fc = get_fuse_conn_super(dentry->d_sb);
+	struct fuse_in_arg ext = { .size = 0, .value = NULL };
+	int err = 0;
+
+	if (fc->init_security)
+		err = get_security_context(dentry, mode, &ext);
+
+	if (!err && ext.size) {
+		WARN_ON(args->in_numargs >= ARRAY_SIZE(args->in_args));
+		args->is_ext = true;
+		args->ext_idx = args->in_numargs++;
+		args->in_args[args->ext_idx] = ext;
+	} else {
+		kfree(ext.value);
+	}
+
+	return err;
+}
+
+static void free_ext_value(struct fuse_args *args)
+{
+	if (args->is_ext)
+		kfree(args->in_args[args->ext_idx].value);
+}
+
 /*
  * Atomic create+open operation
  *
@@ -545,8 +573,6 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	struct fuse_entry_out outentry;
 	struct fuse_inode *fi;
 	struct fuse_file *ff;
-	void *security_ctx = NULL;
-	u32 security_ctxlen;
 	bool trunc = flags & O_TRUNC;
 
 	/* Userspace expects S_IFREG in create mode */
@@ -590,19 +616,12 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	args.out_args[1].size = sizeof(outopen);
 	args.out_args[1].value = &outopen;
 
-	if (fm->fc->init_security) {
-		err = get_security_context(entry, mode, &security_ctx,
-					   &security_ctxlen);
-		if (err)
-			goto out_put_forget_req;
-
-		args.in_numargs = 3;
-		args.in_args[2].size = security_ctxlen;
-		args.in_args[2].value = security_ctx;
-	}
+	err = get_create_ext(&args, entry, mode);
+	if (err)
+		goto out_free_ff;
 
 	err = fuse_simple_request(fm, &args);
-	kfree(security_ctx);
+	free_ext_value(&args);
 	if (err)
 		goto out_free_ff;
 
@@ -709,8 +728,6 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	struct dentry *d;
 	int err;
 	struct fuse_forget_link *forget;
-	void *security_ctx = NULL;
-	u32 security_ctxlen;
 
 	if (fuse_is_bad(dir))
 		return -EIO;
@@ -725,21 +742,14 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	args->out_args[0].size = sizeof(outarg);
 	args->out_args[0].value = &outarg;
 
-	if (fm->fc->init_security && args->opcode != FUSE_LINK) {
-		err = get_security_context(entry, mode, &security_ctx,
-					   &security_ctxlen);
+	if (args->opcode != FUSE_LINK) {
+		err = get_create_ext(args, entry, mode);
 		if (err)
 			goto out_put_forget_req;
-
-		BUG_ON(args->in_numargs != 2);
-
-		args->in_numargs = 3;
-		args->in_args[2].size = security_ctxlen;
-		args->in_args[2].value = security_ctx;
 	}
 
 	err = fuse_simple_request(fm, args);
-	kfree(security_ctx);
+	free_ext_value(args);
 	if (err)
 		goto out_put_forget_req;
 
@@ -1174,7 +1184,7 @@ int fuse_update_attributes(struct inode *inode, struct file *file, u32 mask)
 }
 
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
-			     u64 child_nodeid, struct qstr *name)
+			     u64 child_nodeid, struct qstr *name, u32 flags)
 {
 	int err = -ENOTDIR;
 	struct inode *parent;
@@ -1201,7 +1211,9 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 		goto unlock;
 
 	fuse_dir_changed(parent);
-	fuse_invalidate_entry(entry);
+	if (!(flags & FUSE_EXPIRE_ONLY))
+		d_invalidate(entry);
+	fuse_invalidate_entry_cache(entry);
 
 	if (child_nodeid != 0 && d_really_is_positive(entry)) {
 		inode_lock(d_inode(entry));
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c996c0ef8c63..0df1311afb87 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1563,14 +1563,47 @@ static ssize_t fuse_direct_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return res;
 }
 
+static bool fuse_direct_write_extending_i_size(struct kiocb *iocb,
+					       struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
+}
+
 static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
 	struct fuse_io_priv io = FUSE_IO_PRIV_SYNC(iocb);
 	ssize_t res;
+	bool exclusive_lock =
+		!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES) ||
+		iocb->ki_flags & IOCB_APPEND ||
+		fuse_direct_write_extending_i_size(iocb, from);
+
+	/*
+	 * Take exclusive lock if
+	 * - Parallel direct writes are disabled - a user space decision
+	 * - Parallel direct writes are enabled and i_size is being extended.
+	 *   This might not be needed at all, but needs further investigation.
+	 */
+	if (exclusive_lock)
+		inode_lock(inode);
+	else {
+		inode_lock_shared(inode);
+
+		/* A race with truncate might have come up as the decision for
+		 * the lock type was done without holding the lock, check again.
+		 */
+		if (fuse_direct_write_extending_i_size(iocb, from)) {
+			inode_unlock_shared(inode);
+			inode_lock(inode);
+			exclusive_lock = true;
+		}
+	}
 
-	/* Don't allow parallel writes to the same file */
-	inode_lock(inode);
 	res = generic_write_checks(iocb, from);
 	if (res > 0) {
 		if (!is_sync_kiocb(iocb) && iocb->ki_flags & IOCB_DIRECT) {
@@ -1581,7 +1614,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			fuse_write_update_attr(inode, iocb->ki_pos, res);
 		}
 	}
-	inode_unlock(inode);
+	if (exclusive_lock)
+		inode_unlock(inode);
+	else
+		inode_unlock_shared(inode);
 
 	return res;
 }
@@ -1703,10 +1739,16 @@ __acquires(fi->lock)
 	fuse_writepage_finish(fm, wpa);
 	spin_unlock(&fi->lock);
 
-	/* After fuse_writepage_finish() aux request list is private */
+	/* After rb_erase() aux request list is private */
 	for (aux = wpa->next; aux; aux = next) {
+		struct backing_dev_info *bdi = inode_to_bdi(aux->inode);
+
 		next = aux->next;
 		aux->next = NULL;
+
+		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
+		dec_node_page_state(aux->ia.ap.pages[0], NR_WRITEBACK_TEMP);
+		wb_writeout_inc(&bdi->wb);
 		fuse_writepage_free(aux);
 	}
 
@@ -2931,6 +2973,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	if (iov_iter_rw(iter) == WRITE) {
 		fuse_write_update_attr(inode, pos, ret);
+		/* For extending writes we already hold exclusive lock */
 		if (ret < 0 && offset + count > i_size)
 			fuse_do_truncate(file);
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 66c2a9999468..6c3ec70c1b70 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -264,8 +264,9 @@ struct fuse_page_desc {
 struct fuse_args {
 	uint64_t nodeid;
 	uint32_t opcode;
-	unsigned short in_numargs;
-	unsigned short out_numargs;
+	uint8_t in_numargs;
+	uint8_t out_numargs;
+	uint8_t ext_idx;
 	bool force:1;
 	bool noreply:1;
 	bool nocreds:1;
@@ -276,6 +277,7 @@ struct fuse_args {
 	bool page_zeroing:1;
 	bool page_replace:1;
 	bool may_block:1;
+	bool is_ext:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
@@ -1235,7 +1237,7 @@ int fuse_reverse_inval_inode(struct fuse_conn *fc, u64 nodeid,
  * then the dentry is unhashed (d_delete()).
  */
 int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
-			     u64 child_nodeid, struct qstr *name);
+			     u64 child_nodeid, struct qstr *name, u32 flags);
 
 int fuse_do_open(struct fuse_mount *fm, u64 nodeid, struct file *file,
 		 bool isdir);
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 64618548835b..332cc885b815 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1327,7 +1327,8 @@ void fuse_send_init(struct fuse_mount *fm)
 		FUSE_ABORT_ERROR | FUSE_MAX_PAGES | FUSE_CACHE_SYMLINKS |
 		FUSE_NO_OPENDIR_SUPPORT | FUSE_EXPLICIT_INVAL_DATA |
 		FUSE_HANDLE_KILLPRIV_V2 | FUSE_SETXATTR_EXT | FUSE_INIT_EXT |
-		FUSE_SECURITY_CTX;
+		FUSE_SECURITY_CTX |
+		FUSE_HAS_EXPIRE_ONLY;
 #ifdef CONFIG_FUSE_DAX
 	if (fm->fc->dax)
 		flags |= FUSE_MAP_ALIGNMENT;
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 0d3e7177fce0..4def41e607cc 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -81,7 +81,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 	}
 	ret = fuse_simple_request(fm, &args);
 	if (!ret && !size)
-		ret = min_t(ssize_t, outarg.size, XATTR_SIZE_MAX);
+		ret = min_t(size_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
 		fm->fc->no_getxattr = 1;
 		ret = -EOPNOTSUPP;
@@ -143,7 +143,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	}
 	ret = fuse_simple_request(fm, &args);
 	if (!ret && !size)
-		ret = min_t(ssize_t, outarg.size, XATTR_LIST_MAX);
+		ret = min_t(size_t, outarg.size, XATTR_LIST_MAX);
 	if (ret > 0 && size)
 		ret = fuse_verify_xattr_list(list, ret);
 	if (ret == -ENOSYS) {
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 05ae23657527..f7b4df29ac5f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -47,6 +47,7 @@
 #include <linux/vfs.h>
 #include <linux/inet.h>
 #include <linux/in6.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <net/ipv6.h>
 #include <linux/netdevice.h>
@@ -219,6 +220,7 @@ static int __nfs_list_for_each_server(struct list_head *head,
 		ret = fn(server, data);
 		if (ret)
 			goto out;
+		cond_resched();
 		rcu_read_lock();
 	}
 	rcu_read_unlock();
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index a9b8d77c8c1d..ce30b51ac593 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -708,6 +708,33 @@ static void nilfs_finish_roll_forward(struct the_nilfs *nilfs,
 	brelse(bh);
 }
 
+/**
+ * nilfs_abort_roll_forward - cleaning up after a failed rollforward recovery
+ * @nilfs: nilfs object
+ */
+static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
+{
+	struct nilfs_inode_info *ii, *n;
+	LIST_HEAD(head);
+
+	/* Abandon inodes that have read recovery data */
+	spin_lock(&nilfs->ns_inode_lock);
+	list_splice_init(&nilfs->ns_dirty_files, &head);
+	spin_unlock(&nilfs->ns_inode_lock);
+	if (list_empty(&head))
+		return;
+
+	set_nilfs_purging(nilfs);
+	list_for_each_entry_safe(ii, n, &head, i_dirty) {
+		spin_lock(&nilfs->ns_inode_lock);
+		list_del_init(&ii->i_dirty);
+		spin_unlock(&nilfs->ns_inode_lock);
+
+		iput(&ii->vfs_inode);
+	}
+	clear_nilfs_purging(nilfs);
+}
+
 /**
  * nilfs_salvage_orphan_logs - salvage logs written after the latest checkpoint
  * @nilfs: nilfs object
@@ -766,15 +793,19 @@ int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 		if (unlikely(err)) {
 			nilfs_err(sb, "error %d writing segment for recovery",
 				  err);
-			goto failed;
+			goto put_root;
 		}
 
 		nilfs_finish_roll_forward(nilfs, ri);
 	}
 
- failed:
+put_root:
 	nilfs_put_root(root);
 	return err;
+
+failed:
+	nilfs_abort_roll_forward(nilfs);
+	goto put_root;
 }
 
 /**
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 5110c50be291..6bc8ad0d41f8 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1833,6 +1833,9 @@ static void nilfs_segctor_abort_construction(struct nilfs_sc_info *sci,
 	nilfs_abort_logs(&logs, ret ? : err);
 
 	list_splice_tail_init(&sci->sc_segbufs, &logs);
+	if (list_empty(&logs))
+		return; /* if the first segment buffer preparation failed */
+
 	nilfs_cancel_segusage(&logs, nilfs->ns_sufile);
 	nilfs_free_incomplete_logs(&logs, nilfs);
 
@@ -2077,7 +2080,7 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 
 		err = nilfs_segctor_begin_construction(sci, nilfs);
 		if (unlikely(err))
-			goto out;
+			goto failed;
 
 		/* Update time stamp */
 		sci->sc_seg_ctime = ktime_get_real_seconds();
@@ -2140,10 +2143,9 @@ static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
 	return err;
 
  failed_to_write:
-	if (sci->sc_stage.flags & NILFS_CF_IFILE_STARTED)
-		nilfs_redirty_inodes(&sci->sc_dirty_files);
-
  failed:
+	if (mode == SC_LSEG_SR && nilfs_sc_cstage_get(sci) >= NILFS_ST_IFILE)
+		nilfs_redirty_inodes(&sci->sc_dirty_files);
 	if (nilfs_doing_gc())
 		nilfs_redirty_inodes(&sci->sc_gc_inodes);
 	nilfs_segctor_abort_construction(sci, nilfs, err);
diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 379d22e28ed6..905c7eadf967 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -836,9 +836,15 @@ ssize_t nilfs_dev_revision_show(struct nilfs_dev_attr *attr,
 				struct the_nilfs *nilfs,
 				char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
-	u32 major = le32_to_cpu(sbp[0]->s_rev_level);
-	u16 minor = le16_to_cpu(sbp[0]->s_minor_rev_level);
+	struct nilfs_super_block *raw_sb;
+	u32 major;
+	u16 minor;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	major = le32_to_cpu(raw_sb->s_rev_level);
+	minor = le16_to_cpu(raw_sb->s_minor_rev_level);
+	up_read(&nilfs->ns_sem);
 
 	return sysfs_emit(buf, "%d.%d\n", major, minor);
 }
@@ -856,8 +862,13 @@ ssize_t nilfs_dev_device_size_show(struct nilfs_dev_attr *attr,
 				    struct the_nilfs *nilfs,
 				    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
-	u64 dev_size = le64_to_cpu(sbp[0]->s_dev_size);
+	struct nilfs_super_block *raw_sb;
+	u64 dev_size;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	dev_size = le64_to_cpu(raw_sb->s_dev_size);
+	up_read(&nilfs->ns_sem);
 
 	return sysfs_emit(buf, "%llu\n", dev_size);
 }
@@ -879,9 +890,15 @@ ssize_t nilfs_dev_uuid_show(struct nilfs_dev_attr *attr,
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
+	struct nilfs_super_block *raw_sb;
+	ssize_t len;
 
-	return sysfs_emit(buf, "%pUb\n", sbp[0]->s_uuid);
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	len = sysfs_emit(buf, "%pUb\n", raw_sb->s_uuid);
+	up_read(&nilfs->ns_sem);
+
+	return len;
 }
 
 static
@@ -889,10 +906,16 @@ ssize_t nilfs_dev_volume_name_show(struct nilfs_dev_attr *attr,
 				    struct the_nilfs *nilfs,
 				    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
+	struct nilfs_super_block *raw_sb;
+	ssize_t len;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	len = scnprintf(buf, sizeof(raw_sb->s_volume_name), "%s\n",
+			raw_sb->s_volume_name);
+	up_read(&nilfs->ns_sem);
 
-	return scnprintf(buf, sizeof(sbp[0]->s_volume_name), "%s\n",
-			 sbp[0]->s_volume_name);
+	return len;
 }
 
 static const char dev_readme_str[] =
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index dcd689ed4baa..a4ab0164d150 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -272,9 +272,12 @@ struct inode *dir_search_u(struct inode *dir, const struct cpu_str *uni,
 	return err == -ENOENT ? NULL : err ? ERR_PTR(err) : inode;
 }
 
-static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
-			       const struct NTFS_DE *e, u8 *name,
-			       struct dir_context *ctx)
+/*
+ * returns false if 'ctx' if full
+ */
+static inline bool ntfs_dir_emit(struct ntfs_sb_info *sbi,
+				 struct ntfs_inode *ni, const struct NTFS_DE *e,
+				 u8 *name, struct dir_context *ctx)
 {
 	const struct ATTR_FILE_NAME *fname;
 	unsigned long ino;
@@ -284,29 +287,29 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	fname = Add2Ptr(e, sizeof(struct NTFS_DE));
 
 	if (fname->type == FILE_NAME_DOS)
-		return 0;
+		return true;
 
 	if (!mi_is_ref(&ni->mi, &fname->home))
-		return 0;
+		return true;
 
 	ino = ino_get(&e->ref);
 
 	if (ino == MFT_REC_ROOT)
-		return 0;
+		return true;
 
 	/* Skip meta files. Unless option to show metafiles is set. */
 	if (!sbi->options->showmeta && ntfs_is_meta_file(sbi, ino))
-		return 0;
+		return true;
 
 	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
-		return 0;
+		return true;
 
 	name_len = ntfs_utf16_to_nls(sbi, fname->name, fname->name_len, name,
 				     PATH_MAX);
 	if (name_len <= 0) {
 		ntfs_warn(sbi->sb, "failed to convert name for inode %lx.",
 			  ino);
-		return 0;
+		return true;
 	}
 
 	/*
@@ -336,17 +339,20 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		}
 	}
 
-	return !dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
+	return dir_emit(ctx, (s8 *)name, name_len, ino, dt_type);
 }
 
 /*
  * ntfs_read_hdr - Helper function for ntfs_readdir().
+ *
+ * returns 0 if ok.
+ * returns -EINVAL if directory is corrupted.
+ * returns +1 if 'ctx' is full.
  */
 static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			 const struct INDEX_HDR *hdr, u64 vbo, u64 pos,
 			 u8 *name, struct dir_context *ctx)
 {
-	int err;
 	const struct NTFS_DE *e;
 	u32 e_size;
 	u32 end = le32_to_cpu(hdr->used);
@@ -354,12 +360,12 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 
 	for (;; off += e_size) {
 		if (off + sizeof(struct NTFS_DE) > end)
-			return -1;
+			return -EINVAL;
 
 		e = Add2Ptr(hdr, off);
 		e_size = le16_to_cpu(e->size);
 		if (e_size < sizeof(struct NTFS_DE) || off + e_size > end)
-			return -1;
+			return -EINVAL;
 
 		if (de_is_last(e))
 			return 0;
@@ -369,14 +375,15 @@ static int ntfs_read_hdr(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 			continue;
 
 		if (le16_to_cpu(e->key_size) < SIZEOF_ATTRIBUTE_FILENAME)
-			return -1;
+			return -EINVAL;
 
 		ctx->pos = vbo + off;
 
 		/* Submit the name to the filldir callback. */
-		err = ntfs_filldir(sbi, ni, e, name, ctx);
-		if (err)
-			return err;
+		if (!ntfs_dir_emit(sbi, ni, e, name, ctx)) {
+			/* ctx is full. */
+			return +1;
+		}
 	}
 }
 
@@ -475,8 +482,6 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
-			ntfs_inode_err(dir, "Looks like your dir is corrupt");
-			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}
@@ -499,9 +504,16 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 	__putname(name);
 	put_indx_node(node);
 
-	if (err == -ENOENT) {
+	if (err == 1) {
+		/* 'ctx' is full. */
+		err = 0;
+	} else if (err == -ENOENT) {
 		err = 0;
 		ctx->pos = pos;
+	} else if (err < 0) {
+		if (err == -EINVAL)
+			ntfs_inode_err(dir, "directory corrupted");
+		ctx->pos = eod;
 	}
 
 	return err;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 6cce71cc750e..7bfdc91fae1e 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1601,8 +1601,10 @@ int ni_delete_all(struct ntfs_inode *ni)
 		asize = le32_to_cpu(attr->size);
 		roff = le16_to_cpu(attr->nres.run_off);
 
-		if (roff > asize)
+		if (roff > asize) {
+			_ntfs_bad_inode(&ni->vfs_inode);
 			return -EINVAL;
+		}
 
 		/* run==1 means unpack and deallocate. */
 		run_unpack_ex(RUN_DEALLOCATE, sbi, ni->mi.rno, svcn, evcn, svcn,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2291081653a8..5e9478f31d47 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3443,13 +3443,15 @@ static long smb3_zero_data(struct file *file, struct cifs_tcon *tcon,
 }
 
 static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
-			    loff_t offset, loff_t len, bool keep_size)
+			    unsigned long long offset, unsigned long long len,
+			    bool keep_size)
 {
 	struct cifs_ses *ses = tcon->ses;
 	struct inode *inode = file_inode(file);
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	struct cifsFileInfo *cfile = file->private_data;
-	unsigned long long new_size;
+	struct netfs_inode *ictx = netfs_inode(inode);
+	unsigned long long i_size, new_size, remote_size;
 	long rc;
 	unsigned int xid;
 	__le64 eof;
@@ -3462,6 +3464,16 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 	inode_lock(inode);
 	filemap_invalidate_lock(inode->i_mapping);
 
+	i_size = i_size_read(inode);
+	remote_size = ictx->remote_i_size;
+	if (offset + len >= remote_size && offset < i_size) {
+		unsigned long long top = umin(offset + len, i_size);
+
+		rc = filemap_write_and_wait_range(inode->i_mapping, offset, top - 1);
+		if (rc < 0)
+			goto zero_range_exit;
+	}
+
 	/*
 	 * We zero the range through ioctl, so we need remove the page caches
 	 * first, otherwise the data may be inconsistent with the server.
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7263889a772d..898622b52b48 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -1703,6 +1703,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 		rc = ksmbd_session_register(conn, sess);
 		if (rc)
 			goto out_err;
+
+		conn->binding = false;
 	} else if (conn->dialect >= SMB30_PROT_ID &&
 		   (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
 		   req->Flags & SMB2_SESSION_REQ_FLAG_BINDING) {
@@ -1781,6 +1783,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			sess = NULL;
 			goto out_err;
 		}
+
+		conn->binding = false;
 	}
 	work->sess = sess;
 
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 0012919309f1..25f7c86ba9b9 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -622,8 +622,10 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 		for_each_netdev(&init_net, netdev) {
 			if (netif_is_bridge_port(netdev))
 				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL)))
+			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
+				rtnl_unlock();
 				return -ENOMEM;
+			}
 		}
 		rtnl_unlock();
 		bind_additional_ifaces = 1;
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 24463145b351..f31649080a88 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -276,8 +276,13 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		if (err < 0)
 			goto failed_read;
 
-		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_size = le32_to_cpu(sqsh_ino->symlink_size);
+		if (inode->i_size > PAGE_SIZE) {
+			ERROR("Corrupted symlink\n");
+			return -EINVAL;
+		}
+
+		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		inode->i_op = &squashfs_symlink_inode_ops;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &squashfs_symlink_aops;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 3b6419f29a4c..fa790be4f19f 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1084,12 +1084,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 	struct udf_part_map *map;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct partitionHeaderDesc *phd;
+	u32 sum;
 	int err;
 
 	map = &sbi->s_partmaps[p_index];
 
 	map->s_partition_len = le32_to_cpu(p->partitionLength); /* blocks */
 	map->s_partition_root = le32_to_cpu(p->partitionStartingLocation);
+	if (check_add_overflow(map->s_partition_root, map->s_partition_len,
+			       &sum)) {
+		udf_err(sb, "Partition %d has invalid location %u + %u\n",
+			p_index, map->s_partition_root, map->s_partition_len);
+		return -EFSCORRUPTED;
+	}
 
 	if (p->accessType == cpu_to_le32(PD_ACCESS_TYPE_READ_ONLY))
 		map->s_partition_flags |= UDF_PART_FLAG_READ_ONLY;
@@ -1145,6 +1152,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		bitmap->s_extPosition = le32_to_cpu(
 				phd->unallocSpaceBitmap.extPosition);
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_BITMAP;
+		/* Check whether math over bitmap won't overflow. */
+		if (check_add_overflow(map->s_partition_len,
+				       sizeof(struct spaceBitmapDesc) << 3,
+				       &sum)) {
+			udf_err(sb, "Partition %d is too long (%u)\n", p_index,
+				map->s_partition_len);
+			return -EFSCORRUPTED;
+		}
 		udf_debug("unallocSpaceBitmap (part %d) @ %u\n",
 			  p_index, bitmap->s_extPosition);
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index eefb0948110a..971186f0b7b0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -92,6 +92,10 @@ extern const int mmap_rnd_compat_bits_max;
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
+#ifndef PHYSMEM_END
+# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
+#endif
+
 #include <asm/page.h>
 #include <asm/processor.h>
 
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index a9ca87a8f4e6..60bc7e143869 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -244,6 +244,8 @@ int regulator_disable_deferred(struct regulator *regulator, int ms);
 
 int __must_check regulator_bulk_get(struct device *dev, int num_consumers,
 				    struct regulator_bulk_data *consumers);
+int __must_check of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
+					   struct regulator_bulk_data **consumers);
 int __must_check devm_regulator_bulk_get(struct device *dev, int num_consumers,
 					 struct regulator_bulk_data *consumers);
 void devm_regulator_bulk_put(struct regulator_bulk_data *consumers);
@@ -479,6 +481,20 @@ static inline int devm_regulator_bulk_get(struct device *dev, int num_consumers,
 	return 0;
 }
 
+static inline int of_regulator_bulk_get_all(struct device *dev, struct device_node *np,
+					    struct regulator_bulk_data **consumers)
+{
+	return 0;
+}
+
+static inline int devm_regulator_bulk_get_const(
+	struct device *dev, int num_consumers,
+	const struct regulator_bulk_data *in_consumers,
+	struct regulator_bulk_data **out_consumers)
+{
+	return 0;
+}
+
 static inline int regulator_bulk_enable(int num_consumers,
 					struct regulator_bulk_data *consumers)
 {
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9df7e29386bc..98c0a82bd533 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -187,7 +187,6 @@ struct blocked_key {
 struct smp_csrk {
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 link_type;
 	u8 type;
 	u8 val[16];
 };
@@ -197,7 +196,6 @@ struct smp_ltk {
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
 	u8 bdaddr_type;
-	u8 link_type;
 	u8 authenticated;
 	u8 type;
 	u8 enc_size;
@@ -212,7 +210,6 @@ struct smp_irk {
 	bdaddr_t rpa;
 	bdaddr_t bdaddr;
 	u8 addr_type;
-	u8 link_type;
 	u8 val[16];
 };
 
@@ -220,8 +217,6 @@ struct link_key {
 	struct list_head list;
 	struct rcu_head rcu;
 	bdaddr_t bdaddr;
-	u8 bdaddr_type;
-	u8 link_type;
 	u8 type;
 	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 868d6909b718..6245928d76ee 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1390,6 +1390,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_TILE_VER_GFX10 2
 #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
 #define AMD_FMT_MOD_TILE_VER_GFX11 4
+#define AMD_FMT_MOD_TILE_VER_GFX12 5
 
 /*
  * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
@@ -1400,6 +1401,8 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 /*
  * 64K_D for non-32 bpp is the same for GFX9/GFX10/GFX10_RBPLUS and hence has
  * GFX9 as canonical version.
+ *
+ * 64K_D_2D on GFX12 is identical to 64K_D on GFX11.
  */
 #define AMD_FMT_MOD_TILE_GFX9_64K_D 10
 #define AMD_FMT_MOD_TILE_GFX9_64K_S_X 25
@@ -1407,6 +1410,21 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_TILE_GFX9_64K_R_X 27
 #define AMD_FMT_MOD_TILE_GFX11_256K_R_X 31
 
+/* Gfx12 swizzle modes:
+ *    0 - LINEAR
+ *    1 - 256B_2D  - 2D block dimensions
+ *    2 - 4KB_2D
+ *    3 - 64KB_2D
+ *    4 - 256KB_2D
+ *    5 - 4KB_3D   - 3D block dimensions
+ *    6 - 64KB_3D
+ *    7 - 256KB_3D
+ */
+#define AMD_FMT_MOD_TILE_GFX12_256B_2D 1
+#define AMD_FMT_MOD_TILE_GFX12_4K_2D 2
+#define AMD_FMT_MOD_TILE_GFX12_64K_2D 3
+#define AMD_FMT_MOD_TILE_GFX12_256K_2D 4
+
 #define AMD_FMT_MOD_DCC_BLOCK_64B 0
 #define AMD_FMT_MOD_DCC_BLOCK_128B 1
 #define AMD_FMT_MOD_DCC_BLOCK_256B 2
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 76ee8f9e024a..18e56647accd 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -197,6 +197,13 @@
  *
  *  7.37
  *  - add FUSE_TMPFILE
+ *
+ *  7.38
+ *  - add FUSE_EXPIRE_ONLY flag to fuse_notify_inval_entry
+ *  - add FOPEN_PARALLEL_DIRECT_WRITES
+ *  - add total_extlen to fuse_in_header
+ *  - add FUSE_MAX_NR_SECCTX
+ *  - add extension header
  */
 
 #ifndef _LINUX_FUSE_H
@@ -232,7 +239,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 37
+#define FUSE_KERNEL_MINOR_VERSION 38
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -304,6 +311,7 @@ struct fuse_file_lock {
  * FOPEN_CACHE_DIR: allow caching this directory
  * FOPEN_STREAM: the file is stream-like (no file position at all)
  * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
+ * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
@@ -311,6 +319,7 @@ struct fuse_file_lock {
 #define FOPEN_CACHE_DIR		(1 << 3)
 #define FOPEN_STREAM		(1 << 4)
 #define FOPEN_NOFLUSH		(1 << 5)
+#define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
 
 /**
  * INIT request/reply flags
@@ -356,6 +365,7 @@ struct fuse_file_lock {
  * FUSE_SECURITY_CTX:	add security context to create, mkdir, symlink, and
  *			mknod
  * FUSE_HAS_INODE_DAX:  use per inode DAX
+ * FUSE_HAS_EXPIRE_ONLY: kernel supports expiry-only entry invalidation
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -392,6 +402,7 @@ struct fuse_file_lock {
 /* bits 32..63 get shifted down 32 bits into the flags2 field */
 #define FUSE_SECURITY_CTX	(1ULL << 32)
 #define FUSE_HAS_INODE_DAX	(1ULL << 33)
+#define FUSE_HAS_EXPIRE_ONLY	(1ULL << 35)
 
 /**
  * CUSE INIT request/reply flags
@@ -491,6 +502,21 @@ struct fuse_file_lock {
  */
 #define FUSE_SETXATTR_ACL_KILL_SGID	(1 << 0)
 
+/**
+ * notify_inval_entry flags
+ * FUSE_EXPIRE_ONLY
+ */
+#define FUSE_EXPIRE_ONLY		(1 << 0)
+
+/**
+ * extension type
+ * FUSE_MAX_NR_SECCTX: maximum value of &fuse_secctx_header.nr_secctx
+ */
+enum fuse_ext_type {
+	/* Types 0..31 are reserved for fuse_secctx_header */
+	FUSE_MAX_NR_SECCTX	= 31,
+};
+
 enum fuse_opcode {
 	FUSE_LOOKUP		= 1,
 	FUSE_FORGET		= 2,  /* no reply */
@@ -874,7 +900,8 @@ struct fuse_in_header {
 	uint32_t	uid;
 	uint32_t	gid;
 	uint32_t	pid;
-	uint32_t	padding;
+	uint16_t	total_extlen; /* length of extensions in 8byte units */
+	uint16_t	padding;
 };
 
 struct fuse_out_header {
@@ -919,7 +946,7 @@ struct fuse_notify_inval_inode_out {
 struct fuse_notify_inval_entry_out {
 	uint64_t	parent;
 	uint32_t	namelen;
-	uint32_t	padding;
+	uint32_t	flags;
 };
 
 struct fuse_notify_delete_out {
@@ -1035,4 +1062,17 @@ struct fuse_secctx_header {
 	uint32_t	nr_secctx;
 };
 
+/**
+ * struct fuse_ext_header - extension header
+ * @size: total size of this extension including this header
+ * @type: type of extension
+ *
+ * This is made compatible with fuse_secctx_header by using type values >
+ * FUSE_MAX_NR_SECCTX
+ */
+struct fuse_ext_header {
+	uint32_t	size;
+	uint32_t	type;
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 04503118cdc1..139cd49b2c27 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -628,7 +628,7 @@ static int io_wqe_worker(void *data)
 	struct io_wqe_acct *acct = io_wqe_get_acct(worker);
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
-	bool last_timeout = false;
+	bool exit_mask = false, last_timeout = false;
 	char buf[TASK_COMM_LEN];
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
@@ -644,8 +644,11 @@ static int io_wqe_worker(void *data)
 			io_worker_handle_work(worker);
 
 		raw_spin_lock(&wqe->lock);
-		/* timed out, exit unless we're the last worker */
-		if (last_timeout && acct->nr_workers > 1) {
+		/*
+		 * Last sleep timed out. Exit if we're not the last worker,
+		 * or if someone modified our affinity.
+		 */
+		if (last_timeout && (exit_mask || acct->nr_workers > 1)) {
 			acct->nr_workers--;
 			raw_spin_unlock(&wqe->lock);
 			__set_current_state(TASK_RUNNING);
@@ -664,7 +667,11 @@ static int io_wqe_worker(void *data)
 				continue;
 			break;
 		}
-		last_timeout = !ret;
+		if (!ret) {
+			last_timeout = true;
+			exit_mask = !cpumask_test_cpu(raw_smp_processor_id(),
+							wqe->cpu_mask);
+		}
 	}
 
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state))
@@ -716,7 +723,6 @@ static void io_init_new_worker(struct io_wqe *wqe, struct io_worker *worker,
 	tsk->worker_private = worker;
 	worker->task = tsk;
 	set_cpus_allowed_ptr(tsk, wqe->cpu_mask);
-	tsk->flags |= PF_NO_SETAFFINITY;
 
 	raw_spin_lock(&wqe->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list);
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 11610a70573a..6ea21b503113 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -233,7 +233,6 @@ static int io_sq_thread(void *data)
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	else
 		set_cpus_allowed_ptr(current, cpu_online_mask);
-	current->flags |= PF_NO_SETAFFINITY;
 
 	/*
 	 * Force audit context to get setup, in case we do prep side async
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bb88fd2266a8..95a050446f27 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -466,10 +466,16 @@ static bool btf_type_is_fwd(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_FWD;
 }
 
+static bool btf_type_is_decl_tag(const struct btf_type *t)
+{
+	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
+}
+
 static bool btf_type_nosize(const struct btf_type *t)
 {
 	return btf_type_is_void(t) || btf_type_is_fwd(t) ||
-	       btf_type_is_func(t) || btf_type_is_func_proto(t);
+	       btf_type_is_func(t) || btf_type_is_func_proto(t) ||
+	       btf_type_is_decl_tag(t);
 }
 
 static bool btf_type_nosize_or_null(const struct btf_type *t)
@@ -492,11 +498,6 @@ static bool btf_type_is_datasec(const struct btf_type *t)
 	return BTF_INFO_KIND(t->info) == BTF_KIND_DATASEC;
 }
 
-static bool btf_type_is_decl_tag(const struct btf_type *t)
-{
-	return BTF_INFO_KIND(t->info) == BTF_KIND_DECL_TAG;
-}
-
 static bool btf_type_is_decl_tag_target(const struct btf_type *t)
 {
 	return btf_type_is_func(t) || btf_type_is_struct(t) ||
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 455f67ff31b5..f6656fd410d0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1852,9 +1852,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
-		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
+		css->cgroup = dcgrp;
 		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
 		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
 					 e_cset_node[ss->id]) {
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index dafdc47ae5fc..3efdc5cfe390 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -89,6 +89,22 @@ static int map_benchmark_thread(void *data)
 		atomic64_add(map_sq, &map->sum_sq_map);
 		atomic64_add(unmap_sq, &map->sum_sq_unmap);
 		atomic64_inc(&map->loops);
+
+		/*
+		 * We may test for a long time so periodically check whether
+		 * we need to schedule to avoid starving the others. Otherwise
+		 * we may hangup the kernel in a non-preemptible kernel when
+		 * the test kthreads number >= CPU number, the test kthreads
+		 * will run endless on every CPU since the thread resposible
+		 * for notifying the kthread stop (in do_map_benchmark())
+		 * could not be scheduled.
+		 *
+		 * Note this may degrade the test concurrency since the test
+		 * threads may need to share the CPU time with other load
+		 * in the system. So it's recommended to run this benchmark
+		 * on an idle system.
+		 */
+		cond_resched();
 	}
 
 out:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba099d5b41cd..0e9f1377cec7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1277,8 +1277,9 @@ static void put_ctx(struct perf_event_context *ctx)
  *	  perf_event_context::mutex
  *	    perf_event::child_mutex;
  *	      perf_event_context::lock
- *	    perf_event::mmap_mutex
  *	    mmap_lock
+ *	      perf_event::mmap_mutex
+ *	        perf_buffer::aux_mutex
  *	      perf_addr_filters_head::lock
  *
  *    cpu_hotplug_lock
@@ -6181,12 +6182,11 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		event->pmu->event_unmapped(event, vma->vm_mm);
 
 	/*
-	 * rb->aux_mmap_count will always drop before rb->mmap_count and
-	 * event->mmap_count, so it is ok to use event->mmap_mutex to
-	 * serialize with perf_mmap here.
+	 * The AUX buffer is strictly a sub-buffer, serialize using aux_mutex
+	 * to avoid complications.
 	 */
 	if (rb_has_aux(rb) && vma->vm_pgoff == rb->aux_pgoff &&
-	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &event->mmap_mutex)) {
+	    atomic_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
 		/*
 		 * Stop all AUX events that are writing to this buffer,
 		 * so that we can free its AUX pages and corresponding PMU
@@ -6203,7 +6203,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		rb_free_aux(rb);
 		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
 
-		mutex_unlock(&event->mmap_mutex);
+		mutex_unlock(&rb->aux_mutex);
 	}
 
 	if (atomic_dec_and_test(&rb->mmap_count))
@@ -6291,6 +6291,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	struct perf_event *event = file->private_data;
 	unsigned long user_locked, user_lock_limit;
 	struct user_struct *user = current_user();
+	struct mutex *aux_mutex = NULL;
 	struct perf_buffer *rb = NULL;
 	unsigned long locked, lock_limit;
 	unsigned long vma_size;
@@ -6339,6 +6340,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		if (!rb)
 			goto aux_unlock;
 
+		aux_mutex = &rb->aux_mutex;
+		mutex_lock(aux_mutex);
+
 		aux_offset = READ_ONCE(rb->user_page->aux_offset);
 		aux_size = READ_ONCE(rb->user_page->aux_size);
 
@@ -6489,6 +6493,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		atomic_dec(&rb->mmap_count);
 	}
 aux_unlock:
+	if (aux_mutex)
+		mutex_unlock(aux_mutex);
 	mutex_unlock(&event->mmap_mutex);
 
 	/*
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 386d21c7edfa..f376b057320c 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -40,6 +40,7 @@ struct perf_buffer {
 	struct user_struct		*mmap_user;
 
 	/* AUX area */
+	struct mutex			aux_mutex;
 	long				aux_head;
 	unsigned int			aux_nest;
 	long				aux_wakeup;	/* last aux_watermark boundary crossed by aux_head */
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index f3a3c294ff2b..98588e96b591 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -332,6 +332,8 @@ ring_buffer_init(struct perf_buffer *rb, long watermark, int flags)
 	 */
 	if (!rb->nr_pages)
 		rb->paused = 1;
+
+	mutex_init(&rb->aux_mutex);
 }
 
 void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d9e357b7e17c..f8bda852c6b4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1483,7 +1483,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	uprobe_opcode_t insn = UPROBE_SWBP_INSN;
 	struct xol_area *area;
 
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kzalloc(sizeof(*area), GFP_KERNEL);
 	if (unlikely(!area))
 		goto out;
 
@@ -1493,7 +1493,6 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 		goto free_area;
 
 	area->xol_mapping.name = "[uprobes]";
-	area->xol_mapping.fault = NULL;
 	area->xol_mapping.pages = area->pages;
 	area->pages[0] = alloc_page(GFP_HIGHUSER);
 	if (!area->pages[0])
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 21db0df0eb00..bf3a28ee7d8f 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1624,6 +1624,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 }
 
 static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
+					     struct rt_mutex_base *lock,
 					     struct rt_mutex_waiter *w)
 {
 	/*
@@ -1636,10 +1637,10 @@ static void __sched rt_mutex_handle_deadlock(int res, int detect_deadlock,
 	if (build_ww_mutex() && w->ww_ctx)
 		return;
 
-	/*
-	 * Yell loudly and stop the task right here.
-	 */
+	raw_spin_unlock_irq(&lock->wait_lock);
+
 	WARN(1, "rtmutex deadlock detected\n");
+
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		schedule();
@@ -1693,7 +1694,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	} else {
 		__set_current_state(TASK_RUNNING);
 		remove_waiter(lock, waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, lock, waiter);
 	}
 
 	/*
diff --git a/kernel/resource.c b/kernel/resource.c
index 8f52f8800965..6aed1ca80182 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1781,8 +1781,7 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
 	if (flags & GFR_DESCENDING) {
 		resource_size_t end;
 
-		end = min_t(resource_size_t, base->end,
-			    (1ULL << MAX_PHYSMEM_BITS) - 1);
+		end = min_t(resource_size_t, base->end, PHYSMEM_END);
 		return end - size + 1;
 	}
 
@@ -1799,8 +1798,7 @@ static bool gfr_continue(struct resource *base, resource_size_t addr,
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+	       addr <= min_t(resource_size_t, base->end, PHYSMEM_END);
 }
 
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
diff --git a/kernel/smp.c b/kernel/smp.c
index 63e466bb6b03..0acd433afa7b 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1262,6 +1262,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
 
 	queue_work_on(cpu, system_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
+	destroy_work_on_stack(&sscs.work);
 
 	return sscs.ret;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f2b00ea38111..c9b52e920b8f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4088,6 +4088,8 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 			break;
 		entries++;
 		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->array_buffer->data, cpu)->skipped_entries = entries;
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f3b6ac232e21..93303148a434 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5891,10 +5891,18 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 
 notrace void wq_watchdog_touch(int cpu)
 {
+	unsigned long thresh = READ_ONCE(wq_watchdog_thresh) * HZ;
+	unsigned long touch_ts = READ_ONCE(wq_watchdog_touched);
+	unsigned long now = jiffies;
+
 	if (cpu >= 0)
-		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
+		per_cpu(wq_watchdog_touched_cpu, cpu) = now;
+	else
+		WARN_ONCE(1, "%s should be called with valid CPU", __func__);
 
-	wq_watchdog_touched = jiffies;
+	/* Don't unnecessarily store to global cacheline */
+	if (time_after(now, touch_ts + thresh / 4))
+		WRITE_ONCE(wq_watchdog_touched, jiffies);
 }
 
 static void wq_watchdog_set_thresh(unsigned long thresh)
diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index 7dfa88282b00..78f081d695d0 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -131,6 +131,8 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		if ((v = cmpxchg_release(&radix->root, r, new_root)) == r) {
 			v = new_root;
 			new_node = NULL;
+		} else {
+			new_node->children[0] = NULL;
 		}
 	}
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4ad6e8345b36..280bb6969c0b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5143,11 +5143,28 @@ static struct cftype mem_cgroup_legacy_files[] = {
  */
 
 static DEFINE_IDR(mem_cgroup_idr);
+static DEFINE_SPINLOCK(memcg_idr_lock);
+
+static int mem_cgroup_alloc_id(void)
+{
+	int ret;
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&memcg_idr_lock);
+	ret = idr_alloc(&mem_cgroup_idr, NULL, 1, MEM_CGROUP_ID_MAX + 1,
+			GFP_NOWAIT);
+	spin_unlock(&memcg_idr_lock);
+	idr_preload_end();
+	return ret;
+}
 
 static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 {
 	if (memcg->id.id > 0) {
+		spin_lock(&memcg_idr_lock);
 		idr_remove(&mem_cgroup_idr, memcg->id.id);
+		spin_unlock(&memcg_idr_lock);
+
 		memcg->id.id = 0;
 	}
 }
@@ -5270,8 +5287,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (!memcg)
 		return ERR_PTR(error);
 
-	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX + 1, GFP_KERNEL);
+	memcg->id.id = mem_cgroup_alloc_id();
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
 		goto fail;
@@ -5316,7 +5332,9 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
 	memcg->deferred_split_queue.split_queue_len = 0;
 #endif
+	spin_lock(&memcg_idr_lock);
 	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
+	spin_unlock(&memcg_idr_lock);
 	lru_gen_init_memcg(memcg);
 	return memcg;
 fail:
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3b9d3a4b4386..dc17618bad8b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1530,7 +1530,7 @@ struct range __weak arch_get_mappable_range(void)
 
 struct range mhp_get_pluggable_range(bool need_mapping)
 {
-	const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;
+	const u64 max_phys = PHYSMEM_END;
 	struct range mhp_range;
 
 	if (need_mapping) {
diff --git a/mm/sparse.c b/mm/sparse.c
index 05d1e7b6c6db..c803e318f50b 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -129,7 +129,7 @@ static inline int sparse_early_nid(struct mem_section *section)
 static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
 						unsigned long *end_pfn)
 {
-	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
+	unsigned long max_sparsemem_pfn = (PHYSMEM_END + 1) >> PAGE_SHIFT;
 
 	/*
 	 * Sanity checks - do not allow an architecture to pass
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5b8adfb36e20..c5a3a336515e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2900,16 +2900,6 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "debug_keys %u key_count %u", cp->debug_keys,
 		   key_count);
 
-	for (i = 0; i < key_count; i++) {
-		struct mgmt_link_key_info *key = &cp->keys[i];
-
-		/* Considering SMP over BREDR/LE, there is no need to check addr_type */
-		if (key->type > 0x08)
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_LOAD_LINK_KEYS,
-					       MGMT_STATUS_INVALID_PARAMS);
-	}
-
 	hci_dev_lock(hdev);
 
 	hci_link_keys_clear(hdev);
@@ -2934,6 +2924,19 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		if (key->addr.type != BDADDR_BREDR) {
+			bt_dev_warn(hdev,
+				    "Invalid link address type %u for %pMR",
+				    key->addr.type, &key->addr.bdaddr);
+			continue;
+		}
+
+		if (key->type > 0x08) {
+			bt_dev_warn(hdev, "Invalid link key type %u for %pMR",
+				    key->type, &key->addr.bdaddr);
+			continue;
+		}
+
 		/* Always ignore debug keys and require a new pairing if
 		 * the user wants to use them.
 		 */
@@ -7141,7 +7144,6 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 
 	for (i = 0; i < irk_count; i++) {
 		struct mgmt_irk_info *irk = &cp->irks[i];
-		u8 addr_type = le_addr_type(irk->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_IRK,
@@ -7151,12 +7153,8 @@ static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
 			continue;
 		}
 
-		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
-		if (irk->addr.type == BDADDR_BREDR)
-			addr_type = BDADDR_BREDR;
-
 		hci_add_irk(hdev, &irk->addr.bdaddr,
-			    addr_type, irk->val,
+			    le_addr_type(irk->addr.type), irk->val,
 			    BDADDR_ANY);
 	}
 
@@ -7221,15 +7219,6 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
 	bt_dev_dbg(hdev, "key_count %u", key_count);
 
-	for (i = 0; i < key_count; i++) {
-		struct mgmt_ltk_info *key = &cp->keys[i];
-
-		if (!ltk_is_valid(key))
-			return mgmt_cmd_status(sk, hdev->id,
-					       MGMT_OP_LOAD_LONG_TERM_KEYS,
-					       MGMT_STATUS_INVALID_PARAMS);
-	}
-
 	hci_dev_lock(hdev);
 
 	hci_smp_ltks_clear(hdev);
@@ -7237,7 +7226,6 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
 		u8 type, authenticated;
-		u8 addr_type = le_addr_type(key->addr.type);
 
 		if (hci_is_blocked_key(hdev,
 				       HCI_BLOCKED_KEY_TYPE_LTK,
@@ -7247,6 +7235,12 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			continue;
 		}
 
+		if (!ltk_is_valid(key)) {
+			bt_dev_warn(hdev, "Invalid LTK for %pMR",
+				    &key->addr.bdaddr);
+			continue;
+		}
+
 		switch (key->type) {
 		case MGMT_LTK_UNAUTHENTICATED:
 			authenticated = 0x00;
@@ -7272,12 +7266,8 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 			continue;
 		}
 
-		/* When using SMP over BR/EDR, the addr type should be set to BREDR */
-		if (key->addr.type == BDADDR_BREDR)
-			addr_type = BDADDR_BREDR;
-
 		hci_add_ltk(hdev, &key->addr.bdaddr,
-			    addr_type, type, authenticated,
+			    le_addr_type(key->addr.type), type, authenticated,
 			    key->val, key->enc_size, key->ediv, key->rand);
 	}
 
@@ -9545,7 +9535,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
+	ev.key.addr.type = BDADDR_BREDR;
 	ev.key.type = key->type;
 	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
@@ -9596,7 +9586,7 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent)
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(key->link_type, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
 	ev.key.type = mgmt_ltk_type(key);
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -9625,7 +9615,7 @@ void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent)
 
 	bacpy(&ev.rpa, &irk->rpa);
 	bacpy(&ev.irk.addr.bdaddr, &irk->bdaddr);
-	ev.irk.addr.type = link_to_bdaddr(irk->link_type, irk->addr_type);
+	ev.irk.addr.type = link_to_bdaddr(LE_LINK, irk->addr_type);
 	memcpy(ev.irk.val, irk->val, sizeof(irk->val));
 
 	mgmt_event(MGMT_EV_NEW_IRK, hdev, &ev, sizeof(ev), NULL);
@@ -9654,7 +9644,7 @@ void mgmt_new_csrk(struct hci_dev *hdev, struct smp_csrk *csrk,
 		ev.store_hint = persistent;
 
 	bacpy(&ev.key.addr.bdaddr, &csrk->bdaddr);
-	ev.key.addr.type = link_to_bdaddr(csrk->link_type, csrk->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, csrk->bdaddr_type);
 	ev.key.type = csrk->type;
 	memcpy(ev.key.val, csrk->val, sizeof(csrk->val));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d444fa1bd9f9..b93494790877 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1059,7 +1059,6 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->remote_irk) {
-		smp->remote_irk->link_type = hcon->type;
 		mgmt_new_irk(hdev, smp->remote_irk, persistent);
 
 		/* Now that user space can be considered to know the
@@ -1074,28 +1073,24 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 	}
 
 	if (smp->csrk) {
-		smp->csrk->link_type = hcon->type;
 		smp->csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->csrk, persistent);
 	}
 
 	if (smp->responder_csrk) {
-		smp->responder_csrk->link_type = hcon->type;
 		smp->responder_csrk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_csrk->bdaddr, &hcon->dst);
 		mgmt_new_csrk(hdev, smp->responder_csrk, persistent);
 	}
 
 	if (smp->ltk) {
-		smp->ltk->link_type = hcon->type;
 		smp->ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->ltk, persistent);
 	}
 
 	if (smp->responder_ltk) {
-		smp->responder_ltk->link_type = hcon->type;
 		smp->responder_ltk->bdaddr_type = hcon->dst_type;
 		bacpy(&smp->responder_ltk->bdaddr, &hcon->dst);
 		mgmt_new_ltk(hdev, smp->responder_ltk, persistent);
@@ -1115,8 +1110,6 @@ static void smp_notify_keys(struct l2cap_conn *conn)
 		key = hci_add_link_key(hdev, smp->conn->hcon, &hcon->dst,
 				       smp->link_key, type, 0, &persistent);
 		if (key) {
-			key->link_type = hcon->type;
-			key->bdaddr_type = hcon->dst_type;
 			mgmt_new_link_key(hdev, key, persistent);
 
 			/* Don't keep debug keys around if the relevant
diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index e7f4fccb6adb..882b6a67e11f 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -1388,12 +1388,10 @@ int br_fdb_external_learn_add(struct net_bridge *br, struct net_bridge_port *p,
 			modified = true;
 		}
 
-		if (test_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
+		if (test_and_set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags)) {
 			/* Refresh entry */
 			fdb->used = jiffies;
-		} else if (!test_bit(BR_FDB_ADDED_BY_USER, &fdb->flags)) {
-			/* Take over SW learned entry */
-			set_bit(BR_FDB_ADDED_BY_EXT_LEARN, &fdb->flags);
+		} else {
 			modified = true;
 		}
 
diff --git a/net/can/bcm.c b/net/can/bcm.c
index 925d48cc50f8..4ecb5cd8a22d 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1428,6 +1428,10 @@ static void bcm_notify(struct bcm_sock *bo, unsigned long msg,
 
 		/* remove device reference, if this is our bound device */
 		if (bo->bound && bo->ifindex == dev->ifindex) {
+#if IS_ENABLED(CONFIG_PROC_FS)
+			if (sock_net(sk)->can.bcmproc_dir && bo->bcm_proc_read)
+				remove_proc_entry(bo->procname, sock_net(sk)->can.bcmproc_dir);
+#endif
 			bo->bound   = 0;
 			bo->ifindex = 0;
 			notify_enodev = 1;
diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 358bff068eef..7bcc933103e2 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -48,7 +48,7 @@ struct fou_net {
 
 static inline struct fou *fou_from_sock(struct sock *sk)
 {
-	return sk->sk_user_data;
+	return rcu_dereference_sk_user_data(sk);
 }
 
 static int fou_recv_pull(struct sk_buff *skb, struct fou *fou, size_t len)
@@ -231,9 +231,15 @@ static struct sk_buff *fou_gro_receive(struct sock *sk,
 				       struct sk_buff *skb)
 {
 	const struct net_offload __rcu **offloads;
-	u8 proto = fou_from_sock(sk)->protocol;
+	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
 	struct sk_buff *pp = NULL;
+	u8 proto;
+
+	if (!fou)
+		goto out;
+
+	proto = fou->protocol;
 
 	/* We can clear the encap_mark for FOU as we are essentially doing
 	 * one of two possible things.  We are either adding an L4 tunnel
@@ -261,14 +267,24 @@ static int fou_gro_complete(struct sock *sk, struct sk_buff *skb,
 			    int nhoff)
 {
 	const struct net_offload __rcu **offloads;
-	u8 proto = fou_from_sock(sk)->protocol;
+	struct fou *fou = fou_from_sock(sk);
 	const struct net_offload *ops;
-	int err = -ENOSYS;
+	u8 proto;
+	int err;
+
+	if (!fou) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	proto = fou->protocol;
 
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
-	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
+	if (WARN_ON(!ops || !ops->callbacks.gro_complete)) {
+		err = -ENOSYS;
 		goto out;
+	}
 
 	err = ops->callbacks.gro_complete(skb, nhoff);
 
@@ -318,6 +334,9 @@ static struct sk_buff *gue_gro_receive(struct sock *sk,
 	struct gro_remcsum grc;
 	u8 proto;
 
+	if (!fou)
+		goto out;
+
 	skb_gro_remcsum_init(&grc);
 
 	off = skb_gro_offset(skb);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f8037d142bb7..07a896685d0d 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -572,7 +572,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 		err = sk_stream_error(sk, msg->msg_flags, err);
 	release_sock(sk);
 	sk_psock_put(sk, psock);
-	return copied ? copied : err;
+	return copied > 0 ? copied : err;
 }
 
 static int tcp_bpf_sendpage(struct sock *sk, struct page *page, int offset,
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index b1b4f44d2137..4c7a2702d904 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5843,6 +5843,11 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
+		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
+		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
+		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
+		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
+			goto pass;
 syn_challenge:
 		if (syn_inerr)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
@@ -5852,6 +5857,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		goto discard;
 	}
 
+pass:
 	bpf_skops_parse_hdr(sk, skb);
 
 	return true;
diff --git a/net/ipv6/ila/ila.h b/net/ipv6/ila/ila.h
index ad5f6f6ba333..85b92917849b 100644
--- a/net/ipv6/ila/ila.h
+++ b/net/ipv6/ila/ila.h
@@ -108,6 +108,7 @@ int ila_lwt_init(void);
 void ila_lwt_fini(void);
 
 int ila_xlat_init_net(struct net *net);
+void ila_xlat_pre_exit_net(struct net *net);
 void ila_xlat_exit_net(struct net *net);
 
 int ila_xlat_nl_cmd_add_mapping(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/ipv6/ila/ila_main.c b/net/ipv6/ila/ila_main.c
index 3faf62530d6a..cba81158a24e 100644
--- a/net/ipv6/ila/ila_main.c
+++ b/net/ipv6/ila/ila_main.c
@@ -72,6 +72,11 @@ static __net_init int ila_init_net(struct net *net)
 	return err;
 }
 
+static __net_exit void ila_pre_exit_net(struct net *net)
+{
+	ila_xlat_pre_exit_net(net);
+}
+
 static __net_exit void ila_exit_net(struct net *net)
 {
 	ila_xlat_exit_net(net);
@@ -79,6 +84,7 @@ static __net_exit void ila_exit_net(struct net *net)
 
 static struct pernet_operations ila_net_ops = {
 	.init = ila_init_net,
+	.pre_exit = ila_pre_exit_net,
 	.exit = ila_exit_net,
 	.id   = &ila_net_id,
 	.size = sizeof(struct ila_net),
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index bee45dfeb187..2e7a36a1ea0a 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -620,6 +620,15 @@ int ila_xlat_init_net(struct net *net)
 	return 0;
 }
 
+void ila_xlat_pre_exit_net(struct net *net)
+{
+	struct ila_net *ilan = net_generic(net, ila_net_id);
+
+	if (ilan->xlat.hooks_registered)
+		nf_unregister_net_hooks(net, ila_nf_hook_ops,
+					ARRAY_SIZE(ila_nf_hook_ops));
+}
+
 void ila_xlat_exit_net(struct net *net)
 {
 	struct ila_net *ilan = net_generic(net, ila_net_id);
@@ -627,10 +636,6 @@ void ila_xlat_exit_net(struct net *net)
 	rhashtable_free_and_destroy(&ilan->xlat.rhash_table, ila_free_cb, NULL);
 
 	free_bucket_spinlocks(ilan->xlat.locks);
-
-	if (ilan->xlat.hooks_registered)
-		nf_unregister_net_hooks(net, ila_nf_hook_ops,
-					ARRAY_SIZE(ila_nf_hook_ops));
 }
 
 static int ila_xlat_addr(struct sk_buff *skb, bool sir2ila)
diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index 5d8ed6c90b7e..5885810da412 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -321,7 +321,6 @@ insert_tree(struct net *net,
 	struct nf_conncount_rb *rbconn;
 	struct nf_conncount_tuple *conn;
 	unsigned int count = 0, gc_count = 0;
-	u8 keylen = data->keylen;
 	bool do_gc = true;
 
 	spin_lock_bh(&nf_conncount_locks[hash]);
@@ -333,7 +332,7 @@ insert_tree(struct net *net,
 		rbconn = rb_entry(*rbnode, struct nf_conncount_rb, node);
 
 		parent = *rbnode;
-		diff = key_diff(key, rbconn->key, keylen);
+		diff = key_diff(key, rbconn->key, data->keylen);
 		if (diff < 0) {
 			rbnode = &((*rbnode)->rb_left);
 		} else if (diff > 0) {
@@ -378,7 +377,7 @@ insert_tree(struct net *net,
 
 	conn->tuple = *tuple;
 	conn->zone = *zone;
-	memcpy(rbconn->key, key, sizeof(u32) * keylen);
+	memcpy(rbconn->key, key, sizeof(u32) * data->keylen);
 
 	nf_conncount_list_init(&rbconn->list);
 	list_add(&conn->node, &rbconn->list.head);
@@ -403,7 +402,6 @@ count_tree(struct net *net,
 	struct rb_node *parent;
 	struct nf_conncount_rb *rbconn;
 	unsigned int hash;
-	u8 keylen = data->keylen;
 
 	hash = jhash2(key, data->keylen, conncount_rnd) % CONNCOUNT_SLOTS;
 	root = &data->root[hash];
@@ -414,7 +412,7 @@ count_tree(struct net *net,
 
 		rbconn = rb_entry(parent, struct nf_conncount_rb, node);
 
-		diff = key_diff(key, rbconn->key, keylen);
+		diff = key_diff(key, rbconn->key, data->keylen);
 		if (diff < 0) {
 			parent = rcu_dereference_raw(parent->rb_left);
 		} else if (diff > 0) {
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 3ed0c3342189..73e8caeffd47 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -785,12 +785,15 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		 * queue, accept the collision, update the host tags.
 		 */
 		q->way_collisions++;
-		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
-			q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
-			q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
-		}
 		allocate_src = cake_dsrc(flow_mode);
 		allocate_dst = cake_ddst(flow_mode);
+
+		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
+			if (allocate_src)
+				q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
+			if (allocate_dst)
+				q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
+		}
 found:
 		/* reserve queue for future packets in same flow */
 		reduced_hash = outer_hash + k;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index a18b24c125f4..0eba06613dcd 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -733,11 +733,10 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 
 				err = qdisc_enqueue(skb, q->qdisc, &to_free);
 				kfree_skb_list(to_free);
-				if (err != NET_XMIT_SUCCESS &&
-				    net_xmit_drop_count(err)) {
-					qdisc_qstats_drop(sch);
-					qdisc_tree_reduce_backlog(sch, 1,
-								  pkt_len);
+				if (err != NET_XMIT_SUCCESS) {
+					if (net_xmit_drop_count(err))
+						qdisc_qstats_drop(sch);
+					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7d59f9a6c904..5ce60087086c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -680,9 +680,6 @@ static void init_peercred(struct sock *sk)
 
 static void copy_peercred(struct sock *sk, struct sock *peersk)
 {
-	const struct cred *old_cred;
-	struct pid *old_pid;
-
 	if (sk < peersk) {
 		spin_lock(&sk->sk_peer_lock);
 		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
@@ -690,16 +687,12 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 		spin_lock(&peersk->sk_peer_lock);
 		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
 	}
-	old_pid = sk->sk_peer_pid;
-	old_cred = sk->sk_peer_cred;
+
 	sk->sk_peer_pid  = get_pid(peersk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 
 	spin_unlock(&sk->sk_peer_lock);
 	spin_unlock(&peersk->sk_peer_lock);
-
-	put_pid(old_pid);
-	put_cred(old_cred);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
diff --git a/rust/Makefile b/rust/Makefile
index 6d0c0e9757f2..28ba3b9ee18d 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -303,9 +303,7 @@ $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers.c FORCE
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
 	$(NM) -p --defined-only $< \
-		| grep -E ' (T|R|D) ' | cut -d ' ' -f 3 \
-		| xargs -Isymbol \
-		echo 'EXPORT_SYMBOL_RUST_GPL(symbol);' > $@
+		| awk '/ (T|R|D|B) / {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 75b3e91d5a5f..c18366dbbfed 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3706,12 +3706,18 @@ static int smack_unix_stream_connect(struct sock *sock,
 		}
 	}
 
-	/*
-	 * Cross reference the peer labels for SO_PEERSEC.
-	 */
 	if (rc == 0) {
+		/*
+		 * Cross reference the peer labels for SO_PEERSEC.
+		 */
 		nsp->smk_packet = ssp->smk_out;
 		ssp->smk_packet = osp->smk_out;
+
+		/*
+		 * new/child/established socket must inherit listening socket labels
+		 */
+		nsp->smk_out = osp->smk_out;
+		nsp->smk_in  = osp->smk_in;
 	}
 
 	return rc;
diff --git a/sound/core/control.c b/sound/core/control.c
index 82aa1af1d1d8..92266c97238d 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1477,12 +1477,16 @@ static int snd_ctl_elem_user_get(struct snd_kcontrol *kcontrol,
 static int snd_ctl_elem_user_put(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_value *ucontrol)
 {
-	int change;
+	int err, change;
 	struct user_element *ue = kcontrol->private_data;
 	unsigned int size = ue->elem_data_size;
 	char *dst = ue->elem_data +
 			snd_ctl_get_ioff(kcontrol, &ucontrol->id) * size;
 
+	err = sanity_check_input_values(ue->card, ucontrol, &ue->info, false);
+	if (err < 0)
+		return err;
+
 	change = memcmp(&ucontrol->value, dst, size) != 0;
 	if (change)
 		memcpy(dst, &ucontrol->value, size);
diff --git a/sound/hda/hdmi_chmap.c b/sound/hda/hdmi_chmap.c
index 5d8e1d944b0a..7b276047f85a 100644
--- a/sound/hda/hdmi_chmap.c
+++ b/sound/hda/hdmi_chmap.c
@@ -753,6 +753,20 @@ static int hdmi_chmap_ctl_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+/* a simple sanity check for input values to chmap kcontrol */
+static int chmap_value_check(struct hdac_chmap *hchmap,
+			     const struct snd_ctl_elem_value *ucontrol)
+{
+	int i;
+
+	for (i = 0; i < hchmap->channels_max; i++) {
+		if (ucontrol->value.integer.value[i] < 0 ||
+		    ucontrol->value.integer.value[i] > SNDRV_CHMAP_LAST)
+			return -EINVAL;
+	}
+	return 0;
+}
+
 static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
@@ -764,6 +778,10 @@ static int hdmi_chmap_ctl_put(struct snd_kcontrol *kcontrol,
 	unsigned char chmap[8], per_pin_chmap[8];
 	int i, err, ca, prepared = 0;
 
+	err = chmap_value_check(hchmap, ucontrol);
+	if (err < 0)
+		return err;
+
 	/* No monitor is connected in dyn_pcm_assign.
 	 * It's invalid to setup the chmap
 	 */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 8396d1d93668..63bd0e384bae 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -311,6 +311,7 @@ enum {
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
+	CXT_PINCFG_TOP_SPEAKER,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -978,6 +979,13 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
+	[CXT_PINCFG_TOP_SPEAKER] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1d, 0x82170111 },
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -1074,6 +1082,8 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
+	SND_PCI_QUIRK(0x2782, 0x12c3, "Sirius Gen1", CXT_PINCFG_TOP_SPEAKER),
+	SND_PCI_QUIRK(0x2782, 0x12c5, "Sirius Gen2", CXT_PINCFG_TOP_SPEAKER),
 	{}
 };
 
@@ -1093,6 +1103,7 @@ static const struct hda_model_fixup cxt5066_fixup_models[] = {
 	{ .id = CXT_FIXUP_HP_MIC_NO_PRESENCE, .name = "hp-mic-fix" },
 	{ .id = CXT_PINCFG_LENOVO_NOTEBOOK, .name = "lenovo-20149" },
 	{ .id = CXT_PINCFG_SWS_JS201D, .name = "sws-js201d" },
+	{ .id = CXT_PINCFG_TOP_SPEAKER, .name = "sirius-top-speaker" },
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b942ed868070..d869d6ba96f3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7289,6 +7289,7 @@ enum {
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
+	ALC236_FIXUP_LENOVO_INV_DMIC,
 	ALC298_FIXUP_SAMSUNG_AMP,
 	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
 	ALC256_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
@@ -8805,6 +8806,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_mute_led_micmute_vref,
 	},
+	[ALC236_FIXUP_LENOVO_INV_DMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_inv_dmic,
+		.chained = true,
+		.chain_id = ALC283_FIXUP_INT_MIC,
+	},
 	[ALC298_FIXUP_SAMSUNG_AMP] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc298_fixup_samsung_amp,
@@ -9710,6 +9717,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x87f5, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87f6, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
 	SND_PCI_QUIRK(0x103c, 0x87f7, "HP Spectre x360 14", ALC245_FIXUP_HP_X360_AMP),
+	SND_PCI_QUIRK(0x103c, 0x87fd, "HP Laptop 14-dq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87fe, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8805, "HP ProBook 650 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x880d, "HP EliteBook 830 G8 Notebook PC", ALC285_FIXUP_HP_GPIO_LED),
@@ -10111,6 +10119,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3866, "Lenovo 13X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
+	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
@@ -10359,6 +10368,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC623_FIXUP_LENOVO_THINKSTATION_P340, .name = "alc623-lenovo-thinkstation-p340"},
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
+	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6eb8c6cb5e67..4103443770b0 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4018,6 +4018,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 
 	case SND_SOC_DAPM_POST_PMD:
 		kfree(substream->runtime);
+		substream->runtime = NULL;
 		break;
 
 	default:
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index fcb8a36d4a06..77296c950376 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -889,6 +889,8 @@ static int soc_tplg_denum_create_values(struct soc_tplg *tplg, struct soc_enum *
 		se->dobj.control.dvalues[i] = le32_to_cpu(ec->values[i]);
 	}
 
+	se->items = le32_to_cpu(ec->items);
+	se->values = (const unsigned int *)se->dobj.control.dvalues;
 	return 0;
 }
 
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index e7305ce57ea1..374c8b1d6958 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1817,6 +1817,8 @@ static int sof_link_unload(struct snd_soc_component *scomp, struct snd_soc_dobj
 	if (!slink)
 		return 0;
 
+	slink->link->platforms->name = NULL;
+
 	kfree(slink->tuples);
 	list_del(&slink->list);
 	kfree(slink->hw_configs);
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 6028871825ba..47faaf849de0 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -100,8 +100,8 @@
 #define SUN8I_I2S_CTRL_MODE_PCM			(0 << 4)
 
 #define SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK	BIT(19)
-#define SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED		(1 << 19)
-#define SUN8I_I2S_FMT0_LRCLK_POLARITY_NORMAL		(0 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH	(1 << 19)
+#define SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW		(0 << 19)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK		GENMASK(17, 8)
 #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)
 #define SUN8I_I2S_FMT0_BCLK_POLARITY_MASK	BIT(7)
@@ -727,65 +727,37 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 				 unsigned int fmt)
 {
-	u32 mode, val;
+	u32 mode, lrclk_pol, bclk_pol, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		val = 0;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
-			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
-			   val);
-
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
 		offset = 0;
 		break;
@@ -803,6 +775,35 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_TX_CHAN_OFFSET_MASK,
 			   SUN8I_I2S_TX_CHAN_OFFSET(offset));
 
+	/* DAI clock polarity */
+	bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* No inversion */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   lrclk_pol | bclk_pol);
+
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
@@ -834,65 +835,37 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 				     unsigned int fmt)
 {
-	u32 mode, val;
+	u32 mode, lrclk_pol, bclk_pol, val;
 	u8 offset;
 
-	/*
-	 * DAI clock polarity
-	 *
-	 * The setup for LRCK contradicts the datasheet, but under a
-	 * scope it's clear that the LRCK polarity is reversed
-	 * compared to the expected polarity on the bus.
-	 */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Invert both clocks */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/* Invert bit clock */
-		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
-		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	case SND_SOC_DAIFMT_NB_IF:
-		/* Invert frame clock */
-		val = 0;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
-			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
-			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
-			   val);
-
 	/* DAI Mode */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_PCM;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_LOW;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 1;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_LEFT;
 		offset = 0;
 		break;
 
 	case SND_SOC_DAIFMT_RIGHT_J:
+		lrclk_pol = SUN8I_I2S_FMT0_LRCLK_POLARITY_START_HIGH;
 		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
 		offset = 0;
 		break;
@@ -910,6 +883,36 @@ static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
 			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset));
 
+	/* DAI clock polarity */
+	bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL;
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		bclk_pol = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		lrclk_pol ^= SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* No inversion */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   lrclk_pol | bclk_pol);
+
+
 	/* DAI clock master masks */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
 	case SND_SOC_DAIFMT_BP_FP:
diff --git a/sound/soc/tegra/tegra210_ahub.c b/sound/soc/tegra/tegra210_ahub.c
index b38d205b69cc..dfdcb4580cd7 100644
--- a/sound/soc/tegra/tegra210_ahub.c
+++ b/sound/soc/tegra/tegra210_ahub.c
@@ -2,7 +2,7 @@
 //
 // tegra210_ahub.c - Tegra210 AHUB driver
 //
-// Copyright (c) 2020-2022, NVIDIA CORPORATION.  All rights reserved.
+// Copyright (c) 2020-2024, NVIDIA CORPORATION.  All rights reserved.
 
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -1401,11 +1401,13 @@ static int tegra_ahub_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	err = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
-	if (err)
+	if (err) {
+		pm_runtime_disable(&pdev->dev);
 		return err;
-
-	pm_runtime_enable(&pdev->dev);
+	}
 
 	return 0;
 }
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bb27dfd6b97a..878f05a42421 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9364,7 +9364,7 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 struct bpf_map *
 bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 {
-	if (prev == NULL)
+	if (prev == NULL && obj != NULL)
 		return obj->maps;
 
 	return __bpf_map__iter(prev, obj, 1);
@@ -9373,7 +9373,7 @@ bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 struct bpf_map *
 bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *next)
 {
-	if (next == NULL) {
+	if (next == NULL && obj != NULL) {
 		if (!obj->nr_maps)
 			return NULL;
 		return obj->maps + obj->nr_maps - 1;
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 890a8236a8ba..2809f9a25c43 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -28,9 +28,11 @@ static int check_vgem(int fd)
 	version.name = name;
 
 	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
-	if (ret)
+	if (ret || version.name_len != 4)
 		return 0;
 
+	name[4] = '\0';
+
 	return !strcmp(name, "vgem");
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 33c002c26604..446b8daa23e0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -394,6 +394,25 @@ reset_with_fail()
 	fi
 }
 
+start_events()
+{
+	evts_ns1=$(mktemp)
+	evts_ns2=$(mktemp)
+	:> "$evts_ns1"
+	:> "$evts_ns2"
+	ip netns exec "${ns1}" ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
+	evts_ns1_pid=$!
+	ip netns exec "${ns2}" ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
+	evts_ns2_pid=$!
+}
+
+reset_with_events()
+{
+	reset "${1}" || return 1
+
+	start_events
+}
+
 reset_with_tcp_filter()
 {
 	reset "${1}" || return 1
@@ -596,6 +615,14 @@ kill_tests_wait()
 	wait
 }
 
+kill_events_pids()
+{
+	kill_wait $evts_ns1_pid
+	evts_ns1_pid=0
+	kill_wait $evts_ns2_pid
+	evts_ns2_pid=0
+}
+
 pm_nl_set_limits()
 {
 	local ns=$1
@@ -3143,6 +3170,32 @@ fail_tests()
 	fi
 }
 
+# $1: ns ; $2: event type ; $3: count
+chk_evt_nr()
+{
+	local ns=${1}
+	local evt_name="${2}"
+	local exp="${3}"
+
+	local evts="${evts_ns1}"
+	local evt="${!evt_name}"
+	local count
+
+	evt_name="${evt_name:16}" # without MPTCP_LIB_EVENT_
+	[ "${ns}" == "ns2" ] && evts="${evts_ns2}"
+
+	printf "%-${nr_blank}s %s" " " "event ${ns} ${evt_name} (${exp})"
+
+	count=$(grep -cw "type:${evt}" "${evts}")
+	if [ "${count}" != "${exp}" ]; then
+		echo "[fail] got $count events, expected $exp"
+		fail_test
+		dump_stats
+	else
+		echo "[ ok ]"
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3236,75 +3289,6 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_rm_nr 0 1
 	fi
-
-	# remove and re-add
-	if reset "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 3
-		pm_nl_set_limits $ns2 3 3
-		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-		# broadcast IP: no packet for this address will be received on ns1
-		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
-		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
-		local tests_pid=$!
-
-		wait_mpj $ns2
-		chk_subflow_nr needtitle "before delete" 2
-
-		pm_nl_del_endpoint $ns1 1 10.0.2.1
-		pm_nl_del_endpoint $ns1 2 224.0.0.1
-		sleep 0.5
-		chk_subflow_nr "" "after delete" 1
-
-		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
-		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 3
-
-		pm_nl_del_endpoint $ns1 42 10.0.1.1
-		sleep 0.5
-		chk_subflow_nr "" "after delete ID 0" 2
-
-		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
-		wait_mpj $ns2
-		chk_subflow_nr "" "after re-add" 3
-		kill_tests_wait
-
-		chk_join_nr 4 4 4
-		chk_add_nr 5 5
-		chk_rm_nr 3 2 invert
-	fi
-
-	# flush and re-add
-	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 0 2
-		pm_nl_set_limits $ns2 1 2
-		# broadcast IP: no packet for this address will be received on ns1
-		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
-		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
-		local tests_pid=$!
-
-		wait_attempt_fail $ns2
-		chk_subflow_nr needtitle "before flush" 1
-
-		pm_nl_flush_endpoint $ns2
-		pm_nl_flush_endpoint $ns1
-		wait_rm_addr $ns2 0
-		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
-		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
-		wait_mpj $ns2
-		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
-		wait_mpj $ns2
-		kill_wait "${tests_pid}"
-		kill_tests_wait
-
-		chk_join_nr 2 2 2
-		chk_add_nr 2 2
-		chk_rm_nr 1 0 invert
-	fi
 }
 
 endpoint_tests()
@@ -3334,11 +3318,13 @@ endpoint_tests()
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
+		local tests_pid=$!
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2
@@ -3370,11 +3356,121 @@ endpoint_tests()
 			chk_subflow_nr "" "after re-add id 0 ($i)" 3
 		done
 
+		kill_wait "${tests_pid}"
+		kill_events_pids
 		kill_tests_wait
 
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 4
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 5 # one has been closed before estab
+
 		chk_join_nr 6 6 6
 		chk_rm_nr 4 4
 	fi
+
+	# remove and re-add
+	if reset_with_events "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 3
+		pm_nl_set_limits $ns2 3 3
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_5 2>/dev/null &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		chk_subflow_nr needtitle "before delete" 2
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete" 1
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add" 3
+
+		pm_nl_del_endpoint $ns1 42 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "" "after delete ID 0" 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 99 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-add ID 0" 3
+
+		pm_nl_del_endpoint $ns1 99 10.0.1.1
+		sleep 0.5
+		chk_subflow_nr "" "after re-delete ID 0" 2
+
+		pm_nl_add_endpoint $ns1 10.0.1.1 id 88 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "" "after re-re-add ID 0" 3
+
+		kill_wait "${tests_pid}"
+		kill_events_pids
+		kill_tests_wait
+
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_REMOVED 0
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns1 MPTCP_LIB_EVENT_SUB_CLOSED 3
+
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_CREATED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ESTABLISHED 1
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_ANNOUNCED 6
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_REMOVED 4
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 5
+		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 3
+
+		chk_join_nr 5 5 5
+		chk_add_nr 6 6
+		chk_rm_nr 4 3 invert
+	fi
+
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 2>/dev/null &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr needtitle "before flush" 1
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		kill_wait "${tests_pid}"
+		kill_tests_wait
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f32045b23b89..4b1bef34d6d8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -4,6 +4,21 @@
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
 
+# These variables are used in some selftests, read-only
+declare -rx MPTCP_LIB_EVENT_CREATED=1           # MPTCP_EVENT_CREATED
+declare -rx MPTCP_LIB_EVENT_ESTABLISHED=2       # MPTCP_EVENT_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_CLOSED=3            # MPTCP_EVENT_CLOSED
+declare -rx MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
+declare -rx MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
+declare -rx MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
+declare -rx MPTCP_LIB_EVENT_SUB_PRIORITY=13     # MPTCP_EVENT_SUB_PRIORITY
+declare -rx MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
+declare -rx MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
+
+declare -rx MPTCP_LIB_AF_INET=2
+declare -rx MPTCP_LIB_AF_INET6=10
+
 # SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when validating all
 # features using the last version of the kernel and the selftests to make sure
 # a test is not being skipped by mistake.

