Return-Path: <stable+bounces-75636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30CF97382C
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 15:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D743B1C2436B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 13:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153F18FC80;
	Tue, 10 Sep 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="J8NeYtqP"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0A18801A
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973324; cv=none; b=gh8mAUzQt7Slb0EjFQ5zPlOInwP34430Tv/C6ICNBL+mzak2B/DcU/uuhrmsoKZo54b4iRMBlIQB8/XOZ2p8/WCgg4/R+Na7GM4O+UTQaBHciDoIkyOTPZK8E1dWCCleeOAkTCLEx6adxGILUdGRvroiVoZcNp/D05+INPLEsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973324; c=relaxed/simple;
	bh=C1lPvPOv5BkuU8UNveJDAR70pOFp8leafu6nWrb+jGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAOIiob05vVj/PtzyN86cRIc1Bvkv6AIDrhKSlC1s+gSlvXOI+ivszGGVN35ph+i2iqDMA8SqBV9LYA77Vipz4rsGQiaUnFieGUqfBk5dFM8ZBlUsf3Kd9xIx5jHZPlLRGYGBli92tXvhgZ2xGF3L1nur6iDWZeCmC2r/zXcZ7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=J8NeYtqP; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1725973311;
	bh=SKVG39C3Syh1G3uOh1QkgK8tDu1INvQu6vcDB+xU6So=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=J8NeYtqPbY+qRaTxN9piLK9izZNuAoa/PKdMaKd8TVkC+sxMRCHrpnh4nAlZUjkMq
	 ra+e0xxpDyTiyNZF2xvOvOB06P2adRoTWyTljqevrblI5qWeahyV7PBauclhOhDSwx
	 dx04YjYhv1RdEBij7Tgi8GJEddycBm1KMbmMtrbk=
X-QQ-mid: bizesmtpsz10t1725973307ta5nxx
X-QQ-Originating-IP: qU1BIIE/4zwGnGe9bzJAHXBzJugMeQpeZ1nllbZTbJ8=
Received: from localhost.localdomain ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Sep 2024 21:01:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15173444307273299148
From: He Lugang <helugang@uniontech.com>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	He Lugang <helugang@uniontech.com>
Subject: [PATCH 6.6.y 2/2] LoongArch: Use accessors to page table entries instead of direct dereference
Date: Tue, 10 Sep 2024 21:01:04 +0800
Message-ID: <E722ED3F1F8D57D2+20240910130104.17323-2-helugang@uniontech.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910130104.17323-1-helugang@uniontech.com>
References: <2024091028-stinking-mourner-56f5@gregkh>
 <20240910130104.17323-1-helugang@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0

From: Huacai Chen <chenhuacai@loongson.cn>

From: Huacai Chen <chenhuacai@loongson.cn>

commit 4574815abf43e2bf05643e1b3f7a2e5d6df894f0 upstream

As very well explained in commit 20a004e7b017cce282 ("arm64: mm: Use
READ_ONCE/WRITE_ONCE when accessing page tables"), an architecture whose
page table walker can modify the PTE in parallel must use READ_ONCE()/
WRITE_ONCE() macro to avoid any compiler transformation.

So apply that to LoongArch which is such an architecture, in order to
avoid potential problems.

Similar to commit edf955647269422e ("riscv: Use accessors to page table
entries instead of direct dereference").

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: He Lugang <helugang@uniontech.com>
---
 arch/loongarch/include/asm/hugetlb.h |  4 +--
 arch/loongarch/include/asm/kfence.h  |  6 ++--
 arch/loongarch/include/asm/pgtable.h | 48 +++++++++++++++++-----------
 arch/loongarch/kvm/mmu.c             |  8 ++---
 arch/loongarch/mm/hugetlbpage.c      |  6 ++--
 arch/loongarch/mm/init.c             | 10 +++---
 arch/loongarch/mm/kasan_init.c       | 10 +++---
 arch/loongarch/mm/pgtable.c          |  2 +-
 8 files changed, 52 insertions(+), 42 deletions(-)

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
index 6c82aea1c993..2835b41d2a84 100644
--- a/arch/loongarch/include/asm/kfence.h
+++ b/arch/loongarch/include/asm/kfence.h
@@ -43,13 +43,13 @@ static inline bool kfence_protect_page(unsigned long addr, bool protect)
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
index 29d9b12298bc..2df497d2f864 100644
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
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	pud_val(*pudp) = ((unsigned long)invalid_pmd_table);
+	return (pmd_t *)pud_val(pud);
 }
 
-static inline pmd_t *pud_pgtable(pud_t pud)
+static inline void set_pud(pud_t *pud, pud_t pudval)
 {
-	return (pmd_t *)pud_val(pud);
+	WRITE_ONCE(*pud, pudval);
 }
 
-#define set_pud(pudptr, pudval) do { *(pudptr) = (pudval); } while (0)
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
@@ -591,7 +601,7 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 					    unsigned long address, pmd_t *pmdp)
 {
-	pmd_t old = *pmdp;
+	pmd_t old = pmdp_get(pmdp);
 
 	pmd_clear(pmdp);
 
diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index 80480df5f550..545a824e38b1 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -679,19 +679,19 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
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
index 1e76fcb83093..62ddcea0aa14 100644
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
index 4dd53427f657..71fa4b773eb3 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -140,7 +140,7 @@ void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
 int __meminit vmemmap_check_pmd(pmd_t *pmd, int node,
 				unsigned long addr, unsigned long next)
 {
-	int huge = pmd_val(*pmd) & _PAGE_HUGE;
+	int huge = pmd_val(pmdp_get(pmd)) & _PAGE_HUGE;
 
 	if (huge)
 		vmemmap_verify((pte_t *)pmd, node, addr, next);
@@ -172,7 +172,7 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
 	pud_t *pud;
 	pmd_t *pmd;
 
-	if (p4d_none(*p4d)) {
+	if (p4d_none(p4dp_get(p4d))) {
 		pud = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		if (!pud)
 			panic("%s: Failed to allocate memory\n", __func__);
@@ -183,7 +183,7 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
 	}
 
 	pud = pud_offset(p4d, addr);
-	if (pud_none(*pud)) {
+	if (pud_none(pudp_get(pud))) {
 		pmd = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
 		if (!pmd)
 			panic("%s: Failed to allocate memory\n", __func__);
@@ -194,7 +194,7 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
 	}
 
 	pmd = pmd_offset(pud, addr);
-	if (!pmd_present(*pmd)) {
+	if (!pmd_present(pmdp_get(pmd))) {
 		pte_t *pte;
 
 		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
@@ -215,7 +215,7 @@ void __init __set_fixmap(enum fixed_addresses idx,
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
index 2aae72e63871..6a038a27373a 100644
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
 
-- 
2.45.2


