Return-Path: <stable+bounces-92897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97C9C6B12
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 10:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0352817A6
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 09:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438A189F2F;
	Wed, 13 Nov 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZEElo82"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE6517A589
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731488414; cv=none; b=JXemtWgI+CxaAJfCh5EQYXhdZnTFTU53UA6f/kRZsDi9Tz91essfbzPhIj7YKk1QrIycyZWNAMeXtC76UA+rZ9JWTpKPBvD0/6CYuAAQo2Gv/jIJcU8fT4i5AQ7w9ErCmzRpw0tgRn1cqOUQ+rfjk6tuZ1Q8pFCnOGI7zMz5SNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731488414; c=relaxed/simple;
	bh=RCpENxLGg6hnI3IRN41gi175JQ7tHgwieLMpiZsRYlo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XSNoVlQ+fG25LSHviUDE3/ZoSlpdoZljnkD26KBcEenNtI1Zj/jbw6GUky0DWhGb2PCbK8pmtMtwAtLpPpoVTfmQRthUZGHWp/Oiy2z90iaNQrd+9LwD/HrR1jh9iFPDD+JZunKOzqvY241NZqFPfiEQ0Yy2xGxvh/Yk54sZ+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZEElo82; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e5f86e59f1so3628709b6e.1
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731488411; x=1732093211; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TD2FxzxG5IX/cuY01pfkoKvDX6WI1qGIiCvDMRlDjtU=;
        b=QZEElo82SM0WifdDCsdPPerGPZfrSe97kSIf/F6LF/DjSwY60h7A46ogm7sruRZZy3
         8U9mkgsn+McV8pHQXTuLRpaTULLeACKUVISMqMHXjGi4mkOqc+OBwY1bvapFwTk3V1/L
         rQB/msaG8yiwj/3auF+6PjjhQpO10u+h/qozLa1LsTY1HdDPtD0aBNeSSBZb1YCaHgAS
         zwIXGk5Z7wpwsAlLy7vIKmdvY8HJBHfKiwlAmWtTOvViEsgCwPC+4+/FmCKOVdj6CEHd
         cP6LLyJL1eW/h+0YNcLXIEiW26x1Xj/4eqCRiwIlSNy6KX7zU7O2nVSCN4Gbofb7sU+q
         hvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731488411; x=1732093211;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD2FxzxG5IX/cuY01pfkoKvDX6WI1qGIiCvDMRlDjtU=;
        b=ADyv5xIPfCcN95Yo7LcXcdUTVlEqfgrIMWvYf2q9YaBkd3oQWwt9bvYIC2iqQc7ybo
         wvCsToA3l1iR8yBTuNqC3Omv4a2+gKUf0I3UDqonHgD05AAO50VZjyFJYyhV3s/IgroO
         CdDMrS2BMwVUkHpFE1qKv8xzx1xktP0QK7e7B++ym9xIF8oFBFrc1xpoSnbVrI/K7KvJ
         khBF8OpRa62U9rnrhib4OALHJP6h64kyfmrvLYb9hVIrT4FMSjP5jE1BWuUuz9aE7grt
         dto1j9GJf01YBTa4eiT+yM0qDYhiFS1CjK61SJlHpHIJC4pnXwj1iCiFaN/3eVZpS6i/
         NUHA==
X-Forwarded-Encrypted: i=1; AJvYcCV7S77v+CheDO9ws23VvRulxkHqcUNhUGz3O2fkr5hypC0ol5rJEjgBa8kq2quYkBgw79i68uM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6570hr89zeT4NZThVaoF96kkZ42DjwOmjyowYCi7m1QGPWvdC
	H5n73/g80tLS0Eccv35AVbaCPLkiRRnN+AXADMdkh2L99eaxIVvXbKcLVTTVZg==
X-Google-Smtp-Source: AGHT+IEsX/HuDj6IAYphGQR5pUFRb6X+2JJgfSrNgi5GM5hkd5i0GRWhNXaSFECHIOTJ73IVqvMHUA==
X-Received: by 2002:a05:6808:c5:b0:3e7:b3ce:923 with SMTP id 5614622812f47-3e7b3ce0a32mr435893b6e.23.1731488410592;
        Wed, 13 Nov 2024 01:00:10 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7b0955aa4sm400350b6e.2.2024.11.13.01.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:00:09 -0800 (PST)
Date: Wed, 13 Nov 2024 00:59:53 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: gregkh@linuxfoundation.org
cc: hughd@google.com, akpm@linux-foundation.org, baohua@kernel.org, 
    baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
    hannes@cmpxchg.org, kirill.shutemov@linux.intel.com, nphamcs@gmail.com, 
    richard.weiyang@gmail.com, ryan.roberts@arm.com, shakeel.butt@linux.dev, 
    shy828301@gmail.com, stable@vger.kernel.org, usamaarif642@gmail.com, 
    wangkefeng.wang@huawei.com, willy@infradead.org, ziy@nvidia.com
Subject: Re: FAILED: patch "[PATCH] mm/thp: fix deferred split unqueue naming
 and locking" failed to apply to 6.6-stable tree
In-Reply-To: <2024111106-employer-bulgur-4f6d@gregkh>
Message-ID: <bcd65dea-5dfe-7d55-68bb-4a7031ebaccf@google.com>
References: <2024111106-employer-bulgur-4f6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-453050288-1731488408=:3621"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-453050288-1731488408=:3621
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Nov 2024, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x f8f931bba0f92052cf842b7e30917b1afcc77d5a
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111106-employer-bulgur-4f6d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Thanks for trying this: as expected, the v6.11 port was easy,
but earlier releases not.

I've probably spent more effort on this v6.6 version than it deserves,
and folks may not even like the result: though I am fairly satisfied
with it by now, and testing has shown no problems.

If I do go on to do v6.1 and earlier (not immediately), I won't approach
them in this way, but just do minimal patches to fix mem_cgroup_move_charge
and mem_cgroup_swapout (mem_cgroup_migrate was safe until v6.7).

There's a tarball attached, containing the series of six backports needed
(three clean, three differing slightly from the originals).  But let me
put inline below a squash of those six, so it's easier for all on Cc to
see what it amounts to without extracting the tarball.  Based on v6.6.60,
no conflict with v6.6.61-rc1

[PATCH] mm/thp: fix deferred split unqueue naming and locking

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

Upstream commit itself does not apply cleanly, because there
are fewer calls to folio_undo_large_rmappable() in this tree
(in particular, folio migration does not migrate memcg charge),
and mm/memcontrol-v1.c has not been split out of mm/memcontrol.c.

This single commit is merged from upstream commits:
23e4883248f0 ("mm: add page_rmappable_folio() wrapper")
ec056cef76a5 ("mm/readahead: do not allow order-1 folio")
8897277acfef ("mm: support order-1 folios in the page cache")
b7b098cf00a2 ("mm: always initialise folio->_deferred_list")
593a10dabe08 ("mm: refactor folio_undo_large_rmappable()")
f8f931bba0f9 ("mm/thp: fix deferred split unqueue naming and locking")
With list_del_init() replacing list_del() like in:
c010d47f107f ("mm: thp: split huge page to any lower order pages")
9bcef5973e31 ("mm: memcg: fix split queue list crash when large folio migration")

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/filemap.c     |  2 --
 mm/huge_memory.c | 59 ++++++++++++++++++++++++++++++------------------
 mm/hugetlb.c     |  1 +
 mm/internal.h    | 27 +++++++++++++++++++++-
 mm/memcontrol.c  | 29 ++++++++++++++++++++++++
 mm/mempolicy.c   | 17 +++-----------
 mm/page_alloc.c  | 21 +++++++----------
 mm/readahead.c   | 11 +++------
 8 files changed, 107 insertions(+), 60 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e6c112f3a211..66cdd4545b77 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1957,8 +1957,6 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
-			if (order == 1)
-				order = 0;
 			if (order > 0)
 				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
 			folio = filemap_alloc_folio(alloc_gfp, order);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7b4cb5c68b61..635f0f0f6860 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -569,8 +569,8 @@ struct deferred_split *get_deferred_split_queue(struct folio *folio)
 
 void folio_prep_large_rmappable(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
-	INIT_LIST_HEAD(&folio->_deferred_list);
+	if (!folio || !folio_test_large(folio))
+		return;
 	folio_set_large_rmappable(folio);
 }
 
@@ -2720,9 +2720,10 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	spin_lock(&ds_queue->split_queue_lock);
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
-		if (!list_empty(&folio->_deferred_list)) {
+		if (folio_order(folio) > 1 &&
+		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
-			list_del(&folio->_deferred_list);
+			list_del_init(&folio->_deferred_list);
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
@@ -2766,26 +2767,38 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	return ret;
 }
 
-void folio_undo_large_rmappable(struct folio *folio)
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
 
-	/*
-	 * At this point, there is no one trying to add the folio to
-	 * deferred_list. If folio is not in deferred_list, it's safe
-	 * to check without acquiring the split_queue_lock.
-	 */
-	if (data_race(list_empty(&folio->_deferred_list)))
-		return;
+	WARN_ON_ONCE(folio_ref_count(folio));
+	WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));
 
 	ds_queue = get_deferred_split_queue(folio);
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
-		list_del(&folio->_deferred_list);
+		list_del_init(&folio->_deferred_list);
+		unqueued = true;
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+
+	return unqueued;	/* useful for debug warnings */
 }
 
 void deferred_split_folio(struct folio *folio)
@@ -2796,17 +2809,19 @@ void deferred_split_folio(struct folio *folio)
 #endif
 	unsigned long flags;
 
-	VM_BUG_ON_FOLIO(folio_order(folio) < 2, folio);
+	/*
+	 * Order 1 folios have no space for a deferred list, but we also
+	 * won't waste much memory by not adding them to the deferred list.
+	 */
+	if (folio_order(folio) <= 1)
+		return;
 
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
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0acb04c3e952..92b955cc5a41 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1795,6 +1795,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		destroy_compound_gigantic_folio(folio, huge_page_order(h));
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
+		INIT_LIST_HEAD(&folio->_deferred_list);
 		__free_pages(&folio->page, huge_page_order(h));
 	}
 }
diff --git a/mm/internal.h b/mm/internal.h
index ef8d787a510c..b30907537801 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -413,7 +413,30 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 #endif
 }
 
-void folio_undo_large_rmappable(struct folio *folio);
+bool __folio_unqueue_deferred_split(struct folio *folio);
+static inline bool folio_unqueue_deferred_split(struct folio *folio)
+{
+	if (folio_order(folio) <= 1 || !folio_test_large_rmappable(folio))
+		return false;
+
+	/*
+	 * At this point, there is no one trying to add the folio to
+	 * deferred_list. If folio is not in deferred_list, it's safe
+	 * to check without acquiring the split_queue_lock.
+	 */
+	if (data_race(list_empty(&folio->_deferred_list)))
+		return false;
+
+	return __folio_unqueue_deferred_split(folio);
+}
+
+static inline struct folio *page_rmappable_folio(struct page *page)
+{
+	struct folio *folio = (struct folio *)page;
+
+	folio_prep_large_rmappable(folio);
+	return folio;
+}
 
 static inline void prep_compound_head(struct page *page, unsigned int order)
 {
@@ -423,6 +446,8 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
+	if (order > 1)
+		INIT_LIST_HEAD(&folio->_deferred_list);
 }
 
 static inline void prep_compound_tail(struct page *head, int tail_idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 110afda740a1..d2ceadd11b10 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5873,6 +5873,8 @@ static int mem_cgroup_move_account(struct page *page,
 	css_get(&to->css);
 	css_put(&from->css);
 
+	/* Warning should never happen, so don't worry about refcount non-0 */
+	WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
 	folio->memcg_data = (unsigned long)to;
 
 	__folio_memcg_unlock(from);
@@ -6237,7 +6239,10 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 	enum mc_target_type target_type;
 	union mc_target target;
 	struct page *page;
+	struct folio *folio;
+	bool tried_split_before = false;
 
+retry_pmd:
 	ptl = pmd_trans_huge_lock(pmd, vma);
 	if (ptl) {
 		if (mc.precharge < HPAGE_PMD_NR) {
@@ -6247,6 +6252,28 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
 		target_type = get_mctgt_type_thp(vma, addr, *pmd, &target);
 		if (target_type == MC_TARGET_PAGE) {
 			page = target.page;
+			folio = page_folio(page);
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
+			 * page_remove_rmap() will find it still pmdmapped.
+			 */
 			if (isolate_lru_page(page)) {
 				if (!mem_cgroup_move_account(page, true,
 							     mc.from, mc.to)) {
@@ -7199,6 +7226,7 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
+		WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
 		folio->memcg_data = 0;
 	}
 
@@ -7492,6 +7520,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	VM_BUG_ON_FOLIO(oldid, folio);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
+	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
 
 	if (!mem_cgroup_is_root(memcg))
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4cae854c0f28..109826a2af38 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2200,10 +2200,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		mpol_cond_put(pol);
 		gfp |= __GFP_COMP;
 		page = alloc_page_interleave(gfp, order, nid);
-		folio = (struct folio *)page;
-		if (folio && order > 1)
-			folio_prep_large_rmappable(folio);
-		goto out;
+		return page_rmappable_folio(page);
 	}
 
 	if (pol->mode == MPOL_PREFERRED_MANY) {
@@ -2213,10 +2210,7 @@ struct folio *vma_alloc_folio(gfp_t gfp, int order, struct vm_area_struct *vma,
 		gfp |= __GFP_COMP;
 		page = alloc_pages_preferred_many(gfp, order, node, pol);
 		mpol_cond_put(pol);
-		folio = (struct folio *)page;
-		if (folio && order > 1)
-			folio_prep_large_rmappable(folio);
-		goto out;
+		return page_rmappable_folio(page);
 	}
 
 	if (unlikely(IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && hugepage)) {
@@ -2310,12 +2304,7 @@ EXPORT_SYMBOL(alloc_pages);
 
 struct folio *folio_alloc(gfp_t gfp, unsigned order)
 {
-	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
-	struct folio *folio = (struct folio *)page;
-
-	if (folio && order > 1)
-		folio_prep_large_rmappable(folio);
-	return folio;
+	return page_rmappable_folio(alloc_pages(gfp | __GFP_COMP, order));
 }
 EXPORT_SYMBOL(folio_alloc);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1bbbf2f8b7e4..7272a922b838 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -600,9 +600,7 @@ void destroy_large_folio(struct folio *folio)
 		return;
 	}
 
-	if (folio_test_large_rmappable(folio))
-		folio_undo_large_rmappable(folio);
-
+	folio_unqueue_deferred_split(folio);
 	mem_cgroup_uncharge(folio);
 	free_the_page(&folio->page, folio_order(folio));
 }
@@ -1002,10 +1000,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 		}
 		break;
 	case 2:
-		/*
-		 * the second tail page: ->mapping is
-		 * deferred_list.next -- ignore value.
-		 */
+		/* the second tail page: deferred_list overlaps ->mapping */
+		if (unlikely(!list_empty(&folio->_deferred_list))) {
+			bad_page(page, "on deferred list");
+			goto out;
+		}
 		break;
 	default:
 		if (page->mapping != TAIL_MAPPING) {
@@ -4464,12 +4463,8 @@ struct folio *__folio_alloc(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask)
 {
 	struct page *page = __alloc_pages(gfp | __GFP_COMP, order,
-			preferred_nid, nodemask);
-	struct folio *folio = (struct folio *)page;
-
-	if (folio && order > 1)
-		folio_prep_large_rmappable(folio);
-	return folio;
+					preferred_nid, nodemask);
+	return page_rmappable_folio(page);
 }
 EXPORT_SYMBOL(__folio_alloc);
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 7c0449f8bec7..e9b11d928b0c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -514,16 +514,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		unsigned int order = new_order;
 
 		/* Align with smaller pages if needed */
-		if (index & ((1UL << order) - 1)) {
+		if (index & ((1UL << order) - 1))
 			order = __ffs(index);
-			if (order == 1)
-				order = 0;
-		}
 		/* Don't allocate pages past EOF */
-		while (index + (1UL << order) - 1 > limit) {
-			if (--order == 1)
-				order = 0;
-		}
+		while (index + (1UL << order) - 1 > limit)
+			order--;
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
 			break;
-- 
2.47.0.277.g8800431eea-goog

---1463770367-453050288-1731488408=:3621
Content-Type: application/x-tar; name=defsplitq.tar
Content-Transfer-Encoding: BASE64
Content-ID: <9ec290e1-9e54-3fde-aab0-26d59f8ff172@google.com>
Content-Description: 
Content-Disposition: attachment; filename=defsplitq.tar

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

---1463770367-453050288-1731488408=:3621--

