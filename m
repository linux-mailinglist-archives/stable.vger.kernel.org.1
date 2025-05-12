Return-Path: <stable+bounces-143526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404CAB402A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6FC19E701F
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB741DF72E;
	Mon, 12 May 2025 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0wkX9kkf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7E0245022;
	Mon, 12 May 2025 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072235; cv=none; b=W2tBi8P4Gazd6aIYBEZO+cv4JuXQtOzoJrO6afMNBpOTtLHPocTraWcktaFVSoE+7J05s7uFGYUtcWQVtIi35a9p+j1wWEYeYokMlmvg7UpzAmuh7YBN4nW0pFpDMDdELVOxCASN8ejmBwSxvup5PjXr4Zid7etrmTb/8zhtkpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072235; c=relaxed/simple;
	bh=frcxGWQfprTzoLE4/91BwW7ANSySnb+jF/9ac63oTiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ti3pzcoFw/JbdNS5Na8K91qDi3KA8TYq254/Si9cdxY9JM88BdE4ys+guzGclf5vVTbqjyShYiVf8kCHRjuZPO8PsFrhJs/4TlHnly4795lG+IB2cQO4gXDwrTRtDRckRyHKRKSeQP9U2bwrS0z6i/1mLlVi6rWZzV4VL072DOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0wkX9kkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E736C4CEE7;
	Mon, 12 May 2025 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072235;
	bh=frcxGWQfprTzoLE4/91BwW7ANSySnb+jF/9ac63oTiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0wkX9kkfPvZaj/N30lIaR6ytRVriqKPEQBo6BSJ4Y3H7voc/AQLLVUZ3adeAKzEk8
	 HhUCjyXoFdwkfiq2JOb0KlW3Zt3B//4OIBWjrR27l//PnGoJbtrjn4yrj2YB6UNywm
	 uvBoPnksJmZ/BTXsT3fjWuj3r9AzP3hDMeo1kpzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brendan Jackman <jackmanb@google.com>,
	kernel test robot <oliver.sang@intel.com>,
	Carlos Song <carlos.song@nxp.com>,
	Shivank Garg <shivankg@amd.com>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.14 177/197] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
Date: Mon, 12 May 2025 19:40:27 +0200
Message-ID: <20250512172051.593510038@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
References: <20250512172044.326436266@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Weiner <hannes@cmpxchg.org>

commit 90abee6d7895d5eef18c91d870d8168be4e76e9d upstream.

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
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page_alloc.c |  113 +++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 33 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2165,22 +2165,15 @@ static bool unreserve_highatomic_pageblo
 }
 
 /*
- * Try finding a free buddy page on the fallback list.
- *
- * This will attempt to steal a whole pageblock for the requested type
- * to ensure grouping of such requests in the future.
- *
- * If a whole block cannot be stolen, regress to __rmqueue_smallest()
- * logic to at least break up as little contiguity as possible.
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
@@ -2217,14 +2210,29 @@ __rmqueue_fallback(struct zone *zone, in
 		page = get_page_from_free_area(area, fallback_mt);
 		page = try_to_steal_block(zone, page, current_order, order,
 					  start_migratetype, alloc_flags);
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
+	bool can_steal;
 
-	/* No luck stealing blocks. Find the smallest fallback page */
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
@@ -2234,25 +2242,28 @@ __rmqueue_fallback(struct zone *zone, in
 
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
 
@@ -2271,16 +2282,49 @@ __rmqueue(struct zone *zone, unsigned in
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
+       switch (*mode) {
+       case RMQUEUE_NORMAL:
+               page = __rmqueue_smallest(zone, order, migratetype);
+               if (page)
+                       return page;
+               fallthrough;
+       case RMQUEUE_CMA:
+               if (alloc_flags & ALLOC_CMA) {
 			page = __rmqueue_cma_fallback(zone, order);
+			if (page) {
+				*mode = RMQUEUE_CMA;
+				return page;
+			}
+	       }
+	       fallthrough;
+       case RMQUEUE_CLAIM:
+	       page = __rmqueue_claim(zone, order, migratetype, alloc_flags);
+	       if (page) {
+                       /* Replenished preferred freelist, back to normal mode. */
+                       *mode = RMQUEUE_NORMAL;
+                       return page;
+               }
+               fallthrough;
+       case RMQUEUE_STEAL:
+               if (!(alloc_flags & ALLOC_NOFRAGMENT)) {
+                       page = __rmqueue_steal(zone, order, migratetype);
+                       if (page) {
+                               *mode = RMQUEUE_STEAL;
+                               return page;
+                       }
+               }
+       }
 
-		if (!page)
-			page = __rmqueue_fallback(zone, order, migratetype,
-						  alloc_flags);
-	}
-	return page;
+       return NULL;
 }
 
 /*
@@ -2292,13 +2336,14 @@ static int rmqueue_bulk(struct zone *zon
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
 	unsigned long flags;
 	int i;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+					      alloc_flags, &rmqm);
 		if (unlikely(page == NULL))
 			break;
 
@@ -2899,7 +2944,9 @@ struct page *rmqueue_buddy(struct zone *
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
+			enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
+
+			page = __rmqueue(zone, order, migratetype, alloc_flags, &rmqm);
 
 			/*
 			 * If the allocation fails, allow OOM handling and



