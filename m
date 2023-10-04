Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A24D7B770E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 06:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbjJDESz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 00:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjJDESx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 00:18:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D908BAC;
        Tue,  3 Oct 2023 21:18:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B66C433C8;
        Wed,  4 Oct 2023 04:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696393129;
        bh=HU/DLIrOBlN27rLsRxFRl07rsSCNHWyvNMs4M/m/hc4=;
        h=Date:To:From:Subject:From;
        b=wqi3eqoauhCYmc+XJl7yUO1n4WiHLRHvs0rPwX03FWYgmigKH/4DS3TfZO1PImQxb
         FYHcxsKPiF4SuPnu0jZKiJWuCrmxp24FA/i64S0CkJrZyuStsHN6Xg1rFKaJj764+a
         6MFzaN3SmibCVgzBxyAuZT3zXbqOAMRdtbHeXCJY=
Date:   Tue, 03 Oct 2023 21:18:48 -0700
To:     mm-commits@vger.kernel.org, willy@infradead.org,
        stable@vger.kernel.org, muchun.song@linux.dev,
        mike.kravetz@oracle.com, riel@surriel.com,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: + hugetlbfs-close-race-between-madv_dontneed-and-page-fault.patch added to mm-hotfixes-unstable branch
Message-Id: <20231004041849.70B66C433C8@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch titled
     Subject: hugetlbfs: close race between MADV_DONTNEED and page fault
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     hugetlbfs-close-race-between-madv_dontneed-and-page-fault.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/hugetlbfs-close-race-between-madv_dontneed-and-page-fault.patch

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
From: Rik van Riel <riel@surriel.com>
Subject: hugetlbfs: close race between MADV_DONTNEED and page fault
Date: Tue, 3 Oct 2023 23:25:04 -0400

Malloc libraries, like jemalloc and tcalloc, take decisions on when to
call madvise independently from the code in the main application.

This sometimes results in the application page faulting on an address,
right after the malloc library has shot down the backing memory with
MADV_DONTNEED.

Usually this is harmless, because we always have some 4kB pages sitting
around to satisfy a page fault.  However, with hugetlbfs systems often
allocate only the exact number of huge pages that the application wants.

Due to TLB batching, hugetlbfs MADV_DONTNEED will free pages outside of
any lock taken on the page fault path, which can open up the following
race condition:

       CPU 1                            CPU 2

       MADV_DONTNEED
       unmap page
       shoot down TLB entry
                                       page fault
                                       fail to allocate a huge page
                                       killed with SIGBUS
       free page

Fix that race by pulling the locking from __unmap_hugepage_final_range
into helper functions called from zap_page_range_single.  This ensures
page faults stay locked out of the MADV_DONTNEED VMA until the huge pages
have actually been freed.

Link: https://lkml.kernel.org/r/20231004032814.3108383-3-riel@surriel.com
Fixes: 04ada095dcfc ("hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing")
Signed-off-by: Rik van Riel <riel@surriel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/hugetlb.h |   35 +++++++++++++++++++++++++++++++++--
 mm/hugetlb.c            |   28 ++++++++++++++++------------
 mm/memory.c             |   13 ++++++++-----
 3 files changed, 57 insertions(+), 19 deletions(-)

--- a/include/linux/hugetlb.h~hugetlbfs-close-race-between-madv_dontneed-and-page-fault
+++ a/include/linux/hugetlb.h
@@ -139,7 +139,7 @@ struct page *hugetlb_follow_page_mask(st
 void unmap_hugepage_range(struct vm_area_struct *,
 			  unsigned long, unsigned long, struct page *,
 			  zap_flags_t);
-void __unmap_hugepage_range_final(struct mmu_gather *tlb,
+void __unmap_hugepage_range(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
 			  struct page *ref_page, zap_flags_t zap_flags);
@@ -246,6 +246,25 @@ int huge_pmd_unshare(struct mm_struct *m
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
 				unsigned long *start, unsigned long *end);
 
+extern void __hugetlb_zap_begin(struct vm_area_struct *vma,
+				unsigned long *begin, unsigned long *end);
+extern void __hugetlb_zap_end(struct vm_area_struct *vma,
+			      struct zap_details *details);
+
+static inline void hugetlb_zap_begin(struct vm_area_struct *vma,
+				     unsigned long *start, unsigned long *end)
+{
+	if (is_vm_hugetlb_page(vma))
+		__hugetlb_zap_begin(vma, start, end);
+}
+
+static inline void hugetlb_zap_end(struct vm_area_struct *vma,
+				   struct zap_details *details)
+{
+	if (is_vm_hugetlb_page(vma))
+		__hugetlb_zap_end(vma, details);
+}
+
 void hugetlb_vma_lock_read(struct vm_area_struct *vma);
 void hugetlb_vma_unlock_read(struct vm_area_struct *vma);
 void hugetlb_vma_lock_write(struct vm_area_struct *vma);
@@ -298,6 +317,18 @@ static inline void adjust_range_if_pmd_s
 {
 }
 
+static inline void hugetlb_zap_begin(
+				struct vm_area_struct *vma,
+				unsigned long *start, unsigned long *end)
+{
+}
+
+static inline void hugetlb_zap_end(
+				struct vm_area_struct *vma,
+				struct zap_details *details)
+{
+}
+
 static inline struct page *hugetlb_follow_page_mask(
     struct vm_area_struct *vma, unsigned long address, unsigned int flags,
     unsigned int *page_mask)
@@ -443,7 +474,7 @@ static inline long hugetlb_change_protec
 	return 0;
 }
 
-static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
+static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, struct page *ref_page,
 			zap_flags_t zap_flags)
--- a/mm/hugetlb.c~hugetlbfs-close-race-between-madv_dontneed-and-page-fault
+++ a/mm/hugetlb.c
@@ -5348,9 +5348,9 @@ int move_hugetlb_page_tables(struct vm_a
 	return len + old_addr - old_end;
 }
 
-static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end,
-				   struct page *ref_page, zap_flags_t zap_flags)
+void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			    unsigned long start, unsigned long end,
+			    struct page *ref_page, zap_flags_t zap_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long address;
@@ -5479,16 +5479,19 @@ static void __unmap_hugepage_range(struc
 		tlb_flush_mmu_tlbonly(tlb);
 }
 
-void __unmap_hugepage_range_final(struct mmu_gather *tlb,
-			  struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, struct page *ref_page,
-			  zap_flags_t zap_flags)
+void __hugetlb_zap_begin(struct vm_area_struct *vma,
+			 unsigned long *start, unsigned long *end)
 {
+	adjust_range_if_pmd_sharing_possible(vma, start, end);
 	hugetlb_vma_lock_write(vma);
-	i_mmap_lock_write(vma->vm_file->f_mapping);
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+}
 
-	/* mmu notification performed in caller */
-	__unmap_hugepage_range(tlb, vma, start, end, ref_page, zap_flags);
+void __hugetlb_zap_end(struct vm_area_struct *vma,
+		       struct zap_details *details)
+{
+	zap_flags_t zap_flags = details ? details->zap_flags : 0;
 
 	if (zap_flags & ZAP_FLAG_UNMAP) {	/* final unmap */
 		/*
@@ -5501,11 +5504,12 @@ void __unmap_hugepage_range_final(struct
 		 * someone else.
 		 */
 		__hugetlb_vma_unlock_write_free(vma);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
 	} else {
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
 		hugetlb_vma_unlock_write(vma);
 	}
+
+	if (vma->vm_file)
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
 }
 
 void unmap_hugepage_range(struct vm_area_struct *vma, unsigned long start,
--- a/mm/memory.c~hugetlbfs-close-race-between-madv_dontneed-and-page-fault
+++ a/mm/memory.c
@@ -1692,7 +1692,7 @@ static void unmap_single_vma(struct mmu_
 			if (vma->vm_file) {
 				zap_flags_t zap_flags = details ?
 				    details->zap_flags : 0;
-				__unmap_hugepage_range_final(tlb, vma, start, end,
+				__unmap_hugepage_range(tlb, vma, start, end,
 							     NULL, zap_flags);
 			}
 		} else
@@ -1737,8 +1737,12 @@ void unmap_vmas(struct mmu_gather *tlb,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
 	do {
-		unmap_single_vma(tlb, vma, start_addr, end_addr, &details,
+		unsigned long start = start_addr;
+		unsigned long end = end_addr;
+		hugetlb_zap_begin(vma, &start, &end);
+		unmap_single_vma(tlb, vma, start, end, &details,
 				 mm_wr_locked);
+		hugetlb_zap_end(vma, &details);
 	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
@@ -1762,9 +1766,7 @@ void zap_page_range_single(struct vm_are
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
 				address, end);
-	if (is_vm_hugetlb_page(vma))
-		adjust_range_if_pmd_sharing_possible(vma, &range.start,
-						     &range.end);
+	hugetlb_zap_begin(vma, &range.start, &range.end);
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
@@ -1775,6 +1777,7 @@ void zap_page_range_single(struct vm_are
 	unmap_single_vma(&tlb, vma, address, end, details, false);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
+	hugetlb_zap_end(vma, details);
 }
 
 /**
_

Patches currently in -mm which might be from riel@surriel.com are

hugetlbfs-extend-hugetlb_vma_lock-to-private-vmas.patch
hugetlbfs-close-race-between-madv_dontneed-and-page-fault.patch

