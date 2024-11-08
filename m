Return-Path: <stable+bounces-91952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C112A9C2162
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 17:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B84286056
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 16:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C93C21F4D5;
	Fri,  8 Nov 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rliRxHYh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2990721F4CD;
	Fri,  8 Nov 2024 16:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081606; cv=none; b=uU8ywfjSZziNs2SjY4a5ejYH+gds6eAgXFrmz5QQyImf1GBqEmmCvDGkx6VxnryBqDizvIEbOZjp+V9FhypGWa3DpyO55xky5W8ZI239iXIiHvQy69Xi5Lj+GnB8K3XqV5zeWNfN5uyf83+AM1PVHq5ICJzPVniuKtEkt1J9xfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081606; c=relaxed/simple;
	bh=TFg0rk6qjU8gdNH77rhcGG1FLt1g6UOO/xbfFHj/3hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNx5fsVD1xLB8jyXFwttRoY6BoJGthkAFOXwWJzDaAOFEVJyNduCwjyRs97Yc4Eyy0/wsiVz26dvmm7v+pshyFNzEo86fu2t/DXvLS05Rira3/aF16iYeGQd/mKAzedu8ns8UhXtkv13FYs4McdixCuJ47HMb0jXneGzVHvZZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rliRxHYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9BCC4CECD;
	Fri,  8 Nov 2024 16:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731081606;
	bh=TFg0rk6qjU8gdNH77rhcGG1FLt1g6UOO/xbfFHj/3hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rliRxHYhEJC2D2UsuiJj70ULtUiyjQpDLa/hvEAYkH5wxrIgmQj8i3W7SFFyze8wM
	 Qkx1a0GmEhKKHZulRsofQGyOvIj33ElbK6Ok7vAo4iEribKZuj1PovqxUmhwnlHAjy
	 XFUViYnYPf6QLZ9mny92b3h25uUMGTFbhYBhmTBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.116
Date: Fri,  8 Nov 2024 16:59:39 +0100
Message-ID: <2024110839-baggage-sphere-95d8@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024110839-untainted-affecting-65a7@gregkh>
References: <2024110839-untainted-affecting-65a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 1982ced2f43a..8f1f0f4a96b4 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 115
+SUBLEVEL = 116
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 3ea9661c09ff..9e45f6735d5d 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -313,8 +313,6 @@ extern inline pte_t mk_swap_pte(unsigned long type, unsigned long offset)
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#define kern_addr_valid(addr)	(1)
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
index b23be557403e..515e82db519f 100644
--- a/arch/arc/include/asm/pgtable-bits-arcv2.h
+++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
@@ -120,8 +120,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define kern_addr_valid(addr)	(1)
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #include <asm/hugepage.h>
 #endif
diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index 090011394477..61480d096054 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -21,8 +21,6 @@
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
 #define pgd_clear(pgdp)
-#define kern_addr_valid(addr)	(1)
-/* FIXME */
 /*
  * PMD_SHIFT determines the size of the area a second-level page table can map
  * PGDIR_SHIFT determines what a third-level page table entry can map
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ef48a55e9af8..f049072b2e85 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -300,10 +300,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
  */
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-/* FIXME: this is not correct */
-#define kern_addr_valid(addr)	(1)
-
 /*
  * We provide our own arch_get_unmapped_area to cope with VIPT caches.
  */
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 56c7df4c6532..1d713cfb0af1 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1027,8 +1027,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  */
 #define MAX_SWAPFILES_CHECK() BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > __SWP_TYPE_BITS)
 
-extern int kern_addr_valid(unsigned long addr);
-
 #ifdef CONFIG_ARM64_MTE
 
 #define __HAVE_ARCH_PREPARE_TO_SWAP
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4b302dbf78e9..6a4f118fb25f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -875,53 +875,6 @@ void __init paging_init(void)
 	create_idmap();
 }
 
-/*
- * Check whether a kernel address is valid (derived from arch/x86/).
- */
-int kern_addr_valid(unsigned long addr)
-{
-	pgd_t *pgdp;
-	p4d_t *p4dp;
-	pud_t *pudp, pud;
-	pmd_t *pmdp, pmd;
-	pte_t *ptep, pte;
-
-	addr = arch_kasan_reset_tag(addr);
-	if ((((long)addr) >> VA_BITS) != -1UL)
-		return 0;
-
-	pgdp = pgd_offset_k(addr);
-	if (pgd_none(READ_ONCE(*pgdp)))
-		return 0;
-
-	p4dp = p4d_offset(pgdp, addr);
-	if (p4d_none(READ_ONCE(*p4dp)))
-		return 0;
-
-	pudp = pud_offset(p4dp, addr);
-	pud = READ_ONCE(*pudp);
-	if (pud_none(pud))
-		return 0;
-
-	if (pud_sect(pud))
-		return pfn_valid(pud_pfn(pud));
-
-	pmdp = pmd_offset(pudp, addr);
-	pmd = READ_ONCE(*pmdp);
-	if (pmd_none(pmd))
-		return 0;
-
-	if (pmd_sect(pmd))
-		return pfn_valid(pmd_pfn(pmd));
-
-	ptep = pte_offset_kernel(pmdp, addr);
-	pte = READ_ONCE(*ptep);
-	if (pte_none(pte))
-		return 0;
-
-	return pfn_valid(pte_pfn(pte));
-}
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 static void free_hotplug_page_range(struct page *page, size_t size,
 				    struct vmem_altmap *altmap)
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 425b398f8d45..0a62f458c5cb 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -204,8 +204,7 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 
 /*
  * This function is used to determine if a linear map page has been marked as
- * not-valid. Walk the page table and check the PTE_VALID bit. This is based
- * on kern_addr_valid(), which almost does what we need.
+ * not-valid. Walk the page table and check the PTE_VALID bit.
  *
  * Because this is only called on the kernel linear map,  p?d_sect() implies
  * p?d_present(). When debug_pagealloc is enabled, sections mappings are
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index c3d9b92cbe61..77bc6caff2d2 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -249,9 +249,6 @@ extern void paging_init(void);
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *pte);
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define kern_addr_valid(addr)	(1)
-
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
 	remap_pfn_range(vma, vaddr, pfn, size, prot)
 
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index 7cbf719c578e..d7d4f9fca327 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -131,13 +131,6 @@ static inline void clear_page(void *page)
 
 #define page_to_virt(page)	__va(page_to_phys(page))
 
-/*
- * For port to Hexagon Virtual Machine, MAYBE we check for attempts
- * to reference reserved HVM space, but in any case, the VM will be
- * protected.
- */
-#define kern_addr_valid(addr)   (1)
-
 #include <asm/mem-layout.h>
 #include <asm-generic/memory_model.h>
 /* XXX Todo: implement assembly-optimized version of getorder. */
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 6925e28ae61d..01517a5e6778 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -181,22 +181,6 @@ ia64_phys_addr_valid (unsigned long addr)
 	return (addr & (local_cpu_data->unimpl_pa_mask)) == 0;
 }
 
-/*
- * kern_addr_valid(ADDR) tests if ADDR is pointing to valid kernel
- * memory.  For the return value to be meaningful, ADDR must be >=
- * PAGE_OFFSET.  This operation can be relatively expensive (e.g.,
- * require a hash-, or multi-level tree-lookup or something of that
- * sort) but it guarantees to return TRUE only if accessing the page
- * at that address does not cause an error.  Note that there may be
- * addresses for which kern_addr_valid() returns FALSE even though an
- * access would not cause an error (e.g., this is typically true for
- * memory mapped I/O regions.
- *
- * XXX Need to implement this for IA-64.
- */
-#define kern_addr_valid(addr)	(1)
-
-
 /*
  * Now come the defines and routines to manage and access the three-level
  * page table.
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index f991e678ca4b..103df0eb8642 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -425,8 +425,6 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 	__update_tlb(vma, address, (pte_t *)pmdp);
 }
 
-#define kern_addr_valid(addr)	(1)
-
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
 	return (pmd_val(pmd) & _PFN_MASK) >> _PFN_SHIFT;
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 59aa9dd466e8..64eb5386e7b2 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -40,6 +40,8 @@ static struct page *vdso_pages[] = { NULL };
 struct vdso_data *vdso_data = generic_vdso_data.data;
 struct vdso_pcpu_data *vdso_pdata = loongarch_vdso_data.vdata.pdata;
 
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma);
+
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)(new_vma->vm_start);
@@ -139,13 +141,37 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 
 	mmap_read_lock(mm);
 	for_each_vma(vmi, vma) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
 		if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
-			zap_vma_pages(vma);
+			zap_page_range(vma, vma->vm_start, size);
 	}
 	mmap_read_unlock(mm);
 
 	return 0;
 }
+
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_mm == current->mm))
+		return current->nsproxy->time_ns->vvar_page;
+
+	/*
+	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
+	 * through interfaces like /proc/$pid/mem or
+	 * process_vm_{readv,writev}() as long as there's no .access()
+	 * in special_mapping_vmops.
+	 * For more details check_vma_flags() and __access_remote_vm()
+	 */
+	WARN(1, "vvar_page accessed remotely");
+
+	return NULL;
+}
+#else
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	return NULL;
+}
 #endif
 
 static unsigned long vdso_base(void)
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 9b4e2fe2ac82..b93c41fe2067 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -145,8 +145,6 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 
 #endif /* !__ASSEMBLY__ */
 
-#define kern_addr_valid(addr)	(1)
-
 /* MMU-specific headers */
 
 #ifdef CONFIG_SUN3
diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index bce5ca56c388..fed58da3a6b6 100644
--- a/arch/m68k/include/asm/pgtable_no.h
+++ b/arch/m68k/include/asm/pgtable_no.h
@@ -20,7 +20,6 @@
 #define pgd_none(pgd)		(0)
 #define pgd_bad(pgd)		(0)
 #define pgd_clear(pgdp)
-#define kern_addr_valid(addr)	(1)
 #define	pmd_offset(a, b)	((void *)0)
 
 #define PAGE_NONE	__pgprot(0)
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index ba348e997dbb..42f5988e998b 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -416,9 +416,6 @@ extern unsigned long iopa(unsigned long addr);
 #define	IOMAP_NOCACHE_NONSER	2
 #define	IOMAP_NO_COPYBACK	3
 
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define kern_addr_valid(addr)	(1)
-
 void do_page_fault(struct pt_regs *regs, unsigned long address,
 		   unsigned long error_code);
 
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 4678627673df..a68c0b01d8cd 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -550,8 +550,6 @@ static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 	__update_tlb(vma, address, pte);
 }
 
-#define kern_addr_valid(addr)	(1)
-
 /*
  * Allow physical addresses to be fixed up to help 36-bit peripherals.
  */
diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index b3d45e815295..ab793bc517f5 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -249,8 +249,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 #define __swp_entry_to_pte(swp)	((pte_t) { (swp).val })
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 
-#define kern_addr_valid(addr)		(1)
-
 extern void __init paging_init(void);
 extern void __init mmu_init(void);
 
diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index dcae8aea132f..6477c17b3062 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -395,8 +395,6 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define kern_addr_valid(addr)           (1)
-
 typedef pte_t *pte_addr_t;
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 68ae77069d23..ea357430aafe 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -23,21 +23,6 @@
 #include <asm/processor.h>
 #include <asm/cache.h>
 
-/*
- * kern_addr_valid(ADDR) tests if ADDR is pointing to valid kernel
- * memory.  For the return value to be meaningful, ADDR must be >=
- * PAGE_OFFSET.  This operation can be relatively expensive (e.g.,
- * require a hash-, or multi-level tree-lookup or something of that
- * sort) but it guarantees to return TRUE only if accessing the page
- * at that address does not cause an error.  Note that there may be
- * addresses for which kern_addr_valid() returns FALSE even though an
- * access would not cause an error (e.g., this is typically true for
- * memory mapped I/O regions.
- *
- * XXX Need to implement this for parisc.
- */
-#define kern_addr_valid(addr)	(1)
-
 /* This is for the serialization of PxTLB broadcasts. At least on the N class
  * systems, only one PxTLB inter processor broadcast can be active at any one
  * time on the Merced bus. */
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 283f40d05a4d..9972626ddaf6 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -81,13 +81,6 @@ void poking_init(void);
 extern unsigned long ioremap_bot;
 extern const pgprot_t protection_map[16];
 
-/*
- * kern_addr_valid is intended to indicate whether an address is a valid
- * kernel address.  Most 32-bit archs define it as always true (like this)
- * but most 64-bit archs actually perform a test.  What should we do here?
- */
-#define kern_addr_valid(addr)	(1)
-
 #ifndef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_large(pmd)		0
 #endif
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2d9416a6a070..7d1688f850c3 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -805,8 +805,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 
 #endif /* !CONFIG_MMU */
 
-#define kern_addr_valid(addr)   (1) /* FIXME */
-
 extern char _start[];
 extern void *_dtb_early_va;
 extern uintptr_t _dtb_early_pa;
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index df9444397908..1ecafbcee9a0 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2017 SiFive
  */
 
-#define GENERATING_ASM_OFFSETS
-
 #include <linux/kbuild.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
diff --git a/arch/riscv/kernel/cpu-hotplug.c b/arch/riscv/kernel/cpu-hotplug.c
index f7a832e3a1d1..462b3631663f 100644
--- a/arch/riscv/kernel/cpu-hotplug.c
+++ b/arch/riscv/kernel/cpu-hotplug.c
@@ -65,7 +65,7 @@ void __cpu_die(unsigned int cpu)
 	if (cpu_ops[cpu]->cpu_is_stopped)
 		ret = cpu_ops[cpu]->cpu_is_stopped(cpu);
 	if (ret)
-		pr_warn("CPU%d may not have stopped: %d\n", cpu, ret);
+		pr_warn("CPU%u may not have stopped: %d\n", cpu, ret);
 }
 
 /*
diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 8e733aa48ba6..c306f3a6a800 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -59,7 +59,7 @@ extra_header_fields:
 	.long	efi_header_end - _start			// SizeOfHeaders
 	.long	0					// CheckSum
 	.short	IMAGE_SUBSYSTEM_EFI_APPLICATION		// Subsystem
-	.short	0					// DllCharacteristics
+	.short	IMAGE_DLL_CHARACTERISTICS_NX_COMPAT	// DllCharacteristics
 	.quad	0					// SizeOfStackReserve
 	.quad	0					// SizeOfStackCommit
 	.quad	0					// SizeOfHeapReserve
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 5348d842c745..3d16cc803220 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -132,8 +132,6 @@
 #define REG_PTR(insn, pos, regs)	\
 	(ulong *)((ulong)(regs) + REG_OFFSET(insn, pos))
 
-#define GET_RM(insn)			(((insn) >> 12) & 7)
-
 #define GET_RS1(insn, regs)		(*REG_PTR(insn, SH_RS1, regs))
 #define GET_RS2(insn, regs)		(*REG_PTR(insn, SH_RS2, regs))
 #define GET_RS1S(insn, regs)		(*REG_PTR(RVC_RS1S(insn), 0, regs))
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 06e6b27f3bcc..c1b68f962bad 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -18,6 +18,7 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
+ccflags-y += -fno-builtin
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index e3882b012bfa..70e679d87984 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -16,8 +16,10 @@
 #include <asm/pci_io.h>
 
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
+#define kc_xlate_dev_mem_ptr xlate_dev_mem_ptr
 void *xlate_dev_mem_ptr(phys_addr_t phys);
 #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
+#define kc_unxlate_dev_mem_ptr unxlate_dev_mem_ptr
 void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
 #define IO_SPACE_LIMIT 0
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 956300e3568a..4d6ab5f0a4cf 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1776,8 +1776,6 @@ static inline swp_entry_t __swp_entry(unsigned long type, unsigned long offset)
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)	((pte_t) { (x).val })
 
-#define kern_addr_valid(addr)   (1)
-
 extern int vmem_add_mapping(unsigned long start, unsigned long size);
 extern void vmem_remove_mapping(unsigned long start, unsigned long size);
 extern int __vmem_map_4k_page(unsigned long addr, unsigned long phys, pgprot_t prot, bool alloc);
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 6fb9ec54cf9b..3ce30becf6df 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -92,8 +92,6 @@ static inline unsigned long phys_addr_mask(void)
 
 typedef pte_t *pte_addr_t;
 
-#define kern_addr_valid(addr)	(1)
-
 #define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
 
 struct vm_area_struct;
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 8ff549004fac..5acc05b572e6 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -368,12 +368,6 @@ __get_iospace (unsigned long addr)
 	}
 }
 
-extern unsigned long *sparc_valid_addr_bitmap;
-
-/* Needs to be defined here and not in linux/mm.h, as it is arch dependent */
-#define kern_addr_valid(addr) \
-	(test_bit(__pa((unsigned long)(addr))>>20, sparc_valid_addr_bitmap))
-
 /*
  * For sparc32&64, the pfn in io_remap_pfn_range() carries <iospace> in
  * its high 4 bits.  These macros/functions put it there or get it from there.
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index d88e774c8eb4..9c0ea457bdf0 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -37,8 +37,7 @@
 
 #include "mm_32.h"
 
-unsigned long *sparc_valid_addr_bitmap;
-EXPORT_SYMBOL(sparc_valid_addr_bitmap);
+static unsigned long *sparc_valid_addr_bitmap;
 
 unsigned long phys_base;
 EXPORT_SYMBOL(phys_base);
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index d6faee23c77d..04f9db0c3111 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1667,7 +1667,6 @@ bool kern_addr_valid(unsigned long addr)
 
 	return pfn_valid(pte_pfn(*pte));
 }
-EXPORT_SYMBOL(kern_addr_valid);
 
 static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 					      unsigned long vend,
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 66bc3f99d9be..4e3052f2671a 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -298,8 +298,6 @@ extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
 	((swp_entry_t) { pte_val(pte_mkuptodate(pte)) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define kern_addr_valid(addr) (1)
-
 /* Clear a kernel PTE and flush it from the TLB */
 #define kpte_clear_flush(ptep, vaddr)		\
 do {						\
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 1e481d308e18..daf58a96e0a7 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -211,7 +211,16 @@
  */
 .macro CLEAR_CPU_BUFFERS
 	ALTERNATIVE "jmp .Lskip_verw_\@", "", X86_FEATURE_CLEAR_CPU_BUF
-	verw _ASM_RIP(mds_verw_sel)
+#ifdef CONFIG_X86_64
+	verw mds_verw_sel(%rip)
+#else
+	/*
+	 * In 32bit mode, the memory operand must be a %cs reference. The data
+	 * segments may not be usable (vm86 mode), and the stack segment may not
+	 * be flat (ESPFIX32).
+	 */
+	verw %cs:mds_verw_sel
+#endif
 .Lskip_verw_\@:
 .endm
 
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 7c9c968a42ef..7d4ad8907297 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -47,15 +47,6 @@ do {						\
 
 #endif /* !__ASSEMBLY__ */
 
-/*
- * kern_addr_valid() is (1) for FLATMEM and (0) for SPARSEMEM
- */
-#ifdef CONFIG_FLATMEM
-#define kern_addr_valid(addr)	(1)
-#else
-#define kern_addr_valid(kaddr)	(0)
-#endif
-
 /*
  * This is used to calculate the .brk reservation for initial pagetables.
  * Enough space is reserved to allocate pagetables sufficient to cover all
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 07cd53eeec77..a629b1b9f65a 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -240,7 +240,6 @@ static inline void native_pgd_clear(pgd_t *pgd)
 #define __swp_entry_to_pte(x)		(__pte((x).val))
 #define __swp_entry_to_pmd(x)		(__pmd((x).val))
 
-extern int kern_addr_valid(unsigned long addr);
 extern void cleanup_highmap(void);
 
 #define HAVE_ARCH_UNMAPPED_AREA
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 6d294d24e488..851711509d38 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1420,47 +1420,6 @@ void mark_rodata_ro(void)
 	debug_checkwx();
 }
 
-int kern_addr_valid(unsigned long addr)
-{
-	unsigned long above = ((long)addr) >> __VIRTUAL_MASK_SHIFT;
-	pgd_t *pgd;
-	p4d_t *p4d;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-
-	if (above != 0 && above != -1UL)
-		return 0;
-
-	pgd = pgd_offset_k(addr);
-	if (pgd_none(*pgd))
-		return 0;
-
-	p4d = p4d_offset(pgd, addr);
-	if (!p4d_present(*p4d))
-		return 0;
-
-	pud = pud_offset(p4d, addr);
-	if (!pud_present(*pud))
-		return 0;
-
-	if (pud_large(*pud))
-		return pfn_valid(pud_pfn(*pud));
-
-	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd))
-		return 0;
-
-	if (pmd_large(*pmd))
-		return pfn_valid(pmd_pfn(*pmd));
-
-	pte = pte_offset_kernel(pmd, addr);
-	if (pte_none(*pte))
-		return 0;
-
-	return pfn_valid(pte_pfn(*pte));
-}
-
 /*
  * Block size is the minimum amount of memory which can be hotplugged or
  * hotremoved. It must be power of two and must be equal or larger than
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 54f577c13afa..5b5484d707b2 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -386,8 +386,6 @@ ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 
 #else
 
-#define kern_addr_valid(addr)	(1)
-
 extern  void update_mmu_cache(struct vm_area_struct * vma,
 			      unsigned long address, pte_t *ptep);
 
diff --git a/block/blk-map.c b/block/blk-map.c
index b337ae347bfa..a2fa38756037 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -597,9 +597,7 @@ static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
 			goto put_bio;
 		if (bytes + bv->bv_len > nr_iter)
-			goto put_bio;
-		if (bv->bv_offset + bv->bv_len > PAGE_SIZE)
-			goto put_bio;
+			break;
 
 		nsegs++;
 		bytes += bv->bv_len;
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 3d9326172af4..31ea76b6fa04 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -857,7 +857,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
-	spin_lock_init(&cpc_ptr->rmw_lock);
+	raw_spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1077,6 +1077,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 	struct cpc_desc *cpc_desc;
+	unsigned long flags;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1116,7 +1117,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			return -ENODEV;
 		}
 
-		spin_lock(&cpc_desc->rmw_lock);
+		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
 		switch (size) {
 		case 8:
 			prev_val = readb_relaxed(vaddr);
@@ -1131,7 +1132,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			prev_val = readq_relaxed(vaddr);
 			break;
 		default:
-			spin_unlock(&cpc_desc->rmw_lock);
+			raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 			return -EFAULT;
 		}
 		val = MASK_VAL_WRITE(reg, prev_val, val);
@@ -1164,7 +1165,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		spin_unlock(&cpc_desc->rmw_lock);
+		raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 
 	return ret_val;
 }
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 1de19cecaa62..30204e62497c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,7 +25,6 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
-#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/swiotlb.h>
@@ -2559,7 +2558,6 @@ static const char *dev_uevent_name(struct kobject *kobj)
 static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -2588,12 +2586,8 @@ static int dev_uevent(struct kobject *kobj, struct kobj_uevent_env *env)
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	/* Synchronize with module_remove_driver() */
-	rcu_read_lock();
-	driver = READ_ONCE(dev->driver);
-	if (driver)
-		add_uevent_var(env, "DRIVER=%s", driver->name);
-	rcu_read_unlock();
+	if (dev->driver)
+		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -2663,8 +2657,11 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
+	/* Synchronize with really_probe() */
+	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(&dev->kobj, env);
+	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 851cc5367c04..46ad4d636731 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -7,7 +7,6 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-#include <linux/rcupdate.h>
 #include "base.h"
 
 static char *make_driver_name(struct device_driver *drv)
@@ -78,9 +77,6 @@ void module_remove_driver(struct device_driver *drv)
 	if (!drv)
 		return;
 
-	/* Synchronize with dev_uevent() */
-	synchronize_rcu();
-
 	sysfs_remove_link(&drv->p->kobj, "module");
 
 	if (drv->owner)
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 7f326bb5fd8d..62f5a9d64e8f 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -162,6 +162,7 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	struct mtk_cpufreq_data *data;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
+	struct of_phandle_args args;
 	void __iomem *base;
 	int ret, i;
 	int index;
@@ -170,11 +171,14 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
 	if (!data)
 		return -ENOMEM;
 
-	index = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
-						   "#performance-domain-cells",
-						   policy->cpus);
-	if (index < 0)
-		return index;
+	ret = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
+						 "#performance-domain-cells",
+						 policy->cpus, &args);
+	if (ret < 0)
+		return ret;
+
+	index = args.args[0];
+	of_node_put(args.np);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
 	if (!res) {
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index dd610556a3af..d7d789211c17 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -509,7 +509,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 		return rc;
 
 	/* In case PCI is scanned before ACPI re-trigger memdev attach */
-	return cxl_bus_rescan();
+	cxl_bus_rescan();
+	return 0;
 }
 
 static const struct acpi_device_id cxl_acpi_ids[] = {
@@ -533,7 +534,19 @@ static struct platform_driver cxl_acpi_driver = {
 	.id_table = cxl_test_ids,
 };
 
-module_platform_driver(cxl_acpi_driver);
+static int __init cxl_acpi_init(void)
+{
+	return platform_driver_register(&cxl_acpi_driver);
+}
+
+static void __exit cxl_acpi_exit(void)
+{
+	platform_driver_unregister(&cxl_acpi_driver);
+	cxl_bus_drain();
+}
+
+module_init(cxl_acpi_init);
+module_exit(cxl_acpi_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_IMPORT_NS(ACPI);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1f1483a9e525..20f052d3759e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1786,12 +1786,34 @@ static void cxl_bus_remove(struct device *dev)
 
 static struct workqueue_struct *cxl_bus_wq;
 
-int cxl_bus_rescan(void)
+static int cxl_rescan_attach(struct device *dev, void *data)
 {
-	return bus_rescan_devices(&cxl_bus_type);
+	int rc = device_attach(dev);
+
+	dev_vdbg(dev, "rescan: %s\n", rc ? "attach" : "detached");
+
+	return 0;
+}
+
+static void cxl_bus_rescan_queue(struct work_struct *w)
+{
+	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_rescan_attach);
+}
+
+void cxl_bus_rescan(void)
+{
+	static DECLARE_WORK(rescan_work, cxl_bus_rescan_queue);
+
+	queue_work(cxl_bus_wq, &rescan_work);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_bus_rescan, CXL);
 
+void cxl_bus_drain(void)
+{
+	drain_workqueue(cxl_bus_wq);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bus_drain, CXL);
+
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
 {
 	return queue_work(cxl_bus_wq, &cxlmd->detach_work);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7750ccb7652d..827fa94cddda 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -564,7 +564,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   struct cxl_dport *parent_dport);
 struct cxl_port *find_cxl_root(struct device *dev);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
-int cxl_bus_rescan(void);
+void cxl_bus_rescan(void);
+void cxl_bus_drain(void);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 				   struct cxl_dport **dport);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
index 285fe7ad490d..3e8051fe8296 100644
--- a/drivers/firmware/arm_sdei.c
+++ b/drivers/firmware/arm_sdei.c
@@ -763,7 +763,7 @@ static int sdei_device_freeze(struct device *dev)
 	int err;
 
 	/* unregister private events */
-	cpuhp_remove_state(sdei_entry_point);
+	cpuhp_remove_state(sdei_hp_state);
 
 	err = sdei_unregister_shared();
 	if (err)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8f7130f7d8c6..8dc0f70df24f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2990,6 +2990,10 @@ static int dm_resume(void *handle)
 	/* Do mst topology probing after resuming cached state*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type != dc_connection_mst_branch ||
 		    aconnector->mst_port)
@@ -5722,6 +5726,9 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		&aconnector->base.probed_modes :
 		&aconnector->base.modes;
 
+	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		return NULL;
+
 	if (aconnector->freesync_vid_base.clock != 0)
 		return &aconnector->freesync_vid_base;
 
@@ -8242,6 +8249,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 			continue;
 
 	notify:
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		mutex_lock(&adev->dm.audio_lock);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 407f7889e8fd..7a643690fdc7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -762,6 +762,9 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 			stream = dc->current_state->streams[0];
 			plane = (stream ? dc->current_state->stream_status[0].plane_states[0] : NULL);
 
+			if (!stream || !plane)
+				return false;
+
 			if (stream && plane) {
 				cursor_cache_enable = stream->cursor_position.enable &&
 						plane->address.grph.cursor_cache_addr.quad_part;
diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index deaf600d96fb..0d0884d3b246 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -642,7 +642,7 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0) {
+		if (val2 != 0 || val == 0) {
 			ret = -EINVAL;
 			break;
 		}
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 4943f51c4fda..b97005e748bc 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -522,7 +522,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 			}
 			if (mask == IIO_CHAN_INFO_PROCESSED) {
 				*val = (reg * data->cur_resolution) / 10000;
-				*val2 = (reg * data->cur_resolution) % 10000;
+				*val2 = (reg * data->cur_resolution) % 10000 * 100;
 				return IIO_VAL_INT_PLUS_MICRO;
 			}
 			*val = reg;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 1011293547ef..3a5c58694e07 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1496,9 +1496,11 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	u32 tbl_indx;
 	int rc;
 
+	spin_lock_bh(&rcfw->tbl_lock);
 	tbl_indx = map_qp_id_to_tbl_indx(qp->id, rcfw);
 	rcfw->qp_tbl[tbl_indx].qp_id = BNXT_QPLIB_QP_ID_INVALID;
 	rcfw->qp_tbl[tbl_indx].qp_handle = NULL;
+	spin_unlock_bh(&rcfw->tbl_lock);
 
 	RCFW_CMD_PREP(req, DESTROY_QP, cmd_flags);
 
@@ -1506,8 +1508,10 @@ int bnxt_qplib_destroy_qp(struct bnxt_qplib_res *res,
 	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
 					  (void *)&resp, NULL, 0);
 	if (rc) {
+		spin_lock_bh(&rcfw->tbl_lock);
 		rcfw->qp_tbl[tbl_indx].qp_id = qp->id;
 		rcfw->qp_tbl[tbl_indx].qp_handle = qp;
+		spin_unlock_bh(&rcfw->tbl_lock);
 		return rc;
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 14c9af41faa6..c03475b9fa28 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -320,17 +320,21 @@ static int bnxt_qplib_process_qp_event(struct bnxt_qplib_rcfw *rcfw,
 	case CREQ_QP_EVENT_EVENT_QP_ERROR_NOTIFICATION:
 		err_event = (struct creq_qp_error_notification *)qp_event;
 		qp_id = le32_to_cpu(err_event->xid);
+		spin_lock(&rcfw->tbl_lock);
 		tbl_indx = map_qp_id_to_tbl_indx(qp_id, rcfw);
 		qp = rcfw->qp_tbl[tbl_indx].qp_handle;
+		if (!qp) {
+			spin_unlock(&rcfw->tbl_lock);
+			break;
+		}
+		bnxt_qplib_mark_qp_error(qp);
+		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
+		spin_unlock(&rcfw->tbl_lock);
 		dev_dbg(&pdev->dev, "Received QP error notification\n");
 		dev_dbg(&pdev->dev,
 			"qpid 0x%x, req_err=0x%x, resp_err=0x%x\n",
 			qp_id, err_event->req_err_state_reason,
 			err_event->res_err_state_reason);
-		if (!qp)
-			break;
-		bnxt_qplib_mark_qp_error(qp);
-		rc = rcfw->creq.aeq_handler(rcfw, qp_event, qp);
 		break;
 	default:
 		/*
@@ -629,6 +633,7 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 			       GFP_KERNEL);
 	if (!rcfw->qp_tbl)
 		goto fail;
+	spin_lock_init(&rcfw->tbl_lock);
 
 	return 0;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index b887e7fbad9e..9c28f4625c92 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -186,6 +186,8 @@ struct bnxt_qplib_rcfw {
 	struct bnxt_qplib_crsqe		*crsqe_tbl;
 	int qp_tbl_size;
 	struct bnxt_qplib_qp_node *qp_tbl;
+	/* To synchronize the qp-handle hash table */
+	spinlock_t			tbl_lock;
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
diff --git a/drivers/infiniband/hw/cxgb4/provider.c b/drivers/infiniband/hw/cxgb4/provider.c
index 246b739ddb2b..9008584946c6 100644
--- a/drivers/infiniband/hw/cxgb4/provider.c
+++ b/drivers/infiniband/hw/cxgb4/provider.c
@@ -474,6 +474,7 @@ static const struct ib_device_ops c4iw_dev_ops = {
 	.fill_res_cq_entry = c4iw_fill_res_cq_entry,
 	.fill_res_cm_id_entry = c4iw_fill_res_cm_id_entry,
 	.fill_res_mr_entry = c4iw_fill_res_mr_entry,
+	.fill_res_qp_entry = c4iw_fill_res_qp_entry,
 	.get_dev_fw_str = get_dev_fw_str,
 	.get_dma_mr = c4iw_get_dma_mr,
 	.get_hw_stats = c4iw_get_mib,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e0df3017e241..8d132b726c64 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4187,14 +4187,14 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		MLX5_SET(qpc, qpc, retry_count, attr->retry_cnt);
 
 	if (attr_mask & IB_QP_MAX_QP_RD_ATOMIC && attr->max_rd_atomic)
-		MLX5_SET(qpc, qpc, log_sra_max, ilog2(attr->max_rd_atomic));
+		MLX5_SET(qpc, qpc, log_sra_max, fls(attr->max_rd_atomic - 1));
 
 	if (attr_mask & IB_QP_SQ_PSN)
 		MLX5_SET(qpc, qpc, next_send_psn, attr->sq_psn);
 
 	if (attr_mask & IB_QP_MAX_DEST_RD_ATOMIC && attr->max_dest_rd_atomic)
 		MLX5_SET(qpc, qpc, log_rra_max,
-			 ilog2(attr->max_dest_rd_atomic));
+			 fls(attr->max_dest_rd_atomic - 1));
 
 	if (attr_mask & (IB_QP_ACCESS_FLAGS | IB_QP_MAX_DEST_RD_ATOMIC)) {
 		err = set_qpc_atomic_flags(qp, attr, attr_mask, qpc);
diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index fa1f5a632e7f..093b0459a8a0 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -258,7 +258,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 	int lcpu;
 
 	BUG_ON(dsr_bytes > GRU_NUM_KERNEL_DSR_BYTES);
-	preempt_disable();
 	bs = gru_lock_kernel_context(-1);
 	lcpu = uv_blade_processor_id();
 	*cb = bs->kernel_cb + lcpu * GRU_HANDLE_STRIDE;
@@ -272,7 +271,6 @@ static int gru_get_cpu_resources(int dsr_bytes, void **cb, void **dsr)
 static void gru_free_cpu_resources(void *cb, void *dsr)
 {
 	gru_unlock_kernel_context(uv_numa_blade_id());
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/misc/sgi-gru/grumain.c b/drivers/misc/sgi-gru/grumain.c
index 4eb4b9455139..d2b2e39783d0 100644
--- a/drivers/misc/sgi-gru/grumain.c
+++ b/drivers/misc/sgi-gru/grumain.c
@@ -941,10 +941,8 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 
 again:
 	mutex_lock(&gts->ts_ctxlock);
-	preempt_disable();
 
 	if (gru_check_context_placement(gts)) {
-		preempt_enable();
 		mutex_unlock(&gts->ts_ctxlock);
 		gru_unload_context(gts, 1);
 		return VM_FAULT_NOPAGE;
@@ -953,7 +951,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 	if (!gts->ts_gru) {
 		STAT(load_user_context);
 		if (!gru_assign_gru_context(gts)) {
-			preempt_enable();
 			mutex_unlock(&gts->ts_ctxlock);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(GRU_ASSIGN_DELAY);  /* true hack ZZZ */
@@ -969,7 +966,6 @@ vm_fault_t gru_fault(struct vm_fault *vmf)
 				vma->vm_page_prot);
 	}
 
-	preempt_enable();
 	mutex_unlock(&gts->ts_ctxlock);
 
 	return VM_FAULT_NOPAGE;
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 10921cd2608d..1107dd3e2e9f 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -65,7 +65,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 	struct gru_tlb_global_handle *tgh;
 	int n;
 
-	preempt_disable();
 	if (uv_numa_blade_id() == gru->gs_blade_id)
 		n = get_on_blade_tgh(gru);
 	else
@@ -79,7 +78,6 @@ static struct gru_tlb_global_handle *get_lock_tgh_handle(struct gru_state
 static void get_unlock_tgh_handle(struct gru_tlb_global_handle *tgh)
 {
 	unlock_tgh_handle(tgh);
-	preempt_enable();
 }
 
 /*
diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index b7c775b615e8..58aba52022bf 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -120,9 +120,10 @@ static const struct flash_info winbond_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16)
 		NO_SFDP_FLAGS(SECT_4K) },
-	{ "w25q128", INFO(0xef4018, 0, 0, 0)
-		PARSE_SFDP
-		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256)
+		FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
+			      SPI_NOR_QUAD_READ) },
 	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		.fixups = &w25q256_fixups },
diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index 410c7b67eba4..e6cc916d205f 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -105,10 +105,6 @@ static struct net_device * __init mvme147lance_probe(void)
 	macaddr[3] = address&0xff;
 	eth_hw_addr_set(dev, macaddr);
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -138,6 +134,9 @@ static struct net_device * __init mvme147lance_probe(void)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
index a2ee695a3f17..0888d2d16375 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
@@ -429,27 +429,8 @@ mlxsw_sp1_ipip_rem_addr_unset_gre6(struct mlxsw_sp *mlxsw_sp,
 	WARN_ON_ONCE(1);
 }
 
-static const struct mlxsw_sp_ipip_ops mlxsw_sp1_ipip_gre6_ops = {
-	.dev_type = ARPHRD_IP6GRE,
-	.ul_proto = MLXSW_SP_L3_PROTO_IPV6,
-	.inc_parsing_depth = true,
-	.parms_init = mlxsw_sp1_ipip_netdev_parms_init_gre6,
-	.nexthop_update = mlxsw_sp1_ipip_nexthop_update_gre6,
-	.decap_config = mlxsw_sp1_ipip_decap_config_gre6,
-	.can_offload = mlxsw_sp1_ipip_can_offload_gre6,
-	.ol_loopback_config = mlxsw_sp1_ipip_ol_loopback_config_gre6,
-	.ol_netdev_change = mlxsw_sp1_ipip_ol_netdev_change_gre6,
-	.rem_ip_addr_set = mlxsw_sp1_ipip_rem_addr_set_gre6,
-	.rem_ip_addr_unset = mlxsw_sp1_ipip_rem_addr_unset_gre6,
-};
-
-const struct mlxsw_sp_ipip_ops *mlxsw_sp1_ipip_ops_arr[] = {
-	[MLXSW_SP_IPIP_TYPE_GRE4] = &mlxsw_sp_ipip_gre4_ops,
-	[MLXSW_SP_IPIP_TYPE_GRE6] = &mlxsw_sp1_ipip_gre6_ops,
-};
-
 static struct mlxsw_sp_ipip_parms
-mlxsw_sp2_ipip_netdev_parms_init_gre6(const struct net_device *ol_dev)
+mlxsw_sp_ipip_netdev_parms_init_gre6(const struct net_device *ol_dev)
 {
 	struct __ip6_tnl_parm parms = mlxsw_sp_ipip_netdev_parms6(ol_dev);
 
@@ -464,9 +445,9 @@ mlxsw_sp2_ipip_netdev_parms_init_gre6(const struct net_device *ol_dev)
 }
 
 static int
-mlxsw_sp2_ipip_nexthop_update_gre6(struct mlxsw_sp *mlxsw_sp, u32 adj_index,
-				   struct mlxsw_sp_ipip_entry *ipip_entry,
-				   bool force, char *ratr_pl)
+mlxsw_sp_ipip_nexthop_update_gre6(struct mlxsw_sp *mlxsw_sp, u32 adj_index,
+				  struct mlxsw_sp_ipip_entry *ipip_entry,
+				  bool force, char *ratr_pl)
 {
 	u16 rif_index = mlxsw_sp_ipip_lb_rif_index(ipip_entry->ol_lb);
 	enum mlxsw_reg_ratr_op op;
@@ -482,9 +463,9 @@ mlxsw_sp2_ipip_nexthop_update_gre6(struct mlxsw_sp *mlxsw_sp, u32 adj_index,
 }
 
 static int
-mlxsw_sp2_ipip_decap_config_gre6(struct mlxsw_sp *mlxsw_sp,
-				 struct mlxsw_sp_ipip_entry *ipip_entry,
-				 u32 tunnel_index)
+mlxsw_sp_ipip_decap_config_gre6(struct mlxsw_sp *mlxsw_sp,
+				struct mlxsw_sp_ipip_entry *ipip_entry,
+				u32 tunnel_index)
 {
 	u16 rif_index = mlxsw_sp_ipip_lb_rif_index(ipip_entry->ol_lb);
 	u16 ul_rif_id = mlxsw_sp_ipip_lb_ul_rif_id(ipip_entry->ol_lb);
@@ -519,8 +500,8 @@ mlxsw_sp2_ipip_decap_config_gre6(struct mlxsw_sp *mlxsw_sp,
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(rtdp), rtdp_pl);
 }
 
-static bool mlxsw_sp2_ipip_can_offload_gre6(const struct mlxsw_sp *mlxsw_sp,
-					    const struct net_device *ol_dev)
+static bool mlxsw_sp_ipip_can_offload_gre6(const struct mlxsw_sp *mlxsw_sp,
+					   const struct net_device *ol_dev)
 {
 	struct __ip6_tnl_parm tparm = mlxsw_sp_ipip_netdev_parms6(ol_dev);
 	bool inherit_tos = tparm.flags & IP6_TNL_F_USE_ORIG_TCLASS;
@@ -534,8 +515,8 @@ static bool mlxsw_sp2_ipip_can_offload_gre6(const struct mlxsw_sp *mlxsw_sp,
 }
 
 static struct mlxsw_sp_rif_ipip_lb_config
-mlxsw_sp2_ipip_ol_loopback_config_gre6(struct mlxsw_sp *mlxsw_sp,
-				       const struct net_device *ol_dev)
+mlxsw_sp_ipip_ol_loopback_config_gre6(struct mlxsw_sp *mlxsw_sp,
+				      const struct net_device *ol_dev)
 {
 	struct __ip6_tnl_parm parms = mlxsw_sp_ipip_netdev_parms6(ol_dev);
 	enum mlxsw_reg_ritr_loopback_ipip_type lb_ipipt;
@@ -553,20 +534,42 @@ mlxsw_sp2_ipip_ol_loopback_config_gre6(struct mlxsw_sp *mlxsw_sp,
 }
 
 static int
-mlxsw_sp2_ipip_ol_netdev_change_gre6(struct mlxsw_sp *mlxsw_sp,
-				     struct mlxsw_sp_ipip_entry *ipip_entry,
-				     struct netlink_ext_ack *extack)
+mlxsw_sp_ipip_ol_netdev_change_gre6(struct mlxsw_sp *mlxsw_sp,
+				    struct mlxsw_sp_ipip_entry *ipip_entry,
+				    struct netlink_ext_ack *extack)
 {
+	u32 new_kvdl_index, old_kvdl_index = ipip_entry->dip_kvdl_index;
+	struct in6_addr old_addr6 = ipip_entry->parms.daddr.addr6;
 	struct mlxsw_sp_ipip_parms new_parms;
+	int err;
 
-	new_parms = mlxsw_sp2_ipip_netdev_parms_init_gre6(ipip_entry->ol_dev);
-	return mlxsw_sp_ipip_ol_netdev_change_gre(mlxsw_sp, ipip_entry,
-						  &new_parms, extack);
+	new_parms = mlxsw_sp_ipip_netdev_parms_init_gre6(ipip_entry->ol_dev);
+
+	err = mlxsw_sp_ipv6_addr_kvdl_index_get(mlxsw_sp,
+						&new_parms.daddr.addr6,
+						&new_kvdl_index);
+	if (err)
+		return err;
+	ipip_entry->dip_kvdl_index = new_kvdl_index;
+
+	err = mlxsw_sp_ipip_ol_netdev_change_gre(mlxsw_sp, ipip_entry,
+						 &new_parms, extack);
+	if (err)
+		goto err_change_gre;
+
+	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &old_addr6);
+
+	return 0;
+
+err_change_gre:
+	ipip_entry->dip_kvdl_index = old_kvdl_index;
+	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &new_parms.daddr.addr6);
+	return err;
 }
 
 static int
-mlxsw_sp2_ipip_rem_addr_set_gre6(struct mlxsw_sp *mlxsw_sp,
-				 struct mlxsw_sp_ipip_entry *ipip_entry)
+mlxsw_sp_ipip_rem_addr_set_gre6(struct mlxsw_sp *mlxsw_sp,
+				struct mlxsw_sp_ipip_entry *ipip_entry)
 {
 	return mlxsw_sp_ipv6_addr_kvdl_index_get(mlxsw_sp,
 						 &ipip_entry->parms.daddr.addr6,
@@ -574,24 +577,44 @@ mlxsw_sp2_ipip_rem_addr_set_gre6(struct mlxsw_sp *mlxsw_sp,
 }
 
 static void
-mlxsw_sp2_ipip_rem_addr_unset_gre6(struct mlxsw_sp *mlxsw_sp,
-				   const struct mlxsw_sp_ipip_entry *ipip_entry)
+mlxsw_sp_ipip_rem_addr_unset_gre6(struct mlxsw_sp *mlxsw_sp,
+				  const struct mlxsw_sp_ipip_entry *ipip_entry)
 {
 	mlxsw_sp_ipv6_addr_put(mlxsw_sp, &ipip_entry->parms.daddr.addr6);
 }
 
+static const struct mlxsw_sp_ipip_ops mlxsw_sp1_ipip_gre6_ops = {
+	.dev_type = ARPHRD_IP6GRE,
+	.ul_proto = MLXSW_SP_L3_PROTO_IPV6,
+	.inc_parsing_depth = true,
+	.double_rif_entry = true,
+	.parms_init = mlxsw_sp1_ipip_netdev_parms_init_gre6,
+	.nexthop_update = mlxsw_sp1_ipip_nexthop_update_gre6,
+	.decap_config = mlxsw_sp1_ipip_decap_config_gre6,
+	.can_offload = mlxsw_sp1_ipip_can_offload_gre6,
+	.ol_loopback_config = mlxsw_sp1_ipip_ol_loopback_config_gre6,
+	.ol_netdev_change = mlxsw_sp1_ipip_ol_netdev_change_gre6,
+	.rem_ip_addr_set = mlxsw_sp1_ipip_rem_addr_set_gre6,
+	.rem_ip_addr_unset = mlxsw_sp1_ipip_rem_addr_unset_gre6,
+};
+
+const struct mlxsw_sp_ipip_ops *mlxsw_sp1_ipip_ops_arr[] = {
+	[MLXSW_SP_IPIP_TYPE_GRE4] = &mlxsw_sp_ipip_gre4_ops,
+	[MLXSW_SP_IPIP_TYPE_GRE6] = &mlxsw_sp1_ipip_gre6_ops,
+};
+
 static const struct mlxsw_sp_ipip_ops mlxsw_sp2_ipip_gre6_ops = {
 	.dev_type = ARPHRD_IP6GRE,
 	.ul_proto = MLXSW_SP_L3_PROTO_IPV6,
 	.inc_parsing_depth = true,
-	.parms_init = mlxsw_sp2_ipip_netdev_parms_init_gre6,
-	.nexthop_update = mlxsw_sp2_ipip_nexthop_update_gre6,
-	.decap_config = mlxsw_sp2_ipip_decap_config_gre6,
-	.can_offload = mlxsw_sp2_ipip_can_offload_gre6,
-	.ol_loopback_config = mlxsw_sp2_ipip_ol_loopback_config_gre6,
-	.ol_netdev_change = mlxsw_sp2_ipip_ol_netdev_change_gre6,
-	.rem_ip_addr_set = mlxsw_sp2_ipip_rem_addr_set_gre6,
-	.rem_ip_addr_unset = mlxsw_sp2_ipip_rem_addr_unset_gre6,
+	.parms_init = mlxsw_sp_ipip_netdev_parms_init_gre6,
+	.nexthop_update = mlxsw_sp_ipip_nexthop_update_gre6,
+	.decap_config = mlxsw_sp_ipip_decap_config_gre6,
+	.can_offload = mlxsw_sp_ipip_can_offload_gre6,
+	.ol_loopback_config = mlxsw_sp_ipip_ol_loopback_config_gre6,
+	.ol_netdev_change = mlxsw_sp_ipip_ol_netdev_change_gre6,
+	.rem_ip_addr_set = mlxsw_sp_ipip_rem_addr_set_gre6,
+	.rem_ip_addr_unset = mlxsw_sp_ipip_rem_addr_unset_gre6,
 };
 
 const struct mlxsw_sp_ipip_ops *mlxsw_sp2_ipip_ops_arr[] = {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h
index 8cc259dcc8d0..a35f009da561 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.h
@@ -49,6 +49,7 @@ struct mlxsw_sp_ipip_ops {
 	int dev_type;
 	enum mlxsw_sp_l3proto ul_proto; /* Underlay. */
 	bool inc_parsing_depth;
+	bool double_rif_entry;
 
 	struct mlxsw_sp_ipip_parms
 	(*parms_init)(const struct net_device *ol_dev);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
index 7b01b9c20722..7bb7b57af1a7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ptp.c
@@ -16,6 +16,7 @@
 #include "spectrum.h"
 #include "spectrum_ptp.h"
 #include "core.h"
+#include "txheader.h"
 
 #define MLXSW_SP1_PTP_CLOCK_CYCLES_SHIFT	29
 #define MLXSW_SP1_PTP_CLOCK_FREQ_KHZ		156257 /* 6.4nSec */
@@ -1696,6 +1697,12 @@ int mlxsw_sp_ptp_txhdr_construct(struct mlxsw_core *mlxsw_core,
 				 struct sk_buff *skb,
 				 const struct mlxsw_tx_info *tx_info)
 {
+	if (skb_cow_head(skb, MLXSW_TXHDR_LEN)) {
+		this_cpu_inc(mlxsw_sp_port->pcpu_stats->tx_dropped);
+		dev_kfree_skb_any(skb);
+		return -ENOMEM;
+	}
+
 	mlxsw_sp_txhdr_construct(skb, tx_info);
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index ab0aa1a61d4a..a00dd0ee524e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -77,6 +77,7 @@ struct mlxsw_sp_rif_params {
 	};
 	u16 vid;
 	bool lag;
+	bool double_entry;
 };
 
 struct mlxsw_sp_rif_subport {
@@ -1068,6 +1069,7 @@ mlxsw_sp_ipip_ol_ipip_lb_create(struct mlxsw_sp *mlxsw_sp,
 	lb_params = (struct mlxsw_sp_rif_params_ipip_lb) {
 		.common.dev = ol_dev,
 		.common.lag = false,
+		.common.double_entry = ipip_ops->double_rif_entry,
 		.lb_config = ipip_ops->ol_loopback_config(mlxsw_sp, ol_dev),
 	};
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 93630840309e..045e57c444fd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4183,11 +4183,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (dma_mapping_error(priv->device, des))
 		goto dma_map_err;
 
-	tx_q->tx_skbuff_dma[first_entry].buf = des;
-	tx_q->tx_skbuff_dma[first_entry].len = skb_headlen(skb);
-	tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
-	tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
-
 	if (priv->dma_cap.addr64 <= 32) {
 		first->des0 = cpu_to_le32(des);
 
@@ -4206,6 +4201,23 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
 
+	/* In case two or more DMA transmit descriptors are allocated for this
+	 * non-paged SKB data, the DMA buffer address should be saved to
+	 * tx_q->tx_skbuff_dma[].buf corresponding to the last descriptor,
+	 * and leave the other tx_q->tx_skbuff_dma[].buf as NULL to guarantee
+	 * that stmmac_tx_clean() does not unmap the entire DMA buffer too early
+	 * since the tail areas of the DMA buffer can be accessed by DMA engine
+	 * sooner or later.
+	 * By saving the DMA buffer address to tx_q->tx_skbuff_dma[].buf
+	 * corresponding to the last descriptor, stmmac_tx_clean() will unmap
+	 * this DMA buffer right after the DMA engine completely finishes the
+	 * full buffer transmission.
+	 */
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
+
 	/* Prepare fragments */
 	for (i = 0; i < nfrags; i++) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index bbe8d76b1595..5e0332c9d0d7 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1262,20 +1262,24 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 		return -EINVAL;
 
 	if (data[IFLA_GTP_FD0]) {
-		u32 fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
+		int fd0 = nla_get_u32(data[IFLA_GTP_FD0]);
 
-		sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
-		if (IS_ERR(sk0))
-			return PTR_ERR(sk0);
+		if (fd0 >= 0) {
+			sk0 = gtp_encap_enable_socket(fd0, UDP_ENCAP_GTP0, gtp);
+			if (IS_ERR(sk0))
+				return PTR_ERR(sk0);
+		}
 	}
 
 	if (data[IFLA_GTP_FD1]) {
-		u32 fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
+		int fd1 = nla_get_u32(data[IFLA_GTP_FD1]);
 
-		sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
-		if (IS_ERR(sk1u)) {
-			gtp_encap_disable_sock(sk0);
-			return PTR_ERR(sk1u);
+		if (fd1 >= 0) {
+			sk1u = gtp_encap_enable_socket(fd1, UDP_ENCAP_GTP1U, gtp);
+			if (IS_ERR(sk1u)) {
+				gtp_encap_disable_sock(sk0);
+				return PTR_ERR(sk1u);
+			}
 		}
 	}
 
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 3a19d6f0e0dd..c007e262daf7 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3726,8 +3726,7 @@ static void macsec_free_netdev(struct net_device *dev)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
 
-	if (macsec->secy.tx_sc.md_dst)
-		metadata_dst_free(macsec->secy.tx_sc.md_dst);
+	dst_release(&macsec->secy.tx_sc.md_dst->dst);
 	free_percpu(macsec->stats);
 	free_percpu(macsec->secy.tx_sc.stats);
 
diff --git a/drivers/net/mctp/mctp-i2c.c b/drivers/net/mctp/mctp-i2c.c
index 1d67a3ca1fd1..7635a8b3c35c 100644
--- a/drivers/net/mctp/mctp-i2c.c
+++ b/drivers/net/mctp/mctp-i2c.c
@@ -547,6 +547,9 @@ static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
 	if (len > MCTP_I2C_MAXMTU)
 		return -EMSGSIZE;
 
+	if (!daddr || !saddr)
+		return -EINVAL;
+
 	lldst = *((u8 *)daddr);
 	llsrc = *((u8 *)saddr);
 
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index a1f91ff8ec56..f108e363b716 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1377,10 +1377,12 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
 
 	if (pos != 0)
 		return -EINVAL;
-	if (size > sizeof(buf))
+	if (size > sizeof(buf) - 1)
 		return -EINVAL;
 	if (copy_from_user(buf, user_buf, size))
 		return -EFAULT;
+	buf[size] = 0;
+
 	if (sscanf(buf, "%u %hu", &nhid, &bucket_index) != 2)
 		return -EINVAL;
 
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 4d5009604eee..a0cb2aa2533e 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -3035,9 +3035,14 @@ ath10k_wmi_tlv_op_cleanup_mgmt_tx_send(struct ath10k *ar,
 				       struct sk_buff *msdu)
 {
 	struct ath10k_skb_cb *cb = ATH10K_SKB_CB(msdu);
+	struct ath10k_mgmt_tx_pkt_addr *pkt_addr;
 	struct ath10k_wmi *wmi = &ar->wmi;
 
-	idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	spin_lock_bh(&ar->data_lock);
+	pkt_addr = idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+	spin_unlock_bh(&ar->data_lock);
+
+	kfree(pkt_addr);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 8a5a44d75b14..b126ffba480f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -2440,6 +2440,7 @@ wmi_process_mgmt_tx_comp(struct ath10k *ar, struct mgmt_tx_compl_params *param)
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	info = IEEE80211_SKB_CB(msdu);
+	kfree(pkt_addr);
 
 	if (param->status) {
 		info->flags &= ~IEEE80211_TX_STAT_ACK;
@@ -9581,6 +9582,7 @@ static int ath10k_wmi_mgmt_tx_clean_up_pending(int msdu_id, void *ptr,
 	dma_unmap_single(ar->dev, pkt_addr->paddr,
 			 msdu->len, DMA_TO_DEVICE);
 	ieee80211_free_txskb(ar->hw, msdu);
+	kfree(pkt_addr);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 73f299f65e2e..d01616d06a32 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5224,8 +5224,11 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		    hal_status == HAL_TLV_STATUS_PPDU_DONE) {
 			rx_mon_stats->status_ppdu_done++;
 			pmon->mon_ppdu_status = DP_PPDU_STATUS_DONE;
-			ath11k_dp_rx_mon_dest_process(ar, mac_id, budget, napi);
-			pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+			if (!ab->hw_params.full_monitor_mode) {
+				ath11k_dp_rx_mon_dest_process(ar, mac_id,
+							      budget, napi);
+				pmon->mon_ppdu_status = DP_PPDU_STATUS_START;
+			}
 		}
 
 		if (ppdu_info->peer_id == HAL_INVALID_PEERID ||
diff --git a/drivers/net/wireless/broadcom/brcm80211/Kconfig b/drivers/net/wireless/broadcom/brcm80211/Kconfig
index 3a1a35b5672f..19d0c003f626 100644
--- a/drivers/net/wireless/broadcom/brcm80211/Kconfig
+++ b/drivers/net/wireless/broadcom/brcm80211/Kconfig
@@ -27,6 +27,7 @@ source "drivers/net/wireless/broadcom/brcm80211/brcmfmac/Kconfig"
 config BRCM_TRACING
 	bool "Broadcom device tracing"
 	depends on BRCMSMAC || BRCMFMAC
+	depends on TRACING
 	help
 	  If you say Y here, the Broadcom wireless drivers will register
 	  with ftrace to dump event information into the trace ringbuffer.
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 96002121bb8b..1810b12645a0 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -3119,6 +3119,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 	struct il_cmd_meta *out_meta;
 	dma_addr_t phys_addr;
 	unsigned long flags;
+	u8 *out_payload;
 	u32 idx;
 	u16 fix_size;
 
@@ -3154,6 +3155,16 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 	out_cmd = txq->cmd[idx];
 	out_meta = &txq->meta[idx];
 
+	/* The payload is in the same place in regular and huge
+	 * command buffers, but we need to let the compiler know when
+	 * we're using a larger payload buffer to avoid "field-
+	 * spanning write" warnings at run-time for huge commands.
+	 */
+	if (cmd->flags & CMD_SIZE_HUGE)
+		out_payload = ((struct il_device_cmd_huge *)out_cmd)->cmd.payload;
+	else
+		out_payload = out_cmd->cmd.payload;
+
 	if (WARN_ON(out_meta->flags & CMD_MAPPED)) {
 		spin_unlock_irqrestore(&il->hcmd_lock, flags);
 		return -ENOSPC;
@@ -3167,7 +3178,7 @@ il_enqueue_hcmd(struct il_priv *il, struct il_host_cmd *cmd)
 		out_meta->callback = cmd->callback;
 
 	out_cmd->hdr.cmd = cmd->id;
-	memcpy(&out_cmd->cmd.payload, cmd->data, cmd->len);
+	memcpy(out_payload, cmd->data, cmd->len);
 
 	/* At this point, the out_cmd now has all of the incoming cmd
 	 * information */
@@ -4961,6 +4972,8 @@ il_pci_resume(struct device *device)
 	 */
 	pci_write_config_byte(pdev, PCI_CFG_RETRY_TIMEOUT, 0x00);
 
+	_il_wr(il, CSR_INT, 0xffffffff);
+	_il_wr(il, CSR_FH_INT_STATUS, 0xffffffff);
 	il_enable_interrupts(il);
 
 	if (!(_il_rd(il, CSR_GP_CNTRL) & CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW))
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index 69687fcf963f..027dae5619a3 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -560,6 +560,18 @@ struct il_device_cmd {
 
 #define TFD_MAX_PAYLOAD_SIZE (sizeof(struct il_device_cmd))
 
+/**
+ * struct il_device_cmd_huge
+ *
+ * For use when sending huge commands.
+ */
+struct il_device_cmd_huge {
+	struct il_cmd_header hdr;	/* uCode API */
+	union {
+		u8 payload[IL_MAX_CMD_SIZE - sizeof(struct il_cmd_header)];
+	} __packed cmd;
+} __packed;
+
 struct il_host_cmd {
 	const void *data;
 	unsigned long reply_page;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 668bb9ce293d..4706df3ae81b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1348,11 +1348,18 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 
 #endif /* CONFIG_ACPI */
 
+static void iwl_mvm_disconnect_iterator(void *data, u8 *mac,
+					struct ieee80211_vif *vif)
+{
+	if (vif->type == NL80211_IFTYPE_STATION)
+		ieee80211_hw_restart_disconnect(vif);
+}
+
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 {
 	u32 error_log_size = mvm->fw->ucode_capa.error_log_size;
+	u32 status = 0;
 	int ret;
-	u32 resp;
 
 	struct iwl_fw_error_recovery_cmd recovery_cmd = {
 		.flags = cpu_to_le32(flags),
@@ -1360,7 +1367,6 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 	};
 	struct iwl_host_cmd host_cmd = {
 		.id = WIDE_ID(SYSTEM_GROUP, FW_ERROR_RECOVERY_CMD),
-		.flags = CMD_WANT_SKB,
 		.data = {&recovery_cmd, },
 		.len = {sizeof(recovery_cmd), },
 	};
@@ -1380,7 +1386,7 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 		recovery_cmd.buf_size = cpu_to_le32(error_log_size);
 	}
 
-	ret = iwl_mvm_send_cmd(mvm, &host_cmd);
+	ret = iwl_mvm_send_cmd_status(mvm, &host_cmd, &status);
 	kfree(mvm->error_recovery_buf);
 	mvm->error_recovery_buf = NULL;
 
@@ -1391,11 +1397,15 @@ void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
 
 	/* skb respond is only relevant in ERROR_RECOVERY_UPDATE_DB */
 	if (flags & ERROR_RECOVERY_UPDATE_DB) {
-		resp = le32_to_cpu(*(__le32 *)host_cmd.resp_pkt->data);
-		if (resp)
+		if (status) {
 			IWL_ERR(mvm,
 				"Failed to send recovery cmd blob was invalid %d\n",
-				resp);
+				status);
+
+			ieee80211_iterate_interfaces(mvm->hw, 0,
+						     iwl_mvm_disconnect_iterator,
+						     mvm);
+		}
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 1785fded6290..2a4c59c71448 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1739,7 +1739,8 @@ iwl_mvm_umac_scan_cfg_channels_v6_6g(struct iwl_mvm *mvm,
 			&cp->channel_config[ch_cnt];
 
 		u32 s_ssid_bitmap = 0, bssid_bitmap = 0, flags = 0;
-		u8 j, k, s_max = 0, b_max = 0, n_used_bssid_entries;
+		u8 k, s_max = 0, b_max = 0, n_used_bssid_entries;
+		u32 j;
 		bool force_passive, found = false, allow_passive = true,
 		     unsolicited_probe_on_chan = false, psc_no_listen = false;
 
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index aacc05ec00c2..74791078fdeb 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -101,6 +101,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
 				 __func__, ctrl->cntlid, ret);
 			kfree_sensitive(ctrl->dh_key);
+			ctrl->dh_key = NULL;
 			return ret;
 		}
 		ctrl->dh_keysize = crypto_kpp_maxsize(ctrl->dh_tfm);
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 8934160c4a33..1aaeb0ead7a7 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -1252,7 +1252,7 @@ static ssize_t fc_rport_set_marginal_state(struct device *dev,
 		 */
 		if (rport->port_state == FC_PORTSTATE_ONLINE)
 			rport->port_state = port_state;
-		else
+		else if (port_state != rport->port_state)
 			return -EINVAL;
 	} else if (port_state == FC_PORTSTATE_ONLINE) {
 		/*
@@ -1262,7 +1262,7 @@ static ssize_t fc_rport_set_marginal_state(struct device *dev,
 		 */
 		if (rport->port_state == FC_PORTSTATE_MARGINAL)
 			rport->port_state = port_state;
-		else
+		else if (port_state != rport->port_state)
 			return -EINVAL;
 	} else
 		return -EINVAL;
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6f9eebd6c7ee..d58d99d8375e 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -129,12 +129,15 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 static int ad9832_write_frequency(struct ad9832_state *st,
 				  unsigned int addr, unsigned long fout)
 {
+	unsigned long clk_freq;
 	unsigned long regval;
 
-	if (fout > (clk_get_rate(st->mclk) / 2))
+	clk_freq = clk_get_rate(st->mclk);
+
+	if (!clk_freq || fout > (clk_freq / 2))
 		return -EINVAL;
 
-	regval = ad9832_calc_freqreg(clk_get_rate(st->mclk), fout);
+	regval = ad9832_calc_freqreg(clk_freq, fout);
 
 	st->freq_data[0] = cpu_to_be16((AD9832_CMD_FRE8BITSW << CMD_SHIFT) |
 					(addr << ADD_SHIFT) |
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index e2f9348725ff..e1b40a384868 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -4603,7 +4603,7 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 	int c;
 
 	if (op->data) {
-		font.data = kmalloc(max_font_size, GFP_KERNEL);
+		font.data = kzalloc(max_font_size, GFP_KERNEL);
 		if (!font.data)
 			return -ENOMEM;
 	} else
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 899ac9f9c279..6e18e8e76e8b 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -30,7 +30,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/init.h>
-#include <linux/timer.h>
+#include <linux/hrtimer.h>
 #include <linux/list.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
@@ -50,6 +50,8 @@
 #define POWER_BUDGET	500	/* in mA; use 8 for low-power port testing */
 #define POWER_BUDGET_3	900	/* in mA */
 
+#define DUMMY_TIMER_INT_NSECS	125000 /* 1 microframe */
+
 static const char	driver_name[] = "dummy_hcd";
 static const char	driver_desc[] = "USB Host+Gadget Emulator";
 
@@ -240,7 +242,7 @@ enum dummy_rh_state {
 struct dummy_hcd {
 	struct dummy			*dum;
 	enum dummy_rh_state		rh_state;
-	struct timer_list		timer;
+	struct hrtimer			timer;
 	u32				port_status;
 	u32				old_status;
 	unsigned long			re_timeout;
@@ -252,6 +254,7 @@ struct dummy_hcd {
 	u32				stream_en_ep;
 	u8				num_stream[30 / 2];
 
+	unsigned			timer_pending:1;
 	unsigned			active:1;
 	unsigned			old_active:1;
 	unsigned			resuming:1;
@@ -1302,8 +1305,11 @@ static int dummy_urb_enqueue(
 		urb->error_count = 1;		/* mark as a new urb */
 
 	/* kick the scheduler, it'll do the rest */
-	if (!timer_pending(&dum_hcd->timer))
-		mod_timer(&dum_hcd->timer, jiffies + 1);
+	if (!dum_hcd->timer_pending) {
+		dum_hcd->timer_pending = 1;
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+				HRTIMER_MODE_REL_SOFT);
+	}
 
  done:
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
@@ -1322,9 +1328,10 @@ static int dummy_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	spin_lock_irqsave(&dum_hcd->dum->lock, flags);
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
-	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
-		mod_timer(&dum_hcd->timer, jiffies);
+	if (rc == 0 && !dum_hcd->timer_pending) {
+		dum_hcd->timer_pending = 1;
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+	}
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1778,7 +1785,7 @@ static int handle_control_request(struct dummy_hcd *dum_hcd, struct urb *urb,
  * drivers except that the callbacks are invoked from soft interrupt
  * context.
  */
-static void dummy_timer(struct timer_list *t)
+static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 {
 	struct dummy_hcd	*dum_hcd = from_timer(dum_hcd, t, timer);
 	struct dummy		*dum = dum_hcd->dum;
@@ -1809,16 +1816,15 @@ static void dummy_timer(struct timer_list *t)
 		break;
 	}
 
-	/* FIXME if HZ != 1000 this will probably misbehave ... */
-
 	/* look at each urb queued by the host side driver */
 	spin_lock_irqsave(&dum->lock, flags);
+	dum_hcd->timer_pending = 0;
 
 	if (!dum_hcd->udev) {
 		dev_err(dummy_dev(dum_hcd),
 				"timer fired with no URBs pending?\n");
 		spin_unlock_irqrestore(&dum->lock, flags);
-		return;
+		return HRTIMER_NORESTART;
 	}
 	dum_hcd->next_frame_urbp = NULL;
 
@@ -1994,12 +2000,17 @@ static void dummy_timer(struct timer_list *t)
 	if (list_empty(&dum_hcd->urbp_list)) {
 		usb_put_dev(dum_hcd->udev);
 		dum_hcd->udev = NULL;
-	} else if (dum_hcd->rh_state == DUMMY_RH_RUNNING) {
+	} else if (!dum_hcd->timer_pending &&
+			dum_hcd->rh_state == DUMMY_RH_RUNNING) {
 		/* want a 1 msec delay here */
-		mod_timer(&dum_hcd->timer, jiffies + msecs_to_jiffies(1));
+		dum_hcd->timer_pending = 1;
+		hrtimer_start(&dum_hcd->timer, ns_to_ktime(DUMMY_TIMER_INT_NSECS),
+				HRTIMER_MODE_REL_SOFT);
 	}
 
 	spin_unlock_irqrestore(&dum->lock, flags);
+
+	return HRTIMER_NORESTART;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -2387,8 +2398,10 @@ static int dummy_bus_resume(struct usb_hcd *hcd)
 	} else {
 		dum_hcd->rh_state = DUMMY_RH_RUNNING;
 		set_link_state(dum_hcd);
-		if (!list_empty(&dum_hcd->urbp_list))
-			mod_timer(&dum_hcd->timer, jiffies);
+		if (!list_empty(&dum_hcd->urbp_list)) {
+			dum_hcd->timer_pending = 1;
+			hrtimer_start(&dum_hcd->timer, ns_to_ktime(0), HRTIMER_MODE_REL_SOFT);
+		}
 		hcd->state = HC_STATE_RUNNING;
 	}
 	spin_unlock_irq(&dum_hcd->dum->lock);
@@ -2466,7 +2479,8 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	timer_setup(&dum_hcd->timer, dummy_timer, 0);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2495,7 +2509,8 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
 
 	spin_lock_init(&dum_hcd->dum->lock);
-	timer_setup(&dum_hcd->timer, dummy_timer, 0);
+	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
+	dum_hcd->timer.function = dummy_timer;
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2514,8 +2529,12 @@ static int dummy_start(struct usb_hcd *hcd)
 
 static void dummy_stop(struct usb_hcd *hcd)
 {
-	device_remove_file(dummy_dev(hcd_to_dummy_hcd(hcd)), &dev_attr_urbs);
-	dev_info(dummy_dev(hcd_to_dummy_hcd(hcd)), "stopped\n");
+	struct dummy_hcd	*dum_hcd = hcd_to_dummy_hcd(hcd);
+
+	hrtimer_cancel(&dum_hcd->timer);
+	dum_hcd->timer_pending = 0;
+	device_remove_file(dummy_dev(dum_hcd), &dev_attr_urbs);
+	dev_info(dummy_dev(dum_hcd), "stopped\n");
 }
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index f95a7fdeb443..2ff049e02326 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -526,7 +526,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	pm_runtime_put_noidle(&dev->dev);
 
 	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
-		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get(&dev->dev);
 	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_allow(&dev->dev);
 
@@ -553,7 +553,9 @@ static void xhci_pci_remove(struct pci_dev *dev)
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
-	if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
+	if (pci_choose_state(dev, PMSG_SUSPEND) == PCI_D0)
+		pm_runtime_put(&dev->dev);
+	else if (xhci->quirks & XHCI_DEFAULT_PM_RUNTIME_ALLOW)
 		pm_runtime_forbid(&dev->dev);
 
 	if (xhci->shared_hcd) {
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 023803a8ef7d..49dfd307aba4 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1704,6 +1704,14 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	trace_xhci_handle_command(xhci->cmd_ring, &cmd_trb->generic);
 
+	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
+
+	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
+	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
+		complete_all(&xhci->cmd_ring_stop_completion);
+		return;
+	}
+
 	cmd_dequeue_dma = xhci_trb_virt_to_dma(xhci->cmd_ring->deq_seg,
 			cmd_trb);
 	/*
@@ -1720,14 +1728,6 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 
 	cancel_delayed_work(&xhci->cmd_timer);
 
-	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
-
-	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
-	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
-		complete_all(&xhci->cmd_ring_stop_completion);
-		return;
-	}
-
 	if (cmd->command_trb != xhci->cmd_ring->dequeue) {
 		xhci_err(xhci,
 			 "Command completion event does not match command\n");
diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 1b24492bb4e5..da2546b17bec 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -628,7 +628,7 @@ void devm_usb_put_phy(struct device *dev, struct usb_phy *phy)
 {
 	int r;
 
-	r = devres_destroy(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
+	r = devres_release(dev, devm_usb_phy_release, devm_usb_phy_match, phy);
 	dev_WARN_ONCE(dev, r, "couldn't find PHY resource\n");
 }
 EXPORT_SYMBOL_GPL(devm_usb_put_phy);
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 3d44e181dbb5..9ceb29904bbf 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2165,6 +2165,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 		altmodes[index] = alt;
 		index++;
 	}
+	fwnode_handle_put(altmodes_node);
 }
 EXPORT_SYMBOL_GPL(typec_port_register_altmodes);
 
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 07dc4ec73520..38d5260c4614 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -12,6 +12,7 @@
 #include <linux/swap.h>
 #include <linux/ctype.h>
 #include <linux/sched.h>
+#include <linux/iversion.h>
 #include <linux/task_io_accounting_ops.h>
 #include "internal.h"
 #include "afs_fs.h"
@@ -1808,6 +1809,8 @@ static int afs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 
 static void afs_rename_success(struct afs_operation *op)
 {
+	struct afs_vnode *vnode = AFS_FS_I(d_inode(op->dentry));
+
 	_enter("op=%08x", op->debug_id);
 
 	op->ctime = op->file[0].scb.status.mtime_client;
@@ -1817,6 +1820,22 @@ static void afs_rename_success(struct afs_operation *op)
 		op->ctime = op->file[1].scb.status.mtime_client;
 		afs_vnode_commit_status(op, &op->file[1]);
 	}
+
+	/* If we're moving a subdir between dirs, we need to update
+	 * its DV counter too as the ".." will be altered.
+	 */
+	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
+	    op->file[0].vnode != op->file[1].vnode) {
+		u64 new_dv;
+
+		write_seqlock(&vnode->cb_lock);
+
+		new_dv = vnode->status.data_version + 1;
+		vnode->status.data_version = new_dv;
+		inode_set_iversion_raw(&vnode->netfs.inode, new_dv);
+
+		write_sequnlock(&vnode->cb_lock);
+	}
 }
 
 static void afs_rename_edit_dir(struct afs_operation *op)
@@ -1858,6 +1877,12 @@ static void afs_rename_edit_dir(struct afs_operation *op)
 				 &vnode->fid, afs_edit_dir_for_rename_2);
 	}
 
+	if (S_ISDIR(vnode->netfs.inode.i_mode) &&
+	    new_dvnode != orig_dvnode &&
+	    test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+		afs_edit_dir_update_dotdot(vnode, new_dvnode,
+					   afs_edit_dir_for_rename_sub);
+
 	new_inode = d_inode(new_dentry);
 	if (new_inode) {
 		spin_lock(&new_inode->i_lock);
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index 0ab7752d1b75..e22682c57730 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -126,10 +126,10 @@ static struct folio *afs_dir_get_folio(struct afs_vnode *vnode, pgoff_t index)
 /*
  * Scan a directory block looking for a dirent of the right name.
  */
-static int afs_dir_scan_block(union afs_xdr_dir_block *block, struct qstr *name,
+static int afs_dir_scan_block(const union afs_xdr_dir_block *block, const struct qstr *name,
 			      unsigned int blocknum)
 {
-	union afs_xdr_dirent *de;
+	const union afs_xdr_dirent *de;
 	u64 bitmap;
 	int d, len, n;
 
@@ -491,3 +491,90 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
 	goto out_unmap;
 }
+
+/*
+ * Edit a subdirectory that has been moved between directories to update the
+ * ".." entry.
+ */
+void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
+				enum afs_edit_dir_reason why)
+{
+	union afs_xdr_dir_block *block;
+	union afs_xdr_dirent *de;
+	struct folio *folio;
+	unsigned int nr_blocks, b;
+	pgoff_t index;
+	loff_t i_size;
+	int slot;
+
+	_enter("");
+
+	i_size = i_size_read(&vnode->netfs.inode);
+	if (i_size < AFS_DIR_BLOCK_SIZE) {
+		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+		return;
+	}
+	nr_blocks = i_size / AFS_DIR_BLOCK_SIZE;
+
+	/* Find a block that has sufficient slots available.  Each folio
+	 * contains two or more directory blocks.
+	 */
+	for (b = 0; b < nr_blocks; b++) {
+		index = b / AFS_DIR_BLOCKS_PER_PAGE;
+		folio = afs_dir_get_folio(vnode, index);
+		if (!folio)
+			goto error;
+
+		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(folio));
+
+		/* Abandon the edit if we got a callback break. */
+		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
+			goto invalidated;
+
+		slot = afs_dir_scan_block(block, &dotdot_name, b);
+		if (slot >= 0)
+			goto found_dirent;
+
+		kunmap_local(block);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+
+	/* Didn't find the dirent to clobber.  Download the directory again. */
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_nodd,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+
+found_dirent:
+	de = &block->dirents[slot];
+	de->u.vnode  = htonl(new_dvnode->fid.vnode);
+	de->u.unique = htonl(new_dvnode->fid.unique);
+
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_dd, b, slot,
+			   ntohl(de->u.vnode), ntohl(de->u.unique), "..");
+
+	kunmap_local(block);
+	folio_unlock(folio);
+	folio_put(folio);
+	inode_set_iversion_raw(&vnode->netfs.inode, vnode->status.data_version);
+
+out:
+	_leave("");
+	return;
+
+invalidated:
+	kunmap_local(block);
+	folio_unlock(folio);
+	folio_put(folio);
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_inval,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+
+error:
+	trace_afs_edit_dir(vnode, why, afs_edit_dir_update_error,
+			   0, 0, 0, 0, "..");
+	clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
+	goto out;
+}
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index a25fdc3e5231..097d5a5f07b1 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1043,6 +1043,8 @@ extern void afs_check_for_remote_deletion(struct afs_operation *);
 extern void afs_edit_dir_add(struct afs_vnode *, struct qstr *, struct afs_fid *,
 			     enum afs_edit_dir_reason);
 extern void afs_edit_dir_remove(struct afs_vnode *, struct qstr *, enum afs_edit_dir_reason);
+void afs_edit_dir_update_dotdot(struct afs_vnode *vnode, struct afs_vnode *new_dvnode,
+				enum afs_edit_dir_reason why);
 
 /*
  * dir_silly.c
diff --git a/fs/dax.c b/fs/dax.c
index 72a437892b4a..ca7138bb1d54 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1225,35 +1225,46 @@ static s64 dax_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
-	loff_t pos = iter->pos;
-	loff_t length = iomap_length(iter);
+	loff_t copy_pos = iter->pos;
+	u64 copy_len = iomap_length(iter);
+	u32 mod;
 	int id = 0;
 	s64 ret = 0;
 	void *daddr = NULL, *saddr = NULL;
 
-	/* don't bother with blocks that are not shared to start with */
-	if (!(iomap->flags & IOMAP_F_SHARED))
-		return length;
+	if (!iomap_want_unshare_iter(iter))
+		return iomap_length(iter);
+
+	/*
+	 * Extend the file range to be aligned to fsblock/pagesize, because
+	 * we need to copy entire blocks, not just the byte range specified.
+	 * Invalidate the mapping because we're about to CoW.
+	 */
+	mod = offset_in_page(copy_pos);
+	if (mod) {
+		copy_len += mod;
+		copy_pos -= mod;
+	}
+
+	mod = offset_in_page(copy_pos + copy_len);
+	if (mod)
+		copy_len += PAGE_SIZE - mod;
+
+	invalidate_inode_pages2_range(iter->inode->i_mapping,
+				      copy_pos >> PAGE_SHIFT,
+				      (copy_pos + copy_len - 1) >> PAGE_SHIFT);
 
 	id = dax_read_lock();
-	ret = dax_iomap_direct_access(iomap, pos, length, &daddr, NULL);
+	ret = dax_iomap_direct_access(iomap, copy_pos, copy_len, &daddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	/* zero the distance if srcmap is HOLE or UNWRITTEN */
-	if (srcmap->flags & IOMAP_F_SHARED || srcmap->type == IOMAP_UNWRITTEN) {
-		memset(daddr, 0, length);
-		dax_flush(iomap->dax_dev, daddr, length);
-		ret = length;
-		goto out_unlock;
-	}
-
-	ret = dax_iomap_direct_access(srcmap, pos, length, &saddr, NULL);
+	ret = dax_iomap_direct_access(srcmap, copy_pos, copy_len, &saddr, NULL);
 	if (ret < 0)
 		goto out_unlock;
 
-	if (copy_mc_to_kernel(daddr, saddr, length) == 0)
-		ret = length;
+	if (copy_mc_to_kernel(daddr, saddr, copy_len) == 0)
+		ret = iomap_length(iter);
 	else
 		ret = -EIO;
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1833608f3931..47f44b02c17d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1087,42 +1087,41 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 {
 	struct iomap *iomap = &iter->iomap;
-	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	loff_t pos = iter->pos;
 	loff_t length = iomap_length(iter);
-	long status = 0;
 	loff_t written = 0;
 
-	/* don't bother with blocks that are not shared to start with */
-	if (!(iomap->flags & IOMAP_F_SHARED))
-		return length;
-	/* don't bother with holes or unwritten extents */
-	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+	if (!iomap_want_unshare_iter(iter))
 		return length;
 
 	do {
-		unsigned long offset = offset_in_page(pos);
-		unsigned long bytes = min_t(loff_t, PAGE_SIZE - offset, length);
 		struct folio *folio;
+		int status;
+		size_t offset;
+		size_t bytes = min_t(u64, SIZE_MAX, length);
 
 		status = iomap_write_begin(iter, pos, bytes, &folio);
 		if (unlikely(status))
 			return status;
-		if (iter->iomap.flags & IOMAP_F_STALE)
+		if (iomap->flags & IOMAP_F_STALE)
 			break;
 
-		status = iomap_write_end(iter, pos, bytes, bytes, folio);
-		if (WARN_ON_ONCE(status == 0))
+		offset = offset_in_folio(folio, pos);
+		if (bytes > folio_size(folio) - offset)
+			bytes = folio_size(folio) - offset;
+
+		bytes = iomap_write_end(iter, pos, bytes, bytes, folio);
+		if (WARN_ON_ONCE(bytes == 0))
 			return -EIO;
 
 		cond_resched();
 
-		pos += status;
-		written += status;
-		length -= status;
+		pos += bytes;
+		written += bytes;
+		length -= bytes;
 
 		balance_dirty_pages_ratelimited(iter->inode->i_mapping);
-	} while (length);
+	} while (length > 0);
 
 	return written;
 }
diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 2ba4d221bf9d..39c697e100b1 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -981,6 +981,11 @@ void nfs_delegation_mark_returned(struct inode *inode,
 	}
 
 	nfs_mark_delegation_revoked(delegation);
+	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
+	spin_unlock(&delegation->lock);
+	if (nfs_detach_delegation(NFS_I(inode), delegation, NFS_SERVER(inode)))
+		nfs_put_delegation(delegation);
+	goto out_rcu_unlock;
 
 out_clear_returning:
 	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 180e1ce42d21..ffaca278acd3 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -157,6 +157,9 @@ static int nilfs_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	/* slow symlink */
 	inode->i_op = &nilfs_symlink_inode_operations;
 	inode_nohighmem(inode);
+	mapping_set_gfp_mask(inode->i_mapping,
+			     mapping_gfp_constraint(inode->i_mapping,
+						    ~__GFP_FS));
 	inode->i_mapping->a_ops = &nilfs_aops;
 	err = page_symlink(inode, symname, l);
 	if (err)
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 19bc8eea2b35..6bc4cda804e1 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -404,6 +404,7 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
+	ClearPageChecked(page);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *bh, *head;
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index e19510f97711..d41ddc06f207 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -102,7 +102,9 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec &&
+	    is_rec_inuse(ni->mi.mrec) &&
+	    !(ni->mi.sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 28cbae395431..026ed43c0670 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -524,11 +524,15 @@ struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
 	if (inode->i_state & I_NEW)
 		inode = ntfs_read_mft(inode, name, ref);
 	else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {
-		/* Inode overlaps? */
-		_ntfs_bad_inode(inode);
+		/*
+		 * Sequence number is not expected.
+		 * Looks like inode was reused but caller uses the old reference
+		 */
+		iput(inode);
+		inode = ERR_PTR(-ESTALE);
 	}
 
-	if (IS_ERR(inode) && name)
+	if (IS_ERR(inode))
 		ntfs_set_state(sb->s_fs_info, NTFS_DIRTY_ERROR);
 
 	return inode;
diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 28f654561f27..09db01c1098c 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -236,6 +236,9 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 *unc_end, const u8 *cmpr,
 
 	/* Do decompression until pointers are inside range. */
 	while (up < unc_end && cmpr < cmpr_end) {
+		// return err if more than LZNT_CHUNK_SIZE bytes are written
+		if (up - unc > LZNT_CHUNK_SIZE)
+			return -EINVAL;
 		/* Correct index */
 		while (unc + s_max_off[index] < up)
 			index += 1;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index a9549e73081f..7cad1bc2b314 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -79,7 +79,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err < 0)
 			inode = ERR_PTR(err);
 		else {
-			ni_lock(ni);
+			ni_lock_dir(ni);
 			inode = dir_search_u(dir, uni, NULL);
 			ni_unlock(ni);
 		}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a88f6879fcaa..26dbe1b46fdd 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -328,7 +328,7 @@ struct mft_inode {
 
 /* Nested class for ntfs_inode::ni_lock. */
 enum ntfs_inode_mutex_lock_class {
-	NTFS_INODE_MUTEX_DIRTY,
+	NTFS_INODE_MUTEX_DIRTY = 1,
 	NTFS_INODE_MUTEX_SECURITY,
 	NTFS_INODE_MUTEX_OBJID,
 	NTFS_INODE_MUTEX_REPARSE,
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index f502bb2ce2ea..ea7c79e8ce42 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1784,6 +1784,14 @@ int ocfs2_remove_inode_range(struct inode *inode,
 		return 0;
 
 	if (OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) {
+		int id_count = ocfs2_max_inline_data_with_xattr(inode->i_sb, di);
+
+		if (byte_start > id_count || byte_start + byte_len > id_count) {
+			ret = -EINVAL;
+			mlog_errno(ret);
+			goto out;
+		}
+
 		ret = ocfs2_truncate_inline(inode, di_bh, byte_start,
 					    byte_start + byte_len, 0);
 		if (ret) {
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index dff921f7ca33..a2d430549012 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -25,7 +25,7 @@
 #include <linux/memblock.h>
 #include <linux/init.h>
 #include <linux/slab.h>
-#include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <asm/io.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
@@ -51,6 +51,20 @@ static struct proc_dir_entry *proc_root_kcore;
 #define	kc_offset_to_vaddr(o) ((o) + PAGE_OFFSET)
 #endif
 
+#ifndef kc_xlate_dev_mem_ptr
+#define kc_xlate_dev_mem_ptr kc_xlate_dev_mem_ptr
+static inline void *kc_xlate_dev_mem_ptr(phys_addr_t phys)
+{
+	return __va(phys);
+}
+#endif
+#ifndef kc_unxlate_dev_mem_ptr
+#define kc_unxlate_dev_mem_ptr kc_unxlate_dev_mem_ptr
+static inline void kc_unxlate_dev_mem_ptr(phys_addr_t phys, void *virt)
+{
+}
+#endif
+
 static LIST_HEAD(kclist_head);
 static DECLARE_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
@@ -309,9 +323,12 @@ static void append_kcore_note(char *notes, size_t *i, const char *name,
 }
 
 static ssize_t
-read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
+read_kcore_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct file *file = iocb->ki_filp;
 	char *buf = file->private_data;
+	loff_t *fpos = &iocb->ki_pos;
+
 	size_t phdrs_offset, notes_offset, data_offset;
 	size_t page_offline_frozen = 1;
 	size_t phdrs_len, notes_len;
@@ -319,6 +336,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	size_t tsz;
 	int nphdr;
 	unsigned long start;
+	size_t buflen = iov_iter_count(iter);
 	size_t orig_buflen = buflen;
 	int ret = 0;
 
@@ -357,12 +375,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		};
 
 		tsz = min_t(size_t, buflen, sizeof(struct elfhdr) - *fpos);
-		if (copy_to_user(buffer, (char *)&ehdr + *fpos, tsz)) {
+		if (copy_to_iter((char *)&ehdr + *fpos, tsz, iter) != tsz) {
 			ret = -EFAULT;
 			goto out;
 		}
 
-		buffer += tsz;
 		buflen -= tsz;
 		*fpos += tsz;
 	}
@@ -399,15 +416,14 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		}
 
 		tsz = min_t(size_t, buflen, phdrs_offset + phdrs_len - *fpos);
-		if (copy_to_user(buffer, (char *)phdrs + *fpos - phdrs_offset,
-				 tsz)) {
+		if (copy_to_iter((char *)phdrs + *fpos - phdrs_offset, tsz,
+				 iter) != tsz) {
 			kfree(phdrs);
 			ret = -EFAULT;
 			goto out;
 		}
 		kfree(phdrs);
 
-		buffer += tsz;
 		buflen -= tsz;
 		*fpos += tsz;
 	}
@@ -449,14 +465,13 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 				  min(vmcoreinfo_size, notes_len - i));
 
 		tsz = min_t(size_t, buflen, notes_offset + notes_len - *fpos);
-		if (copy_to_user(buffer, notes + *fpos - notes_offset, tsz)) {
+		if (copy_to_iter(notes + *fpos - notes_offset, tsz, iter) != tsz) {
 			kfree(notes);
 			ret = -EFAULT;
 			goto out;
 		}
 		kfree(notes);
 
-		buffer += tsz;
 		buflen -= tsz;
 		*fpos += tsz;
 	}
@@ -473,6 +488,8 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	while (buflen) {
 		struct page *page;
 		unsigned long pfn;
+		phys_addr_t phys;
+		void *__start;
 
 		/*
 		 * If this is the first iteration or the address is not within
@@ -498,7 +515,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		}
 
 		if (!m) {
-			if (clear_user(buffer, tsz)) {
+			if (iov_iter_zero(tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -509,20 +526,21 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		case KCORE_VMALLOC:
 			vread(buf, (char *)start, tsz);
 			/* we have to zero-fill user buffer even if no read */
-			if (copy_to_user(buffer, buf, tsz)) {
+			if (copy_to_iter(buf, tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
 			break;
 		case KCORE_USER:
 			/* User page is handled prior to normal kernel page: */
-			if (copy_to_user(buffer, (char *)start, tsz)) {
+			if (copy_to_iter((char *)start, tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
 			break;
 		case KCORE_RAM:
-			pfn = __pa(start) >> PAGE_SHIFT;
+			phys = __pa(start);
+			pfn =  phys >> PAGE_SHIFT;
 			page = pfn_to_online_page(pfn);
 
 			/*
@@ -532,7 +550,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			 */
 			if (!page || PageOffline(page) ||
 			    is_page_hwpoison(page) || !pfn_is_ram(pfn)) {
-				if (clear_user(buffer, tsz)) {
+				if (iov_iter_zero(tsz, iter) != tsz) {
 					ret = -EFAULT;
 					goto out;
 				}
@@ -541,33 +559,44 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 			fallthrough;
 		case KCORE_VMEMMAP:
 		case KCORE_TEXT:
-			if (kern_addr_valid(start)) {
-				/*
-				 * Using bounce buffer to bypass the
-				 * hardened user copy kernel text checks.
-				 */
-				if (copy_from_kernel_nofault(buf, (void *)start,
-						tsz)) {
-					if (clear_user(buffer, tsz)) {
+			if (m->type == KCORE_RAM) {
+				__start = kc_xlate_dev_mem_ptr(phys);
+				if (!__start) {
+					ret = -ENOMEM;
+					if (iov_iter_zero(tsz, iter) != tsz)
 						ret = -EFAULT;
-						goto out;
-					}
-				} else {
-					if (copy_to_user(buffer, buf, tsz)) {
-						ret = -EFAULT;
-						goto out;
-					}
+					goto out;
 				}
 			} else {
-				if (clear_user(buffer, tsz)) {
+				__start = (void *)start;
+			}
+
+			/*
+			 * Sadly we must use a bounce buffer here to be able to
+			 * make use of copy_from_kernel_nofault(), as these
+			 * memory regions might not always be mapped on all
+			 * architectures.
+			 */
+			ret = copy_from_kernel_nofault(buf, __start, tsz);
+			if (m->type == KCORE_RAM)
+				kc_unxlate_dev_mem_ptr(phys, __start);
+			if (ret) {
+				if (iov_iter_zero(tsz, iter) != tsz) {
 					ret = -EFAULT;
 					goto out;
 				}
+			/*
+			 * We know the bounce buffer is safe to copy from, so
+			 * use _copy_to_iter() directly.
+			 */
+			} else if (_copy_to_iter(buf, tsz, iter) != tsz) {
+				ret = -EFAULT;
+				goto out;
 			}
 			break;
 		default:
 			pr_warn_once("Unhandled KCORE type: %d\n", m->type);
-			if (clear_user(buffer, tsz)) {
+			if (iov_iter_zero(tsz, iter) != tsz) {
 				ret = -EFAULT;
 				goto out;
 			}
@@ -575,7 +604,6 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 skip:
 		buflen -= tsz;
 		*fpos += tsz;
-		buffer += tsz;
 		start += tsz;
 		tsz = (buflen > PAGE_SIZE ? PAGE_SIZE : buflen);
 	}
@@ -619,7 +647,7 @@ static int release_kcore(struct inode *inode, struct file *file)
 }
 
 static const struct proc_ops kcore_proc_ops = {
-	.proc_read	= read_kcore,
+	.proc_read_iter	= read_kcore_iter,
 	.proc_open	= open_kcore,
 	.proc_release	= release_kcore,
 	.proc_lseek	= default_llseek,
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 2d1ec0e6ee01..de3bda334abf 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -65,7 +65,7 @@ struct cpc_desc {
 	int write_cmd_status;
 	int write_cmd_id;
 	/* Lock used for RMW operations in cpc_write() */
-	spinlock_t rmw_lock;
+	raw_spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 149a520515e1..74dc72b2c3a7 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -102,26 +102,26 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
-#if __has_attribute(__no_sanitize_address__)
-#define __no_sanitize_address __attribute__((no_sanitize_address))
+#ifdef __SANITIZE_HWADDRESS__
+#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress")))
 #else
-#define __no_sanitize_address
+#define __no_sanitize_address __attribute__((__no_sanitize_address__))
 #endif
 
 #if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
-#define __no_sanitize_thread __attribute__((no_sanitize_thread))
+#define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
 #else
 #define __no_sanitize_thread
 #endif
 
 #if __has_attribute(__no_sanitize_undefined__)
-#define __no_sanitize_undefined __attribute__((no_sanitize_undefined))
+#define __no_sanitize_undefined __attribute__((__no_sanitize_undefined__))
 #else
 #define __no_sanitize_undefined
 #endif
 
 #if defined(CONFIG_KCOV) && __has_attribute(__no_sanitize_coverage__)
-#define __no_sanitize_coverage __attribute__((no_sanitize_coverage))
+#define __no_sanitize_coverage __attribute__((__no_sanitize_coverage__))
 #else
 #define __no_sanitize_coverage
 #endif
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9d208648c84d..3759d0a15c7b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1123,52 +1123,51 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 }
 
 static inline int parse_perf_domain(int cpu, const char *list_name,
-				    const char *cell_name)
+				    const char *cell_name,
+				    struct of_phandle_args *args)
 {
-	struct device_node *cpu_np;
-	struct of_phandle_args args;
 	int ret;
 
-	cpu_np = of_cpu_device_node_get(cpu);
+	struct device_node *cpu_np __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!cpu_np)
 		return -ENODEV;
 
 	ret = of_parse_phandle_with_args(cpu_np, list_name, cell_name, 0,
-					 &args);
+					 args);
 	if (ret < 0)
 		return ret;
-
-	of_node_put(cpu_np);
-
-	return args.args[0];
+	return 0;
 }
 
 static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
-						     const char *cell_name, struct cpumask *cpumask)
+						     const char *cell_name, struct cpumask *cpumask,
+						     struct of_phandle_args *pargs)
 {
-	int target_idx;
 	int cpu, ret;
+	struct of_phandle_args args;
 
-	ret = parse_perf_domain(pcpu, list_name, cell_name);
+	ret = parse_perf_domain(pcpu, list_name, cell_name, pargs);
 	if (ret < 0)
 		return ret;
 
-	target_idx = ret;
 	cpumask_set_cpu(pcpu, cpumask);
 
 	for_each_possible_cpu(cpu) {
 		if (cpu == pcpu)
 			continue;
 
-		ret = parse_perf_domain(cpu, list_name, cell_name);
+		ret = parse_perf_domain(cpu, list_name, cell_name, &args);
 		if (ret < 0)
 			continue;
 
-		if (target_idx == ret)
+		if (pargs->np == args.np && pargs->args_count == args.args_count &&
+		    !memcmp(pargs->args, args.args, sizeof(args.args[0]) * args.args_count))
 			cpumask_set_cpu(cpu, cpumask);
+
+		of_node_put(args.np);
 	}
 
-	return target_idx;
+	return 0;
 }
 #else
 static inline int cpufreq_boost_trigger_state(int state)
@@ -1198,7 +1197,8 @@ cpufreq_table_set_inefficient(struct cpufreq_policy *policy,
 }
 
 static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_name,
-						     const char *cell_name, struct cpumask *cpumask)
+						     const char *cell_name, struct cpumask *cpumask,
+						     struct of_phandle_args *pargs)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 33c496130983..0d32634c5cf0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3029,6 +3029,42 @@ static inline void file_end_write(struct file *file)
 	__sb_end_write(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 }
 
+/**
+ * kiocb_start_write - get write access to a superblock for async file io
+ * @iocb: the io context we want to submit the write with
+ *
+ * This is a variant of sb_start_write() for async io submission.
+ * Should be matched with a call to kiocb_end_write().
+ */
+static inline void kiocb_start_write(struct kiocb *iocb)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	sb_start_write(inode->i_sb);
+	/*
+	 * Fool lockdep by telling it the lock got released so that it
+	 * doesn't complain about the held lock when we return to userspace.
+	 */
+	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+}
+
+/**
+ * kiocb_end_write - drop write access to a superblock after async file io
+ * @iocb: the io context we sumbitted the write with
+ *
+ * Should be matched with a call to kiocb_start_write().
+ */
+static inline void kiocb_end_write(struct kiocb *iocb)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	/*
+	 * Tell lockdep we inherited freeze protection from submission thread.
+	 */
+	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+	sb_end_write(inode->i_sb);
+}
+
 /*
  * This is used for regular files where some users -- especially the
  * currently executed binary in a process, previously handled via
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0983dfc9a203..1de65d5d79d4 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -251,6 +251,25 @@ static inline const struct iomap *iomap_iter_srcmap(const struct iomap_iter *i)
 	return &i->iomap;
 }
 
+/*
+ * Check if the range needs to be unshared for a FALLOC_FL_UNSHARE_RANGE
+ * operation.
+ *
+ * Don't bother with blocks that are not shared to start with; or mappings that
+ * cannot be shared, such as inline data, delalloc reservations, holes or
+ * unwritten extents.
+ *
+ * Note that we use srcmap directly instead of iomap_iter_srcmap as unsharing
+ * requires providing a separate source map, and the presence of one is a good
+ * indicator that unsharing is needed, unlike IOMAP_F_SHARED which can be set
+ * for any data that goes into the COW fork for XFS.
+ */
+static inline bool iomap_want_unshare_iter(const struct iomap_iter *iter)
+{
+	return (iter->iomap.flags & IOMAP_F_SHARED) &&
+		iter->srcmap.type == IOMAP_MAPPED;
+}
+
 ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3ef77f52a4f0..7376074f2e1e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -18,6 +18,7 @@ struct migration_target_control;
  * - zero on page migration success;
  */
 #define MIGRATEPAGE_SUCCESS		0
+#define MIGRATEPAGE_UNMAP		1
 
 /**
  * struct movable_operations - Driver page migration
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 0cc077c3dda3..f1ba369306fe 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -252,7 +252,7 @@ static inline void ip_tunnel_init_flow(struct flowi4 *fl4,
 	memset(fl4, 0, sizeof(*fl4));
 
 	if (oif) {
-		fl4->flowi4_l3mdev = l3mdev_master_upper_ifindex_by_index_rcu(net, oif);
+		fl4->flowi4_l3mdev = l3mdev_master_upper_ifindex_by_index(net, oif);
 		/* Legacy VRF/l3mdev use case */
 		fl4->flowi4_oif = fl4->flowi4_l3mdev ? 0 : oif;
 	}
diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
index e9d412d19dbb..d1ee4272d1cb 100644
--- a/include/trace/events/afs.h
+++ b/include/trace/events/afs.h
@@ -18,97 +18,6 @@
 #ifndef __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
-enum afs_call_trace {
-	afs_call_trace_alloc,
-	afs_call_trace_free,
-	afs_call_trace_get,
-	afs_call_trace_put,
-	afs_call_trace_wake,
-	afs_call_trace_work,
-};
-
-enum afs_server_trace {
-	afs_server_trace_alloc,
-	afs_server_trace_callback,
-	afs_server_trace_destroy,
-	afs_server_trace_free,
-	afs_server_trace_gc,
-	afs_server_trace_get_by_addr,
-	afs_server_trace_get_by_uuid,
-	afs_server_trace_get_caps,
-	afs_server_trace_get_install,
-	afs_server_trace_get_new_cbi,
-	afs_server_trace_get_probe,
-	afs_server_trace_give_up_cb,
-	afs_server_trace_purging,
-	afs_server_trace_put_call,
-	afs_server_trace_put_cbi,
-	afs_server_trace_put_find_rsq,
-	afs_server_trace_put_probe,
-	afs_server_trace_put_slist,
-	afs_server_trace_put_slist_isort,
-	afs_server_trace_put_uuid_rsq,
-	afs_server_trace_update,
-};
-
-
-enum afs_volume_trace {
-	afs_volume_trace_alloc,
-	afs_volume_trace_free,
-	afs_volume_trace_get_alloc_sbi,
-	afs_volume_trace_get_cell_insert,
-	afs_volume_trace_get_new_op,
-	afs_volume_trace_get_query_alias,
-	afs_volume_trace_put_cell_dup,
-	afs_volume_trace_put_cell_root,
-	afs_volume_trace_put_destroy_sbi,
-	afs_volume_trace_put_free_fc,
-	afs_volume_trace_put_put_op,
-	afs_volume_trace_put_query_alias,
-	afs_volume_trace_put_validate_fc,
-	afs_volume_trace_remove,
-};
-
-enum afs_cell_trace {
-	afs_cell_trace_alloc,
-	afs_cell_trace_free,
-	afs_cell_trace_get_queue_dns,
-	afs_cell_trace_get_queue_manage,
-	afs_cell_trace_get_queue_new,
-	afs_cell_trace_get_vol,
-	afs_cell_trace_insert,
-	afs_cell_trace_manage,
-	afs_cell_trace_put_candidate,
-	afs_cell_trace_put_destroy,
-	afs_cell_trace_put_queue_fail,
-	afs_cell_trace_put_queue_work,
-	afs_cell_trace_put_vol,
-	afs_cell_trace_see_source,
-	afs_cell_trace_see_ws,
-	afs_cell_trace_unuse_alias,
-	afs_cell_trace_unuse_check_alias,
-	afs_cell_trace_unuse_delete,
-	afs_cell_trace_unuse_fc,
-	afs_cell_trace_unuse_lookup,
-	afs_cell_trace_unuse_mntpt,
-	afs_cell_trace_unuse_no_pin,
-	afs_cell_trace_unuse_parse,
-	afs_cell_trace_unuse_pin,
-	afs_cell_trace_unuse_probe,
-	afs_cell_trace_unuse_sbi,
-	afs_cell_trace_unuse_ws,
-	afs_cell_trace_use_alias,
-	afs_cell_trace_use_check_alias,
-	afs_cell_trace_use_fc,
-	afs_cell_trace_use_fc_alias,
-	afs_cell_trace_use_lookup,
-	afs_cell_trace_use_mntpt,
-	afs_cell_trace_use_pin,
-	afs_cell_trace_use_probe,
-	afs_cell_trace_use_sbi,
-	afs_cell_trace_wait,
-};
-
 enum afs_fs_operation {
 	afs_FS_FetchData		= 130,	/* AFS Fetch file data */
 	afs_FS_FetchACL			= 131,	/* AFS Fetch file ACL */
@@ -202,121 +111,6 @@ enum yfs_cm_operation {
 	yfs_CB_CallBack			= 64204,
 };
 
-enum afs_edit_dir_op {
-	afs_edit_dir_create,
-	afs_edit_dir_create_error,
-	afs_edit_dir_create_inval,
-	afs_edit_dir_create_nospc,
-	afs_edit_dir_delete,
-	afs_edit_dir_delete_error,
-	afs_edit_dir_delete_inval,
-	afs_edit_dir_delete_noent,
-};
-
-enum afs_edit_dir_reason {
-	afs_edit_dir_for_create,
-	afs_edit_dir_for_link,
-	afs_edit_dir_for_mkdir,
-	afs_edit_dir_for_rename_0,
-	afs_edit_dir_for_rename_1,
-	afs_edit_dir_for_rename_2,
-	afs_edit_dir_for_rmdir,
-	afs_edit_dir_for_silly_0,
-	afs_edit_dir_for_silly_1,
-	afs_edit_dir_for_symlink,
-	afs_edit_dir_for_unlink,
-};
-
-enum afs_eproto_cause {
-	afs_eproto_bad_status,
-	afs_eproto_cb_count,
-	afs_eproto_cb_fid_count,
-	afs_eproto_cellname_len,
-	afs_eproto_file_type,
-	afs_eproto_ibulkst_cb_count,
-	afs_eproto_ibulkst_count,
-	afs_eproto_motd_len,
-	afs_eproto_offline_msg_len,
-	afs_eproto_volname_len,
-	afs_eproto_yvl_fsendpt4_len,
-	afs_eproto_yvl_fsendpt6_len,
-	afs_eproto_yvl_fsendpt_num,
-	afs_eproto_yvl_fsendpt_type,
-	afs_eproto_yvl_vlendpt4_len,
-	afs_eproto_yvl_vlendpt6_len,
-	afs_eproto_yvl_vlendpt_type,
-};
-
-enum afs_io_error {
-	afs_io_error_cm_reply,
-	afs_io_error_extract,
-	afs_io_error_fs_probe_fail,
-	afs_io_error_vl_lookup_fail,
-	afs_io_error_vl_probe_fail,
-};
-
-enum afs_file_error {
-	afs_file_error_dir_bad_magic,
-	afs_file_error_dir_big,
-	afs_file_error_dir_missing_page,
-	afs_file_error_dir_name_too_long,
-	afs_file_error_dir_over_end,
-	afs_file_error_dir_small,
-	afs_file_error_dir_unmarked_ext,
-	afs_file_error_mntpt,
-	afs_file_error_writeback_fail,
-};
-
-enum afs_flock_event {
-	afs_flock_acquired,
-	afs_flock_callback_break,
-	afs_flock_defer_unlock,
-	afs_flock_extend_fail,
-	afs_flock_fail_other,
-	afs_flock_fail_perm,
-	afs_flock_no_lockers,
-	afs_flock_release_fail,
-	afs_flock_silly_delete,
-	afs_flock_timestamp,
-	afs_flock_try_to_lock,
-	afs_flock_vfs_lock,
-	afs_flock_vfs_locking,
-	afs_flock_waited,
-	afs_flock_waiting,
-	afs_flock_work_extending,
-	afs_flock_work_retry,
-	afs_flock_work_unlocking,
-	afs_flock_would_block,
-};
-
-enum afs_flock_operation {
-	afs_flock_op_copy_lock,
-	afs_flock_op_flock,
-	afs_flock_op_grant,
-	afs_flock_op_lock,
-	afs_flock_op_release_lock,
-	afs_flock_op_return_ok,
-	afs_flock_op_return_eagain,
-	afs_flock_op_return_edeadlk,
-	afs_flock_op_return_error,
-	afs_flock_op_set_lock,
-	afs_flock_op_unlock,
-	afs_flock_op_wake,
-};
-
-enum afs_cb_break_reason {
-	afs_cb_break_no_break,
-	afs_cb_break_no_promise,
-	afs_cb_break_for_callback,
-	afs_cb_break_for_deleted,
-	afs_cb_break_for_lapsed,
-	afs_cb_break_for_s_reinit,
-	afs_cb_break_for_unlink,
-	afs_cb_break_for_v_break,
-	afs_cb_break_for_volume_callback,
-	afs_cb_break_for_zap,
-};
-
 #endif /* end __AFS_DECLARE_TRACE_ENUMS_ONCE_ONLY */
 
 /*
@@ -391,6 +185,7 @@ enum afs_cb_break_reason {
 	EM(afs_cell_trace_unuse_fc,		"UNU fc    ") \
 	EM(afs_cell_trace_unuse_lookup,		"UNU lookup") \
 	EM(afs_cell_trace_unuse_mntpt,		"UNU mntpt ") \
+	EM(afs_cell_trace_unuse_no_pin,		"UNU no-pin") \
 	EM(afs_cell_trace_unuse_parse,		"UNU parse ") \
 	EM(afs_cell_trace_unuse_pin,		"UNU pin   ") \
 	EM(afs_cell_trace_unuse_probe,		"UNU probe ") \
@@ -500,7 +295,11 @@ enum afs_cb_break_reason {
 	EM(afs_edit_dir_delete,			"delete") \
 	EM(afs_edit_dir_delete_error,		"d_err ") \
 	EM(afs_edit_dir_delete_inval,		"d_invl") \
-	E_(afs_edit_dir_delete_noent,		"d_nent")
+	EM(afs_edit_dir_delete_noent,		"d_nent") \
+	EM(afs_edit_dir_update_dd,		"u_ddot") \
+	EM(afs_edit_dir_update_error,		"u_fail") \
+	EM(afs_edit_dir_update_inval,		"u_invl") \
+	E_(afs_edit_dir_update_nodd,		"u_nodd")
 
 #define afs_edit_dir_reasons				  \
 	EM(afs_edit_dir_for_create,		"Create") \
@@ -509,6 +308,7 @@ enum afs_cb_break_reason {
 	EM(afs_edit_dir_for_rename_0,		"Renam0") \
 	EM(afs_edit_dir_for_rename_1,		"Renam1") \
 	EM(afs_edit_dir_for_rename_2,		"Renam2") \
+	EM(afs_edit_dir_for_rename_sub,		"RnmSub") \
 	EM(afs_edit_dir_for_rmdir,		"RmDir ") \
 	EM(afs_edit_dir_for_silly_0,		"S_Ren0") \
 	EM(afs_edit_dir_for_silly_1,		"S_Ren1") \
@@ -614,6 +414,32 @@ enum afs_cb_break_reason {
 	EM(afs_cb_break_for_volume_callback,	"break-v-cb")		\
 	E_(afs_cb_break_for_zap,		"break-zap")
 
+/*
+ * Generate enums for tracing information.
+ */
+#ifndef __AFS_GENERATE_TRACE_ENUMS_ONCE_ONLY
+#define __AFS_GENERATE_TRACE_ENUMS_ONCE_ONLY
+
+#undef EM
+#undef E_
+#define EM(a, b) a,
+#define E_(a, b) a
+
+enum afs_call_trace		{ afs_call_traces } __mode(byte);
+enum afs_cb_break_reason	{ afs_cb_break_reasons } __mode(byte);
+enum afs_cell_trace		{ afs_cell_traces } __mode(byte);
+enum afs_edit_dir_op		{ afs_edit_dir_ops } __mode(byte);
+enum afs_edit_dir_reason	{ afs_edit_dir_reasons } __mode(byte);
+enum afs_eproto_cause		{ afs_eproto_causes } __mode(byte);
+enum afs_file_error		{ afs_file_errors } __mode(byte);
+enum afs_flock_event		{ afs_flock_events } __mode(byte);
+enum afs_flock_operation	{ afs_flock_operations } __mode(byte);
+enum afs_io_error		{ afs_io_errors } __mode(byte);
+enum afs_server_trace		{ afs_server_traces } __mode(byte);
+enum afs_volume_trace		{ afs_volume_traces } __mode(byte);
+
+#endif /* end __AFS_GENERATE_TRACE_ENUMS_ONCE_ONLY */
+
 /*
  * Export enum symbols via userspace.
  */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index f902b161f02c..92c1aa8f3501 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -593,6 +593,8 @@ static bool __io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
 	bool all_flushed;
 	size_t cqe_size = sizeof(struct io_uring_cqe);
 
+	lockdep_assert_held(&ctx->uring_lock);
+
 	if (!force && __io_cqring_events(ctx) == ctx->cq_entries)
 		return false;
 
@@ -647,12 +649,9 @@ static bool io_cqring_overflow_flush(struct io_ring_ctx *ctx)
 	bool ret = true;
 
 	if (test_bit(IO_CHECK_CQ_OVERFLOW_BIT, &ctx->check_cq)) {
-		/* iopoll syncs against uring_lock, not completion_lock */
-		if (ctx->flags & IORING_SETUP_IOPOLL)
-			mutex_lock(&ctx->uring_lock);
+		mutex_lock(&ctx->uring_lock);
 		ret = __io_cqring_overflow_flush(ctx, false);
-		if (ctx->flags & IORING_SETUP_IOPOLL)
-			mutex_unlock(&ctx->uring_lock);
+		mutex_unlock(&ctx->uring_lock);
 	}
 
 	return ret;
@@ -1405,6 +1404,8 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, long min)
 	int ret = 0;
 	unsigned long check_cq;
 
+	lockdep_assert_held(&ctx->uring_lock);
+
 	if (!io_allowed_run_tw(ctx))
 		return -EEXIST;
 
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 038e6b13a749..9d6e17a244ae 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -220,17 +220,12 @@ static bool io_rw_should_reissue(struct io_kiocb *req)
 }
 #endif
 
-static void kiocb_end_write(struct io_kiocb *req)
+static void io_req_end_write(struct io_kiocb *req)
 {
-	/*
-	 * Tell lockdep we inherited freeze protection from submission
-	 * thread.
-	 */
 	if (req->flags & REQ_F_ISREG) {
-		struct super_block *sb = file_inode(req->file)->i_sb;
+		struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 
-		__sb_writers_acquired(sb, SB_FREEZE_WRITE);
-		sb_end_write(sb);
+		kiocb_end_write(&rw->kiocb);
 	}
 }
 
@@ -243,7 +238,7 @@ static void io_req_io_end(struct io_kiocb *req)
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
 
 	if (rw->kiocb.ki_flags & IOCB_WRITE) {
-		kiocb_end_write(req);
+		io_req_end_write(req);
 		fsnotify_modify(req->file);
 	} else {
 		fsnotify_access(req->file);
@@ -307,7 +302,7 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	struct io_kiocb *req = cmd_to_io_kiocb(rw);
 
 	if (kiocb->ki_flags & IOCB_WRITE)
-		kiocb_end_write(req);
+		io_req_end_write(req);
 	if (unlikely(res != req->cqe.res)) {
 		if (res == -EAGAIN && io_rw_should_reissue(req)) {
 			req->flags |= REQ_F_REISSUE | REQ_F_PARTIAL_IO;
@@ -844,6 +839,25 @@ int io_read(struct io_kiocb *req, unsigned int issue_flags)
 	return kiocb_done(req, ret, issue_flags);
 }
 
+static bool io_kiocb_start_write(struct io_kiocb *req, struct kiocb *kiocb)
+{
+	struct inode *inode;
+	bool ret;
+
+	if (!(req->flags & REQ_F_ISREG))
+		return true;
+	if (!(kiocb->ki_flags & IOCB_NOWAIT)) {
+		kiocb_start_write(kiocb);
+		return true;
+	}
+
+	inode = file_inode(kiocb->ki_filp);
+	ret = sb_start_write_trylock(inode->i_sb);
+	if (ret)
+		__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	return ret;
+}
+
 int io_write(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
@@ -897,18 +911,8 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		return ret;
 	}
 
-	/*
-	 * Open-code file_start_write here to grab freeze protection,
-	 * which will be released by another thread in
-	 * io_complete_rw().  Fool lockdep by telling it the lock got
-	 * released so that it doesn't complain about the held lock when
-	 * we return to userspace.
-	 */
-	if (req->flags & REQ_F_ISREG) {
-		sb_start_write(file_inode(req->file)->i_sb);
-		__sb_writers_release(file_inode(req->file)->i_sb,
-					SB_FREEZE_WRITE);
-	}
+	if (unlikely(!io_kiocb_start_write(req, kiocb)))
+		return -EAGAIN;
 	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (likely(req->file->f_op->write_iter))
@@ -956,7 +960,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 				io->bytes_done += ret2;
 
 			if (kiocb->ki_flags & IOCB_WRITE)
-				kiocb_end_write(req);
+				io_req_end_write(req);
 			return ret ? ret : -EAGAIN;
 		}
 done:
@@ -967,7 +971,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 		ret = io_setup_async_rw(req, iovec, s, false);
 		if (!ret) {
 			if (kiocb->ki_flags & IOCB_WRITE)
-				kiocb_end_write(req);
+				io_req_end_write(req);
 			return -EAGAIN;
 		}
 		return ret;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index bb70f400c25e..2cb04e0e118d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -24,6 +24,23 @@
 DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
+/*
+ * cgroup bpf destruction makes heavy use of work items and there can be a lot
+ * of concurrent destructions.  Use a separate workqueue so that cgroup bpf
+ * destruction work items don't end up filling up max_active of system_wq
+ * which may lead to deadlock.
+ */
+static struct workqueue_struct *cgroup_bpf_destroy_wq;
+
+static int __init cgroup_bpf_wq_init(void)
+{
+	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
+	if (!cgroup_bpf_destroy_wq)
+		panic("Failed to alloc workqueue for cgroup bpf destroy.\n");
+	return 0;
+}
+core_initcall(cgroup_bpf_wq_init);
+
 /* __always_inline is necessary to prevent indirect call through run_prog
  * function pointer.
  */
@@ -334,7 +351,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
 	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
 
 	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
-	queue_work(system_wq, &cgrp->bpf.release_work);
+	queue_work(cgroup_bpf_destroy_wq, &cgrp->bpf.release_work);
 }
 
 /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 37b510d91b81..d8ddb1e245d9 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -650,7 +650,7 @@ static int trie_get_next_key(struct bpf_map *map, void *_key, void *_next_key)
 	if (!key || key->prefixlen > trie->max_prefixlen)
 		goto find_leftmost;
 
-	node_stack = kmalloc_array(trie->max_prefixlen,
+	node_stack = kmalloc_array(trie->max_prefixlen + 1,
 				   sizeof(struct lpm_trie_node *),
 				   GFP_ATOMIC | __GFP_NOWARN);
 	if (!node_stack)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f6656fd410d0..2ca4aeb21a44 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5707,7 +5707,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 {
 	struct cgroup *cgroup;
 	int ret = false;
-	int level = 1;
+	int level = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -5715,7 +5715,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 		if (cgroup->nr_descendants >= cgroup->max_descendants)
 			goto fail;
 
-		if (level > cgroup->max_depth)
+		if (level >= cgroup->max_depth)
 			goto fail;
 
 		level++;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 98a1a05f2db2..f53bc54dacb3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2728,7 +2728,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	 * split PMDs
 	 */
 	if (!can_split_folio(folio, &extra_pins)) {
-		ret = -EBUSY;
+		ret = -EAGAIN;
 		goto out_unlock;
 	}
 
@@ -2780,7 +2780,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			xas_unlock(&xas);
 		local_irq_enable();
 		remap_page(folio, folio_nr_pages(folio));
-		ret = -EBUSY;
+		ret = -EAGAIN;
 	}
 
 out_unlock:
diff --git a/mm/internal.h b/mm/internal.h
index d01130efce5f..a50bc08337d2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -754,8 +754,13 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_OOM		ALLOC_NO_WATERMARKS
 #endif
 
-#define ALLOC_HARDER		 0x10 /* try to alloc harder */
-#define ALLOC_HIGH		 0x20 /* __GFP_HIGH set */
+#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
+				       * to 25% of the min watermark or
+				       * 62.5% if __GFP_HIGH is set.
+				       */
+#define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
+				       * of the min watermark.
+				       */
 #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
 #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
 #ifdef CONFIG_ZONE_DMA32
@@ -763,8 +768,12 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #else
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
+#define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
+/* Flags that allow allocations below the min watermark. */
+#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+
 enum ttu_flags;
 struct tlbflush_unmap_batch;
 
diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index cef683a2e0d2..df9658299a08 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1260,32 +1260,6 @@ static void vm_map_ram_tags(struct kunit *test)
 	free_pages((unsigned long)p_ptr, 1);
 }
 
-static void vmalloc_percpu(struct kunit *test)
-{
-	char __percpu *ptr;
-	int cpu;
-
-	/*
-	 * This test is specifically crafted for the software tag-based mode,
-	 * the only tag-based mode that poisons percpu mappings.
-	 */
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_KASAN_SW_TAGS);
-
-	ptr = __alloc_percpu(PAGE_SIZE, PAGE_SIZE);
-
-	for_each_possible_cpu(cpu) {
-		char *c_ptr = per_cpu_ptr(ptr, cpu);
-
-		KUNIT_EXPECT_GE(test, (u8)get_tag(c_ptr), (u8)KASAN_TAG_MIN);
-		KUNIT_EXPECT_LT(test, (u8)get_tag(c_ptr), (u8)KASAN_TAG_KERNEL);
-
-		/* Make sure that in-bounds accesses don't crash the kernel. */
-		*c_ptr = 0;
-	}
-
-	free_percpu(ptr);
-}
-
 /*
  * Check that the assigned pointer tag falls within the [KASAN_TAG_MIN,
  * KASAN_TAG_KERNEL) range (note: excluding the match-all tag) for tag-based
@@ -1439,7 +1413,6 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(vmalloc_oob),
 	KUNIT_CASE(vmap_tags),
 	KUNIT_CASE(vm_map_ram_tags),
-	KUNIT_CASE(vmalloc_percpu),
 	KUNIT_CASE(match_all_not_assigned),
 	KUNIT_CASE(match_all_ptr_tag),
 	KUNIT_CASE(match_all_mem_tag),
diff --git a/mm/migrate.c b/mm/migrate.c
index 0252aa4ff572..209078154a46 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1011,11 +1011,59 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 	return rc;
 }
 
-static int __unmap_and_move(struct folio *src, struct folio *dst,
+/*
+ * To record some information during migration, we use some unused
+ * fields (mapping and private) of struct folio of the newly allocated
+ * destination folio.  This is safe because nobody is using them
+ * except us.
+ */
+union migration_ptr {
+	struct anon_vma *anon_vma;
+	struct address_space *mapping;
+};
+static void __migrate_folio_record(struct folio *dst,
+				   unsigned long page_was_mapped,
+				   struct anon_vma *anon_vma)
+{
+	union migration_ptr ptr = { .anon_vma = anon_vma };
+	dst->mapping = ptr.mapping;
+	dst->private = (void *)page_was_mapped;
+}
+
+static void __migrate_folio_extract(struct folio *dst,
+				   int *page_was_mappedp,
+				   struct anon_vma **anon_vmap)
+{
+	union migration_ptr ptr = { .mapping = dst->mapping };
+	*anon_vmap = ptr.anon_vma;
+	*page_was_mappedp = (unsigned long)dst->private;
+	dst->mapping = NULL;
+	dst->private = NULL;
+}
+
+/* Cleanup src folio upon migration success */
+static void migrate_folio_done(struct folio *src,
+			       enum migrate_reason reason)
+{
+	/*
+	 * Compaction can migrate also non-LRU pages which are
+	 * not accounted to NR_ISOLATED_*. They can be recognized
+	 * as __PageMovable
+	 */
+	if (likely(!__folio_test_movable(src)) && reason != MR_DEMOTION)
+		mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
+				    folio_is_file_lru(src), -folio_nr_pages(src));
+
+	if (reason != MR_MEMORY_FAILURE)
+		/* We release the page in page_handle_poison. */
+		folio_put(src);
+}
+
+static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
 				int force, enum migrate_mode mode)
 {
 	int rc = -EAGAIN;
-	bool page_was_mapped = false;
+	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(&src->page);
 
@@ -1091,8 +1139,8 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 		goto out_unlock;
 
 	if (unlikely(!is_lru)) {
-		rc = move_to_new_folio(dst, src, mode);
-		goto out_unlock_both;
+		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		return MIGRATEPAGE_UNMAP;
 	}
 
 	/*
@@ -1117,11 +1165,42 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
 		try_to_migrate(src, 0);
-		page_was_mapped = true;
+		page_was_mapped = 1;
 	}
 
-	if (!folio_mapped(src))
-		rc = move_to_new_folio(dst, src, mode);
+	if (!folio_mapped(src)) {
+		__migrate_folio_record(dst, page_was_mapped, anon_vma);
+		return MIGRATEPAGE_UNMAP;
+	}
+
+	if (page_was_mapped)
+		remove_migration_ptes(src, src, false);
+
+out_unlock_both:
+	folio_unlock(dst);
+out_unlock:
+	/* Drop an anon_vma reference if we took one */
+	if (anon_vma)
+		put_anon_vma(anon_vma);
+	folio_unlock(src);
+out:
+
+	return rc;
+}
+
+static int __migrate_folio_move(struct folio *src, struct folio *dst,
+				enum migrate_mode mode)
+{
+	int rc;
+	int page_was_mapped = 0;
+	struct anon_vma *anon_vma = NULL;
+	bool is_lru = !__PageMovable(&src->page);
+
+	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
+
+	rc = move_to_new_folio(dst, src, mode);
+	if (unlikely(!is_lru))
+		goto out_unlock_both;
 
 	/*
 	 * When successful, push dst to LRU immediately: so that if it
@@ -1144,12 +1223,10 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 
 out_unlock_both:
 	folio_unlock(dst);
-out_unlock:
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
 	folio_unlock(src);
-out:
 	/*
 	 * If migration is successful, decrease refcount of dst,
 	 * which will not free the page because new page owner increased
@@ -1161,80 +1238,92 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
 	return rc;
 }
 
-/*
- * Obtain the lock on page, remove all ptes and migrate the page
- * to the newly allocated page in newpage.
- */
-static int unmap_and_move(new_page_t get_new_page,
-				   free_page_t put_new_page,
-				   unsigned long private, struct page *page,
-				   int force, enum migrate_mode mode,
-				   enum migrate_reason reason,
-				   struct list_head *ret)
+/* Obtain the lock on page, remove all ptes. */
+static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
+			       unsigned long private, struct folio *src,
+			       struct folio **dstp, int force,
+			       enum migrate_mode mode, enum migrate_reason reason,
+			       struct list_head *ret)
 {
-	struct folio *dst, *src = page_folio(page);
-	int rc = MIGRATEPAGE_SUCCESS;
+	struct folio *dst;
+	int rc = MIGRATEPAGE_UNMAP;
 	struct page *newpage = NULL;
 
-	if (!thp_migration_supported() && PageTransHuge(page))
+	if (!thp_migration_supported() && folio_test_transhuge(src))
 		return -ENOSYS;
 
-	if (page_count(page) == 1) {
-		/* Page was freed from under us. So we are done. */
-		ClearPageActive(page);
-		ClearPageUnevictable(page);
+	if (folio_ref_count(src) == 1) {
+		/* Folio was freed from under us. So we are done. */
+		folio_clear_active(src);
+		folio_clear_unevictable(src);
 		/* free_pages_prepare() will clear PG_isolated. */
-		goto out;
+		list_del(&src->lru);
+		migrate_folio_done(src, reason);
+		return MIGRATEPAGE_SUCCESS;
 	}
 
-	newpage = get_new_page(page, private);
+	newpage = get_new_page(&src->page, private);
 	if (!newpage)
 		return -ENOMEM;
 	dst = page_folio(newpage);
+	*dstp = dst;
+
+	dst->private = NULL;
+	rc = __migrate_folio_unmap(src, dst, force, mode);
+	if (rc == MIGRATEPAGE_UNMAP)
+		return rc;
+
+	/*
+	 * A folio that has not been unmapped will be restored to
+	 * right list unless we want to retry.
+	 */
+	if (rc != -EAGAIN)
+		list_move_tail(&src->lru, ret);
+
+	if (put_new_page)
+		put_new_page(&dst->page, private);
+	else
+		folio_put(dst);
+
+	return rc;
+}
+
+/* Migrate the folio to the newly allocated folio in dst. */
+static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
+			      struct folio *src, struct folio *dst,
+			      enum migrate_mode mode, enum migrate_reason reason,
+			      struct list_head *ret)
+{
+	int rc;
 
-	newpage->private = 0;
-	rc = __unmap_and_move(src, dst, force, mode);
+	rc = __migrate_folio_move(src, dst, mode);
 	if (rc == MIGRATEPAGE_SUCCESS)
-		set_page_owner_migrate_reason(newpage, reason);
+		set_page_owner_migrate_reason(&dst->page, reason);
 
-out:
 	if (rc != -EAGAIN) {
 		/*
-		 * A page that has been migrated has all references
-		 * removed and will be freed. A page that has not been
+		 * A folio that has been migrated has all references
+		 * removed and will be freed. A folio that has not been
 		 * migrated will have kept its references and be restored.
 		 */
-		list_del(&page->lru);
+		list_del(&src->lru);
 	}
 
 	/*
 	 * If migration is successful, releases reference grabbed during
-	 * isolation. Otherwise, restore the page to right list unless
+	 * isolation. Otherwise, restore the folio to right list unless
 	 * we want to retry.
 	 */
 	if (rc == MIGRATEPAGE_SUCCESS) {
-		/*
-		 * Compaction can migrate also non-LRU pages which are
-		 * not accounted to NR_ISOLATED_*. They can be recognized
-		 * as __PageMovable
-		 */
-		if (likely(!__PageMovable(page)))
-			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
-					page_is_file_lru(page), -thp_nr_pages(page));
-
-		if (reason != MR_MEMORY_FAILURE)
-			/*
-			 * We release the page in page_handle_poison.
-			 */
-			put_page(page);
+		migrate_folio_done(src, reason);
 	} else {
 		if (rc != -EAGAIN)
-			list_add_tail(&page->lru, ret);
+			list_add_tail(&src->lru, ret);
 
 		if (put_new_page)
-			put_new_page(newpage, private);
+			put_new_page(&dst->page, private);
 		else
-			put_page(newpage);
+			folio_put(dst);
 	}
 
 	return rc;
@@ -1385,234 +1474,411 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	return rc;
 }
 
-static inline int try_split_thp(struct page *page, struct list_head *split_pages)
+static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
 {
 	int rc;
 
-	lock_page(page);
-	rc = split_huge_page_to_list(page, split_pages);
-	unlock_page(page);
+	folio_lock(folio);
+	rc = split_folio_to_list(folio, split_folios);
+	folio_unlock(folio);
 	if (!rc)
-		list_move_tail(&page->lru, split_pages);
+		list_move_tail(&folio->lru, split_folios);
 
 	return rc;
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define NR_MAX_BATCHED_MIGRATION	HPAGE_PMD_NR
+#else
+#define NR_MAX_BATCHED_MIGRATION	512
+#endif
+#define NR_MAX_MIGRATE_PAGES_RETRY	10
+
+struct migrate_pages_stats {
+	int nr_succeeded;	/* Normal and large folios migrated successfully, in
+				   units of base pages */
+	int nr_failed_pages;	/* Normal and large folios failed to be migrated, in
+				   units of base pages.  Untried folios aren't counted */
+	int nr_thp_succeeded;	/* THP migrated successfully */
+	int nr_thp_failed;	/* THP failed to be migrated */
+	int nr_thp_split;	/* THP split before migrating */
+};
+
 /*
- * migrate_pages - migrate the pages specified in a list, to the free pages
- *		   supplied as the target for the page migration
- *
- * @from:		The list of pages to be migrated.
- * @get_new_page:	The function used to allocate free pages to be used
- *			as the target of the page migration.
- * @put_new_page:	The function used to free target pages if migration
- *			fails, or NULL if no special handling is necessary.
- * @private:		Private data to be passed on to get_new_page()
- * @mode:		The migration mode that specifies the constraints for
- *			page migration, if any.
- * @reason:		The reason for page migration.
- * @ret_succeeded:	Set to the number of normal pages migrated successfully if
- *			the caller passes a non-NULL pointer.
- *
- * The function returns after 10 attempts or if no pages are movable any more
- * because the list has become empty or no retryable pages exist any more.
- * It is caller's responsibility to call putback_movable_pages() to return pages
- * to the LRU or free list only if ret != 0.
- *
- * Returns the number of {normal page, THP, hugetlb} that were not migrated, or
- * an error code. The number of THP splits will be considered as the number of
- * non-migrated THP, no matter how many subpages of the THP are migrated successfully.
+ * Returns the number of hugetlb folios that were not migrated, or an error code
+ * after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no hugetlb folios are movable
+ * any more because the list has become empty or no retryable hugetlb folios
+ * exist any more. It is caller's responsibility to call putback_movable_pages()
+ * only if ret != 0.
  */
-int migrate_pages(struct list_head *from, new_page_t get_new_page,
+static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
+			    free_page_t put_new_page, unsigned long private,
+			    enum migrate_mode mode, int reason,
+			    struct migrate_pages_stats *stats,
+			    struct list_head *ret_folios)
+{
+	int retry = 1;
+	int nr_failed = 0;
+	int nr_retry_pages = 0;
+	int pass = 0;
+	struct folio *folio, *folio2;
+	int rc, nr_pages;
+
+	for (pass = 0; pass < NR_MAX_MIGRATE_PAGES_RETRY && retry; pass++) {
+		retry = 0;
+		nr_retry_pages = 0;
+
+		list_for_each_entry_safe(folio, folio2, from, lru) {
+			if (!folio_test_hugetlb(folio))
+				continue;
+
+			nr_pages = folio_nr_pages(folio);
+
+			cond_resched();
+
+			rc = unmap_and_move_huge_page(get_new_page,
+						      put_new_page, private,
+						      &folio->page, pass > 2, mode,
+						      reason, ret_folios);
+			/*
+			 * The rules are:
+			 *	Success: hugetlb folio will be put back
+			 *	-EAGAIN: stay on the from list
+			 *	-ENOMEM: stay on the from list
+			 *	-ENOSYS: stay on the from list
+			 *	Other errno: put on ret_folios list
+			 */
+			switch(rc) {
+			case -ENOSYS:
+				/* Hugetlb migration is unsupported */
+				nr_failed++;
+				stats->nr_failed_pages += nr_pages;
+				list_move_tail(&folio->lru, ret_folios);
+				break;
+			case -ENOMEM:
+				/*
+				 * When memory is low, don't bother to try to migrate
+				 * other folios, just exit.
+				 */
+				stats->nr_failed_pages += nr_pages + nr_retry_pages;
+				return -ENOMEM;
+			case -EAGAIN:
+				retry++;
+				nr_retry_pages += nr_pages;
+				break;
+			case MIGRATEPAGE_SUCCESS:
+				stats->nr_succeeded += nr_pages;
+				break;
+			default:
+				/*
+				 * Permanent failure (-EBUSY, etc.):
+				 * unlike -EAGAIN case, the failed folio is
+				 * removed from migration folio list and not
+				 * retried in the next outer loop.
+				 */
+				nr_failed++;
+				stats->nr_failed_pages += nr_pages;
+				break;
+			}
+		}
+	}
+	/*
+	 * nr_failed is number of hugetlb folios failed to be migrated.  After
+	 * NR_MAX_MIGRATE_PAGES_RETRY attempts, give up and count retried hugetlb
+	 * folios as failed.
+	 */
+	nr_failed += retry;
+	stats->nr_failed_pages += nr_retry_pages;
+
+	return nr_failed;
+}
+
+static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
 		free_page_t put_new_page, unsigned long private,
-		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
+		enum migrate_mode mode, int reason, struct list_head *ret_folios,
+		struct migrate_pages_stats *stats)
 {
 	int retry = 1;
+	int large_retry = 1;
 	int thp_retry = 1;
 	int nr_failed = 0;
-	int nr_failed_pages = 0;
 	int nr_retry_pages = 0;
-	int nr_succeeded = 0;
-	int nr_thp_succeeded = 0;
-	int nr_thp_failed = 0;
-	int nr_thp_split = 0;
+	int nr_large_failed = 0;
 	int pass = 0;
+	bool is_large = false;
 	bool is_thp = false;
-	struct page *page;
-	struct page *page2;
-	int rc, nr_subpages;
-	LIST_HEAD(ret_pages);
-	LIST_HEAD(thp_split_pages);
+	struct folio *folio, *folio2, *dst = NULL;
+	int rc, nr_pages;
+	LIST_HEAD(split_folios);
 	bool nosplit = (reason == MR_NUMA_MISPLACED);
-	bool no_subpage_counting = false;
-
-	trace_mm_migrate_pages_start(mode, reason);
+	bool no_split_folio_counting = false;
 
-thp_subpage_migration:
-	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
+split_folio_migration:
+	for (pass = 0;
+	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
+	     pass++) {
 		retry = 0;
+		large_retry = 0;
 		thp_retry = 0;
 		nr_retry_pages = 0;
 
-		list_for_each_entry_safe(page, page2, from, lru) {
+		list_for_each_entry_safe(folio, folio2, from, lru) {
 			/*
-			 * THP statistics is based on the source huge page.
-			 * Capture required information that might get lost
-			 * during migration.
+			 * Large folio statistics is based on the source large
+			 * folio. Capture required information that might get
+			 * lost during migration.
 			 */
-			is_thp = PageTransHuge(page) && !PageHuge(page);
-			nr_subpages = compound_nr(page);
+			is_large = folio_test_large(folio);
+			is_thp = is_large && folio_test_pmd_mappable(folio);
+			nr_pages = folio_nr_pages(folio);
+
 			cond_resched();
 
-			if (PageHuge(page))
-				rc = unmap_and_move_huge_page(get_new_page,
-						put_new_page, private, page,
-						pass > 2, mode, reason,
-						&ret_pages);
-			else
-				rc = unmap_and_move(get_new_page, put_new_page,
-						private, page, pass > 2, mode,
-						reason, &ret_pages);
+			rc = migrate_folio_unmap(get_new_page, put_new_page, private,
+						 folio, &dst, pass > 2, mode,
+						 reason, ret_folios);
+			if (rc == MIGRATEPAGE_UNMAP)
+				rc = migrate_folio_move(put_new_page, private,
+							folio, dst, mode,
+							reason, ret_folios);
 			/*
 			 * The rules are:
-			 *	Success: non hugetlb page will be freed, hugetlb
-			 *		 page will be put back
+			 *	Success: folio will be freed
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	-ENOSYS: stay on the from list
-			 *	Other errno: put on ret_pages list then splice to
-			 *		     from list
+			 *	Other errno: put on ret_folios list
 			 */
 			switch(rc) {
 			/*
-			 * THP migration might be unsupported or the
-			 * allocation could've failed so we should
-			 * retry on the same page with the THP split
-			 * to base pages.
+			 * Large folio migration might be unsupported or
+			 * the allocation could've failed so we should retry
+			 * on the same folio with the large folio split
+			 * to normal folios.
 			 *
-			 * Sub-pages are put in thp_split_pages, and
+			 * Split folios are put in split_folios, and
 			 * we will migrate them after the rest of the
 			 * list is processed.
 			 */
 			case -ENOSYS:
-				/* THP migration is unsupported */
-				if (is_thp) {
-					nr_thp_failed++;
-					if (!try_split_thp(page, &thp_split_pages)) {
-						nr_thp_split++;
+				/* Large folio migration is unsupported */
+				if (is_large) {
+					nr_large_failed++;
+					stats->nr_thp_failed += is_thp;
+					if (!try_split_folio(folio, &split_folios)) {
+						stats->nr_thp_split += is_thp;
 						break;
 					}
-				/* Hugetlb migration is unsupported */
-				} else if (!no_subpage_counting) {
+				} else if (!no_split_folio_counting) {
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_subpages;
-				list_move_tail(&page->lru, &ret_pages);
+				stats->nr_failed_pages += nr_pages;
+				list_move_tail(&folio->lru, ret_folios);
 				break;
 			case -ENOMEM:
 				/*
 				 * When memory is low, don't bother to try to migrate
-				 * other pages, just exit.
+				 * other folios, just exit.
 				 */
-				if (is_thp) {
-					nr_thp_failed++;
-					/* THP NUMA faulting doesn't split THP to retry. */
-					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
-						nr_thp_split++;
-						break;
+				if (is_large) {
+					nr_large_failed++;
+					stats->nr_thp_failed += is_thp;
+					/* Large folio NUMA faulting doesn't split to retry. */
+					if (!nosplit) {
+						int ret = try_split_folio(folio, &split_folios);
+
+						if (!ret) {
+							stats->nr_thp_split += is_thp;
+							break;
+						} else if (reason == MR_LONGTERM_PIN &&
+							   ret == -EAGAIN) {
+							/*
+							 * Try again to split large folio to
+							 * mitigate the failure of longterm pinning.
+							 */
+							large_retry++;
+							thp_retry += is_thp;
+							nr_retry_pages += nr_pages;
+							/* Undo duplicated failure counting. */
+							nr_large_failed--;
+							stats->nr_thp_failed -= is_thp;
+							break;
+						}
 					}
-				} else if (!no_subpage_counting) {
+				} else if (!no_split_folio_counting) {
 					nr_failed++;
 				}
 
-				nr_failed_pages += nr_subpages + nr_retry_pages;
+				stats->nr_failed_pages += nr_pages + nr_retry_pages;
 				/*
-				 * There might be some subpages of fail-to-migrate THPs
-				 * left in thp_split_pages list. Move them back to migration
+				 * There might be some split folios of fail-to-migrate large
+				 * folios left in split_folios list. Move them to ret_folios
 				 * list so that they could be put back to the right list by
-				 * the caller otherwise the page refcnt will be leaked.
+				 * the caller otherwise the folio refcnt will be leaked.
 				 */
-				list_splice_init(&thp_split_pages, from);
+				list_splice_init(&split_folios, ret_folios);
 				/* nr_failed isn't updated for not used */
-				nr_thp_failed += thp_retry;
+				nr_large_failed += large_retry;
+				stats->nr_thp_failed += thp_retry;
 				goto out;
 			case -EAGAIN:
-				if (is_thp)
-					thp_retry++;
-				else if (!no_subpage_counting)
+				if (is_large) {
+					large_retry++;
+					thp_retry += is_thp;
+				} else if (!no_split_folio_counting) {
 					retry++;
-				nr_retry_pages += nr_subpages;
+				}
+				nr_retry_pages += nr_pages;
 				break;
 			case MIGRATEPAGE_SUCCESS:
-				nr_succeeded += nr_subpages;
-				if (is_thp)
-					nr_thp_succeeded++;
+				stats->nr_succeeded += nr_pages;
+				stats->nr_thp_succeeded += is_thp;
 				break;
 			default:
 				/*
 				 * Permanent failure (-EBUSY, etc.):
-				 * unlike -EAGAIN case, the failed page is
-				 * removed from migration page list and not
+				 * unlike -EAGAIN case, the failed folio is
+				 * removed from migration folio list and not
 				 * retried in the next outer loop.
 				 */
-				if (is_thp)
-					nr_thp_failed++;
-				else if (!no_subpage_counting)
+				if (is_large) {
+					nr_large_failed++;
+					stats->nr_thp_failed += is_thp;
+				} else if (!no_split_folio_counting) {
 					nr_failed++;
+				}
 
-				nr_failed_pages += nr_subpages;
+				stats->nr_failed_pages += nr_pages;
 				break;
 			}
 		}
 	}
 	nr_failed += retry;
-	nr_thp_failed += thp_retry;
-	nr_failed_pages += nr_retry_pages;
+	nr_large_failed += large_retry;
+	stats->nr_thp_failed += thp_retry;
+	stats->nr_failed_pages += nr_retry_pages;
 	/*
-	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
-	 * counting in this round, since all subpages of a THP is counted
-	 * as 1 failure in the first round.
+	 * Try to migrate split folios of fail-to-migrate large folios, no
+	 * nr_failed counting in this round, since all split folios of a
+	 * large folio is counted as 1 failure in the first round.
 	 */
-	if (!list_empty(&thp_split_pages)) {
+	if (!list_empty(&split_folios)) {
 		/*
-		 * Move non-migrated pages (after 10 retries) to ret_pages
-		 * to avoid migrating them again.
+		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
+		 * retries) to ret_folios to avoid migrating them again.
 		 */
-		list_splice_init(from, &ret_pages);
-		list_splice_init(&thp_split_pages, from);
-		no_subpage_counting = true;
+		list_splice_init(from, ret_folios);
+		list_splice_init(&split_folios, from);
+		no_split_folio_counting = true;
 		retry = 1;
-		goto thp_subpage_migration;
+		goto split_folio_migration;
 	}
 
-	rc = nr_failed + nr_thp_failed;
+	rc = nr_failed + nr_large_failed;
+out:
+	return rc;
+}
+
+/*
+ * migrate_pages - migrate the folios specified in a list, to the free folios
+ *		   supplied as the target for the page migration
+ *
+ * @from:		The list of folios to be migrated.
+ * @get_new_page:	The function used to allocate free folios to be used
+ *			as the target of the folio migration.
+ * @put_new_page:	The function used to free target folios if migration
+ *			fails, or NULL if no special handling is necessary.
+ * @private:		Private data to be passed on to get_new_page()
+ * @mode:		The migration mode that specifies the constraints for
+ *			folio migration, if any.
+ * @reason:		The reason for folio migration.
+ * @ret_succeeded:	Set to the number of folios migrated successfully if
+ *			the caller passes a non-NULL pointer.
+ *
+ * The function returns after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no folios
+ * are movable any more because the list has become empty or no retryable folios
+ * exist any more. It is caller's responsibility to call putback_movable_pages()
+ * only if ret != 0.
+ *
+ * Returns the number of {normal folio, large folio, hugetlb} that were not
+ * migrated, or an error code. The number of large folio splits will be
+ * considered as the number of non-migrated large folio, no matter how many
+ * split folios of the large folio are migrated successfully.
+ */
+int migrate_pages(struct list_head *from, new_page_t get_new_page,
+		free_page_t put_new_page, unsigned long private,
+		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
+{
+	int rc, rc_gather;
+	int nr_pages;
+	struct folio *folio, *folio2;
+	LIST_HEAD(folios);
+	LIST_HEAD(ret_folios);
+	struct migrate_pages_stats stats;
+
+	trace_mm_migrate_pages_start(mode, reason);
+
+	memset(&stats, 0, sizeof(stats));
+
+	rc_gather = migrate_hugetlbs(from, get_new_page, put_new_page, private,
+				     mode, reason, &stats, &ret_folios);
+	if (rc_gather < 0)
+		goto out;
+again:
+	nr_pages = 0;
+	list_for_each_entry_safe(folio, folio2, from, lru) {
+		/* Retried hugetlb folios will be kept in list  */
+		if (folio_test_hugetlb(folio)) {
+			list_move_tail(&folio->lru, &ret_folios);
+			continue;
+		}
+
+		nr_pages += folio_nr_pages(folio);
+		if (nr_pages > NR_MAX_BATCHED_MIGRATION)
+			break;
+	}
+	if (nr_pages > NR_MAX_BATCHED_MIGRATION)
+		list_cut_before(&folios, from, &folio->lru);
+	else
+		list_splice_init(from, &folios);
+	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
+				 mode, reason, &ret_folios, &stats);
+	list_splice_tail_init(&folios, &ret_folios);
+	if (rc < 0) {
+		rc_gather = rc;
+		goto out;
+	}
+	rc_gather += rc;
+	if (!list_empty(from))
+		goto again;
 out:
 	/*
-	 * Put the permanent failure page back to migration list, they
+	 * Put the permanent failure folio back to migration list, they
 	 * will be put back to the right list by the caller.
 	 */
-	list_splice(&ret_pages, from);
+	list_splice(&ret_folios, from);
 
 	/*
-	 * Return 0 in case all subpages of fail-to-migrate THPs are
-	 * migrated successfully.
+	 * Return 0 in case all split folios of fail-to-migrate large folios
+	 * are migrated successfully.
 	 */
 	if (list_empty(from))
-		rc = 0;
+		rc_gather = 0;
 
-	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
-	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
-	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
-	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
-	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
-	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
-			       nr_thp_failed, nr_thp_split, mode, reason);
+	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
+	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
+	count_vm_events(THP_MIGRATION_SUCCESS, stats.nr_thp_succeeded);
+	count_vm_events(THP_MIGRATION_FAIL, stats.nr_thp_failed);
+	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
+	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
+			       stats.nr_thp_succeeded, stats.nr_thp_failed,
+			       stats.nr_thp_split, mode, reason);
 
 	if (ret_succeeded)
-		*ret_succeeded = nr_succeeded;
+		*ret_succeeded = stats.nr_succeeded;
 
-	return rc;
+	return rc_gather;
 }
 
 struct page *alloc_migration_target(struct page *page, unsigned long private)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a905b850d31c..b87b350b2f40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3713,10 +3713,20 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		 * reserved for high-order atomic allocation, so order-0
 		 * request should skip it.
 		 */
-		if (order > 0 && alloc_flags & ALLOC_HARDER)
+		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
 			page = __rmqueue(zone, order, migratetype, alloc_flags);
+
+			/*
+			 * If the allocation fails, allow OOM handling and
+			 * order-0 (atomic) allocs access to HIGHATOMIC
+			 * reserves as failing now is worse than failing a
+			 * high-order atomic allocation in the future.
+			 */
+			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
+				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
+
 			if (!page) {
 				spin_unlock_irqrestore(&zone->lock, flags);
 				return NULL;
@@ -3946,15 +3956,14 @@ ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
 static inline long __zone_watermark_unusable_free(struct zone *z,
 				unsigned int order, unsigned int alloc_flags)
 {
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 	long unusable_free = (1 << order) - 1;
 
 	/*
-	 * If the caller does not have rights to ALLOC_HARDER then subtract
-	 * the high-atomic reserves. This will over-estimate the size of the
-	 * atomic reserve but it avoids a search.
+	 * If the caller does not have rights to reserves below the min
+	 * watermark then subtract the high-atomic reserves. This will
+	 * over-estimate the size of the atomic reserve but it avoids a search.
 	 */
-	if (likely(!alloc_harder))
+	if (likely(!(alloc_flags & ALLOC_RESERVES)))
 		unusable_free += z->nr_reserved_highatomic;
 
 #ifdef CONFIG_CMA
@@ -3978,25 +3987,37 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 {
 	long min = mark;
 	int o;
-	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
 
 	/* free_pages may go negative - that's OK */
 	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
 
-	if (alloc_flags & ALLOC_HIGH)
-		min -= min / 2;
+	if (unlikely(alloc_flags & ALLOC_RESERVES)) {
+		/*
+		 * __GFP_HIGH allows access to 50% of the min reserve as well
+		 * as OOM.
+		 */
+		if (alloc_flags & ALLOC_MIN_RESERVE) {
+			min -= min / 2;
+
+			/*
+			 * Non-blocking allocations (e.g. GFP_ATOMIC) can
+			 * access more reserves than just __GFP_HIGH. Other
+			 * non-blocking allocations requests such as GFP_NOWAIT
+			 * or (GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) do not get
+			 * access to the min reserve.
+			 */
+			if (alloc_flags & ALLOC_NON_BLOCK)
+				min -= min / 4;
+		}
 
-	if (unlikely(alloc_harder)) {
 		/*
-		 * OOM victims can try even harder than normal ALLOC_HARDER
+		 * OOM victims can try even harder than the normal reserve
 		 * users on the grounds that it's definitely going to be in
 		 * the exit path shortly and free memory. Any allocation it
 		 * makes during the free path will be small and short-lived.
 		 */
 		if (alloc_flags & ALLOC_OOM)
 			min -= min / 2;
-		else
-			min -= min / 4;
 	}
 
 	/*
@@ -4030,8 +4051,10 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 			return true;
 		}
 #endif
-		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
+		if ((alloc_flags & (ALLOC_HIGHATOMIC|ALLOC_OOM)) &&
+		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
 			return true;
+		}
 	}
 	return false;
 }
@@ -4293,7 +4316,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * If this is a high-order atomic allocation then check
 			 * if the pageblock should be reserved for the future
 			 */
-			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
+			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
 				reserve_highatomic_pageblock(page, zone, order);
 
 			return page;
@@ -4820,41 +4843,48 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 }
 
 static inline unsigned int
-gfp_to_alloc_flags(gfp_t gfp_mask)
+gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 {
 	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
 
 	/*
-	 * __GFP_HIGH is assumed to be the same as ALLOC_HIGH
+	 * __GFP_HIGH is assumed to be the same as ALLOC_MIN_RESERVE
 	 * and __GFP_KSWAPD_RECLAIM is assumed to be the same as ALLOC_KSWAPD
 	 * to save two branches.
 	 */
-	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_HIGH);
+	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_MIN_RESERVE);
 	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
 
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
 	 * cannot run direct reclaim, or if the caller has realtime scheduling
 	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
-	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
+	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
 	 */
 	alloc_flags |= (__force int)
 		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
 
-	if (gfp_mask & __GFP_ATOMIC) {
+	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		/*
 		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
 		 * if it can't schedule.
 		 */
-		if (!(gfp_mask & __GFP_NOMEMALLOC))
-			alloc_flags |= ALLOC_HARDER;
+		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
+			alloc_flags |= ALLOC_NON_BLOCK;
+
+			if (order > 0)
+				alloc_flags |= ALLOC_HIGHATOMIC;
+		}
+
 		/*
-		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
-		 * comment for __cpuset_node_allowed().
+		 * Ignore cpuset mems for non-blocking __GFP_HIGH (probably
+		 * GFP_ATOMIC) rather than fail, see the comment for
+		 * __cpuset_node_allowed().
 		 */
-		alloc_flags &= ~ALLOC_CPUSET;
+		if (alloc_flags & ALLOC_MIN_RESERVE)
+			alloc_flags &= ~ALLOC_CPUSET;
 	} else if (unlikely(rt_task(current)) && in_task())
-		alloc_flags |= ALLOC_HARDER;
+		alloc_flags |= ALLOC_MIN_RESERVE;
 
 	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
 
@@ -5056,7 +5086,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * kswapd needs to be woken up, and to avoid the cost of setting up
 	 * alloc_flags precisely. So we do that now.
 	 */
-	alloc_flags = gfp_to_alloc_flags(gfp_mask);
+	alloc_flags = gfp_to_alloc_flags(gfp_mask, order);
 
 	/*
 	 * We need to recalculate the starting point for the zonelist iterator
@@ -5285,12 +5315,13 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
 
 		/*
-		 * Help non-failing allocations by giving them access to memory
-		 * reserves but do not use ALLOC_NO_WATERMARKS because this
+		 * Help non-failing allocations by giving some access to memory
+		 * reserves normally used for high priority non-blocking
+		 * allocations but do not use ALLOC_NO_WATERMARKS because this
 		 * could deplete whole memory reserves which would just make
-		 * the situation worse
+		 * the situation worse.
 		 */
-		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
+		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE, ac);
 		if (page)
 			goto got_pg;
 
diff --git a/mm/shmem.c b/mm/shmem.c
index f7c08e169e42..0e1fbc53717d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1086,7 +1086,9 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
+	inode_lock_shared(inode);
 	generic_fillattr(&init_user_ns, inode, stat);
+	inode_unlock_shared(inode);
 
 	if (shmem_is_huge(NULL, inode, 0, false))
 		stat->blksize = HPAGE_PMD_SIZE;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 0cc187ff3587..c368235202b2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -200,6 +200,12 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return ERR_PTR(err);
 	}
 
+	/* If command return a status event skb will be set to NULL as there are
+	 * no parameters.
+	 */
+	if (!skb)
+		return ERR_PTR(-ENODATA);
+
 	return skb;
 }
 EXPORT_SYMBOL(__hci_cmd_sync_sk);
@@ -249,6 +255,11 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 	u8 status;
 
 	skb = __hci_cmd_sync_sk(hdev, opcode, plen, param, event, timeout, sk);
+
+	/* If command return a status event, skb will be set to -ENODATA */
+	if (skb == ERR_PTR(-ENODATA))
+		return 0;
+
 	if (IS_ERR(skb)) {
 		if (!event)
 			bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", opcode,
@@ -256,13 +267,6 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 		return PTR_ERR(skb);
 	}
 
-	/* If command return a status event skb will be set to NULL as there are
-	 * no parameters, in case of failure IS_ERR(skb) would have be set to
-	 * the actual error would be found with PTR_ERR(skb).
-	 */
-	if (!skb)
-		return 0;
-
 	status = skb->data[0];
 
 	kfree_skb(skb);
diff --git a/net/core/dev.c b/net/core/dev.c
index 9a6c1603ef77..42c16b3e86b9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3678,6 +3678,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;
 
 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
+		if (vlan_get_protocol(skb) == htons(ETH_P_IPV6) &&
+		    skb_network_header_len(skb) != sizeof(struct ipv6hdr))
+			goto sw_checksum;
 		switch (skb->csum_offset) {
 		case offsetof(struct tcphdr, check):
 		case offsetof(struct udphdr, check):
@@ -3685,6 +3688,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		}
 	}
 
+sw_checksum:
 	return skb_checksum_help(skb);
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 4e0976534648..e4776bd2ed89 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -268,12 +268,12 @@ static int nf_reject6_fill_skb_dst(struct sk_buff *skb_in)
 void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 		    int hook)
 {
-	struct sk_buff *nskb;
-	struct tcphdr _otcph;
-	const struct tcphdr *otcph;
-	unsigned int otcplen, hh_len;
 	const struct ipv6hdr *oip6h = ipv6_hdr(oldskb);
 	struct dst_entry *dst = NULL;
+	const struct tcphdr *otcph;
+	struct sk_buff *nskb;
+	struct tcphdr _otcph;
+	unsigned int otcplen;
 	struct flowi6 fl6;
 
 	if ((!(ipv6_addr_type(&oip6h->saddr) & IPV6_ADDR_UNICAST)) ||
@@ -312,9 +312,8 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	if (IS_ERR(dst))
 		return;
 
-	hh_len = (dst->dev->hard_header_len + 15)&~15;
-	nskb = alloc_skb(hh_len + 15 + dst->header_len + sizeof(struct ipv6hdr)
-			 + sizeof(struct tcphdr) + dst->trailer_len,
+	nskb = alloc_skb(LL_MAX_HEADER + sizeof(struct ipv6hdr) +
+			 sizeof(struct tcphdr) + dst->trailer_len,
 			 GFP_ATOMIC);
 
 	if (!nskb) {
@@ -327,7 +326,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 
 	nskb->mark = fl6.flowi6_mark;
 
-	skb_reserve(nskb, hh_len + dst->header_len);
+	skb_reserve(nskb, LL_MAX_HEADER);
 	nf_reject_ip6hdr_put(nskb, oldskb, IPPROTO_TCP, ip6_dst_hoplimit(dst));
 	nf_reject_ip6_tcphdr_put(nskb, oldskb, otcph, otcplen);
 
diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index 51ec8256b7fa..8278221a36a1 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -86,7 +86,7 @@ config MAC80211_DEBUGFS
 
 config MAC80211_MESSAGE_TRACING
 	bool "Trace all mac80211 debug messages"
-	depends on MAC80211
+	depends on MAC80211 && TRACING
 	help
 	  Select this option to have mac80211 register the
 	  mac80211_msg trace subsystem with tracepoints to
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index e26a72f3a104..1241ab7a86bb 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -593,7 +593,9 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 		return -EINVAL;
 
 	if (!pubsta->deflink.ht_cap.ht_supported &&
-	    sta->sdata->vif.bss_conf.chandef.chan->band != NL80211_BAND_6GHZ)
+	    !pubsta->deflink.vht_cap.vht_supported &&
+	    !pubsta->deflink.he_cap.has_he &&
+	    !pubsta->deflink.eht_cap.has_eht)
 		return -EINVAL;
 
 	if (WARN_ON_ONCE(!local->ops->ampdu_action))
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1ce8fefd7f0d..c0dccaceb05e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3001,7 +3001,8 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
-	if (local->ops->get_txpower)
+	if (local->ops->get_txpower &&
+	    (sdata->flags & IEEE80211_SDATA_IN_DRIVER))
 		return drv_get_txpower(local, sdata, dbm);
 
 	if (!local->use_chanctx)
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 23bb24243c6e..585de86fce84 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -976,6 +976,26 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&sdata->local->key_mtx);
 }
 
+static void
+ieee80211_key_iter(struct ieee80211_hw *hw,
+		   struct ieee80211_vif *vif,
+		   struct ieee80211_key *key,
+		   void (*iter)(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				struct ieee80211_key_conf *key,
+				void *data),
+		   void *iter_data)
+{
+	/* skip keys of station in removal process */
+	if (key->sta && key->sta->removed)
+		return;
+	if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+		return;
+	iter(hw, vif, key->sta ? &key->sta->sta : NULL,
+	     &key->conf, iter_data);
+}
+
 void ieee80211_iter_keys(struct ieee80211_hw *hw,
 			 struct ieee80211_vif *vif,
 			 void (*iter)(struct ieee80211_hw *hw,
@@ -995,16 +1015,13 @@ void ieee80211_iter_keys(struct ieee80211_hw *hw,
 	if (vif) {
 		sdata = vif_to_sdata(vif);
 		list_for_each_entry_safe(key, tmp, &sdata->key_list, list)
-			iter(hw, &sdata->vif,
-			     key->sta ? &key->sta->sta : NULL,
-			     &key->conf, iter_data);
+			ieee80211_key_iter(hw, vif, key, iter, iter_data);
 	} else {
 		list_for_each_entry(sdata, &local->interfaces, list)
 			list_for_each_entry_safe(key, tmp,
 						 &sdata->key_list, list)
-				iter(hw, &sdata->vif,
-				     key->sta ? &key->sta->sta : NULL,
-				     &key->conf, iter_data);
+				ieee80211_key_iter(hw, &sdata->vif, key,
+						   iter, iter_data);
 	}
 	mutex_unlock(&local->key_mtx);
 }
@@ -1022,17 +1039,8 @@ _ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
 {
 	struct ieee80211_key *key;
 
-	list_for_each_entry_rcu(key, &sdata->key_list, list) {
-		/* skip keys of station in removal process */
-		if (key->sta && key->sta->removed)
-			continue;
-		if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
-			continue;
-
-		iter(hw, &sdata->vif,
-		     key->sta ? &key->sta->sta : NULL,
-		     &key->conf, iter_data);
-	}
+	list_for_each_entry_rcu(key, &sdata->key_list, list)
+		ieee80211_key_iter(hw, &sdata->vif, key, iter, iter_data);
 }
 
 void ieee80211_iter_keys_rcu(struct ieee80211_hw *hw,
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 1b001dd2bc9a..ae3277424b83 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -777,6 +777,9 @@ static void nft_payload_set_eval(const struct nft_expr *expr,
 	    ((priv->base != NFT_PAYLOAD_TRANSPORT_HEADER &&
 	      priv->base != NFT_PAYLOAD_INNER_HEADER) ||
 	     skb->ip_summed != CHECKSUM_PARTIAL)) {
+		if (offset + priv->len > skb->len)
+			goto err;
+
 		fsum = skb_checksum(skb, offset, priv->len, 0);
 		tsum = csum_partial(src, priv->len, 0);
 
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 470282cf3fae..e8cc8eef0ab6 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1268,7 +1268,7 @@ struct xt_table *xt_find_table_lock(struct net *net, u_int8_t af,
 
 	/* and once again: */
 	list_for_each_entry(t, &xt_net->tables[af], list)
-		if (strcmp(t->name, name) == 0)
+		if (strcmp(t->name, name) == 0 && owner == t->me)
 			return t;
 
 	module_put(owner);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 87ba5aaef206..fe053e717260 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -788,7 +788,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 	drops = max_t(int, n, 0);
 	rcu_read_lock();
 	while ((parentid = sch->parent)) {
-		if (TC_H_MAJ(parentid) == TC_H_MAJ(TC_H_INGRESS))
+		if (parentid == TC_H_ROOT)
 			break;
 
 		if (sch->flags & TCQ_F_NOPARENT)
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 22f67b64135d..2bed30621fa6 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1230,6 +1230,7 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	/* deleted from the list, so can't be found from nl80211 any more */
 	cqm_config = rcu_access_pointer(wdev->cqm_config);
 	kfree_rcu(cqm_config, rcu_head);
+	RCU_INIT_POINTER(wdev->cqm_config, NULL);
 
 	/*
 	 * Ensure that all events have been processed and
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a8bc95ffa41a..d750c6e6eb98 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7159,6 +7159,7 @@ enum {
 	ALC286_FIXUP_SONY_MIC_NO_PRESENCE,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
 	ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 	ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL3_MIC_NO_PRESENCE,
 	ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
@@ -7193,6 +7194,7 @@ enum {
 	ALC255_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC255_FIXUP_ASUS_MIC_NO_PRESENCE,
 	ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 	ALC255_FIXUP_DELL2_MIC_NO_PRESENCE,
 	ALC255_FIXUP_HEADSET_MODE,
 	ALC255_FIXUP_HEADSET_MODE_NO_HP_MIC,
@@ -7658,6 +7660,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE
 	},
+	[ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 	[ALC269_FIXUP_DELL2_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -7938,6 +7946,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC255_FIXUP_HEADSET_MODE
 	},
+	[ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_limit_int_mic_boost,
+		.chained = true,
+		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
+	},
 	[ALC255_FIXUP_DELL2_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -10200,6 +10214,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1d05, 0x115c, "TongFang GMxTGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x121b, "TongFang GMxAGxx", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x1d05, 0x1387, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1d05, 0x1409, "TongFang GMxIXxx", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d17, 0x3288, "Haier Boyue G42", ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS),
 	SND_PCI_QUIRK(0x1d72, 0x1602, "RedmiBook", ALC255_FIXUP_XIAOMI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1d72, 0x1701, "XiaomiNotebook Pro", ALC298_FIXUP_DELL1_MIC_NO_PRESENCE),
@@ -10294,6 +10309,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC269_FIXUP_DELL2_MIC_NO_PRESENCE, .name = "dell-headset-dock"},
 	{.id = ALC269_FIXUP_DELL3_MIC_NO_PRESENCE, .name = "dell-headset3"},
 	{.id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE, .name = "dell-headset4"},
+	{.id = ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET, .name = "dell-headset4-quiet"},
 	{.id = ALC283_FIXUP_CHROME_BOOK, .name = "alc283-dac-wcaps"},
 	{.id = ALC283_FIXUP_SENSE_COMBO_JACK, .name = "alc283-sense-combo"},
 	{.id = ALC292_FIXUP_TPT440_DOCK, .name = "tpt440-dock"},
@@ -10841,16 +10857,16 @@ static const struct snd_hda_pin_quirk alc269_fallback_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE_QUIET,
 		{0x19, 0x40000000},
 		{0x1b, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0236, 0x1028, "Dell", ALC255_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
-	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
+	SND_HDA_PIN_QUIRK(0x10ec0274, 0x1028, "Dell", ALC269_FIXUP_DELL1_LIMIT_INT_MIC_BOOST,
 		{0x19, 0x40000000},
 		{0x1a, 0x40000000}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC2XX_FIXUP_HEADSET_MIC,
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 4b832d52f643..cda621647602 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -750,8 +750,10 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 
 	cs42l51->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						      GPIOD_OUT_LOW);
-	if (IS_ERR(cs42l51->reset_gpio))
-		return PTR_ERR(cs42l51->reset_gpio);
+	if (IS_ERR(cs42l51->reset_gpio)) {
+		ret = PTR_ERR(cs42l51->reset_gpio);
+		goto error;
+	}
 
 	if (cs42l51->reset_gpio) {
 		dev_dbg(dev, "Release reset gpio\n");
@@ -783,6 +785,7 @@ int cs42l51_probe(struct device *dev, struct regmap *regmap)
 	return 0;
 
 error:
+	gpiod_set_value_cansleep(cs42l51->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(cs42l51->supplies),
 			       cs42l51->supplies);
 	return ret;
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index c8d48566e175..06965da51dd0 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -3465,6 +3465,9 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
 			break;
 		err = dell_dock_mixer_init(mixer);
 		break;
+	case USB_ID(0x0bda, 0x402e): /* Dell WD19 dock */
+		err = dell_dock_mixer_create(mixer);
+		break;
 
 	case USB_ID(0x2a39, 0x3fd2): /* RME ADI-2 Pro */
 	case USB_ID(0x2a39, 0x3fd3): /* RME ADI-2 DAC */
diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftests/vm/hmm-tests.c
index 4adaad1b822f..95af1a73f505 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -1652,7 +1652,7 @@ TEST_F(hmm2, double_map)
 
 	buffer->fd = -1;
 	buffer->size = size;
-	buffer->mirror = malloc(npages);
+	buffer->mirror = malloc(size);
 	ASSERT_NE(buffer->mirror, NULL);
 
 	/* Reserve a range of addresses. */
diff --git a/tools/usb/usbip/src/usbip_detach.c b/tools/usb/usbip/src/usbip_detach.c
index aec993159036..bc663ca79c74 100644
--- a/tools/usb/usbip/src/usbip_detach.c
+++ b/tools/usb/usbip/src/usbip_detach.c
@@ -68,6 +68,7 @@ static int detach_port(char *port)
 	}
 
 	if (!found) {
+		ret = -1;
 		err("Invalid port %s > maxports %d",
 			port, vhci_driver->nports);
 		goto call_driver_close;

