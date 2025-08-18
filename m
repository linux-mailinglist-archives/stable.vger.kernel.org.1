Return-Path: <stable+bounces-170030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E59E2B2A012
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8763E18A15CD
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E739310622;
	Mon, 18 Aug 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3MRgecE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC423002DD
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515303; cv=none; b=l+c6XpgFOCWYYm9pRo+kvOckjlir8HMDrLuAaarn5zaLb/GdiXme/LmLNmChY5ApifZVzOIdLLuGiHyJEOrkSTs+FMf/ZjptuekbW4jFJZ9RR/NSLFSB3cUXRO8CuSoEjpc+eXMKvuRhm2GI/HE4Ya+3+eYLiE+CVXYF6h/00Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515303; c=relaxed/simple;
	bh=BRgyGK8S5+spkj1ReGMBsDLgoFXB7c8yzHyuPzf1k+Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kn/Ij1JpfJIuwmlzwwUQMsNxwi6tRR8DNYn74r5yDCgl3mlybX3dJh7iKrpeSTBjCelFCavx60NGfI4Z7r6hAsiQFjAlITFoXXwJUpRUjqMu2KRyuO0y91Zt3CZ7hMe0PV/JwFFWHXDgi7X7AOB/BX3rY+/jY1pNcNyhwAI6rLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W3MRgecE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C08DC4CEEB;
	Mon, 18 Aug 2025 11:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755515303;
	bh=BRgyGK8S5+spkj1ReGMBsDLgoFXB7c8yzHyuPzf1k+Q=;
	h=Subject:To:Cc:From:Date:From;
	b=W3MRgecEBzII5N1dR/p5n3/XhnpnFdHFYMKmQt5+ATzbxQ+3eUKF4nOq+myrKE/L1
	 /HUaBkGPhFXXdiKydMMA2EYviGeofYUBhO6eEggfrTkWM2NzneQbkPLC0mJirgKVg3
	 vYP0Wunx49fiuhpF3PICj4obafTfo8TRXSbvz41g=
Subject: FAILED: patch "[PATCH] mm/shmem, swap: improve cached mTHP handling and fix" failed to apply to 6.12-stable tree
To: kasong@tencent.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,bhe@redhat.com,chrisl@kernel.org,dev.jain@arm.com,hughd@google.com,nphamcs@gmail.com,shikemeng@huaweicloud.com,stable@vger.kernel.org,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 13:08:19 +0200
Message-ID: <2025081819-dawdler-letdown-9d50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5c241ed8d031693dadf33dd98ed2e7cc363e9b66
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081819-dawdler-letdown-9d50@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5c241ed8d031693dadf33dd98ed2e7cc363e9b66 Mon Sep 17 00:00:00 2001
From: Kairui Song <kasong@tencent.com>
Date: Mon, 28 Jul 2025 15:52:59 +0800
Subject: [PATCH] mm/shmem, swap: improve cached mTHP handling and fix
 potential hang

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

And worth noting, it may seems the order and value check before inserting
might help reducing the lock contention, which is not true.  The swap
cache layer ensures raced swapin will either see a swap cache folio or
failed to do a swapin (we have SWAP_HAS_CACHE bit even if swap cache is
bypassed), so holding the folio lock and checking the folio flag is
already good enough for avoiding the lock contention.  The chance that a
folio passes the swap entry value check but the shmem mapping slot has
changed should be very low.

Link: https://lkml.kernel.org/r/20250728075306.12704-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20250728075306.12704-2-ryncsn@gmail.com
Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/shmem.c b/mm/shmem.c
index 7570a24e0ae4..1d0fd266c29b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -891,7 +891,9 @@ static int shmem_add_to_page_cache(struct folio *folio,
 				   pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
-	long nr = folio_nr_pages(folio);
+	unsigned long nr = folio_nr_pages(folio);
+	swp_entry_t iter, swap;
+	void *entry;
 
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -903,14 +905,25 @@ static int shmem_add_to_page_cache(struct folio *folio,
 
 	gfp &= GFP_RECLAIM_MASK;
 	folio_throttle_swaprate(folio, gfp);
+	swap = radix_to_swp_entry(expected);
 
 	do {
+		iter = swap;
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
@@ -2359,7 +2372,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			error = -ENOMEM;
 			goto failed;
 		}
-	} else if (order != folio_order(folio)) {
+	} else if (order > folio_order(folio)) {
 		/*
 		 * Swap readahead may swap in order 0 folios into swapcache
 		 * asynchronously, while the shmem mapping can still stores
@@ -2384,15 +2397,23 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
 		}
+	} else if (order < folio_order(folio)) {
+		swap.val = round_down(swap.val, 1 << folio_order(folio));
+		index = round_down(index, 1 << folio_order(folio));
 	}
 
 alloced:
-	/* We have to do this with folio locked to prevent races */
+	/*
+	 * We have to do this with the folio locked to prevent races.
+	 * The shmem_confirm_swap below only checks if the first swap
+	 * entry matches the folio, that's enough to ensure the folio
+	 * is not used outside of shmem, as shmem swap entries
+	 * and swap cache folios are never partially freed.
+	 */
 	folio_lock(folio);
 	if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
-	    folio->swap.val != swap.val ||
 	    !shmem_confirm_swap(mapping, index, swap) ||
-	    xa_get_order(&mapping->i_pages, index) != folio_order(folio)) {
+	    folio->swap.val != swap.val) {
 		error = -EEXIST;
 		goto unlock;
 	}


