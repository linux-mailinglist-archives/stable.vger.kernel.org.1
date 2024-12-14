Return-Path: <stable+bounces-104171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B939F1D0C
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 07:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E7718879D3
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 06:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B19412C470;
	Sat, 14 Dec 2024 06:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="o7LkcPDa"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF2522F;
	Sat, 14 Dec 2024 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734158429; cv=none; b=sQ4YD7+surMzH1CR1nimRfff89kKuI+cWeSUYs/bACySUbXHs3Eh0Cg8JjR+pBJXw5Tx0mC21VIbb3xnvQ5JbjyUrdZW8yVCVbGpvI1syrTEJv+S3QRO8xnWGYHniI/5qBndKl5QTAlYmHnx/Jb9VDg2lMxCeX0BUKBbWMiv5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734158429; c=relaxed/simple;
	bh=A0eBcWQArwQLrfg8t0zZ0AtFF5oj0KFDRa6xoPxT6zo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bhm0sK4qpAtghMj609sCnMHuujkpUGn7bQwdsaOC08rkRP8VUbUMUE6TDgmxebBzu1L/aa4YsJllM3uTFAibp9OY1G+vQtm43gp37DlaBWcKvZgQ/2MifkzSRPgSu05NzCsSc5ZOZpBD5sAAJ8+4HmyREGVP7LXGJKpU8s27PxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=o7LkcPDa; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=YLxCN2Gesg12CJxR+/
	GXPQjMM9x70eFi/qCoE9PaI/w=; b=o7LkcPDav8oUYppbM2JA0u9rzgI03m9lI2
	PJDjHiK9GGCCqqvZbZ5uyFImiE9mAe87GlbSZPKuMTL2J1SETOD5De5RSxcCLTMo
	O8fE4Xawo6m5ynpxU84X2SFcZGB9pXhWhpF5ReOZ1VgeTzp2q7FQerxIyEcPrNOu
	8zpM47SnQ=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [118.242.3.34])
	by gzsmtp5 (Coremail) with SMTP id qSkvCgDnr_NuJF1n7VZTCQ--.7274S2;
	Sat, 14 Dec 2024 14:23:43 +0800 (CST)
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
Subject: [PATCH V2] mm, compaction: don't use ALLOC_CMA in long term GUP flow
Date: Sat, 14 Dec 2024 14:23:40 +0800
Message-Id: <1734157420-31110-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:qSkvCgDnr_NuJF1n7VZTCQ--.7274S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtry8Zr4kJrWUGr4xXr4fKrg_yoWxuF13pF
	18ZasFyws5XF13Gr48tF409a15tw4xGF18JryIgw1xZw1akFn2v3WkKFy7AF15XryayF4Y
	qFWq9ryDGFsxAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNLvKwUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbifgq1G2ddD3K5DQAAsp
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

V2:
- using the 'cc->alloc_flags' to determin if 'ALLOC_CMA' is needed
- rich the commit log description

 include/linux/compaction.h |  3 ++-
 mm/compaction.c            | 18 +++++++++++-------
 mm/page_alloc.c            |  4 +++-
 mm/vmscan.c                |  4 ++--
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index e947764..0c6f97a 100644
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
diff --git a/mm/compaction.c b/mm/compaction.c
index 07bd227..585f5ab 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2381,9 +2381,11 @@ static enum compact_result compact_finished(struct compact_control *cc)
 
 static bool __compaction_suitable(struct zone *zone, int order,
 				  int highest_zoneidx,
+				  unsigned int alloc_flags,
 				  unsigned long wmark_target)
 {
 	unsigned long watermark;
+	bool use_cma;
 	/*
 	 * Watermarks for order-0 must be met for compaction to be able to
 	 * isolate free pages for migration targets. This means that the
@@ -2395,25 +2397,27 @@ static bool __compaction_suitable(struct zone *zone, int order,
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
+	use_cma = !!(alloc_flags & ALLOC_CMA);
 	return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
-				   ALLOC_CMA, wmark_target);
+				   use_cma ? ALLOC_CMA : 0, wmark_target);
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
@@ -2474,7 +2478,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
-					  available))
+					  alloc_flags, available))
 			return true;
 	}
 
@@ -2499,7 +2503,7 @@ compaction_suit_allocation_order(struct zone *zone, unsigned int order,
 			      alloc_flags))
 		return COMPACT_SUCCESS;
 
-	if (!compaction_suitable(zone, order, highest_zoneidx))
+	if (!compaction_suitable(zone, order, highest_zoneidx, alloc_flags))
 		return COMPACT_SKIPPED;
 
 	return COMPACT_CONTINUE;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index dde19db..9a5dfda 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2813,6 +2813,7 @@ int __isolate_free_page(struct page *page, unsigned int order)
 {
 	struct zone *zone = page_zone(page);
 	int mt = get_pageblock_migratetype(page);
+	bool pin;
 
 	if (!is_migrate_isolate(mt)) {
 		unsigned long watermark;
@@ -2823,7 +2824,8 @@ int __isolate_free_page(struct page *page, unsigned int order)
 		 * exists.
 		 */
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
-		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
+		pin = !!(current->flags & PF_MEMALLOC_PIN);
+		if (!zone_watermark_ok(zone, 0, watermark, 0, pin ? 0 : ALLOC_CMA))
 			return 0;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5e03a61..806f031 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5815,7 +5815,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 				      sc->reclaim_idx, 0))
 			return false;
 
-		if (compaction_suitable(zone, sc->order, sc->reclaim_idx))
+		if (compaction_suitable(zone, sc->order, sc->reclaim_idx, 0))
 			return false;
 	}
 
@@ -6043,7 +6043,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 		return true;
 
 	/* Compaction cannot yet proceed. Do reclaim. */
-	if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
+	if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, 0))
 		return false;
 
 	/*
-- 
2.7.4


