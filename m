Return-Path: <stable+bounces-116654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2E9A391DF
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 05:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62F53B43C2
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 03:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4261CDFD5;
	Tue, 18 Feb 2025 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="nQD5FqMj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498FF1CDA2D;
	Tue, 18 Feb 2025 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851003; cv=none; b=YApnE/MDG7Y/THh//vNaQ++2/33dMSyLf9rw5VMDy9zxSwt92nEtiAWHGRkVx9KTe1DUNfz9G9G50LexDoo9Ywre0iYdZnrECocUs/q+UkGrE62bD4WlVFlNRYRPEMJdRwiKmbrpzUBB24ugNRAwePVR3gbToUIHgcwExsb3XTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851003; c=relaxed/simple;
	bh=bhkogdJzEzDvTrTOklcd+YkvUy29eMVWMpI0jQzZgpA=;
	h=Date:To:From:Subject:Message-Id; b=RNuUF8HV2KsgSJK9CVs/nLjE0emUzp+LwVIEAZ7VA74P4gyhx3Xm2h/F+ckwgYOs4A+gq2U+vgvyt/tpLWljR4FKKvbPw0gVHKGmbw2AkwmSGzADSGapT+5HG1jKejVE1NVFfRu2Aq2S8Qb0sIp7KMbsuX7uutrglWXaqDuik6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=nQD5FqMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38A8C4CEE6;
	Tue, 18 Feb 2025 03:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739851002;
	bh=bhkogdJzEzDvTrTOklcd+YkvUy29eMVWMpI0jQzZgpA=;
	h=Date:To:From:Subject:From;
	b=nQD5FqMjgtxLXL2cosa95w5/aNZRYvGK/yMDV9aD680Of0vs3CmQH4WARWIcbRM70
	 qET/Q4cXsHDYkog+y6zRNOF533abwvR4pieIwI+mRFxmrai/Lg/pnFypnmiMQQA2nr
	 kjo9Mdu8mIeK62D9mNMb40kZHHYgPlmPMRZRQ5sQ=
Date: Mon, 17 Feb 2025 19:56:42 -0800
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,ryan.roberts@arm.com,muchun.song@linux.dev,linux@armlinux.org.uk,hughd@google.com,ezra.buehler@husqvarnagroup.com,david@redhat.com,zhengqi.arch@bytedance.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + arm-pgtable-fix-null-pointer-dereference-issue.patch added to mm-hotfixes-unstable branch
Message-Id: <20250218035642.A38A8C4CEE6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: arm: pgtable: fix NULL pointer dereference issue
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     arm-pgtable-fix-null-pointer-dereference-issue.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/arm-pgtable-fix-null-pointer-dereference-issue.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: Qi Zheng <zhengqi.arch@bytedance.com>
Subject: arm: pgtable: fix NULL pointer dereference issue
Date: Mon, 17 Feb 2025 10:49:24 +0800

When update_mmu_cache_range() is called by update_mmu_cache(), the vmf
parameter is NULL, which will cause a NULL pointer dereference issue in
adjust_pte():

Unable to handle kernel NULL pointer dereference at virtual address 00000030 when read
Hardware name: Atmel AT91SAM9
PC is at update_mmu_cache_range+0x1e0/0x278
LR is at pte_offset_map_rw_nolock+0x18/0x2c
Call trace:
 update_mmu_cache_range from remove_migration_pte+0x29c/0x2ec
 remove_migration_pte from rmap_walk_file+0xcc/0x130
 rmap_walk_file from remove_migration_ptes+0x90/0xa4
 remove_migration_ptes from migrate_pages_batch+0x6d4/0x858
 migrate_pages_batch from migrate_pages+0x188/0x488
 migrate_pages from compact_zone+0x56c/0x954
 compact_zone from compact_node+0x90/0xf0
 compact_node from kcompactd+0x1d4/0x204
 kcompactd from kthread+0x120/0x12c
 kthread from ret_from_fork+0x14/0x38
Exception stack(0xc0d8bfb0 to 0xc0d8bff8)

To fix it, do not rely on whether 'ptl' is equal to decide whether to hold
the pte lock, but decide it by whether CONFIG_SPLIT_PTE_PTLOCKS is
enabled.  In addition, if two vmas map to the same PTE page, there is no
need to hold the pte lock again, otherwise a deadlock will occur.  Just
add the need_lock parameter to let adjust_pte() know this information.

Link: https://lkml.kernel.org/r/20250217024924.57996-1-zhengqi.arch@bytedance.com
Fixes: fc9c45b71f43 ("arm: adjust_pte() use pte_offset_map_rw_nolock()")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reported-by: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Closes: https://lore.kernel.org/lkml/CAM1KZSmZ2T_riHvay+7cKEFxoPgeVpHkVFTzVVEQ1BO0cLkHEQ@mail.gmail.com/
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickens <hughd@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Russel King <linux@armlinux.org.uk>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/mm/fault-armv.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/arch/arm/mm/fault-armv.c~arm-pgtable-fix-null-pointer-dereference-issue
+++ a/arch/arm/mm/fault-armv.c
@@ -62,7 +62,7 @@ static int do_adjust_pte(struct vm_area_
 }
 
 static int adjust_pte(struct vm_area_struct *vma, unsigned long address,
-		      unsigned long pfn, struct vm_fault *vmf)
+		      unsigned long pfn, bool need_lock)
 {
 	spinlock_t *ptl;
 	pgd_t *pgd;
@@ -99,12 +99,11 @@ again:
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
@@ -114,7 +113,7 @@ again:
 
 	ret = do_adjust_pte(vma, address, pfn, pte);
 
-	if (ptl != vmf->ptl)
+	if (need_lock)
 		spin_unlock(ptl);
 	pte_unmap(pte);
 
@@ -123,9 +122,10 @@ again:
 
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
@@ -142,6 +142,14 @@ make_coherent(struct address_space *mapp
 	flush_dcache_mmap_lock(mapping);
 	vma_interval_tree_foreach(mpnt, &mapping->i_mmap, pgoff, pgoff) {
 		/*
+		 * If we are using split PTE locks, then we need to take the pte
+		 * lock. Otherwise we are using shared mm->page_table_lock which
+		 * is already locked, thus cannot take it.
+		 */
+		bool need_lock = IS_ENABLED(CONFIG_SPLIT_PTE_PTLOCKS);
+		unsigned long mpnt_addr;
+
+		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 * Note that we intentionally mask out the VMA
 		 * that we are fixing up.
@@ -151,7 +159,12 @@ make_coherent(struct address_space *mapp
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
@@ -194,7 +207,7 @@ void update_mmu_cache_range(struct vm_fa
 		__flush_dcache_folio(mapping, folio);
 	if (mapping) {
 		if (cache_is_vivt())
-			make_coherent(mapping, vma, addr, ptep, pfn, vmf);
+			make_coherent(mapping, vma, addr, ptep, pfn);
 		else if (vma->vm_flags & VM_EXEC)
 			__flush_icache_all();
 	}
_

Patches currently in -mm which might be from zhengqi.arch@bytedance.com are

mm-pgtable-fix-incorrect-reclaim-of-non-empty-pte-pages.patch
arm-pgtable-fix-null-pointer-dereference-issue.patch


