Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237CC754DFE
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjGPJMT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGPJMT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0232F102
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71D1B60C55
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E83C433C7;
        Sun, 16 Jul 2023 09:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689498736;
        bh=filOtxVIF5wjibdkTJmYf6x0bzVRlVvmoaygIOgeN38=;
        h=Subject:To:Cc:From:Date:From;
        b=DCvYt8FrWmGdlMPTEObpvL1ejVj23As93fIl2Uzy+U51nJCAtUVcov+KQp1YOxcCZ
         TeGty03s3H8f9olt6w8H7ha9+cq7tzFRr9TPbM7JSPSMR5DJq6ZNNHNtD1MQD8hKjj
         d1L/1Nw1A/EEmUmOnca6Zevav7r7xBQue7GCXZPI=
Subject: FAILED: patch "[PATCH] mm/damon/ops-common: atomically test and clear young on ptes" failed to apply to 5.15-stable tree
To:     ryan.roberts@arm.com, akpm@linux-foundation.org, hch@lst.de,
        kirill.shutemov@linux.intel.com, lstoakes@gmail.com,
        rppt@kernel.org, sj@kernel.org, stable@vger.kernel.org,
        urezki@gmail.com, willy@infradead.org, yuzhao@google.com,
        ziy@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 16 Jul 2023 11:12:14 +0200
Message-ID: <2023071613-reminder-relapse-b922@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c11d34fa139e4b0fb4249a30f37b178353533fa1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023071613-reminder-relapse-b922@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

c11d34fa139e ("mm/damon/ops-common: atomically test and clear young on ptes and pmds")
72c33ef4c02e ("mm/damon: replace pmd_huge() with pmd_trans_huge() for THP")
c8b9aff41930 ("mm/damon: validate if the pmd entry is present before accessing")
02e34fff195d ("mm: damon: use HPAGE_PMD_SIZE")
198f0f4c58b9 ("mm/damon/vaddr,paddr: support pageout prioritization")
57223ac29584 ("mm/damon/paddr: support the pageout scheme")
a28397beb55b ("mm/damon: implement primitives for physical address space monitoring")
46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions")
6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c11d34fa139e4b0fb4249a30f37b178353533fa1 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Fri, 2 Jun 2023 10:29:47 +0100
Subject: [PATCH] mm/damon/ops-common: atomically test and clear young on ptes
 and pmds

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
Cc: Christoph Hellwig <hch@lst.de>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index cc63cf953636..acc264b97903 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -37,7 +37,7 @@ struct folio *damon_get_folio(unsigned long pfn)
 	return folio;
 }
 
-void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
+void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
 	struct folio *folio = damon_get_folio(pte_pfn(*pte));
@@ -45,13 +45,11 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
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
 
@@ -62,7 +60,7 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
 	folio_put(folio);
 }
 
-void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
+void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	bool referenced = false;
@@ -71,13 +69,11 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
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
 
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 14f4bc69f29b..18d837d11bce 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -9,8 +9,8 @@
 
 struct folio *damon_get_folio(unsigned long pfn);
 
-void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
-void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
+void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
+void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
 
 int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 467b99166b43..5b3a3463d078 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -24,9 +24,9 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
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
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1fec16d7263e..37994fb6120c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -311,7 +311,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		}
 
 		if (pmd_trans_huge(*pmd)) {
-			damon_pmdp_mkold(pmd, walk->mm, addr);
+			damon_pmdp_mkold(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			return 0;
 		}
@@ -323,7 +323,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte_present(*pte))
 		goto out;
-	damon_ptep_mkold(pte, walk->mm, addr);
+	damon_ptep_mkold(pte, walk->vma, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;

