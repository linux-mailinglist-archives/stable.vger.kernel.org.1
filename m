Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1914720A99
	for <lists+stable@lfdr.de>; Fri,  2 Jun 2023 22:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbjFBUzO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 2 Jun 2023 16:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbjFBUzM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Jun 2023 16:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE452E43;
        Fri,  2 Jun 2023 13:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4512261770;
        Fri,  2 Jun 2023 20:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFBDC433D2;
        Fri,  2 Jun 2023 20:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685739309;
        bh=Nzq/BuOYIQNUUb6G2pp3sjalDbiX/ZSQYUQpzzkpMQw=;
        h=Date:To:From:Subject:From;
        b=BxA7A7ZOdEOHS3OUGvY8tlfd/niNIEZXEd0tU8fH0RC6LL+xrSfsrLvjjGSsMsSnO
         JMJxAj6MrlqnG97ikPs8DDhw2Rl2DKG4sFRG/0gFkP3P1pWGY7MhHkb7ncdduE3AG/
         dBkMKLnd2MHZj0UzglTEHp3BWVV+T13zLRptpnt4=
Date:   Fri, 02 Jun 2023 13:55:08 -0700
To:     mm-commits@vger.kernel.org, ziy@nvidia.com, yuzhao@google.com,
        willy@infradead.org, urezki@gmail.com, stable@vger.kernel.org,
        sj@kernel.org, rppt@kernel.org, lstoakes@gmail.com,
        kirill.shutemov@linux.intel.com, hch@lst.de, hch@infradead.org,
        ryan.roberts@arm.com, akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-damon-ops-common-atomically-test-and-clear-young-on-ptes-and-pmds.patch added to mm-unstable branch
Message-Id: <20230602205509.9DFBDC433D2@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: mm/damon/ops-common: atomically test and clear young on ptes and pmds
has been added to the -mm mm-unstable branch.  Its filename is
     mm-damon-ops-common-atomically-test-and-clear-young-on-ptes-and-pmds.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-damon-ops-common-atomically-test-and-clear-young-on-ptes-and-pmds.patch

This patch will later appear in the mm-unstable branch at
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
From: Ryan Roberts <ryan.roberts@arm.com>
Subject: mm/damon/ops-common: atomically test and clear young on ptes and pmds
Date: Fri, 2 Jun 2023 10:29:47 +0100

It is racy to non-atomically read a pte, then clear the young bit, then
write it back as this could discard dirty information.  Further, it is bad
practice to directly set a pte entry within a table.  Instead clearing
young must go through the arch-provided helper,
ptep_test_and_clear_young() to ensure it is modified atomically and to
give the arch code visibility and allow it to check (and potentially
modify) the operation.

Link: https://lkml.kernel.org/r/20230602092949.545577-3-ryan.roberts@arm.com
Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces").
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/ops-common.c |   16 ++++++----------
 mm/damon/ops-common.h |    4 ++--
 mm/damon/paddr.c      |    4 ++--
 mm/damon/vaddr.c      |    4 ++--
 4 files changed, 12 insertions(+), 16 deletions(-)

--- a/mm/damon/ops-common.c~mm-damon-ops-common-atomically-test-and-clear-young-on-ptes-and-pmds
+++ a/mm/damon/ops-common.c
@@ -37,7 +37,7 @@ struct folio *damon_get_folio(unsigned l
 	return folio;
 }
 
-void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
+void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
 	struct folio *folio = damon_get_folio(pte_pfn(*pte));
@@ -45,13 +45,11 @@ void damon_ptep_mkold(pte_t *pte, struct
 	if (!folio)
 		return;
 
-	if (pte_young(*pte)) {
+	if (ptep_test_and_clear_young(vma, addr, pte))
 		referenced = true;
-		*pte = pte_mkold(*pte);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
+	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
@@ -62,7 +60,7 @@ void damon_ptep_mkold(pte_t *pte, struct
 	folio_put(folio);
 }
 
-void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
+void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	bool referenced = false;
@@ -71,13 +69,11 @@ void damon_pmdp_mkold(pmd_t *pmd, struct
 	if (!folio)
 		return;
 
-	if (pmd_young(*pmd)) {
+	if (pmdp_test_and_clear_young(vma, addr, pmd))
 		referenced = true;
-		*pmd = pmd_mkold(*pmd);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr, addr + HPAGE_PMD_SIZE))
+	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
--- a/mm/damon/ops-common.h~mm-damon-ops-common-atomically-test-and-clear-young-on-ptes-and-pmds
+++ a/mm/damon/ops-common.h
@@ -9,8 +9,8 @@
 
 struct folio *damon_get_folio(unsigned long pfn);
 
-void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
-void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
+void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
+void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
 
 int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
--- a/mm/damon/paddr.c~mm-damon-ops-common-atomically-test-and-clear-young-on-ptes-and-pmds
+++ a/mm/damon/paddr.c
@@ -24,9 +24,9 @@ static bool __damon_pa_mkold(struct foli
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte)
-			damon_ptep_mkold(pvmw.pte, vma->vm_mm, addr);
+			damon_ptep_mkold(pvmw.pte, vma, addr);
 		else
-			damon_pmdp_mkold(pvmw.pmd, vma->vm_mm, addr);
+			damon_pmdp_mkold(pvmw.pmd, vma, addr);
 	}
 	return true;
 }
--- a/mm/damon/vaddr.c~mm-damon-ops-common-atomically-test-and-clear-young-on-ptes-and-pmds
+++ a/mm/damon/vaddr.c
@@ -311,7 +311,7 @@ static int damon_mkold_pmd_entry(pmd_t *
 		}
 
 		if (pmd_trans_huge(*pmd)) {
-			damon_pmdp_mkold(pmd, walk->mm, addr);
+			damon_pmdp_mkold(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			return 0;
 		}
@@ -323,7 +323,7 @@ static int damon_mkold_pmd_entry(pmd_t *
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte_present(*pte))
 		goto out;
-	damon_ptep_mkold(pte, walk->mm, addr);
+	damon_ptep_mkold(pte, walk->vma, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
_

Patches currently in -mm which might be from ryan.roberts@arm.com are

mm-vmalloc-must-set-pte-via-arch-code.patch
mm-damon-ops-common-atomically-test-and-clear-young-on-ptes-and-pmds.patch
mm-damon-ops-common-refactor-to-use-ptepmdp_clear_young_notify.patch
mm-fix-failure-to-unmap-pte-on-highmem-systems.patch

