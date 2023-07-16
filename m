Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2081E75542F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjGPU1f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGPU1e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19231126
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 995D060EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D29AC433C7;
        Sun, 16 Jul 2023 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539252;
        bh=rbCMWdjoCfI/se8YRBAHHl0r5B/qL29jT+Br5uRZQQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xlU5lZB+a2CE0sJobI74x1QJeHy7W51OcNSPGM2FSfYwVgjg2meX2+NGgA87kkReP
         0kOKk3Npom8p67afg9al1Eeq21g41QNXalq66s9LQwrdrmPVYH8viWvPo17xuv/qzX
         DmV9i1TqUQlu//hpvaYgv+cw6eWaXFoGVPrJjYNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ryan Roberts <ryan.roberts@arm.com>,
        Zi Yan <ziy@nvidia.com>, SeongJae Park <sj@kernel.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 741/800] mm/damon/ops-common: atomically test and clear young on ptes and pmds
Date:   Sun, 16 Jul 2023 21:49:54 +0200
Message-ID: <20230716195006.332796651@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ryan Roberts <ryan.roberts@arm.com>

commit c11d34fa139e4b0fb4249a30f37b178353533fa1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/ops-common.c |   16 ++++++----------
 mm/damon/ops-common.h |    4 ++--
 mm/damon/paddr.c      |    4 ++--
 mm/damon/vaddr.c      |    4 ++--
 4 files changed, 12 insertions(+), 16 deletions(-)

--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
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
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
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
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
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


