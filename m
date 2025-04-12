Return-Path: <stable+bounces-132307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DE0A869D6
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 02:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAD98A4AD7
	for <lists+stable@lfdr.de>; Sat, 12 Apr 2025 00:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764003B1A4;
	Sat, 12 Apr 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nvcxy0iI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F189134D4;
	Sat, 12 Apr 2025 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744418018; cv=none; b=QiMPwxPQZ/Qj5QZPSwkJD0VblfcVdYVVvyiWIgFlK3INuT5O8i8BuaZvyZGMoQV/sPr6iA0DzrcAkl5IZSPqwu33gVTt4McMK5C9AxaL6re6exD3J0TTqs4WRf0GOWvvGGe9eNRRnwP9HKmBZdwQb/x4oKOvW5Rf9ND5Pz6awlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744418018; c=relaxed/simple;
	bh=Y/BgYprArmobohjfwYyE2fdHt3WHGHMfi8XEPkyzuWI=;
	h=Date:To:From:Subject:Message-Id; b=QNnu8ZlOVr9tLg4B1FRQPt2EK1j4tLw+Xv/432h2bZ+ODNEhcz2eCVdGo+nU3U5C9Vy3d+epaHFUSud8JKKcnQ8juaa/JByWK5Z1Z7ByDg3WJhcjDVpS9tVIp8h9nMtX42JhXZwCmdBrhl3Ae2KJq7IHoiQrOmCAXAfr7sfZgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nvcxy0iI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60ABC4CEE2;
	Sat, 12 Apr 2025 00:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1744418017;
	bh=Y/BgYprArmobohjfwYyE2fdHt3WHGHMfi8XEPkyzuWI=;
	h=Date:To:From:Subject:From;
	b=Nvcxy0iIcAXGsCSf0epyRVONEV9qh7GtEjEdh+d8JD2fRf3OMXFXIfMxc8N9RhXn4
	 jnjWVY82Ms3ueJp9tjVoRlXa0KgTONXfIefHX5N3gDnr687Qn/L1BZvfyY5ZqJPLhV
	 W8sfVvSKkReWiDbCY+tv3kMB0BEQp1aGVp6ZIETg=
Date: Fri, 11 Apr 2025 17:33:37 -0700
To: mm-commits@vger.kernel.org,ziy@nvidia.com,vbabka@suse.cz,stable@vger.kernel.org,shivankg@amd.com,oliver.sang@intel.com,jackmanb@google.com,carlos.song@nxp.com,hannes@cmpxchg.org,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-page_alloc-speed-up-fallbacks-in-rmqueue_bulk.patch removed from -mm tree
Message-Id: <20250412003337.D60ABC4CEE2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm: page_alloc: speed up fallbacks in rmqueue_bulk()
has been removed from the -mm tree.  Its filename was
     mm-page_alloc-speed-up-fallbacks-in-rmqueue_bulk.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Johannes Weiner <hannes@cmpxchg.org>
Subject: mm: page_alloc: speed up fallbacks in rmqueue_bulk()
Date: Mon, 7 Apr 2025 14:01:53 -0400

The test robot identified c2f6ea38fc1b ("mm: page_alloc: don't steal
single pages from biggest buddy") as the root cause of a 56.4% regression
in vm-scalability::lru-file-mmap-read.

Carlos reports an earlier patch, c0cd6f557b90 ("mm: page_alloc: fix
freelist movement during block conversion"), as the root cause for a
regression in worst-case zone->lock+irqoff hold times.

Both of these patches modify the page allocator's fallback path to be less
greedy in an effort to stave off fragmentation.  The flip side of this is
that fallbacks are also less productive each time around, which means the
fallback search can run much more frequently.

Carlos' traces point to rmqueue_bulk() specifically, which tries to refill
the percpu cache by allocating a large batch of pages in a loop.  It
highlights how once the native freelists are exhausted, the fallback code
first scans orders top-down for whole blocks to claim, then falls back to
a bottom-up search for the smallest buddy to steal.  For the next batch
page, it goes through the same thing again.

This can be made more efficient.  Since rmqueue_bulk() holds the
zone->lock over the entire batch, the freelists are not subject to outside
changes; when the search for a block to claim has already failed, there is
no point in trying again for the next page.

Modify __rmqueue() to remember the last successful fallback mode, and
restart directly from there on the next rmqueue_bulk() iteration.

Oliver confirms that this improves beyond the regression that the test
robot reported against c2f6ea38fc1b:

commit:
  f3b92176f4 ("tools/selftests: add guard region test for /proc/$pid/pagemap")
  c2f6ea38fc ("mm: page_alloc: don't steal single pages from biggest buddy")
  acc4d5ff0b ("Merge tag 'net-6.15-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
  2c847f27c3 ("mm: page_alloc: speed up fallbacks in rmqueue_bulk()")   <--- your patch

f3b92176f4f7100f c2f6ea38fc1b640aa7a2e155cc1 acc4d5ff0b61eb1715c498b6536 2c847f27c37da65a93d23c237c5
---------------- --------------------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \          |                \
  25525364 ±  3%     -56.4%   11135467           -57.8%   10779336           +31.6%   33581409        vm-scalability.throughput

Carlos confirms that worst-case times are almost fully recovered
compared to before the earlier culprit patch:

  2dd482ba627d (before freelist hygiene):    1ms
  c0cd6f557b90  (after freelist hygiene):   90ms
 next-20250319    (steal smallest buddy):  280ms
    this patch                          :    8ms

[jackmanb@google.com: comment updates]
  Link: https://lkml.kernel.org/r/D92AC0P9594X.3BML64MUKTF8Z@google.com
[hannes@cmpxchg.org: reset rmqueue_mode in rmqueue_buddy() error loop, per Yunsheng Lin]
  Link: https://lkml.kernel.org/r/20250409140023.GA2313@cmpxchg.org
Link: https://lkml.kernel.org/r/20250407180154.63348-1-hannes@cmpxchg.org
Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block conversion")
Fixes: c2f6ea38fc1b ("mm: page_alloc: don't steal single pages from biggest buddy")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Carlos Song <carlos.song@nxp.com>
Tested-by: Carlos Song <carlos.song@nxp.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503271547.fc08b188-lkp@intel.com
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>	[6.10+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/page_alloc.c |  113 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 79 insertions(+), 34 deletions(-)

--- a/mm/page_alloc.c~mm-page_alloc-speed-up-fallbacks-in-rmqueue_bulk
+++ a/mm/page_alloc.c
@@ -2183,23 +2183,15 @@ try_to_claim_block(struct zone *zone, st
 }
 
 /*
- * Try finding a free buddy page on the fallback list.
- *
- * This will attempt to claim a whole pageblock for the requested type
- * to ensure grouping of such requests in the future.
- *
- * If a whole block cannot be claimed, steal an individual page, regressing to
- * __rmqueue_smallest() logic to at least break up as little contiguity as
- * possible.
+ * Try to allocate from some fallback migratetype by claiming the entire block,
+ * i.e. converting it to the allocation's start migratetype.
  *
  * The use of signed ints for order and current_order is a deliberate
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
- *
- * Return the stolen page, or NULL if none can be found.
  */
 static __always_inline struct page *
-__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
+__rmqueue_claim(struct zone *zone, int order, int start_migratetype,
 						unsigned int alloc_flags)
 {
 	struct free_area *area;
@@ -2237,14 +2229,29 @@ __rmqueue_fallback(struct zone *zone, in
 		page = try_to_claim_block(zone, page, current_order, order,
 					  start_migratetype, fallback_mt,
 					  alloc_flags);
-		if (page)
-			goto got_one;
+		if (page) {
+			trace_mm_page_alloc_extfrag(page, order, current_order,
+						    start_migratetype, fallback_mt);
+			return page;
+		}
 	}
 
-	if (alloc_flags & ALLOC_NOFRAGMENT)
-		return NULL;
+	return NULL;
+}
+
+/*
+ * Try to steal a single page from some fallback migratetype. Leave the rest of
+ * the block as its current migratetype, potentially causing fragmentation.
+ */
+static __always_inline struct page *
+__rmqueue_steal(struct zone *zone, int order, int start_migratetype)
+{
+	struct free_area *area;
+	int current_order;
+	struct page *page;
+	int fallback_mt;
+	bool claim_block;
 
-	/* No luck claiming pageblock. Find the smallest fallback page */
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
@@ -2254,25 +2261,28 @@ __rmqueue_fallback(struct zone *zone, in
 
 		page = get_page_from_free_area(area, fallback_mt);
 		page_del_and_expand(zone, page, order, current_order, fallback_mt);
-		goto got_one;
+		trace_mm_page_alloc_extfrag(page, order, current_order,
+					    start_migratetype, fallback_mt);
+		return page;
 	}
 
 	return NULL;
-
-got_one:
-	trace_mm_page_alloc_extfrag(page, order, current_order,
-		start_migratetype, fallback_mt);
-
-	return page;
 }
 
+enum rmqueue_mode {
+	RMQUEUE_NORMAL,
+	RMQUEUE_CMA,
+	RMQUEUE_CLAIM,
+	RMQUEUE_STEAL,
+};
+
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
 static __always_inline struct page *
 __rmqueue(struct zone *zone, unsigned int order, int migratetype,
-						unsigned int alloc_flags)
+	  unsigned int alloc_flags, enum rmqueue_mode *mode)
 {
 	struct page *page;
 
@@ -2291,16 +2301,48 @@ __rmqueue(struct zone *zone, unsigned in
 		}
 	}
 
-	page = __rmqueue_smallest(zone, order, migratetype);
-	if (unlikely(!page)) {
-		if (alloc_flags & ALLOC_CMA)
+	/*
+	 * First try the freelists of the requested migratetype, then try
+	 * fallbacks modes with increasing levels of fragmentation risk.
+	 *
+	 * The fallback logic is expensive and rmqueue_bulk() calls in
+	 * a loop with the zone->lock held, meaning the freelists are
+	 * not subject to any outside changes. Remember in *mode where
+	 * we found pay dirt, to save us the search on the next call.
+	 */
+	switch (*mode) {
+	case RMQUEUE_NORMAL:
+		page = __rmqueue_smallest(zone, order, migratetype);
+		if (page)
+			return page;
+		fallthrough;
+	case RMQUEUE_CMA:
+		if (alloc_flags & ALLOC_CMA) {
 			page = __rmqueue_cma_fallback(zone, order);
-
-		if (!page)
-			page = __rmqueue_fallback(zone, order, migratetype,
-						  alloc_flags);
+			if (page) {
+				*mode = RMQUEUE_CMA;
+				return page;
+			}
+		}
+		fallthrough;
+	case RMQUEUE_CLAIM:
+		page = __rmqueue_claim(zone, order, migratetype, alloc_flags);
+		if (page) {
+			/* Replenished preferred freelist, back to normal mode. */
+			*mode = RMQUEUE_NORMAL;
+			return page;
+		}
+		fallthrough;
+	case RMQUEUE_STEAL:
+		if (!(alloc_flags & ALLOC_NOFRAGMENT)) {
+			page = __rmqueue_steal(zone, order, migratetype);
+			if (page) {
+				*mode = RMQUEUE_STEAL;
+				return page;
+			}
+		}
 	}
-	return page;
+	return NULL;
 }
 
 /*
@@ -2312,6 +2354,7 @@ static int rmqueue_bulk(struct zone *zon
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
 	unsigned long flags;
 	int i;
 
@@ -2323,7 +2366,7 @@ static int rmqueue_bulk(struct zone *zon
 	}
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+					      alloc_flags, &rmqm);
 		if (unlikely(page == NULL))
 			break;
 
@@ -2948,7 +2991,9 @@ struct page *rmqueue_buddy(struct zone *
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
+			enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
+
+			page = __rmqueue(zone, order, migratetype, alloc_flags, &rmqm);
 
 			/*
 			 * If the allocation fails, allow OOM handling and
_

Patches currently in -mm which might be from hannes@cmpxchg.org are

mm-page_alloc-tighten-up-find_suitable_fallback.patch


