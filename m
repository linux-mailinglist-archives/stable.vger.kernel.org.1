Return-Path: <stable+bounces-151456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3CACE4CC
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 21:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94844160A0F
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 19:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05B2046B3;
	Wed,  4 Jun 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="oFqqzIS+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0A86337;
	Wed,  4 Jun 2025 19:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065257; cv=none; b=PNenTRQoK9eZWZsTvAkVbblarLD/muIlSmhEdqS5fOMlLoX7tSGWWfEZ4lG4spRvdiGTggBAbZaFLBA+oqfuWUo6QMTd8vW7bR147rS+ZAe/j6rRew0BbNxsxlCzTlW026Uf4DLvLm0Mg/CI/Ez/m1+oHcUHDFpVhAawn5Wp2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065257; c=relaxed/simple;
	bh=nMgqY2jkFUb9NnbRKeB474icfBmRN1AyIJSk4BLPkJ0=;
	h=Date:To:From:Subject:Message-Id; b=bW0Cr37Ik3DIMUlzOSXF0MGpyKNYh9vgpi/ULY8ub7yYKlobCx1RZW4vDtoN2WVU4n0SoHGrLV2Zg2vDPPgzvuezT/WjUxPVeV7ic1jsG3F1tCgTSiM/K2gMpRukMshLIWHQZ8hVc2vdoS9IJQOkgKowwToJVTSLN1xNCjUVuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=oFqqzIS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58647C4CEE4;
	Wed,  4 Jun 2025 19:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749065255;
	bh=nMgqY2jkFUb9NnbRKeB474icfBmRN1AyIJSk4BLPkJ0=;
	h=Date:To:From:Subject:From;
	b=oFqqzIS+NYZNjXBRqhgg9cZRxJ1BimblPXwzXNQgySTpFXyQA047f2WLsp5LGTX5k
	 0leNGjh5vu6Wjrxif7QGQKeoQtLpsoKcPxITsU8t18cSkiNARE3ICuZ6+i6KpbbutR
	 OZ2zUceXM3OVZ+4HX4s/dIkOsY4VpapqJUJKwc8g=
Date: Wed, 04 Jun 2025 12:27:34 -0700
To: mm-commits@vger.kernel.org,surenb@google.com,stable@vger.kernel.org,peterx@redhat.com,lokeshgidra@google.com,david@redhat.com,aarcange@redhat.com,21cnbao@gmail.com,kasong@tencent.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-userfaultfd-fix-race-of-userfaultfd_move-and-swap-cache.patch added to mm-hotfixes-unstable branch
Message-Id: <20250604192735.58647C4CEE4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm: userfaultfd: fix race of userfaultfd_move and swap cache
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-userfaultfd-fix-race-of-userfaultfd_move-and-swap-cache.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-userfaultfd-fix-race-of-userfaultfd_move-and-swap-cache.patch

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
From: Kairui Song <kasong@tencent.com>
Subject: mm: userfaultfd: fix race of userfaultfd_move and swap cache
Date: Wed, 4 Jun 2025 23:10:38 +0800

On seeing a swap entry PTE, userfaultfd_move does a lockless swap cache
lookup, and tries to move the found folio to the faulting vma.  Currently,
it relies on checking the PTE value to ensure that the moved folio still
belongs to the src swap entry and that no new folio has been added to the
swap cache, which turns out to be unreliable.

While working and reviewing the swap table series with Barry, following
existing races are observed and reproduced [1]:

In the example below, move_pages_pte is moving src_pte to dst_pte, where
src_pte is a swap entry PTE holding swap entry S1, and S1 is not in the
swap cache:

CPU1                               CPU2
userfaultfd_move
  move_pages_pte()
    entry = pte_to_swp_entry(orig_src_pte);
    // Here it got entry = S1
    ... < interrupted> ...
                                   <swapin src_pte, alloc and use folio A>
                                   // folio A is a new allocated folio
                                   // and get installed into src_pte
                                   <frees swap entry S1>
                                   // src_pte now points to folio A, S1
                                   // has swap count == 0, it can be freed
                                   // by folio_swap_swap or swap
                                   // allocator's reclaim.
                                   <try to swap out another folio B>
                                   // folio B is a folio in another VMA.
                                   <put folio B to swap cache using S1 >
                                   // S1 is freed, folio B can use it
                                   // for swap out with no problem.
                                   ...
    folio = filemap_get_folio(S1)
    // Got folio B here !!!
    ... < interrupted again> ...
                                   <swapin folio B and free S1>
                                   // Now S1 is free to be used again.
                                   <swapout src_pte & folio A using S1>
                                   // Now src_pte is a swap entry PTE
                                   // holding S1 again.
    folio_trylock(folio)
    move_swap_pte
      double_pt_lock
      is_pte_pages_stable
      // Check passed because src_pte == S1
      folio_move_anon_rmap(...)
      // Moved invalid folio B here !!!

The race window is very short and requires multiple collisions of multiple
rare events, so it's very unlikely to happen, but with a deliberately
constructed reproducer and increased time window, it can be reproduced
easily.

This can be fixed by checking if the folio returned by filemap is the
valid swap cache folio after acquiring the folio lock.

Another similar race is possible: filemap_get_folio may return NULL, but
folio (A) could be swapped in and then swapped out again using the same
swap entry after the lookup.  In such a case, folio (A) may remain in the
swap cache, so it must be moved too:

CPU1                               CPU2
userfaultfd_move
  move_pages_pte()
    entry = pte_to_swp_entry(orig_src_pte);
    // Here it got entry = S1, and S1 is not in swap cache
    folio = filemap_get_folio(S1)
    // Got NULL
    ... < interrupted again> ...
                                   <swapin folio A and free S1>
                                   <swapout folio A re-using S1>
    move_swap_pte
      double_pt_lock
      is_pte_pages_stable
      // Check passed because src_pte == S1
      folio_move_anon_rmap(...)
      // folio A is ignored !!!

Fix this by checking the swap cache again after acquiring the src_pte
lock.  And to avoid the filemap overhead, we check swap_map directly [2].

The SWP_SYNCHRONOUS_IO path does make the problem more complex, but so far
we don't need to worry about that, since folios can only be exposed to the
swap cache in the swap out path, and this is covered in this patch by
checking the swap cache again after acquiring the src_pte lock.

Testing with a simple C program that allocates and moves several GB of
memory did not show any observable performance change.

Link: https://lkml.kernel.org/r/20250604151038.21968-1-ryncsn@gmail.com
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Signed-off-by: Kairui Song <kasong@tencent.com>
Closes: https://lore.kernel.org/linux-mm/CAMgjq7B1K=6OOrK2OUZ0-tqCzi+EJt+2_K97TPGoSt=9+JwP7Q@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/CAGsJ_4yJhJBo16XhiC-nUzSheyX-V3-nFE+tAi=8Y560K8eT=A@mail.gmail.com/ [2]
Reviewed-by: Lokesh Gidra <lokeshgidra@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/userfaultfd.c |   33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

--- a/mm/userfaultfd.c~mm-userfaultfd-fix-race-of-userfaultfd_move-and-swap-cache
+++ a/mm/userfaultfd.c
@@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struc
 			 pte_t orig_dst_pte, pte_t orig_src_pte,
 			 pmd_t *dst_pmd, pmd_t dst_pmdval,
 			 spinlock_t *dst_ptl, spinlock_t *src_ptl,
-			 struct folio *src_folio)
+			 struct folio *src_folio,
+			 struct swap_info_struct *si, swp_entry_t entry)
 {
+	/*
+	 * Check if the folio still belongs to the target swap entry after
+	 * acquiring the lock. Folio can be freed in the swap cache while
+	 * not locked.
+	 */
+	if (src_folio && unlikely(!folio_test_swapcache(src_folio) ||
+				  entry.val != src_folio->swap.val))
+		return -EAGAIN;
+
 	double_pt_lock(dst_ptl, src_ptl);
 
 	if (!is_pte_pages_stable(dst_pte, src_pte, orig_dst_pte, orig_src_pte,
@@ -1102,6 +1112,25 @@ static int move_swap_pte(struct mm_struc
 	if (src_folio) {
 		folio_move_anon_rmap(src_folio, dst_vma);
 		src_folio->index = linear_page_index(dst_vma, dst_addr);
+	} else {
+		/*
+		 * Check if the swap entry is cached after acquiring the src_pte
+		 * lock. Otherwise, we might miss a newly loaded swap cache folio.
+		 *
+		 * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
+		 * We are trying to catch newly added swap cache, the only possible case is
+		 * when a folio is swapped in and out again staying in swap cache, using the
+		 * same entry before the PTE check above. The PTL is acquired and released
+		 * twice, each time after updating the swap_map's flag. So holding
+		 * the PTL here ensures we see the updated value. False positive is possible,
+		 * e.g. SWP_SYNCHRONOUS_IO swapin may set the flag without touching the
+		 * cache, or during the tiny synchronization window between swap cache and
+		 * swap_map, but it will be gone very quickly, worst result is retry jitters.
+		 */
+		if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {
+			double_pt_unlock(dst_ptl, src_ptl);
+			return -EAGAIN;
+		}
 	}
 
 	orig_src_pte = ptep_get_and_clear(mm, src_addr, src_pte);
@@ -1412,7 +1441,7 @@ retry:
 		}
 		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
 				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
-				dst_ptl, src_ptl, src_folio);
+				dst_ptl, src_ptl, src_folio, si, entry);
 	}
 
 out:
_

Patches currently in -mm which might be from kasong@tencent.com are

mm-userfaultfd-fix-race-of-userfaultfd_move-and-swap-cache.patch


