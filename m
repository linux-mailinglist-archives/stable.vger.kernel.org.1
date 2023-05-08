Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC736FACEA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbjEHL3d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbjEHL3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B663E764
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:28:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B886562EBC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A32C433EF;
        Mon,  8 May 2023 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545316;
        bh=JpFETWvbuCTNt476SUVS0+90N9CRfeFecBJn04wOLhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WiyVqgQiAX7ldI0Oj2GSR+7Z6T1cF4BdOqZpMZ9vCJlYqAo6Mn8dU4hy9OI6O/M5P
         tTbWr/CbA/iP613qjPoX/wUVsq7EP/SnsMnO0gkWV/fgFAEyoscfnHRm+YjJY2vOyS
         Mnlld1IzB/wd7qm7it1jCJ+xzXOuAdIslK391U+E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mpenttil@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 677/694] mm/hugetlb: fix uffd-wp during fork()
Date:   Mon,  8 May 2023 11:48:32 +0200
Message-Id: <20230508094458.205673564@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Xu <peterx@redhat.com>

commit 5a2f8d22ace4c8ac8798fab836dca7350fa710b1 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/hugetlb.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4949,11 +4949,15 @@ static bool is_hugetlb_entry_hwpoisoned(
 
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
@@ -5028,14 +5032,12 @@ again:
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
@@ -5046,10 +5048,10 @@ again:
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
@@ -5109,7 +5111,8 @@ again:
 					/* huge_ptep of dst_pte won't change as in child */
 					goto again;
 				}
-				hugetlb_install_folio(dst_vma, dst_pte, addr, new_folio);
+				hugetlb_install_folio(dst_vma, dst_pte, addr,
+						      new_folio, src_pte_old);
 				spin_unlock(src_ptl);
 				spin_unlock(dst_ptl);
 				continue;
@@ -5127,6 +5130,9 @@ again:
 				entry = huge_pte_wrprotect(entry);
 			}
 
+			if (!userfaultfd_wp(dst_vma))
+				entry = huge_pte_clear_uffd_wp(entry);
+
 			set_huge_pte_at(dst, addr, dst_pte, entry);
 			hugetlb_count_add(npages, dst);
 		}


