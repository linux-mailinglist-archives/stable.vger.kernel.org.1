Return-Path: <stable+bounces-50401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA729064AB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92CE3B22D94
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31901384BE;
	Thu, 13 Jun 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oSEaIi3N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457312CD9D
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718262809; cv=none; b=Se0XZEMYQEnHGhfFAFXABXQOxwrZxgY0hEMdL+QveIL9bxbJv7X7/TZP5ZIZVsvoHibZ5ublYBP6p0ERfsHNHKGVQdlHOn4l8sbM/FGE0+4rM/WCVpAZYm8HCqyQOKl98XaqcKkDSJzoYAtySQPFgtDvnAuxeuqgOMSBABNIQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718262809; c=relaxed/simple;
	bh=ailvt1VA9ocJZ5vEDrzQ4gbskGTUmxJxw/o9LiphFZ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PnzZukW1BE2Go9hyhKNPxDvNb7Tg6e51uRuiMEn0k5JSZsGg6rqum8SGYA96F/cEqB7+Nw3Y0R9xjEFJ1rE1cfq9OwcamGQOC4fKyd5okMipZTM7CJ2ZHZZh3NXjSYi4dxo3j26t8uzN7a1Vx3eF1GECSyweWN7TCiO6W0sZVEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oSEaIi3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE4AC2BBFC;
	Thu, 13 Jun 2024 07:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718262809;
	bh=ailvt1VA9ocJZ5vEDrzQ4gbskGTUmxJxw/o9LiphFZ8=;
	h=Subject:To:Cc:From:Date:From;
	b=oSEaIi3Nz25UddChBl8mNt/B/E3DiK8M50b1iTRuXTrCijz5qwHKBseCavCqdwD9Y
	 KcQQhnZh4GgU8u/3dzszm9/rKBa0S0CnUI/r+gjgA22HXpK27ERUMl5IcKZzc6P2iq
	 sgjdYu20rXNokqRHnjQJz11pwVDLh6jWllt5+vIA=
Subject: FAILED: patch "[PATCH] mm: fix race between __split_huge_pmd_locked() and GUP-fast" failed to apply to 4.19-stable tree
To: ryan.roberts@arm.com,akpm@linux-foundation.org,andreas@gaisler.com,aneesh.kumar@kernel.org,anshuman.khandual@arm.com,borntraeger@linux.ibm.com,bp@alien8.de,catalin.marinas@arm.com,christophe.leroy@csgroup.eu,corbet@lwn.net,dave.hansen@linux.intel.com,davem@davemloft.net,david@redhat.com,luto@kernel.org,mark.rutland@arm.com,mingo@redhat.com,naveen.n.rao@linux.ibm.com,npiggin@gmail.com,peterz@infradead.org,stable@vger.kernel.org,svens@linux.ibm.com,tglx@linutronix.de,will@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:13:20 +0200
Message-ID: <2024061320-handcart-crook-0519@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 3a5a8d343e1cf96eb9971b17cbd4b832ab19b8e7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061320-handcart-crook-0519@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

3a5a8d343e1c ("mm: fix race between __split_huge_pmd_locked() and GUP-fast")
4f83145721f3 ("mm: avoid unnecessary flush on change_huge_pmd()")
c9fe66560bf2 ("mm/mprotect: do not flush when not required architecturally")
4a18419f71cd ("mm/mprotect: use mmu_gather")
e346e6688c4a ("mm: thp: skip make PMD PROT_NONE if THP migration is not supported")
f0953a1bbaca ("mm: fix typos in comments")
e2db1a9aa381 ("kasan, mm: optimize kmalloc poisoning")
928501344fc6 ("kasan, mm: don't save alloc stacks twice")
2b8305260fb3 ("kfence, kasan: make KFENCE compatible with KASAN")
0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
41139aa4c3a3 ("mm/filemap: add mapping_seek_hole_data")
a1ba9da8f0f9 ("mm/hugetlb.c: fix unnecessary address expansion of pmd sharing")
611806b4bf8d ("kasan: fix bug detection via ksize for HW_TAGS mode")
027b37b552f3 ("kasan: move _RET_IP_ to inline wrappers")
573a48092313 ("kasan: add match-all tag tests")
f00748bfa024 ("kasan: prefix global functions with kasan_")
dbf53f7597be ("mm/mprotect.c: optimize error detection in do_mprotect_pkey()")
96667f8a4382 ("mm: Close race in generic_access_phys")
97593cad003c ("kasan: sanitize objects when metadata doesn't fit")
1ef3133bd3b8 ("kasan: simplify assign_tag and set_tag calls")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a5a8d343e1cf96eb9971b17cbd4b832ab19b8e7 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Wed, 1 May 2024 15:33:10 +0100
Subject: [PATCH] mm: fix race between __split_huge_pmd_locked() and GUP-fast

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

diff --git a/Documentation/mm/arch_pgtable_helpers.rst b/Documentation/mm/arch_pgtable_helpers.rst
index 2466d3363af7..ad50ca6f495e 100644
--- a/Documentation/mm/arch_pgtable_helpers.rst
+++ b/Documentation/mm/arch_pgtable_helpers.rst
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
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 83823db3488b..2975ea0841ba 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -170,6 +170,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 {
 	unsigned long old_pmd;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	old_pmd = pmd_hugepage_update(vma->vm_mm, address, pmdp, _PAGE_PRESENT, _PAGE_INVALID);
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return __pmd(old_pmd);
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2cb2a2e7b34b..558902edbfec 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1769,8 +1769,10 @@ static inline pmd_t pmdp_huge_clear_flush(struct vm_area_struct *vma,
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
index 19642f7ffb52..8648a50afe88 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -249,6 +249,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t old, entry;
 
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	entry = __pmd(pmd_val(*pmdp) & ~_PAGE_VALID);
 	old = pmdp_establish(vma, address, pmdp, entry);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 94767c82fc0d..93e54ba91fbf 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -631,6 +631,8 @@ int pmdp_clear_flush_young(struct vm_area_struct *vma,
 pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 			 pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
+
 	/*
 	 * No flush is necessary. Once an invalid PTE is established, the PTE's
 	 * access and dirty bits cannot be updated.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 08e4f3343bcd..ccdcff73284a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2430,32 +2430,11 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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
@@ -2466,6 +2445,30 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
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
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 4fcd959dcc4d..a78a4adf711a 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 		     pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	pmd_t old = pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp));
 	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return old;
@@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long address,
 			 pmd_t *pmdp)
 {
+	VM_WARN_ON_ONCE(!pmd_present(*pmdp));
 	return pmdp_invalidate(vma, address, pmdp);
 }
 #endif


