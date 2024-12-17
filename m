Return-Path: <stable+bounces-105036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9869F55B6
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2627C18888C0
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1171F7570;
	Tue, 17 Dec 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gzAfsk9T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9450276;
	Tue, 17 Dec 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459035; cv=none; b=q5XxoV/H23MPwMWsdQSn21t59eoLBDI/7CyBc6xcrL2jg5rhUEFF4Qg5UZz8TfidEfuldjk7tF9YPdZA/mzUPkOmzkFUXgYEdfJB/C0R9RSDO//Vqce5io3MVjwEtU5Cgdb7bOkQy1XPMhgVgcBwvn2Wk/BlMT2m58eF77ezNiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459035; c=relaxed/simple;
	bh=WqjYjLvahSA74JL5n2xqMHBnFhQcImTwsMWvYSbYqy0=;
	h=Date:To:From:Subject:Message-Id; b=kduku4hZc7z67xI8aeTeEYEsJXiQHsxJ7ERKJ9kXTp1/Dwc6xibhk8q9vdOTMjNZtR9CW/fgYw1wWTCKIRakflbzzaw3Bju2v7LKUBnW2ncUwOvJkZmB/wDw8AvLFzBaK2m8mn3RAs6a2A5WL6MR1FewCz6HIQaL46ePGLgwyYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gzAfsk9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45719C4CED3;
	Tue, 17 Dec 2024 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734459035;
	bh=WqjYjLvahSA74JL5n2xqMHBnFhQcImTwsMWvYSbYqy0=;
	h=Date:To:From:Subject:From;
	b=gzAfsk9TGkeuny5k7GF4Ru1mDo8h5qhCcpJ+4m22HjpKzTAHocnKcJ51eg1KY3b5d
	 XRgN5TCVOGZhCyQSCiVxjLOLHH4ZKpKKgYLq8qaZIAXnrA4z+b8+lejhc2Y7eGsTmd
	 Bs6YgD0qRitvo+nqLybh3v7SHZq2wxEeXoyUCn6I=
Date: Tue, 17 Dec 2024 10:10:34 -0800
To: mm-commits@vger.kernel.org,vbabka@suse.cz,stable@vger.kernel.org,david@redhat.com,baolin.wang@linux.alibaba.com,yangge1116@126.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow.patch removed from -mm tree
Message-Id: <20241217181035.45719C4CED3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm, compaction: don't use ALLOC_CMA in long term GUP flow
has been removed from the -mm tree.  Its filename was
     mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: yangge <yangge1116@126.com>
Subject: mm, compaction: don't use ALLOC_CMA in long term GUP flow
Date: Mon, 16 Dec 2024 19:54:04 +0800

Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags in
__compaction_suitable()") allow compaction to proceed when free pages
required for compaction reside in the CMA pageblocks, it's possible that
__compaction_suitable() always returns true, and in some cases, it's not
acceptable.

There are 4 NUMA nodes on my machine, and each NUMA node has 32GB of
memory.  I have configured 16GB of CMA memory on each NUMA node, and
starting a 32GB virtual machine with device passthrough is extremely slow,
taking almost an hour.

During the start-up of the virtual machine, it will call
pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.  Long
term GUP cannot allocate memory from CMA area, so a maximum of 16 GB of
no-CMA memory on a NUMA node can be used as virtual machine memory.  Since
there is 16G of free CMA memory on the NUMA node, watermark for order-0
always be met for compaction, so __compaction_suitable() always returns
true, even if the node is unable to allocate non-CMA memory for the
virtual machine.

For costly allocations, because __compaction_suitable() always
returns true, __alloc_pages_slowpath() can't exit at the appropriate
place, resulting in excessively long virtual machine startup times.
Call trace:
__alloc_pages_slowpath
    if (compact_result == COMPACT_SKIPPED ||
        compact_result == COMPACT_DEFERRED)
        goto nopage; // should exit __alloc_pages_slowpath() from here

In order to quickly fall back to remote node, we should remove ALLOC_CMA
both in __compaction_suitable() and __isolate_free_page() in long term GUP
flow.  After this fix, starting a 32GB virtual machine with device
passthrough takes only a few seconds.

Link: https://lkml.kernel.org/r/1734350044-12928-1-git-send-email-yangge1116@126.com
Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
Signed-off-by: yangge <yangge1116@126.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/compaction.h |    6 ++++--
 mm/compaction.c            |   20 +++++++++++---------
 mm/internal.h              |    3 ++-
 mm/page_alloc.c            |    6 ++++--
 mm/page_isolation.c        |    3 ++-
 mm/page_reporting.c        |    2 +-
 mm/vmscan.c                |    4 ++--
 7 files changed, 26 insertions(+), 18 deletions(-)

--- a/include/linux/compaction.h~mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow
+++ a/include/linux/compaction.h
@@ -90,7 +90,8 @@ extern enum compact_result try_to_compac
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern bool compaction_suitable(struct zone *zone, int order,
-					       int highest_zoneidx);
+					       int highest_zoneidx,
+					       unsigned int alloc_flags);
 
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
@@ -108,7 +109,8 @@ static inline void reset_isolation_suita
 }
 
 static inline bool compaction_suitable(struct zone *zone, int order,
-						      int highest_zoneidx)
+						      int highest_zoneidx,
+						      unsigned int alloc_flags)
 {
 	return false;
 }
--- a/mm/compaction.c~mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow
+++ a/mm/compaction.c
@@ -654,7 +654,7 @@ static unsigned long isolate_freepages_b
 
 		/* Found a free page, will break it into order-0 pages */
 		order = buddy_order(page);
-		isolated = __isolate_free_page(page, order);
+		isolated = __isolate_free_page(page, order, cc->alloc_flags);
 		if (!isolated)
 			break;
 		set_page_private(page, order);
@@ -1633,7 +1633,7 @@ static void fast_isolate_freepages(struc
 
 		/* Isolate the page if available */
 		if (page) {
-			if (__isolate_free_page(page, order)) {
+			if (__isolate_free_page(page, order, cc->alloc_flags)) {
 				set_page_private(page, order);
 				nr_isolated = 1 << order;
 				nr_scanned += nr_isolated - 1;
@@ -2379,6 +2379,7 @@ static enum compact_result compact_finis
 
 static bool __compaction_suitable(struct zone *zone, int order,
 				  int highest_zoneidx,
+				  unsigned int alloc_flags,
 				  unsigned long wmark_target)
 {
 	unsigned long watermark;
@@ -2393,25 +2394,26 @@ static bool __compaction_suitable(struct
 	 * even if compaction succeeds.
 	 * For costly orders, we require low watermark instead of min for
 	 * compaction to proceed to increase its chances.
-	 * ALLOC_CMA is used, as pages in CMA pageblocks are considered
-	 * suitable migration targets
+	 * In addition to long term GUP flow, ALLOC_CMA is used, as pages in
+	 * CMA pageblocks are considered suitable migration targets
 	 */
 	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
 				low_wmark_pages(zone) : min_wmark_pages(zone);
 	watermark += compact_gap(order);
 	return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
-				   ALLOC_CMA, wmark_target);
+				   alloc_flags & ALLOC_CMA, wmark_target);
 }
 
 /*
  * compaction_suitable: Is this suitable to run compaction on this zone now?
  */
-bool compaction_suitable(struct zone *zone, int order, int highest_zoneidx)
+bool compaction_suitable(struct zone *zone, int order, int highest_zoneidx,
+				   unsigned int alloc_flags)
 {
 	enum compact_result compact_result;
 	bool suitable;
 
-	suitable = __compaction_suitable(zone, order, highest_zoneidx,
+	suitable = __compaction_suitable(zone, order, highest_zoneidx, alloc_flags,
 					 zone_page_state(zone, NR_FREE_PAGES));
 	/*
 	 * fragmentation index determines if allocation failures are due to
@@ -2472,7 +2474,7 @@ bool compaction_zonelist_suitable(struct
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
-					  available))
+					  alloc_flags, available))
 			return true;
 	}
 
@@ -2497,7 +2499,7 @@ compaction_suit_allocation_order(struct
 			      alloc_flags))
 		return COMPACT_SUCCESS;
 
-	if (!compaction_suitable(zone, order, highest_zoneidx))
+	if (!compaction_suitable(zone, order, highest_zoneidx, alloc_flags))
 		return COMPACT_SKIPPED;
 
 	return COMPACT_CONTINUE;
--- a/mm/internal.h~mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow
+++ a/mm/internal.h
@@ -662,7 +662,8 @@ static inline void clear_zone_contiguous
 	zone->contiguous = false;
 }
 
-extern int __isolate_free_page(struct page *page, unsigned int order);
+extern int __isolate_free_page(struct page *page, unsigned int order,
+				    unsigned int alloc_flags);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
--- a/mm/page_alloc.c~mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow
+++ a/mm/page_alloc.c
@@ -2808,7 +2808,8 @@ void split_page(struct page *page, unsig
 }
 EXPORT_SYMBOL_GPL(split_page);
 
-int __isolate_free_page(struct page *page, unsigned int order)
+int __isolate_free_page(struct page *page, unsigned int order,
+				   unsigned int alloc_flags)
 {
 	struct zone *zone = page_zone(page);
 	int mt = get_pageblock_migratetype(page);
@@ -2822,7 +2823,8 @@ int __isolate_free_page(struct page *pag
 		 * exists.
 		 */
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
-		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
+		if (!zone_watermark_ok(zone, 0, watermark, 0,
+			    alloc_flags & ALLOC_CMA))
 			return 0;
 	}
 
--- a/mm/page_isolation.c~mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow
+++ a/mm/page_isolation.c
@@ -229,7 +229,8 @@ static void unset_migratetype_isolate(st
 			buddy = find_buddy_page_pfn(page, page_to_pfn(page),
 						    order, NULL);
 			if (buddy && !is_migrate_isolate_page(buddy)) {
-				isolated_page = !!__isolate_free_page(page, order);
+				isolated_page = !!__isolate_free_page(page, order,
+						    ALLOC_CMA);
 				/*
 				 * Isolating a free page in an isolated pageblock
 				 * is expected to always work as watermarks don't
--- a/mm/page_reporting.c~mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow
+++ a/mm/page_reporting.c
@@ -198,7 +198,7 @@ page_reporting_cycle(struct page_reporti
 
 		/* Attempt to pull page from list and place in scatterlist */
 		if (*offset) {
-			if (!__isolate_free_page(page, order)) {
+			if (!__isolate_free_page(page, order, ALLOC_CMA)) {
 				next = page;
 				break;
 			}
--- a/mm/vmscan.c~mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow
+++ a/mm/vmscan.c
@@ -5861,7 +5861,7 @@ static inline bool should_continue_recla
 				      sc->reclaim_idx, 0))
 			return false;
 
-		if (compaction_suitable(zone, sc->order, sc->reclaim_idx))
+		if (compaction_suitable(zone, sc->order, sc->reclaim_idx, ALLOC_CMA))
 			return false;
 	}
 
@@ -6089,7 +6089,7 @@ static inline bool compaction_ready(stru
 		return true;
 
 	/* Compaction cannot yet proceed. Do reclaim. */
-	if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
+	if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, ALLOC_CMA))
 		return false;
 
 	/*
_

Patches currently in -mm which might be from yangge1116@126.com are



