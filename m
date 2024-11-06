Return-Path: <stable+bounces-90851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FF39BEB54
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65761C2082C
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181B1E104A;
	Wed,  6 Nov 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfDgTHPe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18851E909B;
	Wed,  6 Nov 2024 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897001; cv=none; b=iqqHJv1V7XdelQDDSAXGFvl2CdFxVsqcNejL+2Cpml2gB/IYIUiKuRMjzy0AZ33yQLPGo++VfOr2dsPrOfmqwyWRRym4MRzUKHNexmYcqexy/OczIBVYjmI8BfAInzER8rz60wkSb7c3bJUL3dBiHBTKQr2ArlI70j3L3POa3NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897001; c=relaxed/simple;
	bh=VljtYjXIfeSGZeDJ2jwoQ5y8pqF7QZIqrF9fAkyqDKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+UiKP5OcdDZ4JnlI8pYRSVhdUOLgjgajKzbdsxXmeoeiQRPqZkiSvecQQSj9ul+4iKIGh53VGOl5KpzlziI3E/V32KiFkan0rjJsbrCxliK8i2gNzKgYEfGH9d/s3VLVk9HWKnGaiCv99IoAKryDQ3RLuYpg4JkITdHKUSRkvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XfDgTHPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551F3C4CECD;
	Wed,  6 Nov 2024 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897001;
	bh=VljtYjXIfeSGZeDJ2jwoQ5y8pqF7QZIqrF9fAkyqDKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfDgTHPeisnuqnPVFpSRkcbLHY4Pna4JPlf8a8jYJGerFteuA90941BmVS1esQa8I
	 SEfet0mj6sOrmmoW0kTb0S+8vByJX5Hr7UNSqnRivko6F7HcliDV5ijCaEu+lFixb5
	 A08kF9B3f6FGBk71lCcGCptzexoPVnNETlAwnw44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	aou@eecs.berkeley.edu,
	Borislav Petkov <bp@alien8.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Chris Zankel <chris@zankel.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jonas Bonn <jonas@southpole.se>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michal Simek <monstr@monstr.eu>,
	Nicholas Piggin <npiggin@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Rich Felker <dalias@libc.org>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Yoshinori Sato <ysato@users.osdn.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Guo Ren <guoren@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1 004/126] mm: remove kern_addr_valid() completely
Date: Wed,  6 Nov 2024 13:03:25 +0100
Message-ID: <20241106120306.172349650@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit e025ab842ec35225b1a8e163d1f311beb9e38ce9 ]

Most architectures (except arm64/x86/sparc) simply return 1 for
kern_addr_valid(), which is only used in read_kcore(), and it calls
copy_from_kernel_nofault() which could check whether the address is a
valid kernel address.  So as there is no need for kern_addr_valid(), let's
remove it.

Link: https://lkml.kernel.org/r/20221018074014.185687-1-wangkefeng.wang@huawei.com
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>	[m68k]
Acked-by: Heiko Carstens <hca@linux.ibm.com>		[s390]
Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Helge Deller <deller@gmx.de>			[parisc]
Acked-by: Michael Ellerman <mpe@ellerman.id.au>		[powerpc]
Acked-by: Guo Ren <guoren@kernel.org>			[csky]
Acked-by: Catalin Marinas <catalin.marinas@arm.com>	[arm64]
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: <aou@eecs.berkeley.edu>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Chris Zankel <chris@zankel.net>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Greg Ungerer <gerg@linux-m68k.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rich Felker <dalias@libc.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Xuerui Wang <kernel@xen0n.name>
Cc: Yoshinori Sato <ysato@users.osdn.me>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3d5854d75e31 ("fs/proc/kcore.c: allow translation of physical memory addresses")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/include/asm/pgtable.h          |  2 -
 arch/arc/include/asm/pgtable-bits-arcv2.h |  2 -
 arch/arm/include/asm/pgtable-nommu.h      |  2 -
 arch/arm/include/asm/pgtable.h            |  4 --
 arch/arm64/include/asm/pgtable.h          |  2 -
 arch/arm64/mm/mmu.c                       | 47 -----------------------
 arch/arm64/mm/pageattr.c                  |  3 +-
 arch/csky/include/asm/pgtable.h           |  3 --
 arch/hexagon/include/asm/page.h           |  7 ----
 arch/ia64/include/asm/pgtable.h           | 16 --------
 arch/loongarch/include/asm/pgtable.h      |  2 -
 arch/m68k/include/asm/pgtable_mm.h        |  2 -
 arch/m68k/include/asm/pgtable_no.h        |  1 -
 arch/microblaze/include/asm/pgtable.h     |  3 --
 arch/mips/include/asm/pgtable.h           |  2 -
 arch/nios2/include/asm/pgtable.h          |  2 -
 arch/openrisc/include/asm/pgtable.h       |  2 -
 arch/parisc/include/asm/pgtable.h         | 15 --------
 arch/powerpc/include/asm/pgtable.h        |  7 ----
 arch/riscv/include/asm/pgtable.h          |  2 -
 arch/s390/include/asm/pgtable.h           |  2 -
 arch/sh/include/asm/pgtable.h             |  2 -
 arch/sparc/include/asm/pgtable_32.h       |  6 ---
 arch/sparc/mm/init_32.c                   |  3 +-
 arch/sparc/mm/init_64.c                   |  1 -
 arch/um/include/asm/pgtable.h             |  2 -
 arch/x86/include/asm/pgtable_32.h         |  9 -----
 arch/x86/include/asm/pgtable_64.h         |  1 -
 arch/x86/mm/init_64.c                     | 41 --------------------
 arch/xtensa/include/asm/pgtable.h         |  2 -
 fs/proc/kcore.c                           | 26 +++++--------
 31 files changed, 11 insertions(+), 210 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 3ea9661c09ffc..9e45f6735d5d2 100644
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
index b23be557403e3..515e82db519fe 100644
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
index 090011394477f..61480d096054d 100644
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
index ef48a55e9af83..f049072b2e858 100644
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
index 56c7df4c65325..1d713cfb0af16 100644
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
index 4b302dbf78e96..6a4f118fb25f4 100644
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
index 425b398f8d456..0a62f458c5cb0 100644
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
index c3d9b92cbe61c..77bc6caff2d23 100644
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
index 7cbf719c578ec..d7d4f9fca3279 100644
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
index 6925e28ae61d1..01517a5e67789 100644
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
index f991e678ca4b7..103df0eb8642a 100644
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
diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
index 9b4e2fe2ac821..b93c41fe20678 100644
--- a/arch/m68k/include/asm/pgtable_mm.h
+++ b/arch/m68k/include/asm/pgtable_mm.h
@@ -145,8 +145,6 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 
 #endif /* !__ASSEMBLY__ */
 
-#define kern_addr_valid(addr)	(1)
-
 /* MMU-specific headers */
 
 #ifdef CONFIG_SUN3
diff --git a/arch/m68k/include/asm/pgtable_no.h b/arch/m68k/include/asm/pgtable_no.h
index bce5ca56c3883..fed58da3a6b65 100644
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
index ba348e997dbb4..42f5988e998b8 100644
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
index 4678627673dfe..a68c0b01d8cdc 100644
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
index b3d45e815295f..ab793bc517f5c 100644
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
index dcae8aea132fd..6477c17b3062d 100644
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
index 68ae77069d23f..ea357430aafeb 100644
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
index 283f40d05a4d7..9972626ddaf68 100644
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
index 2d9416a6a070e..7d1688f850c31 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -805,8 +805,6 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 
 #endif /* !CONFIG_MMU */
 
-#define kern_addr_valid(addr)   (1) /* FIXME */
-
 extern char _start[];
 extern void *_dtb_early_va;
 extern uintptr_t _dtb_early_pa;
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 956300e3568a4..4d6ab5f0a4cf0 100644
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
index 6fb9ec54cf9b4..3ce30becf6dfa 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -92,8 +92,6 @@ static inline unsigned long phys_addr_mask(void)
 
 typedef pte_t *pte_addr_t;
 
-#define kern_addr_valid(addr)	(1)
-
 #define pte_pfn(x)		((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
 
 struct vm_area_struct;
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 8ff549004fac4..5acc05b572e65 100644
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
index d88e774c8eb49..9c0ea457bdf05 100644
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
index d6faee23c77dd..04f9db0c31117 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1667,7 +1667,6 @@ bool kern_addr_valid(unsigned long addr)
 
 	return pfn_valid(pte_pfn(*pte));
 }
-EXPORT_SYMBOL(kern_addr_valid);
 
 static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 					      unsigned long vend,
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 66bc3f99d9bef..4e3052f2671a0 100644
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
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 7c9c968a42efe..7d4ad8907297c 100644
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
index 07cd53eeec770..a629b1b9f65a6 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -240,7 +240,6 @@ static inline void native_pgd_clear(pgd_t *pgd)
 #define __swp_entry_to_pte(x)		(__pte((x).val))
 #define __swp_entry_to_pmd(x)		(__pmd((x).val))
 
-extern int kern_addr_valid(unsigned long addr);
 extern void cleanup_highmap(void);
 
 #define HAVE_ARCH_UNMAPPED_AREA
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 6d294d24e488e..851711509d383 100644
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
index 54f577c13afa1..5b5484d707b2e 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -386,8 +386,6 @@ ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 
 #else
 
-#define kern_addr_valid(addr)	(1)
-
 extern  void update_mmu_cache(struct vm_area_struct * vma,
 			      unsigned long address, pte_t *ptep);
 
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index dff921f7ca332..590ecb79ad8b6 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -541,25 +541,17 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
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
-						ret = -EFAULT;
-						goto out;
-					}
-				} else {
-					if (copy_to_user(buffer, buf, tsz)) {
-						ret = -EFAULT;
-						goto out;
-					}
+			/*
+			 * Using bounce buffer to bypass the
+			 * hardened user copy kernel text checks.
+			 */
+			if (copy_from_kernel_nofault(buf, (void *)start, tsz)) {
+				if (clear_user(buffer, tsz)) {
+					ret = -EFAULT;
+					goto out;
 				}
 			} else {
-				if (clear_user(buffer, tsz)) {
+				if (copy_to_user(buffer, buf, tsz)) {
 					ret = -EFAULT;
 					goto out;
 				}
-- 
2.43.0




