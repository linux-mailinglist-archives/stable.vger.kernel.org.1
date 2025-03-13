Return-Path: <stable+bounces-124293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68632A5F475
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 13:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE70D17F44D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D76E267B1D;
	Thu, 13 Mar 2025 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/7ha/Pb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900E267B15;
	Thu, 13 Mar 2025 12:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868921; cv=none; b=HOAkxooZHly8QpR4fHkMdNmoVtyL5ID3c3iPL1kLgWDQRp3V6SAqQdFX0XgHL4/M+DruzbX+fvA2njMBNgMcqCOgoyTqA6vVZY6LZSoks5vW2rmbOOnwCnG8jVAtz9T2ONd6UpT7znPDEmmpqtYP61tPGJrxUS0Jhz/7UfRX10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868921; c=relaxed/simple;
	bh=ZP2UghbhMBfp3KumYFEMjRNBf5P2m9iAdFHFJ8+6V5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fun2gP1XBvGntmmqTb9+lPpDQsgXkFi2rs/DN0f33rTjt/9MtaM+IihFlorzpnACAB2YMw99VckS7hXFOTSQyALVUxLngKJh1lsOkJ2Ndu7EgMLiY0QrWj2aCxbx3tB9krClV6ata9Jez56MQ2YXqu8fM6EzwckQHQFP7iK3vqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/7ha/Pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2526CC4CEEF;
	Thu, 13 Mar 2025 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741868921;
	bh=ZP2UghbhMBfp3KumYFEMjRNBf5P2m9iAdFHFJ8+6V5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/7ha/Pb8QtTWLybNmKAsaKXrnAGJ5Yu1Y9W/2+3+qdTBc7xSTgDxQ7Vgjvv7p7Nu
	 7BwKPUiDTkecvjp5wAeG1uMKLjLyNpQQfi4MJfWPC59hR+oRx6UoUt85Qe0Rth/Qkj
	 mn5YIYxxjgCrnEkNE6BCnkgvkluTCIA/kChB/3Y8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.13.7
Date: Thu, 13 Mar 2025 13:28:29 +0100
Message-ID: <2025031329-fifty-cozily-1130@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025031329-macaw-unstable-669c@gregkh>
References: <2025031329-macaw-unstable-669c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index b2b36d0c3094..7a85b6eb884e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -212,6 +212,17 @@ pid>/``).
 This value defaults to 0.
 
 
+core_sort_vma
+=============
+
+The default coredump writes VMAs in address order. By setting
+``core_sort_vma`` to 1, VMAs will be written from smallest size
+to largest size. This is known to break at least elfutils, but
+can be handy when dealing with very large (and truncated)
+coredumps where the more useful debugging details are included
+in the smaller VMAs.
+
+
 core_uses_pid
 =============
 
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index ab5881d0d017..52d3f1ce3367 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -146,6 +146,7 @@ properties:
     maxItems: 2
 
   pwm-names:
+    minItems: 1
     items:
       - const: convst1
       - const: convst2
diff --git a/Makefile b/Makefile
index f49182f3bae1..3363645fa624 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 13
-SUBLEVEL = 6
+SUBLEVEL = 7
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -1122,6 +1122,11 @@ endif
 KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
+# userspace programs are linked via the compiler, use the correct linker
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+KBUILD_USERLDFLAGS += --ld-path=$(LD)
+endif
+
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
 
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 2bec87c3327d..39fd5df73317 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_struct *vma, unsigned long address,
 }
 
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
-		      unsigned long pfn, struct vm_fault *vmf)
+		      unsigned long pfn, bool need_lock)
 {
 	spinlock_t *ptl;
 	pgd_t *pgd;
@@ -99,12 +99,11 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 	if (!pte)
 		return 0;
 
-	/*
-	 * If we are using split PTE locks, then we need to take the page
-	 * lock here.  Otherwise we are using shared mm->page_table_lock
-	 * which is already locked, thus cannot take it.
-	 */
-	if (ptl != vmf->ptl) {
+	if (need_lock) {
+		/*
+		 * Use nested version here to indicate that we are already
+		 * holding one similar spinlock.
+		 */
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 		if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd)))) {
 			pte_unmap_unlock(pte, ptl);
@@ -114,7 +113,7 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-	if (ptl != vmf->ptl)
+	if (need_lock)
 		spin_unlock(ptl);
 	pte_unmap(pte);
 
@@ -123,9 +122,10 @@ static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
 
 static void
 make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
-	      unsigned long addr, pte_t *ptep, unsigned long pfn,
-	      struct vm_fault *vmf)
+	      unsigned long addr, pte_t *ptep, unsigned long pfn)
 {
+	const unsigned long pmd_start_addr = ALIGN_DOWN(addr, PMD_SIZE);
+	const unsigned long pmd_end_addr = pmd_start_addr + PMD_SIZE;
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *mpnt;
 	unsigned long offset;
@@ -141,6 +141,14 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
 	 */
 	flush_dcache_mmap_lock(mapping);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
+		/*
+		 * If we are using split PTE locks, then we need to take the pte
+		 * lock. Otherwise we are using shared mm->page_table_lock which
+		 * is already locked, thus cannot take it.
+		 */
+		bool need_lock = IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS);
+		unsigned long mpnt_addr;
+
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 * Note that we intentionally mask out the VMA
@@ -151,7 +159,12 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma,
 		if (!(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
 		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		aliases += adjust_pte(mpnt, mpnt->vm_start + offset, pfn, vmf);
+		mpnt_addr = mpnt->vm_start + offset;
+
+		/* Avoid deadlocks by not grabbing the same PTE lock again. */
+		if (mpnt_addr >= pmd_start_addr && mpnt_addr < pmd_end_addr)
+			need_lock = false;
+		aliases += adjust_pte(mpnt, mpnt_addr, pfn, need_lock);
 	}
 	flush_dcache_mmap_unlock(mapping);
 	if (aliases)
@@ -194,7 +207,7 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
 		__flush_dcache_folio(mapping, folio);
 	if (mapping) {
 		if (cache_is_vivt())
-			make_coherent(mapping, vma, addr, ptep, pfn, vmf);
+			make_coherent(mapping, vma, addr, ptep, pfn);
 		else if (vma->vm_flags & VM_EXEC)
 			__flush_icache_all();
 	}
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index c6dff3e69539..03db9cb21ace 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -42,8 +42,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
-extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-				     unsigned long addr, pte_t *ptep);
+extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				     pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 98a2a0e64e25..b3a7fafe8892 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -100,20 +100,11 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 
 static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 {
-	int contig_ptes = 0;
+	int contig_ptes = 1;
 
 	*pgsize = size;
 
 	switch (size) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SIZE:
-		if (pud_sect_supported())
-			contig_ptes = 1;
-		break;
-#endif
-	case PMD_SIZE:
-		contig_ptes = 1;
-		break;
 	case CONT_PMD_SIZE:
 		*pgsize = PMD_SIZE;
 		contig_ptes = CONT_PMDS;
@@ -122,6 +113,8 @@ static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
 		*pgsize = PAGE_SIZE;
 		contig_ptes = CONT_PTES;
 		break;
+	default:
+		WARN_ON(!__hugetlb_valid_size(size));
 	}
 
 	return contig_ptes;
@@ -163,24 +156,23 @@ static pte_t get_clear_contig(struct mm_struct *mm,
 			     unsigned long pgsize,
 			     unsigned long ncontig)
 {
-	pte_t orig_pte = __ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
-
-		/*
-		 * If HW_AFDBM is enabled, then the HW could turn on
-		 * the dirty or accessed bit for any page in the set,
-		 * so check them all.
-		 */
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
+	pte_t pte, tmp_pte;
+	bool present;
+
+	pte = __ptep_get_and_clear(mm, addr, ptep);
+	present = pte_present(pte);
+	while (--ncontig) {
+		ptep++;
+		addr += pgsize;
+		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
+		if (present) {
+			if (pte_dirty(tmp_pte))
+				pte = pte_mkdirty(pte);
+			if (pte_young(tmp_pte))
+				pte = pte_mkyoung(pte);
+		}
 	}
-	return orig_pte;
+	return pte;
 }
 
 static pte_t get_clear_contig_flush(struct mm_struct *mm,
@@ -396,18 +388,13 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		__pte_clear(mm, addr, ptep);
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, unsigned long sz)
 {
 	int ncontig;
 	size_t pgsize;
-	pte_t orig_pte = __ptep_get(ptep);
-
-	if (!pte_cont(orig_pte))
-		return __ptep_get_and_clear(mm, addr, ptep);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
 
+	ncontig = num_contig_ptes(sz, &pgsize);
 	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 }
 
@@ -549,6 +536,8 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
 
 pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
 	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_2645198)) {
 		/*
 		 * Break-before-make (BBM) is required for all user space mappings
@@ -558,7 +547,7 @@ pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr
 		if (pte_user_exec(__ptep_get(ptep)))
 			return huge_ptep_clear_flush(vma, addr, ptep);
 	}
-	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
 }
 
 void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index 08388876ade4..561ac1bf79e2 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -4,6 +4,7 @@
 
 #include <asm/break.h>
 #include <linux/stringify.h>
+#include <linux/objtool.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
 #define _BUGVERBOSE_LOCATION(file, line)
@@ -33,25 +34,25 @@
 
 #define ASM_BUG_FLAGS(flags)					\
 	__BUG_ENTRY(flags)					\
-	break		BRK_BUG
+	break		BRK_BUG;
 
 #define ASM_BUG()	ASM_BUG_FLAGS(0)
 
-#define __BUG_FLAGS(flags)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
+#define __BUG_FLAGS(flags, extra)					\
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
+			     extra);
 
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
-	annotate_reachable();					\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ASM_REACHABLE);	\
 	instrumentation_end();					\
 } while (0)
 
 #define BUG()							\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(0);						\
+	__BUG_FLAGS(0, "");					\
 	unreachable();						\
 } while (0)
 
diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index c8e4057734d0..4dc4b3e04225 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -36,7 +36,8 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = ptep_get(ptep);
@@ -51,8 +52,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_tlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
index 8ae641dc53bb..f9381800e291 100644
--- a/arch/loongarch/kernel/machine_kexec.c
+++ b/arch/loongarch/kernel/machine_kexec.c
@@ -126,14 +126,14 @@ void kexec_reboot(void)
 	/* All secondary cpus go to kexec_smp_wait */
 	if (smp_processor_id() > 0) {
 		relocated_kexec_smp_wait(NULL);
-		unreachable();
+		BUG();
 	}
 #endif
 
 	do_kexec = (void *)reboot_code_buffer;
 	do_kexec(efi_boot, cmdline_ptr, systable_ptr, start_addr, first_ind_entry);
 
-	unreachable();
+	BUG();
 }
 
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 56934fe58170..1fa6a604734e 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -387,6 +387,9 @@ static void __init check_kernel_sections_mem(void)
  */
 static void __init arch_mem_init(char **cmdline_p)
 {
+	/* Recalculate max_low_pfn for "mem=xxx" */
+	max_pfn = max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
+
 	if (usermem)
 		pr_info("User-defined physical RAM map overwrite\n");
 
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index fbf747447f13..4b24589c0b56 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/export.h>
+#include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/time.h>
 #include <linux/tracepoint.h>
@@ -423,7 +424,7 @@ void loongson_cpu_die(unsigned int cpu)
 	mb();
 }
 
-void __noreturn arch_cpu_idle_dead(void)
+static void __noreturn idle_play_dead(void)
 {
 	register uint64_t addr;
 	register void (*init_fn)(void);
@@ -447,6 +448,50 @@ void __noreturn arch_cpu_idle_dead(void)
 	BUG();
 }
 
+#ifdef CONFIG_HIBERNATION
+static void __noreturn poll_play_dead(void)
+{
+	register uint64_t addr;
+	register void (*init_fn)(void);
+
+	idle_task_exit();
+	__this_cpu_write(cpu_state, CPU_DEAD);
+
+	__smp_mb();
+	do {
+		__asm__ __volatile__("nop\n\t");
+		addr = iocsr_read64(LOONGARCH_IOCSR_MBUF0);
+	} while (addr == 0);
+
+	init_fn = (void *)TO_CACHE(addr);
+	iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_CLEAR);
+
+	init_fn();
+	BUG();
+}
+#endif
+
+static void (*play_dead)(void) = idle_play_dead;
+
+void __noreturn arch_cpu_idle_dead(void)
+{
+	play_dead();
+	BUG(); /* play_dead() doesn't return */
+}
+
+#ifdef CONFIG_HIBERNATION
+int hibernate_resume_nonboot_cpu_disable(void)
+{
+	int ret;
+
+	play_dead = poll_play_dead;
+	ret = suspend_disable_secondary_cpus();
+	play_dead = idle_play_dead;
+
+	return ret;
+}
+#endif
+
 #endif
 
 /*
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index a7893bd01e73..6db13d3e189e 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -669,6 +669,12 @@ static int kvm_handle_rdwr_fault(struct kvm_vcpu *vcpu, bool write)
 	struct kvm_run *run = vcpu->run;
 	unsigned long badv = vcpu->arch.badv;
 
+	/* Inject ADE exception if exceed max GPA size */
+	if (unlikely(badv >= vcpu->kvm->arch.gpa_size)) {
+		kvm_queue_exception(vcpu, EXCCODE_ADE, EXSUBCODE_ADEM);
+		return RESUME_GUEST;
+	}
+
 	ret = kvm_handle_mm_fault(vcpu, badv, write);
 	if (ret) {
 		/* Treat as MMIO */
diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
index 034402e0948c..d0b941459a6b 100644
--- a/arch/loongarch/kvm/main.c
+++ b/arch/loongarch/kvm/main.c
@@ -299,6 +299,13 @@ int kvm_arch_enable_virtualization_cpu(void)
 	kvm_debug("GCFG:%lx GSTAT:%lx GINTC:%lx GTLBC:%lx",
 		  read_csr_gcfg(), read_csr_gstat(), read_csr_gintc(), read_csr_gtlbc());
 
+	/*
+	 * HW Guest CSR registers are lost after CPU suspend and resume.
+	 * Clear last_vcpu so that Guest CSR registers forced to reload
+	 * from vCPU SW state.
+	 */
+	this_cpu_ptr(vmcs)->last_vcpu = NULL;
+
 	return 0;
 }
 
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index d18a4a270415..153b617c115b 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -311,7 +311,7 @@ static int kvm_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int ret = RESUME_GUEST;
 	unsigned long estat = vcpu->arch.host_estat;
-	u32 intr = estat & 0x1fff; /* Ignore NMI */
+	u32 intr = estat & CSR_ESTAT_IS;
 	u32 ecode = (estat & CSR_ESTAT_EXC) >> CSR_ESTAT_EXC_SHIFT;
 
 	vcpu->mode = OUTSIDE_GUEST_MODE;
diff --git a/arch/loongarch/kvm/vm.c b/arch/loongarch/kvm/vm.c
index b8b3e1972d6e..edccfc8c9cd8 100644
--- a/arch/loongarch/kvm/vm.c
+++ b/arch/loongarch/kvm/vm.c
@@ -48,7 +48,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (kvm_pvtime_supported())
 		kvm->arch.pv_features |= BIT(KVM_FEATURE_STEAL_TIME);
 
-	kvm->arch.gpa_size = BIT(cpu_vabits - 1);
+	/*
+	 * cpu_vabits means user address space only (a half of total).
+	 * GPA size of VM is the same with the size of user address space.
+	 */
+	kvm->arch.gpa_size = BIT(cpu_vabits);
 	kvm->arch.root_level = CONFIG_PGTABLE_LEVELS - 1;
 	kvm->arch.invalid_ptes[0] = 0;
 	kvm->arch.invalid_ptes[1] = (unsigned long)invalid_pte_table;
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index 914e82ff3f65..1df9e99582cc 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
 #include <linux/export.h>
+#include <linux/hugetlb.h>
 #include <linux/io.h>
 #include <linux/kfence.h>
 #include <linux/memblock.h>
@@ -63,8 +64,11 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	}
 
 	info.length = len;
-	info.align_mask = do_color_align ? (PAGE_MASK & SHM_ALIGN_MASK) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
+	if (filp && is_file_hugepages(filp))
+		info.align_mask = huge_page_mask_align(filp);
+	else
+		info.align_mask = do_color_align ? (PAGE_MASK & SHM_ALIGN_MASK) : 0;
 
 	if (dir == DOWN) {
 		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index d0a86ce83de9..fbc71ddcf0f6 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -27,7 +27,8 @@ static inline int prepare_hugepage_range(struct file *file,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	pte_t clear;
 	pte_t pte = *ptep;
@@ -42,13 +43,14 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
 	/*
 	 * clear the huge pte entry firstly, so that the other smp threads will
 	 * not get old pte entry after finishing flush_tlb_page and before
 	 * setting new huge pte entry
 	 */
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_tlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 5b3a5429f71b..21e9ace17739 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -10,7 +10,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
index e9d18cf25b79..a94fe546d434 100644
--- a/arch/parisc/mm/hugetlbpage.c
+++ b/arch/parisc/mm/hugetlbpage.c
@@ -126,7 +126,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	pte_t entry;
 
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index dad2e7980f24..86326587e58d 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -45,7 +45,8 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
 {
 	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
 }
@@ -55,8 +56,9 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
 	pte_t pte;
+	unsigned long sz = huge_page_size(hstate_vma(vma));
 
-	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, sz);
 	flush_hugetlb_page(vma, addr);
 	return pte;
 }
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index faf3624d8057..446126497768 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -28,7 +28,8 @@ void set_huge_pte_at(struct mm_struct *mm,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep);
+			      unsigned long addr, pte_t *ptep,
+			      unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 42314f093922..b4a78a4b35cf 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -293,7 +293,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	pte_t orig_pte = ptep_get(ptep);
 	int pte_num;
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index a40664b236e9..5ef1b5778fc7 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -23,9 +23,17 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
 #define __HAVE_ARCH_HUGE_PTEP_GET
 extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+
+pte_t __huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep);
+
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
-extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep);
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep,
+					    unsigned long sz)
+{
+	return __huge_ptep_get_and_clear(mm, addr, ptep);
+}
 
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
@@ -47,7 +55,7 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long address, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
+	return __huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
 }
 
 #define  __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
@@ -57,7 +65,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 {
 	int changed = !pte_same(huge_ptep_get(vma->vm_mm, addr, ptep), pte);
 	if (changed) {
-		huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+		__huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 		__set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
 	}
 	return changed;
@@ -67,7 +75,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
-	pte_t pte = huge_ptep_get_and_clear(mm, addr, ptep);
+	pte_t pte = __huge_ptep_get_and_clear(mm, addr, ptep);
 	__set_huge_pte_at(mm, addr, ptep, pte_wrprotect(pte));
 }
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 24fee11b030d..b746213d3110 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -285,10 +285,10 @@ static void __init test_monitor_call(void)
 		return;
 	asm volatile(
 		"	mc	0,0\n"
-		"0:	xgr	%0,%0\n"
+		"0:	lhi	%[val],0\n"
 		"1:\n"
-		EX_TABLE(0b,1b)
-		: "+d" (val));
+		EX_TABLE(0b, 1b)
+		: [val] "+d" (val));
 	if (!val)
 		panic("Monitor call doesn't work!\n");
 }
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index d9ce199953de..2e568f175cd4 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -188,8 +188,8 @@ pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 	return __rste_to_pte(pte_val(*ptep));
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
+pte_t __huge_ptep_get_and_clear(struct mm_struct *mm,
+				unsigned long addr, pte_t *ptep)
 {
 	pte_t pte = huge_ptep_get(mm, addr, ptep);
 	pmd_t *pmdp = (pmd_t *) ptep;
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index c714ca6a05aa..e7a9cdd498dc 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -20,7 +20,7 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep);
+			      pte_t *ptep, unsigned long sz);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index eee601a0d2cf..80504148d8a5 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -260,7 +260,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 }
 
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep)
+			      pte_t *ptep, unsigned long sz)
 {
 	unsigned int i, nptes, orig_shift, shift;
 	unsigned long size;
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index c882e1f67af0..d8c5de40669d 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 #include <asm/bootparam.h>
+#include <asm/bootparam_utils.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
@@ -107,6 +108,7 @@ asmlinkage void configure_5level_paging(struct boot_params *bp, void *pgtable)
 	bool l5_required = false;
 
 	/* Initialize boot_params. Required for cmdline_find_option_bool(). */
+	sanitize_boot_params(bp);
 	boot_params_ptr = bp;
 
 	/*
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 76bfeb03c041..c39ee7d569e0 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -761,6 +761,7 @@ struct kvm_vcpu_arch {
 	u32 pkru;
 	u32 hflags;
 	u64 efer;
+	u64 host_debugctl;
 	u64 apic_base;
 	struct kvm_lapic *apic;    /* kernel irqchip context */
 	bool load_eoi_exitmap_pending;
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 37b8244899d8..04712fd0c964 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -405,7 +405,6 @@ bool __init early_is_amd_nb(u32 device)
 
 struct resource *amd_get_mmconfig_range(struct resource *res)
 {
-	u32 address;
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
@@ -413,13 +412,11 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
-	/* assume all cpus from fam10h have mmconfig */
-	if (boot_cpu_data.x86 < 0x10)
+	/* Assume CPUs from Fam10h have mmconfig, although not all VMs do */
+	if (boot_cpu_data.x86 < 0x10 ||
+	    rdmsrl_safe(MSR_FAM10H_MMIO_CONF_BASE, &msr))
 		return NULL;
 
-	address = MSR_FAM10H_MMIO_CONF_BASE;
-	rdmsrl(address, msr);
-
 	/* mmconfig is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index e6fa03ed9172..a6c6bccfa8b8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -808,7 +808,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 			/* If bit 31 is set, this is an unknown format */
-			for (j = 0 ; j < 3 ; j++)
+			for (j = 0 ; j < 4 ; j++)
 				if (regs[j] & (1 << 31))
 					regs[j] = 0;
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8ded9f859a3a..80b7eaca5aa7 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -640,26 +640,37 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 }
 #endif
 
-#define TLB_INST_4K	0x01
-#define TLB_INST_4M	0x02
-#define TLB_INST_2M_4M	0x03
+#define TLB_INST_4K		0x01
+#define TLB_INST_4M		0x02
+#define TLB_INST_2M_4M		0x03
 
-#define TLB_INST_ALL	0x05
-#define TLB_INST_1G	0x06
+#define TLB_INST_ALL		0x05
+#define TLB_INST_1G		0x06
 
-#define TLB_DATA_4K	0x11
-#define TLB_DATA_4M	0x12
-#define TLB_DATA_2M_4M	0x13
-#define TLB_DATA_4K_4M	0x14
+#define TLB_DATA_4K		0x11
+#define TLB_DATA_4M		0x12
+#define TLB_DATA_2M_4M		0x13
+#define TLB_DATA_4K_4M		0x14
 
-#define TLB_DATA_1G	0x16
+#define TLB_DATA_1G		0x16
+#define TLB_DATA_1G_2M_4M	0x17
 
-#define TLB_DATA0_4K	0x21
-#define TLB_DATA0_4M	0x22
-#define TLB_DATA0_2M_4M	0x23
+#define TLB_DATA0_4K		0x21
+#define TLB_DATA0_4M		0x22
+#define TLB_DATA0_2M_4M		0x23
 
-#define STLB_4K		0x41
-#define STLB_4K_2M	0x42
+#define STLB_4K			0x41
+#define STLB_4K_2M		0x42
+
+/*
+ * All of leaf 0x2's one-byte TLB descriptors implies the same number of
+ * entries for their respective TLB types.  The 0x63 descriptor is an
+ * exception: it implies 4 dTLB entries for 1GB pages 32 dTLB entries
+ * for 2MB or 4MB pages.  Encode descriptor 0x63 dTLB entry count for
+ * 2MB/4MB pages here, as its count for dTLB 1GB pages is already at the
+ * intel_tlb_table[] mapping.
+ */
+#define TLB_0x63_2M_4M_ENTRIES	32
 
 static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x01, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages, 4-way set associative" },
@@ -681,7 +692,8 @@ static const struct _tlb_table intel_tlb_table[] = {
 	{ 0x5c, TLB_DATA_4K_4M,		128,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
-	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x63, TLB_DATA_1G_2M_4M,	4,	" TLB_DATA 1 GByte pages, 4-way set associative"
+						" (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here)" },
 	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
 	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
 	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
@@ -781,6 +793,12 @@ static void intel_tlb_lookup(const unsigned char desc)
 		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
 		break;
+	case TLB_DATA_1G_2M_4M:
+		if (tlb_lld_2m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_2m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		if (tlb_lld_4m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
+			tlb_lld_4m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		fallthrough;
 	case TLB_DATA_1G:
 		if (tlb_lld_1g[ENTRIES] < intel_tlb_table[k].entries)
 			tlb_lld_1g[ENTRIES] = intel_tlb_table[k].entries;
@@ -804,7 +822,7 @@ static void intel_detect_tlb(struct cpuinfo_x86 *c)
 		cpuid(2, &regs[0], &regs[1], &regs[2], &regs[3]);
 
 		/* If bit 31 is set, this is an unknown format */
-		for (j = 0 ; j < 3 ; j++)
+		for (j = 0 ; j < 4 ; j++)
 			if (regs[j] & (1 << 31))
 				regs[j] = 0;
 
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f5365b32582a..def6a2854a4b 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -175,23 +175,29 @@ static bool need_sha_check(u32 cur_rev)
 {
 	switch (cur_rev >> 8) {
 	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;
 	case 0x86081: return cur_rev <= 0x8608108; break;
 	case 0x87010: return cur_rev <= 0x8701034; break;
 	case 0x8a000: return cur_rev <= 0x8a0000a; break;
+	case 0xa0010: return cur_rev <= 0xa00107a; break;
 	case 0xa0011: return cur_rev <= 0xa0011da; break;
 	case 0xa0012: return cur_rev <= 0xa001243; break;
+	case 0xa0082: return cur_rev <= 0xa00820e; break;
 	case 0xa1011: return cur_rev <= 0xa101153; break;
 	case 0xa1012: return cur_rev <= 0xa10124e; break;
 	case 0xa1081: return cur_rev <= 0xa108109; break;
 	case 0xa2010: return cur_rev <= 0xa20102f; break;
 	case 0xa2012: return cur_rev <= 0xa201212; break;
+	case 0xa4041: return cur_rev <= 0xa404109; break;
+	case 0xa5000: return cur_rev <= 0xa500013; break;
 	case 0xa6012: return cur_rev <= 0xa60120a; break;
 	case 0xa7041: return cur_rev <= 0xa704109; break;
 	case 0xa7052: return cur_rev <= 0xa705208; break;
 	case 0xa7080: return cur_rev <= 0xa708009; break;
 	case 0xa70c0: return cur_rev <= 0xa70C009; break;
+	case 0xaa001: return cur_rev <= 0xaa00116; break;
 	case 0xaa002: return cur_rev <= 0xaa00218; break;
 	default: break;
 	}
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index b65ab214bdf5..776a20172867 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -64,6 +64,13 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	struct file *backing;
 	long ret;
 
+	/*
+	 * ECREATE would detect this too, but checking here also ensures
+	 * that the 'encl_size' calculations below can never overflow.
+	 */
+	if (!is_power_of_2(secs->size))
+		return -EINVAL;
+
 	va_page = sgx_encl_grow(encl, true);
 	if (IS_ERR(va_page))
 		return PTR_ERR(va_page);
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ae0b438a2c99..ed3b28e5609f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1393,7 +1393,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		entry->ecx = entry->edx = 0;
 		if (!enable_pmu || !kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2)) {
-			entry->eax = entry->ebx;
+			entry->eax = entry->ebx = 0;
 			break;
 		}
 
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fe6cc763fd51..0f40267114a0 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4567,6 +4567,8 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm)
 
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa)
 {
+	struct kvm *kvm = svm->vcpu.kvm;
+
 	/*
 	 * All host state for SEV-ES guests is categorized into three swap types
 	 * based on how it is handled by hardware during a world switch:
@@ -4590,10 +4592,15 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 
 	/*
 	 * If DebugSwap is enabled, debug registers are loaded but NOT saved by
-	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU both
-	 * saves and loads debug registers (Type-A).
+	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU does
+	 * not save or load debug registers.  Sadly, on CPUs without
+	 * ALLOWED_SEV_FEATURES, KVM can't prevent SNP guests from enabling
+	 * DebugSwap on secondary vCPUs without KVM's knowledge via "AP Create".
+	 * Save all registers if DebugSwap is supported to prevent host state
+	 * from being clobbered by a misbehaving guest.
 	 */
-	if (sev_vcpu_has_debug_swap(svm)) {
+	if (sev_vcpu_has_debug_swap(svm) ||
+	    (sev_snp_guest(kvm) && cpu_feature_enabled(X86_FEATURE_DEBUG_SWAP))) {
 		hostsa->dr0 = native_get_debugreg(0);
 		hostsa->dr1 = native_get_debugreg(1);
 		hostsa->dr2 = native_get_debugreg(2);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 68704e035d7c..3f0e219288f5 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3169,6 +3169,27 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 			kvm_pr_unimpl_wrmsr(vcpu, ecx, data);
 			break;
 		}
+
+		/*
+		 * AMD changed the architectural behavior of bits 5:2.  On CPUs
+		 * without BusLockTrap, bits 5:2 control "external pins", but
+		 * on CPUs that support BusLockDetect, bit 2 enables BusLockTrap
+		 * and bits 5:3 are reserved-to-zero.  Sadly, old KVM allowed
+		 * the guest to set bits 5:2 despite not actually virtualizing
+		 * Performance-Monitoring/Breakpoint external pins.  Drop bits
+		 * 5:2 for backwards compatibility.
+		 */
+		data &= ~GENMASK(5, 2);
+
+		/*
+		 * Suppress BTF as KVM doesn't virtualize BTF, but there's no
+		 * way to communicate lack of support to the guest.
+		 */
+		if (data & DEBUGCTLMSR_BTF) {
+			kvm_pr_unimpl_wrmsr(vcpu, MSR_IA32_DEBUGCTLMSR, data);
+			data &= ~DEBUGCTLMSR_BTF;
+		}
+
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
@@ -4178,6 +4199,18 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 
 	guest_state_enter_irqoff();
 
+	/*
+	 * Set RFLAGS.IF prior to VMRUN, as the host's RFLAGS.IF at the time of
+	 * VMRUN controls whether or not physical IRQs are masked (KVM always
+	 * runs with V_INTR_MASKING_MASK).  Toggle RFLAGS.IF here to avoid the
+	 * temptation to do STI+VMRUN+CLI, as AMD CPUs bleed the STI shadow
+	 * into guest state if delivery of an event during VMRUN triggers a
+	 * #VMEXIT, and the guest_state transitions already tell lockdep that
+	 * IRQs are being enabled/disabled.  Note!  GIF=0 for the entirety of
+	 * this path, so IRQs aren't actually unmasked while running host code.
+	 */
+	raw_local_irq_enable();
+
 	amd_clear_divider();
 
 	if (sev_es_guest(vcpu->kvm))
@@ -4186,6 +4219,8 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu, bool spec_ctrl_in
 	else
 		__svm_vcpu_run(svm, spec_ctrl_intercepted);
 
+	raw_local_irq_disable();
+
 	guest_state_exit_irqoff();
 }
 
@@ -4242,6 +4277,16 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 	clgi();
 	kvm_load_guest_xsave_state(vcpu);
 
+	/*
+	 * Hardware only context switches DEBUGCTL if LBR virtualization is
+	 * enabled.  Manually load DEBUGCTL if necessary (and restore it after
+	 * VM-Exit), as running with the host's DEBUGCTL can negatively affect
+	 * guest state and can even be fatal, e.g. due to Bus Lock Detect.
+	 */
+	if (!(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) &&
+	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
+		update_debugctlmsr(svm->vmcb->save.dbgctl);
+
 	kvm_wait_lapic_expire(vcpu);
 
 	/*
@@ -4269,6 +4314,10 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
 		kvm_before_interrupt(vcpu, KVM_HANDLING_NMI);
 
+	if (!(svm->vmcb->control.virt_ext & LBR_CTL_ENABLE_MASK) &&
+	    vcpu->arch.host_debugctl != svm->vmcb->save.dbgctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
+
 	kvm_load_host_xsave_state(vcpu);
 	stgi();
 
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 43fa6a16eb19..d114efac7af7 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -591,7 +591,7 @@ static inline bool is_vnmi_enabled(struct vcpu_svm *svm)
 /* svm.c */
 #define MSR_INVALID				0xffffffffU
 
-#define DEBUGCTL_RESERVED_BITS (~(0x3fULL))
+#define DEBUGCTL_RESERVED_BITS (~DEBUGCTLMSR_LBR)
 
 extern bool dump_invalid_vmcb;
 
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index 2ed80aea3bb1..0c61153b275f 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -170,12 +170,8 @@ SYM_FUNC_START(__svm_vcpu_run)
 	mov VCPU_RDI(%_ASM_DI), %_ASM_DI
 
 	/* Enter guest mode */
-	sti
-
 3:	vmrun %_ASM_AX
 4:
-	cli
-
 	/* Pop @svm to RAX while it's the only available register. */
 	pop %_ASM_AX
 
@@ -340,12 +336,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	mov KVM_VMCB_pa(%rax), %rax
 
 	/* Enter guest mode */
-	sti
-
 1:	vmrun %rax
-
-2:	cli
-
+2:
 	/* IMPORTANT: Stuff the RSB immediately after VM-Exit, before RET! */
 	FILL_RETURN_BUFFER %rax, RSB_CLEAR_LOOPS, X86_FEATURE_RSB_VMEXIT
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aebd45d43ebb..bd20609e69d1 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1514,16 +1514,12 @@ void vmx_vcpu_load_vmcs(struct kvm_vcpu *vcpu, int cpu,
  */
 void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	struct vcpu_vmx *vmx = to_vmx(vcpu);
-
 	if (vcpu->scheduled_out && !kvm_pause_in_guest(vcpu->kvm))
 		shrink_ple_window(vcpu);
 
 	vmx_vcpu_load_vmcs(vcpu, cpu, NULL);
 
 	vmx_vcpu_pi_load(vcpu, cpu);
-
-	vmx->host_debugctlmsr = get_debugctlmsr();
 }
 
 void vmx_vcpu_put(struct kvm_vcpu *vcpu)
@@ -7469,8 +7465,8 @@ fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	}
 
 	/* MSR_IA32_DEBUGCTLMSR is zeroed on vmexit. Restore it if needed */
-	if (vmx->host_debugctlmsr)
-		update_debugctlmsr(vmx->host_debugctlmsr);
+	if (vcpu->arch.host_debugctl)
+		update_debugctlmsr(vcpu->arch.host_debugctl);
 
 #ifndef CONFIG_X86_64
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 892302022094..13ba4bac1f24 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -337,8 +337,6 @@ struct vcpu_vmx {
 	/* apic deadline value in host tsc */
 	u64 hv_deadline_tsc;
 
-	unsigned long host_debugctlmsr;
-
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
 	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 030310b26c69..742d9f4bca22 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10960,6 +10960,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 5e9be13a56a8..7acba66eed48 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -682,7 +682,7 @@ static void utf16_le_to_7bit(const __le16 *in, unsigned int size, u8 *out)
 	out[size] = 0;
 
 	while (i < size) {
-		u8 c = le16_to_cpu(in[i]) & 0xff;
+		u8 c = le16_to_cpu(in[i]) & 0x7f;
 
 		if (c && !isprint(c))
 			c = '!';
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 94865c9d8adc..70dbf8706980 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2079,6 +2079,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode_handle *con_handle,
 out:
 	sup_handle->flags &= ~FWNODE_FLAG_VISITED;
 	put_device(sup_dev);
+	put_device(con_dev);
 	put_device(par_dev);
 	return ret;
 }
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 934ab9332c80..d9e8bf9f5e5a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2716,9 +2716,12 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	/* parameters can only be changed when device isn't live */
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+	if (test_bit(UB_STATE_USED, &ub->state)) {
+		/*
+		 * Parameters can only be changed when device hasn't
+		 * been started yet
+		 */
 		ret = -EACCES;
 	} else if (copy_from_user(&ub->params, argp, ph.len)) {
 		ret = -EFAULT;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 72e85673b709..75dbe07e07e2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3652,6 +3652,7 @@ static ssize_t force_poll_sync_write(struct file *file,
 }
 
 static const struct file_operations force_poll_sync_fops = {
+	.owner		= THIS_MODULE,
 	.open		= simple_open,
 	.read		= force_poll_sync_read,
 	.write		= force_poll_sync_write,
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 56ba4192c89c..eb502fc557cd 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1040,8 +1040,9 @@ static void mhi_pci_recovery_work(struct work_struct *work)
 err_unprepare:
 	mhi_unprepare_after_power_down(mhi_cntrl);
 err_try_reset:
-	if (pci_reset_function(pdev))
-		dev_err(&pdev->dev, "Recovery failed\n");
+	err = pci_try_reset_function(pdev);
+	if (err)
+		dev_err(&pdev->dev, "Recovery failed: %d\n", err);
 }
 
 static void health_check(struct timer_list *t)
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 76eac3653b1c..daa0fb62a1f7 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -470,8 +470,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 2cf595d2e10b..f7dd455dd0dd 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -264,8 +264,8 @@ int misc_register(struct miscdevice *misc)
 		device_create_with_groups(&misc_class, misc->parent, dev,
 					  misc, misc->groups, "%s", misc->name);
 	if (IS_ERR(misc->this_device)) {
+		misc_minor_free(misc->minor);
 		if (is_dynamic) {
-			misc_minor_free(misc->minor);
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
 		err = PTR_ERR(misc->this_device);
diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 65f41cc3eafc..d668ddb2e81d 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -119,10 +119,15 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	struct platform_device *pdev;
 	int res, id;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	/* kernfs guarantees string termination, so count + 1 is safe */
 	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr)
-		return -ENOMEM;
+	if (!aggr) {
+		res = -ENOMEM;
+		goto put_module;
+	}
 
 	memcpy(aggr->args, buf, count + 1);
 
@@ -161,6 +166,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	}
 
 	aggr->pdev = pdev;
+	module_put(THIS_MODULE);
 	return count;
 
 remove_table:
@@ -175,6 +181,8 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	kfree(aggr->lookups);
 free_ga:
 	kfree(aggr);
+put_module:
+	module_put(THIS_MODULE);
 	return res;
 }
 
@@ -203,13 +211,19 @@ static ssize_t delete_device_store(struct device_driver *driver,
 	if (error)
 		return error;
 
+	if (!try_module_get(THIS_MODULE))
+		return -ENOENT;
+
 	mutex_lock(&gpio_aggregator_lock);
 	aggr = idr_remove(&gpio_aggregator_idr, id);
 	mutex_unlock(&gpio_aggregator_lock);
-	if (!aggr)
+	if (!aggr) {
+		module_put(THIS_MODULE);
 		return -ENOENT;
+	}
 
 	gpio_aggregator_free(aggr);
+	module_put(THIS_MODULE);
 	return count;
 }
 static DRIVER_ATTR_WO(delete_device);
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 2ecee3269a0c..a7a1cdf7ac66 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -40,7 +40,7 @@ struct gpio_rcar_info {
 
 struct gpio_rcar_priv {
 	void __iomem *base;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct device *dev;
 	struct gpio_chip gpio_chip;
 	unsigned int irq_parent;
@@ -123,7 +123,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	 * "Setting Level-Sensitive Interrupt Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive or negative logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, hwirq, !active_high_rising_edge);
@@ -142,7 +142,7 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
 	if (!level_trigger)
 		gpio_rcar_write(p, INTCLR, BIT(hwirq));
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
@@ -246,7 +246,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	 * "Setting General Input Mode"
 	 */
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 
 	/* Configure positive logic in POSNEG */
 	gpio_rcar_modify_bit(p, POSNEG, gpio, false);
@@ -261,7 +261,7 @@ static void gpio_rcar_config_general_input_output_mode(struct gpio_chip *chip,
 	if (p->info.has_outdtsel && output)
 		gpio_rcar_modify_bit(p, OUTDTSEL, gpio, false);
 
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
@@ -347,7 +347,7 @@ static int gpio_rcar_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 		return 0;
 	}
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	outputs = gpio_rcar_read(p, INOUTSEL);
 	m = outputs & bankmask;
 	if (m)
@@ -356,7 +356,7 @@ static int gpio_rcar_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	m = ~outputs & bankmask;
 	if (m)
 		val |= gpio_rcar_read(p, INDT) & m;
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 
 	bits[0] = val;
 	return 0;
@@ -367,9 +367,9 @@ static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	gpio_rcar_modify_bit(p, OUTDT, offset, value);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -386,12 +386,12 @@ static void gpio_rcar_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 	if (!bankmask)
 		return;
 
-	spin_lock_irqsave(&p->lock, flags);
+	raw_spin_lock_irqsave(&p->lock, flags);
 	val = gpio_rcar_read(p, OUTDT);
 	val &= ~bankmask;
 	val |= (bankmask & bits[0]);
 	gpio_rcar_write(p, OUTDT, val);
-	spin_unlock_irqrestore(&p->lock, flags);
+	raw_spin_unlock_irqrestore(&p->lock, flags);
 }
 
 static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
@@ -468,7 +468,12 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	p->info = *info;
 
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
-	*npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
+	if (ret) {
+		*npins = RCAR_MAX_GPIO_PER_BANK;
+	} else {
+		*npins = args.args[2];
+		of_node_put(args.np);
+	}
 
 	if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
 		dev_warn(p->dev, "Invalid number of gpio lines %u, using %u\n",
@@ -505,7 +510,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	p->dev = dev;
-	spin_lock_init(&p->lock);
+	raw_spin_lock_init(&p->lock);
 
 	/* Get device configuration from DT node */
 	ret = gpio_rcar_parse_dt(p, &npins);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index ad29634f8b44..80c85b6cc478 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -266,8 +266,8 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	/* EOP buffer is not required for all ASICs */
 	if (properties->eop_ring_buffer_address) {
 		if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
-			pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
-				properties->eop_buf_bo->tbo.base.size,
+			pr_debug("queue eop bo size 0x%x not equal to node eop buf size 0x%x\n",
+				properties->eop_ring_buffer_size,
 				topo_dev->node_props.eop_buffer_size);
 			err = -EINVAL;
 			goto out_err_unreserve;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 626f75b6ad00..568f5b215ce2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1455,7 +1455,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
 	/* Invalid input */
-	if (!plane_state->dst_rect.width ||
+	if (!plane_state ||
+			!plane_state->dst_rect.width ||
 			!plane_state->dst_rect.height ||
 			!plane_state->src_rect.width ||
 			!plane_state->src_rect.height) {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index a87040cb2f2e..daa37e009349 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1899,16 +1899,6 @@ static int smu_v14_0_allow_ih_interrupt(struct smu_context *smu)
 				    NULL);
 }
 
-static int smu_v14_0_process_pending_interrupt(struct smu_context *smu)
-{
-	int ret = 0;
-
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_ACDC_BIT))
-		ret = smu_v14_0_allow_ih_interrupt(smu);
-
-	return ret;
-}
-
 int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
 {
 	int ret = 0;
@@ -1920,7 +1910,7 @@ int smu_v14_0_enable_thermal_alert(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	return smu_v14_0_process_pending_interrupt(smu);
+	return smu_v14_0_allow_ih_interrupt(smu);
 }
 
 int smu_v14_0_disable_thermal_alert(struct smu_context *smu)
diff --git a/drivers/gpu/drm/imagination/pvr_fw_meta.c b/drivers/gpu/drm/imagination/pvr_fw_meta.c
index c39beb70c317..6d13864851fc 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_meta.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_meta.c
@@ -527,8 +527,10 @@ pvr_meta_vm_map(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 static void
 pvr_meta_vm_unmap(struct pvr_device *pvr_dev, struct pvr_fw_object *fw_obj)
 {
-	pvr_vm_unmap(pvr_dev->kernel_vm_ctx, fw_obj->fw_mm_node.start,
-		     fw_obj->fw_mm_node.size);
+	struct pvr_gem_object *pvr_obj = fw_obj->gem;
+
+	pvr_vm_unmap_obj(pvr_dev->kernel_vm_ctx, pvr_obj,
+			 fw_obj->fw_mm_node.start, fw_obj->fw_mm_node.size);
 }
 
 static bool
diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index 73707daa4e52..5dbb636d7d4f 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -333,8 +333,8 @@ static int fw_trace_seq_show(struct seq_file *s, void *v)
 	if (sf_id == ROGUE_FW_SF_LAST)
 		return -EINVAL;
 
-	timestamp = read_fw_trace(trace_seq_data, 1) |
-		((u64)read_fw_trace(trace_seq_data, 2) << 32);
+	timestamp = ((u64)read_fw_trace(trace_seq_data, 1) << 32) |
+		read_fw_trace(trace_seq_data, 2);
 	timestamp = (timestamp & ~ROGUE_FWT_TIMESTAMP_TIME_CLRMSK) >>
 		ROGUE_FWT_TIMESTAMP_TIME_SHIFT;
 
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index c4f08432882b..43411be930a2 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -109,12 +109,20 @@ pvr_queue_fence_get_driver_name(struct dma_fence *f)
 	return PVR_DRIVER_NAME;
 }
 
+static void pvr_queue_fence_release_work(struct work_struct *w)
+{
+	struct pvr_queue_fence *fence = container_of(w, struct pvr_queue_fence, release_work);
+
+	pvr_context_put(fence->queue->ctx);
+	dma_fence_free(&fence->base);
+}
+
 static void pvr_queue_fence_release(struct dma_fence *f)
 {
 	struct pvr_queue_fence *fence = container_of(f, struct pvr_queue_fence, base);
+	struct pvr_device *pvr_dev = fence->queue->ctx->pvr_dev;
 
-	pvr_context_put(fence->queue->ctx);
-	dma_fence_free(f);
+	queue_work(pvr_dev->sched_wq, &fence->release_work);
 }
 
 static const char *
@@ -268,6 +276,7 @@ pvr_queue_fence_init(struct dma_fence *f,
 
 	pvr_context_get(queue->ctx);
 	fence->queue = queue;
+	INIT_WORK(&fence->release_work, pvr_queue_fence_release_work);
 	dma_fence_init(&fence->base, fence_ops,
 		       &fence_ctx->lock, fence_ctx->id,
 		       atomic_inc_return(&fence_ctx->seqno));
@@ -304,8 +313,9 @@ pvr_queue_cccb_fence_init(struct dma_fence *fence, struct pvr_queue *queue)
 static void
 pvr_queue_job_fence_init(struct dma_fence *fence, struct pvr_queue *queue)
 {
-	pvr_queue_fence_init(fence, queue, &pvr_queue_job_fence_ops,
-			     &queue->job_fence_ctx);
+	if (!fence->ops)
+		pvr_queue_fence_init(fence, queue, &pvr_queue_job_fence_ops,
+				     &queue->job_fence_ctx);
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_queue.h b/drivers/gpu/drm/imagination/pvr_queue.h
index e06ced69302f..93fe9ac9f58c 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.h
+++ b/drivers/gpu/drm/imagination/pvr_queue.h
@@ -5,6 +5,7 @@
 #define PVR_QUEUE_H
 
 #include <drm/gpu_scheduler.h>
+#include <linux/workqueue.h>
 
 #include "pvr_cccb.h"
 #include "pvr_device.h"
@@ -63,6 +64,9 @@ struct pvr_queue_fence {
 
 	/** @queue: Queue that created this fence. */
 	struct pvr_queue *queue;
+
+	/** @release_work: Fence release work structure. */
+	struct work_struct release_work;
 };
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index 363f885a7098..2896fa7501b1 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -293,8 +293,9 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 
 static int
 pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
-			  struct pvr_vm_context *vm_ctx, u64 device_addr,
-			  u64 size)
+			  struct pvr_vm_context *vm_ctx,
+			  struct pvr_gem_object *pvr_obj,
+			  u64 device_addr, u64 size)
 {
 	int err;
 
@@ -318,6 +319,7 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
 		goto err_bind_op_fini;
 	}
 
+	bind_op->pvr_obj = pvr_obj;
 	bind_op->vm_ctx = vm_ctx;
 	bind_op->device_addr = device_addr;
 	bind_op->size = size;
@@ -597,20 +599,6 @@ pvr_vm_create_context(struct pvr_device *pvr_dev, bool is_userspace_context)
 	return ERR_PTR(err);
 }
 
-/**
- * pvr_vm_unmap_all() - Unmap all mappings associated with a VM context.
- * @vm_ctx: Target VM context.
- *
- * This function ensures that no mappings are left dangling by unmapping them
- * all in order of ascending device-virtual address.
- */
-void
-pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
-{
-	WARN_ON(pvr_vm_unmap(vm_ctx, vm_ctx->gpuvm_mgr.mm_start,
-			     vm_ctx->gpuvm_mgr.mm_range));
-}
-
 /**
  * pvr_vm_context_release() - Teardown a VM context.
  * @ref_count: Pointer to reference counter of the VM context.
@@ -703,11 +691,7 @@ pvr_vm_lock_extra(struct drm_gpuvm_exec *vm_exec)
 	struct pvr_vm_bind_op *bind_op = vm_exec->extra.priv;
 	struct pvr_gem_object *pvr_obj = bind_op->pvr_obj;
 
-	/* Unmap operations don't have an object to lock. */
-	if (!pvr_obj)
-		return 0;
-
-	/* Acquire lock on the GEM being mapped. */
+	/* Acquire lock on the GEM object being mapped/unmapped. */
 	return drm_exec_lock_obj(&vm_exec->exec, gem_from_pvr_gem(pvr_obj));
 }
 
@@ -772,8 +756,10 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
 }
 
 /**
- * pvr_vm_unmap() - Unmap an already mapped section of device-virtual memory.
+ * pvr_vm_unmap_obj_locked() - Unmap an already mapped section of device-virtual
+ * memory.
  * @vm_ctx: Target VM context.
+ * @pvr_obj: Target PowerVR memory object.
  * @device_addr: Virtual device address at the start of the target mapping.
  * @size: Size of the target mapping.
  *
@@ -784,9 +770,13 @@ pvr_vm_map(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
  *  * Any error encountered while performing internal operations required to
  *    destroy the mapping (returned from pvr_vm_gpuva_unmap or
  *    pvr_vm_gpuva_remap).
+ *
+ * The vm_ctx->lock must be held when calling this function.
  */
-int
-pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
+static int
+pvr_vm_unmap_obj_locked(struct pvr_vm_context *vm_ctx,
+			struct pvr_gem_object *pvr_obj,
+			u64 device_addr, u64 size)
 {
 	struct pvr_vm_bind_op bind_op = {0};
 	struct drm_gpuvm_exec vm_exec = {
@@ -799,11 +789,13 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 		},
 	};
 
-	int err = pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, device_addr,
-					    size);
+	int err = pvr_vm_bind_op_unmap_init(&bind_op, vm_ctx, pvr_obj,
+					    device_addr, size);
 	if (err)
 		return err;
 
+	pvr_gem_object_get(pvr_obj);
+
 	err = drm_gpuvm_exec_lock(&vm_exec);
 	if (err)
 		goto err_cleanup;
@@ -818,6 +810,96 @@ pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
 	return err;
 }
 
+/**
+ * pvr_vm_unmap_obj() - Unmap an already mapped section of device-virtual
+ * memory.
+ * @vm_ctx: Target VM context.
+ * @pvr_obj: Target PowerVR memory object.
+ * @device_addr: Virtual device address at the start of the target mapping.
+ * @size: Size of the target mapping.
+ *
+ * Return:
+ *  * 0 on success,
+ *  * Any error encountered by pvr_vm_unmap_obj_locked.
+ */
+int
+pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx, struct pvr_gem_object *pvr_obj,
+		 u64 device_addr, u64 size)
+{
+	int err;
+
+	mutex_lock(&vm_ctx->lock);
+	err = pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj, device_addr, size);
+	mutex_unlock(&vm_ctx->lock);
+
+	return err;
+}
+
+/**
+ * pvr_vm_unmap() - Unmap an already mapped section of device-virtual memory.
+ * @vm_ctx: Target VM context.
+ * @device_addr: Virtual device address at the start of the target mapping.
+ * @size: Size of the target mapping.
+ *
+ * Return:
+ *  * 0 on success,
+ *  * Any error encountered by drm_gpuva_find,
+ *  * Any error encountered by pvr_vm_unmap_obj_locked.
+ */
+int
+pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size)
+{
+	struct pvr_gem_object *pvr_obj;
+	struct drm_gpuva *va;
+	int err;
+
+	mutex_lock(&vm_ctx->lock);
+
+	va = drm_gpuva_find(&vm_ctx->gpuvm_mgr, device_addr, size);
+	if (va) {
+		pvr_obj = gem_to_pvr_gem(va->gem.obj);
+		err = pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
+					      va->va.addr, va->va.range);
+	} else {
+		err = -ENOENT;
+	}
+
+	mutex_unlock(&vm_ctx->lock);
+
+	return err;
+}
+
+/**
+ * pvr_vm_unmap_all() - Unmap all mappings associated with a VM context.
+ * @vm_ctx: Target VM context.
+ *
+ * This function ensures that no mappings are left dangling by unmapping them
+ * all in order of ascending device-virtual address.
+ */
+void
+pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx)
+{
+	mutex_lock(&vm_ctx->lock);
+
+	for (;;) {
+		struct pvr_gem_object *pvr_obj;
+		struct drm_gpuva *va;
+
+		va = drm_gpuva_find_first(&vm_ctx->gpuvm_mgr,
+					  vm_ctx->gpuvm_mgr.mm_start,
+					  vm_ctx->gpuvm_mgr.mm_range);
+		if (!va)
+			break;
+
+		pvr_obj = gem_to_pvr_gem(va->gem.obj);
+
+		WARN_ON(pvr_vm_unmap_obj_locked(vm_ctx, pvr_obj,
+						va->va.addr, va->va.range));
+	}
+
+	mutex_unlock(&vm_ctx->lock);
+}
+
 /* Static data areas are determined by firmware. */
 static const struct drm_pvr_static_data_area static_data_areas[] = {
 	{
diff --git a/drivers/gpu/drm/imagination/pvr_vm.h b/drivers/gpu/drm/imagination/pvr_vm.h
index 79406243617c..b0528dffa7f1 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.h
+++ b/drivers/gpu/drm/imagination/pvr_vm.h
@@ -38,6 +38,9 @@ struct pvr_vm_context *pvr_vm_create_context(struct pvr_device *pvr_dev,
 int pvr_vm_map(struct pvr_vm_context *vm_ctx,
 	       struct pvr_gem_object *pvr_obj, u64 pvr_obj_offset,
 	       u64 device_addr, u64 size);
+int pvr_vm_unmap_obj(struct pvr_vm_context *vm_ctx,
+		     struct pvr_gem_object *pvr_obj,
+		     u64 device_addr, u64 size);
 int pvr_vm_unmap(struct pvr_vm_context *vm_ctx, u64 device_addr, u64 size);
 void pvr_vm_unmap_all(struct pvr_vm_context *vm_ctx);
 
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index ce840300578d..1050a4617fc1 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -4,6 +4,7 @@ config DRM_NOUVEAU
 	depends on DRM && PCI && MMU
 	select IOMMU_API
 	select FW_LOADER
+	select FW_CACHE if PM_SLEEP
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 05c13102a8cb..d22889fbfa9c 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -359,7 +359,8 @@ int r300_mc_wait_for_idle(struct radeon_device *rdev)
 	return -1;
 }
 
-static void r300_gpu_init(struct radeon_device *rdev)
+/* rs400_gpu_init also calls this! */
+void r300_gpu_init(struct radeon_device *rdev)
 {
 	uint32_t gb_tile_config, tmp;
 
diff --git a/drivers/gpu/drm/radeon/radeon_asic.h b/drivers/gpu/drm/radeon/radeon_asic.h
index 1e00f6b99f94..8f5e07834fcc 100644
--- a/drivers/gpu/drm/radeon/radeon_asic.h
+++ b/drivers/gpu/drm/radeon/radeon_asic.h
@@ -165,6 +165,7 @@ void r200_set_safe_registers(struct radeon_device *rdev);
  */
 extern int r300_init(struct radeon_device *rdev);
 extern void r300_fini(struct radeon_device *rdev);
+extern void r300_gpu_init(struct radeon_device *rdev);
 extern int r300_suspend(struct radeon_device *rdev);
 extern int r300_resume(struct radeon_device *rdev);
 extern int r300_asic_reset(struct radeon_device *rdev, bool hard);
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index d6c18fd740ec..13cd0a688a65 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -256,8 +256,22 @@ int rs400_mc_wait_for_idle(struct radeon_device *rdev)
 
 static void rs400_gpu_init(struct radeon_device *rdev)
 {
-	/* FIXME: is this correct ? */
-	r420_pipes_init(rdev);
+	/* Earlier code was calling r420_pipes_init and then
+	 * rs400_mc_wait_for_idle(rdev). The problem is that
+	 * at least on my Mobility Radeon Xpress 200M RC410 card
+	 * that ends up in this code path ends up num_gb_pipes == 3
+	 * while the card seems to have only one pipe. With the
+	 * r420 pipe initialization method.
+	 *
+	 * Problems shown up as HyperZ glitches, see:
+	 * https://bugs.freedesktop.org/show_bug.cgi?id=110897
+	 *
+	 * Delegating initialization to r300 code seems to work
+	 * and results in proper pipe numbers. The rs400 cards
+	 * are said to be not r400, but r300 kind of cards.
+	 */
+	r300_gpu_init(rdev);
+
 	if (rs400_mc_wait_for_idle(rdev)) {
 		pr_warn("rs400: Failed to wait MC idle while programming pipes. Bad things might happen. %08x\n",
 			RREG32(RADEON_MC_STATUS));
diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
index c75302ca3427..f56e77e7f6d0 100644
--- a/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
+++ b/drivers/gpu/drm/scheduler/gpu_scheduler_trace.h
@@ -21,7 +21,7 @@
  *
  */
 
-#if !defined(_GPU_SCHED_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#if !defined(_GPU_SCHED_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
 #define _GPU_SCHED_TRACE_H_
 
 #include <linux/stringify.h>
@@ -106,7 +106,7 @@ TRACE_EVENT(drm_sched_job_wait_dep,
 		      __entry->seqno)
 );
 
-#endif
+#endif /* _GPU_SCHED_TRACE_H_ */
 
 /* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 6f91ff1dbf7e..4e7d49fb9e6e 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -335,8 +335,6 @@ static void bochs_hw_setmode(struct bochs_device *bochs, struct drm_display_mode
 			 bochs->xres, bochs->yres, bochs->bpp,
 			 bochs->yres_virtual);
 
-	bochs_hw_blank(bochs, false);
-
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,      0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         bochs->bpp);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_XRES,        bochs->xres);
@@ -506,6 +504,9 @@ static int bochs_crtc_helper_atomic_check(struct drm_crtc *crtc,
 static void bochs_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 					    struct drm_atomic_state *state)
 {
+	struct bochs_device *bochs = to_bochs_device(crtc->dev);
+
+	bochs_hw_blank(bochs, false);
 }
 
 static void bochs_crtc_helper_atomic_disable(struct drm_crtc *crtc,
diff --git a/drivers/gpu/drm/xe/display/xe_plane_initial.c b/drivers/gpu/drm/xe/display/xe_plane_initial.c
index 8c113463a3d5..668f544a7ac8 100644
--- a/drivers/gpu/drm/xe/display/xe_plane_initial.c
+++ b/drivers/gpu/drm/xe/display/xe_plane_initial.c
@@ -194,8 +194,6 @@ intel_find_initial_plane_obj(struct intel_crtc *crtc,
 		to_intel_plane(crtc->base.primary);
 	struct intel_plane_state *plane_state =
 		to_intel_plane_state(plane->base.state);
-	struct intel_crtc_state *crtc_state =
-		to_intel_crtc_state(crtc->base.state);
 	struct drm_framebuffer *fb;
 	struct i915_vma *vma;
 
@@ -241,14 +239,6 @@ intel_find_initial_plane_obj(struct intel_crtc *crtc,
 	atomic_or(plane->frontbuffer_bit, &to_intel_frontbuffer(fb)->bits);
 
 	plane_config->vma = vma;
-
-	/*
-	 * Flip to the newly created mapping ASAP, so we can re-use the
-	 * first part of GGTT for WOPCM, prevent flickering, and prevent
-	 * the lookup of sysmem scratch pages.
-	 */
-	plane->check_plane(crtc_state, plane_state);
-	plane->async_flip(NULL, plane, crtc_state, plane_state, true);
 	return;
 
 nofb:
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 77d818beb26d..560fb82f5dc4 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -380,9 +380,7 @@ int xe_gt_init_early(struct xe_gt *gt)
 	if (err)
 		return err;
 
-	xe_wa_process_gt(gt);
 	xe_wa_process_oob(gt);
-	xe_tuning_process_gt(gt);
 
 	xe_force_wake_init_gt(gt, gt_to_fw(gt));
 	spin_lock_init(&gt->global_invl_lock);
@@ -474,6 +472,8 @@ static int all_fw_domain_init(struct xe_gt *gt)
 	}
 
 	xe_gt_mcr_set_implicit_defaults(gt);
+	xe_wa_process_gt(gt);
+	xe_tuning_process_gt(gt);
 	xe_reg_sr_apply_mmio(&gt->reg_sr, gt);
 
 	err = xe_gt_clock_init(gt);
diff --git a/drivers/gpu/drm/xe/xe_hmm.c b/drivers/gpu/drm/xe/xe_hmm.c
index 2c32dc46f7d4..d7a9408b3a97 100644
--- a/drivers/gpu/drm/xe/xe_hmm.c
+++ b/drivers/gpu/drm/xe/xe_hmm.c
@@ -19,11 +19,10 @@ static u64 xe_npages_in_range(unsigned long start, unsigned long end)
 	return (end - start) >> PAGE_SHIFT;
 }
 
-/*
+/**
  * xe_mark_range_accessed() - mark a range is accessed, so core mm
  * have such information for memory eviction or write back to
  * hard disk
- *
  * @range: the range to mark
  * @write: if write to this range, we mark pages in this range
  * as dirty
@@ -43,15 +42,51 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
 	}
 }
 
-/*
+static int xe_alloc_sg(struct xe_device *xe, struct sg_table *st,
+		       struct hmm_range *range, struct rw_semaphore *notifier_sem)
+{
+	unsigned long i, npages, hmm_pfn;
+	unsigned long num_chunks = 0;
+	int ret;
+
+	/* HMM docs says this is needed. */
+	ret = down_read_interruptible(notifier_sem);
+	if (ret)
+		return ret;
+
+	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
+		up_read(notifier_sem);
+		return -EAGAIN;
+	}
+
+	npages = xe_npages_in_range(range->start, range->end);
+	for (i = 0; i < npages;) {
+		unsigned long len;
+
+		hmm_pfn = range->hmm_pfns[i];
+		xe_assert(xe, hmm_pfn & HMM_PFN_VALID);
+
+		len = 1UL << hmm_pfn_to_map_order(hmm_pfn);
+
+		/* If order > 0 the page may extend beyond range->start */
+		len -= (hmm_pfn & ~HMM_PFN_FLAGS) & (len - 1);
+		i += len;
+		num_chunks++;
+	}
+	up_read(notifier_sem);
+
+	return sg_alloc_table(st, num_chunks, GFP_KERNEL);
+}
+
+/**
  * xe_build_sg() - build a scatter gather table for all the physical pages/pfn
  * in a hmm_range. dma-map pages if necessary. dma-address is save in sg table
  * and will be used to program GPU page table later.
- *
  * @xe: the xe device who will access the dma-address in sg table
  * @range: the hmm range that we build the sg table from. range->hmm_pfns[]
  * has the pfn numbers of pages that back up this hmm address range.
  * @st: pointer to the sg table.
+ * @notifier_sem: The xe notifier lock.
  * @write: whether we write to this range. This decides dma map direction
  * for system pages. If write we map it bi-diretional; otherwise
  * DMA_TO_DEVICE
@@ -78,43 +113,84 @@ static void xe_mark_range_accessed(struct hmm_range *range, bool write)
  * Returns 0 if successful; -ENOMEM if fails to allocate memory
  */
 static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
-		       struct sg_table *st, bool write)
+		       struct sg_table *st,
+		       struct rw_semaphore *notifier_sem,
+		       bool write)
 {
+	unsigned long npages = xe_npages_in_range(range->start, range->end);
 	struct device *dev = xe->drm.dev;
-	struct page **pages;
-	u64 i, npages;
-	int ret;
+	struct scatterlist *sgl;
+	struct page *page;
+	unsigned long i, j;
 
-	npages = xe_npages_in_range(range->start, range->end);
-	pages = kvmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
-	if (!pages)
-		return -ENOMEM;
+	lockdep_assert_held(notifier_sem);
 
-	for (i = 0; i < npages; i++) {
-		pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
-		xe_assert(xe, !is_device_private_page(pages[i]));
+	i = 0;
+	for_each_sg(st->sgl, sgl, st->nents, j) {
+		unsigned long hmm_pfn, size;
+
+		hmm_pfn = range->hmm_pfns[i];
+		page = hmm_pfn_to_page(hmm_pfn);
+		xe_assert(xe, !is_device_private_page(page));
+
+		size = 1UL << hmm_pfn_to_map_order(hmm_pfn);
+		size -= page_to_pfn(page) & (size - 1);
+		i += size;
+
+		if (unlikely(j == st->nents - 1)) {
+			if (i > npages)
+				size -= (i - npages);
+			sg_mark_end(sgl);
+		}
+		sg_set_page(sgl, page, size << PAGE_SHIFT, 0);
 	}
+	xe_assert(xe, i == npages);
 
-	ret = sg_alloc_table_from_pages_segment(st, pages, npages, 0, npages << PAGE_SHIFT,
-						xe_sg_segment_size(dev), GFP_KERNEL);
-	if (ret)
-		goto free_pages;
+	return dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
+			       DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
+}
+
+static void xe_hmm_userptr_set_mapped(struct xe_userptr_vma *uvma)
+{
+	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
+
+	lockdep_assert_held_write(&vm->lock);
+	lockdep_assert_held(&vm->userptr.notifier_lock);
+
+	mutex_lock(&userptr->unmap_mutex);
+	xe_assert(vm->xe, !userptr->mapped);
+	userptr->mapped = true;
+	mutex_unlock(&userptr->unmap_mutex);
+}
+
+void xe_hmm_userptr_unmap(struct xe_userptr_vma *uvma)
+{
+	struct xe_userptr *userptr = &uvma->userptr;
+	struct xe_vma *vma = &uvma->vma;
+	bool write = !xe_vma_read_only(vma);
+	struct xe_vm *vm = xe_vma_vm(vma);
+	struct xe_device *xe = vm->xe;
 
-	ret = dma_map_sgtable(dev, st, write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE,
-			      DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_NO_KERNEL_MAPPING);
-	if (ret) {
-		sg_free_table(st);
-		st = NULL;
+	if (!lockdep_is_held_type(&vm->userptr.notifier_lock, 0) &&
+	    !lockdep_is_held_type(&vm->lock, 0) &&
+	    !(vma->gpuva.flags & XE_VMA_DESTROYED)) {
+		/* Don't unmap in exec critical section. */
+		xe_vm_assert_held(vm);
+		/* Don't unmap while mapping the sg. */
+		lockdep_assert_held(&vm->lock);
 	}
 
-free_pages:
-	kvfree(pages);
-	return ret;
+	mutex_lock(&userptr->unmap_mutex);
+	if (userptr->sg && userptr->mapped)
+		dma_unmap_sgtable(xe->drm.dev, userptr->sg,
+				  write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE, 0);
+	userptr->mapped = false;
+	mutex_unlock(&userptr->unmap_mutex);
 }
 
-/*
+/**
  * xe_hmm_userptr_free_sg() - Free the scatter gather table of userptr
- *
  * @uvma: the userptr vma which hold the scatter gather table
  *
  * With function xe_userptr_populate_range, we allocate storage of
@@ -124,16 +200,9 @@ static int xe_build_sg(struct xe_device *xe, struct hmm_range *range,
 void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma)
 {
 	struct xe_userptr *userptr = &uvma->userptr;
-	struct xe_vma *vma = &uvma->vma;
-	bool write = !xe_vma_read_only(vma);
-	struct xe_vm *vm = xe_vma_vm(vma);
-	struct xe_device *xe = vm->xe;
-	struct device *dev = xe->drm.dev;
-
-	xe_assert(xe, userptr->sg);
-	dma_unmap_sgtable(dev, userptr->sg,
-			  write ? DMA_BIDIRECTIONAL : DMA_TO_DEVICE, 0);
 
+	xe_assert(xe_vma_vm(&uvma->vma)->xe, userptr->sg);
+	xe_hmm_userptr_unmap(uvma);
 	sg_free_table(userptr->sg);
 	userptr->sg = NULL;
 }
@@ -166,13 +235,20 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 {
 	unsigned long timeout =
 		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
-	unsigned long *pfns, flags = HMM_PFN_REQ_FAULT;
+	unsigned long *pfns;
 	struct xe_userptr *userptr;
 	struct xe_vma *vma = &uvma->vma;
 	u64 userptr_start = xe_vma_userptr(vma);
 	u64 userptr_end = userptr_start + xe_vma_size(vma);
 	struct xe_vm *vm = xe_vma_vm(vma);
-	struct hmm_range hmm_range;
+	struct hmm_range hmm_range = {
+		.pfn_flags_mask = 0, /* ignore pfns */
+		.default_flags = HMM_PFN_REQ_FAULT,
+		.start = userptr_start,
+		.end = userptr_end,
+		.notifier = &uvma->userptr.notifier,
+		.dev_private_owner = vm->xe,
+	};
 	bool write = !xe_vma_read_only(vma);
 	unsigned long notifier_seq;
 	u64 npages;
@@ -199,19 +275,14 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 		return -ENOMEM;
 
 	if (write)
-		flags |= HMM_PFN_REQ_WRITE;
+		hmm_range.default_flags |= HMM_PFN_REQ_WRITE;
 
 	if (!mmget_not_zero(userptr->notifier.mm)) {
 		ret = -EFAULT;
 		goto free_pfns;
 	}
 
-	hmm_range.default_flags = flags;
 	hmm_range.hmm_pfns = pfns;
-	hmm_range.notifier = &userptr->notifier;
-	hmm_range.start = userptr_start;
-	hmm_range.end = userptr_end;
-	hmm_range.dev_private_owner = vm->xe;
 
 	while (true) {
 		hmm_range.notifier_seq = mmu_interval_read_begin(&userptr->notifier);
@@ -238,16 +309,37 @@ int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma,
 	if (ret)
 		goto free_pfns;
 
-	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt, write);
+	ret = xe_alloc_sg(vm->xe, &userptr->sgt, &hmm_range, &vm->userptr.notifier_lock);
 	if (ret)
 		goto free_pfns;
 
+	ret = down_read_interruptible(&vm->userptr.notifier_lock);
+	if (ret)
+		goto free_st;
+
+	if (mmu_interval_read_retry(hmm_range.notifier, hmm_range.notifier_seq)) {
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
+	ret = xe_build_sg(vm->xe, &hmm_range, &userptr->sgt,
+			  &vm->userptr.notifier_lock, write);
+	if (ret)
+		goto out_unlock;
+
 	xe_mark_range_accessed(&hmm_range, write);
 	userptr->sg = &userptr->sgt;
+	xe_hmm_userptr_set_mapped(uvma);
 	userptr->notifier_seq = hmm_range.notifier_seq;
+	up_read(&vm->userptr.notifier_lock);
+	kvfree(pfns);
+	return 0;
 
+out_unlock:
+	up_read(&vm->userptr.notifier_lock);
+free_st:
+	sg_free_table(&userptr->sgt);
 free_pfns:
 	kvfree(pfns);
 	return ret;
 }
-
diff --git a/drivers/gpu/drm/xe/xe_hmm.h b/drivers/gpu/drm/xe/xe_hmm.h
index 909dc2bdcd97..0ea98d8e7bbc 100644
--- a/drivers/gpu/drm/xe/xe_hmm.h
+++ b/drivers/gpu/drm/xe/xe_hmm.h
@@ -3,9 +3,16 @@
  * Copyright © 2024 Intel Corporation
  */
 
+#ifndef _XE_HMM_H_
+#define _XE_HMM_H_
+
 #include <linux/types.h>
 
 struct xe_userptr_vma;
 
 int xe_hmm_userptr_populate_range(struct xe_userptr_vma *uvma, bool is_mm_mmap_locked);
+
 void xe_hmm_userptr_free_sg(struct xe_userptr_vma *uvma);
+
+void xe_hmm_userptr_unmap(struct xe_userptr_vma *uvma);
+#endif
diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 797576690356..230cf47fb9c5 100644
--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -28,6 +28,8 @@ struct xe_pt_dir {
 	struct xe_pt pt;
 	/** @children: Array of page-table child nodes */
 	struct xe_ptw *children[XE_PDES];
+	/** @staging: Array of page-table staging nodes */
+	struct xe_ptw *staging[XE_PDES];
 };
 
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG_VM)
@@ -48,9 +50,10 @@ static struct xe_pt_dir *as_xe_pt_dir(struct xe_pt *pt)
 	return container_of(pt, struct xe_pt_dir, pt);
 }
 
-static struct xe_pt *xe_pt_entry(struct xe_pt_dir *pt_dir, unsigned int index)
+static struct xe_pt *
+xe_pt_entry_staging(struct xe_pt_dir *pt_dir, unsigned int index)
 {
-	return container_of(pt_dir->children[index], struct xe_pt, base);
+	return container_of(pt_dir->staging[index], struct xe_pt, base);
 }
 
 static u64 __xe_pt_empty_pte(struct xe_tile *tile, struct xe_vm *vm,
@@ -125,6 +128,7 @@ struct xe_pt *xe_pt_create(struct xe_vm *vm, struct xe_tile *tile,
 	}
 	pt->bo = bo;
 	pt->base.children = level ? as_xe_pt_dir(pt)->children : NULL;
+	pt->base.staging = level ? as_xe_pt_dir(pt)->staging : NULL;
 
 	if (vm->xef)
 		xe_drm_client_add_bo(vm->xef->client, pt->bo);
@@ -205,8 +209,8 @@ void xe_pt_destroy(struct xe_pt *pt, u32 flags, struct llist_head *deferred)
 		struct xe_pt_dir *pt_dir = as_xe_pt_dir(pt);
 
 		for (i = 0; i < XE_PDES; i++) {
-			if (xe_pt_entry(pt_dir, i))
-				xe_pt_destroy(xe_pt_entry(pt_dir, i), flags,
+			if (xe_pt_entry_staging(pt_dir, i))
+				xe_pt_destroy(xe_pt_entry_staging(pt_dir, i), flags,
 					      deferred);
 		}
 	}
@@ -375,8 +379,10 @@ xe_pt_insert_entry(struct xe_pt_stage_bind_walk *xe_walk, struct xe_pt *parent,
 		/* Continue building a non-connected subtree. */
 		struct iosys_map *map = &parent->bo->vmap;
 
-		if (unlikely(xe_child))
+		if (unlikely(xe_child)) {
 			parent->base.children[offset] = &xe_child->base;
+			parent->base.staging[offset] = &xe_child->base;
+		}
 
 		xe_pt_write(xe_walk->vm->xe, map, offset, pte);
 		parent->num_live++;
@@ -613,6 +619,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 			.ops = &xe_pt_stage_bind_ops,
 			.shifts = xe_normal_pt_shifts,
 			.max_level = XE_PT_HIGHEST_LEVEL,
+			.staging = true,
 		},
 		.vm = xe_vma_vm(vma),
 		.tile = tile,
@@ -872,7 +879,7 @@ static void xe_pt_cancel_bind(struct xe_vma *vma,
 	}
 }
 
-static void xe_pt_commit_locks_assert(struct xe_vma *vma)
+static void xe_pt_commit_prepare_locks_assert(struct xe_vma *vma)
 {
 	struct xe_vm *vm = xe_vma_vm(vma);
 
@@ -884,6 +891,16 @@ static void xe_pt_commit_locks_assert(struct xe_vma *vma)
 	xe_vm_assert_held(vm);
 }
 
+static void xe_pt_commit_locks_assert(struct xe_vma *vma)
+{
+	struct xe_vm *vm = xe_vma_vm(vma);
+
+	xe_pt_commit_prepare_locks_assert(vma);
+
+	if (xe_vma_is_userptr(vma))
+		lockdep_assert_held_read(&vm->userptr.notifier_lock);
+}
+
 static void xe_pt_commit(struct xe_vma *vma,
 			 struct xe_vm_pgtable_update *entries,
 			 u32 num_entries, struct llist_head *deferred)
@@ -894,13 +911,17 @@ static void xe_pt_commit(struct xe_vma *vma,
 
 	for (i = 0; i < num_entries; i++) {
 		struct xe_pt *pt = entries[i].pt;
+		struct xe_pt_dir *pt_dir;
 
 		if (!pt->level)
 			continue;
 
+		pt_dir = as_xe_pt_dir(pt);
 		for (j = 0; j < entries[i].qwords; j++) {
 			struct xe_pt *oldpte = entries[i].pt_entries[j].pt;
+			int j_ = j + entries[i].ofs;
 
+			pt_dir->children[j_] = pt_dir->staging[j_];
 			xe_pt_destroy(oldpte, xe_vma_vm(vma)->flags, deferred);
 		}
 	}
@@ -912,7 +933,7 @@ static void xe_pt_abort_bind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = num_entries - 1; i >= 0; --i) {
 		struct xe_pt *pt = entries[i].pt;
@@ -927,10 +948,10 @@ static void xe_pt_abort_bind(struct xe_vma *vma,
 		pt_dir = as_xe_pt_dir(pt);
 		for (j = 0; j < entries[i].qwords; j++) {
 			u32 j_ = j + entries[i].ofs;
-			struct xe_pt *newpte = xe_pt_entry(pt_dir, j_);
+			struct xe_pt *newpte = xe_pt_entry_staging(pt_dir, j_);
 			struct xe_pt *oldpte = entries[i].pt_entries[j].pt;
 
-			pt_dir->children[j_] = oldpte ? &oldpte->base : 0;
+			pt_dir->staging[j_] = oldpte ? &oldpte->base : 0;
 			xe_pt_destroy(newpte, xe_vma_vm(vma)->flags, NULL);
 		}
 	}
@@ -942,7 +963,7 @@ static void xe_pt_commit_prepare_bind(struct xe_vma *vma,
 {
 	u32 i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = 0; i < num_entries; i++) {
 		struct xe_pt *pt = entries[i].pt;
@@ -960,10 +981,10 @@ static void xe_pt_commit_prepare_bind(struct xe_vma *vma,
 			struct xe_pt *newpte = entries[i].pt_entries[j].pt;
 			struct xe_pt *oldpte = NULL;
 
-			if (xe_pt_entry(pt_dir, j_))
-				oldpte = xe_pt_entry(pt_dir, j_);
+			if (xe_pt_entry_staging(pt_dir, j_))
+				oldpte = xe_pt_entry_staging(pt_dir, j_);
 
-			pt_dir->children[j_] = &newpte->base;
+			pt_dir->staging[j_] = &newpte->base;
 			entries[i].pt_entries[j].pt = oldpte;
 		}
 	}
@@ -1212,42 +1233,22 @@ static int vma_check_userptr(struct xe_vm *vm, struct xe_vma *vma,
 		return 0;
 
 	uvma = to_userptr_vma(vma);
-	notifier_seq = uvma->userptr.notifier_seq;
+	if (xe_pt_userptr_inject_eagain(uvma))
+		xe_vma_userptr_force_invalidate(uvma);
 
-	if (uvma->userptr.initial_bind && !xe_vm_in_fault_mode(vm))
-		return 0;
+	notifier_seq = uvma->userptr.notifier_seq;
 
 	if (!mmu_interval_read_retry(&uvma->userptr.notifier,
-				     notifier_seq) &&
-	    !xe_pt_userptr_inject_eagain(uvma))
+				     notifier_seq))
 		return 0;
 
-	if (xe_vm_in_fault_mode(vm)) {
+	if (xe_vm_in_fault_mode(vm))
 		return -EAGAIN;
-	} else {
-		spin_lock(&vm->userptr.invalidated_lock);
-		list_move_tail(&uvma->userptr.invalidate_link,
-			       &vm->userptr.invalidated);
-		spin_unlock(&vm->userptr.invalidated_lock);
-
-		if (xe_vm_in_preempt_fence_mode(vm)) {
-			struct dma_resv_iter cursor;
-			struct dma_fence *fence;
-			long err;
-
-			dma_resv_iter_begin(&cursor, xe_vm_resv(vm),
-					    DMA_RESV_USAGE_BOOKKEEP);
-			dma_resv_for_each_fence_unlocked(&cursor, fence)
-				dma_fence_enable_sw_signaling(fence);
-			dma_resv_iter_end(&cursor);
-
-			err = dma_resv_wait_timeout(xe_vm_resv(vm),
-						    DMA_RESV_USAGE_BOOKKEEP,
-						    false, MAX_SCHEDULE_TIMEOUT);
-			XE_WARN_ON(err <= 0);
-		}
-	}
 
+	/*
+	 * Just continue the operation since exec or rebind worker
+	 * will take care of rebinding.
+	 */
 	return 0;
 }
 
@@ -1513,6 +1514,7 @@ static unsigned int xe_pt_stage_unbind(struct xe_tile *tile, struct xe_vma *vma,
 			.ops = &xe_pt_stage_unbind_ops,
 			.shifts = xe_normal_pt_shifts,
 			.max_level = XE_PT_HIGHEST_LEVEL,
+			.staging = true,
 		},
 		.tile = tile,
 		.modified_start = xe_vma_start(vma),
@@ -1554,7 +1556,7 @@ static void xe_pt_abort_unbind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = num_entries - 1; i >= 0; --i) {
 		struct xe_vm_pgtable_update *entry = &entries[i];
@@ -1567,7 +1569,7 @@ static void xe_pt_abort_unbind(struct xe_vma *vma,
 			continue;
 
 		for (j = entry->ofs; j < entry->ofs + entry->qwords; j++)
-			pt_dir->children[j] =
+			pt_dir->staging[j] =
 				entries[i].pt_entries[j - entry->ofs].pt ?
 				&entries[i].pt_entries[j - entry->ofs].pt->base : NULL;
 	}
@@ -1580,7 +1582,7 @@ xe_pt_commit_prepare_unbind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = 0; i < num_entries; ++i) {
 		struct xe_vm_pgtable_update *entry = &entries[i];
@@ -1594,8 +1596,8 @@ xe_pt_commit_prepare_unbind(struct xe_vma *vma,
 		pt_dir = as_xe_pt_dir(pt);
 		for (j = entry->ofs; j < entry->ofs + entry->qwords; j++) {
 			entry->pt_entries[j - entry->ofs].pt =
-				xe_pt_entry(pt_dir, j);
-			pt_dir->children[j] = NULL;
+				xe_pt_entry_staging(pt_dir, j);
+			pt_dir->staging[j] = NULL;
 		}
 	}
 }
diff --git a/drivers/gpu/drm/xe/xe_pt_walk.c b/drivers/gpu/drm/xe/xe_pt_walk.c
index b8b3d2aea492..be602a763ff3 100644
--- a/drivers/gpu/drm/xe/xe_pt_walk.c
+++ b/drivers/gpu/drm/xe/xe_pt_walk.c
@@ -74,7 +74,8 @@ int xe_pt_walk_range(struct xe_ptw *parent, unsigned int level,
 		     u64 addr, u64 end, struct xe_pt_walk *walk)
 {
 	pgoff_t offset = xe_pt_offset(addr, level, walk);
-	struct xe_ptw **entries = parent->children ? parent->children : NULL;
+	struct xe_ptw **entries = walk->staging ? (parent->staging ?: NULL) :
+		(parent->children ?: NULL);
 	const struct xe_pt_walk_ops *ops = walk->ops;
 	enum page_walk_action action;
 	struct xe_ptw *child;
diff --git a/drivers/gpu/drm/xe/xe_pt_walk.h b/drivers/gpu/drm/xe/xe_pt_walk.h
index 5ecc4d2f0f65..5c02c244f7de 100644
--- a/drivers/gpu/drm/xe/xe_pt_walk.h
+++ b/drivers/gpu/drm/xe/xe_pt_walk.h
@@ -11,12 +11,14 @@
 /**
  * struct xe_ptw - base class for driver pagetable subclassing.
  * @children: Pointer to an array of children if any.
+ * @staging: Pointer to an array of staging if any.
  *
  * Drivers could subclass this, and if it's a page-directory, typically
  * embed an array of xe_ptw pointers.
  */
 struct xe_ptw {
 	struct xe_ptw **children;
+	struct xe_ptw **staging;
 };
 
 /**
@@ -41,6 +43,8 @@ struct xe_pt_walk {
 	 * as shared pagetables.
 	 */
 	bool shared_pt_mode;
+	/** @staging: Walk staging PT structure */
+	bool staging;
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index 5693b337f5df..872de052d670 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -580,51 +580,26 @@ static void preempt_rebind_work_func(struct work_struct *w)
 	trace_xe_vm_rebind_worker_exit(vm);
 }
 
-static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
-				   const struct mmu_notifier_range *range,
-				   unsigned long cur_seq)
+static void __vma_userptr_invalidate(struct xe_vm *vm, struct xe_userptr_vma *uvma)
 {
-	struct xe_userptr *userptr = container_of(mni, typeof(*userptr), notifier);
-	struct xe_userptr_vma *uvma = container_of(userptr, typeof(*uvma), userptr);
+	struct xe_userptr *userptr = &uvma->userptr;
 	struct xe_vma *vma = &uvma->vma;
-	struct xe_vm *vm = xe_vma_vm(vma);
 	struct dma_resv_iter cursor;
 	struct dma_fence *fence;
 	long err;
 
-	xe_assert(vm->xe, xe_vma_is_userptr(vma));
-	trace_xe_vma_userptr_invalidate(vma);
-
-	if (!mmu_notifier_range_blockable(range))
-		return false;
-
-	vm_dbg(&xe_vma_vm(vma)->xe->drm,
-	       "NOTIFIER: addr=0x%016llx, range=0x%016llx",
-		xe_vma_start(vma), xe_vma_size(vma));
-
-	down_write(&vm->userptr.notifier_lock);
-	mmu_interval_set_seq(mni, cur_seq);
-
-	/* No need to stop gpu access if the userptr is not yet bound. */
-	if (!userptr->initial_bind) {
-		up_write(&vm->userptr.notifier_lock);
-		return true;
-	}
-
 	/*
 	 * Tell exec and rebind worker they need to repin and rebind this
 	 * userptr.
 	 */
 	if (!xe_vm_in_fault_mode(vm) &&
-	    !(vma->gpuva.flags & XE_VMA_DESTROYED) && vma->tile_present) {
+	    !(vma->gpuva.flags & XE_VMA_DESTROYED)) {
 		spin_lock(&vm->userptr.invalidated_lock);
 		list_move_tail(&userptr->invalidate_link,
 			       &vm->userptr.invalidated);
 		spin_unlock(&vm->userptr.invalidated_lock);
 	}
 
-	up_write(&vm->userptr.notifier_lock);
-
 	/*
 	 * Preempt fences turn into schedule disables, pipeline these.
 	 * Note that even in fault mode, we need to wait for binds and
@@ -642,11 +617,37 @@ static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
 				    false, MAX_SCHEDULE_TIMEOUT);
 	XE_WARN_ON(err <= 0);
 
-	if (xe_vm_in_fault_mode(vm)) {
+	if (xe_vm_in_fault_mode(vm) && userptr->initial_bind) {
 		err = xe_vm_invalidate_vma(vma);
 		XE_WARN_ON(err);
 	}
 
+	xe_hmm_userptr_unmap(uvma);
+}
+
+static bool vma_userptr_invalidate(struct mmu_interval_notifier *mni,
+				   const struct mmu_notifier_range *range,
+				   unsigned long cur_seq)
+{
+	struct xe_userptr_vma *uvma = container_of(mni, typeof(*uvma), userptr.notifier);
+	struct xe_vma *vma = &uvma->vma;
+	struct xe_vm *vm = xe_vma_vm(vma);
+
+	xe_assert(vm->xe, xe_vma_is_userptr(vma));
+	trace_xe_vma_userptr_invalidate(vma);
+
+	if (!mmu_notifier_range_blockable(range))
+		return false;
+
+	vm_dbg(&xe_vma_vm(vma)->xe->drm,
+	       "NOTIFIER: addr=0x%016llx, range=0x%016llx",
+		xe_vma_start(vma), xe_vma_size(vma));
+
+	down_write(&vm->userptr.notifier_lock);
+	mmu_interval_set_seq(mni, cur_seq);
+
+	__vma_userptr_invalidate(vm, uvma);
+	up_write(&vm->userptr.notifier_lock);
 	trace_xe_vma_userptr_invalidate_complete(vma);
 
 	return true;
@@ -656,6 +657,34 @@ static const struct mmu_interval_notifier_ops vma_userptr_notifier_ops = {
 	.invalidate = vma_userptr_invalidate,
 };
 
+#if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
+/**
+ * xe_vma_userptr_force_invalidate() - force invalidate a userptr
+ * @uvma: The userptr vma to invalidate
+ *
+ * Perform a forced userptr invalidation for testing purposes.
+ */
+void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
+{
+	struct xe_vm *vm = xe_vma_vm(&uvma->vma);
+
+	/* Protect against concurrent userptr pinning */
+	lockdep_assert_held(&vm->lock);
+	/* Protect against concurrent notifiers */
+	lockdep_assert_held(&vm->userptr.notifier_lock);
+	/*
+	 * Protect against concurrent instances of this function and
+	 * the critical exec sections
+	 */
+	xe_vm_assert_held(vm);
+
+	if (!mmu_interval_read_retry(&uvma->userptr.notifier,
+				     uvma->userptr.notifier_seq))
+		uvma->userptr.notifier_seq -= 2;
+	__vma_userptr_invalidate(vm, uvma);
+}
+#endif
+
 int xe_vm_userptr_pin(struct xe_vm *vm)
 {
 	struct xe_userptr_vma *uvma, *next;
@@ -1012,6 +1041,7 @@ static struct xe_vma *xe_vma_create(struct xe_vm *vm,
 			INIT_LIST_HEAD(&userptr->invalidate_link);
 			INIT_LIST_HEAD(&userptr->repin_link);
 			vma->gpuva.gem.offset = bo_offset_or_userptr;
+			mutex_init(&userptr->unmap_mutex);
 
 			err = mmu_interval_notifier_insert(&userptr->notifier,
 							   current->mm,
@@ -1053,6 +1083,7 @@ static void xe_vma_destroy_late(struct xe_vma *vma)
 		 * them anymore
 		 */
 		mmu_interval_notifier_remove(&userptr->notifier);
+		mutex_destroy(&userptr->unmap_mutex);
 		xe_vm_put(vm);
 	} else if (xe_vma_is_null(vma)) {
 		xe_vm_put(vm);
@@ -2284,8 +2315,17 @@ static int vm_bind_ioctl_ops_parse(struct xe_vm *vm, struct drm_gpuva_ops *ops,
 			break;
 		}
 		case DRM_GPUVA_OP_UNMAP:
+			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
+			break;
 		case DRM_GPUVA_OP_PREFETCH:
-			/* FIXME: Need to skip some prefetch ops */
+			vma = gpuva_to_vma(op->base.prefetch.va);
+
+			if (xe_vma_is_userptr(vma)) {
+				err = xe_vma_userptr_pin_pages(to_userptr_vma(vma));
+				if (err)
+					return err;
+			}
+
 			xe_vma_ops_incr_pt_update_ops(vops, op->tile_mask);
 			break;
 		default:
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index c864dba35e1d..d2406532fcc5 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -275,9 +275,17 @@ static inline void vm_dbg(const struct drm_device *dev,
 			  const char *format, ...)
 { /* noop */ }
 #endif
-#endif
 
 struct xe_vm_snapshot *xe_vm_snapshot_capture(struct xe_vm *vm);
 void xe_vm_snapshot_capture_delayed(struct xe_vm_snapshot *snap);
 void xe_vm_snapshot_print(struct xe_vm_snapshot *snap, struct drm_printer *p);
 void xe_vm_snapshot_free(struct xe_vm_snapshot *snap);
+
+#if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
+void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma);
+#else
+static inline void xe_vma_userptr_force_invalidate(struct xe_userptr_vma *uvma)
+{
+}
+#endif
+#endif
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index 7f9a303e51d8..a4b4091cfd0d 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -59,12 +59,16 @@ struct xe_userptr {
 	struct sg_table *sg;
 	/** @notifier_seq: notifier sequence number */
 	unsigned long notifier_seq;
+	/** @unmap_mutex: Mutex protecting dma-unmapping */
+	struct mutex unmap_mutex;
 	/**
 	 * @initial_bind: user pointer has been bound at least once.
 	 * write: vm->userptr.notifier_lock in read mode and vm->resv held.
 	 * read: vm->userptr.notifier_lock in write mode or vm->resv held.
 	 */
 	bool initial_bind;
+	/** @mapped: Whether the @sgt sg-table is dma-mapped. Protected by @unmap_mutex. */
+	bool mapped;
 #if IS_ENABLED(CONFIG_DRM_XE_USERPTR_INVAL_INJECT)
 	u32 divisor;
 #endif
@@ -227,8 +231,8 @@ struct xe_vm {
 		 * up for revalidation. Protected from access with the
 		 * @invalidated_lock. Removing items from the list
 		 * additionally requires @lock in write mode, and adding
-		 * items to the list requires the @userptr.notifer_lock in
-		 * write mode.
+		 * items to the list requires either the @userptr.notifer_lock in
+		 * write mode, OR @lock in write mode.
 		 */
 		struct list_head invalidated;
 	} userptr;
diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
index 8deded185725..c45e5aa569d2 100644
--- a/drivers/hid/hid-appleir.c
+++ b/drivers/hid/hid-appleir.c
@@ -188,7 +188,7 @@ static int appleir_raw_event(struct hid_device *hid, struct hid_report *report,
 	static const u8 flatbattery[] = { 0x25, 0x87, 0xe0 };
 	unsigned long flags;
 
-	if (len != 5)
+	if (len != 5 || !(hid->claimed & HID_CLAIMED_INPUT))
 		goto out;
 
 	if (!memcmp(data, keydown, sizeof(keydown))) {
diff --git a/drivers/hid/hid-corsair-void.c b/drivers/hid/hid-corsair-void.c
index 56e858066c3c..afbd67aa9719 100644
--- a/drivers/hid/hid-corsair-void.c
+++ b/drivers/hid/hid-corsair-void.c
@@ -71,11 +71,9 @@
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
-#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/power_supply.h>
 #include <linux/usb.h>
 #include <linux/workqueue.h>
@@ -120,6 +118,12 @@ enum {
 	CORSAIR_VOID_BATTERY_CHARGING	= 5,
 };
 
+enum {
+	CORSAIR_VOID_ADD_BATTERY	= 0,
+	CORSAIR_VOID_REMOVE_BATTERY	= 1,
+	CORSAIR_VOID_UPDATE_BATTERY	= 2,
+};
+
 static enum power_supply_property corsair_void_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
@@ -155,12 +159,12 @@ struct corsair_void_drvdata {
 
 	struct power_supply *battery;
 	struct power_supply_desc battery_desc;
-	struct mutex battery_mutex;
 
 	struct delayed_work delayed_status_work;
 	struct delayed_work delayed_firmware_work;
-	struct work_struct battery_remove_work;
-	struct work_struct battery_add_work;
+
+	unsigned long battery_work_flags;
+	struct work_struct battery_work;
 };
 
 /*
@@ -260,11 +264,9 @@ static void corsair_void_process_receiver(struct corsair_void_drvdata *drvdata,
 
 	/* Inform power supply if battery values changed */
 	if (memcmp(&orig_battery_data, battery_data, sizeof(*battery_data))) {
-		scoped_guard(mutex, &drvdata->battery_mutex) {
-			if (drvdata->battery) {
-				power_supply_changed(drvdata->battery);
-			}
-		}
+		set_bit(CORSAIR_VOID_UPDATE_BATTERY,
+			&drvdata->battery_work_flags);
+		schedule_work(&drvdata->battery_work);
 	}
 }
 
@@ -536,29 +538,11 @@ static void corsair_void_firmware_work_handler(struct work_struct *work)
 
 }
 
-static void corsair_void_battery_remove_work_handler(struct work_struct *work)
-{
-	struct corsair_void_drvdata *drvdata;
-
-	drvdata = container_of(work, struct corsair_void_drvdata,
-			       battery_remove_work);
-	scoped_guard(mutex, &drvdata->battery_mutex) {
-		if (drvdata->battery) {
-			power_supply_unregister(drvdata->battery);
-			drvdata->battery = NULL;
-		}
-	}
-}
-
-static void corsair_void_battery_add_work_handler(struct work_struct *work)
+static void corsair_void_add_battery(struct corsair_void_drvdata *drvdata)
 {
-	struct corsair_void_drvdata *drvdata;
 	struct power_supply_config psy_cfg = {};
 	struct power_supply *new_supply;
 
-	drvdata = container_of(work, struct corsair_void_drvdata,
-			       battery_add_work);
-	guard(mutex)(&drvdata->battery_mutex);
 	if (drvdata->battery)
 		return;
 
@@ -583,16 +567,42 @@ static void corsair_void_battery_add_work_handler(struct work_struct *work)
 	drvdata->battery = new_supply;
 }
 
+static void corsair_void_battery_work_handler(struct work_struct *work)
+{
+	struct corsair_void_drvdata *drvdata = container_of(work,
+		struct corsair_void_drvdata, battery_work);
+
+	bool add_battery = test_and_clear_bit(CORSAIR_VOID_ADD_BATTERY,
+					      &drvdata->battery_work_flags);
+	bool remove_battery = test_and_clear_bit(CORSAIR_VOID_REMOVE_BATTERY,
+						 &drvdata->battery_work_flags);
+	bool update_battery = test_and_clear_bit(CORSAIR_VOID_UPDATE_BATTERY,
+						 &drvdata->battery_work_flags);
+
+	if (add_battery && !remove_battery) {
+		corsair_void_add_battery(drvdata);
+	} else if (remove_battery && !add_battery && drvdata->battery) {
+		power_supply_unregister(drvdata->battery);
+		drvdata->battery = NULL;
+	}
+
+	if (update_battery && drvdata->battery)
+		power_supply_changed(drvdata->battery);
+
+}
+
 static void corsair_void_headset_connected(struct corsair_void_drvdata *drvdata)
 {
-	schedule_work(&drvdata->battery_add_work);
+	set_bit(CORSAIR_VOID_ADD_BATTERY, &drvdata->battery_work_flags);
+	schedule_work(&drvdata->battery_work);
 	schedule_delayed_work(&drvdata->delayed_firmware_work,
 			      msecs_to_jiffies(100));
 }
 
 static void corsair_void_headset_disconnected(struct corsair_void_drvdata *drvdata)
 {
-	schedule_work(&drvdata->battery_remove_work);
+	set_bit(CORSAIR_VOID_REMOVE_BATTERY, &drvdata->battery_work_flags);
+	schedule_work(&drvdata->battery_work);
 
 	corsair_void_set_unknown_wireless_data(drvdata);
 	corsair_void_set_unknown_batt(drvdata);
@@ -678,13 +688,7 @@ static int corsair_void_probe(struct hid_device *hid_dev,
 	drvdata->battery_desc.get_property = corsair_void_battery_get_property;
 
 	drvdata->battery = NULL;
-	INIT_WORK(&drvdata->battery_remove_work,
-		  corsair_void_battery_remove_work_handler);
-	INIT_WORK(&drvdata->battery_add_work,
-		  corsair_void_battery_add_work_handler);
-	ret = devm_mutex_init(drvdata->dev, &drvdata->battery_mutex);
-	if (ret)
-		return ret;
+	INIT_WORK(&drvdata->battery_work, corsair_void_battery_work_handler);
 
 	ret = sysfs_create_group(&hid_dev->dev.kobj, &corsair_void_attr_group);
 	if (ret)
@@ -721,8 +725,7 @@ static void corsair_void_remove(struct hid_device *hid_dev)
 	struct corsair_void_drvdata *drvdata = hid_get_drvdata(hid_dev);
 
 	hid_hw_stop(hid_dev);
-	cancel_work_sync(&drvdata->battery_remove_work);
-	cancel_work_sync(&drvdata->battery_add_work);
+	cancel_work_sync(&drvdata->battery_work);
 	if (drvdata->battery)
 		power_supply_unregister(drvdata->battery);
 
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 0f292b5d3e26..eb6fd2dc75d0 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -268,11 +268,13 @@ static void cbas_ec_remove(struct platform_device *pdev)
 	mutex_unlock(&cbas_ec_reglock);
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id cbas_ec_acpi_ids[] = {
 	{ "GOOG000B", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cbas_ec_acpi_ids);
+#endif
 
 #ifdef CONFIG_OF
 static const struct of_device_id cbas_ec_of_match[] = {
diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 5f8518f6f5ac..03e57d8acdad 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -1327,11 +1327,11 @@ static void steam_remove(struct hid_device *hdev)
 		return;
 	}
 
+	hid_destroy_device(steam->client_hdev);
 	cancel_delayed_work_sync(&steam->mode_switch);
 	cancel_work_sync(&steam->work_connect);
 	cancel_work_sync(&steam->rumble_work);
 	cancel_work_sync(&steam->unregister_work);
-	hid_destroy_device(steam->client_hdev);
 	steam->client_hdev = NULL;
 	steam->client_opened = 0;
 	if (steam->quirks & STEAM_QUIRK_WIRELESS) {
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index cb04cd1d980b..6550ad5bfbb5 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -832,9 +832,9 @@ static void hid_ishtp_cl_remove(struct ishtp_cl_device *cl_device)
 			hid_ishtp_cl);
 
 	dev_dbg(ishtp_device(cl_device), "%s\n", __func__);
-	hid_ishtp_cl_deinit(hid_ishtp_cl);
 	ishtp_put_device(cl_device);
 	ishtp_hid_remove(client_data);
+	hid_ishtp_cl_deinit(hid_ishtp_cl);
 
 	hid_ishtp_cl = NULL;
 
diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 00c6f0ebf356..be2c62fc8251 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -261,12 +261,14 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
  */
 void ishtp_hid_remove(struct ishtp_cl_data *client_data)
 {
+	void *data;
 	int i;
 
 	for (i = 0; i < client_data->num_hid_devices; ++i) {
 		if (client_data->hid_sensor_hubs[i]) {
-			kfree(client_data->hid_sensor_hubs[i]->driver_data);
+			data = client_data->hid_sensor_hubs[i]->driver_data;
 			hid_destroy_device(client_data->hid_sensor_hubs[i]);
+			kfree(data);
 			client_data->hid_sensor_hubs[i] = NULL;
 		}
 	}
diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index 7802bbf5f958..59424103f634 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -22,11 +22,13 @@
  */
 #define AD7314_TEMP_MASK		0x7FE0
 #define AD7314_TEMP_SHIFT		5
+#define AD7314_LEADING_ZEROS_MASK	BIT(15)
 
 /*
  * ADT7301 and ADT7302 temperature masks
  */
 #define ADT7301_TEMP_MASK		0x3FFF
+#define ADT7301_LEADING_ZEROS_MASK	(BIT(15) | BIT(14))
 
 enum ad7314_variant {
 	adt7301,
@@ -65,12 +67,20 @@ static ssize_t ad7314_temperature_show(struct device *dev,
 		return ret;
 	switch (spi_get_device_id(chip->spi_dev)->driver_data) {
 	case ad7314:
+		if (ret & AD7314_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		data = (ret & AD7314_TEMP_MASK) >> AD7314_TEMP_SHIFT;
 		data = sign_extend32(data, 9);
 
 		return sprintf(buf, "%d\n", 250 * data);
 	case adt7301:
 	case adt7302:
+		if (ret & ADT7301_LEADING_ZEROS_MASK) {
+			/* Invalid read-out, leading zero part is missing */
+			return -EIO;
+		}
 		/*
 		 * Documented as a 13 bit twos complement register
 		 * with a sign bit - which is a 14 bit 2's complement
diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index b5352900463f..0d29c8f97ba7 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -181,40 +181,40 @@ static const struct ntc_compensation ncpXXwf104[] = {
 };
 
 static const struct ntc_compensation ncpXXxh103[] = {
-	{ .temp_c	= -40, .ohm	= 247565 },
-	{ .temp_c	= -35, .ohm	= 181742 },
-	{ .temp_c	= -30, .ohm	= 135128 },
-	{ .temp_c	= -25, .ohm	= 101678 },
-	{ .temp_c	= -20, .ohm	= 77373 },
-	{ .temp_c	= -15, .ohm	= 59504 },
-	{ .temp_c	= -10, .ohm	= 46222 },
-	{ .temp_c	= -5, .ohm	= 36244 },
-	{ .temp_c	= 0, .ohm	= 28674 },
-	{ .temp_c	= 5, .ohm	= 22878 },
-	{ .temp_c	= 10, .ohm	= 18399 },
-	{ .temp_c	= 15, .ohm	= 14910 },
-	{ .temp_c	= 20, .ohm	= 12169 },
+	{ .temp_c	= -40, .ohm	= 195652 },
+	{ .temp_c	= -35, .ohm	= 148171 },
+	{ .temp_c	= -30, .ohm	= 113347 },
+	{ .temp_c	= -25, .ohm	= 87559 },
+	{ .temp_c	= -20, .ohm	= 68237 },
+	{ .temp_c	= -15, .ohm	= 53650 },
+	{ .temp_c	= -10, .ohm	= 42506 },
+	{ .temp_c	= -5, .ohm	= 33892 },
+	{ .temp_c	= 0, .ohm	= 27219 },
+	{ .temp_c	= 5, .ohm	= 22021 },
+	{ .temp_c	= 10, .ohm	= 17926 },
+	{ .temp_c	= 15, .ohm	= 14674 },
+	{ .temp_c	= 20, .ohm	= 12081 },
 	{ .temp_c	= 25, .ohm	= 10000 },
-	{ .temp_c	= 30, .ohm	= 8271 },
-	{ .temp_c	= 35, .ohm	= 6883 },
-	{ .temp_c	= 40, .ohm	= 5762 },
-	{ .temp_c	= 45, .ohm	= 4851 },
-	{ .temp_c	= 50, .ohm	= 4105 },
-	{ .temp_c	= 55, .ohm	= 3492 },
-	{ .temp_c	= 60, .ohm	= 2985 },
-	{ .temp_c	= 65, .ohm	= 2563 },
-	{ .temp_c	= 70, .ohm	= 2211 },
-	{ .temp_c	= 75, .ohm	= 1915 },
-	{ .temp_c	= 80, .ohm	= 1666 },
-	{ .temp_c	= 85, .ohm	= 1454 },
-	{ .temp_c	= 90, .ohm	= 1275 },
-	{ .temp_c	= 95, .ohm	= 1121 },
-	{ .temp_c	= 100, .ohm	= 990 },
-	{ .temp_c	= 105, .ohm	= 876 },
-	{ .temp_c	= 110, .ohm	= 779 },
-	{ .temp_c	= 115, .ohm	= 694 },
-	{ .temp_c	= 120, .ohm	= 620 },
-	{ .temp_c	= 125, .ohm	= 556 },
+	{ .temp_c	= 30, .ohm	= 8315 },
+	{ .temp_c	= 35, .ohm	= 6948 },
+	{ .temp_c	= 40, .ohm	= 5834 },
+	{ .temp_c	= 45, .ohm	= 4917 },
+	{ .temp_c	= 50, .ohm	= 4161 },
+	{ .temp_c	= 55, .ohm	= 3535 },
+	{ .temp_c	= 60, .ohm	= 3014 },
+	{ .temp_c	= 65, .ohm	= 2586 },
+	{ .temp_c	= 70, .ohm	= 2228 },
+	{ .temp_c	= 75, .ohm	= 1925 },
+	{ .temp_c	= 80, .ohm	= 1669 },
+	{ .temp_c	= 85, .ohm	= 1452 },
+	{ .temp_c	= 90, .ohm	= 1268 },
+	{ .temp_c	= 95, .ohm	= 1110 },
+	{ .temp_c	= 100, .ohm	= 974 },
+	{ .temp_c	= 105, .ohm	= 858 },
+	{ .temp_c	= 110, .ohm	= 758 },
+	{ .temp_c	= 115, .ohm	= 672 },
+	{ .temp_c	= 120, .ohm	= 596 },
+	{ .temp_c	= 125, .ohm	= 531 },
 };
 
 /*
diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
index d6762259dd69..fbe82d9852e0 100644
--- a/drivers/hwmon/peci/dimmtemp.c
+++ b/drivers/hwmon/peci/dimmtemp.c
@@ -127,8 +127,6 @@ static int update_thresholds(struct peci_dimmtemp *priv, int dimm_no)
 		return 0;
 
 	ret = priv->gen_info->read_thresholds(priv, dimm_order, chan_rank, &data);
-	if (ret == -ENODATA) /* Use default or previous value */
-		return 0;
 	if (ret)
 		return ret;
 
@@ -509,11 +507,11 @@ read_thresholds_icx(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 13, 0, 2, 0xd4, &reg_val);
 	if (ret || !(reg_val & BIT(31)))
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 13, 0, 2, 0xd0, &reg_val);
 	if (ret)
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	/*
 	 * Device 26, Offset 224e0: IMC 0 channel 0 -> rank 0
@@ -546,11 +544,11 @@ read_thresholds_spr(struct peci_dimmtemp *priv, int dimm_order, int chan_rank, u
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd4, &reg_val);
 	if (ret || !(reg_val & BIT(31)))
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	ret = peci_ep_pci_local_read(priv->peci_dev, 0, 30, 0, 2, 0xd0, &reg_val);
 	if (ret)
-		return -ENODATA; /* Use default or previous value */
+		return -ENODATA;
 
 	/*
 	 * Device 26, Offset 219a8: IMC 0 channel 0 -> rank 0
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index 77cf268e7d2d..920cd5408141 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -103,6 +103,8 @@ static int pmbus_identify(struct i2c_client *client,
 		if (pmbus_check_byte_register(client, 0, PMBUS_PAGE)) {
 			int page;
 
+			info->pages = PMBUS_PAGES;
+
 			for (page = 1; page < PMBUS_PAGES; page++) {
 				if (pmbus_set_page(client, page, 0xff) < 0)
 					break;
diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 1e3bd129a922..7087197383c9 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -706,7 +706,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (!ctx->pcc_comm_addr) {
+		if (IS_ERR_OR_NULL(ctx->pcc_comm_addr)) {
 			dev_err(&pdev->dev,
 				"Failed to ioremap PCC comm region\n");
 			rc = -ENOMEM;
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index e9d8d28e055f..e3def163d5cf 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -334,6 +334,21 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa824),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Arrow Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7724),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Panther Lake-H */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe324),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
+		/* Panther Lake-P/U */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xe424),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 1c87db0e0460..c4effe8429c8 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1082,7 +1082,7 @@ static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned lon
 
 	conf &= ~AD7192_CONF_CHAN_MASK;
 	for_each_set_bit(i, scan_mask, 8)
-		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, i);
+		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, BIT(i));
 
 	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
 	if (ret < 0)
diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index e35d55d03d86..b60be98f877d 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1039,7 +1039,7 @@ static int ad7606_read_avail(struct iio_dev *indio_dev,
 
 		cs = &st->chan_scales[ch];
 		*vals = (int *)cs->scale_avail;
-		*length = cs->num_scales;
+		*length = cs->num_scales * 2;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 
 		return IIO_AVAIL_LIST;
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 8e5aaf15a921..c3a1dea2aa82 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -329,7 +329,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 #define AT91_HWFIFO_MAX_SIZE_STR	"128"
 #define AT91_HWFIFO_MAX_SIZE		128
 
-#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+#define AT91_SAMA_CHAN_SINGLE(index, num, addr, rbits)			\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
@@ -337,7 +337,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 'u',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -350,7 +350,13 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.indexed = 1,						\
 	}
 
-#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+#define AT91_SAMA5D2_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_SINGLE(index, num, addr)			\
+	AT91_SAMA_CHAN_SINGLE(index, num, addr, 16)
+
+#define AT91_SAMA_CHAN_DIFF(index, num, num2, addr, rbits)		\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.differential = 1,					\
@@ -360,7 +366,7 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.scan_index = index,					\
 		.scan_type = {						\
 			.sign = 's',					\
-			.realbits = 14,					\
+			.realbits = rbits,				\
 			.storagebits = 16,				\
 		},							\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
@@ -373,6 +379,12 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
 		.indexed = 1,						\
 	}
 
+#define AT91_SAMA5D2_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 14)
+
+#define AT91_SAMA7G5_CHAN_DIFF(index, num, num2, addr)			\
+	AT91_SAMA_CHAN_DIFF(index, num, num2, addr, 16)
+
 #define AT91_SAMA5D2_CHAN_TOUCH(num, name, mod)				\
 	{								\
 		.type = IIO_POSITIONRELATIVE,				\
@@ -666,30 +678,30 @@ static const struct iio_chan_spec at91_sama5d2_adc_channels[] = {
 };
 
 static const struct iio_chan_spec at91_sama7g5_adc_channels[] = {
-	AT91_SAMA5D2_CHAN_SINGLE(0, 0, 0x60),
-	AT91_SAMA5D2_CHAN_SINGLE(1, 1, 0x64),
-	AT91_SAMA5D2_CHAN_SINGLE(2, 2, 0x68),
-	AT91_SAMA5D2_CHAN_SINGLE(3, 3, 0x6c),
-	AT91_SAMA5D2_CHAN_SINGLE(4, 4, 0x70),
-	AT91_SAMA5D2_CHAN_SINGLE(5, 5, 0x74),
-	AT91_SAMA5D2_CHAN_SINGLE(6, 6, 0x78),
-	AT91_SAMA5D2_CHAN_SINGLE(7, 7, 0x7c),
-	AT91_SAMA5D2_CHAN_SINGLE(8, 8, 0x80),
-	AT91_SAMA5D2_CHAN_SINGLE(9, 9, 0x84),
-	AT91_SAMA5D2_CHAN_SINGLE(10, 10, 0x88),
-	AT91_SAMA5D2_CHAN_SINGLE(11, 11, 0x8c),
-	AT91_SAMA5D2_CHAN_SINGLE(12, 12, 0x90),
-	AT91_SAMA5D2_CHAN_SINGLE(13, 13, 0x94),
-	AT91_SAMA5D2_CHAN_SINGLE(14, 14, 0x98),
-	AT91_SAMA5D2_CHAN_SINGLE(15, 15, 0x9c),
-	AT91_SAMA5D2_CHAN_DIFF(16, 0, 1, 0x60),
-	AT91_SAMA5D2_CHAN_DIFF(17, 2, 3, 0x68),
-	AT91_SAMA5D2_CHAN_DIFF(18, 4, 5, 0x70),
-	AT91_SAMA5D2_CHAN_DIFF(19, 6, 7, 0x78),
-	AT91_SAMA5D2_CHAN_DIFF(20, 8, 9, 0x80),
-	AT91_SAMA5D2_CHAN_DIFF(21, 10, 11, 0x88),
-	AT91_SAMA5D2_CHAN_DIFF(22, 12, 13, 0x90),
-	AT91_SAMA5D2_CHAN_DIFF(23, 14, 15, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(0, 0, 0x60),
+	AT91_SAMA7G5_CHAN_SINGLE(1, 1, 0x64),
+	AT91_SAMA7G5_CHAN_SINGLE(2, 2, 0x68),
+	AT91_SAMA7G5_CHAN_SINGLE(3, 3, 0x6c),
+	AT91_SAMA7G5_CHAN_SINGLE(4, 4, 0x70),
+	AT91_SAMA7G5_CHAN_SINGLE(5, 5, 0x74),
+	AT91_SAMA7G5_CHAN_SINGLE(6, 6, 0x78),
+	AT91_SAMA7G5_CHAN_SINGLE(7, 7, 0x7c),
+	AT91_SAMA7G5_CHAN_SINGLE(8, 8, 0x80),
+	AT91_SAMA7G5_CHAN_SINGLE(9, 9, 0x84),
+	AT91_SAMA7G5_CHAN_SINGLE(10, 10, 0x88),
+	AT91_SAMA7G5_CHAN_SINGLE(11, 11, 0x8c),
+	AT91_SAMA7G5_CHAN_SINGLE(12, 12, 0x90),
+	AT91_SAMA7G5_CHAN_SINGLE(13, 13, 0x94),
+	AT91_SAMA7G5_CHAN_SINGLE(14, 14, 0x98),
+	AT91_SAMA7G5_CHAN_SINGLE(15, 15, 0x9c),
+	AT91_SAMA7G5_CHAN_DIFF(16, 0, 1, 0x60),
+	AT91_SAMA7G5_CHAN_DIFF(17, 2, 3, 0x68),
+	AT91_SAMA7G5_CHAN_DIFF(18, 4, 5, 0x70),
+	AT91_SAMA7G5_CHAN_DIFF(19, 6, 7, 0x78),
+	AT91_SAMA7G5_CHAN_DIFF(20, 8, 9, 0x80),
+	AT91_SAMA7G5_CHAN_DIFF(21, 10, 11, 0x88),
+	AT91_SAMA7G5_CHAN_DIFF(22, 12, 13, 0x90),
+	AT91_SAMA7G5_CHAN_DIFF(23, 14, 15, 0x98),
 	IIO_CHAN_SOFT_TIMESTAMP(24),
 	AT91_SAMA5D2_CHAN_TEMP(AT91_SAMA7G5_ADC_TEMP_CHANNEL, "temp", 0xdc),
 };
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index e7206af53af6..7944f5c1d264 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -410,6 +410,12 @@ static int ad3552r_reset(struct ad3552r_desc *dac)
 		return ret;
 	}
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = ad3552r_write_reg(dac, AD3552R_REG_ADDR_ERR_STATUS,
+				AD3552R_MASK_RESET_STATUS);
+	if (ret)
+		return ret;
+
 	return ad3552r_update_reg_field(dac,
 					AD3552R_REG_ADDR_INTERFACE_CONFIG_A,
 					AD3552R_MASK_ADDR_ASCENSION,
diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 848baa6e3bbf..d85b7d3de866 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -574,21 +574,15 @@ static int admv8818_init(struct admv8818_state *st)
 	struct spi_device *spi = st->spi;
 	unsigned int chip_id;
 
-	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SOFTRESET_N_MSK |
-				 ADMV8818_SOFTRESET_MSK,
-				 FIELD_PREP(ADMV8818_SOFTRESET_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SOFTRESET_MSK, 1));
+	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SOFTRESET_N_MSK | ADMV8818_SOFTRESET_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 Soft Reset failed.\n");
 		return ret;
 	}
 
-	ret = regmap_update_bits(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
-				 ADMV8818_SDOACTIVE_N_MSK |
-				 ADMV8818_SDOACTIVE_MSK,
-				 FIELD_PREP(ADMV8818_SDOACTIVE_N_MSK, 1) |
-				 FIELD_PREP(ADMV8818_SDOACTIVE_MSK, 1));
+	ret = regmap_write(st->regmap, ADMV8818_REG_SPI_CONFIG_A,
+			   ADMV8818_SDOACTIVE_N_MSK | ADMV8818_SDOACTIVE_MSK);
 	if (ret) {
 		dev_err(&spi->dev, "ADMV8818 SDO Enable failed.\n");
 		return ret;
diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 69a0d609cffc..5ed7e17f49e7 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -108,11 +108,11 @@ static const struct part_id_gts_multiplier apds9306_gts_mul[] = {
 	{
 		.part_id = 0xB1,
 		.max_scale_int = 16,
-		.max_scale_nano = 3264320,
+		.max_scale_nano = 326432000,
 	}, {
 		.part_id = 0xB3,
 		.max_scale_int = 14,
-		.max_scale_nano = 9712000,
+		.max_scale_nano = 97120000,
 	},
 };
 
diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index c83acbd78275..71dcef3fbe57 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -49,9 +49,10 @@ static const u32 prox_sensitivity_addresses[] = {
 #define PROX_CHANNEL(_is_proximity, _channel) \
 	{\
 		.type = _is_proximity ? IIO_PROXIMITY : IIO_ATTENTION,\
-		.info_mask_separate = _is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
-				      BIT(IIO_CHAN_INFO_PROCESSED),\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |\
+		.info_mask_separate = \
+		(_is_proximity ? BIT(IIO_CHAN_INFO_RAW) :\
+				BIT(IIO_CHAN_INFO_PROCESSED)) |\
+		BIT(IIO_CHAN_INFO_OFFSET) |\
 		BIT(IIO_CHAN_INFO_SCALE) |\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |\
 		BIT(IIO_CHAN_INFO_HYSTERESIS),\
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index e0174da5e9fc..77b0490a1b38 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -286,7 +286,6 @@ static int rtsx_usb_get_status_with_bulk(struct rtsx_ucr *ucr, u16 *status)
 int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 {
 	int ret;
-	u8 interrupt_val = 0;
 	u16 *buf;
 
 	if (!status)
@@ -309,20 +308,6 @@ int rtsx_usb_get_card_status(struct rtsx_ucr *ucr, u16 *status)
 		ret = rtsx_usb_get_status_with_bulk(ucr, status);
 	}
 
-	rtsx_usb_read_register(ucr, CARD_INT_PEND, &interrupt_val);
-	/* Cross check presence with interrupts */
-	if (*status & XD_CD)
-		if (!(interrupt_val & XD_INT))
-			*status &= ~XD_CD;
-
-	if (*status & SD_CD)
-		if (!(interrupt_val & SD_INT))
-			*status &= ~SD_CD;
-
-	if (*status & MS_CD)
-		if (!(interrupt_val & MS_INT))
-			*status &= ~MS_CD;
-
 	/* usb_control_msg may return positive when success */
 	if (ret < 0)
 		return ret;
diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index 88888485e6f8..ee58f7ce5bfa 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -50,7 +50,7 @@ static struct platform_device digsy_mtc_eeprom = {
 };
 
 static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
-	.dev_id         = "spi_gpio",
+	.dev_id         = "spi_gpio.1",
 	.table          = {
 		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CLK,
 			    "sck", GPIO_ACTIVE_HIGH),
diff --git a/drivers/misc/mei/hw-me-regs.h b/drivers/misc/mei/hw-me-regs.h
index c3a6657dcd4a..a5f88ec97df7 100644
--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -117,6 +117,8 @@
 
 #define MEI_DEV_ID_LNL_M      0xA870  /* Lunar Lake Point M */
 
+#define MEI_DEV_ID_PTL_P      0xE470  /* Panther Lake P */
+
 /*
  * MEI HW Section
  */
diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 6589635f8ba3..d6ff9d82ae94 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -124,6 +124,8 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_LNL_M, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_PTL_P, MEI_ME_PCH15_CFG)},
+
 	/* required last entry */
 	{0, }
 };
diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index 35d349fee769..7be1649b1972 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -502,7 +502,7 @@ static int vsc_tp_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphost", GPIOD_IN);
+	tp->wakeuphost = devm_gpiod_get(dev, "wakeuphostint", GPIOD_IN);
 	if (IS_ERR(tp->wakeuphost))
 		return PTR_ERR(tp->wakeuphost);
 
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 7fea00c7ca8a..c60386bf2d1a 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -745,7 +745,7 @@ static int cfv_probe(struct virtio_device *vdev)
 
 	if (cfv->vr_rx)
 		vdev->vringh_config->del_vrhs(cfv->vdev);
-	if (cfv->vdev)
+	if (cfv->vq_tx)
 		vdev->config->del_vqs(cfv->vdev);
 	free_netdev(netdev);
 	return err;
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 086b8b3d5b40..b05e38d19b21 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2591,7 +2591,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 	if (ret < 0)
 		return ret;
 
-	return 0;
+	/* Setup VLAN ID 0 for VLAN-unaware bridges */
+	return mt7530_setup_vlan0(priv);
 }
 
 static int
@@ -2687,11 +2688,6 @@ mt7531_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
-	/* Setup VLAN ID 0 for VLAN-unaware bridges */
-	ret = mt7530_setup_vlan0(priv);
-	if (ret)
-		return ret;
-
 	ds->assisted_learning_on_cpu_port = true;
 	ds->mtu_enforcement_ingress = true;
 
diff --git a/drivers/net/ethernet/emulex/benet/be.h b/drivers/net/ethernet/emulex/benet/be.h
index e48b861e4ce1..270ff9aab335 100644
--- a/drivers/net/ethernet/emulex/benet/be.h
+++ b/drivers/net/ethernet/emulex/benet/be.h
@@ -562,7 +562,7 @@ struct be_adapter {
 	struct be_dma_mem mbox_mem_alloced;
 
 	struct be_mcc_obj mcc_obj;
-	struct mutex mcc_lock;	/* For serializing mcc cmds to BE card */
+	spinlock_t mcc_lock;	/* For serializing mcc cmds to BE card */
 	spinlock_t mcc_cq_lock;
 
 	u16 cfg_num_rx_irqs;		/* configured via set-channels */
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 61adcebeef01..51b8377edd1d 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -575,7 +575,7 @@ int be_process_mcc(struct be_adapter *adapter)
 /* Wait till no more pending mcc requests are present */
 static int be_mcc_wait_compl(struct be_adapter *adapter)
 {
-#define mcc_timeout		12000 /* 12s timeout */
+#define mcc_timeout		120000 /* 12s timeout */
 	int i, status = 0;
 	struct be_mcc_obj *mcc_obj = &adapter->mcc_obj;
 
@@ -589,7 +589,7 @@ static int be_mcc_wait_compl(struct be_adapter *adapter)
 
 		if (atomic_read(&mcc_obj->q.used) == 0)
 			break;
-		usleep_range(500, 1000);
+		udelay(100);
 	}
 	if (i == mcc_timeout) {
 		dev_err(&adapter->pdev->dev, "FW not responding\n");
@@ -866,7 +866,7 @@ static bool use_mcc(struct be_adapter *adapter)
 static int be_cmd_lock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter)) {
-		mutex_lock(&adapter->mcc_lock);
+		spin_lock_bh(&adapter->mcc_lock);
 		return 0;
 	} else {
 		return mutex_lock_interruptible(&adapter->mbox_lock);
@@ -877,7 +877,7 @@ static int be_cmd_lock(struct be_adapter *adapter)
 static void be_cmd_unlock(struct be_adapter *adapter)
 {
 	if (use_mcc(adapter))
-		return mutex_unlock(&adapter->mcc_lock);
+		return spin_unlock_bh(&adapter->mcc_lock);
 	else
 		return mutex_unlock(&adapter->mbox_lock);
 }
@@ -1047,7 +1047,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 	struct be_cmd_req_mac_query *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1076,7 +1076,7 @@ int be_cmd_mac_addr_query(struct be_adapter *adapter, u8 *mac_addr,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1088,7 +1088,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, const u8 *mac_addr,
 	struct be_cmd_req_pmac_add *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1113,7 +1113,7 @@ int be_cmd_pmac_add(struct be_adapter *adapter, const u8 *mac_addr,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (base_status(status) == MCC_STATUS_UNAUTHORIZED_REQUEST)
 		status = -EPERM;
@@ -1131,7 +1131,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id, u32 dom)
 	if (pmac_id == -1)
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1151,7 +1151,7 @@ int be_cmd_pmac_del(struct be_adapter *adapter, u32 if_id, int pmac_id, u32 dom)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1414,7 +1414,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
 	struct be_dma_mem *q_mem = &rxq->dma_mem;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1444,7 +1444,7 @@ int be_cmd_rxq_create(struct be_adapter *adapter,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1508,7 +1508,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 	struct be_cmd_req_q_destroy *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1525,7 +1525,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 	q->created = false;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1593,7 +1593,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	struct be_cmd_req_hdr *hdr;
 	int status = 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1621,7 +1621,7 @@ int be_cmd_get_stats(struct be_adapter *adapter, struct be_dma_mem *nonemb_cmd)
 	adapter->stats_cmd_sent = true;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1637,7 +1637,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 			    CMD_SUBSYSTEM_ETH))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1660,7 +1660,7 @@ int lancer_cmd_get_pport_stats(struct be_adapter *adapter,
 	adapter->stats_cmd_sent = true;
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1697,7 +1697,7 @@ int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 	struct be_cmd_req_link_status *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	if (link_status)
 		*link_status = LINK_DOWN;
@@ -1736,7 +1736,7 @@ int be_cmd_link_status_query(struct be_adapter *adapter, u16 *link_speed,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1747,7 +1747,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 	struct be_cmd_req_get_cntl_addnl_attribs *req;
 	int status = 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1762,7 +1762,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 
 	status = be_mcc_notify(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1811,7 +1811,7 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter, u32 buf_len, void *buf)
 	if (!get_fat_cmd.va)
 		return -ENOMEM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	while (total_size) {
 		buf_size = min(total_size, (u32)60 * 1024);
@@ -1849,9 +1849,9 @@ int be_cmd_get_fat_dump(struct be_adapter *adapter, u32 buf_len, void *buf)
 		log_offset += buf_size;
 	}
 err:
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, get_fat_cmd.size,
 			  get_fat_cmd.va, get_fat_cmd.dma);
-	mutex_unlock(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1862,7 +1862,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
 	struct be_cmd_req_get_fw_version *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1885,7 +1885,7 @@ int be_cmd_get_fw_ver(struct be_adapter *adapter)
 			sizeof(adapter->fw_on_flash));
 	}
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1899,7 +1899,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *adapter,
 	struct be_cmd_req_modify_eq_delay *req;
 	int status = 0, i;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1922,7 +1922,7 @@ static int __be_cmd_modify_eqd(struct be_adapter *adapter,
 
 	status = be_mcc_notify(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1949,7 +1949,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 	struct be_cmd_req_vlan_config *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -1971,7 +1971,7 @@ int be_cmd_vlan_config(struct be_adapter *adapter, u32 if_id, u16 *vtag_array,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -1982,7 +1982,7 @@ static int __be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 	struct be_cmd_req_rx_filter *req = mem->va;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2015,7 +2015,7 @@ static int __be_cmd_rx_filter(struct be_adapter *adapter, u32 flags, u32 value)
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2046,7 +2046,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2066,7 +2066,7 @@ int be_cmd_set_flow_control(struct be_adapter *adapter, u32 tx_fc, u32 rx_fc)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (base_status(status) == MCC_STATUS_FEATURE_NOT_SUPPORTED)
 		return  -EOPNOTSUPP;
@@ -2085,7 +2085,7 @@ int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2108,7 +2108,7 @@ int be_cmd_get_flow_control(struct be_adapter *adapter, u32 *tx_fc, u32 *rx_fc)
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2189,7 +2189,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u8 *rsstable,
 	if (!(be_if_cap_flags(adapter) & BE_IF_FLAGS_RSS))
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2214,7 +2214,7 @@ int be_cmd_rss_config(struct be_adapter *adapter, u8 *rsstable,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2226,7 +2226,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num,
 	struct be_cmd_req_enable_disable_beacon *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2247,7 +2247,7 @@ int be_cmd_set_beacon_state(struct be_adapter *adapter, u8 port_num,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2258,7 +2258,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 	struct be_cmd_req_get_beacon_state *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2282,7 +2282,7 @@ int be_cmd_get_beacon_state(struct be_adapter *adapter, u8 port_num, u32 *state)
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2306,7 +2306,7 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 		return -ENOMEM;
 	}
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2328,7 +2328,7 @@ int be_cmd_read_port_transceiver_data(struct be_adapter *adapter,
 		memcpy(data, resp->page_data + off, len);
 	}
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 	return status;
 }
@@ -2345,7 +2345,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	void *ctxt = NULL;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 	adapter->flash_status = 0;
 
 	wrb = wrb_from_mccq(adapter);
@@ -2387,7 +2387,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(60000)))
@@ -2406,7 +2406,7 @@ static int lancer_cmd_write_object(struct be_adapter *adapter,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2460,7 +2460,7 @@ static int lancer_cmd_delete_object(struct be_adapter *adapter,
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2478,7 +2478,7 @@ static int lancer_cmd_delete_object(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2491,7 +2491,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 	struct lancer_cmd_resp_read_object *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2525,7 +2525,7 @@ int lancer_cmd_read_object(struct be_adapter *adapter, struct be_dma_mem *cmd,
 	}
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2537,7 +2537,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	struct be_cmd_write_flashrom *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 	adapter->flash_status = 0;
 
 	wrb = wrb_from_mccq(adapter);
@@ -2562,7 +2562,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(40000)))
@@ -2573,7 +2573,7 @@ static int be_cmd_write_flashrom(struct be_adapter *adapter,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -2584,7 +2584,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -2611,7 +2611,7 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 		memcpy(flashed_crc, req->crc, 4);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3217,7 +3217,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adapter, u8 *mac,
 	struct be_cmd_req_acpi_wol_magic_config *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3234,7 +3234,7 @@ int be_cmd_enable_magic_wol(struct be_adapter *adapter, u8 *mac,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3249,7 +3249,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3272,7 +3272,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 	if (status)
 		goto err_unlock;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	if (!wait_for_completion_timeout(&adapter->et_cmd_compl,
 					 msecs_to_jiffies(SET_LB_MODE_TIMEOUT)))
@@ -3281,7 +3281,7 @@ int be_cmd_set_loopback(struct be_adapter *adapter, u8 port_num,
 	return status;
 
 err_unlock:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3298,7 +3298,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3324,7 +3324,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 	if (status)
 		goto err;
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 
 	wait_for_completion(&adapter->et_cmd_compl);
 	resp = embedded_payload(wrb);
@@ -3332,7 +3332,7 @@ int be_cmd_loopback_test(struct be_adapter *adapter, u32 port_num,
 
 	return status;
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3348,7 +3348,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter, u64 pattern,
 			    CMD_SUBSYSTEM_LOWLEVEL))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3382,7 +3382,7 @@ int be_cmd_ddr_dma_test(struct be_adapter *adapter, u64 pattern,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3393,7 +3393,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adapter,
 	struct be_cmd_req_seeprom_read *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3409,7 +3409,7 @@ int be_cmd_get_seeprom_data(struct be_adapter *adapter,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3424,7 +3424,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3469,7 +3469,7 @@ int be_cmd_get_phy_info(struct be_adapter *adapter)
 	}
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3479,7 +3479,7 @@ static int be_cmd_set_qos(struct be_adapter *adapter, u32 bps, u32 domain)
 	struct be_cmd_req_set_qos *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3499,7 +3499,7 @@ static int be_cmd_set_qos(struct be_adapter *adapter, u32 bps, u32 domain)
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3611,7 +3611,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *adapter, u32 *privilege,
 	struct be_cmd_req_get_fn_privileges *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3643,7 +3643,7 @@ int be_cmd_get_fn_privileges(struct be_adapter *adapter, u32 *privilege,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3655,7 +3655,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *adapter, u32 privileges,
 	struct be_cmd_req_set_fn_privileges *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3675,7 +3675,7 @@ int be_cmd_set_fn_privileges(struct be_adapter *adapter, u32 privileges,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3707,7 +3707,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
 		return -ENOMEM;
 	}
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3771,7 +3771,7 @@ int be_cmd_get_mac_from_list(struct be_adapter *adapter, u8 *mac,
 	}
 
 out:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	dma_free_coherent(&adapter->pdev->dev, get_mac_list_cmd.size,
 			  get_mac_list_cmd.va, get_mac_list_cmd.dma);
 	return status;
@@ -3831,7 +3831,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 	if (!cmd.va)
 		return -ENOMEM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3853,7 +3853,7 @@ int be_cmd_set_mac_list(struct be_adapter *adapter, u8 *mac_array,
 
 err:
 	dma_free_coherent(&adapter->pdev->dev, cmd.size, cmd.va, cmd.dma);
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3889,7 +3889,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapter, u16 pvid,
 			    CMD_SUBSYSTEM_COMMON))
 		return -EPERM;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3930,7 +3930,7 @@ int be_cmd_set_hsw_config(struct be_adapter *adapter, u16 pvid,
 	status = be_mcc_notify_wait(adapter);
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -3944,7 +3944,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapter, u16 *pvid,
 	int status;
 	u16 vid;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -3991,7 +3991,7 @@ int be_cmd_get_hsw_config(struct be_adapter *adapter, u16 *pvid,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4190,7 +4190,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapter *adapter,
 	struct be_cmd_req_set_ext_fat_caps *req;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4206,7 +4206,7 @@ int be_cmd_set_ext_fat_capabilites(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4684,7 +4684,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter, u32 iface, u8 op)
 	if (iface == 0xFFFFFFFF)
 		return -1;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4701,7 +4701,7 @@ int be_cmd_manage_iface(struct be_adapter *adapter, u32 iface, u8 op)
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4735,7 +4735,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, struct be_vf_cfg *vf_cfg,
 	struct be_cmd_resp_get_iface_list *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4756,7 +4756,7 @@ int be_cmd_get_if_id(struct be_adapter *adapter, struct be_vf_cfg *vf_cfg,
 	}
 
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4850,7 +4850,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8 domain)
 	if (BEx_chip(adapter))
 		return 0;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4868,7 +4868,7 @@ int be_cmd_enable_vf(struct be_adapter *adapter, u8 domain)
 	req->enable = 1;
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -4941,7 +4941,7 @@ __be_cmd_set_logical_link_config(struct be_adapter *adapter,
 	u32 link_config = 0;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -4969,7 +4969,7 @@ __be_cmd_set_logical_link_config(struct be_adapter *adapter,
 
 	status = be_mcc_notify_wait(adapter);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -5000,8 +5000,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
 	struct be_mcc_wrb *wrb;
 	int status;
 
-	if (mutex_lock_interruptible(&adapter->mcc_lock))
-		return -1;
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -5039,7 +5038,7 @@ int be_cmd_set_features(struct be_adapter *adapter)
 		dev_info(&adapter->pdev->dev,
 			 "Adapter does not support HW error recovery\n");
 
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 
@@ -5053,7 +5052,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_payload,
 	struct be_cmd_resp_hdr *resp;
 	int status;
 
-	mutex_lock(&adapter->mcc_lock);
+	spin_lock_bh(&adapter->mcc_lock);
 
 	wrb = wrb_from_mccq(adapter);
 	if (!wrb) {
@@ -5076,7 +5075,7 @@ int be_roce_mcc_cmd(void *netdev_handle, void *wrb_payload,
 	memcpy(wrb_payload, resp, sizeof(*resp) + resp->response_length);
 	be_dws_le_to_cpu(wrb_payload, sizeof(*resp) + resp->response_length);
 err:
-	mutex_unlock(&adapter->mcc_lock);
+	spin_unlock_bh(&adapter->mcc_lock);
 	return status;
 }
 EXPORT_SYMBOL(be_roce_mcc_cmd);
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 875fe379eea2..3d2e21592119 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -5667,8 +5667,8 @@ static int be_drv_init(struct be_adapter *adapter)
 	}
 
 	mutex_init(&adapter->mbox_lock);
-	mutex_init(&adapter->mcc_lock);
 	mutex_init(&adapter->rx_filter_lock);
+	spin_lock_init(&adapter->mcc_lock);
 	spin_lock_init(&adapter->mcc_cq_lock);
 	init_completion(&adapter->et_cmd_compl);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index bab16c2191b2..181af419b878 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -483,7 +483,7 @@ int hclge_ptp_init(struct hclge_dev *hdev)
 
 		ret = hclge_ptp_get_cycle(hdev);
 		if (ret)
-			return ret;
+			goto out;
 	}
 
 	ret = hclge_ptp_int_en(hdev, true);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index f5acfb7d4ff6..ab7c2750c104 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -11,6 +11,8 @@
 #include "dwmac_dma.h"
 #include "dwmac1000.h"
 
+#define DRIVER_NAME "dwmac-loongson-pci"
+
 /* Normal Loongson Tx Summary */
 #define DMA_INTR_ENA_NIE_TX_LOONGSON	0x00040000
 /* Normal Loongson Rx Summary */
@@ -568,7 +570,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_len(pdev, i) == 0)
 			continue;
-		ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
 		if (ret)
 			goto err_disable_device;
 		break;
@@ -687,7 +689,7 @@ static const struct pci_device_id loongson_dwmac_id_table[] = {
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
 
 static struct pci_driver loongson_dwmac_driver = {
-	.name = "dwmac-loongson-pci",
+	.name = DRIVER_NAME,
 	.id_table = loongson_dwmac_id_table,
 	.probe = loongson_dwmac_probe,
 	.remove = loongson_dwmac_remove,
diff --git a/drivers/net/ipa/data/ipa_data-v4.7.c b/drivers/net/ipa/data/ipa_data-v4.7.c
index c8c23d9be961..41f212209993 100644
--- a/drivers/net/ipa/data/ipa_data-v4.7.c
+++ b/drivers/net/ipa/data/ipa_data-v4.7.c
@@ -28,20 +28,18 @@ enum ipa_resource_type {
 enum ipa_rsrc_group_id {
 	/* Source resource group identifiers */
 	IPA_RSRC_GROUP_SRC_UL_DL			= 0,
-	IPA_RSRC_GROUP_SRC_UC_RX_Q,
 	IPA_RSRC_GROUP_SRC_COUNT,	/* Last in set; not a source group */
 
 	/* Destination resource group identifiers */
-	IPA_RSRC_GROUP_DST_UL_DL_DPL			= 0,
-	IPA_RSRC_GROUP_DST_UNUSED_1,
+	IPA_RSRC_GROUP_DST_UL_DL			= 0,
 	IPA_RSRC_GROUP_DST_COUNT,	/* Last; not a destination group */
 };
 
 /* QSB configuration data for an SoC having IPA v4.7 */
 static const struct ipa_qsb_data ipa_qsb_data[] = {
 	[IPA_QSB_MASTER_DDR] = {
-		.max_writes		= 8,
-		.max_reads		= 0,	/* no limit (hardware max) */
+		.max_writes		= 12,
+		.max_reads		= 13,
 		.max_reads_beats	= 120,
 	},
 };
@@ -81,7 +79,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
 				.aggregation	= true,
 				.status_enable	= true,
 				.rx = {
@@ -106,6 +104,7 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 			.filter_support	= true,
 			.config = {
 				.resource_group	= IPA_RSRC_GROUP_SRC_UL_DL,
+				.checksum       = true,
 				.qmap		= true,
 				.status_enable	= true,
 				.tx = {
@@ -128,7 +127,8 @@ static const struct ipa_gsi_endpoint_data ipa_gsi_endpoint_data[] = {
 		},
 		.endpoint = {
 			.config = {
-				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL_DPL,
+				.resource_group	= IPA_RSRC_GROUP_DST_UL_DL,
+				.checksum       = true,
 				.qmap		= true,
 				.aggregation	= true,
 				.rx = {
@@ -197,12 +197,12 @@ static const struct ipa_resource ipa_resource_src[] = {
 /* Destination resource configuration data for an SoC having IPA v4.7 */
 static const struct ipa_resource ipa_resource_dst[] = {
 	[IPA_RESOURCE_TYPE_DST_DATA_SECTORS] = {
-		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
 			.min = 7,	.max = 7,
 		},
 	},
 	[IPA_RESOURCE_TYPE_DST_DPS_DMARS] = {
-		.limits[IPA_RSRC_GROUP_DST_UL_DL_DPL] = {
+		.limits[IPA_RSRC_GROUP_DST_UL_DL] = {
 			.min = 2,	.max = 2,
 		},
 	},
diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index d247fe483c58..c1e72253063b 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -507,6 +507,9 @@ static int mctp_i3c_header_create(struct sk_buff *skb, struct net_device *dev,
 {
 	struct mctp_i3c_internal_hdr *ihdr;
 
+	if (!daddr || !saddr)
+		return -EINVAL;
+
 	skb_push(skb, sizeof(struct mctp_i3c_internal_hdr));
 	skb_reset_mac_header(skb);
 	ihdr = (void *)skb_mac_header(skb);
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 0d20b534122b..ffd1da04d3ad 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -615,6 +615,49 @@ int phy_ethtool_get_stats(struct phy_device *phydev,
 }
 EXPORT_SYMBOL(phy_ethtool_get_stats);
 
+/**
+ * __phy_ethtool_get_phy_stats - Retrieve standardized PHY statistics
+ * @phydev: Pointer to the PHY device
+ * @phy_stats: Pointer to ethtool_eth_phy_stats structure
+ * @phydev_stats: Pointer to ethtool_phy_stats structure
+ *
+ * Fetches PHY statistics using a kernel-defined interface for consistent
+ * diagnostics. Unlike phy_ethtool_get_stats(), which allows custom stats,
+ * this function enforces a standardized format for better interoperability.
+ */
+void __phy_ethtool_get_phy_stats(struct phy_device *phydev,
+				 struct ethtool_eth_phy_stats *phy_stats,
+				 struct ethtool_phy_stats *phydev_stats)
+{
+	if (!phydev->drv || !phydev->drv->get_phy_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_phy_stats(phydev, phy_stats, phydev_stats);
+	mutex_unlock(&phydev->lock);
+}
+
+/**
+ * __phy_ethtool_get_link_ext_stats - Retrieve extended link statistics for a PHY
+ * @phydev: Pointer to the PHY device
+ * @link_stats: Pointer to the structure to store extended link statistics
+ *
+ * Populates the ethtool_link_ext_stats structure with link down event counts
+ * and additional driver-specific link statistics, if available.
+ */
+void __phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				      struct ethtool_link_ext_stats *link_stats)
+{
+	link_stats->link_down_events = READ_ONCE(phydev->link_down_events);
+
+	if (!phydev->drv || !phydev->drv->get_link_stats)
+		return;
+
+	mutex_lock(&phydev->lock);
+	phydev->drv->get_link_stats(phydev, link_stats);
+	mutex_unlock(&phydev->lock);
+}
+
 /**
  * phy_ethtool_get_plca_cfg - Get PLCA RS configuration
  * @phydev: the phy_device struct
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b26bb33cd1d4..5f1ad0c7fb53 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3773,6 +3773,8 @@ static const struct ethtool_phy_ops phy_ethtool_phy_ops = {
 static const struct phylib_stubs __phylib_stubs = {
 	.hwtstamp_get = __phy_hwtstamp_get,
 	.hwtstamp_set = __phy_hwtstamp_set,
+	.get_phy_stats = __phy_ethtool_get_phy_stats,
+	.get_link_ext_stats = __phy_ethtool_get_link_ext_stats,
 };
 
 static void phylib_register_stubs(void)
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..1420c4efa48e 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -72,6 +72,17 @@
 #define PPP_PROTO_LEN	2
 #define PPP_LCP_HDRLEN	4
 
+/* The filter instructions generated by libpcap are constructed
+ * assuming a four-byte PPP header on each packet, where the last
+ * 2 bytes are the protocol field defined in the RFC and the first
+ * byte of the first 2 bytes indicates the direction.
+ * The second byte is currently unused, but we still need to initialize
+ * it to prevent crafted BPF programs from reading them which would
+ * cause reading of uninitialized data.
+ */
+#define PPP_FILTER_OUTBOUND_TAG 0x0100
+#define PPP_FILTER_INBOUND_TAG  0x0000
+
 /*
  * An instance of /dev/ppp can be associated with either a ppp
  * interface unit or a ppp channel.  In both cases, file->private_data
@@ -1762,10 +1773,10 @@ ppp_send_frame(struct ppp *ppp, struct sk_buff *skb)
 
 	if (proto < 0x8000) {
 #ifdef CONFIG_PPP_FILTER
-		/* check if we should pass this packet */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
-		*(u8 *)skb_push(skb, 2) = 1;
+		/* check if the packet passes the pass and active filters.
+		 * See comment for PPP_FILTER_OUTBOUND_TAG above.
+		 */
+		*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_OUTBOUND_TAG);
 		if (ppp->pass_filter &&
 		    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 			if (ppp->debug & 1)
@@ -2482,14 +2493,13 @@ ppp_receive_nonmp_frame(struct ppp *ppp, struct sk_buff *skb)
 		/* network protocol frame - give it to the kernel */
 
 #ifdef CONFIG_PPP_FILTER
-		/* check if the packet passes the pass and active filters */
-		/* the filter instructions are constructed assuming
-		   a four-byte PPP header on each packet */
 		if (ppp->pass_filter || ppp->active_filter) {
 			if (skb_unclone(skb, GFP_ATOMIC))
 				goto err;
-
-			*(u8 *)skb_push(skb, 2) = 0;
+			/* Check if the packet passes the pass and active filters.
+			 * See comment for PPP_FILTER_INBOUND_TAG above.
+			 */
+			*(__be16 *)skb_push(skb, 2) = htons(PPP_FILTER_INBOUND_TAG);
 			if (ppp->pass_filter &&
 			    bpf_prog_run(ppp->pass_filter, skb) == 0) {
 				if (ppp->debug & 1)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 8e0c85a1240d..c7b261c8ec96 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -540,6 +540,9 @@ bool iwl_fwrt_read_err_table(struct iwl_trans *trans, u32 base, u32 *err_id)
 	} err_info = {};
 	int ret;
 
+	if (err_id)
+		*err_id = 0;
+
 	if (!base)
 		return false;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index c620911a1193..754e01688900 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1197,7 +1197,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 
 			if (tlv_len != sizeof(*fseq_ver))
 				goto invalid_tlv_len;
-			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %s\n",
+			IWL_INFO(drv, "TLV_FW_FSEQ_VERSION: %.32s\n",
 				 fseq_ver->version);
 			}
 			break;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 4d1daff1e070..5797d28b6a0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -3099,8 +3099,14 @@ static void iwl_mvm_d3_disconnect_iter(void *data, u8 *mac,
 		ieee80211_resume_disconnect(vif);
 }
 
-static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
-				   struct ieee80211_vif *vif)
+enum rt_status {
+	FW_ALIVE,
+	FW_NEEDS_RESET,
+	FW_ERROR,
+};
+
+static enum rt_status iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
+					      struct ieee80211_vif *vif)
 {
 	u32 err_id;
 
@@ -3108,29 +3114,35 @@ static bool iwl_mvm_check_rt_status(struct iwl_mvm *mvm,
 	if (iwl_fwrt_read_err_table(mvm->trans,
 				    mvm->trans->dbg.lmac_error_event_table[0],
 				    &err_id)) {
-		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN && vif) {
-			struct cfg80211_wowlan_wakeup wakeup = {
-				.rfkill_release = true,
-			};
-			ieee80211_report_wowlan_wakeup(vif, &wakeup,
-						       GFP_KERNEL);
+		if (err_id == RF_KILL_INDICATOR_FOR_WOWLAN) {
+			IWL_WARN(mvm, "Rfkill was toggled during suspend\n");
+			if (vif) {
+				struct cfg80211_wowlan_wakeup wakeup = {
+					.rfkill_release = true,
+				};
+
+				ieee80211_report_wowlan_wakeup(vif, &wakeup,
+							       GFP_KERNEL);
+			}
+
+			return FW_NEEDS_RESET;
 		}
-		return true;
+		return FW_ERROR;
 	}
 
 	/* check if we have lmac2 set and check for error */
 	if (iwl_fwrt_read_err_table(mvm->trans,
 				    mvm->trans->dbg.lmac_error_event_table[1],
 				    NULL))
-		return true;
+		return FW_ERROR;
 
 	/* check for umac error */
 	if (iwl_fwrt_read_err_table(mvm->trans,
 				    mvm->trans->dbg.umac_error_event_table,
 				    NULL))
-		return true;
+		return FW_ERROR;
 
-	return false;
+	return FW_ALIVE;
 }
 
 /*
@@ -3499,6 +3511,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	bool d0i3_first = fw_has_capa(&mvm->fw->ucode_capa,
 				      IWL_UCODE_TLV_CAPA_D0I3_END_FIRST);
 	bool resume_notif_based = iwl_mvm_d3_resume_notif_based(mvm);
+	enum rt_status rt_status;
 	bool keep = false;
 
 	mutex_lock(&mvm->mutex);
@@ -3522,13 +3535,19 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
-	if (iwl_mvm_check_rt_status(mvm, vif)) {
+	rt_status = iwl_mvm_check_rt_status(mvm, vif);
+	if (rt_status != FW_ALIVE) {
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
-		iwl_mvm_dump_nic_error_log(mvm);
-		iwl_dbg_tlv_time_point(&mvm->fwrt,
-				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
-		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
-					false, 0);
+		if (rt_status == FW_ERROR) {
+			IWL_ERR(mvm, "FW Error occurred during suspend. Restarting.\n");
+			iwl_mvm_dump_nic_error_log(mvm);
+			iwl_dbg_tlv_time_point(&mvm->fwrt,
+					       IWL_FW_INI_TIME_POINT_FW_ASSERT,
+					       NULL);
+			iwl_fw_dbg_collect_desc(&mvm->fwrt,
+						&iwl_dump_desc_assert,
+						false, 0);
+		}
 		ret = 1;
 		goto err;
 	}
@@ -3685,6 +3704,7 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 		.notif_expected =
 			IWL_D3_NOTIF_D3_END_NOTIF,
 	};
+	enum rt_status rt_status;
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -3694,15 +3714,20 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 	mvm->last_reset_or_resume_time_jiffies = jiffies;
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
-	if (iwl_mvm_check_rt_status(mvm, NULL)) {
-		IWL_ERR(mvm,
-			"iwl_mvm_check_rt_status failed, device is gone during suspend\n");
+	rt_status = iwl_mvm_check_rt_status(mvm, NULL);
+	if (rt_status != FW_ALIVE) {
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
-		iwl_mvm_dump_nic_error_log(mvm);
-		iwl_dbg_tlv_time_point(&mvm->fwrt,
-				       IWL_FW_INI_TIME_POINT_FW_ASSERT, NULL);
-		iwl_fw_dbg_collect_desc(&mvm->fwrt, &iwl_dump_desc_assert,
-					false, 0);
+		if (rt_status == FW_ERROR) {
+			IWL_ERR(mvm,
+				"iwl_mvm_check_rt_status failed, device is gone during suspend\n");
+			iwl_mvm_dump_nic_error_log(mvm);
+			iwl_dbg_tlv_time_point(&mvm->fwrt,
+					       IWL_FW_INI_TIME_POINT_FW_ASSERT,
+					       NULL);
+			iwl_fw_dbg_collect_desc(&mvm->fwrt,
+						&iwl_dump_desc_assert,
+						false, 0);
+		}
 		mvm->trans->state = IWL_TRANS_NO_FW;
 		ret = -ENODEV;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 91ca830a7b60..f4276fdee6be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1518,6 +1518,13 @@ static ssize_t iwl_dbgfs_fw_dbg_clear_write(struct iwl_mvm *mvm,
 	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_9000)
 		return -EOPNOTSUPP;
 
+	/*
+	 * If the firmware is not running, silently succeed since there is
+	 * no data to clear.
+	 */
+	if (!iwl_mvm_firmware_running(mvm))
+		return count;
+
 	mutex_lock(&mvm->mutex);
 	iwl_fw_dbg_clear_monitor_buf(&mvm->fwrt);
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 72fa7ac86516..17b8ccc27569 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -1030,6 +1030,8 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
 		mvmvif->time_event_data.link_id = -1;
+		/* set the bit so the ROC cleanup will actually clean up */
+		set_bit(IWL_MVM_STATUS_ROC_P2P_RUNNING, &mvm->status);
 		iwl_mvm_roc_finished(mvm);
 		ieee80211_remain_on_channel_expired(mvm->hw);
 	} else if (le32_to_cpu(notif->start)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 27a7e0b5b3d5..ebe9b25cc53a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2003-2015, 2018-2024 Intel Corporation
+ * Copyright (C) 2003-2015, 2018-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -643,7 +643,8 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
 				    unsigned int len);
 struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_cmd_meta *cmd_meta,
-				   u8 **hdr, unsigned int hdr_room);
+				   u8 **hdr, unsigned int hdr_room,
+				   unsigned int offset);
 
 void iwl_pcie_free_tso_pages(struct iwl_trans *trans, struct sk_buff *skb,
 			     struct iwl_cmd_meta *cmd_meta);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index b1846abb99b7..477a05cd1288 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020, 2023-2024 Intel Corporation
+ * Copyright (C) 2018-2020, 2023-2025 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -188,7 +188,8 @@ static int iwl_txq_gen2_build_amsdu(struct iwl_trans *trans,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr));
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room);
+	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room,
+				snap_ip_tcp_hdrlen + hdr_len);
 	if (!sgt)
 		return -ENOMEM;
 
@@ -347,6 +348,7 @@ iwl_tfh_tfd *iwl_txq_gen2_build_tx_amsdu(struct iwl_trans *trans,
 	return tfd;
 
 out_err:
+	iwl_pcie_free_tso_pages(trans, skb, out_meta);
 	iwl_txq_gen2_tfd_unmap(trans, out_meta, tfd);
 	return NULL;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 1ef14340953c..477f779d4bf7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2003-2014, 2018-2021, 2023-2024 Intel Corporation
+ * Copyright (C) 2003-2014, 2018-2021, 2023-2025 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1853,6 +1853,7 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
  * @cmd_meta: command meta to store the scatter list information for unmapping
  * @hdr: output argument for TSO headers
  * @hdr_room: requested length for TSO headers
+ * @offset: offset into the data from which mapping should start
  *
  * Allocate space for a scatter gather list and TSO headers and map the SKB
  * using the scatter gather list. The SKB is unmapped again when the page is
@@ -1862,9 +1863,12 @@ dma_addr_t iwl_pcie_get_sgt_tb_phys(struct sg_table *sgt, unsigned int offset,
  */
 struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 				   struct iwl_cmd_meta *cmd_meta,
-				   u8 **hdr, unsigned int hdr_room)
+				   u8 **hdr, unsigned int hdr_room,
+				   unsigned int offset)
 {
 	struct sg_table *sgt;
+	unsigned int n_segments = skb_shinfo(skb)->nr_frags + 1;
+	int orig_nents;
 
 	if (WARN_ON_ONCE(skb_has_frag_list(skb)))
 		return NULL;
@@ -1872,8 +1876,7 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 	*hdr = iwl_pcie_get_page_hdr(trans,
 				     hdr_room + __alignof__(struct sg_table) +
 				     sizeof(struct sg_table) +
-				     (skb_shinfo(skb)->nr_frags + 1) *
-				     sizeof(struct scatterlist),
+				     n_segments * sizeof(struct scatterlist),
 				     skb);
 	if (!*hdr)
 		return NULL;
@@ -1881,14 +1884,15 @@ struct sg_table *iwl_pcie_prep_tso(struct iwl_trans *trans, struct sk_buff *skb,
 	sgt = (void *)PTR_ALIGN(*hdr + hdr_room, __alignof__(struct sg_table));
 	sgt->sgl = (void *)(sgt + 1);
 
-	sg_init_table(sgt->sgl, skb_shinfo(skb)->nr_frags + 1);
+	sg_init_table(sgt->sgl, n_segments);
 
 	/* Only map the data, not the header (it is copied to the TSO page) */
-	sgt->orig_nents = skb_to_sgvec(skb, sgt->sgl, skb_headlen(skb),
-				       skb->data_len);
-	if (WARN_ON_ONCE(sgt->orig_nents <= 0))
+	orig_nents = skb_to_sgvec(skb, sgt->sgl, offset, skb->len - offset);
+	if (WARN_ON_ONCE(orig_nents <= 0))
 		return NULL;
 
+	sgt->orig_nents = orig_nents;
+
 	/* And map the entire SKB */
 	if (dma_map_sgtable(trans->dev, sgt, DMA_TO_DEVICE, 0) < 0)
 		return NULL;
@@ -1937,7 +1941,8 @@ static int iwl_fill_data_tbs_amsdu(struct iwl_trans *trans, struct sk_buff *skb,
 		(3 + snap_ip_tcp_hdrlen + sizeof(struct ethhdr)) + iv_len;
 
 	/* Our device supports 9 segments at most, it will fit in 1 page */
-	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room);
+	sgt = iwl_pcie_prep_tso(trans, skb, out_meta, &start_hdr, hdr_room,
+				snap_ip_tcp_hdrlen + hdr_len + iv_len);
 	if (!sgt)
 		return -ENOMEM;
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b1b46c2713e1..24e2c702da7a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -128,8 +128,10 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	if (!nvme_ctrl_sgl_supported(ctrl))
 		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
 	if (has_metadata) {
-		if (!supports_metadata)
-			return -EINVAL;
+		if (!supports_metadata) {
+			ret = -EINVAL;
+			goto out;
+		}
 		if (!nvme_ctrl_meta_sgl_supported(ctrl))
 			dev_warn_once(ctrl->device,
 				      "using unchecked metadata buffer\n");
@@ -139,8 +141,10 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		struct iov_iter iter;
 
 		/* fixedbufs is only for non-vectored io */
-		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC))
-			return -EINVAL;
+		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC)) {
+			ret = -EINVAL;
+			goto out;
+		}
 		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d7c193028e7c..65347fed4237 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -217,6 +217,19 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
 	return queue - queue->ctrl->queues;
 }
 
+static inline bool nvme_tcp_recv_pdu_supported(enum nvme_tcp_pdu_type type)
+{
+	switch (type) {
+	case nvme_tcp_c2h_term:
+	case nvme_tcp_c2h_data:
+	case nvme_tcp_r2t:
+	case nvme_tcp_rsp:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Check if the queue is TLS encrypted
  */
@@ -763,6 +776,40 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
+static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
+		struct nvme_tcp_term_pdu *pdu)
+{
+	u16 fes;
+	const char *msg;
+	u32 plen = le32_to_cpu(pdu->hdr.plen);
+
+	static const char * const msg_table[] = {
+		[NVME_TCP_FES_INVALID_PDU_HDR] = "Invalid PDU Header Field",
+		[NVME_TCP_FES_PDU_SEQ_ERR] = "PDU Sequence Error",
+		[NVME_TCP_FES_HDR_DIGEST_ERR] = "Header Digest Error",
+		[NVME_TCP_FES_DATA_OUT_OF_RANGE] = "Data Transfer Out Of Range",
+		[NVME_TCP_FES_DATA_LIMIT_EXCEEDED] = "Data Transfer Limit Exceeded",
+		[NVME_TCP_FES_UNSUPPORTED_PARAM] = "Unsupported Parameter",
+	};
+
+	if (plen < NVME_TCP_MIN_C2HTERM_PLEN ||
+	    plen > NVME_TCP_MAX_C2HTERM_PLEN) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Received a malformed C2HTermReq PDU (plen = %u)\n",
+			plen);
+		return;
+	}
+
+	fes = le16_to_cpu(pdu->fes);
+	if (fes && fes < ARRAY_SIZE(msg_table))
+		msg = msg_table[fes];
+	else
+		msg = "Unknown";
+
+	dev_err(queue->ctrl->ctrl.device,
+		"Received C2HTermReq (FES = %s)\n", msg);
+}
+
 static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		unsigned int *offset, size_t *len)
 {
@@ -784,6 +831,25 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		return 0;
 
 	hdr = queue->pdu;
+	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
+		if (!nvme_tcp_recv_pdu_supported(hdr->type))
+			goto unsupported_pdu;
+
+		dev_err(queue->ctrl->ctrl.device,
+			"pdu type %d has unexpected header length (%d)\n",
+			hdr->type, hdr->hlen);
+		return -EPROTO;
+	}
+
+	if (unlikely(hdr->type == nvme_tcp_c2h_term)) {
+		/*
+		 * C2HTermReq never includes Header or Data digests.
+		 * Skip the checks.
+		 */
+		nvme_tcp_handle_c2h_term(queue, (void *)queue->pdu);
+		return -EINVAL;
+	}
+
 	if (queue->hdr_digest) {
 		ret = nvme_tcp_verify_hdgst(queue, queue->pdu, hdr->hlen);
 		if (unlikely(ret))
@@ -807,10 +873,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 		nvme_tcp_init_recv_ctx(queue);
 		return nvme_tcp_handle_r2t(queue, (void *)queue->pdu);
 	default:
-		dev_err(queue->ctrl->ctrl.device,
-			"unsupported pdu type (%d)\n", hdr->type);
-		return -EINVAL;
+		goto unsupported_pdu;
 	}
+
+unsupported_pdu:
+	dev_err(queue->ctrl->ctrl.device,
+		"unsupported pdu type (%d)\n", hdr->type);
+	return -EINVAL;
 }
 
 static inline void nvme_tcp_end_request(struct request *rq, u16 status)
@@ -1452,11 +1521,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	msg.msg_flags = MSG_WAITALL;
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < sizeof(*icresp)) {
+	if (ret >= 0 && ret < sizeof(*icresp))
+		ret = -ECONNRESET;
+	if (ret < 0) {
 		pr_warn("queue %d: failed to receive icresp, error %d\n",
 			nvme_tcp_queue_id(queue), ret);
-		if (ret >= 0)
-			ret = -ECONNRESET;
 		goto free_icresp;
 	}
 	ret = -ENOTCONN;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7233549f7c8a..016a5c250546 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -607,7 +607,6 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		struct nvmet_host *host);
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
-bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_MIN_QUEUE_SIZE	16
 #define NVMET_MAX_QUEUE_SIZE	1024
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..4f9cac8a5abe 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -571,10 +571,16 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	enum nvmet_tcp_recv_state queue_state;
+	struct nvmet_tcp_cmd *queue_cmd;
 	struct nvme_sgl_desc *sgl;
 	u32 len;
 
-	if (unlikely(cmd == queue->cmd)) {
+	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
+	queue_state = smp_load_acquire(&queue->rcv_state);
+	queue_cmd = READ_ONCE(queue->cmd);
+
+	if (unlikely(cmd == queue_cmd)) {
 		sgl = &cmd->req.cmd->common.dptr.sgl;
 		len = le32_to_cpu(sgl->length);
 
@@ -583,7 +589,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		 * Avoid using helpers, this might happen before
 		 * nvmet_req_init is completed.
 		 */
-		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
+		if (queue_state == NVMET_TCP_RECV_PDU &&
 		    len && len <= cmd->req.port->inline_data_size &&
 		    nvme_is_write(cmd->req.cmd))
 			return;
@@ -847,8 +853,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
 {
 	queue->offset = 0;
 	queue->left = sizeof(struct nvme_tcp_hdr);
-	queue->cmd = NULL;
-	queue->rcv_state = NVMET_TCP_RECV_PDU;
+	WRITE_ONCE(queue->cmd, NULL);
+	/* Ensure rcv_state is visible only after queue->cmd is set */
+	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
 }
 
 static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index e2da88d7706a..f31fadad29cc 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -415,12 +415,12 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 
 	prop = of_get_flat_dt_prop(node, "alignment", &len);
 	if (prop) {
-		if (len != dt_root_size_cells * sizeof(__be32)) {
+		if (len != dt_root_addr_cells * sizeof(__be32)) {
 			pr_err("invalid alignment property in '%s' node.\n",
 				uname);
 			return -EINVAL;
 		}
-		align = dt_mem_next_cell(dt_root_size_cells, &prop);
+		align = dt_mem_next_cell(dt_root_addr_cells, &prop);
 	}
 
 	nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2cfb2ac3f465..84dcd7da7319 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9958,6 +9958,7 @@ static const struct tpacpi_quirk battery_quirk_table[] __initconst = {
 	 * Individual addressing is broken on models that expose the
 	 * primary battery as BAT1.
 	 */
+	TPACPI_Q_LNV('G', '8', true),       /* ThinkPad X131e */
 	TPACPI_Q_LNV('8', 'F', true),       /* Thinkpad X120e */
 	TPACPI_Q_LNV('J', '7', true),       /* B5400 */
 	TPACPI_Q_LNV('J', 'I', true),       /* Thinkpad 11e */
diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 27afbb9d544b..cbf531d0ba68 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1742,7 +1742,8 @@ static int rio_mport_add_riodev(struct mport_cdev_priv *priv,
 		err = rio_add_net(net);
 		if (err) {
 			rmcd_debug(RDEV, "failed to register net, err=%d", err);
-			kfree(net);
+			put_device(&net->dev);
+			mport->net = NULL;
 			goto cleanup;
 		}
 	}
diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index fdcf742b2adb..c12941f71e2c 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -871,7 +871,10 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
 		dev_set_name(&net->dev, "rnet_%d", net->id);
 		net->dev.parent = &mport->dev;
 		net->dev.release = rio_scan_release_dev;
-		rio_add_net(net);
+		if (rio_add_net(net)) {
+			put_device(&net->dev);
+			net = NULL;
+		}
 	}
 
 	return net;
diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
index 242570a5e565..455c1fd1490f 100644
--- a/drivers/slimbus/messaging.c
+++ b/drivers/slimbus/messaging.c
@@ -148,8 +148,9 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
 	}
 
 	ret = ctrl->xfer_msg(ctrl, txn);
-
-	if (!ret && need_tid && !txn->msg->comp) {
+	if (ret == -ETIMEDOUT) {
+		slim_free_txn_tid(ctrl, txn);
+	} else if (!ret && need_tid && !txn->msg->comp) {
 		unsigned long ms = txn->rl + HZ;
 
 		time_left = wait_for_completion_timeout(txn->comp,
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 0dd85d2635b9..47d06af33747 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -1131,7 +1131,10 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	struct cxacru_data *instance;
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 	struct usb_host_endpoint *cmd_ep = usb_dev->ep_in[CXACRU_EP_CMD];
-	struct usb_endpoint_descriptor *in, *out;
+	static const u8 ep_addrs[] = {
+		CXACRU_EP_CMD + USB_DIR_IN,
+		CXACRU_EP_CMD + USB_DIR_OUT,
+		0};
 	int ret;
 
 	/* instance init */
@@ -1179,13 +1182,11 @@ static int cxacru_bind(struct usbatm_data *usbatm_instance,
 	}
 
 	if (usb_endpoint_xfer_int(&cmd_ep->desc))
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						NULL, NULL, &in, &out);
+		ret = usb_check_int_endpoints(intf, ep_addrs);
 	else
-		ret = usb_find_common_endpoints(intf->cur_altsetting,
-						&in, &out, NULL, NULL);
+		ret = usb_check_bulk_endpoints(intf, ep_addrs);
 
-	if (ret) {
+	if (!ret) {
 		usb_err(usbatm_instance, "cxacru_bind: interface has incorrect endpoints\n");
 		ret = -ENODEV;
 		goto fail;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 906daf423cb0..145787c424e0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -6065,6 +6065,36 @@ void usb_hub_cleanup(void)
 	usb_deregister(&hub_driver);
 } /* usb_hub_cleanup() */
 
+/**
+ * hub_hc_release_resources - clear resources used by host controller
+ * @udev: pointer to device being released
+ *
+ * Context: task context, might sleep
+ *
+ * Function releases the host controller resources in correct order before
+ * making any operation on resuming usb device. The host controller resources
+ * allocated for devices in tree should be released starting from the last
+ * usb device in tree toward the root hub. This function is used only during
+ * resuming device when usb device require reinitialization – that is, when
+ * flag udev->reset_resume is set.
+ *
+ * This call is synchronous, and may not be used in an interrupt context.
+ */
+static void hub_hc_release_resources(struct usb_device *udev)
+{
+	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
+	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
+	int i;
+
+	/* Release up resources for all children before this device */
+	for (i = 0; i < udev->maxchild; i++)
+		if (hub->ports[i]->child)
+			hub_hc_release_resources(hub->ports[i]->child);
+
+	if (hcd->driver->reset_device)
+		hcd->driver->reset_device(hcd, udev);
+}
+
 /**
  * usb_reset_and_verify_device - perform a USB port reset to reinitialize a device
  * @udev: device to reset (not in SUSPENDED or NOTATTACHED state)
@@ -6129,6 +6159,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	bos = udev->bos;
 	udev->bos = NULL;
 
+	if (udev->reset_resume)
+		hub_hc_release_resources(udev);
+
 	mutex_lock(hcd->address0_mutex);
 
 	for (i = 0; i < PORT_INIT_TRIES; ++i) {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 027479179f09..6926bd639ec6 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -341,6 +341,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
 
+	/* Prolific Single-LUN Mass Storage Card Reader */
+	{ USB_DEVICE(0x067b, 0x2731), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_NO_LPM },
+
 	/* Saitek Cyborg Gold Joystick */
 	{ USB_DEVICE(0x06a3, 0x0006), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 0a631641a3b3..b751904f09f3 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -131,11 +131,24 @@ void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 	}
 }
 
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy)
 {
+	unsigned int hw_mode;
 	u32 reg;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+
+	 /*
+	  * For DRD controllers, GUSB3PIPECTL.SUSPENDENABLE and
+	  * GUSB2PHYCFG.SUSPHY should be cleared during mode switching,
+	  * and they can be set after core initialization.
+	  */
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD && !ignore_susphy) {
+		if (DWC3_GCTL_PRTCAP(reg) != mode)
+			dwc3_enable_susphy(dwc, false);
+	}
+
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
@@ -216,7 +229,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 
 	spin_lock_irqsave(&dwc->lock, flags);
 
-	dwc3_set_prtcap(dwc, desired_dr_role);
+	dwc3_set_prtcap(dwc, desired_dr_role, false);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -658,16 +671,7 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
 	 */
 	reg &= ~DWC3_GUSB3PIPECTL_UX_EXIT_PX;
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB3PIPECTL_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB3PIPECTL.SUSPENDENABLE must be
-	 * cleared after power-on reset, and it can be set after core
-	 * initialization.
-	 */
+	/* Ensure the GUSB3PIPECTL.SUSPENDENABLE is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
 	if (dwc->u2ss_inp3_quirk)
@@ -747,15 +751,7 @@ static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
 		break;
 	}
 
-	/*
-	 * Above DWC_usb3.0 1.94a, it is recommended to set
-	 * DWC3_GUSB2PHYCFG_SUSPHY to '0' during coreConsultant configuration.
-	 * So default value will be '0' when the core is reset. Application
-	 * needs to set it to '1' after the core initialization is completed.
-	 *
-	 * Similarly for DRD controllers, GUSB2PHYCFG.SUSPHY must be cleared
-	 * after power-on reset, and it can be set after core initialization.
-	 */
+	/* Ensure the GUSB2PHYCFG.SUSPHY is cleared prior to phy init. */
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
 
 	if (dwc->dis_enblslpm_quirk)
@@ -830,6 +826,25 @@ static int dwc3_phy_init(struct dwc3 *dwc)
 			goto err_exit_usb3_phy;
 	}
 
+	/*
+	 * Above DWC_usb3.0 1.94a, it is recommended to set
+	 * DWC3_GUSB3PIPECTL_SUSPHY and DWC3_GUSB2PHYCFG_SUSPHY to '0' during
+	 * coreConsultant configuration. So default value will be '0' when the
+	 * core is reset. Application needs to set it to '1' after the core
+	 * initialization is completed.
+	 *
+	 * Certain phy requires to be in P0 power state during initialization.
+	 * Make sure GUSB3PIPECTL.SUSPENDENABLE and GUSB2PHYCFG.SUSPHY are clear
+	 * prior to phy init to maintain in the P0 state.
+	 *
+	 * After phy initialization, some phy operations can only be executed
+	 * while in lower P states. Ensure GUSB3PIPECTL.SUSPENDENABLE and
+	 * GUSB2PHYCFG.SUSPHY are set soon after initialization to avoid
+	 * blocking phy ops.
+	 */
+	if (!DWC3_VER_IS_WITHIN(DWC3, ANY, 194A))
+		dwc3_enable_susphy(dwc, true);
+
 	return 0;
 
 err_exit_usb3_phy:
@@ -1568,7 +1583,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, false);
@@ -1580,7 +1595,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 			return dev_err_probe(dev, ret, "failed to initialize gadget\n");
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, false);
 
 		if (dwc->usb2_phy)
 			otg_set_vbus(dwc->usb2_phy->otg, true);
@@ -1625,7 +1640,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	}
 
 	/* de-assert DRVVBUS for HOST and OTG mode */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 }
 
 static void dwc3_get_software_properties(struct dwc3 *dwc)
@@ -1815,8 +1830,6 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->tx_thr_num_pkt_prd = tx_thr_num_pkt_prd;
 	dwc->tx_max_burst_prd = tx_max_burst_prd;
 
-	dwc->imod_interval = 0;
-
 	dwc->tx_fifo_resize_max_num = tx_fifo_resize_max_num;
 }
 
@@ -1834,21 +1847,19 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	unsigned int hwparam_gen =
 		DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3);
 
-	/* Check for proper value of imod_interval */
-	if (dwc->imod_interval && !dwc3_has_imod(dwc)) {
-		dev_warn(dwc->dev, "Interrupt moderation not supported\n");
-		dwc->imod_interval = 0;
-	}
-
 	/*
+	 * Enable IMOD for all supporting controllers.
+	 *
+	 * Particularly, DWC_usb3 v3.00a must enable this feature for
+	 * the following reason:
+	 *
 	 * Workaround for STAR 9000961433 which affects only version
 	 * 3.00a of the DWC_usb3 core. This prevents the controller
 	 * interrupt from being masked while handling events. IMOD
 	 * allows us to work around this issue. Enable it for the
 	 * affected version.
 	 */
-	if (!dwc->imod_interval &&
-	    DWC3_VER_IS(DWC3, 300A))
+	if (dwc3_has_imod((dwc)))
 		dwc->imod_interval = 1;
 
 	/* Check the maximum_speed parameter */
@@ -2437,7 +2448,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE, true);
 		dwc3_gadget_resume(dwc);
 		break;
 	case DWC3_GCTL_PRTCAP_HOST:
@@ -2445,7 +2456,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 			ret = dwc3_core_init_for_resume(dwc);
 			if (ret)
 				return ret;
-			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+			dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST, true);
 			break;
 		}
 		/* Restore GUSB2PHYCFG bits that were modified in suspend */
@@ -2474,7 +2485,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
 		if (ret)
 			return ret;
 
-		dwc3_set_prtcap(dwc, dwc->current_dr_role);
+		dwc3_set_prtcap(dwc, dwc->current_dr_role, true);
 
 		dwc3_otg_init(dwc);
 		if (dwc->current_otg_role == DWC3_OTG_ROLE_HOST) {
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f11570c8ffd0..ecadedd2fc0b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1556,7 +1556,7 @@ struct dwc3_gadget_ep_cmd_params {
 #define DWC3_HAS_OTG			BIT(3)
 
 /* prototypes */
-void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
+void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bool ignore_susphy);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index d76ae676783c..7977860932b1 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -173,7 +173,7 @@ void dwc3_otg_init(struct dwc3 *dwc)
 	 * block "Initialize GCTL for OTG operation".
 	 */
 	/* GCTL.PrtCapDir=2'b11 */
-	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+	dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 	/* GUSB2PHYCFG0.SusPHY=0 */
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
@@ -556,7 +556,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
 
 		dwc3_drd_update(dwc);
 	} else {
-		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
+		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG, true);
 
 		/* use OTG block to get ID event */
 		irq = dwc3_otg_get_irq(dwc);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 329bc164241a..535b73217715 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4494,14 +4494,18 @@ static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
 	dwc3_writel(dwc->regs, DWC3_GEVNTSIZ(0),
 		    DWC3_GEVNTSIZ_SIZE(evt->length));
 
+	evt->flags &= ~DWC3_EVENT_PENDING;
+	/*
+	 * Add an explicit write memory barrier to make sure that the update of
+	 * clearing DWC3_EVENT_PENDING is observed in dwc3_check_event_buf()
+	 */
+	wmb();
+
 	if (dwc->imod_interval) {
 		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), DWC3_GEVNTCOUNT_EHB);
 		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), dwc->imod_interval);
 	}
 
-	/* Keep the clearing of DWC3_EVENT_PENDING at the end */
-	evt->flags &= ~DWC3_EVENT_PENDING;
-
 	return ret;
 }
 
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index bdda8c74602d..869ad99afb48 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev *cdev,
 	else
 		usb_gadget_set_remote_wakeup(gadget, 0);
 done:
-	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
-		usb_gadget_set_selfpowered(gadget);
-	else
+	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
+	    (c && !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER)))
 		usb_gadget_clear_selfpowered(gadget);
+	else
+		usb_gadget_set_selfpowered(gadget);
 
 	usb_gadget_vbus_draw(gadget, power);
 	if (result >= 0 && cdev->delayed_status)
@@ -2615,7 +2616,10 @@ void composite_suspend(struct usb_gadget *gadget)
 
 	cdev->suspended = 1;
 
-	usb_gadget_set_selfpowered(gadget);
+	if (cdev->config &&
+	    cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
+		usb_gadget_set_selfpowered(gadget);
+
 	usb_gadget_vbus_draw(gadget, 2);
 }
 
@@ -2649,8 +2653,11 @@ void composite_resume(struct usb_gadget *gadget)
 		else
 			maxpower = min(maxpower, 900U);
 
-		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW)
+		if (maxpower > USB_SELF_POWER_VBUS_MAX_DRAW ||
+		    !(cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
 			usb_gadget_clear_selfpowered(gadget);
+		else
+			usb_gadget_set_selfpowered(gadget);
 
 		usb_gadget_vbus_draw(gadget, maxpower);
 	} else {
diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 09e2838917e2..f58590bf5e02 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -1052,8 +1052,8 @@ void gether_suspend(struct gether *link)
 		 * There is a transfer in progress. So we trigger a remote
 		 * wakeup to inform the host.
 		 */
-		ether_wakeup_host(dev->port_usb);
-		return;
+		if (!ether_wakeup_host(dev->port_usb))
+			return;
 	}
 	spin_lock_irqsave(&dev->lock, flags);
 	link->is_suspend = true;
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 9693464c0520..69c278b64084 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 #include <linux/bitfield.h>
+#include <linux/pci.h>
 
 #include "xhci.h"
 #include "xhci-trace.h"
@@ -770,9 +771,16 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
 enum usb_link_tunnel_mode xhci_port_is_tunneled(struct xhci_hcd *xhci,
 						struct xhci_port *port)
 {
+	struct usb_hcd *hcd;
 	void __iomem *base;
 	u32 offset;
 
+	/* Don't try and probe this capability for non-Intel hosts */
+	hcd = xhci_to_hcd(xhci);
+	if (!dev_is_pci(hcd->self.controller) ||
+	    to_pci_dev(hcd->self.controller)->vendor != PCI_VENDOR_ID_INTEL)
+		return USB_LINK_UNKNOWN;
+
 	base = &xhci->cap_regs->hc_capbase;
 	offset = xhci_find_next_ext_cap(base, 0, XHCI_EXT_CAPS_INTEL_SPR_SHADOW);
 
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 92703efda1f7..fdf0c1008225 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2437,7 +2437,8 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 * and our use of dma addresses in the trb_address_map radix tree needs
 	 * TRB_SEGMENT_SIZE alignment, so we pick the greater alignment need.
 	 */
-	if (xhci->quirks & XHCI_ZHAOXIN_TRB_FETCH)
+	if (xhci->quirks & XHCI_TRB_OVERFETCH)
+		/* Buggy HC prefetches beyond segment bounds - allocate dummy space at the end */
 		xhci->segment_pool = dma_pool_create("xHCI ring segments", dev,
 				TRB_SEGMENT_SIZE * 2, TRB_SEGMENT_SIZE * 2, xhci->page_size * 2);
 	else
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index ad0ff356f6fa..54460d11f7ee 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -38,6 +38,8 @@
 #define PCI_DEVICE_ID_ETRON_EJ168		0x7023
 #define PCI_DEVICE_ID_ETRON_EJ188		0x7052
 
+#define PCI_DEVICE_ID_VIA_VL805			0x3483
+
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI		0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI		0x9c31
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_XHCI	0x9cb1
@@ -418,8 +420,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 			pdev->device == 0x3432)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
-	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483)
+	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == PCI_DEVICE_ID_VIA_VL805) {
 		xhci->quirks |= XHCI_LPM_SUPPORT;
+		xhci->quirks |= XHCI_TRB_OVERFETCH;
+	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
@@ -467,11 +471,11 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 
 		if (pdev->device == 0x9202) {
 			xhci->quirks |= XHCI_RESET_ON_RESUME;
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 		}
 
 		if (pdev->device == 0x9203)
-			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
+			xhci->quirks |= XHCI_TRB_OVERFETCH;
 	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_CDNS &&
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5ebde8cae4fc..55086d63e7ef 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -779,8 +779,12 @@ static void xhci_clear_command_ring(struct xhci_hcd *xhci)
 	struct xhci_segment *seg;
 
 	ring = xhci->cmd_ring;
-	xhci_for_each_ring_seg(ring->first_seg, seg)
+	xhci_for_each_ring_seg(ring->first_seg, seg) {
+		/* erase all TRBs before the link */
 		memset(seg->trbs, 0, sizeof(union xhci_trb) * (TRBS_PER_SEGMENT - 1));
+		/* clear link cycle bit */
+		seg->trbs[TRBS_PER_SEGMENT - 1].link.control &= cpu_to_le32(~TRB_CYCLE);
+	}
 
 	xhci_initialize_ring_info(ring);
 	/*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 4914f0a10cff..dba1db259cd3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1628,7 +1628,7 @@ struct xhci_hcd {
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 #define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
-#define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
+#define XHCI_TRB_OVERFETCH	BIT_ULL(45)
 #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
 #define XHCI_WRITE_64_HI_LO	BIT_ULL(47)
 #define XHCI_CDNS_SCTX_QUIRK	BIT_ULL(48)
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 935fc496fe94..4b35ef216125 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -312,8 +312,10 @@ static int usbhsc_clk_get(struct device *dev, struct usbhs_priv *priv)
 	priv->clks[1] = of_clk_get(dev_of_node(dev), 1);
 	if (PTR_ERR(priv->clks[1]) == -ENOENT)
 		priv->clks[1] = NULL;
-	else if (IS_ERR(priv->clks[1]))
+	else if (IS_ERR(priv->clks[1])) {
+		clk_put(priv->clks[0]);
 		return PTR_ERR(priv->clks[1]);
+	}
 
 	return 0;
 }
@@ -779,6 +781,8 @@ static void usbhs_remove(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "usb remove\n");
 
+	flush_delayed_work(&priv->notify_hotplug_work);
+
 	/* power off */
 	if (!usbhs_get_dparam(priv, runtime_pwctrl))
 		usbhsc_power_ctrl(priv, 0);
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 105132ae87ac..e8e5723f5412 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -1094,7 +1094,7 @@ int usbhs_mod_gadget_probe(struct usbhs_priv *priv)
 		goto usbhs_mod_gadget_probe_err_gpriv;
 	}
 
-	gpriv->transceiver = usb_get_phy(USB_PHY_TYPE_UNDEFINED);
+	gpriv->transceiver = devm_usb_get_phy(dev, USB_PHY_TYPE_UNDEFINED);
 	dev_info(dev, "%stransceiver found\n",
 		 !IS_ERR(gpriv->transceiver) ? "" : "no ");
 
diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 64f6dd0dc660..88c50b984e8a 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -334,6 +334,11 @@ static int rt1711h_probe(struct i2c_client *client)
 {
 	int ret;
 	struct rt1711h_chip *chip;
+	const u16 alert_mask = TCPC_ALERT_TX_SUCCESS | TCPC_ALERT_TX_DISCARDED |
+			       TCPC_ALERT_TX_FAILED | TCPC_ALERT_RX_HARD_RST |
+			       TCPC_ALERT_RX_STATUS | TCPC_ALERT_POWER_STATUS |
+			       TCPC_ALERT_CC_STATUS | TCPC_ALERT_RX_BUF_OVF |
+			       TCPC_ALERT_FAULT;
 
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
@@ -382,6 +387,12 @@ static int rt1711h_probe(struct i2c_client *client)
 					dev_name(chip->dev), chip);
 	if (ret < 0)
 		return ret;
+
+	/* Enable alert interrupts */
+	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, alert_mask);
+	if (ret < 0)
+		return ret;
+
 	enable_irq_wake(client->irq);
 
 	return 0;
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index fcf499cc9458..2a2915b0a645 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -25,7 +25,7 @@
  * difficult to estimate the time it takes for the system to process the command
  * before it is actually passed to the PPM.
  */
-#define UCSI_TIMEOUT_MS		5000
+#define UCSI_TIMEOUT_MS		10000
 
 /*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
@@ -1346,7 +1346,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 	mutex_lock(&ucsi->ppm_lock);
 
-	ret = ucsi->ops->read_cci(ucsi, &cci);
+	ret = ucsi->ops->poll_cci(ucsi, &cci);
 	if (ret < 0)
 		goto out;
 
@@ -1364,7 +1364,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 
 		tmo = jiffies + msecs_to_jiffies(UCSI_TIMEOUT_MS);
 		do {
-			ret = ucsi->ops->read_cci(ucsi, &cci);
+			ret = ucsi->ops->poll_cci(ucsi, &cci);
 			if (ret < 0)
 				goto out;
 			if (cci & UCSI_CCI_COMMAND_COMPLETE)
@@ -1393,7 +1393,7 @@ static int ucsi_reset_ppm(struct ucsi *ucsi)
 		/* Give the PPM time to process a reset before reading CCI */
 		msleep(20);
 
-		ret = ucsi->ops->read_cci(ucsi, &cci);
+		ret = ucsi->ops->poll_cci(ucsi, &cci);
 		if (ret)
 			goto out;
 
@@ -1825,11 +1825,11 @@ static int ucsi_init(struct ucsi *ucsi)
 
 err_unregister:
 	for (con = connector; con->port; con++) {
+		if (con->wq)
+			destroy_workqueue(con->wq);
 		ucsi_unregister_partner(con);
 		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
 		ucsi_unregister_port_psy(con);
-		if (con->wq)
-			destroy_workqueue(con->wq);
 
 		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
 		con->port_sink_caps = NULL;
@@ -1929,8 +1929,8 @@ struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops)
 	struct ucsi *ucsi;
 
 	if (!ops ||
-	    !ops->read_version || !ops->read_cci || !ops->read_message_in ||
-	    !ops->sync_control || !ops->async_control)
+	    !ops->read_version || !ops->read_cci || !ops->poll_cci ||
+	    !ops->read_message_in || !ops->sync_control || !ops->async_control)
 		return ERR_PTR(-EINVAL);
 
 	ucsi = kzalloc(sizeof(*ucsi), GFP_KERNEL);
@@ -2013,10 +2013,6 @@ void ucsi_unregister(struct ucsi *ucsi)
 
 	for (i = 0; i < ucsi->cap.num_connectors; i++) {
 		cancel_work_sync(&ucsi->connector[i].work);
-		ucsi_unregister_partner(&ucsi->connector[i]);
-		ucsi_unregister_altmodes(&ucsi->connector[i],
-					 UCSI_RECIPIENT_CON);
-		ucsi_unregister_port_psy(&ucsi->connector[i]);
 
 		if (ucsi->connector[i].wq) {
 			struct ucsi_work *uwork;
@@ -2032,6 +2028,11 @@ void ucsi_unregister(struct ucsi *ucsi)
 			destroy_workqueue(ucsi->connector[i].wq);
 		}
 
+		ucsi_unregister_partner(&ucsi->connector[i]);
+		ucsi_unregister_altmodes(&ucsi->connector[i],
+					 UCSI_RECIPIENT_CON);
+		ucsi_unregister_port_psy(&ucsi->connector[i]);
+
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
 		ucsi->connector[i].port_sink_caps = NULL;
 		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 5ff369c24a2f..e4c563da715f 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -61,6 +61,7 @@ struct dentry;
  * struct ucsi_operations - UCSI I/O operations
  * @read_version: Read implemented UCSI version
  * @read_cci: Read CCI register
+ * @poll_cci: Read CCI register while polling with notifications disabled
  * @read_message_in: Read message data from UCSI
  * @sync_control: Blocking control operation
  * @async_control: Non-blocking control operation
@@ -75,6 +76,7 @@ struct dentry;
 struct ucsi_operations {
 	int (*read_version)(struct ucsi *ucsi, u16 *version);
 	int (*read_cci)(struct ucsi *ucsi, u32 *cci);
+	int (*poll_cci)(struct ucsi *ucsi, u32 *cci);
 	int (*read_message_in)(struct ucsi *ucsi, void *val, size_t val_len);
 	int (*sync_control)(struct ucsi *ucsi, u64 command);
 	int (*async_control)(struct ucsi *ucsi, u64 command);
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 5c5515551963..ac1ebb5d9527 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -59,19 +59,24 @@ static int ucsi_acpi_read_version(struct ucsi *ucsi, u16 *version)
 static int ucsi_acpi_read_cci(struct ucsi *ucsi, u32 *cci)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
-	int ret;
-
-	if (UCSI_COMMAND(ua->cmd) == UCSI_PPM_RESET) {
-		ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
-		if (ret)
-			return ret;
-	}
 
 	memcpy(cci, ua->base + UCSI_CCI, sizeof(*cci));
 
 	return 0;
 }
 
+static int ucsi_acpi_poll_cci(struct ucsi *ucsi, u32 *cci)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
+	if (ret)
+		return ret;
+
+	return ucsi_acpi_read_cci(ucsi, cci);
+}
+
 static int ucsi_acpi_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
@@ -94,6 +99,7 @@ static int ucsi_acpi_async_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_acpi_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_acpi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_acpi_async_control
@@ -142,6 +148,7 @@ static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_gram_ops = {
 	.read_version = ucsi_acpi_read_version,
 	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
 	.read_message_in = ucsi_gram_read_message_in,
 	.sync_control = ucsi_gram_sync_control,
 	.async_control = ucsi_acpi_async_control
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 740171f24ef9..4b1668733a4b 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -664,6 +664,7 @@ static int ucsi_ccg_sync_control(struct ucsi *ucsi, u64 command)
 static const struct ucsi_operations ucsi_ccg_ops = {
 	.read_version = ucsi_ccg_read_version,
 	.read_cci = ucsi_ccg_read_cci,
+	.poll_cci = ucsi_ccg_read_cci,
 	.read_message_in = ucsi_ccg_read_message_in,
 	.sync_control = ucsi_ccg_sync_control,
 	.async_control = ucsi_ccg_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index fed39d458090..8af79101a2fc 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -206,6 +206,7 @@ static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
 static const struct ucsi_operations pmic_glink_ucsi_ops = {
 	.read_version = pmic_glink_ucsi_read_version,
 	.read_cci = pmic_glink_ucsi_read_cci,
+	.poll_cci = pmic_glink_ucsi_read_cci,
 	.read_message_in = pmic_glink_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = pmic_glink_ucsi_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_stm32g0.c b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
index 6923fad31d79..57ef7d83a412 100644
--- a/drivers/usb/typec/ucsi/ucsi_stm32g0.c
+++ b/drivers/usb/typec/ucsi/ucsi_stm32g0.c
@@ -424,6 +424,7 @@ static irqreturn_t ucsi_stm32g0_irq_handler(int irq, void *data)
 static const struct ucsi_operations ucsi_stm32g0_ops = {
 	.read_version = ucsi_stm32g0_read_version,
 	.read_cci = ucsi_stm32g0_read_cci,
+	.poll_cci = ucsi_stm32g0_read_cci,
 	.read_message_in = ucsi_stm32g0_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = ucsi_stm32g0_async_control,
diff --git a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
index f3a5e24ea84d..40e5da4fd2a4 100644
--- a/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
+++ b/drivers/usb/typec/ucsi/ucsi_yoga_c630.c
@@ -74,6 +74,7 @@ static int yoga_c630_ucsi_async_control(struct ucsi *ucsi, u64 command)
 const struct ucsi_operations yoga_c630_ucsi_ops = {
 	.read_version = yoga_c630_ucsi_read_version,
 	.read_cci = yoga_c630_ucsi_read_cci,
+	.poll_cci = yoga_c630_ucsi_read_cci,
 	.read_message_in = yoga_c630_ucsi_read_message_in,
 	.sync_control = ucsi_sync_control_common,
 	.async_control = yoga_c630_ucsi_async_control,
diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
index c24036c4e51e..e4e196abdaac 100644
--- a/drivers/virt/acrn/hsm.c
+++ b/drivers/virt/acrn/hsm.c
@@ -49,7 +49,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 	switch (cmd & PMCMD_TYPE_MASK) {
 	case ACRN_PMCMD_GET_PX_CNT:
 	case ACRN_PMCMD_GET_CX_CNT:
-		pm_info = kmalloc(sizeof(u64), GFP_KERNEL);
+		pm_info = kzalloc(sizeof(u64), GFP_KERNEL);
 		if (!pm_info)
 			return -ENOMEM;
 
@@ -64,7 +64,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 		kfree(pm_info);
 		break;
 	case ACRN_PMCMD_GET_PX_DATA:
-		px_data = kmalloc(sizeof(*px_data), GFP_KERNEL);
+		px_data = kzalloc(sizeof(*px_data), GFP_KERNEL);
 		if (!px_data)
 			return -ENOMEM;
 
@@ -79,7 +79,7 @@ static int pmcmd_ioctl(u64 cmd, void __user *uptr)
 		kfree(px_data);
 		break;
 	case ACRN_PMCMD_GET_CX_DATA:
-		cx_data = kmalloc(sizeof(*cx_data), GFP_KERNEL);
+		cx_data = kzalloc(sizeof(*cx_data), GFP_KERNEL);
 		if (!cx_data)
 			return -ENOMEM;
 
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index b699771be029..af64e6191f74 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -41,12 +41,6 @@ struct snp_guest_dev {
 	struct miscdevice misc;
 
 	struct snp_msg_desc *msg_desc;
-
-	union {
-		struct snp_report_req report;
-		struct snp_derived_key_req derived_key;
-		struct snp_ext_report_req ext_report;
-	} req;
 };
 
 /*
@@ -390,7 +384,7 @@ struct snp_req_resp {
 
 static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_report_req *report_req = &snp_dev->req.report;
+	struct snp_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -399,6 +393,10 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!arg->req_data || !arg->resp_data)
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_user(report_req, (void __user *)arg->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
@@ -435,7 +433,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 
 static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
 {
-	struct snp_derived_key_req *derived_key_req = &snp_dev->req.derived_key;
+	struct snp_derived_key_req *derived_key_req __free(kfree) = NULL;
 	struct snp_derived_key_resp derived_key_resp = {0};
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_guest_req req = {};
@@ -455,6 +453,10 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (sizeof(buf) < resp_len)
 		return -ENOMEM;
 
+	derived_key_req = kzalloc(sizeof(*derived_key_req), GFP_KERNEL_ACCOUNT);
+	if (!derived_key_req)
+		return -ENOMEM;
+
 	if (copy_from_user(derived_key_req, (void __user *)arg->req_data,
 			   sizeof(*derived_key_req)))
 		return -EFAULT;
@@ -487,7 +489,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 			  struct snp_req_resp *io)
 
 {
-	struct snp_ext_report_req *report_req = &snp_dev->req.ext_report;
+	struct snp_ext_report_req *report_req __free(kfree) = NULL;
 	struct snp_msg_desc *mdesc = snp_dev->msg_desc;
 	struct snp_report_resp *report_resp;
 	struct snp_guest_req req = {};
@@ -497,6 +499,10 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
 	if (sockptr_is_null(io->req_data) || sockptr_is_null(io->resp_data))
 		return -EINVAL;
 
+	report_req = kzalloc(sizeof(*report_req), GFP_KERNEL_ACCOUNT);
+	if (!report_req)
+		return -ENOMEM;
+
 	if (copy_from_sockptr(report_req, io->req_data, sizeof(*report_req)))
 		return -EFAULT;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b4160b1c7757..d1acae2d6d33 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1426,8 +1426,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				continue;
 			}
 			if (done_offset) {
-				*done_offset = start - 1;
-				return 0;
+				/*
+				 * Move @end to the end of the processed range,
+				 * and exit the loop to unlock the processed extents.
+				 */
+				end = start - 1;
+				ret = 0;
+				break;
 			}
 			ret = -ENOSPC;
 		}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3d0ac8bdb21f..083841e45689 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7076,6 +7076,7 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
 		btrfs_err(fs_info,
 			  "failed to add chunk map, start=%llu len=%llu: %d",
 			  map->start, map->chunk_len, ret);
+		btrfs_free_chunk_map(map);
 	}
 
 	return ret;
diff --git a/fs/coredump.c b/fs/coredump.c
index d48edb37bc35..c6f4c745e1bd 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -63,6 +63,7 @@ static void free_vma_snapshot(struct coredump_params *cprm);
 
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
+static unsigned int core_sort_vma;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
 static int core_name_size = CORENAME_MAX_SIZE;
 unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
@@ -1026,6 +1027,15 @@ static struct ctl_table coredump_sysctls[] = {
 		.extra1		= (unsigned int *)&core_file_note_size_min,
 		.extra2		= (unsigned int *)&core_file_note_size_max,
 	},
+	{
+		.procname	= "core_sort_vma",
+		.data		= &core_sort_vma,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 };
 
 static int __init init_fs_coredump_sysctls(void)
@@ -1256,8 +1266,9 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 		cprm->vma_data_size += m->dump_size;
 	}
 
-	sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
-		cmp_vma_size, NULL);
+	if (core_sort_vma)
+		sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
+		     cmp_vma_size, NULL);
 
 	return true;
 }
diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index ce9be95c9172..9ff825f1502d 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -141,7 +141,7 @@ int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	return 0;
 }
 
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
+int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 {
 	int i, b;
 	unsigned int ent_idx;
@@ -150,13 +150,17 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 	struct exfat_mount_options *opts = &sbi->options;
 
 	if (!is_valid_cluster(sbi, clu))
-		return;
+		return -EIO;
 
 	ent_idx = CLUSTER_TO_BITMAP_ENT(clu);
 	i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
 	b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
 
+	if (!test_bit_le(b, sbi->vol_amap[i]->b_data))
+		return -EIO;
+
 	clear_bit_le(b, sbi->vol_amap[i]->b_data);
+
 	exfat_update_bh(sbi->vol_amap[i], sync);
 
 	if (opts->discard) {
@@ -171,6 +175,8 @@ void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync)
 			opts->discard = 0;
 		}
 	}
+
+	return 0;
 }
 
 /*
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 78be6964a8a0..d30ce18a88b7 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -456,7 +456,7 @@ int exfat_count_num_clusters(struct super_block *sb,
 int exfat_load_bitmap(struct super_block *sb);
 void exfat_free_bitmap(struct exfat_sb_info *sbi);
 int exfat_set_bitmap(struct inode *inode, unsigned int clu, bool sync);
-void exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
+int exfat_clear_bitmap(struct inode *inode, unsigned int clu, bool sync);
 unsigned int exfat_find_free_bitmap(struct super_block *sb, unsigned int clu);
 int exfat_count_used_clusters(struct super_block *sb, unsigned int *ret_count);
 int exfat_trim_fs(struct inode *inode, struct fstrim_range *range);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 9e5492ac409b..6f3651c6ca91 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -175,6 +175,7 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		BITMAP_OFFSET_SECTOR_INDEX(sb, CLUSTER_TO_BITMAP_ENT(clu));
 
 	if (p_chain->flags == ALLOC_NO_FAT_CHAIN) {
+		int err;
 		unsigned int last_cluster = p_chain->dir + p_chain->size - 1;
 		do {
 			bool sync = false;
@@ -189,7 +190,9 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			err = exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			if (err)
+				break;
 			clu++;
 			num_clusters++;
 		} while (num_clusters < p_chain->size);
@@ -210,12 +213,13 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 				cur_cmap_i = next_cmap_i;
 			}
 
-			exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode)));
+			if (exfat_clear_bitmap(inode, clu, (sync && IS_DIRSYNC(inode))))
+				break;
 			clu = n_clu;
 			num_clusters++;
 
 			if (err)
-				goto dec_used_clus;
+				break;
 
 			if (num_clusters >= sbi->num_clusters - EXFAT_FIRST_CLUSTER) {
 				/*
@@ -229,7 +233,6 @@ static int __exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain
 		} while (clu != EXFAT_EOF_CLUSTER);
 	}
 
-dec_used_clus:
 	sbi->used_clusters -= num_clusters;
 	return 0;
 }
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 05b51e721783..807349d8ea05 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -587,7 +587,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	valid_size = ei->valid_size;
 
 	ret = generic_write_checks(iocb, iter);
-	if (ret < 0)
+	if (ret <= 0)
 		goto unlock;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 099f80645072..9996ca61c85b 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -237,7 +237,7 @@ static int exfat_search_empty_slot(struct super_block *sb,
 		dentry = 0;
 	}
 
-	while (dentry + num_entries < total_entries &&
+	while (dentry + num_entries <= total_entries &&
 	       clu.dir != EXFAT_EOF_CLUSTER) {
 		i = dentry & (dentries_per_clu - 1);
 
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1bb646752e46..033feeab8c34 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/gfp.h>
 #include <linux/swap.h>
+#include <linux/compaction.h>
 
 #include <linux/uaccess.h>
 #include <linux/filelock.h>
@@ -457,7 +458,7 @@ static bool nfs_release_folio(struct folio *folio, gfp_t gfp)
 	/* If the private flag is set, then the folio is not freeable */
 	if (folio_test_private(folio)) {
 		if ((current_gfp_context(gfp) & GFP_KERNEL) != GFP_KERNEL ||
-		    current_is_kswapd())
+		    current_is_kswapd() || current_is_kcompactd())
 			return false;
 		if (nfs_wb_folio(folio->mapping->host, folio) < 0)
 			return false;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1e6085f2f78e..37b7d84e2691 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -215,10 +215,8 @@ struct cifs_cred {
 
 struct cifs_open_info_data {
 	bool adjust_tz;
-	union {
-		bool reparse_point;
-		bool symlink;
-	};
+	bool reparse_point;
+	bool contains_posix_file_info;
 	struct {
 		/* ioctl response buffer */
 		struct {
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 0d149b315a83..4d8effe78be5 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -990,7 +990,7 @@ cifs_get_file_info(struct file *filp)
 		/* TODO: add support to query reparse tag */
 		data.adjust_tz = false;
 		if (data.symlink_target) {
-			data.symlink = true;
+			data.reparse_point = true;
 			data.reparse.tag = IO_REPARSE_TAG_SYMLINK;
 		}
 		path = build_path_from_dentry(dentry, page);
diff --git a/fs/smb/client/reparse.h b/fs/smb/client/reparse.h
index ff05b0e75c92..f080f92cb1e7 100644
--- a/fs/smb/client/reparse.h
+++ b/fs/smb/client/reparse.h
@@ -97,14 +97,30 @@ static inline bool reparse_inode_match(struct inode *inode,
 
 static inline bool cifs_open_data_reparse(struct cifs_open_info_data *data)
 {
-	struct smb2_file_all_info *fi = &data->fi;
-	u32 attrs = le32_to_cpu(fi->Attributes);
+	u32 attrs;
 	bool ret;
 
-	ret = data->reparse_point || (attrs & ATTR_REPARSE);
-	if (ret)
-		attrs |= ATTR_REPARSE;
-	fi->Attributes = cpu_to_le32(attrs);
+	if (data->contains_posix_file_info) {
+		struct smb311_posix_qinfo *fi = &data->posix_fi;
+
+		attrs = le32_to_cpu(fi->DosAttributes);
+		if (data->reparse_point) {
+			attrs |= ATTR_REPARSE;
+			fi->DosAttributes = cpu_to_le32(attrs);
+		}
+
+	} else {
+		struct smb2_file_all_info *fi = &data->fi;
+
+		attrs = le32_to_cpu(fi->Attributes);
+		if (data->reparse_point) {
+			attrs |= ATTR_REPARSE;
+			fi->Attributes = cpu_to_le32(attrs);
+		}
+	}
+
+	ret = attrs & ATTR_REPARSE;
+
 	return ret;
 }
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index c70f4961c4eb..bd791aa54681 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -551,7 +551,7 @@ static int cifs_query_path_info(const unsigned int xid,
 	int rc;
 	FILE_ALL_INFO fi = {};
 
-	data->symlink = false;
+	data->reparse_point = false;
 	data->adjust_tz = false;
 
 	/* could do find first instead but this returns more info */
@@ -592,7 +592,7 @@ static int cifs_query_path_info(const unsigned int xid,
 		/* Need to check if this is a symbolic link or not */
 		tmprc = CIFS_open(xid, &oparms, &oplock, NULL);
 		if (tmprc == -EOPNOTSUPP)
-			data->symlink = true;
+			data->reparse_point = true;
 		else if (tmprc == 0)
 			CIFSSMBClose(xid, tcon, fid.netfid);
 	}
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 7dfd3eb3847b..6048b3fed3e7 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -648,6 +648,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		switch (cmds[i]) {
 		case SMB2_OP_QUERY_INFO:
 			idata = in_iov[i].iov_base;
+			idata->contains_posix_file_info = false;
 			if (rc == 0 && cfile && cfile->symlink_target) {
 				idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 				if (!idata->symlink_target)
@@ -671,6 +672,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			break;
 		case SMB2_OP_POSIX_QUERY_INFO:
 			idata = in_iov[i].iov_base;
+			idata->contains_posix_file_info = true;
 			if (rc == 0 && cfile && cfile->symlink_target) {
 				idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 				if (!idata->symlink_target)
@@ -768,6 +770,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 				idata = in_iov[i].iov_base;
 				idata->reparse.io.iov = *iov;
 				idata->reparse.io.buftype = resp_buftype[i + 1];
+				idata->contains_posix_file_info = false; /* BB VERIFY */
 				rbuf = reparse_buf_ptr(iov);
 				if (IS_ERR(rbuf)) {
 					rc = PTR_ERR(rbuf);
@@ -789,6 +792,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		case SMB2_OP_QUERY_WSL_EA:
 			if (!rc) {
 				idata = in_iov[i].iov_base;
+				idata->contains_posix_file_info = false;
 				qi_rsp = rsp_iov[i + 1].iov_base;
 				data[0] = (u8 *)qi_rsp + le16_to_cpu(qi_rsp->OutputBufferOffset);
 				size[0] = le32_to_cpu(qi_rsp->OutputBufferLength);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 793e9b2b79d6..17c3063a9ca5 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1001,6 +1001,7 @@ static int smb2_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
 		if (!data->symlink_target)
 			return -ENOMEM;
 	}
+	data->contains_posix_file_info = false;
 	return SMB2_query_info(xid, tcon, fid->persistent_fid, fid->volatile_fid, &data->fi);
 }
 
@@ -5150,7 +5151,7 @@ int __cifs_sfu_make_node(unsigned int xid, struct inode *inode,
 			     FILE_CREATE, CREATE_NOT_DIR |
 			     CREATE_OPTION_SPECIAL, ACL_NO_MODE);
 	oparms.fid = &fid;
-
+	idata.contains_posix_file_info = false;
 	rc = server->ops->open(xid, &oparms, &oplock, &idata);
 	if (rc)
 		goto out;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 772deec5b90f..91de0224902f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7457,17 +7457,17 @@ int smb2_lock(struct ksmbd_work *work)
 		}
 
 no_check_cl:
+		flock = smb_lock->fl;
+		list_del(&smb_lock->llist);
+
 		if (smb_lock->zero_len) {
 			err = 0;
 			goto skip;
 		}
-
-		flock = smb_lock->fl;
-		list_del(&smb_lock->llist);
 retry:
 		rc = vfs_lock_file(filp, smb_lock->cmd, flock, NULL);
 skip:
-		if (flags & SMB2_LOCKFLAG_UNLOCK) {
+		if (smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) {
 			if (!rc) {
 				ksmbd_debug(SMB, "File unlocked\n");
 			} else if (rc == -ENOENT) {
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index d39d3e553366..89415b02dd64 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -807,6 +807,13 @@ static int parse_sid(struct smb_sid *psid, char *end_of_acl)
 		return -EINVAL;
 	}
 
+	if (!psid->num_subauth)
+		return 0;
+
+	if (psid->num_subauth > SID_MAX_SUB_AUTHORITIES ||
+	    end_of_acl < (char *)psid + 8 + sizeof(__le32) * psid->num_subauth)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -848,6 +855,9 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 	pntsd->type = cpu_to_le16(DACL_PRESENT);
 
 	if (pntsd->osidoffset) {
+		if (le32_to_cpu(pntsd->osidoffset) < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		rc = parse_sid(owner_sid_ptr, end_of_acl);
 		if (rc) {
 			pr_err("%s: Error %d parsing Owner SID\n", __func__, rc);
@@ -863,6 +873,9 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 	}
 
 	if (pntsd->gsidoffset) {
+		if (le32_to_cpu(pntsd->gsidoffset) < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		rc = parse_sid(group_sid_ptr, end_of_acl);
 		if (rc) {
 			pr_err("%s: Error %d mapping Owner SID to gid\n",
@@ -884,6 +897,9 @@ int parse_sec_desc(struct mnt_idmap *idmap, struct smb_ntsd *pntsd,
 		pntsd->type |= cpu_to_le16(DACL_PROTECTED);
 
 	if (dacloffset) {
+		if (dacloffset < sizeof(struct smb_ntsd))
+			return -EINVAL;
+
 		parse_dacl(idmap, dacl_ptr, end_of_acl,
 			   owner_sid_ptr, group_sid_ptr, fattr);
 	}
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index e9aa92d02789..22a3646b909b 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -281,6 +281,7 @@ static int handle_response(int type, void *payload, size_t sz)
 		if (entry->type + 1 != type) {
 			pr_err("Waiting for IPC type %d, got %d. Ignore.\n",
 			       entry->type + 1, type);
+			continue;
 		}
 
 		entry->response = kvzalloc(sz, KSMBD_DEFAULT_GFP);
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index f42133dae68e..2afc95bf1655 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -90,7 +90,7 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-		unsigned long addr, pte_t *ptep)
+		unsigned long addr, pte_t *ptep, unsigned long sz)
 {
 	return ptep_get_and_clear(mm, addr, ptep);
 }
diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index e94776496049..7bf0c521db63 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -80,6 +80,11 @@ static inline unsigned long compact_gap(unsigned int order)
 	return 2UL << order;
 }
 
+static inline int current_is_kcompactd(void)
+{
+	return current->flags & PF_KCOMPACTD;
+}
+
 #ifdef CONFIG_COMPACTION
 
 extern unsigned int extfrag_for_order(struct zone *zone, unsigned int order);
diff --git a/include/linux/cred.h b/include/linux/cred.h
index e4a3155fe409..1e1ec8834e45 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -179,15 +179,12 @@ static inline bool cap_ambient_invariant_ok(const struct cred *cred)
  */
 static inline const struct cred *override_creds_light(const struct cred *override_cred)
 {
-	const struct cred *old = current->cred;
-
-	rcu_assign_pointer(current->cred, override_cred);
-	return old;
+	return rcu_replace_pointer(current->cred, override_cred, 1);
 }
 
-static inline void revert_creds_light(const struct cred *revert_cred)
+static inline const struct cred *revert_creds_light(const struct cred *revert_cred)
 {
-	rcu_assign_pointer(current->cred, revert_cred);
+	return rcu_replace_pointer(current->cred, revert_cred, 1);
 }
 
 /**
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index b8b935b52603..b0ed740ca749 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -412,6 +412,29 @@ struct ethtool_eth_phy_stats {
 	);
 };
 
+/**
+ * struct ethtool_phy_stats - PHY-level statistics counters
+ * @rx_packets: Total successfully received frames
+ * @rx_bytes: Total successfully received bytes
+ * @rx_errors: Total received frames with errors (e.g., CRC errors)
+ * @tx_packets: Total successfully transmitted frames
+ * @tx_bytes: Total successfully transmitted bytes
+ * @tx_errors: Total transmitted frames with errors
+ *
+ * This structure provides a standardized interface for reporting
+ * PHY-level statistics counters. It is designed to expose statistics
+ * commonly provided by PHYs but not explicitly defined in the IEEE
+ * 802.3 standard.
+ */
+struct ethtool_phy_stats {
+	u64 rx_packets;
+	u64 rx_bytes;
+	u64 rx_errors;
+	u64 tx_packets;
+	u64 tx_bytes;
+	u64 tx_errors;
+};
+
 /* Basic IEEE 802.3 MAC Ctrl statistics (30.3.3.*), not otherwise exposed
  * via a more targeted API.
  */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ae4fe8615bb6..0385103dffcd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1003,7 +1003,9 @@ static inline void hugetlb_count_sub(long l, struct mm_struct *mm)
 static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
 						unsigned long addr, pte_t *ptep)
 {
-	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	unsigned long psize = huge_page_size(hstate_vma(vma));
+
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep, psize);
 }
 #endif
 
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index e07e8978d691..e435250fcb4d 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -13,6 +13,8 @@
 #define NVME_TCP_ADMIN_CCSZ	SZ_8K
 #define NVME_TCP_DIGEST_LENGTH	4
 #define NVME_TCP_MIN_MAXH2CDATA 4096
+#define NVME_TCP_MIN_C2HTERM_PLEN	24
+#define NVME_TCP_MAX_C2HTERM_PLEN	152
 
 enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 563c46205685..bed2b81f8fb3 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1090,6 +1090,35 @@ struct phy_driver {
 	int (*cable_test_get_status)(struct phy_device *dev, bool *finished);
 
 	/* Get statistics from the PHY using ethtool */
+	/**
+	 * @get_phy_stats: Retrieve PHY statistics.
+	 * @dev: The PHY device for which the statistics are retrieved.
+	 * @eth_stats: structure where Ethernet PHY stats will be stored.
+	 * @stats: structure where additional PHY-specific stats will be stored.
+	 *
+	 * Retrieves the supported PHY statistics and populates the provided
+	 * structures. The input structures are pre-initialized with
+	 * `ETHTOOL_STAT_NOT_SET`, and the driver must only modify members
+	 * corresponding to supported statistics. Unmodified members will remain
+	 * set to `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
+	 */
+	void (*get_phy_stats)(struct phy_device *dev,
+			      struct ethtool_eth_phy_stats *eth_stats,
+			      struct ethtool_phy_stats *stats);
+
+	/**
+	 * @get_link_stats: Retrieve link statistics.
+	 * @dev: The PHY device for which the statistics are retrieved.
+	 * @link_stats: structure where link-specific stats will be stored.
+	 *
+	 * Retrieves link-related statistics for the given PHY device. The input
+	 * structure is pre-initialized with `ETHTOOL_STAT_NOT_SET`, and the
+	 * driver must only modify members corresponding to supported
+	 * statistics. Unmodified members will remain set to
+	 * `ETHTOOL_STAT_NOT_SET` and will not be returned to userspace.
+	 */
+	void (*get_link_stats)(struct phy_device *dev,
+			       struct ethtool_link_ext_stats *link_stats);
 	/** @get_sset_count: Number of statistic counters */
 	int (*get_sset_count)(struct phy_device *dev);
 	/** @get_strings: Names of the statistic counters */
@@ -2065,6 +2094,13 @@ int phy_ethtool_get_strings(struct phy_device *phydev, u8 *data);
 int phy_ethtool_get_sset_count(struct phy_device *phydev);
 int phy_ethtool_get_stats(struct phy_device *phydev,
 			  struct ethtool_stats *stats, u64 *data);
+
+void __phy_ethtool_get_phy_stats(struct phy_device *phydev,
+			 struct ethtool_eth_phy_stats *phy_stats,
+			 struct ethtool_phy_stats *phydev_stats);
+void __phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				      struct ethtool_link_ext_stats *link_stats);
+
 int phy_ethtool_get_plca_cfg(struct phy_device *phydev,
 			     struct phy_plca_cfg *plca_cfg);
 int phy_ethtool_set_plca_cfg(struct phy_device *phydev,
diff --git a/include/linux/phylib_stubs.h b/include/linux/phylib_stubs.h
index 1279f48c8a70..9d2d6090c86d 100644
--- a/include/linux/phylib_stubs.h
+++ b/include/linux/phylib_stubs.h
@@ -5,6 +5,9 @@
 
 #include <linux/rtnetlink.h>
 
+struct ethtool_eth_phy_stats;
+struct ethtool_link_ext_stats;
+struct ethtool_phy_stats;
 struct kernel_hwtstamp_config;
 struct netlink_ext_ack;
 struct phy_device;
@@ -19,6 +22,11 @@ struct phylib_stubs {
 	int (*hwtstamp_set)(struct phy_device *phydev,
 			    struct kernel_hwtstamp_config *config,
 			    struct netlink_ext_ack *extack);
+	void (*get_phy_stats)(struct phy_device *phydev,
+			      struct ethtool_eth_phy_stats *phy_stats,
+			      struct ethtool_phy_stats *phydev_stats);
+	void (*get_link_ext_stats)(struct phy_device *phydev,
+				   struct ethtool_link_ext_stats *link_stats);
 };
 
 static inline int phy_hwtstamp_get(struct phy_device *phydev,
@@ -50,6 +58,29 @@ static inline int phy_hwtstamp_set(struct phy_device *phydev,
 	return phylib_stubs->hwtstamp_set(phydev, config, extack);
 }
 
+static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
+					struct ethtool_eth_phy_stats *phy_stats,
+					struct ethtool_phy_stats *phydev_stats)
+{
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return;
+
+	phylib_stubs->get_phy_stats(phydev, phy_stats, phydev_stats);
+}
+
+static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				    struct ethtool_link_ext_stats *link_stats)
+{
+	ASSERT_RTNL();
+
+	if (!phylib_stubs)
+		return;
+
+	phylib_stubs->get_link_ext_stats(phydev, link_stats);
+}
+
 #else
 
 static inline int phy_hwtstamp_get(struct phy_device *phydev,
@@ -65,4 +96,15 @@ static inline int phy_hwtstamp_set(struct phy_device *phydev,
 	return -EOPNOTSUPP;
 }
 
+static inline void phy_ethtool_get_phy_stats(struct phy_device *phydev,
+					struct ethtool_eth_phy_stats *phy_stats,
+					struct ethtool_phy_stats *phydev_stats)
+{
+}
+
+static inline void phy_ethtool_get_link_ext_stats(struct phy_device *phydev,
+				    struct ethtool_link_ext_stats *link_stats)
+{
+}
+
 #endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 949b53e0accf..376478d29e2d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1686,7 +1686,7 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF__HOLE__00010000	0x00010000
+#define PF_KCOMPACTD		0x00010000	/* I am kcompactd */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0e6e16eb2d10..43a44a6e243b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11896,6 +11896,8 @@ void perf_pmu_unregister(struct pmu *pmu)
 {
 	mutex_lock(&pmus_lock);
 	list_del_rcu(&pmu->entry);
+	idr_remove(&pmu_idr, pmu->type);
+	mutex_unlock(&pmus_lock);
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
@@ -11905,7 +11907,6 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	idr_remove(&pmu_idr, pmu->type);
 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -11913,7 +11914,6 @@ void perf_pmu_unregister(struct pmu *pmu)
 		put_device(pmu->dev);
 	}
 	free_pmu_context(pmu);
-	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7d0a05660e5e..4f850edf1640 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4046,15 +4046,17 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
 {
 	struct cfs_rq *prev_cfs_rq;
 	struct list_head *prev;
+	struct rq *rq = rq_of(cfs_rq);
 
 	if (cfs_rq->on_list) {
 		prev = cfs_rq->leaf_cfs_rq_list.prev;
 	} else {
-		struct rq *rq = rq_of(cfs_rq);
-
 		prev = rq->tmp_alone_branch;
 	}
 
+	if (prev == &rq->leaf_cfs_rq_list)
+		return false;
+
 	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
 
 	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index c62d1629cffe..99048c330382 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1018,6 +1018,19 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 	if (*is_return)
 		return 0;
 
+	if (is_tracepoint) {
+		tmp = *symbol;
+		while (*tmp && (isalnum(*tmp) || *tmp == '_'))
+			tmp++;
+		if (*tmp) {
+			/* find a wrong character. */
+			trace_probe_log_err(tmp - *symbol, BAD_TP_NAME);
+			kfree(*symbol);
+			*symbol = NULL;
+			return -EINVAL;
+		}
+	}
+
 	/* If there is $retval, this should be a return fprobe. */
 	for (i = 2; i < argc; i++) {
 		tmp = strstr(argv[i], "$retval");
@@ -1025,6 +1038,8 @@ static int parse_symbol_and_return(int argc, const char *argv[],
 			if (is_tracepoint) {
 				trace_probe_log_set_index(i);
 				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
+				kfree(*symbol);
+				*symbol = NULL;
 				return -EINVAL;
 			}
 			*is_return = true;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 5803e6a41570..8a6797c2278d 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -36,7 +36,6 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
-#define MAX_ARG_BUF_LEN		(MAX_TRACE_ARGS * MAX_ARG_NAME_LEN)
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -481,6 +480,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(NON_UNIQ_SYMBOL,	"The symbol is not unique"),		\
 	C(BAD_RETPROBE,		"Retprobe address must be an function entry"), \
 	C(NO_TRACEPOINT,	"Tracepoint is not found"),		\
+	C(BAD_TP_NAME,		"Invalid character in tracepoint name"),\
 	C(BAD_ADDR_SUFFIX,	"Invalid probed address suffix"), \
 	C(NO_GROUP_NAME,	"Group name is not specified"),		\
 	C(GROUP_TOO_LONG,	"Group name is too long"),		\
diff --git a/mm/compaction.c b/mm/compaction.c
index 384e4672998e..77dbb9022b47 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -3164,6 +3164,7 @@ static int kcompactd(void *p)
 	if (!cpumask_empty(cpumask))
 		set_cpus_allowed_ptr(tsk, cpumask);
 
+	current->flags |= PF_KCOMPACTD;
 	set_freezable();
 
 	pgdat->kcompactd_max_order = 0;
@@ -3220,6 +3221,8 @@ static int kcompactd(void *p)
 			pgdat->proactive_compact_trigger = false;
 	}
 
+	current->flags &= ~PF_KCOMPACTD;
+
 	return 0;
 }
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b2294dc1dd6e..15ae955c7cbc 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5402,7 +5402,7 @@ static void move_huge_pte(struct vm_area_struct *vma, unsigned long old_addr,
 	if (src_ptl != dst_ptl)
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 
-	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte);
+	pte = huge_ptep_get_and_clear(mm, old_addr, src_pte, sz);
 
 	if (need_clear_uffd_wp && pte_marker_uffd_wp(pte))
 		huge_pte_clear(mm, new_addr, dst_pte, sz);
@@ -5577,7 +5577,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			set_vma_resv_flags(vma, HPAGE_RESV_UNMAPPED);
 		}
 
-		pte = huge_ptep_get_and_clear(mm, address, ptep);
+		pte = huge_ptep_get_and_clear(mm, address, ptep, sz);
 		tlb_remove_huge_tlb_entry(h, tlb, ptep, address);
 		if (huge_pte_dirty(pte))
 			set_page_dirty(page);
diff --git a/mm/internal.h b/mm/internal.h
index 9826f7dce607..c9186ca8d7c2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1102,7 +1102,7 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
  * mm/memory-failure.c
  */
 #ifdef CONFIG_MEMORY_FAILURE
-void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu);
+int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill);
 void shake_folio(struct folio *folio);
 extern int hwpoison_filter(struct page *p);
 
@@ -1125,8 +1125,9 @@ unsigned long page_mapped_in_vma(const struct page *page,
 		struct vm_area_struct *vma);
 
 #else
-static inline void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
+static inline int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
 {
+	return -EBUSY;
 }
 #endif
 
diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
index 3ea50f09311f..3df45c25c1f6 100644
--- a/mm/kmsan/hooks.c
+++ b/mm/kmsan/hooks.c
@@ -357,6 +357,7 @@ void kmsan_handle_dma(struct page *page, size_t offset, size_t size,
 		size -= to_go;
 	}
 }
+EXPORT_SYMBOL_GPL(kmsan_handle_dma);
 
 void kmsan_handle_dma_sg(struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a7b8ccd29b6f..38bdffb45648 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1556,11 +1556,35 @@ static int get_hwpoison_page(struct page *p, unsigned long flags)
 	return ret;
 }
 
-void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
+int unmap_poisoned_folio(struct folio *folio, unsigned long pfn, bool must_kill)
 {
-	if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
-		struct address_space *mapping;
+	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
+	struct address_space *mapping;
+
+	if (folio_test_swapcache(folio)) {
+		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
+		ttu &= ~TTU_HWPOISON;
+	}
 
+	/*
+	 * Propagate the dirty bit from PTEs to struct page first, because we
+	 * need this to decide if we should kill or just drop the page.
+	 * XXX: the dirty test could be racy: set_page_dirty() may not always
+	 * be called inside page lock (it's recommended but not enforced).
+	 */
+	mapping = folio_mapping(folio);
+	if (!must_kill && !folio_test_dirty(folio) && mapping &&
+	    mapping_can_writeback(mapping)) {
+		if (folio_mkclean(folio)) {
+			folio_set_dirty(folio);
+		} else {
+			ttu &= ~TTU_HWPOISON;
+			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
+				pfn);
+		}
+	}
+
+	if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
 		/*
 		 * For hugetlb folios in shared mappings, try_to_unmap
 		 * could potentially call huge_pmd_unshare.  Because of
@@ -1572,7 +1596,7 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 		if (!mapping) {
 			pr_info("%#lx: could not lock mapping for mapped hugetlb folio\n",
 				folio_pfn(folio));
-			return;
+			return -EBUSY;
 		}
 
 		try_to_unmap(folio, ttu|TTU_RMAP_LOCKED);
@@ -1580,6 +1604,8 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 	} else {
 		try_to_unmap(folio, ttu);
 	}
+
+	return folio_mapped(folio) ? -EBUSY : 0;
 }
 
 /*
@@ -1589,8 +1615,6 @@ void unmap_poisoned_folio(struct folio *folio, enum ttu_flags ttu)
 static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 		unsigned long pfn, int flags)
 {
-	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_SYNC | TTU_HWPOISON;
-	struct address_space *mapping;
 	LIST_HEAD(tokill);
 	bool unmap_success;
 	int forcekill;
@@ -1613,29 +1637,6 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	if (!folio_mapped(folio))
 		return true;
 
-	if (folio_test_swapcache(folio)) {
-		pr_err("%#lx: keeping poisoned page in swap cache\n", pfn);
-		ttu &= ~TTU_HWPOISON;
-	}
-
-	/*
-	 * Propagate the dirty bit from PTEs to struct page first, because we
-	 * need this to decide if we should kill or just drop the page.
-	 * XXX: the dirty test could be racy: set_page_dirty() may not always
-	 * be called inside page lock (it's recommended but not enforced).
-	 */
-	mapping = folio_mapping(folio);
-	if (!(flags & MF_MUST_KILL) && !folio_test_dirty(folio) && mapping &&
-	    mapping_can_writeback(mapping)) {
-		if (folio_mkclean(folio)) {
-			folio_set_dirty(folio);
-		} else {
-			ttu &= ~TTU_HWPOISON;
-			pr_info("%#lx: corrupted page was clean: dropped without side effects\n",
-				pfn);
-		}
-	}
-
 	/*
 	 * First collect all the processes that have the page
 	 * mapped in dirty form.  This has to be done before try_to_unmap,
@@ -1643,9 +1644,7 @@ static bool hwpoison_user_mappings(struct folio *folio, struct page *p,
 	 */
 	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
 
-	unmap_poisoned_folio(folio, ttu);
-
-	unmap_success = !folio_mapped(folio);
+	unmap_success = !unmap_poisoned_folio(folio, pfn, flags & MF_MUST_KILL);
 	if (!unmap_success)
 		pr_err("%#lx: failed to unmap page (folio mapcount=%d)\n",
 		       pfn, folio_mapcount(folio));
diff --git a/mm/memory.c b/mm/memory.c
index 398c031be9ba..b6015e230822 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2971,8 +2971,10 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(*pgd) && !create)
 			continue;
-		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
-			return -EINVAL;
+		if (WARN_ON_ONCE(pgd_leaf(*pgd))) {
+			err = -EINVAL;
+			break;
+		}
 		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
 			if (!create)
 				continue;
@@ -5102,7 +5104,11 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
 		      !(vma->vm_flags & VM_SHARED);
 	int type, nr_pages;
-	unsigned long addr = vmf->address;
+	unsigned long addr;
+	bool needs_fallback = false;
+
+fallback:
+	addr = vmf->address;
 
 	/* Did we COW the page? */
 	if (is_cow)
@@ -5141,7 +5147,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	 * approach also applies to non-anonymous-shmem faults to avoid
 	 * inflating the RSS of the process.
 	 */
-	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
+	if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma)) ||
+	    unlikely(needs_fallback)) {
 		nr_pages = 1;
 	} else if (nr_pages > 1) {
 		pgoff_t idx = folio_page_idx(folio, page);
@@ -5177,9 +5184,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
-		ret = VM_FAULT_NOPAGE;
-		goto unlock;
+		needs_fallback = true;
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		goto fallback;
 	}
 
 	folio_ref_add(folio, nr_pages - 1);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c43b4e7fb298..c3de35389269 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1795,26 +1795,24 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 		if (folio_test_large(folio))
 			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
 
-		/*
-		 * HWPoison pages have elevated reference counts so the migration would
-		 * fail on them. It also doesn't make any sense to migrate them in the
-		 * first place. Still try to unmap such a page in case it is still mapped
-		 * (keep the unmap as the catch all safety net).
-		 */
+		if (!folio_try_get(folio))
+			continue;
+
+		if (unlikely(page_folio(page) != folio))
+			goto put_folio;
+
 		if (folio_test_hwpoison(folio) ||
 		    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio))) {
 			if (WARN_ON(folio_test_lru(folio)))
 				folio_isolate_lru(folio);
-			if (folio_mapped(folio))
-				unmap_poisoned_folio(folio, TTU_IGNORE_MLOCK);
-			continue;
-		}
-
-		if (!folio_try_get(folio))
-			continue;
+			if (folio_mapped(folio)) {
+				folio_lock(folio);
+				unmap_poisoned_folio(folio, pfn, false);
+				folio_unlock(folio);
+			}
 
-		if (unlikely(page_folio(page) != folio))
 			goto put_folio;
+		}
 
 		if (!isolate_folio_to_list(folio, &source)) {
 			if (__ratelimit(&migrate_rs)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 01eab25edf89..0f9b359d67bb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4243,6 +4243,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 restart:
 	compaction_retries = 0;
 	no_progress_loops = 0;
+	compact_result = COMPACT_SKIPPED;
 	compact_priority = DEF_COMPACT_PRIORITY;
 	cpuset_mems_cookie = read_mems_allowed_begin();
 	zonelist_iter_cookie = zonelist_iter_begin();
@@ -5858,11 +5859,10 @@ static void setup_per_zone_lowmem_reserve(void)
 
 			for (j = i + 1; j < MAX_NR_ZONES; j++) {
 				struct zone *upper_zone = &pgdat->node_zones[j];
-				bool empty = !zone_managed_pages(upper_zone);
 
 				managed_pages += zone_managed_pages(upper_zone);
 
-				if (clear || empty)
+				if (clear)
 					zone->lowmem_reserve[j] = 0;
 				else
 					zone->lowmem_reserve[j] = managed_pages / ratio;
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 60a0be33766f..64e998f7d57c 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1224,6 +1224,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		 */
 		if (!src_folio) {
 			struct folio *folio;
+			bool locked;
 
 			/*
 			 * Pin the page while holding the lock to be sure the
@@ -1243,12 +1244,26 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 				goto out;
 			}
 
+			locked = folio_trylock(folio);
+			/*
+			 * We avoid waiting for folio lock with a raised
+			 * refcount for large folios because extra refcounts
+			 * will result in split_folio() failing later and
+			 * retrying.  If multiple tasks are trying to move a
+			 * large folio we can end up livelocking.
+			 */
+			if (!locked && folio_test_large(folio)) {
+				spin_unlock(src_ptl);
+				err = -EAGAIN;
+				goto out;
+			}
+
 			folio_get(folio);
 			src_folio = folio;
 			src_folio_pte = orig_src_pte;
 			spin_unlock(src_ptl);
 
-			if (!folio_trylock(src_folio)) {
+			if (!locked) {
 				pte_unmap(&orig_src_pte);
 				pte_unmap(&orig_dst_pte);
 				src_pte = dst_pte = NULL;
diff --git a/mm/vma.c b/mm/vma.c
index bb2119e5a0d0..b126683397fc 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1508,24 +1508,28 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 {
 	struct vm_area_struct *vma = vmg->vma;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
 	struct vm_area_struct *merged;
 
 	/* First, try to merge. */
 	merged = vma_merge_existing_range(vmg);
 	if (merged)
 		return merged;
+	if (vmg_nomem(vmg))
+		return ERR_PTR(-ENOMEM);
 
 	/* Split any preceding portion of the VMA. */
-	if (vma->vm_start < vmg->start) {
-		int err = split_vma(vmg->vmi, vma, vmg->start, 1);
+	if (vma->vm_start < start) {
+		int err = split_vma(vmg->vmi, vma, start, 1);
 
 		if (err)
 			return ERR_PTR(err);
 	}
 
 	/* Split any trailing portion of the VMA. */
-	if (vma->vm_end > vmg->end) {
-		int err = split_vma(vmg->vmi, vma, vmg->end, 0);
+	if (vma->vm_end > end) {
+		int err = split_vma(vmg->vmi, vma, end, 0);
 
 		if (err)
 			return ERR_PTR(err);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5c88d0e90c20..b6e8e39af653 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -586,13 +586,13 @@ static int vmap_small_pages_range_noflush(unsigned long addr, unsigned long end,
 			mask |= PGTBL_PGD_MODIFIED;
 		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
-			return err;
+			break;
 	} while (pgd++, addr = next, addr != end);
 
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
-	return 0;
+	return err;
 }
 
 /*
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index e45187b88220..41be38264493 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -131,7 +131,8 @@ int vlan_check_real_dev(struct net_device *real_dev,
 {
 	const char *name = real_dev->name;
 
-	if (real_dev->features & NETIF_F_VLAN_CHALLENGED) {
+	if (real_dev->features & NETIF_F_VLAN_CHALLENGED ||
+	    real_dev->type != ARPHRD_ETHER) {
 		pr_info("VLANs not supported on %s\n", name);
 		NL_SET_ERR_MSG_MOD(extack, "VLANs not supported on device");
 		return -EOPNOTSUPP;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 71dda10f6a24..aa8b0df41291 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9791,6 +9791,9 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 				     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0) +
 				     eir_precalc_len(sizeof(conn->dev_class)));
 
+	if (!skb)
+		return;
+
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, &conn->dst);
 	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
@@ -10544,6 +10547,8 @@ void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 
 	skb = mgmt_alloc_skb(hdev, MGMT_EV_DEVICE_FOUND,
 			     sizeof(*ev) + (name ? eir_precalc_len(name_len) : 0));
+	if (!skb)
+		return;
 
 	ev = skb_put(skb, sizeof(*ev));
 	bacpy(&ev->addr.bdaddr, bdaddr);
diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index f22051f33868..84096f6b0236 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -72,8 +72,8 @@ int ethnl_act_cable_test(struct sk_buff *skb, struct genl_info *info)
 	dev = req_info.dev;
 
 	rtnl_lock();
-	phydev = ethnl_req_get_phydev(&req_info,
-				      tb[ETHTOOL_A_CABLE_TEST_HEADER],
+	phydev = ethnl_req_get_phydev(&req_info, tb,
+				      ETHTOOL_A_CABLE_TEST_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
@@ -339,8 +339,8 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 		goto out_dev_put;
 
 	rtnl_lock();
-	phydev = ethnl_req_get_phydev(&req_info,
-				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
+	phydev = ethnl_req_get_phydev(&req_info, tb,
+				      ETHTOOL_A_CABLE_TEST_TDR_HEADER,
 				      info->extack);
 	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 34d76e87847d..05a5f72c99fa 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -3,6 +3,7 @@
 #include "netlink.h"
 #include "common.h"
 #include <linux/phy.h>
+#include <linux/phylib_stubs.h>
 
 struct linkstate_req_info {
 	struct ethnl_req_info		base;
@@ -26,9 +27,8 @@ const struct nla_policy ethnl_linkstate_get_policy[] = {
 		NLA_POLICY_NESTED(ethnl_header_policy_stats),
 };
 
-static int linkstate_get_sqi(struct net_device *dev)
+static int linkstate_get_sqi(struct phy_device *phydev)
 {
-	struct phy_device *phydev = dev->phydev;
 	int ret;
 
 	if (!phydev)
@@ -46,9 +46,8 @@ static int linkstate_get_sqi(struct net_device *dev)
 	return ret;
 }
 
-static int linkstate_get_sqi_max(struct net_device *dev)
+static int linkstate_get_sqi_max(struct phy_device *phydev)
 {
-	struct phy_device *phydev = dev->phydev;
 	int ret;
 
 	if (!phydev)
@@ -100,19 +99,28 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct linkstate_reply_data *data = LINKSTATE_REPDATA(reply_base);
 	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_LINKSTATE_HEADER,
+				      info->extack);
+	if (IS_ERR(phydev)) {
+		ret = PTR_ERR(phydev);
+		goto out;
+	}
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
 	data->link = __ethtool_get_link(dev);
 
-	ret = linkstate_get_sqi(dev);
+	ret = linkstate_get_sqi(phydev);
 	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi = ret;
 
-	ret = linkstate_get_sqi_max(dev);
+	ret = linkstate_get_sqi_max(phydev);
 	if (linkstate_sqi_critical_error(ret))
 		goto out;
 	data->sqi_max = ret;
@@ -127,9 +135,9 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 			   sizeof(data->link_stats) / 8);
 
 	if (req_base->flags & ETHTOOL_FLAG_STATS) {
-		if (dev->phydev)
-			data->link_stats.link_down_events =
-				READ_ONCE(dev->phydev->link_down_events);
+		if (phydev)
+			phy_ethtool_get_link_ext_stats(phydev,
+						       &data->link_stats);
 
 		if (dev->ethtool_ops->get_link_ext_stats)
 			dev->ethtool_ops->get_link_ext_stats(dev,
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 4d18dc29b304..e233dfc8ca4b 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -210,7 +210,7 @@ int ethnl_parse_header_dev_get(struct ethnl_req_info *req_info,
 }
 
 struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
-					const struct nlattr *header,
+					struct nlattr **tb, unsigned int header,
 					struct netlink_ext_ack *extack)
 {
 	struct phy_device *phydev;
@@ -224,8 +224,8 @@ struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
 		return req_info->dev->phydev;
 
 	phydev = phy_link_topo_get_phy(req_info->dev, req_info->phy_index);
-	if (!phydev) {
-		NL_SET_ERR_MSG_ATTR(extack, header,
+	if (!phydev && tb) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[header],
 				    "no phy matching phyindex");
 		return ERR_PTR(-ENODEV);
 	}
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 203b08eb6c6f..5e176938d6d2 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -275,7 +275,8 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
  * ethnl_req_get_phydev() - Gets the phy_device targeted by this request,
  *			    if any. Must be called under rntl_lock().
  * @req_info:	The ethnl request to get the phy from.
- * @header:	The netlink header, used for error reporting.
+ * @tb:		The netlink attributes array, for error reporting.
+ * @header:	The netlink header index, used for error reporting.
  * @extack:	The netlink extended ACK, for error reporting.
  *
  * The caller must hold RTNL, until it's done interacting with the returned
@@ -289,7 +290,7 @@ static inline void ethnl_parse_header_dev_put(struct ethnl_req_info *req_info)
  *	   is returned.
  */
 struct phy_device *ethnl_req_get_phydev(const struct ethnl_req_info *req_info,
-					const struct nlattr *header,
+					struct nlattr **tb, unsigned int header,
 					struct netlink_ext_ack *extack);
 
 /**
diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index ed8f690f6bac..e067cc234419 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -125,7 +125,7 @@ static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
 	struct phy_req_info *req_info = PHY_REQINFO(req_base);
 	struct phy_device *phydev;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PHY_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PHY_HEADER,
 				      extack);
 	if (!phydev)
 		return 0;
diff --git a/net/ethtool/plca.c b/net/ethtool/plca.c
index d95d92f173a6..e1f7820a6158 100644
--- a/net/ethtool/plca.c
+++ b/net/ethtool/plca.c
@@ -62,7 +62,7 @@ static int plca_get_cfg_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev)) {
@@ -152,7 +152,7 @@ ethnl_set_plca(struct ethnl_req_info *req_info, struct genl_info *info)
 	bool mod = false;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev))
@@ -211,7 +211,7 @@ static int plca_get_status_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PLCA_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PLCA_HEADER,
 				      info->extack);
 	// check that the PHY device is available and connected
 	if (IS_ERR_OR_NULL(phydev)) {
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index a0705edca22a..71843de832cc 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -64,7 +64,7 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	if (ret < 0)
 		return ret;
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_PSE_HEADER],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
 		return -ENODEV;
@@ -261,7 +261,7 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	struct phy_device *phydev;
 	int ret;
 
-	phydev = ethnl_req_get_phydev(req_info, tb[ETHTOOL_A_PSE_HEADER],
+	phydev = ethnl_req_get_phydev(req_info, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	ret = ethnl_set_pse_validate(phydev, info);
 	if (ret)
diff --git a/net/ethtool/stats.c b/net/ethtool/stats.c
index 912f0c4fff2f..273ae4ff343f 100644
--- a/net/ethtool/stats.c
+++ b/net/ethtool/stats.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/phy.h>
+#include <linux/phylib_stubs.h>
+
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
@@ -20,6 +23,7 @@ struct stats_reply_data {
 		struct ethtool_eth_mac_stats	mac_stats;
 		struct ethtool_eth_ctrl_stats	ctrl_stats;
 		struct ethtool_rmon_stats	rmon_stats;
+		struct ethtool_phy_stats	phydev_stats;
 	);
 	const struct ethtool_rmon_hist_range	*rmon_ranges;
 };
@@ -120,8 +124,15 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	struct stats_reply_data *data = STATS_REPDATA(reply_base);
 	enum ethtool_mac_stats_src src = req_info->src;
 	struct net_device *dev = reply_base->dev;
+	struct nlattr **tb = info->attrs;
+	struct phy_device *phydev;
 	int ret;
 
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_STATS_HEADER,
+				      info->extack);
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
+
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
 		return ret;
@@ -145,6 +156,13 @@ static int stats_prepare_data(const struct ethnl_req_info *req_base,
 	data->ctrl_stats.src = src;
 	data->rmon_stats.src = src;
 
+	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
+	    src == ETHTOOL_MAC_STATS_SRC_AGGREGATE) {
+		if (phydev)
+			phy_ethtool_get_phy_stats(phydev, &data->phy_stats,
+						  &data->phydev_stats);
+	}
+
 	if (test_bit(ETHTOOL_STATS_ETH_PHY, req_info->stat_mask) &&
 	    dev->ethtool_ops->get_eth_phy_stats)
 		dev->ethtool_ops->get_eth_phy_stats(dev, &data->phy_stats);
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index b3382b3cf325..b9400d18f01d 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -299,7 +299,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		return 0;
 	}
 
-	phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_HEADER_FLAGS],
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_HEADER_FLAGS,
 				      info->extack);
 
 	/* phydev can be NULL, check for errors only */
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..2dfac79dc78b 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -13,12 +13,15 @@
 #include <net/tcp.h>
 #include <net/protocol.h>
 
-static void tcp_gso_tstamp(struct sk_buff *skb, unsigned int ts_seq,
+static void tcp_gso_tstamp(struct sk_buff *skb, struct sk_buff *gso_skb,
 			   unsigned int seq, unsigned int mss)
 {
+	u32 flags = skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP;
+	u32 ts_seq = skb_shinfo(gso_skb)->tskey;
+
 	while (skb) {
 		if (before(ts_seq, seq + mss)) {
-			skb_shinfo(skb)->tx_flags |= SKBTX_SW_TSTAMP;
+			skb_shinfo(skb)->tx_flags |= flags;
 			skb_shinfo(skb)->tskey = ts_seq;
 			return;
 		}
@@ -193,8 +196,8 @@ struct sk_buff *tcp_gso_segment(struct sk_buff *skb,
 	th = tcp_hdr(skb);
 	seq = ntohl(th->seq);
 
-	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_SW_TSTAMP))
-		tcp_gso_tstamp(segs, skb_shinfo(gso_skb)->tskey, seq, mss);
+	if (unlikely(skb_shinfo(gso_skb)->tx_flags & SKBTX_ANY_TSTAMP))
+		tcp_gso_tstamp(segs, gso_skb, seq, mss);
 
 	newcheck = ~csum_fold(csum_add(csum_unfold(th->check), delta));
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a5be6e4ed326..ecfca59f31f1 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -321,13 +321,17 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
 	copy_dtor = gso_skb->destructor == sock_wfree;
-	if (copy_dtor)
+	if (copy_dtor) {
 		gso_skb->destructor = NULL;
+		gso_skb->sk = NULL;
+	}
 
 	segs = skb_segment(gso_skb, features);
 	if (IS_ERR_OR_NULL(segs)) {
-		if (copy_dtor)
+		if (copy_dtor) {
 			gso_skb->destructor = sock_wfree;
+			gso_skb->sk = sk;
+		}
 		return segs;
 	}
 
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index ff7e734e335b..7d574f5132e2 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -88,13 +88,15 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected) {
+		/* cache only if we don't create a dst reference loop */
+		if (ilwt->connected && orig_dst->lwtstate != dst->lwtstate) {
 			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
 			local_bh_enable();
 		}
 	}
 
+	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
 	return dst_output(net, sk, skb);
 
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 06fb8e6944b0..7a0cae9a8111 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -24,7 +24,7 @@
 #include <net/llc_s_ac.h>
 #include <net/llc_s_ev.h>
 #include <net/llc_sap.h>
-
+#include <net/sock.h>
 
 /**
  *	llc_sap_action_unitdata_ind - forward UI PDU to network layer
@@ -40,6 +40,26 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 	return 0;
 }
 
+static int llc_prepare_and_xmit(struct sk_buff *skb)
+{
+	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
+	struct sk_buff *nskb;
+	int rc;
+
+	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
+	if (rc)
+		return rc;
+
+	nskb = skb_clone(skb, GFP_ATOMIC);
+	if (!nskb)
+		return -ENOMEM;
+
+	if (skb->sk)
+		skb_set_owner_w(nskb, skb->sk);
+
+	return dev_queue_xmit(nskb);
+}
+
 /**
  *	llc_sap_action_send_ui - sends UI PDU resp to UNITDATA REQ to MAC layer
  *	@sap: SAP
@@ -52,17 +72,12 @@ int llc_sap_action_unitdata_ind(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -77,17 +92,12 @@ int llc_sap_action_send_ui(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_xid_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U_XID, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_xid_cmd(skb, LLC_XID_NULL_CLASS_2, 0);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 /**
@@ -133,17 +143,12 @@ int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
 int llc_sap_action_send_test_c(struct llc_sap *sap, struct sk_buff *skb)
 {
 	struct llc_sap_state_ev *ev = llc_sap_ev(skb);
-	int rc;
 
 	llc_pdu_header_init(skb, LLC_PDU_TYPE_U, ev->saddr.lsap,
 			    ev->daddr.lsap, LLC_PDU_CMD);
 	llc_pdu_init_as_test_cmd(skb);
-	rc = llc_mac_hdr_init(skb, ev->saddr.mac, ev->daddr.mac);
-	if (likely(!rc)) {
-		skb_get(skb);
-		rc = dev_queue_xmit(skb);
-	}
-	return rc;
+
+	return llc_prepare_and_xmit(skb);
 }
 
 int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9f0db39b28ff..c39b813a8199 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1749,6 +1749,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_eht_operation *eht_operation;
 	const struct ieee80211_multi_link_elem *ml_basic;
 	const struct ieee80211_multi_link_elem *ml_reconf;
+	const struct ieee80211_multi_link_elem *ml_epcs;
 	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 	const struct ieee80211_ttlm_elem *ttlm[IEEE80211_TTLM_MAX_CNT];
 
@@ -1779,6 +1780,7 @@ struct ieee802_11_elems {
 	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
 	size_t ml_basic_len;
 	size_t ml_reconf_len;
+	size_t ml_epcs_len;
 
 	u8 ttlm_num;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 61c318f5239f..0e3db0c2920b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4825,6 +4825,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		parse_params.start = bss_ies->data;
 		parse_params.len = bss_ies->len;
 		parse_params.bss = cbss;
+		parse_params.link_id = -1;
 		bss_elems = ieee802_11_parse_elems_full(&parse_params);
 		if (!bss_elems) {
 			ret = false;
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 279c5143b335..6da39c864f45 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -44,6 +44,12 @@ struct ieee80211_elems_parse {
 	/* The reconfiguration Multi-Link element in the original elements */
 	const struct element *ml_reconf_elem;
 
+	/* The EPCS Multi-Link element in the original elements */
+	const struct element *ml_epcs_elem;
+
+	bool multi_link_inner;
+	bool skip_vendor;
+
 	/*
 	 * scratch buffer that can be used for various element parsing related
 	 * tasks, e.g., element de-fragmentation etc.
@@ -149,16 +155,18 @@ ieee80211_parse_extension_element(u32 *crc,
 			switch (le16_get_bits(mle->control,
 					      IEEE80211_ML_CONTROL_TYPE)) {
 			case IEEE80211_ML_CONTROL_TYPE_BASIC:
-				if (elems_parse->ml_basic_elem) {
+				if (elems_parse->multi_link_inner) {
 					elems->parse_error |=
 						IEEE80211_PARSE_ERR_DUP_NEST_ML_BASIC;
 					break;
 				}
-				elems_parse->ml_basic_elem = elem;
 				break;
 			case IEEE80211_ML_CONTROL_TYPE_RECONF:
 				elems_parse->ml_reconf_elem = elem;
 				break;
+			case IEEE80211_ML_CONTROL_TYPE_PRIO_ACCESS:
+				elems_parse->ml_epcs_elem = elem;
+				break;
 			default:
 				break;
 			}
@@ -393,6 +401,9 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
 			break;
 		case WLAN_EID_VENDOR_SPECIFIC:
+			if (elems_parse->skip_vendor)
+				break;
+
 			if (elen >= 4 && pos[0] == 0x00 && pos[1] == 0x50 &&
 			    pos[2] == 0xf2) {
 				/* Microsoft OUI (00:50:F2) */
@@ -860,21 +871,36 @@ ieee80211_mle_get_sta_prof(struct ieee80211_elems_parse *elems_parse,
 	}
 }
 
-static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
-				     struct ieee80211_elems_parse_params *params)
+static const struct element *
+ieee80211_prep_mle_link_parse(struct ieee80211_elems_parse *elems_parse,
+			      struct ieee80211_elems_parse_params *params,
+			      struct ieee80211_elems_parse_params *sub)
 {
 	struct ieee802_11_elems *elems = &elems_parse->elems;
 	struct ieee80211_mle_per_sta_profile *prof;
-	struct ieee80211_elems_parse_params sub = {
-		.mode = params->mode,
-		.action = params->action,
-		.from_ap = params->from_ap,
-		.link_id = -1,
-	};
-	ssize_t ml_len = elems->ml_basic_len;
-	const struct element *non_inherit = NULL;
+	const struct element *tmp;
+	ssize_t ml_len;
 	const u8 *end;
 
+	if (params->mode < IEEE80211_CONN_MODE_EHT)
+		return NULL;
+
+	for_each_element_extid(tmp, WLAN_EID_EXT_EHT_MULTI_LINK,
+			       elems->ie_start, elems->total_len) {
+		const struct ieee80211_multi_link_elem *mle =
+			(void *)tmp->data + 1;
+
+		if (!ieee80211_mle_size_ok(tmp->data + 1, tmp->datalen - 1))
+			continue;
+
+		if (le16_get_bits(mle->control, IEEE80211_ML_CONTROL_TYPE) !=
+		    IEEE80211_ML_CONTROL_TYPE_BASIC)
+			continue;
+
+		elems_parse->ml_basic_elem = tmp;
+		break;
+	}
+
 	ml_len = cfg80211_defragment_element(elems_parse->ml_basic_elem,
 					     elems->ie_start,
 					     elems->total_len,
@@ -885,26 +911,26 @@ static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 					     WLAN_EID_FRAGMENT);
 
 	if (ml_len < 0)
-		return;
+		return NULL;
 
 	elems->ml_basic = (const void *)elems_parse->scratch_pos;
 	elems->ml_basic_len = ml_len;
 	elems_parse->scratch_pos += ml_len;
 
 	if (params->link_id == -1)
-		return;
+		return NULL;
 
 	ieee80211_mle_get_sta_prof(elems_parse, params->link_id);
 	prof = elems->prof;
 
 	if (!prof)
-		return;
+		return NULL;
 
 	/* check if we have the 4 bytes for the fixed part in assoc response */
 	if (elems->sta_prof_len < sizeof(*prof) + prof->sta_info_len - 1 + 4) {
 		elems->prof = NULL;
 		elems->sta_prof_len = 0;
-		return;
+		return NULL;
 	}
 
 	/*
@@ -913,13 +939,17 @@ static void ieee80211_mle_parse_link(struct ieee80211_elems_parse *elems_parse,
 	 * the -1 is because the 'sta_info_len' is accounted to as part of the
 	 * per-STA profile, but not part of the 'u8 variable[]' portion.
 	 */
-	sub.start = prof->variable + prof->sta_info_len - 1 + 4;
+	sub->start = prof->variable + prof->sta_info_len - 1 + 4;
 	end = (const u8 *)prof + elems->sta_prof_len;
-	sub.len = end - sub.start;
+	sub->len = end - sub->start;
+
+	sub->mode = params->mode;
+	sub->action = params->action;
+	sub->from_ap = params->from_ap;
+	sub->link_id = -1;
 
-	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-					     sub.start, sub.len);
-	_ieee802_11_parse_elems_full(&sub, elems_parse, non_inherit);
+	return cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+				      sub->start, sub->len);
 }
 
 static void
@@ -943,18 +973,43 @@ ieee80211_mle_defrag_reconf(struct ieee80211_elems_parse *elems_parse)
 	elems_parse->scratch_pos += ml_len;
 }
 
+static void
+ieee80211_mle_defrag_epcs(struct ieee80211_elems_parse *elems_parse)
+{
+	struct ieee802_11_elems *elems = &elems_parse->elems;
+	ssize_t ml_len;
+
+	ml_len = cfg80211_defragment_element(elems_parse->ml_epcs_elem,
+					     elems->ie_start,
+					     elems->total_len,
+					     elems_parse->scratch_pos,
+					     elems_parse->scratch +
+						elems_parse->scratch_len -
+						elems_parse->scratch_pos,
+					     WLAN_EID_FRAGMENT);
+	if (ml_len < 0)
+		return;
+	elems->ml_epcs = (void *)elems_parse->scratch_pos;
+	elems->ml_epcs_len = ml_len;
+	elems_parse->scratch_pos += ml_len;
+}
+
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
+	struct ieee80211_elems_parse_params sub = {};
 	struct ieee80211_elems_parse *elems_parse;
-	struct ieee802_11_elems *elems;
 	const struct element *non_inherit = NULL;
-	u8 *nontransmitted_profile;
-	int nontransmitted_profile_len = 0;
+	struct ieee802_11_elems *elems;
 	size_t scratch_len = 3 * params->len;
+	bool multi_link_inner = false;
 
 	BUILD_BUG_ON(offsetof(typeof(*elems_parse), elems) != 0);
 
+	/* cannot parse for both a specific link and non-transmitted BSS */
+	if (WARN_ON(params->link_id >= 0 && params->bss))
+		return NULL;
+
 	elems_parse = kzalloc(struct_size(elems_parse, scratch, scratch_len),
 			      GFP_ATOMIC);
 	if (!elems_parse)
@@ -971,36 +1026,55 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	ieee80211_clear_tpe(&elems->tpe);
 	ieee80211_clear_tpe(&elems->csa_tpe);
 
-	nontransmitted_profile = elems_parse->scratch_pos;
-	nontransmitted_profile_len =
-		ieee802_11_find_bssid_profile(params->start, params->len,
-					      elems, params->bss,
-					      nontransmitted_profile);
-	elems_parse->scratch_pos += nontransmitted_profile_len;
-	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
-					     nontransmitted_profile,
-					     nontransmitted_profile_len);
+	/*
+	 * If we're looking for a non-transmitted BSS then we cannot at
+	 * the same time be looking for a second link as the two can only
+	 * appear in the same frame carrying info for different BSSes.
+	 *
+	 * In any case, we only look for one at a time, as encoded by
+	 * the WARN_ON above.
+	 */
+	if (params->bss) {
+		int nontx_len =
+			ieee802_11_find_bssid_profile(params->start,
+						      params->len,
+						      elems, params->bss,
+						      elems_parse->scratch_pos);
+		sub.start = elems_parse->scratch_pos;
+		sub.mode = params->mode;
+		sub.len = nontx_len;
+		sub.action = params->action;
+		sub.link_id = params->link_id;
+
+		/* consume the space used for non-transmitted profile */
+		elems_parse->scratch_pos += nontx_len;
+
+		non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+						     sub.start, nontx_len);
+	} else {
+		/* must always parse to get elems_parse->ml_basic_elem */
+		non_inherit = ieee80211_prep_mle_link_parse(elems_parse, params,
+							    &sub);
+		multi_link_inner = true;
+	}
 
+	elems_parse->skip_vendor =
+		cfg80211_find_elem(WLAN_EID_VENDOR_SPECIFIC,
+				   sub.start, sub.len);
 	elems->crc = _ieee802_11_parse_elems_full(params, elems_parse,
 						  non_inherit);
 
-	/* Override with nontransmitted profile, if found */
-	if (nontransmitted_profile_len) {
-		struct ieee80211_elems_parse_params sub = {
-			.mode = params->mode,
-			.start = nontransmitted_profile,
-			.len = nontransmitted_profile_len,
-			.action = params->action,
-			.link_id = params->link_id,
-		};
-
+	/* Override with nontransmitted/per-STA profile if found */
+	if (sub.len) {
+		elems_parse->multi_link_inner = multi_link_inner;
+		elems_parse->skip_vendor = false;
 		_ieee802_11_parse_elems_full(&sub, elems_parse, NULL);
 	}
 
-	ieee80211_mle_parse_link(elems_parse, params);
-
 	ieee80211_mle_defrag_reconf(elems_parse);
 
+	ieee80211_mle_defrag_epcs(elems_parse);
+
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2b1982fe1632..3f93ddab9408 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -977,7 +977,7 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 					     struct mptcp_pm_addr_entry *entry,
-					     bool needs_id)
+					     bool needs_id, bool replace)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -1017,6 +1017,17 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 			if (entry->addr.id)
 				goto out;
 
+			/* allow callers that only need to look up the local
+			 * addr's id to skip replacement. This allows them to
+			 * avoid calling synchronize_rcu in the packet recv
+			 * path.
+			 */
+			if (!replace) {
+				kfree(entry);
+				ret = cur->addr.id;
+				goto out;
+			}
+
 			pernet->addrs--;
 			entry->addr.id = cur->addr.id;
 			list_del_rcu(&cur->list);
@@ -1165,7 +1176,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true, false);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1433,7 +1444,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
-						!mptcp_pm_has_addr_attr_id(attr, info));
+						!mptcp_pm_has_addr_attr_id(attr, info),
+						true);
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index dd84fc54fb9b..f65e7441e644 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4221,6 +4221,11 @@ static int parse_monitor_flags(struct nlattr *nla, u32 *mntrflags)
 		if (flags[flag])
 			*mntrflags |= (1<<flag);
 
+	/* cooked monitor mode is incompatible with other modes */
+	if (*mntrflags & MONITOR_FLAG_COOK_FRAMES &&
+	    *mntrflags != MONITOR_FLAG_COOK_FRAMES)
+		return -EOPNOTSUPP;
+
 	*mntrflags |= MONITOR_FLAG_CHANGED;
 
 	return 0;
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 1df65a5a44f7..eec95cb0ab9e 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -407,7 +407,8 @@ static bool is_an_alpha2(const char *alpha2)
 {
 	if (!alpha2)
 		return false;
-	return isalpha(alpha2[0]) && isalpha(alpha2[1]);
+	return isascii(alpha2[0]) && isalpha(alpha2[0]) &&
+	       isascii(alpha2[1]) && isalpha(alpha2[1]);
 }
 
 static bool alpha2_equal(const char *alpha2_x, const char *alpha2_y)
diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index 798c4ae0bded..14806e1997fd 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -174,9 +174,9 @@ pub fn build<T: Operations>(
 ///
 /// # Invariants
 ///
-///  - `gendisk` must always point to an initialized and valid `struct gendisk`.
-///  - `gendisk` was added to the VFS through a call to
-///     `bindings::device_add_disk`.
+/// - `gendisk` must always point to an initialized and valid `struct gendisk`.
+/// - `gendisk` was added to the VFS through a call to
+///   `bindings::device_add_disk`.
 pub struct GenDisk<T: Operations> {
     _tagset: Arc<TagSet<T>>,
     gendisk: *mut bindings::gendisk,
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 9955c4d54e42..b30faf731da7 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -106,7 +106,7 @@ static struct snd_seq_client *clientptr(int clientid)
 	return clienttab[clientid];
 }
 
-struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
+static struct snd_seq_client *client_use_ptr(int clientid, bool load_module)
 {
 	unsigned long flags;
 	struct snd_seq_client *client;
@@ -126,7 +126,7 @@ struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
 	}
 	spin_unlock_irqrestore(&clients_lock, flags);
 #ifdef CONFIG_MODULES
-	if (!in_interrupt()) {
+	if (load_module) {
 		static DECLARE_BITMAP(client_requested, SNDRV_SEQ_GLOBAL_CLIENTS);
 		static DECLARE_BITMAP(card_requested, SNDRV_CARDS);
 
@@ -168,6 +168,20 @@ struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
 	return client;
 }
 
+/* get snd_seq_client object for the given id quickly */
+struct snd_seq_client *snd_seq_client_use_ptr(int clientid)
+{
+	return client_use_ptr(clientid, false);
+}
+
+/* get snd_seq_client object for the given id;
+ * if not found, retry after loading the modules
+ */
+static struct snd_seq_client *client_load_and_use_ptr(int clientid)
+{
+	return client_use_ptr(clientid, IS_ENABLED(CONFIG_MODULES));
+}
+
 /* Take refcount and perform ioctl_mutex lock on the given client;
  * used only for OSS sequencer
  * Unlock via snd_seq_client_ioctl_unlock() below
@@ -176,7 +190,7 @@ bool snd_seq_client_ioctl_lock(int clientid)
 {
 	struct snd_seq_client *client;
 
-	client = snd_seq_client_use_ptr(clientid);
+	client = client_load_and_use_ptr(clientid);
 	if (!client)
 		return false;
 	mutex_lock(&client->ioctl_mutex);
@@ -1195,7 +1209,7 @@ static int snd_seq_ioctl_running_mode(struct snd_seq_client *client, void  *arg)
 	int err = 0;
 
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(info->client);
+	cptr = client_load_and_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
@@ -1257,7 +1271,7 @@ static int snd_seq_ioctl_get_client_info(struct snd_seq_client *client,
 	struct snd_seq_client *cptr;
 
 	/* requested client number */
-	cptr = snd_seq_client_use_ptr(client_info->client);
+	cptr = client_load_and_use_ptr(client_info->client);
 	if (cptr == NULL)
 		return -ENOENT;		/* don't change !!! */
 
@@ -1392,7 +1406,7 @@ static int snd_seq_ioctl_get_port_info(struct snd_seq_client *client, void *arg)
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port;
 
-	cptr = snd_seq_client_use_ptr(info->addr.client);
+	cptr = client_load_and_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
@@ -1496,10 +1510,10 @@ static int snd_seq_ioctl_subscribe_port(struct snd_seq_client *client,
 	struct snd_seq_client *receiver = NULL, *sender = NULL;
 	struct snd_seq_client_port *sport = NULL, *dport = NULL;
 
-	receiver = snd_seq_client_use_ptr(subs->dest.client);
+	receiver = client_load_and_use_ptr(subs->dest.client);
 	if (!receiver)
 		goto __end;
-	sender = snd_seq_client_use_ptr(subs->sender.client);
+	sender = client_load_and_use_ptr(subs->sender.client);
 	if (!sender)
 		goto __end;
 	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
@@ -1864,7 +1878,7 @@ static int snd_seq_ioctl_get_client_pool(struct snd_seq_client *client,
 	struct snd_seq_client_pool *info = arg;
 	struct snd_seq_client *cptr;
 
-	cptr = snd_seq_client_use_ptr(info->client);
+	cptr = client_load_and_use_ptr(info->client);
 	if (cptr == NULL)
 		return -ENOENT;
 	memset(info, 0, sizeof(*info));
@@ -1968,7 +1982,7 @@ static int snd_seq_ioctl_get_subscription(struct snd_seq_client *client,
 	struct snd_seq_client_port *sport = NULL;
 
 	result = -EINVAL;
-	sender = snd_seq_client_use_ptr(subs->sender.client);
+	sender = client_load_and_use_ptr(subs->sender.client);
 	if (!sender)
 		goto __end;
 	sport = snd_seq_port_use_ptr(sender, subs->sender.port);
@@ -1999,7 +2013,7 @@ static int snd_seq_ioctl_query_subs(struct snd_seq_client *client, void *arg)
 	struct list_head *p;
 	int i;
 
-	cptr = snd_seq_client_use_ptr(subs->root.client);
+	cptr = client_load_and_use_ptr(subs->root.client);
 	if (!cptr)
 		goto __end;
 	port = snd_seq_port_use_ptr(cptr, subs->root.port);
@@ -2066,7 +2080,7 @@ static int snd_seq_ioctl_query_next_client(struct snd_seq_client *client,
 	if (info->client < 0)
 		info->client = 0;
 	for (; info->client < SNDRV_SEQ_MAX_CLIENTS; info->client++) {
-		cptr = snd_seq_client_use_ptr(info->client);
+		cptr = client_load_and_use_ptr(info->client);
 		if (cptr)
 			break; /* found */
 	}
@@ -2089,7 +2103,7 @@ static int snd_seq_ioctl_query_next_port(struct snd_seq_client *client,
 	struct snd_seq_client *cptr;
 	struct snd_seq_client_port *port = NULL;
 
-	cptr = snd_seq_client_use_ptr(info->addr.client);
+	cptr = client_load_and_use_ptr(info->addr.client);
 	if (cptr == NULL)
 		return -ENXIO;
 
@@ -2186,7 +2200,7 @@ static int snd_seq_ioctl_client_ump_info(struct snd_seq_client *caller,
 		size = sizeof(struct snd_ump_endpoint_info);
 	else
 		size = sizeof(struct snd_ump_block_info);
-	cptr = snd_seq_client_use_ptr(client);
+	cptr = client_load_and_use_ptr(client);
 	if (!cptr)
 		return -ENOENT;
 
@@ -2458,7 +2472,7 @@ int snd_seq_kernel_client_enqueue(int client, struct snd_seq_event *ev,
 	if (check_event_type_and_length(ev))
 		return -EINVAL;
 
-	cptr = snd_seq_client_use_ptr(client);
+	cptr = client_load_and_use_ptr(client);
 	if (cptr == NULL)
 		return -EINVAL;
 	
@@ -2690,7 +2704,7 @@ void snd_seq_info_clients_read(struct snd_info_entry *entry,
 
 	/* list the client table */
 	for (c = 0; c < SNDRV_SEQ_MAX_CLIENTS; c++) {
-		client = snd_seq_client_use_ptr(c);
+		client = client_load_and_use_ptr(c);
 		if (client == NULL)
 			continue;
 		if (client->type == NO_CLIENT) {
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 68f1eee9e5c9..dbf933c18a82 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -208,6 +208,7 @@ comment "Set to Y if you want auto-loading the side codec driver"
 
 config SND_HDA_CODEC_REALTEK
 	tristate "Build Realtek HD-audio codec support"
+	depends on INPUT
 	select SND_HDA_GENERIC
 	select SND_HDA_GENERIC_LEDS
 	select SND_HDA_SCODEC_COMPONENT
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4a62440adfaf..188b64c0ed75 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2232,6 +2232,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
 	/* KONTRON SinglePC may cause a stall at runtime resume */
 	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
+	/* Dell ALC3271 */
+	SND_PCI_QUIRK(0x1028, 0x0962, "Dell ALC3271", 0),
 	{}
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0ffb7fa1b883..10e9ec74104d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3845,6 +3845,79 @@ static void alc225_shutup(struct hda_codec *codec)
 	}
 }
 
+static void alc222_init(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+	bool hp1_pin_sense, hp2_pin_sense;
+
+	if (!hp_pin)
+		return;
+
+	msleep(30);
+
+	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+	hp2_pin_sense = snd_hda_jack_detect(codec, 0x14);
+
+	if (hp1_pin_sense || hp2_pin_sense) {
+		msleep(2);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		msleep(75);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+		msleep(75);
+	}
+}
+
+static void alc222_shutup(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = alc_get_hp_pin(spec);
+	bool hp1_pin_sense, hp2_pin_sense;
+
+	if (!hp_pin)
+		hp_pin = 0x21;
+
+	hp1_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+	hp2_pin_sense = snd_hda_jack_detect(codec, 0x14);
+
+	if (hp1_pin_sense || hp2_pin_sense) {
+		msleep(2);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+		msleep(75);
+
+		if (hp1_pin_sense)
+			snd_hda_codec_write(codec, hp_pin, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+		if (hp2_pin_sense)
+			snd_hda_codec_write(codec, 0x14, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+		msleep(75);
+	}
+	alc_auto_setup_eapd(codec, false);
+	alc_shutup_pins(codec);
+}
+
 static void alc_default_init(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -4929,7 +5002,6 @@ static void alc298_fixup_samsung_amp_v2_4_amps(struct hda_codec *codec,
 		alc298_samsung_v2_init_amps(codec, 4);
 }
 
-#if IS_REACHABLE(CONFIG_INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
@@ -5038,10 +5110,6 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 		spec->kb_dev = NULL;
 	}
 }
-#else /* INPUT */
-#define alc280_fixup_hp_gpio2_mic_hotkey	NULL
-#define alc233_fixup_lenovo_line2_mic_hotkey	NULL
-#endif /* INPUT */
 
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
@@ -5055,6 +5123,16 @@ static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 	}
 }
 
+static void alc233_fixup_lenovo_low_en_micmute_led(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->micmute_led_polarity = 1;
+	alc233_fixup_lenovo_line2_mic_hotkey(codec, fix, action);
+}
+
 static void alc_hp_mute_disable(struct hda_codec *codec, unsigned int delay)
 {
 	if (delay <= 0)
@@ -7608,6 +7686,7 @@ enum {
 	ALC275_FIXUP_DELL_XPS,
 	ALC293_FIXUP_LENOVO_SPK_NOISE,
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
+	ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED,
 	ALC255_FIXUP_DELL_SPK_NOISE,
 	ALC225_FIXUP_DISABLE_MIC_VREF,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
@@ -7677,7 +7756,6 @@ enum {
 	ALC285_FIXUP_THINKPAD_X1_GEN7,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_ALLY,
-	ALC294_FIXUP_ASUS_ALLY_X,
 	ALC294_FIXUP_ASUS_ALLY_PINS,
 	ALC294_FIXUP_ASUS_ALLY_VERBS,
 	ALC294_FIXUP_ASUS_ALLY_SPEAKER,
@@ -8596,6 +8674,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc233_fixup_lenovo_line2_mic_hotkey,
 	},
+	[ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc233_fixup_lenovo_low_en_micmute_led,
+	},
 	[ALC233_FIXUP_INTEL_NUC8_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic,
@@ -9118,12 +9200,6 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
 	},
-	[ALC294_FIXUP_ASUS_ALLY_X] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = tas2781_fixup_i2c,
-		.chained = true,
-		.chain_id = ALC294_FIXUP_ASUS_ALLY_PINS
-	},
 	[ALC294_FIXUP_ASUS_ALLY_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -10617,7 +10693,6 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1740, "ASUS UX430UA", ALC295_FIXUP_ASUS_DACS),
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x17f3, "ROG Ally NR2301L/X", ALC294_FIXUP_ASUS_ALLY),
-	SND_PCI_QUIRK(0x1043, 0x1eb3, "ROG Ally X RC72LA", ALC294_FIXUP_ASUS_ALLY_X),
 	SND_PCI_QUIRK(0x1043, 0x1863, "ASUS UX6404VI/VV", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x1881, "ASUS Zephyrus S/M", ALC294_FIXUP_ASUS_GX502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
@@ -10884,6 +10959,9 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x17aa, 0x3384, "ThinkCentre M90a PRO", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
+	SND_PCI_QUIRK(0x17aa, 0x3386, "ThinkCentre M90a Gen6", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
+	SND_PCI_QUIRK(0x17aa, 0x3387, "ThinkCentre M70a Gen6", ALC233_FIXUP_LENOVO_L2MH_LOW_ENLED),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	HDA_CODEC_QUIRK(0x17aa, 0x3802, "DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga Pro 9 14IRP8", ALC287_FIXUP_TAS2781_I2C),
@@ -11870,8 +11948,11 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->codec_variant = ALC269_TYPE_ALC300;
 		spec->gen.mixer_nid = 0; /* no loopback on ALC300 */
 		break;
+	case 0x10ec0222:
 	case 0x10ec0623:
 		spec->codec_variant = ALC269_TYPE_ALC623;
+		spec->shutup = alc222_shutup;
+		spec->init_hook = alc222_init;
 		break;
 	case 0x10ec0700:
 	case 0x10ec0701:
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 5f81c68fd42b..5756ff3528a2 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -151,6 +151,12 @@ static int snd_usx2y_card_used[SNDRV_CARDS];
 static void snd_usx2y_card_private_free(struct snd_card *card);
 static void usx2y_unlinkseq(struct snd_usx2y_async_seq *s);
 
+#ifdef USX2Y_NRPACKS_VARIABLE
+int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
+module_param(nrpacks, int, 0444);
+MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
+#endif
+
 /*
  * pipe 4 is used for switching the lamps, setting samplerate, volumes ....
  */
@@ -432,6 +438,11 @@ static int snd_usx2y_probe(struct usb_interface *intf,
 	struct snd_card *card;
 	int err;
 
+#ifdef USX2Y_NRPACKS_VARIABLE
+	if (nrpacks < 0 || nrpacks > USX2Y_NRPACKS_MAX)
+		return -EINVAL;
+#endif
+
 	if (le16_to_cpu(device->descriptor.idVendor) != 0x1604 ||
 	    (le16_to_cpu(device->descriptor.idProduct) != USB_ID_US122 &&
 	     le16_to_cpu(device->descriptor.idProduct) != USB_ID_US224 &&
diff --git a/sound/usb/usx2y/usbusx2y.h b/sound/usb/usx2y/usbusx2y.h
index 391fd7b4ed5e..6a76d04bf1c7 100644
--- a/sound/usb/usx2y/usbusx2y.h
+++ b/sound/usb/usx2y/usbusx2y.h
@@ -7,6 +7,32 @@
 
 #define NRURBS	        2
 
+/* Default value used for nr of packs per urb.
+ * 1 to 4 have been tested ok on uhci.
+ * To use 3 on ohci, you'd need a patch:
+ * look for "0000425-linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz" on
+ * "https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425"
+ *
+ * 1, 2 and 4 work out of the box on ohci, if I recall correctly.
+ * Bigger is safer operation, smaller gives lower latencies.
+ */
+#define USX2Y_NRPACKS 4
+
+#define USX2Y_NRPACKS_MAX 1024
+
+/* If your system works ok with this module's parameter
+ * nrpacks set to 1, you might as well comment
+ * this define out, and thereby produce smaller, faster code.
+ * You'd also set USX2Y_NRPACKS to 1 then.
+ */
+#define USX2Y_NRPACKS_VARIABLE 1
+
+#ifdef USX2Y_NRPACKS_VARIABLE
+extern int nrpacks;
+#define nr_of_packs() nrpacks
+#else
+#define nr_of_packs() USX2Y_NRPACKS
+#endif
 
 #define URBS_ASYNC_SEQ 10
 #define URB_DATA_LEN_ASYNC_SEQ 32
diff --git a/sound/usb/usx2y/usbusx2yaudio.c b/sound/usb/usx2y/usbusx2yaudio.c
index f540f46a0b14..acca8bead82e 100644
--- a/sound/usb/usx2y/usbusx2yaudio.c
+++ b/sound/usb/usx2y/usbusx2yaudio.c
@@ -28,33 +28,6 @@
 #include "usx2y.h"
 #include "usbusx2y.h"
 
-/* Default value used for nr of packs per urb.
- * 1 to 4 have been tested ok on uhci.
- * To use 3 on ohci, you'd need a patch:
- * look for "0000425-linux-2.6.9-rc4-mm1_ohci-hcd.patch.gz" on
- * "https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000425"
- *
- * 1, 2 and 4 work out of the box on ohci, if I recall correctly.
- * Bigger is safer operation, smaller gives lower latencies.
- */
-#define USX2Y_NRPACKS 4
-
-/* If your system works ok with this module's parameter
- * nrpacks set to 1, you might as well comment
- * this define out, and thereby produce smaller, faster code.
- * You'd also set USX2Y_NRPACKS to 1 then.
- */
-#define USX2Y_NRPACKS_VARIABLE 1
-
-#ifdef USX2Y_NRPACKS_VARIABLE
-static int nrpacks = USX2Y_NRPACKS; /* number of packets per urb */
-#define  nr_of_packs() nrpacks
-module_param(nrpacks, int, 0444);
-MODULE_PARM_DESC(nrpacks, "Number of packets per URB.");
-#else
-#define nr_of_packs() USX2Y_NRPACKS
-#endif
-
 static int usx2y_urb_capt_retire(struct snd_usx2y_substream *subs)
 {
 	struct urb	*urb = subs->completed_urb;
diff --git a/tools/testing/selftests/damon/damon_nr_regions.py b/tools/testing/selftests/damon/damon_nr_regions.py
index 2e8a74aff543..58f3291fed12 100755
--- a/tools/testing/selftests/damon/damon_nr_regions.py
+++ b/tools/testing/selftests/damon/damon_nr_regions.py
@@ -65,6 +65,7 @@ def test_nr_regions(real_nr_regions, min_nr_regions, max_nr_regions):
 
     test_name = 'nr_regions test with %d/%d/%d real/min/max nr_regions' % (
             real_nr_regions, min_nr_regions, max_nr_regions)
+    collected_nr_regions.sort()
     if (collected_nr_regions[0] < min_nr_regions or
         collected_nr_regions[-1] > max_nr_regions):
         print('fail %s' % test_name)
@@ -109,6 +110,7 @@ def main():
     attrs = kdamonds.kdamonds[0].contexts[0].monitoring_attrs
     attrs.min_nr_regions = 3
     attrs.max_nr_regions = 7
+    attrs.update_us = 100000
     err = kdamonds.kdamonds[0].commit()
     if err is not None:
         proc.terminate()
diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
index 7d4c6bb2e3cd..57c4937aaed2 100755
--- a/tools/testing/selftests/damon/damos_quota.py
+++ b/tools/testing/selftests/damon/damos_quota.py
@@ -51,16 +51,19 @@ def main():
         nr_quota_exceeds = scheme.stats.qt_exceeds
 
     wss_collected.sort()
+    nr_expected_quota_exceeds = 0
     for wss in wss_collected:
         if wss > sz_quota:
             print('quota is not kept: %s > %s' % (wss, sz_quota))
             print('collected samples are as below')
             print('\n'.join(['%d' % wss for wss in wss_collected]))
             exit(1)
+        if wss == sz_quota:
+            nr_expected_quota_exceeds += 1
 
-    if nr_quota_exceeds < len(wss_collected):
-        print('quota is not always exceeded: %d > %d' %
-              (len(wss_collected), nr_quota_exceeds))
+    if nr_quota_exceeds < nr_expected_quota_exceeds:
+        print('quota is exceeded less than expected: %d < %d' %
+              (nr_quota_exceeds, nr_expected_quota_exceeds))
         exit(1)
 
 if __name__ == '__main__':
diff --git a/tools/testing/selftests/damon/damos_quota_goal.py b/tools/testing/selftests/damon/damos_quota_goal.py
index 18246f3b62f7..f76e0412b564 100755
--- a/tools/testing/selftests/damon/damos_quota_goal.py
+++ b/tools/testing/selftests/damon/damos_quota_goal.py
@@ -63,6 +63,9 @@ def main():
             if last_effective_bytes != 0 else -1.0))
 
         if last_effective_bytes == goal.effective_bytes:
+            # effective quota was already minimum that cannot be more reduced
+            if expect_increase is False and last_effective_bytes == 1:
+                continue
             print('efective bytes not changed: %d' % goal.effective_bytes)
             exit(1)
 
diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index ada9156cc497..c463d1c09c9b 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -15,7 +15,7 @@
 #define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <sys/mman.h>
 #include <errno.h>
 #include <fcntl.h> /* Definition of O_* constants */
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 66b4e111b5a2..b61803e36d1c 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <stdint.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/mman.h>
@@ -369,6 +369,7 @@ static void test_unmerge_discarded(void)
 	munmap(map, size);
 }
 
+#ifdef __NR_userfaultfd
 static void test_unmerge_uffd_wp(void)
 {
 	struct uffdio_writeprotect uffd_writeprotect;
@@ -429,6 +430,7 @@ static void test_unmerge_uffd_wp(void)
 unmap:
 	munmap(map, size);
 }
+#endif
 
 /* Verify that KSM can be enabled / queried with prctl. */
 static void test_prctl(void)
@@ -684,7 +686,9 @@ int main(int argc, char **argv)
 		exit(test_child_ksm());
 	}
 
+#ifdef __NR_userfaultfd
 	tests++;
+#endif
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -696,7 +700,9 @@ int main(int argc, char **argv)
 	test_unmerge();
 	test_unmerge_zero_pages();
 	test_unmerge_discarded();
+#ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
+#endif
 
 	test_prot_none();
 
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 74c911aa3aea..9a0597310a76 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -17,7 +17,7 @@
 
 #include <stdlib.h>
 #include <string.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -28,6 +28,8 @@
 #define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
 #define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
 
+#ifdef __NR_memfd_secret
+
 #define PATTERN	0x55
 
 static const int prot = PROT_READ | PROT_WRITE;
@@ -332,3 +334,13 @@ int main(int argc, char *argv[])
 
 	ksft_finished();
 }
+
+#else /* __NR_memfd_secret */
+
+int main(int argc, char *argv[])
+{
+	printf("skip: skipping memfd_secret test (missing __NR_memfd_secret)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_memfd_secret */
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index 1db134063c38..b8a7efe9204e 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -9,7 +9,7 @@
  */
 #include <fcntl.h>
 #include <signal.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <string.h>
 #include <errno.h>
 #include <stdlib.h>
@@ -265,6 +265,7 @@ static void test_pte_mapped_thp(void)
 	munmap(mmap_mem, mmap_size);
 }
 
+#ifdef __NR_userfaultfd
 static void test_uffdio_copy(void)
 {
 	struct uffdio_register uffdio_register;
@@ -321,6 +322,7 @@ static void test_uffdio_copy(void)
 	munmap(dst, pagesize);
 	free(src);
 }
+#endif /* __NR_userfaultfd */
 
 int main(void)
 {
@@ -333,7 +335,9 @@ int main(void)
 			       thpsize / 1024);
 		tests += 3;
 	}
+#ifdef __NR_userfaultfd
 	tests += 1;
+#endif /* __NR_userfaultfd */
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -363,7 +367,9 @@ int main(void)
 	if (thpsize)
 		test_pte_mapped_thp();
 	/* Placing a fresh page via userfaultfd may set the PTE dirty. */
+#ifdef __NR_userfaultfd
 	test_uffdio_copy();
+#endif /* __NR_userfaultfd */
 
 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/mm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
index 1e5731bab499..4417eaa5cfb7 100644
--- a/tools/testing/selftests/mm/mlock2.h
+++ b/tools/testing/selftests/mm/mlock2.h
@@ -3,7 +3,6 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <asm-generic/unistd.h>
 
 static int mlock2_(void *start, size_t len, int flags)
 {
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 4990f7ab4cb7..4fcecfb7b189 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -42,7 +42,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <asm-generic/unistd.h>
+#include <unistd.h>
 #include <sys/ptrace.h>
 #include <setjmp.h>
 
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 717539eddf98..7ad6ba660c7d 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -673,7 +673,11 @@ int uffd_open_dev(unsigned int flags)
 
 int uffd_open_sys(unsigned int flags)
 {
+#ifdef __NR_userfaultfd
 	return syscall(__NR_userfaultfd, flags);
+#else
+	return -1;
+#endif
 }
 
 int uffd_open(unsigned int flags)
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index a4b83280998a..944d559ade21 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -33,10 +33,11 @@
  * pthread_mutex_lock will also verify the atomicity of the memory
  * transfer (UFFDIO_COPY).
  */
-#include <asm-generic/unistd.h>
+
 #include "uffd-common.h"
 
 uint64_t features;
+#ifdef __NR_userfaultfd
 
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
@@ -471,3 +472,15 @@ int main(int argc, char **argv)
 	       nr_pages, nr_pages_per_cpu);
 	return userfaultfd_stress();
 }
+
+#else /* __NR_userfaultfd */
+
+#warning "missing __NR_userfaultfd definition"
+
+int main(void)
+{
+	printf("skip: Skipping userfaultfd test (missing __NR_userfaultfd)\n");
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index a2e71b1636e7..3ddbb0a71b9c 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -5,11 +5,12 @@
  *  Copyright (C) 2015-2023  Red Hat, Inc.
  */
 
-#include <asm-generic/unistd.h>
 #include "uffd-common.h"
 
 #include "../../../../mm/gup_test.h"
 
+#ifdef __NR_userfaultfd
+
 /* The unit test doesn't need a large or random size, make it 32MB for now */
 #define  UFFD_TEST_MEM_SIZE               (32UL << 20)
 
@@ -1558,3 +1559,14 @@ int main(int argc, char *argv[])
 	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
 }
 
+#else /* __NR_userfaultfd */
+
+#warning "missing __NR_userfaultfd definition"
+
+int main(void)
+{
+	printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
+	return KSFT_SKIP;
+}
+
+#endif /* __NR_userfaultfd */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 6c6de1b1622b..e3d6b03527fe 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -10,7 +10,7 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
 
 # In theory, we do not care -m32 or -m64 for header compile tests.
 # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
-UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
+UAPI_CFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # USERCFLAGS might contain sysroot location for CC.
 UAPI_CFLAGS += $(USERCFLAGS)

