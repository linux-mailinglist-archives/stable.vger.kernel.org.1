Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76B07D979C
	for <lists+stable@lfdr.de>; Fri, 27 Oct 2023 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjJ0MRi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 27 Oct 2023 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjJ0MRe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Oct 2023 08:17:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC9110FF
        for <stable@vger.kernel.org>; Fri, 27 Oct 2023 05:17:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CCFC433C8;
        Fri, 27 Oct 2023 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698409044;
        bh=olj1PBp+neIBQ7hcYJodTkRF5jmBQGFBp3nYdKRZSUg=;
        h=Subject:To:Cc:From:Date:From;
        b=rSSeRDWot7nOixCQ6HpYYiHRVtKfTsyPYJ4JggQQ+NCbBlEFD9veD9xO2lF3TTW6f
         q8xWSierOncX0dEJCW60oOQdJPlM7C8+cHAeR/6/9AVPIVzGeEMczaEqP4WY9LKkNU
         gTmJWlapZ1peImfij9ADGvg0VKadseaX7ZhOhszo=
Subject: FAILED: patch "[PATCH] hugetlbfs: close race between MADV_DONTNEED and page fault" failed to apply to 6.5-stable tree
To:     riel@surriel.com, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev,
        stable@vger.kernel.org, willy@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:17:21 +0200
Message-ID: <2023102721-populate-culpable-52a4@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.5-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.5.y
git checkout FETCH_HEAD
git cherry-pick -x 2820b0f09be99f6406784b03a22dfc83e858449d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102721-populate-culpable-52a4@gregkh' --subject-prefix 'PATCH 6.5.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2820b0f09be99f6406784b03a22dfc83e858449d Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@surriel.com>
Date: Thu, 5 Oct 2023 23:59:08 -0400
Subject: [PATCH] hugetlbfs: close race between MADV_DONTNEED and page fault

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

Link: https://lkml.kernel.org/r/20231006040020.3677377-4-riel@surriel.com
Fixes: 04ada095dcfc ("hugetlb: don't delete vma_lock in hugetlb MADV_DONTNEED processing")
Signed-off-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 065ec022cbb0..47d25a5e1933 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -139,7 +139,7 @@ struct page *hugetlb_follow_page_mask(struct vm_area_struct *vma,
 void unmap_hugepage_range(struct vm_area_struct *,
 			  unsigned long, unsigned long, struct page *,
 			  zap_flags_t);
-void __unmap_hugepage_range_final(struct mmu_gather *tlb,
+void __unmap_hugepage_range(struct mmu_gather *tlb,
 			  struct vm_area_struct *vma,
 			  unsigned long start, unsigned long end,
 			  struct page *ref_page, zap_flags_t zap_flags);
@@ -246,6 +246,25 @@ int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -297,6 +316,18 @@ static inline void adjust_range_if_pmd_sharing_possible(
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
@@ -442,7 +473,7 @@ static inline long hugetlb_change_protection(
 	return 0;
 }
 
-static inline void __unmap_hugepage_range_final(struct mmu_gather *tlb,
+static inline void __unmap_hugepage_range(struct mmu_gather *tlb,
 			struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, struct page *ref_page,
 			zap_flags_t zap_flags)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d218ee2b6a99..1301ba7b2c9a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5306,9 +5306,9 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
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
@@ -5437,16 +5437,25 @@ static void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct
 		tlb_flush_mmu_tlbonly(tlb);
 }
 
-void __unmap_hugepage_range_final(struct mmu_gather *tlb,
-			  struct vm_area_struct *vma, unsigned long start,
-			  unsigned long end, struct page *ref_page,
-			  zap_flags_t zap_flags)
+void __hugetlb_zap_begin(struct vm_area_struct *vma,
+			 unsigned long *start, unsigned long *end)
 {
+	if (!vma->vm_file)	/* hugetlbfs_file_mmap error */
+		return;
+
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
+
+	if (!vma->vm_file)	/* hugetlbfs_file_mmap error */
+		return;
 
 	if (zap_flags & ZAP_FLAG_UNMAP) {	/* final unmap */
 		/*
@@ -5459,11 +5468,12 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
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
diff --git a/mm/memory.c b/mm/memory.c
index 6c264d2f969c..517221f01303 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1683,7 +1683,7 @@ static void unmap_single_vma(struct mmu_gather *tlb,
 			if (vma->vm_file) {
 				zap_flags_t zap_flags = details ?
 				    details->zap_flags : 0;
-				__unmap_hugepage_range_final(tlb, vma, start, end,
+				__unmap_hugepage_range(tlb, vma, start, end,
 							     NULL, zap_flags);
 			}
 		} else
@@ -1728,8 +1728,12 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
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
@@ -1753,9 +1757,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
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
@@ -1766,6 +1768,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	unmap_single_vma(&tlb, vma, address, end, details, false);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
+	hugetlb_zap_end(vma, details);
 }
 
 /**

