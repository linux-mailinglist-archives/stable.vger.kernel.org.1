Return-Path: <stable+bounces-54986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C2F9145AE
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1711C285E02
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6640870;
	Mon, 24 Jun 2024 09:03:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B47FD
	for <stable@vger.kernel.org>; Mon, 24 Jun 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219839; cv=none; b=c2vAtHYyKr2swM6MVgREMVEPlYgo4r6FttOwoDb2MAp47H7nSOCUUEmDe3x722lMGzVD8U5DTJbvVSwEJYma5b/AuAK+ZIHrlSBBaFedEtGe7Mu3PHiVp16W0GFAgTWEtPU5CD1W9OozG2TZOJ+Ri02yKGG5dDwe7mfemjuCQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219839; c=relaxed/simple;
	bh=nyG4xPoey73vKHXobbSJFbRdFlJIGjTibh3SJVJdmK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PITCwIDvuhAlvKwHpEm0ZLTllbgRtJsVwAdRtlrCoWEYA3QDuq3JG4uhXITpst7g9l5uJw6xryq/CD1WYl0/OHUCuIfQa2pqiz6PF7c0zdPOxrKqu/Hq+GAzg8YzVMyLdv0+VoaGuuSzGVFCr7x6O2vmrdj4xWoJmGeeMBlfu10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2375FDA7;
	Mon, 24 Jun 2024 02:04:21 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80F743F6A8;
	Mon, 24 Jun 2024 02:03:53 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.15.y] mm: fix race between __split_huge_pmd_locked() and GUP-fast
Date: Mon, 24 Jun 2024 10:03:46 +0100
Message-ID: <20240624090346.477617-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024061316-brook-imaging-a202@gregkh>
References: <2024061316-brook-imaging-a202@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 3a5a8d343e1cf96eb9971b17cbd4b832ab19b8e7)
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 Documentation/vm/arch_pgtable_helpers.rst |  6 ++-
 arch/powerpc/mm/book3s64/pgtable.c        |  1 +
 arch/s390/include/asm/pgtable.h           |  4 +-
 arch/sparc/mm/tlb.c                       |  1 +
 mm/huge_memory.c                          | 49 ++++++++++++-----------
 mm/pgtable-generic.c                      |  5 ++-
 6 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/Documentation/vm/arch_pgtable_helpers.rst b/Documentation/vm/arch_pgtable_helpers.rst
index 552567d863b8..b8ae5d040b99 100644
--- a/Documentation/vm/arch_pgtable_helpers.rst
+++ b/Documentation/vm/arch_pgtable_helpers.rst
@@ -134,7 +134,8 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_swp_clear_soft_dirty  | Clears a soft dirty swapped PMD                  |
 +---------------------------+--------------------------------------------------+
-| pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
+| pmd_mkinvalid             | Invalidates a present PMD; do not call for       |
+|                           | non-present PMD [1]                              |
 +---------------------------+--------------------------------------------------+
 | pmd_set_huge              | Creates a PMD huge mapping                       |
 +---------------------------+--------------------------------------------------+
@@ -190,7 +191,8 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_mkdevmap              | Creates a ZONE_DEVICE mapped PUD                 |
 +---------------------------+--------------------------------------------------+
-| pud_mkinvalid             | Invalidates a mapped PUD [1]                     |
+| pud_mkinvalid             | Invalidates a present PUD; do not call for       |
+|                           | non-present PUD [1]                              |
 +---------------------------+--------------------------------------------------+
 | pud_set_huge              | Creates a PUD huge mapping                       |
 +---------------------------+--------------------------------------------------+
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index da15f28c7b13..3a22e7d970f3 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -115,6 +115,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 {
 	unsigned long old_pmd;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return __pmd(old_pmd);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index b61426c9ef17..b65ce0c90dd0 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1625,8 +1625,10 @@ static inline pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
 static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmdp)
 {
-	pmd_t pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
+	pmd_t pmd;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
+	pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
 	return pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
 }
 
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 9a725547578e..946f33c1b032 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -245,6 +245,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t old, entry;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
 	old = pmdp_establish(vma, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 98ff57c8eda6..4e9dbaded0a4 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2017,32 +2017,11 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -2050,6 +2029,30 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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
 		if (pmd_dirty(old_pmd))
 			SetPageDirty(page);
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4e640baf9794..efa5ab28f471 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -194,7 +194,10 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
-	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
+	pmd_t old;
+
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
+	old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return old;
 }
-- 
2.43.0


