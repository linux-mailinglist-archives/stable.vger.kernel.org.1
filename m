Return-Path: <stable+bounces-104332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8E09F2FE1
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 12:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA21639B2
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F769204579;
	Mon, 16 Dec 2024 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="loZNMNdq"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B9204088;
	Mon, 16 Dec 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734350147; cv=none; b=g6zs/GvC6iO5M5PpJIxd/P1tgWlwg/RkPPN7cHwp6sBR2/M616AwDFfCYl0IlzOXJR5dJBkUyeR+kmjtu24Qb3JvMxlCInJUtejRUzfeHyhRbyx5FCwjjqmNj8h/mmW19BdC4lptN3uvvQ0HQ7k5WroAcwO/khm/MztEqzcFqyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734350147; c=relaxed/simple;
	bh=G5tUMqKyP1F13z/KdIHU03qX75lbfqEpYVMS8+8jhsY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YHxRCL5yFU8EI3LN2KdkGNS/dgd4eCt4+MJkcBjQZEh7XF3WJVEJ3E3fh5l0EvX10QesQgMr6UODrqoLIIrJpoit0fICkrcQDItbfqSx2dVgr7GzDRNmDJoEfHIIfOHld8Yl/VzOtz0YwNjxJjSmazGXpd7Jk84MCu6JcjQO6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=loZNMNdq; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=UKrvP/Ymp5jq0pAVdR
	g5jcH+ViqV5yReScKB+YOXh1Q=; b=loZNMNdqCCuwB8aZY3ZLIRV3eaFrX5LFHK
	lem8vfSFUYH/sSj/nVGDOzzRP1zkBPKbcbEXOxMGXVhZ/dzLgZYrjsrYd0c4jccv
	f8HpYsMn9TP0Qc6nGUBmfHX6CwolVv5+OhkgWqBF2IzwU4QnryrR2++PP3qg2zxX
	92s1wQHOs=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDHjwjdFGBnGCMaAg--.3044S2;
	Mon, 16 Dec 2024 19:54:06 +0800 (CST)
From: yangge1116@126.com
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	21cnbao@gmail.com,
	david@redhat.com,
	baolin.wang@linux.alibaba.com,
	vbabka@suse.cz,
	liuzixing@hygon.cn,
	yangge <yangge1116@126.com>
Subject: [PATCH V5] mm, compaction: don't use ALLOC_CMA in long term GUP flow
Date: Mon, 16 Dec 2024 19:54:04 +0800
Message-Id: <1734350044-12928-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDHjwjdFGBnGCMaAg--.3044S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtry8Zr4kJrWUGr4xCr1kuFg_yoWDGr18pF
	48X3WIy3yrX3W3CrW8JF4vv3WYqw4xGF48AryIgw18Zw13KF92v3Z7KFy7AFy5Wr95AFWY
	vFWqkrWkGFsxAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zKsj8bUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOgW3G2dgFFkEhwABsb
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: yangge <yangge1116@126.com>

Since commit 984fdba6a32e ("mm, compaction: use proper alloc_flags
in __compaction_suitable()") allow compaction to proceed when free
pages required for compaction reside in the CMA pageblocks, it's
possible that __compaction_suitable() always returns true, and in
some cases, it's not acceptable.

There are 4 NUMA nodes on my machine, and each NUMA node has 32GB
of memory. I have configured 16GB of CMA memory on each NUMA node,
and starting a 32GB virtual machine with device passthrough is
extremely slow, taking almost an hour.

During the start-up of the virtual machine, it will call
pin_user_pages_remote(..., FOLL_LONGTERM, ...) to allocate memory.
Long term GUP cannot allocate memory from CMA area, so a maximum
of 16 GB of no-CMA memory on a NUMA node can be used as virtual
machine memory. Since there is 16G of free CMA memory on the NUMA
node, watermark for order-0 always be met for compaction, so
__compaction_suitable() always returns true, even if the node is
unable to allocate non-CMA memory for the virtual machine.

For costly allocations, because __compaction_suitable() always
returns true, __alloc_pages_slowpath() can't exit at the appropriate
place, resulting in excessively long virtual machine startup times.
Call trace:
__alloc_pages_slowpath
    if (compact_result == COMPACT_SKIPPED ||
        compact_result == COMPACT_DEFERRED)
        goto nopage; // should exit __alloc_pages_slowpath() from here

In order to quickly fall back to remote node, we should remove
ALLOC_CMA both in __compaction_suitable() and __isolate_free_page()
in long term GUP flow. After this fix, starting a 32GB virtual machine
with device passthrough takes only a few seconds.

Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
Cc: <stable@vger.kernel.org>
Signed-off-by: yangge <yangge1116@126.com>
---

V5:
- add 'alloc_flags' parameter for __isolate_free_page()
- remove 'usa_cma' variable

V4:
- rich the commit log description

V3:
- fix build errors
- add ALLOC_CMA both in should_continue_reclaim() and compaction_ready()

V2:
- using the 'cc->alloc_flags' to determin if 'ALLOC_CMA' is needed
- rich the commit log description

 include/linux/compaction.h |  6 ++++--
 mm/compaction.c            | 20 +++++++++++---------
 mm/internal.h              |  3 ++-
 mm/page_alloc.c            |  6 ++++--
 mm/page_isolation.c        |  3 ++-
 mm/page_reporting.c        |  2 +-
 mm/vmscan.c                |  4 ++--
 7 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index e947764..b4c3ac3 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -90,7 +90,8 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern bool compaction_suitable(struct zone *zone, int order,
-					       int highest_zoneidx);
+					       int highest_zoneidx,
+					       unsigned int alloc_flags);
 
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
@@ -108,7 +109,8 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 }
 
 static inline bool compaction_suitable(struct zone *zone, int order,
-						      int highest_zoneidx)
+						      int highest_zoneidx,
+						      unsigned int alloc_flags)
 {
 	return false;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index 07bd227..b10d921 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -655,7 +655,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
 
 		/* Found a free page, will break it into order-0 pages */
 		order = buddy_order(page);
-		isolated = __isolate_free_page(page, order);
+		isolated = __isolate_free_page(page, order, cc->alloc_flags);
 		if (!isolated)
 			break;
 		set_page_private(page, order);
@@ -1634,7 +1634,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
 
 		/* Isolate the page if available */
 		if (page) {
-			if (__isolate_free_page(page, order)) {
+			if (__isolate_free_page(page, order, cc->alloc_flags)) {
 				set_page_private(page, order);
 				nr_isolated = 1 << order;
 				nr_scanned += nr_isolated - 1;
@@ -2381,6 +2381,7 @@ static enum compact_result compact_finished(struct compact_control *cc)
 
 static bool __compaction_suitable(struct zone *zone, int order,
 				  int highest_zoneidx,
+				  unsigned int alloc_flags,
 				  unsigned long wmark_target)
 {
 	unsigned long watermark;
@@ -2395,25 +2396,26 @@ static bool __compaction_suitable(struct zone *zone, int order,
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
@@ -2474,7 +2476,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
-					  available))
+					  alloc_flags, available))
 			return true;
 	}
 
@@ -2499,7 +2501,7 @@ compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 			      alloc_flags))
 		return COMPACT_SUCCESS;
 
-	if (!compaction_suitable(zone, order, highest_zoneidx))
+	if (!compaction_suitable(zone, order, highest_zoneidx, alloc_flags))
 		return COMPACT_SKIPPED;
 
 	return COMPACT_CONTINUE;
diff --git a/mm/internal.h b/mm/internal.h
index 3922788..6d257c8 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -662,7 +662,8 @@ static inline void clear_zone_contiguous(struct zone *zone)
 	zone->contiguous = false;
 }
 
-extern int __isolate_free_page(struct page *page, unsigned int order);
+extern int __isolate_free_page(struct page *page, unsigned int order,
+				    unsigned int alloc_flags);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(struct page *page, unsigned long pfn,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dde19db..ecb2fd7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2809,7 +2809,8 @@ void split_page(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(split_page);
 
-int __isolate_free_page(struct page *page, unsigned int order)
+int __isolate_free_page(struct page *page, unsigned int order,
+				   unsigned int alloc_flags)
 {
 	struct zone *zone = page_zone(page);
 	int mt = get_pageblock_migratetype(page);
@@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		 * exists.
 		 */
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
-		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
+		if (!zone_watermark_ok(zone, 0, watermark, 0,
+			    alloc_flags & ALLOC_CMA))
 			return 0;
 	}
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c608e9d..a1f2c79 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -229,7 +229,8 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 			buddy = find_buddy_page_pfn(page, page_to_pfn(page),
 						    order, NULL);
 			if (buddy && !is_migrate_isolate_page(buddy)) {
-				isolated_page = !!__isolate_free_page(page, order);
+				isolated_page = !!__isolate_free_page(page, order,
+						    ALLOC_CMA);
 				/*
 				 * Isolating a free page in an isolated pageblock
 				 * is expected to always work as watermarks don't
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index e4c428e..fd3813b 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -198,7 +198,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
 
 		/* Attempt to pull page from list and place in scatterlist */
 		if (*offset) {
-			if (!__isolate_free_page(page, order)) {
+			if (!__isolate_free_page(page, order, ALLOC_CMA)) {
 				next = page;
 				break;
 			}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5e03a61..33f5b46 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5815,7 +5815,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 				      sc->reclaim_idx, 0))
 			return false;
 
-		if (compaction_suitable(zone, sc->order, sc->reclaim_idx))
+		if (compaction_suitable(zone, sc->order, sc->reclaim_idx, ALLOC_CMA))
 			return false;
 	}
 
@@ -6043,7 +6043,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 		return true;
 
 	/* Compaction cannot yet proceed. Do reclaim. */
-	if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
+	if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, ALLOC_CMA))
 		return false;
 
 	/*
-- 
2.7.4


