Return-Path: <stable+bounces-158904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E57AED88E
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E114A189A72B
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060132405E4;
	Mon, 30 Jun 2025 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PogzEg3k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858723F40F
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275315; cv=none; b=QOD6DOKoyMbW1/BiaJ7dPPBxYOQjR5DYY6iPOn0x1lE+RpU/9nYExdy0sCAOMzvzaI6Tru7MvqAAmXQ3zn+Bgol0YptmZ3QXfmAQ+5eH5kdGgBZwsHhlvNzPWtBPxqIrTmak9YmIPY+aubLXolbCxzynwUE0IbDREyAq28WOuEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275315; c=relaxed/simple;
	bh=GcBRlp8BxfgH/BowaKhDDH74AfqXP1+z05IlsUlO158=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aU8FaZ7NMjeHNscsYbuMApkXi63Azu6mDHHKJNhYUmEradAmEwSY0LWZj1SSl6d85S8Dg849j39Wxp6ArbgV+uGFd8vkU08tyoR4FtVcokE7kWPV+mSdnvrw3cjw5AjYFa7pbpELCGq/d+5fEWix43iTyOM4W1HIS7YfmKBQpNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PogzEg3k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267AAC4CEE3;
	Mon, 30 Jun 2025 09:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275315;
	bh=GcBRlp8BxfgH/BowaKhDDH74AfqXP1+z05IlsUlO158=;
	h=Subject:To:Cc:From:Date:From;
	b=PogzEg3ksmU5wgdrYAkEuQwrJIkBA8RSi4oPA5ZKJQSgzaOWJTOsWk7AwqM6I/tiE
	 uPqE3qzU58GzNrwBjTUeOnm9GnejuPMcgAkIkZ38XJOPYDiT5QQ6oNaWsngiUKPEbX
	 i7Xl8+Ux8Y3Wy/4obn63XnLhMiVdD/nRZbzCKUkE=
Subject: FAILED: patch "[PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache" failed to apply to 6.12-stable tree
To: kasong@tencent.com,aarcange@redhat.com,akpm@linux-foundation.org,baohua@kernel.org,chrisl@kernel.org,david@redhat.com,lokeshgidra@google.com,peterx@redhat.com,stable@vger.kernel.org,surenb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:21:52 +0200
Message-ID: <2025063052-strive-fabulous-239b@gregkh>
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
git cherry-pick -x 0ea148a799198518d8ebab63ddd0bb6114a103bc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063052-strive-fabulous-239b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ea148a799198518d8ebab63ddd0bb6114a103bc Mon Sep 17 00:00:00 2001
From: Kairui Song <kasong@tencent.com>
Date: Wed, 4 Jun 2025 23:10:38 +0800
Subject: [PATCH] mm: userfaultfd: fix race of userfaultfd_move and swap cache

This commit fixes two kinds of races, they may have different results:

Barry reported a BUG_ON in commit c50f8e6053b0, we may see the same
BUG_ON if the filemap lookup returned NULL and folio is added to swap
cache after that.

If another kind of race is triggered (folio changed after lookup) we
may see RSS counter is corrupted:

[  406.893936] BUG: Bad rss-counter state mm:ffff0000c5a9ddc0
type:MM_ANONPAGES val:-1
[  406.894071] BUG: Bad rss-counter state mm:ffff0000c5a9ddc0
type:MM_SHMEMPAGES val:1

Because the folio is being accounted to the wrong VMA.

I'm not sure if there will be any data corruption though, seems no.
The issues above are critical already.


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
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Chris Li <chrisl@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index bc473ad21202..8253978ee0fb 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1084,8 +1084,18 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
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
@@ -1102,6 +1112,25 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
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
@@ -1412,7 +1441,7 @@ static int move_pages_pte(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd,
 		}
 		err = move_swap_pte(mm, dst_vma, dst_addr, src_addr, dst_pte, src_pte,
 				orig_dst_pte, orig_src_pte, dst_pmd, dst_pmdval,
-				dst_ptl, src_ptl, src_folio);
+				dst_ptl, src_ptl, src_folio, si, entry);
 	}
 
 out:


