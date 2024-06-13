Return-Path: <stable+bounces-52027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10109072BC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D88D1F21868
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F306714375C;
	Thu, 13 Jun 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LXL+JP53"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A21428F5;
	Thu, 13 Jun 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283019; cv=none; b=p7K4K9Dz6EFoazmXyqM5zgEHwaADut48LYErqVZZGbSD9Kjh8xhjqqPEimmIEFrM9GChaQ9gTL7ALXLd46r40UxFY7fSaclwZ4r/c66E8eg7AxCi6twVZMrraPvvL6MoPbBJj9EZTHacixWoRwCLCcD/03IHCSooiPl92rKrD14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283019; c=relaxed/simple;
	bh=zIe+r8kaIbDb/1QC4pE9VJp1aAu2dqwqCYNbylc9674=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppiN9jbtZADLa/DWeaIGubBrYSjsETIkEtNTqLICz+oqyrXVP1QeibmAvOKEBqVR6GX8SqyR/NBfI6RD1mydovkG2wOR/AOZUO16RV4j5iKpYEBrzvirbvL6azZzLGu/gQDXWlp4y+FnsJ7btuDsiuW5kzrsJuR6iPZSwXIs8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LXL+JP53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A782C2BBFC;
	Thu, 13 Jun 2024 12:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718283019;
	bh=zIe+r8kaIbDb/1QC4pE9VJp1aAu2dqwqCYNbylc9674=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXL+JP53hRHq8fiZDrxShGNLdG02HayeJLurStuDE58tLtE91oQeonhDlkZ3LoBYE
	 sasVF0bbhgdq4iPeAI189OGeSk6M6tGK1nX2masVUkcOl9/iEQZtRPLO/ioGedSYpt
	 7MtqZy2XGTKUeAiiXQuWCLl8afNcacgj6HhQNDB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ingo Molnar <mingo@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 54/85] mm: fix race between __split_huge_pmd_locked() and GUP-fast
Date: Thu, 13 Jun 2024 13:35:52 +0200
Message-ID: <20240613113216.224277070@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
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

From: Ryan Roberts <ryan.roberts@arm.com>

commit 3a5a8d343e1cf96eb9971b17cbd4b832ab19b8e7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/mm/arch_pgtable_helpers.rst |    6 ++-
 arch/powerpc/mm/book3s64/pgtable.c        |    1 
 arch/s390/include/asm/pgtable.h           |    4 +-
 arch/sparc/mm/tlb.c                       |    1 
 arch/x86/mm/pgtable.c                     |    2 +
 mm/huge_memory.c                          |   49 +++++++++++++++---------------
 mm/pgtable-generic.c                      |    2 +
 7 files changed, 39 insertions(+), 26 deletions(-)

--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
@@ -136,7 +136,8 @@ PMD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pmd_swp_clear_soft_dirty  | Clears a soft dirty swapped PMD                  |
 +---------------------------+--------------------------------------------------+
-| pmd_mkinvalid             | Invalidates a mapped PMD [1]                     |
+| pmd_mkinvalid             | Invalidates a present PMD; do not call for       |
+|                           | non-present PMD [1]                              |
 +---------------------------+--------------------------------------------------+
 | pmd_set_huge              | Creates a PMD huge mapping                       |
 +---------------------------+--------------------------------------------------+
@@ -192,7 +193,8 @@ PUD Page Table Helpers
 +---------------------------+--------------------------------------------------+
 | pud_mkdevmap              | Creates a ZONE_DEVICE mapped PUD                 |
 +---------------------------+--------------------------------------------------+
-| pud_mkinvalid             | Invalidates a mapped PUD [1]                     |
+| pud_mkinvalid             | Invalidates a present PUD; do not call for       |
+|                           | non-present PUD [1]                              |
 +---------------------------+--------------------------------------------------+
 | pud_set_huge              | Creates a PUD huge mapping                       |
 +---------------------------+--------------------------------------------------+
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -124,6 +124,7 @@ pmd_t pmdp_invalidate(struct vm_area_str
 {
 	unsigned long old_pmd;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return __pmd(old_pmd);
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1686,8 +1686,10 @@ static inline pmd_t pmdp_huge_clear_flus
 static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmdp)
 {
-	pmd_t pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
+	pmd_t pmd;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
+	pmd = __pmd(pmd_val(*pmdp) | _SEGMENT_ENTRY_INVALID);
 	return pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
 }
 
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -245,6 +245,7 @@ pmd_t pmdp_invalidate(struct vm_area_str
 {
 	pmd_t old, entry;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
 	old = pmdp_establish(vma, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -615,6 +615,8 @@ int pmdp_clear_flush_young(struct vm_are
 pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 			 pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
+
 	/*
 	 * No flush is necessary. Once an invalid PTE is established, the PTE's
 	 * access and dirty bits cannot be updated.
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2108,32 +2108,11 @@ static void __split_huge_pmd_locked(stru
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
@@ -2144,6 +2123,30 @@ static void __split_huge_pmd_locked(stru
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
 		if (pmd_dirty(old_pmd)) {
 			dirty = true;
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -195,6 +195,7 @@ pgtable_t pgtable_trans_huge_withdraw(st
 pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return old;
@@ -205,6 +206,7 @@ pmd_t pmdp_invalidate(struct vm_area_str
 pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 			 pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	return pmdp_invalidate(vma, address, pmdp);
 }
 #endif



