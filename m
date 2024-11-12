Return-Path: <stable+bounces-92733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8024B9C55D0
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11AB51F2383E
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48521A4CC;
	Tue, 12 Nov 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yw27CJd6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4726321A4C4;
	Tue, 12 Nov 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408413; cv=none; b=UYuPtVXpBB+2u8DYBiOhcM2/ogRquQHAJGIpNNq77QNPBG8EGYGvc7SVhwKQpf2N1hK73yRvlJPKLD+vHnchh+Gu0iagu2cnVxwA3bcwqpeJe5vcvJNN9UBa9oYVXNHCThDob6ru7D7Vkt2uNM3tbVXItaIieG6WZryDgYWnuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408413; c=relaxed/simple;
	bh=8rLm2VUNkizA5VaDqQIsGmz/ndnORpn3JSjiUVWaPFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAnKilfsXGAnS9Odfyv/Uv+lbIT9HAXXIxM34azd1labOGP7nLQbVCCuU5sR/v8zlh59IPQzpTV5EwsrE9yUnRaZDo3x+rZq0oke8cpnrYqQTMBNTvQ3/6fB7AJj1WjzZZiXDfUxJOJnmbrz4ogD/k4YW4inNt6jZ0I/indeRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yw27CJd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810B2C4CECD;
	Tue, 12 Nov 2024 10:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408413;
	bh=8rLm2VUNkizA5VaDqQIsGmz/ndnORpn3JSjiUVWaPFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yw27CJd6gLL0PHz5IE0bLi6NgEGpsR8YEcB/lDAYoAvuR/C7AqaibHv8F3mNW9WTi
	 sfnfEovDQH5cnTqPb4X5lb+6VpCEGHSNoULhafspAMe1xYHQWBCDnEnqHuAhX2Gvwd
	 mUzQ6iZESWYms4eFzUkQmS7piJosFgfneKnw/Dms=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.11 154/184] mm/thp: fix deferred split unqueue naming and locking
Date: Tue, 12 Nov 2024 11:21:52 +0100
Message-ID: <20241112101906.783436968@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hugh Dickins <hughd@google.com>

commit f8f931bba0f92052cf842b7e30917b1afcc77d5a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/huge_memory.c   |   35 ++++++++++++++++++++++++++---------
 mm/internal.h      |   10 +++++-----
 mm/memcontrol-v1.c |   25 +++++++++++++++++++++++++
 mm/memcontrol.c    |    8 +++++---
 mm/migrate.c       |    4 ++--
 mm/page_alloc.c    |    1 -
 mm/swap.c          |    4 ++--
 mm/vmscan.c        |    4 ++--
 8 files changed, 67 insertions(+), 24 deletions(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3268,18 +3268,38 @@ out:
 	return ret;
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
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		list_del_init(&folio->_deferred_list);
+		unqueued = true;
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+
+	return unqueued;	/* useful for debug warnings */
 }
 
 void deferred_split_folio(struct folio *folio)
@@ -3298,14 +3318,11 @@ void deferred_split_folio(struct folio *
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
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -631,11 +631,11 @@ static inline void folio_set_order(struc
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
@@ -643,9 +643,9 @@ static inline void folio_undo_large_rmap
 	 * to check without acquiring the split_queue_lock.
 	 */
 	if (data_race(list_empty(&folio->_deferred_list)))
-		return;
+		return false;
 
-	__folio_undo_large_rmappable(folio);
+	return __folio_unqueue_deferred_split(folio);
 }
 
 static inline struct folio *page_rmappable_folio(struct page *page)
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -845,6 +845,8 @@ static int mem_cgroup_move_account(struc
 	css_get(&to->css);
 	css_put(&from->css);
 
+	/* Warning should never happen, so don't worry about refcount non-0 */
+	WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
 	folio->memcg_data = (unsigned long)to;
 
 	__folio_memcg_unlock(from);
@@ -1214,7 +1216,9 @@ static int mem_cgroup_move_charge_pte_ra
 	enum mc_target_type target_type;
 	union mc_target target;
 	struct folio *folio;
+	bool tried_split_before = false;
 
+retry_pmd:
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		if (mc.precharge < HPAGE_PMD_NR) {
@@ -1224,6 +1228,27 @@ static int mem_cgroup_move_charge_pte_ra
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
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4604,9 +4604,6 @@ static void uncharge_folio(struct folio
 	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
-	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
-			!folio_test_hugetlb(folio) &&
-			!list_empty(&folio->_deferred_list), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
@@ -4653,6 +4650,7 @@ static void uncharge_folio(struct folio
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
+		WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
 		folio->memcg_data = 0;
 	}
 
@@ -4769,6 +4767,9 @@ void mem_cgroup_migrate(struct folio *ol
 
 	/* Transfer the charge and the css ref */
 	commit_charge(new, memcg);
+
+	/* Warning should never happen, so don't worry about refcount non-0 */
+	WARN_ON_ONCE(folio_unqueue_deferred_split(old));
 	old->memcg_data = 0;
 }
 
@@ -4955,6 +4956,7 @@ void mem_cgroup_swapout(struct folio *fo
 	VM_BUG_ON_FOLIO(oldid, folio);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
+	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
 
 	if (!mem_cgroup_is_root(memcg))
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -415,7 +415,7 @@ static int __folio_migrate_mapping(struc
 		    folio_test_large_rmappable(folio)) {
 			if (!folio_ref_freeze(folio, expected_count))
 				return -EAGAIN;
-			folio_undo_large_rmappable(folio);
+			folio_unqueue_deferred_split(folio);
 			folio_ref_unfreeze(folio, expected_count);
 		}
 
@@ -438,7 +438,7 @@ static int __folio_migrate_mapping(struc
 	}
 
 	/* Take off deferred split queue while frozen and memcg set */
-	folio_undo_large_rmappable(folio);
+	folio_unqueue_deferred_split(folio);
 
 	/*
 	 * Now we know that no one else is looking at the folio:
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2663,7 +2663,6 @@ void free_unref_folios(struct folio_batc
 		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = folio_order(folio);
 
-		folio_undo_large_rmappable(folio);
 		if (!free_pages_prepare(&folio->page, order))
 			continue;
 		/*
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -123,7 +123,7 @@ void __folio_put(struct folio *folio)
 	}
 
 	page_cache_release(folio);
-	folio_undo_large_rmappable(folio);
+	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
 	free_unref_page(&folio->page, folio_order(folio));
 }
@@ -1020,7 +1020,7 @@ void folios_put_refs(struct folio_batch
 			free_huge_folio(folio);
 			continue;
 		}
-		folio_undo_large_rmappable(folio);
+		folio_unqueue_deferred_split(folio);
 		__page_cache_release(folio, &lruvec, &flags);
 
 		if (j != i)
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1462,7 +1462,7 @@ free_it:
 		 */
 		nr_reclaimed += nr_pages;
 
-		folio_undo_large_rmappable(folio);
+		folio_unqueue_deferred_split(folio);
 		if (folio_batch_add(&free_folios, folio) == 0) {
 			mem_cgroup_uncharge_folios(&free_folios);
 			try_to_unmap_flush();
@@ -1849,7 +1849,7 @@ static unsigned int move_folios_to_lru(s
 		if (unlikely(folio_put_testzero(folio))) {
 			__folio_clear_lru_flags(folio);
 
-			folio_undo_large_rmappable(folio);
+			folio_unqueue_deferred_split(folio);
 			if (folio_batch_add(&free_folios, folio) == 0) {
 				spin_unlock_irq(&lruvec->lru_lock);
 				mem_cgroup_uncharge_folios(&free_folios);



