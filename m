Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA875D397
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGUTM1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjGUTM1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:12:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E4E4C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:12:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42D7A61D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C8FC433CB;
        Fri, 21 Jul 2023 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966744;
        bh=6GGXTQ9muik6pDc4jpUit5pJjAdyxFU9aGvn4wKDsE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ngtlGf9e2msouO4V1kyWbHQu4CBmkLH2aINE3pRJqUc1KBIBAWk31xNyCCmIFx6t
         kO6ZLwhuikacMwy+KPpMhzIKME5oJiJulFk/R35Rmwlrkiua0m5ToJB6VcWTowKxz4
         CG3M1uj6IaOTJZ9hUvpJMlT1TdFK/PzBMXelbJOU=
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
Subject: [PATCH 5.15 453/532] mm/damon/ops-common: atomically test and clear young on ptes and pmds
Date:   Fri, 21 Jul 2023 18:05:57 +0200
Message-ID: <20230721160639.111033639@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/damon/vaddr.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -393,7 +393,7 @@ static struct page *damon_get_page(unsig
 	return page;
 }
 
-static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
+static void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma,
 			     unsigned long addr)
 {
 	bool referenced = false;
@@ -402,13 +402,11 @@ static void damon_ptep_mkold(pte_t *pte,
 	if (!page)
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
 
@@ -419,7 +417,7 @@ static void damon_ptep_mkold(pte_t *pte,
 	put_page(page);
 }
 
-static void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm,
+static void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma,
 			     unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -429,13 +427,11 @@ static void damon_pmdp_mkold(pmd_t *pmd,
 	if (!page)
 		return;
 
-	if (pmd_young(*pmd)) {
+	if (pmdp_test_and_clear_young(vma, addr, pmd))
 		referenced = true;
-		*pmd = pmd_mkold(*pmd);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr,
+	if (mmu_notifier_clear_young(vma->vm_mm, addr,
 				addr + ((1UL) << HPAGE_PMD_SHIFT)))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
@@ -462,7 +458,7 @@ static int damon_mkold_pmd_entry(pmd_t *
 		}
 
 		if (pmd_huge(*pmd)) {
-			damon_pmdp_mkold(pmd, walk->mm, addr);
+			damon_pmdp_mkold(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			return 0;
 		}
@@ -474,7 +470,7 @@ static int damon_mkold_pmd_entry(pmd_t *
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte_present(*pte))
 		goto out;
-	damon_ptep_mkold(pte, walk->mm, addr);
+	damon_ptep_mkold(pte, walk->vma, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;


