Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E66C7BDE29
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376743AbjJINQe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376969AbjJINQa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:16:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B88DA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:16:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23922C433C8;
        Mon,  9 Oct 2023 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857387;
        bh=l5KwzhFKlfgnt5Z6FZ3jOspZpjEEJ4jAw7LrJcH6e6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wjku1yAED5/X11pkayySOEP9jHzY+WsNeQr+cnzf82Axk9yOl72rBysAWZ6VWY/K
         TyK5qt+6hyEtrZBDG2OtAiOxtZ4Q6HC4YRWsTyMrVD616mR0SAy8JOMD1D2WfJJXlG
         X8s8hRjN6nDfAy8wNeBoqX6Wzbj8cr8tOfL5VveM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/162] mm/page_alloc: leave IRQs enabled for per-cpu page allocations
Date:   Mon,  9 Oct 2023 15:00:11 +0200
Message-ID: <20231009130123.777053245@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mel Gorman <mgorman@techsingularity.net>

[ Upstream commit 5749077415994eb02d660b2559b9d8278521e73d ]

The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
allocating from the PCP must not re-enter the allocator from IRQ context.
In each instance where IRQ-reentrancy is possible, the lock is acquired
using pcp_spin_trylock_irqsave() even though IRQs are disabled and
re-entrancy is impossible.

Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the
common case at the cost of some IRQ allocations taking a slower path.  If
the PCP lists need to be refilled, the zone lock still needs to disable
IRQs but that will only happen on PCP refill and drain.  If an IRQ is
raised when a PCP allocation is in progress, the trylock will fail and
fallback to using the buddy lists directly.  Note that this may not be a
universal win if an interrupt-intensive workload also allocates heavily
from interrupt context and contends heavily on the zone->lock as a result.

[mgorman@techsingularity.net: migratetype might be wrong if a PCP was locked]
  Link: https://lkml.kernel.org/r/20221122131229.5263-2-mgorman@techsingularity.net
[yuzhao@google.com: reported lockdep issue on IO completion from softirq]
[hughd@google.com: fix list corruption, lock improvements, micro-optimsations]
Link: https://lkml.kernel.org/r/20221118101714.19590-3-mgorman@techsingularity.net
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 7b086755fb8c ("mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 124 +++++++++++++++++++++---------------------------
 1 file changed, 54 insertions(+), 70 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d94ac6d87bc97..90082f75660f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -170,21 +170,12 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 	_ret;								\
 })
 
-#define pcpu_spin_lock_irqsave(type, member, ptr, flags)		\
+#define pcpu_spin_trylock(type, member, ptr)				\
 ({									\
 	type *_ret;							\
 	pcpu_task_pin();						\
 	_ret = this_cpu_ptr(ptr);					\
-	spin_lock_irqsave(&_ret->member, flags);			\
-	_ret;								\
-})
-
-#define pcpu_spin_trylock_irqsave(type, member, ptr, flags)		\
-({									\
-	type *_ret;							\
-	pcpu_task_pin();						\
-	_ret = this_cpu_ptr(ptr);					\
-	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
+	if (!spin_trylock(&_ret->member)) {				\
 		pcpu_task_unpin();					\
 		_ret = NULL;						\
 	}								\
@@ -197,27 +188,16 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 	pcpu_task_unpin();						\
 })
 
-#define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
-({									\
-	spin_unlock_irqrestore(&ptr->member, flags);			\
-	pcpu_task_unpin();						\
-})
-
 /* struct per_cpu_pages specific helpers. */
 #define pcp_spin_lock(ptr)						\
 	pcpu_spin_lock(struct per_cpu_pages, lock, ptr)
 
-#define pcp_spin_lock_irqsave(ptr, flags)				\
-	pcpu_spin_lock_irqsave(struct per_cpu_pages, lock, ptr, flags)
-
-#define pcp_spin_trylock_irqsave(ptr, flags)				\
-	pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, ptr, flags)
+#define pcp_spin_trylock(ptr)						\
+	pcpu_spin_trylock(struct per_cpu_pages, lock, ptr)
 
 #define pcp_spin_unlock(ptr)						\
 	pcpu_spin_unlock(lock, ptr)
 
-#define pcp_spin_unlock_irqrestore(ptr, flags)				\
-	pcpu_spin_unlock_irqrestore(lock, ptr, flags)
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -1548,6 +1528,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 					struct per_cpu_pages *pcp,
 					int pindex)
 {
+	unsigned long flags;
 	int min_pindex = 0;
 	int max_pindex = NR_PCP_LISTS - 1;
 	unsigned int order;
@@ -1563,8 +1544,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	/* Ensure requested pindex is drained first. */
 	pindex = pindex - 1;
 
-	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
-	spin_lock(&zone->lock);
+	spin_lock_irqsave(&zone->lock, flags);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	while (count > 0) {
@@ -1612,7 +1592,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (count > 0 && !list_empty(list));
 	}
 
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
 static void free_one_page(struct zone *zone,
@@ -3126,10 +3106,10 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	unsigned long flags;
 	int i, allocated = 0;
 
-	/* Caller must hold IRQ-safe pcp->lock so IRQs are disabled. */
-	spin_lock(&zone->lock);
+	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
 								alloc_flags);
@@ -3163,7 +3143,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	 * pages added to the pcp list.
 	 */
 	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
-	spin_unlock(&zone->lock);
+	spin_unlock_irqrestore(&zone->lock, flags);
 	return allocated;
 }
 
@@ -3180,16 +3160,9 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0) {
-		unsigned long flags;
-
-		/*
-		 * free_pcppages_bulk expects IRQs disabled for zone->lock
-		 * so even though pcp->lock is not intended to be IRQ-safe,
-		 * it's needed in this context.
-		 */
-		spin_lock_irqsave(&pcp->lock, flags);
+		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		spin_unlock_irqrestore(&pcp->lock, flags);
+		spin_unlock(&pcp->lock);
 	}
 }
 #endif
@@ -3203,12 +3176,9 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	if (pcp->count) {
-		unsigned long flags;
-
-		/* See drain_zone_pages on why this is disabling IRQs */
-		spin_lock_irqsave(&pcp->lock, flags);
+		spin_lock(&pcp->lock);
 		free_pcppages_bulk(zone, pcp->count, pcp, 0);
-		spin_unlock_irqrestore(&pcp->lock, flags);
+		spin_unlock(&pcp->lock);
 	}
 }
 
@@ -3474,7 +3444,6 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
  */
 void free_unref_page(struct page *page, unsigned int order)
 {
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
@@ -3502,10 +3471,10 @@ void free_unref_page(struct page *page, unsigned int order)
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
 		free_unref_page_commit(zone, pcp, page, migratetype, order);
-		pcp_spin_unlock_irqrestore(pcp, flags);
+		pcp_spin_unlock(pcp);
 	} else {
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
 	}
@@ -3517,10 +3486,10 @@ void free_unref_page(struct page *page, unsigned int order)
  */
 void free_unref_page_list(struct list_head *list)
 {
+	unsigned long __maybe_unused UP_flags;
 	struct page *page, *next;
 	struct per_cpu_pages *pcp = NULL;
 	struct zone *locked_zone = NULL;
-	unsigned long flags;
 	int batch_count = 0;
 	int migratetype;
 
@@ -3548,21 +3517,36 @@ void free_unref_page_list(struct list_head *list)
 		struct zone *zone = page_zone(page);
 
 		list_del(&page->lru);
+		migratetype = get_pcppage_migratetype(page);
 
 		/* Different zone, different pcp lock. */
 		if (zone != locked_zone) {
-			if (pcp)
-				pcp_spin_unlock_irqrestore(pcp, flags);
+			if (pcp) {
+				pcp_spin_unlock(pcp);
+				pcp_trylock_finish(UP_flags);
+			}
 
+			/*
+			 * trylock is necessary as pages may be getting freed
+			 * from IRQ or SoftIRQ context after an IO completion.
+			 */
+			pcp_trylock_prepare(UP_flags);
+			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
+			if (unlikely(!pcp)) {
+				pcp_trylock_finish(UP_flags);
+				free_one_page(zone, page, page_to_pfn(page),
+					      0, migratetype, FPI_NONE);
+				locked_zone = NULL;
+				continue;
+			}
 			locked_zone = zone;
-			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
+			batch_count = 0;
 		}
 
 		/*
 		 * Non-isolated types over MIGRATE_PCPTYPES get added
 		 * to the MIGRATE_MOVABLE pcp list.
 		 */
-		migratetype = get_pcppage_migratetype(page);
 		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
 			migratetype = MIGRATE_MOVABLE;
 
@@ -3570,18 +3554,23 @@ void free_unref_page_list(struct list_head *list)
 		free_unref_page_commit(zone, pcp, page, migratetype, 0);
 
 		/*
-		 * Guard against excessive IRQ disabled times when we get
-		 * a large list of pages to free.
+		 * Guard against excessive lock hold times when freeing
+		 * a large list of pages. Lock will be reacquired if
+		 * necessary on the next iteration.
 		 */
 		if (++batch_count == SWAP_CLUSTER_MAX) {
-			pcp_spin_unlock_irqrestore(pcp, flags);
+			pcp_spin_unlock(pcp);
+			pcp_trylock_finish(UP_flags);
 			batch_count = 0;
-			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
+			pcp = NULL;
+			locked_zone = NULL;
 		}
 	}
 
-	if (pcp)
-		pcp_spin_unlock_irqrestore(pcp, flags);
+	if (pcp) {
+		pcp_spin_unlock(pcp);
+		pcp_trylock_finish(UP_flags);
+	}
 }
 
 /*
@@ -3782,15 +3771,11 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
 	struct page *page;
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 
-	/*
-	 * spin_trylock may fail due to a parallel drain. In the future, the
-	 * trylock will also protect against IRQ reentrancy.
-	 */
+	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp) {
 		pcp_trylock_finish(UP_flags);
 		return NULL;
@@ -3804,7 +3789,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
-	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
@@ -5375,7 +5360,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			struct page **page_array)
 {
 	struct page *page;
-	unsigned long flags;
 	unsigned long __maybe_unused UP_flags;
 	struct zone *zone;
 	struct zoneref *z;
@@ -5457,9 +5441,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	/* Is a parallel drain in progress? */
+	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp)
 		goto failed_irq;
 
@@ -5478,7 +5462,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
-				pcp_spin_unlock_irqrestore(pcp, flags);
+				pcp_spin_unlock(pcp);
 				goto failed_irq;
 			}
 			break;
@@ -5493,7 +5477,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	pcp_spin_unlock_irqrestore(pcp, flags);
+	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-- 
2.40.1



