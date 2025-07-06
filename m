Return-Path: <stable+bounces-160226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0D0AF9BA4
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 22:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62F9565DD2
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 20:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5591FE461;
	Fri,  4 Jul 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cAHfRXSx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B444D1D90DF;
	Fri,  4 Jul 2025 20:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660398; cv=none; b=UErMbSMBNN0gzF4sgixBUR5ckd/c0QUeYsQ2yE5S89J0QkWK4PXPYXSNPB+ojjT46AS+mkU2NgXzcU+0NBDxEWYV8x4g93Zn3OPUszGE9/sI+gluCTZcp29aNaXVQqqtUfr1pgrca9/f5hxiP8TILei0HK3KwHsZk0fnwlwbp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660398; c=relaxed/simple;
	bh=L2gdbSLCEKeH0sBYC7aYnuEMAyVIFfV/KGZIMPU4b8M=;
	h=Date:To:From:Subject:Message-Id; b=sDeD1ZaD6Pzk/X7Jvs+SlJee8Kn60ftAKIKyBzk5cWFS0G8oikOb8laRJIBQrizQMJLgqAWtr94+ZbioQPErOejIj94aWxmzYFaf6iz5yoz9teGRJ1Ul/x8+frlQT8flSXpZSNeli1dE5HqYbhgIkdW06JQPuG+5uWIXDiKCfoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cAHfRXSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18928C4CEE3;
	Fri,  4 Jul 2025 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751660398;
	bh=L2gdbSLCEKeH0sBYC7aYnuEMAyVIFfV/KGZIMPU4b8M=;
	h=Date:To:From:Subject:From;
	b=cAHfRXSxVx65D3wFtY01L5/avg8YInZyvbnebvNm03MMe9kmH3+9Vp8w/oammBLR1
	 SjaXAS19gBjMpNfaZHiQ2e/jeQAH5cpykUT9l6TLamD1XMsFpcYG2QnapCp5mTF1NI
	 WUNZua5dNKYAuDNBJ+mFKcNzwLrEcBvRTiPKkEyI=
Date: Fri, 04 Jul 2025 13:19:57 -0700
To: mm-commits@vger.kernel.org,willy@infradead.org,stable@vger.kernel.org,shikemeng@huaweicloud.com,nphamcs@gmail.com,hughd@google.com,dev.jain@arm.com,chrisl@kernel.org,bhe@redhat.com,baolin.wang@linux.alibaba.com,baohua@kernel.org,kasong@tencent.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-shmem-swap-improve-cached-mthp-handling-and-fix-potential-hung.patch added to mm-unstable branch
Message-Id: <20250704201958.18928C4CEE3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/shmem, swap: improve cached mTHP handling and fix potential hang
has been added to the -mm mm-unstable branch.  Its filename is
     mm-shmem-swap-improve-cached-mthp-handling-and-fix-potential-hung.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-shmem-swap-improve-cached-mthp-handling-and-fix-potential-hung.patch

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
From: Kairui Song <kasong@tencent.com>
Subject: mm/shmem, swap: improve cached mTHP handling and fix potential hang
Date: Sat, 5 Jul 2025 02:17:40 +0800

Patch series "mm/shmem, swap: bugfix and improvement of mTHP swap-in", v4.

The current mTHP swapin path have several problems.  It may potentially
hang, may cause redundant faults due to false positive swap cache lookup,
and it will involve at least 4 Xarray tree walks (get order, get order
again, confirm swap, insert folio).  And for !CONFIG_TRANSPARENT_HUGEPAGE
builds, it will performs some mTHP related checks.

This series fixes all of the mentioned issues, and the code should be more
robust and prepared for the swap table series.  Now tree walks is reduced
to twice (get order & confirm, insert folio), !CONFIG_TRANSPARENT_HUGEPAGE
build overhead is also minimized, and comes with a sanity check now.

The performance is slightly better after this series, sequential swap in
of 24G data from ZRAM, using transparent_hugepage_tmpfs=always (24 samples
each):

Before:        11.02,  stddev: 0.06
After patch 1: 10.74,  stddev: 0.03
After patch 2: 10.72,  stddev: 0.01
After patch 3: 10.73,  stddev: 0.04
After patch 4: 10.72,  stddev: 0.02
After patch 5: 10.74,  stddev: 0.01
After patch 6: 10.13,  stddev: 0.09
After patch 7: 9.95,   stddev: 0.02
After patch 8: 9.88,   stddev: 0.04

Each patch improves the performance by a little, which is about ~10%
faster in total.

Build kernel test showed very slightly improvement, testing with make -j24
with defconfig in a 256M memcg also using ZRAM as swap, and
transparent_hugepage_tmpfs=always (6 test runs):

Before:      system time avg: 3911.80s
After:       system time avg: 3863.76s


This patch (of 9):

The current swap-in code assumes that, when a swap entry in shmem mapping
is order 0, its cached folios (if present) must be order 0 too, which
turns out not always correct.

The problem is shmem_split_large_entry is called before verifying the
folio will eventually be swapped in, one possible race is:

    CPU1                          CPU2
shmem_swapin_folio
/* swap in of order > 0 swap entry S1 */
  folio = swap_cache_get_folio
  /* folio = NULL */
  order = xa_get_order
  /* order > 0 */
  folio = shmem_swap_alloc_folio
  /* mTHP alloc failure, folio = NULL */
  <... Interrupted ...>
                                 shmem_swapin_folio
                                 /* S1 is swapped in */
                                 shmem_writeout
                                 /* S1 is swapped out, folio cached */
  shmem_split_large_entry(..., S1)
  /* S1 is split, but the folio covering it has order > 0 now */

Now any following swapin of S1 will hang: `xa_get_order` returns 0, and
folio lookup will return a folio with order > 0.  The
`xa_get_order(&mapping->i_pages, index) != folio_order(folio)` will always
return false causing swap-in to return -EEXIST.

And this looks fragile.  So fix this up by allowing seeing a larger folio
in swap cache, and check the whole shmem mapping range covered by the
swapin have the right swap value upon inserting the folio.  And drop the
redundant tree walks before the insertion.

This will actually improve performance, as it avoids two redundant Xarray
tree walks in the hot path, and the only side effect is that in the
failure path, shmem may redundantly reallocate a few folios causing
temporary slight memory pressure.

And worth noting, it may seem the order and value check before inserting
might help reducing the lock contention, which is not true.  The swap
cache layer ensures raced swapin will either see a swap cache folio or
failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache is
bypassed), so holding the folio lock and checking the folio flag is
already good enough for avoiding the lock contention.  The chance that a
folio passes the swap entry value check but the shmem mapping slot has
changed should be very low.

Link: https://lkml.kernel.org/r/20250704181748.63181-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20250704181748.63181-2-ryncsn@gmail.com
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/shmem.c |   30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

--- a/mm/shmem.c~mm-shmem-swap-improve-cached-mthp-handling-and-fix-potential-hung
+++ a/mm/shmem.c
@@ -884,7 +884,9 @@ static int shmem_add_to_page_cache(struc
 				   pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
-	long nr = folio_nr_pages(folio);
+	unsigned long nr = folio_nr_pages(folio);
+	swp_entry_t iter, swap;
+	void *entry;
 
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -896,14 +898,24 @@ static int shmem_add_to_page_cache(struc
 
 	gfp &= GFP_RECLAIM_MASK;
 	folio_throttle_swaprate(folio, gfp);
+	swap = iter = radix_to_swp_entry(expected);
 
 	do {
 		xas_lock_irq(&xas);
-		if (expected != xas_find_conflict(&xas)) {
-			xas_set_err(&xas, -EEXIST);
-			goto unlock;
+		xas_for_each_conflict(&xas, entry) {
+			/*
+			 * The range must either be empty, or filled with
+			 * expected swap entries. Shmem swap entries are never
+			 * partially freed without split of both entry and
+			 * folio, so there shouldn't be any holes.
+			 */
+			if (!expected || entry != swp_to_radix_entry(iter)) {
+				xas_set_err(&xas, -EEXIST);
+				goto unlock;
+			}
+			iter.val += 1 << xas_get_order(&xas);
 		}
-		if (expected && xas_find_conflict(&xas)) {
+		if (expected && iter.val - nr != swap.val) {
 			xas_set_err(&xas, -EEXIST);
 			goto unlock;
 		}
@@ -2323,7 +2335,7 @@ static int shmem_swapin_folio(struct ino
 			error = -ENOMEM;
 			goto failed;
 		}
-	} else if (order != folio_order(folio)) {
+	} else if (order > folio_order(folio)) {
 		/*
 		 * Swap readahead may swap in order 0 folios into swapcache
 		 * asynchronously, while the shmem mapping can still stores
@@ -2348,15 +2360,15 @@ static int shmem_swapin_folio(struct ino
 
 			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
 		}
+	} else if (order < folio_order(folio)) {
+		swap.val = round_down(swap.val, 1 << folio_order(folio));
 	}
 
 alloced:
 	/* We have to do this with folio locked to prevent races */
 	folio_lock(folio);
 	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
-	    folio->swap.val != swap.val ||
-	    !shmem_confirm_swap(mapping, index, swap) ||
-	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
+	    folio->swap.val != swap.val) {
 		error = -EEXIST;
 		goto unlock;
 	}
_

Patches currently in -mm which might be from kasong@tencent.com are

mm-list_lru-refactor-the-locking-code.patch
mm-shmem-swap-improve-cached-mthp-handling-and-fix-potential-hung.patch
mm-shmem-swap-avoid-redundant-xarray-lookup-during-swapin.patch
mm-shmem-swap-tidy-up-thp-swapin-checks.patch
mm-shmem-swap-tidy-up-swap-entry-splitting.patch
mm-shmem-swap-avoid-false-positive-swap-cache-lookup.patch
mm-shmem-swap-never-use-swap-cache-and-readahead-for-swp_synchronous_io.patch
mm-shmem-swap-simplify-swapin-path-and-result-handling.patch
mm-shmem-swap-simplify-swap-entry-and-index-calculation-of-large-swapin.patch
mm-shmem-swap-fix-major-fault-counting.patch


