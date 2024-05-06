Return-Path: <stable+bounces-43081-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE738BC4F7
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 02:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1370F1C210AE
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 00:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715B13A27B;
	Mon,  6 May 2024 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NQKP6CBv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7438F91;
	Mon,  6 May 2024 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957159; cv=none; b=sA2rx1OjJHENuiG/fexEEhO9CxlRA0Cx4H7E9/ho9vmRASMtM/5DVLkWDcnpxZgQFqbQDYhFHT3QapMdzas8QdOWBO1St+NJiLkvIOBThwy9fLKD3qYJYVChTaojHSL3P34tIxgpz6E1LOws4r9QSDg0OWTZWCczQst7UbovJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957159; c=relaxed/simple;
	bh=I81ycal2YXN7AP5D6VqdpOiMOT/ofRv4dsJ+bKp348w=;
	h=Date:To:From:Subject:Message-Id; b=f31iVfCuERrPelMvTB+b5DxgnysJ+enVcQ8qZBXwPkMcSrDC+o+sjgVK5HGIoPYuYDAzRxISUmWBAXa383njPrs37l7bYNP5pxBcyJYfOrzfm7uxyQ+3n2LrXEbg5SK7rHqiQkNNVeCk8zWAfN5xI6emIqTIdgB9cBE4hFL/fzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NQKP6CBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E5FC113CC;
	Mon,  6 May 2024 00:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714957159;
	bh=I81ycal2YXN7AP5D6VqdpOiMOT/ofRv4dsJ+bKp348w=;
	h=Date:To:From:Subject:From;
	b=NQKP6CBveC/VZHmZuFsSK3D0W9vAGQB/WwkgYLE5b2f7uV0he8MldU6Q52fl4HR9U
	 Uw1BAWG3FwIhKoLxUvjNdxl7/QWZZp1z/ptVnXQ8m/eDOuXOLFZcjmzdQ/PV6XybfF
	 NUHkAoGKSqvTAqTRIwDykC1JV7/5bSuKYZRxnjEw=
Date: Sun, 05 May 2024 17:59:18 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,will@kernel.org,tglx@linutronix.de,svens@linux.ibm.com,stable@vger.kernel.org,peterz@infradead.org,npiggin@gmail.com,naveen.n.rao@linux.ibm.com,mingo@redhat.com,mark.rutland@arm.com,luto@kernel.org,david@redhat.com,davem@davemloft.net,dave.hansen@linux.intel.com,corbet@lwn.net,christophe.leroy@csgroup.eu,catalin.marinas@arm.com,bp@alien8.de,borntraeger@linux.ibm.com,anshuman.khandual@arm.com,aneesh.kumar@kernel.org,andreas@gaisler.com,ryan.roberts@arm.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast.patch removed from -mm tree
Message-Id: <20240506005919.03E5FC113CC@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: fix race between __split_huge_pmd_locked() and GUP-fast
has been removed from the -mm tree.  Its filename was
     mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Ryan Roberts <ryan.roberts@arm.com>
Subject: mm: fix race between __split_huge_pmd_locked() and GUP-fast
Date: Wed, 1 May 2024 15:33:10 +0100

__split_huge_pmd_locked() can be called for a present THP, devmap or
(non-present) migration entry.  It calls pmdp_invalidate() unconditionally
on the pmdp and only determines if it is present or not based on the
returned old pmd.  This is a problem for the migration entry case because
pmd_mkinvalid(), called by pmdp_invalidate() must only be called for a
present pmd.

On arm64 at least, pmd_mkinvalid() will mark the pmd such that any future
call to pmd_present() will return true.  And therefore any lockless
pgtable walker could see the migration entry pmd in this state and start
interpretting the fields as if it were present, leading to BadThings (TM).
GUP-fast appears to be one such lockless pgtable walker.

x86 does not suffer the above problem, but instead pmd_mkinvalid() will
corrupt the offset field of the swap entry within the swap pte.  See link
below for discussion of that problem.

Fix all of this by only calling pmdp_invalidate() for a present pmd.  And
for good measure let's add a warning to all implementations of
pmdp_invalidate[_ad]().  I've manually reviewed all other
pmdp_invalidate[_ad]() call sites and believe all others to be conformant.

This is a theoretical bug found during code review.  I don't have any test
case to trigger it in practice.

Link: https://lkml.kernel.org/r/20240501143310.1381675-1-ryan.roberts@arm.com
Link: https://lore.kernel.org/all/0dd7827a-6334-439a-8fd0-43c98e6af22b@arm.com/
Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/mm/arch_pgtable_helpers.rst |    6 +-
 arch/powerpc/mm/book3s64/pgtable.c        |    1 
 arch/s390/include/asm/pgtable.h           |    4 +
 arch/sparc/mm/tlb.c                       |    1 
 arch/x86/mm/pgtable.c                     |    2 
 mm/huge_memory.c                          |   49 ++++++++++----------
 mm/pgtable-generic.c                      |    2 
 7 files changed, 39 insertions(+), 26 deletions(-)

--- a/arch/powerpc/mm/book3s64/pgtable.c~mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast
+++ a/arch/powerpc/mm/book3s64/pgtable.c
@@ -170,6 +170,7 @@ pmd_t pmdp_invalidate(struct vm_area_str
 {
 	unsigned long old_pmd;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return __pmd(old_pmd);
--- a/arch/s390/include/asm/pgtable.h~mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast
+++ a/arch/s390/include/asm/pgtable.h
@@ -1769,8 +1769,10 @@ static inline pmd_t pmdp_huge_clear_flus
 static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmdp)
 {
-	pmd_t pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
+	pmd_t pmd;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
+	pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
 	return pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
 }
 
--- a/arch/sparc/mm/tlb.c~mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast
+++ a/arch/sparc/mm/tlb.c
@@ -249,6 +249,7 @@ pmd_t pmdp_invalidate(struct vm_area_str
 {
 	pmd_t old, entry;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
 	old = pmdp_establish(vma, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
--- a/arch/x86/mm/pgtable.c~mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast
+++ a/arch/x86/mm/pgtable.c
@@ -631,6 +631,8 @@ int pmdp_clear_flush_young(struct vm_are
 pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 			 pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
+
 	/*
 	 * No flush is necessary. Once an invalid PTE is established, the PTE's
 	 * access and dirty bits cannot be updated.
--- a/Documentation/mm/arch_pgtable_helpers.rst~mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast
+++ a/Documentation/mm/arch_pgtable_helpers.rst
@@ -140,7 +140,8 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_swp_clear_soft_dirty  | Clears a soft dirty swapped PMD                  |
 +---------------------------+--------------------------------------------------+
-| pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
+| pmd_mkinvalid             | Invalidates a present PMD; do not call for       |
+|                           | non-present PMD [1]                              |
 +---------------------------+--------------------------------------------------+
 | pmd_set_huge              | Creates a PMD huge mapping                       |
 +---------------------------+--------------------------------------------------+
@@ -196,7 +197,8 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_mkdevmap              | Creates a ZONE_DEVICE mapped PUD                 |
 +---------------------------+--------------------------------------------------+
-| pud_mkinvalid             | Invalidates a mapped PUD [1]                     |
+| pud_mkinvalid             | Invalidates a present PUD; do not call for       |
+|                           | non-present PUD [1]                              |
 +---------------------------+--------------------------------------------------+
 | pud_set_huge              | Creates a PUD huge mapping                       |
 +---------------------------+--------------------------------------------------+
--- a/mm/huge_memory.c~mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast
+++ a/mm/huge_memory.c
@@ -2430,32 +2430,11 @@ static void __split_huge_pmd_locked(stru
 		return __split_huge_zero_page_pmd(vma, haddr, pmd);
 	}
 
-	/*
-	 * Up to this point the pmd is present and huge and userland has the
-	 * whole access to the hugepage during the split (which happens in
-	 * place). If we overwrite the pmd with the not-huge version pointing
-	 * to the pte here (which of course we could if all CPUs were bug
-	 * free), userland could trigger a small page size TLB miss on the
-	 * small sized TLB while the hugepage TLB entry is still established in
-	 * the huge TLB. Some CPU doesn't like that.
-	 * See http://support.amd.com/TechDocs/41322_10h_Rev_Gd.pdf, Erratum
-	 * 383 on page 105. Intel should be safe but is also warns that it's
-	 * only safe if the permission and cache attributes of the two entries
-	 * loaded in the two TLB is identical (which should be the case here).
-	 * But it is generally safer to never allow small and huge TLB entries
-	 * for the same virtual address to be loaded simultaneously. So instead
-	 * of doing "pmd_populate(); flush_pmd_tlb_range();" we first mark the
-	 * current pmd notpresent (atomically because here the pmd_trans_huge
-	 * must remain set at all times on the pmd until the split is complete
-	 * for this pmd), then we flush the SMP TLB and finally we write the
-	 * non-huge version of the pmd entry with pmd_populate.
-	 */
-	old_pmd = pmdp_invalidate(vma, haddr, pmd);
-
-	pmd_migration = is_pmd_migration_entry(old_pmd);
+	pmd_migration = is_pmd_migration_entry(*pmd);
 	if (unlikely(pmd_migration)) {
 		swp_entry_t entry;
 
+		old_pmd = *pmd;
 		entry = pmd_to_swp_entry(old_pmd);
 		page = pfn_swap_entry_to_page(entry);
 		write = is_writable_migration_entry(entry);
@@ -2466,6 +2445,30 @@ static void __split_huge_pmd_locked(stru
 		soft_dirty = pmd_swp_soft_dirty(old_pmd);
 		uffd_wp = pmd_swp_uffd_wp(old_pmd);
 	} else {
+		/*
+		 * Up to this point the pmd is present and huge and userland has
+		 * the whole access to the hugepage during the split (which
+		 * happens in place). If we overwrite the pmd with the not-huge
+		 * version pointing to the pte here (which of course we could if
+		 * all CPUs were bug free), userland could trigger a small page
+		 * size TLB miss on the small sized TLB while the hugepage TLB
+		 * entry is still established in the huge TLB. Some CPU doesn't
+		 * like that. See
+		 * http://support.amd.com/TechDocs/41322_10h_Rev_Gd.pdf, Erratum
+		 * 383 on page 105. Intel should be safe but is also warns that
+		 * it's only safe if the permission and cache attributes of the
+		 * two entries loaded in the two TLB is identical (which should
+		 * be the case here). But it is generally safer to never allow
+		 * small and huge TLB entries for the same virtual address to be
+		 * loaded simultaneously. So instead of doing "pmd_populate();
+		 * flush_pmd_tlb_range();" we first mark the current pmd
+		 * notpresent (atomically because here the pmd_trans_huge must
+		 * remain set at all times on the pmd until the split is
+		 * complete for this pmd), then we flush the SMP TLB and finally
+		 * we write the non-huge version of the pmd entry with
+		 * pmd_populate.
+		 */
+		old_pmd = pmdp_invalidate(vma, haddr, pmd);
 		page = pmd_page(old_pmd);
 		folio = page_folio(page);
 		if (pmd_dirty(old_pmd)) {
--- a/mm/pgtable-generic.c~mm-fix-race-between-__split_huge_pmd_locked-and-gup-fast
+++ a/mm/pgtable-generic.c
@@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(st
 pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return old;
@@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_str
 pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 			 pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	return pmdp_invalidate(vma, address, pmdp);
 }
 #endif
_

Patches currently in -mm which might be from ryan.roberts@arm.com are



