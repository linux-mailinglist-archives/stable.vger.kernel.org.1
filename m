Return-Path: <stable+bounces-92092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6AE9C3D6A
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724841C225DF
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A336815A84E;
	Mon, 11 Nov 2024 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dCJrLWpF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52517155CBD
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324970; cv=none; b=hlX1BTi8iJ2+Lw+LPdyATmGHw7D6gOEzM/veeA5IgGP9sdPSjS2DaMFt6IOIjOSS3wmPyypSd4MQRvXGptZ81QdDDylgEHjpu96yppZEi0sRa6rj67PxtGI2qDpf5P8a/Yvvgsi2w74aeEA4Sk6Cs772Y/pAG9v5wmGRlQZe2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324970; c=relaxed/simple;
	bh=CxMl1KgI5jS9zLfQvWC38qxC3LYxAdmT7j51Ny2l1BI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gYH0ADLofvBHQAJ4ezobdBersfyY1AeZzAbqroGNhX3phLlaShCkaOOZF1Z7BZyxRPwpvuDXhd9TbbHdqHc7MoMWzR1986Ce8qKWRmFKXfqQJ2ByZBgkNIqFo9fXIKHzmVF5iDlP9R1PbLRA7MbKuTzguCtZUKodiNUgoNpEe7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dCJrLWpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318F6C4CECF;
	Mon, 11 Nov 2024 11:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731324969;
	bh=CxMl1KgI5jS9zLfQvWC38qxC3LYxAdmT7j51Ny2l1BI=;
	h=Subject:To:Cc:From:Date:From;
	b=dCJrLWpFue76FCECm0XN3HWMIRQZvO6VIYvEkkdXPiKWPaUNQowcznoOqAhT846D0
	 oWl2TXTki/WSD6oH74X0ySwtfVtcl0OtmFsxAkWNw9aPfGK1wo8OhVEo3aPSQQwzRd
	 qTtuhDU5bNo9oS3iszVzBZoLqa+wzLq4D/1AWhp4=
Subject: FAILED: patch "[PATCH] mm/thp: fix deferred split unqueue naming and locking" failed to apply to 6.6-stable tree
To: hughd@google.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,chrisl@kernel.org,david@redhat.com,hannes@cmpxchg.org,kirill.shutemov@linux.intel.com,nphamcs@gmail.com,richard.weiyang@gmail.com,ryan.roberts@arm.com,shakeel.butt@linux.dev,shy828301@gmail.com,stable@vger.kernel.org,usamaarif642@gmail.com,wangkefeng.wang@huawei.com,willy@infradead.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:36:06 +0100
Message-ID: <2024111106-employer-bulgur-4f6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f8f931bba0f92052cf842b7e30917b1afcc77d5a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111106-employer-bulgur-4f6d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8f931bba0f92052cf842b7e30917b1afcc77d5a Mon Sep 17 00:00:00 2001
From: Hugh Dickins <hughd@google.com>
Date: Sun, 27 Oct 2024 13:02:13 -0700
Subject: [PATCH] mm/thp: fix deferred split unqueue naming and locking

Recent changes are putting more pressure on THP deferred split queues:
under load revealing long-standing races, causing list_del corruptions,
"Bad page state"s and worse (I keep BUGs in both of those, so usually
don't get to see how badly they end up without).  The relevant recent
changes being 6.8's mTHP, 6.10's mTHP swapout, and 6.12's mTHP swapin,
improved swap allocation, and underused THP splitting.

Before fixing locking: rename misleading folio_undo_large_rmappable(),
which does not undo large_rmappable, to folio_unqueue_deferred_split(),
which is what it does.  But that and its out-of-line __callee are mm
internals of very limited usability: add comment and WARN_ON_ONCEs to
check usage; and return a bool to say if a deferred split was unqueued,
which can then be used in WARN_ON_ONCEs around safety checks (sparing
callers the arcane conditionals in __folio_unqueue_deferred_split()).

Just omit the folio_unqueue_deferred_split() from free_unref_folios(), all
of whose callers now call it beforehand (and if any forget then bad_page()
will tell) - except for its caller put_pages_list(), which itself no
longer has any callers (and will be deleted separately).

Swapout: mem_cgroup_swapout() has been resetting folio->memcg_data 0
without checking and unqueueing a THP folio from deferred split list;
which is unfortunate, since the split_queue_lock depends on the memcg
(when memcg is enabled); so swapout has been unqueueing such THPs later,
when freeing the folio, using the pgdat's lock instead: potentially
corrupting the memcg's list.  __remove_mapping() has frozen refcount to 0
here, so no problem with calling folio_unqueue_deferred_split() before
resetting memcg_data.

That goes back to 5.4 commit 87eaceb3faa5 ("mm: thp: make deferred split
shrinker memcg aware"): which included a check on swapcache before adding
to deferred queue, but no check on deferred queue before adding THP to
swapcache.  That worked fine with the usual sequence of events in reclaim
(though there were a couple of rare ways in which a THP on deferred queue
could have been swapped out), but 6.12 commit dafff3f4c850 ("mm: split
underused THPs") avoids splitting underused THPs in reclaim, which makes
swapcache THPs on deferred queue commonplace.

Keep the check on swapcache before adding to deferred queue?  Yes: it is
no longer essential, but preserves the existing behaviour, and is likely
to be a worthwhile optimization (vmstat showed much more traffic on the
queue under swapping load if the check was removed); update its comment.

Memcg-v1 move (deprecated): mem_cgroup_move_account() has been changing
folio->memcg_data without checking and unqueueing a THP folio from the
deferred list, sometimes corrupting "from" memcg's list, like swapout.
Refcount is non-zero here, so folio_unqueue_deferred_split() can only be
used in a WARN_ON_ONCE to validate the fix, which must be done earlier:
mem_cgroup_move_charge_pte_range() first try to split the THP (splitting
of course unqueues), or skip it if that fails.  Not ideal, but moving
charge has been requested, and khugepaged should repair the THP later:
nobody wants new custom unqueueing code just for this deprecated case.

The 87eaceb3faa5 commit did have the code to move from one deferred list
to another (but was not conscious of its unsafety while refcount non-0);
but that was removed by 5.6 commit fac0516b5534 ("mm: thp: don't need care
deferred split queue in memcg charge move path"), which argued that the
existence of a PMD mapping guarantees that the THP cannot be on a deferred
list.  As above, false in rare cases, and now commonly false.

Backport to 6.11 should be straightforward.  Earlier backports must take
care that other _deferred_list fixes and dependencies are included.  There
is not a strong case for backports, but they can fix cornercases.

Link: https://lkml.kernel.org/r/8dc111ae-f6db-2da7-b25c-7a20b1effe3b@google.com
Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
Fixes: dafff3f4c850 ("mm: split underused THPs")
Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chris Li <chrisl@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a1d345f1680c..03fd4bc39ea1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3588,10 +3588,27 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
 	return split_huge_page_to_list_to_order(&folio->page, list, ret);
 }
 
-void __folio_undo_large_rmappable(struct folio *folio)
+/*
+ * __folio_unqueue_deferred_split() is not to be called directly:
+ * the folio_unqueue_deferred_split() inline wrapper in mm/internal.h
+ * limits its calls to those folios which may have a _deferred_list for
+ * queueing THP splits, and that list is (racily observed to be) non-empty.
+ *
+ * It is unsafe to call folio_unqueue_deferred_split() until folio refcount is
+ * zero: because even when split_queue_lock is held, a non-empty _deferred_list
+ * might be in use on deferred_split_scan()'s unlocked on-stack list.
+ *
+ * If memory cgroups are enabled, split_queue_lock is in the mem_cgroup: it is
+ * therefore important to unqueue deferred split before changing folio memcg.
+ */
+bool __folio_unqueue_deferred_split(struct folio *folio)
 {
 	struct deferred_split *ds_queue;
 	unsigned long flags;
+	bool unqueued = false;
+
+	WARN_ON_ONCE(folio_ref_count(folio));
+	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
 
 	ds_queue = get_deferred_split_queue(folio);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
@@ -3603,8 +3620,11 @@ void __folio_undo_large_rmappable(struct folio *folio)
 				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 		}
 		list_del_init(&folio->_deferred_list);
+		unqueued = true;
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+
+	return unqueued;	/* useful for debug warnings */
 }
 
 /* partially_mapped=false won't clear PG_partially_mapped folio flag */
@@ -3627,14 +3647,11 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 		return;
 
 	/*
-	 * The try_to_unmap() in page reclaim path might reach here too,
-	 * this may cause a race condition to corrupt deferred split queue.
-	 * And, if page reclaim is already handling the same folio, it is
-	 * unnecessary to handle it again in shrinker.
-	 *
-	 * Check the swapcache flag to determine if the folio is being
-	 * handled by page reclaim since THP swap would add the folio into
-	 * swap cache before calling try_to_unmap().
+	 * Exclude swapcache: originally to avoid a corrupt deferred split
+	 * queue. Nowadays that is fully prevented by mem_cgroup_swapout();
+	 * but if page reclaim is already handling the same folio, it is
+	 * unnecessary to handle it again in the shrinker, so excluding
+	 * swapcache here may still be a useful optimization.
 	 */
 	if (folio_test_swapcache(folio))
 		return;
diff --git a/mm/internal.h b/mm/internal.h
index 93083bbeeefa..16c1f3cd599e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -639,11 +639,11 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 #endif
 }
 
-void __folio_undo_large_rmappable(struct folio *folio);
-static inline void folio_undo_large_rmappable(struct folio *folio)
+bool __folio_unqueue_deferred_split(struct folio *folio);
+static inline bool folio_unqueue_deferred_split(struct folio *folio)
 {
 	if (folio_order(folio) <= 1 || !folio_test_large_rmappable(folio))
-		return;
+		return false;
 
 	/*
 	 * At this point, there is no one trying to add the folio to
@@ -651,9 +651,9 @@ static inline void folio_undo_large_rmappable(struct folio *folio)
 	 * to check without acquiring the split_queue_lock.
 	 */
 	if (data_race(list_empty(&folio->_deferred_list)))
-		return;
+		return false;
 
-	__folio_undo_large_rmappable(folio);
+	return __folio_unqueue_deferred_split(folio);
 }
 
 static inline struct folio *page_rmappable_folio(struct page *page)
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 81d8819f13cd..f8744f5630bb 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -848,6 +848,8 @@ static int mem_cgroup_move_account(struct folio *folio,
 	css_get(&to->css);
 	css_put(&from->css);
 
+	/* Warning should never happen, so don't worry about refcount non-0 */
+	WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
 	folio->memcg_data = (unsigned long)to;
 
 	__folio_memcg_unlock(from);
@@ -1217,7 +1219,9 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	enum mc_target_type target_type;
 	union mc_target target;
 	struct folio *folio;
+	bool tried_split_before = false;
 
+retry_pmd:
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		if (mc.precharge < HPAGE_PMD_NR) {
@@ -1227,6 +1231,27 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
 		if (target_type == MC_TARGET_PAGE) {
 			folio = target.folio;
+			/*
+			 * Deferred split queue locking depends on memcg,
+			 * and unqueue is unsafe unless folio refcount is 0:
+			 * split or skip if on the queue? first try to split.
+			 */
+			if (!list_empty(&folio->_deferred_list)) {
+				spin_unlock(ptl);
+				if (!tried_split_before)
+					split_folio(folio);
+				folio_unlock(folio);
+				folio_put(folio);
+				if (tried_split_before)
+					return 0;
+				tried_split_before = true;
+				goto retry_pmd;
+			}
+			/*
+			 * So long as that pmd lock is held, the folio cannot
+			 * be racily added to the _deferred_list, because
+			 * __folio_remove_rmap() will find !partially_mapped.
+			 */
 			if (folio_isolate_lru(folio)) {
 				if (!mem_cgroup_move_account(folio, true,
 							     mc.from, mc.to)) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2703227cce88..06df2af97415 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4629,9 +4629,6 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
-	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
-			!folio_test_hugetlb(folio) &&
-			!list_empty(&folio->_deferred_list), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
@@ -4678,6 +4675,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
+		WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
 		folio->memcg_data = 0;
 	}
 
@@ -4789,6 +4787,9 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 
 	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
+
+	/* Warning should never happen, so don't worry about refcount non-0 */
+	WARN_ON_ONCE(folio_unqueue_deferred_split(old));
 	old->memcg_data = 0;
 }
 
@@ -4975,6 +4976,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	VM_BUG_ON_FOLIO(oldid, folio);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
+	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
 
 	if (!mem_cgroup_is_root(memcg))
diff --git a/mm/migrate.c b/mm/migrate.c
index fab84a776088..dfa24e41e8f9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -490,7 +490,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		    folio_test_large_rmappable(folio)) {
 			if (!folio_ref_freeze(folio, expected_count))
 				return -EAGAIN;
-			folio_undo_large_rmappable(folio);
+			folio_unqueue_deferred_split(folio);
 			folio_ref_unfreeze(folio, expected_count);
 		}
 
@@ -515,7 +515,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	/* Take off deferred split queue while frozen and memcg set */
-	folio_undo_large_rmappable(folio);
+	folio_unqueue_deferred_split(folio);
 
 	/*
 	 * Now we know that no one else is looking at the folio:
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5e108ae755cc..8ad38cd5e574 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2681,7 +2681,6 @@ void free_unref_folios(struct folio_batch *folios)
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
-		folio_undo_large_rmappable(folio);
 		if (!free_pages_prepare(&folio->page, order))
 			continue;
 		/*
diff --git a/mm/swap.c b/mm/swap.c
index 835bdf324b76..b8e3259ea2c4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -121,7 +121,7 @@ void __folio_put(struct folio *folio)
 	}
 
 	page_cache_release(folio);
-	folio_undo_large_rmappable(folio);
+	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
 	free_unref_page(&folio->page, folio_order(folio));
 }
@@ -988,7 +988,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 			free_huge_folio(folio);
 			continue;
 		}
-		folio_undo_large_rmappable(folio);
+		folio_unqueue_deferred_split(folio);
 		__page_cache_release(folio, &lruvec, &flags);
 
 		if (j != i)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ddaaff67642e..28ba2b06fc7d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1476,7 +1476,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 */
 		nr_reclaimed += nr_pages;
 
-		folio_undo_large_rmappable(folio);
+		folio_unqueue_deferred_split(folio);
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
@@ -1864,7 +1864,7 @@ static unsigned int move_folios_to_lru(struct lruvec *lruvec,
 		if (unlikely(folio_put_testzero(folio))) {
 			__folio_clear_lru_flags(folio);
 
-			folio_undo_large_rmappable(folio);
+			folio_unqueue_deferred_split(folio);
 			if (folio_batch_add(&free_folios, folio) == 0) {
 				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge_folios(&free_folios);


