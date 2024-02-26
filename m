Return-Path: <stable+bounces-23646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D02867151
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431651C28815
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA0B52F92;
	Mon, 26 Feb 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rVh43Rug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA8321A0B
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943351; cv=none; b=idehzrl7DwsDilTF+kKLoZVUwhqBMG+48GIu8U5/+Pz5wSInqwx2YINzto+7Gupi38kAmm8CnQcIqe3yM48lLKirBf6EvnHviAC/U3X95yfV8tWok0gFGGbqJuooCX3IjpDVs1d+Jc0eBAyLGv59RlVhf7qEVURsewtteLRkY00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943351; c=relaxed/simple;
	bh=xcFCQLjCakvWomloDxuMx1WE0cYTTpgM77+K8QBpgLQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BLWobABp8uYltidAkaLwSxI/dGASNfKYPVh+m1qMITz5XWFKFIlP9M4l5h2KPF7xk1LWZwFsCj4RxDM9Cqh6cZ/xZdg5dwprslQ8Xkkb7UsGla49Gk0D4yIjtrLH/GsMU5lhzx2qxder7bEMse09AeKng4cmxyY/9KkX/h2xiLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rVh43Rug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08EEC433C7;
	Mon, 26 Feb 2024 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943351;
	bh=xcFCQLjCakvWomloDxuMx1WE0cYTTpgM77+K8QBpgLQ=;
	h=Subject:To:Cc:From:Date:From;
	b=rVh43RugI4tgFxq0WCOwj7r/Y85RQBHlATBF9viY6UVW+Vqtr9vVt9fTdYsiGcbfN
	 7kNxjSx7TtbHiS0i0zhDmbxuY2T78/5oy1KZHtVMxyUXmh6Nj3Jo6TSpIvnAug/Lny
	 2qnYU6hOtAz4niFc+buiJCmwfseKMLPCrbdBNy1Y=
Subject: FAILED: patch "[PATCH] mm/swap: fix race when skipping swapcache" failed to apply to 4.19-stable tree
To: kasong@tencent.com,21cnbao@gmail.com,akpm@linux-foundation.org,chrisl@kernel.org,david@redhat.com,hannes@cmpxchg.org,hughd@google.com,mhocko@suse.com,minchan@kernel.org,sj@kernel.org,stable@vger.kernel.org,willy@infradead.org,ying.huang@intel.com,yosryahmed@google.com,yuzhao@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:29:08 +0100
Message-ID: <2024022608-green-engaging-46db@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 13ddaf26be324a7f951891ecd9ccd04466d27458
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022608-green-engaging-46db@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

13ddaf26be32 ("mm/swap: fix race when skipping swapcache")
c9edc242811d ("swap: add swap_cache_get_folio()")
1baec203b77c ("mm/khugepaged: try to free transhuge swapcache when possible")
442701e7058b ("mm/swap: remove swap_cache_info statistics")
014bb1de4fc1 ("mm: create new mm/swap.h header file")
1493a1913e34 ("mm/swap: remember PG_anon_exclusive via a swp pte bit")
6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
78fbe906cc90 ("mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for PageAnon() pages")
6c54dc6c7437 ("mm/rmap: use page_move_anon_rmap() when reusing a mapped PageAnon() page exclusively")
28c5209dfd5f ("mm/rmap: pass rmap flags to hugepage_add_anon_rmap()")
f1e2db12e45b ("mm/rmap: remove do_page_add_anon_rmap()")
14f9135d5470 ("mm/rmap: convert RMAP flags to a proper distinct rmap_t type")
fb3d824d1a46 ("mm/rmap: split page_dup_rmap() into page_dup_file_rmap() and page_try_dup_anon_rmap()")
b51ad4f8679e ("mm/memory: slightly simplify copy_present_pte()")
623a1ddfeb23 ("mm/hugetlb: take src_mm->write_protect_seq in copy_hugetlb_page_range()")
3bff7e3f1f16 ("mm/huge_memory: streamline COW logic in do_huge_pmd_wp_page()")
c145e0b47c77 ("mm: streamline COW logic in do_swap_page()")
84d60fdd3733 ("mm: slightly clarify KSM logic in do_swap_page()")
53a05ad9f21d ("mm: optimize do_wp_page() for exclusive pages in the swapcache")
6b1f86f8e9c7 ("Merge tag 'folio-5.18b' of git://git.infradead.org/users/willy/pagecache")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 13ddaf26be324a7f951891ecd9ccd04466d27458 Mon Sep 17 00:00:00 2001
From: Kairui Song <kasong@tencent.com>
Date: Wed, 7 Feb 2024 02:25:59 +0800
Subject: [PATCH] mm/swap: fix race when skipping swapcache

When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
swapin the same entry at the same time, they get different pages (A, B).
Before one thread (T0) finishes the swapin and installs page (A) to the
PTE, another thread (T1) could finish swapin of page (B), swap_free the
entry, then swap out the possibly modified page reusing the same entry.
It breaks the pte_same check in (T0) because PTE value is unchanged,
causing ABA problem.  Thread (T0) will install a stalled page (A) into the
PTE and cause data corruption.

One possible callstack is like this:

CPU0                                 CPU1
----                                 ----
do_swap_page()                       do_swap_page() with same entry
<direct swapin path>                 <direct swapin path>
<alloc page A>                       <alloc page B>
swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
<slow on later locks or interrupt>   <finished swapin first>
...                                  set_pte_at()
                                     swap_free() <- entry is free
                                     <write to page B, now page A stalled>
                                     <swap out page B to same swap entry>
pte_same() <- Check pass, PTE seems
              unchanged, but page A
              is stalled!
swap_free() <- page B content lost!
set_pte_at() <- staled page A installed!

And besides, for ZRAM, swap_free() allows the swap device to discard the
entry content, so even if page (B) is not modified, if swap_read_folio()
on CPU0 happens later than swap_free() on CPU1, it may also cause data
loss.

To fix this, reuse swapcache_prepare which will pin the swap entry using
the cache flag, and allow only one thread to swap it in, also prevent any
parallel code from putting the entry in the cache.  Release the pin after
PT unlocked.

Racers just loop and wait since it's a rare and very short event.  A
schedule_timeout_uninterruptible(1) call is added to avoid repeated page
faults wasting too much CPU, causing livelock or adding too much noise to
perf statistics.  A similar livelock issue was described in commit
029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead")

Reproducer:

This race issue can be triggered easily using a well constructed
reproducer and patched brd (with a delay in read path) [1]:

With latest 6.8 mainline, race caused data loss can be observed easily:
$ gcc -g -lpthread test-thread-swap-race.c && ./a.out
  Polulating 32MB of memory region...
  Keep swapping out...
  Starting round 0...
  Spawning 65536 workers...
  32746 workers spawned, wait for done...
  Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
  Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
  Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
  Round 0 Failed, 15 data loss!

This reproducer spawns multiple threads sharing the same memory region
using a small swap device.  Every two threads updates mapped pages one by
one in opposite direction trying to create a race, with one dedicated
thread keep swapping out the data out using madvise.

The reproducer created a reproduce rate of about once every 5 minutes, so
the race should be totally possible in production.

After this patch, I ran the reproducer for over a few hundred rounds and
no data loss observed.

Performance overhead is minimal, microbenchmark swapin 10G from 32G
zram:

Before:     10934698 us
After:      11157121 us
Cached:     13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)

[kasong@tencent.com: v4]
  Link: https://lkml.kernel.org/r/20240219082040.7495-1-ryncsn@gmail.com
Link: https://lkml.kernel.org/r/20240206182559.32264-1-ryncsn@gmail.com
Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous device")
Reported-by: "Huang, Ying" <ying.huang@intel.com>
Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com/
Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-race [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Acked-by: Yu Zhao <yuzhao@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Chris Li <chrisl@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 4db00ddad261..8d28f6091a32 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
 	return 0;
 }
 
+static inline int swapcache_prepare(swp_entry_t swp)
+{
+	return 0;
+}
+
 static inline void swap_free(swp_entry_t swp)
 {
 }
diff --git a/mm/memory.c b/mm/memory.c
index 15f8b10ea17c..0bfc8b007c01 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct page *page;
 	struct swap_info_struct *si = NULL;
 	rmap_t rmap_flags = RMAP_NONE;
+	bool need_clear_cache = false;
 	bool exclusive = false;
 	swp_entry_t entry;
 	pte_t pte;
@@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
+			/*
+			 * Prevent parallel swapin from proceeding with
+			 * the cache flag. Otherwise, another thread may
+			 * finish swapin first, free the entry, and swapout
+			 * reusing the same entry. It's undetectable as
+			 * pte_same() returns true due to entry reuse.
+			 */
+			if (swapcache_prepare(entry)) {
+				/* Relax a bit to prevent rapid repeated page faults */
+				schedule_timeout_uninterruptible(1);
+				goto out;
+			}
+			need_clear_cache = true;
+
 			/* skip swapcache */
 			folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 						vma, vmf->address, false);
@@ -4117,6 +4132,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
+	/* Clear the swap cache pin for direct swapin after PTL unlock */
+	if (need_clear_cache)
+		swapcache_clear(si, entry);
 	if (si)
 		put_swap_device(si);
 	return ret;
@@ -4131,6 +4149,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_unlock(swapcache);
 		folio_put(swapcache);
 	}
+	if (need_clear_cache)
+		swapcache_clear(si, entry);
 	if (si)
 		put_swap_device(si);
 	return ret;
diff --git a/mm/swap.h b/mm/swap.h
index 758c46ca671e..fc2f6ade7f80 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
 void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
@@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
 	return 0;
 }
 
+static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+}
+
 static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
 		struct vm_area_struct *vma, unsigned long addr)
 {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 556ff7347d5f..746aa9da5302 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
 	return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }
 
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
+	unsigned char usage;
+
+	ci = lock_cluster_or_swap_info(si, offset);
+	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
+	unlock_cluster_or_swap_info(si, ci);
+	if (!usage)
+		free_swap_slot(entry);
+}
+
 struct swap_info_struct *swp_swap_info(swp_entry_t entry)
 {
 	return swap_type_to_swap_info(swp_type(entry));


