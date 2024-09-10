Return-Path: <stable+bounces-74145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240A972C9F
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91DE0B24072
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 08:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE0186294;
	Tue, 10 Sep 2024 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yyZIizP9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EC117C9B9
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958529; cv=none; b=RHKbf5yzKSPs8AuU6Zpnd6s+1DlbvT8kw/+ARZyXbuqr/BWT7HtrEIzD/CxlbFIDUS1omF92T/hPnEk08mInWZg+uyhkCCDgx3UocUdUQbjArpoxHPjPCwwoQao8gxEmrVFz1pUc/mEOUxt7TPhEjo3ACvRUjH2NvDUTSWIBkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958529; c=relaxed/simple;
	bh=nhQPblASwIiiJ61RR/ri1sBuX/ce5JlhIKCLHRCHoRE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZKBi38D6uRTKinwEVU3FTnqB44eqPSDpAqoCMs0mKram2woiFVyvIqxmn78MaVft2b26ggqRM4Zl973ivXh6YU38zrgzgFM9/giXzTQ8omhvGg7djf++3HYPtLPWBIlIbGjYsH8Q9E9/ViU+lhbtplhLMbQjHwiHkW77HTwxl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yyZIizP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4E8C4CEC3;
	Tue, 10 Sep 2024 08:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725958528;
	bh=nhQPblASwIiiJ61RR/ri1sBuX/ce5JlhIKCLHRCHoRE=;
	h=Subject:To:Cc:From:Date:From;
	b=yyZIizP9M10lugo4peP9vMDXD7/AW1LY7xNupWhQdbvPRQixbCgnbphsZ/x9fPK3E
	 0Q5bnv6MY7H/DWSBNYyjTlHShm+C5VpLz19HzhfX8R1CztBC9HGTjmvQIiDsQE6GaZ
	 X6RS6sVg1dJ2XTJDiM6TgHU5h7bYOBsxdrHmh7Ts=
Subject: FAILED: patch "[PATCH] LoongArch: Use accessors to page table entries instead of" failed to apply to 6.10-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Sep 2024 10:55:25 +0200
Message-ID: <2024091025-freeway-unlocked-8c52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4574815abf43e2bf05643e1b3f7a2e5d6df894f0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024091025-freeway-unlocked-8c52@gregkh' --subject-prefix 'PATCH 6.10.y' HEAD^..

Possible dependencies:

4574815abf43 ("LoongArch: Use accessors to page table entries instead of direct dereference")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4574815abf43e2bf05643e1b3f7a2e5d6df894f0 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 7 Aug 2024 17:37:11 +0800
Subject: [PATCH] LoongArch: Use accessors to page table entries instead of
 direct dereference

As very well explained in commit 20a004e7b017cce282 ("arm64: mm: Use
READ_ONCE/WRITE_ONCE when accessing page tables"), an architecture whose
page table walker can modify the PTE in parallel must use READ_ONCE()/
WRITE_ONCE() macro to avoid any compiler transformation.

So apply that to LoongArch which is such an architecture, in order to
avoid potential problems.

Similar to commit edf955647269422e ("riscv: Use accessors to page table
entries instead of direct dereference").

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

diff --git a/arch/loongarch/include/asm/hugetlb.h b/arch/loongarch/include/asm/hugetlb.h
index aa44b3fe43dd..5da32c00d483 100644
--- a/arch/loongarch/include/asm/hugetlb.h
+++ b/arch/loongarch/include/asm/hugetlb.h
@@ -34,7 +34,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr, pte_t *ptep)
 {
 	pte_t clear;
-	pte_t pte = *ptep;
+	pte_t pte = ptep_get(ptep);
 
 	pte_val(clear) = (unsigned long)invalid_pte_table;
 	set_pte_at(mm, addr, ptep, clear);
@@ -65,7 +65,7 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 					     pte_t *ptep, pte_t pte,
 					     int dirty)
 {
-	int changed = !pte_same(*ptep, pte);
+	int changed = !pte_same(ptep_get(ptep), pte);
 
 	if (changed) {
 		set_pte_at(vma->vm_mm, addr, ptep, pte);
diff --git a/arch/loongarch/include/asm/kfence.h b/arch/loongarch/include/asm/kfence.h
index 92636e82957c..da9e93024626 100644
--- a/arch/loongarch/include/asm/kfence.h
+++ b/arch/loongarch/include/asm/kfence.h
@@ -53,13 +53,13 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
 {
 	pte_t *pte = virt_to_kpte(addr);
 
-	if (WARN_ON(!pte) || pte_none(*pte))
+	if (WARN_ON(!pte) || pte_none(ptep_get(pte)))
 		return false;
 
 	if (protect)
-		set_pte(pte, __pte(pte_val(*pte) & ~(_PAGE_VALID | _PAGE_PRESENT)));
+		set_pte(pte, __pte(pte_val(ptep_get(pte)) & ~(_PAGE_VALID | _PAGE_PRESENT)));
 	else
-		set_pte(pte, __pte(pte_val(*pte) | (_PAGE_VALID | _PAGE_PRESENT)));
+		set_pte(pte, __pte(pte_val(ptep_get(pte)) | (_PAGE_VALID | _PAGE_PRESENT)));
 
 	preempt_disable();
 	local_flush_tlb_one(addr);
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 3fbf1f37c58e..85431f20a14d 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -106,6 +106,9 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define KFENCE_AREA_START	(VMEMMAP_END + 1)
 #define KFENCE_AREA_END		(KFENCE_AREA_START + KFENCE_AREA_SIZE - 1)
 
+#define ptep_get(ptep) READ_ONCE(*(ptep))
+#define pmdp_get(pmdp) READ_ONCE(*(pmdp))
+
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
 #ifndef __PAGETABLE_PMD_FOLDED
@@ -147,11 +150,6 @@ static inline int p4d_present(p4d_t p4d)
 	return p4d_val(p4d) != (unsigned long)invalid_pud_table;
 }
 
-static inline void p4d_clear(p4d_t *p4dp)
-{
-	p4d_val(*p4dp) = (unsigned long)invalid_pud_table;
-}
-
 static inline pud_t *p4d_pgtable(p4d_t p4d)
 {
 	return (pud_t *)p4d_val(p4d);
@@ -159,7 +157,12 @@ static inline pud_t *p4d_pgtable(p4d_t p4d)
 
 static inline void set_p4d(p4d_t *p4d, p4d_t p4dval)
 {
-	*p4d = p4dval;
+	WRITE_ONCE(*p4d, p4dval);
+}
+
+static inline void p4d_clear(p4d_t *p4dp)
+{
+	set_p4d(p4dp, __p4d((unsigned long)invalid_pud_table));
 }
 
 #define p4d_phys(p4d)		PHYSADDR(p4d_val(p4d))
@@ -193,17 +196,20 @@ static inline int pud_present(pud_t pud)
 	return pud_val(pud) != (unsigned long)invalid_pmd_table;
 }
 
-static inline void pud_clear(pud_t *pudp)
-{
-	pud_val(*pudp) = ((unsigned long)invalid_pmd_table);
-}
-
 static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	return (pmd_t *)pud_val(pud);
 }
 
-#define set_pud(pudptr, pudval) do { *(pudptr) = (pudval); } while (0)
+static inline void set_pud(pud_t *pud, pud_t pudval)
+{
+	WRITE_ONCE(*pud, pudval);
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	set_pud(pudp, __pud((unsigned long)invalid_pmd_table));
+}
 
 #define pud_phys(pud)		PHYSADDR(pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
@@ -231,12 +237,15 @@ static inline int pmd_present(pmd_t pmd)
 	return pmd_val(pmd) != (unsigned long)invalid_pte_table;
 }
 
-static inline void pmd_clear(pmd_t *pmdp)
+static inline void set_pmd(pmd_t *pmd, pmd_t pmdval)
 {
-	pmd_val(*pmdp) = ((unsigned long)invalid_pte_table);
+	WRITE_ONCE(*pmd, pmdval);
 }
 
-#define set_pmd(pmdptr, pmdval) do { *(pmdptr) = (pmdval); } while (0)
+static inline void pmd_clear(pmd_t *pmdp)
+{
+	set_pmd(pmdp, __pmd((unsigned long)invalid_pte_table));
+}
 
 #define pmd_phys(pmd)		PHYSADDR(pmd_val(pmd))
 
@@ -314,7 +323,8 @@ extern void paging_init(void);
 
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
-	*ptep = pteval;
+	WRITE_ONCE(*ptep, pteval);
+
 	if (pte_val(pteval) & _PAGE_GLOBAL) {
 		pte_t *buddy = ptep_buddy(ptep);
 		/*
@@ -341,8 +351,8 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 		: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 		: [global] "r" (page_global));
 #else /* !CONFIG_SMP */
-		if (pte_none(*buddy))
-			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
+		if (pte_none(ptep_get(buddy)))
+			WRITE_ONCE(*buddy, __pte(pte_val(ptep_get(buddy)) | _PAGE_GLOBAL));
 #endif /* CONFIG_SMP */
 	}
 }
@@ -350,7 +360,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
 	/* Preserve global status for the pair */
-	if (pte_val(*ptep_buddy(ptep)) & _PAGE_GLOBAL)
+	if (pte_val(ptep_get(ptep_buddy(ptep))) & _PAGE_GLOBAL)
 		set_pte(ptep, __pte(_PAGE_GLOBAL));
 	else
 		set_pte(ptep, __pte(0));
@@ -603,7 +613,7 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address, pmd_t *pmdp)
 {
-	pmd_t old = *pmdp;
+	pmd_t old = pmdp_get(pmdp);
 
 	pmd_clear(pmdp);
 
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index 2634a9e8d82c..28681dfb4b85 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -714,19 +714,19 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	 * value) and then p*d_offset() walks into the target huge page instead
 	 * of the old page table (sees the new value).
 	 */
-	pgd = READ_ONCE(*pgd_offset(kvm->mm, hva));
+	pgd = pgdp_get(pgd_offset(kvm->mm, hva));
 	if (pgd_none(pgd))
 		goto out;
 
-	p4d = READ_ONCE(*p4d_offset(&pgd, hva));
+	p4d = p4dp_get(p4d_offset(&pgd, hva));
 	if (p4d_none(p4d) || !p4d_present(p4d))
 		goto out;
 
-	pud = READ_ONCE(*pud_offset(&p4d, hva));
+	pud = pudp_get(pud_offset(&p4d, hva));
 	if (pud_none(pud) || !pud_present(pud))
 		goto out;
 
-	pmd = READ_ONCE(*pmd_offset(&pud, hva));
+	pmd = pmdp_get(pmd_offset(&pud, hva));
 	if (pmd_none(pmd) || !pmd_present(pmd))
 		goto out;
 
diff --git a/arch/loongarch/mm/hugetlbpage.c b/arch/loongarch/mm/hugetlbpage.c
index 12222c56cb59..e4068906143b 100644
--- a/arch/loongarch/mm/hugetlbpage.c
+++ b/arch/loongarch/mm/hugetlbpage.c
@@ -39,11 +39,11 @@ pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
 	pmd_t *pmd = NULL;
 
 	pgd = pgd_offset(mm, addr);
-	if (pgd_present(*pgd)) {
+	if (pgd_present(pgdp_get(pgd))) {
 		p4d = p4d_offset(pgd, addr);
-		if (p4d_present(*p4d)) {
+		if (p4d_present(p4dp_get(p4d))) {
 			pud = pud_offset(p4d, addr);
-			if (pud_present(*pud))
+			if (pud_present(pudp_get(pud)))
 				pmd = pmd_offset(pud, addr);
 		}
 	}
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index bf789d114c2d..8a87a482c8f4 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -141,7 +141,7 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 				unsigned long addr, unsigned long next)
 {
-	int huge = pmd_val(*pmd) & _PAGE_HUGE;
+	int huge = pmd_val(pmdp_get(pmd)) & _PAGE_HUGE;
 
 	if (huge)
 		vmemmap_verify((pte_t *)pmd, node, addr, next);
@@ -173,7 +173,7 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
 	pud_t *pud;
 	pmd_t *pmd;
 
-	if (p4d_none(*p4d)) {
+	if (p4d_none(p4dp_get(p4d))) {
 		pud = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		if (!pud)
 			panic("%s: Failed to allocate memory\n", __func__);
@@ -184,7 +184,7 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
 	}
 
 	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud)) {
+	if (pud_none(pudp_get(pud))) {
 		pmd = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		if (!pmd)
 			panic("%s: Failed to allocate memory\n", __func__);
@@ -195,7 +195,7 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
 	}
 
 	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd)) {
+	if (!pmd_present(pmdp_get(pmd))) {
 		pte_t *pte;
 
 		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
@@ -216,7 +216,7 @@ void __init __set_fixmap(enum fixed_addresses idx,
 	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
 
 	ptep = populate_kernel_pte(addr);
-	if (!pte_none(*ptep)) {
+	if (!pte_none(ptep_get(ptep))) {
 		pte_ERROR(*ptep);
 		return;
 	}
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index c608adc99845..427d6b1aec09 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -105,7 +105,7 @@ static phys_addr_t __init kasan_alloc_zeroed_page(int node)
 
 static pte_t *__init kasan_pte_offset(pmd_t *pmdp, unsigned long addr, int node, bool early)
 {
-	if (__pmd_none(early, READ_ONCE(*pmdp))) {
+	if (__pmd_none(early, pmdp_get(pmdp))) {
 		phys_addr_t pte_phys = early ?
 				__pa_symbol(kasan_early_shadow_pte) : kasan_alloc_zeroed_page(node);
 		if (!early)
@@ -118,7 +118,7 @@ static pte_t *__init kasan_pte_offset(pmd_t *pmdp, unsigned long addr, int node,
 
 static pmd_t *__init kasan_pmd_offset(pud_t *pudp, unsigned long addr, int node, bool early)
 {
-	if (__pud_none(early, READ_ONCE(*pudp))) {
+	if (__pud_none(early, pudp_get(pudp))) {
 		phys_addr_t pmd_phys = early ?
 				__pa_symbol(kasan_early_shadow_pmd) : kasan_alloc_zeroed_page(node);
 		if (!early)
@@ -131,7 +131,7 @@ static pmd_t *__init kasan_pmd_offset(pud_t *pudp, unsigned long addr, int node,
 
 static pud_t *__init kasan_pud_offset(p4d_t *p4dp, unsigned long addr, int node, bool early)
 {
-	if (__p4d_none(early, READ_ONCE(*p4dp))) {
+	if (__p4d_none(early, p4dp_get(p4dp))) {
 		phys_addr_t pud_phys = early ?
 			__pa_symbol(kasan_early_shadow_pud) : kasan_alloc_zeroed_page(node);
 		if (!early)
@@ -154,7 +154,7 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 					      : kasan_alloc_zeroed_page(node);
 		next = addr + PAGE_SIZE;
 		set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
-	} while (ptep++, addr = next, addr != end && __pte_none(early, READ_ONCE(*ptep)));
+	} while (ptep++, addr = next, addr != end && __pte_none(early, ptep_get(ptep)));
 }
 
 static void __init kasan_pmd_populate(pud_t *pudp, unsigned long addr,
@@ -166,7 +166,7 @@ static void __init kasan_pmd_populate(pud_t *pudp, unsigned long addr,
 	do {
 		next = pmd_addr_end(addr, end);
 		kasan_pte_populate(pmdp, addr, next, node, early);
-	} while (pmdp++, addr = next, addr != end && __pmd_none(early, READ_ONCE(*pmdp)));
+	} while (pmdp++, addr = next, addr != end && __pmd_none(early, pmdp_get(pmdp)));
 }
 
 static void __init kasan_pud_populate(p4d_t *p4dp, unsigned long addr,
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index bda018150000..eb6a29b491a7 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -128,7 +128,7 @@ pmd_t mk_pmd(struct page *page, pgprot_t prot)
 void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 		pmd_t *pmdp, pmd_t pmd)
 {
-	*pmdp = pmd;
+	WRITE_ONCE(*pmdp, pmd);
 	flush_tlb_all();
 }
 


