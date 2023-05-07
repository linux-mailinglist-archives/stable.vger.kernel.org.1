Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F286F9891
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 15:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjEGNKc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 09:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGNKc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 09:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590F0524D
        for <stable@vger.kernel.org>; Sun,  7 May 2023 06:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3C87619CC
        for <stable@vger.kernel.org>; Sun,  7 May 2023 13:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1964C433D2;
        Sun,  7 May 2023 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683465029;
        bh=p0MhCpt2I+jGnGPMkEm5AiCWrglwilRA3gNz+T9a6Fk=;
        h=Subject:To:Cc:From:Date:From;
        b=fmz11nDJhUiSxYCz7UUzY4fjmNL2aJfzjugBLfvTzbS8gGgpgBHkU+nYOn7pVnNIW
         Z9PG+MfzxOCqpnbLyiejVodAraDINap4bqKMHgSNpKuwvojI5wDlgIVK6tWXfatYdW
         rhFbhM9s1V5CiqiAI63K83j+w8xjLXe/h6kRxtKU=
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix uffd-wp during fork()" failed to apply to 6.1-stable tree
To:     peterx@redhat.com, aarcange@redhat.com, akpm@linux-foundation.org,
        axelrasmussen@google.com, david@redhat.com,
        mike.kravetz@oracle.com, mpenttil@redhat.com, nadav.amit@gmail.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 15:10:18 +0200
Message-ID: <2023050718-verdict-stegosaur-3aaa@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5a2f8d22ace4c8ac8798fab836dca7350fa710b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050718-verdict-stegosaur-3aaa@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

5a2f8d22ace4 ("mm/hugetlb: fix uffd-wp during fork()")
d0ce0e47b323 ("mm/hugetlb: convert hugetlb fault paths to use alloc_hugetlb_folio()")
ea4c353df377 ("mm/hugetlb: convert hugetlb_install_page to folios")
0ffdc38eb564 ("mm/hugetlb: convert restore_reserve_on_error() to folios")
e37d3e838d90 ("mm/hugetlb: convert alloc_migrate_huge_page to folios")
ff7d853b0313 ("mm/hugetlb: increase use of folios in alloc_huge_page()")
3a740e8bb56e ("mm/hugetlb: convert alloc_surplus_huge_page() to folios")
a36f1e902474 ("mm/hugetlb: convert dequeue_hugetlb_page functions to folios")
5b4bd90f9ac7 ("rmap: add folio parameter to __page_set_anon_rmap()")
db4e5dbdcdd5 ("mm: use a folio in hugepage_add_anon_rmap() and hugepage_add_new_anon_rmap()")
4d510f3da4c2 ("mm: add folio_add_new_anon_rmap()")
c7c3dec1c9db ("mm: rmap: remove lock_page_memcg()")
19fc1a7e8b2b ("mm/hugetlb: change hugetlb allocation functions to return a folio")
7f325a8d2563 ("mm/hugetlb: convert free_gigantic_page() to folios")
2f6c57d696ab ("mm/hugetlb: convert add_hugetlb_page() to folios and add hugetlb_cma_folio()")
1a7cdab59b22 ("mm/hugetlb: convert dissolve_free_huge_page() to folios")
911565b82853 ("mm/hugetlb: convert destroy_compound_gigantic_page() to folios")
9fd330582b2f ("mm: add folio dtor and order setter functions")
4b51634cd16a ("mm,thp,rmap: subpages_mapcount COMPOUND_MAPPED if PMD-mapped")
be5ef2d9b006 ("mm,thp,rmap: subpages_mapcount of PTE-mapped subpages")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a2f8d22ace4c8ac8798fab836dca7350fa710b1 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Apr 2023 15:53:12 -0400
Subject: [PATCH] mm/hugetlb: fix uffd-wp during fork()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch series "mm/hugetlb: More fixes around uffd-wp vs fork() / RO pins",
v2.


This patch (of 6):

There're a bunch of things that were wrong:

  - Reading uffd-wp bit from a swap entry should use pte_swp_uffd_wp()
    rather than huge_pte_uffd_wp().

  - When copying over a pte, we should drop uffd-wp bit when
    !EVENT_FORK (aka, when !userfaultfd_wp(dst_vma)).

  - When doing early CoW for private hugetlb (e.g. when the parent page was
    pinned), uffd-wp bit should be properly carried over if necessary.

No bug reported probably because most people do not even care about these
corner cases, but they are still bugs and can be exposed by the recent unit
tests introduced, so fix all of them in one shot.

Link: https://lkml.kernel.org/r/20230417195317.898696-1-peterx@redhat.com
Link: https://lkml.kernel.org/r/20230417195317.898696-2-peterx@redhat.com
Fixes: bc70fbf269fd ("mm/hugetlb: handle uffd-wp during fork()")
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Mika Penttilä <mpenttil@redhat.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a08fb47fb200..d105b0b6a274 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4953,11 +4953,15 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
 
 static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
-		     struct folio *new_folio)
+		      struct folio *new_folio, pte_t old)
 {
+	pte_t newpte = make_huge_pte(vma, &new_folio->page, 1);
+
 	__folio_mark_uptodate(new_folio);
 	hugepage_add_new_anon_rmap(new_folio, vma, addr);
-	set_huge_pte_at(vma->vm_mm, addr, ptep, make_huge_pte(vma, &new_folio->page, 1));
+	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(old))
+		newpte = huge_pte_mkuffd_wp(newpte);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, newpte);
 	hugetlb_count_add(pages_per_huge_page(hstate_vma(vma)), vma->vm_mm);
 	folio_set_hugetlb_migratable(new_folio);
 }
@@ -5032,14 +5036,12 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			 */
 			;
 		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
-			bool uffd_wp = huge_pte_uffd_wp(entry);
-
-			if (!userfaultfd_wp(dst_vma) && uffd_wp)
+			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
 			swp_entry_t swp_entry = pte_to_swp_entry(entry);
-			bool uffd_wp = huge_pte_uffd_wp(entry);
+			bool uffd_wp = pte_swp_uffd_wp(entry);
 
 			if (!is_readable_migration_entry(swp_entry) && cow) {
 				/*
@@ -5050,10 +5052,10 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 							swp_offset(swp_entry));
 				entry = swp_entry_to_pte(swp_entry);
 				if (userfaultfd_wp(src_vma) && uffd_wp)
-					entry = huge_pte_mkuffd_wp(entry);
+					entry = pte_swp_mkuffd_wp(entry);
 				set_huge_pte_at(src, addr, src_pte, entry);
 			}
-			if (!userfaultfd_wp(dst_vma) && uffd_wp)
+			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 		} else if (unlikely(is_pte_marker(entry))) {
@@ -5118,7 +5120,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
-				hugetlb_install_folio(dst_vma, dst_pte, addr, new_folio);
+				hugetlb_install_folio(dst_vma, dst_pte, addr,
+						      new_folio, src_pte_old);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
@@ -5136,6 +5139,9 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_wrprotect(entry);
 			}
 
+			if (!userfaultfd_wp(dst_vma))
+				entry = huge_pte_clear_uffd_wp(entry);
+
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 			hugetlb_count_add(npages, dst);
 		}

