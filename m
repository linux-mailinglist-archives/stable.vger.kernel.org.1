Return-Path: <stable+bounces-104274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9649F230D
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329FF165DC2
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77481145A18;
	Sun, 15 Dec 2024 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="KcNv0AL4"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF76B20322;
	Sun, 15 Dec 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734256907; cv=none; b=N1oZq+KVL8oa0Z5HwkwrrUbOypjRtTItxXhp6Xl+fU7yvn8JB9rC/EedLSGpu5b9DqqmT2GIwJbUF2P/WO7h0JvZCCCQXajGXlRnL0NNs0NQStGS9zfbcJjsvWEHOEqrlWQwAKKbqq0JXuNMxoeObNVTnLBYZ2fDecrOuen6hMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734256907; c=relaxed/simple;
	bh=NWZeH2tix5ArRjTz/EBMRfZUjTwXtz2F1fqWBC6RkVQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XHT91AYtaJOQXH2+wCEEMvLYwXStw6eePwXUvjX9BZUEAvWJuWUfDHfUQRxdgYwfP5aT4C0Q1jMhtjI1yb42Xb1iMVivNxTzywdkBTZRkKso9HgdCbtWiBzHzB+y0VJT0bEgws15ydCuFvacNIK6ee3nGjGyFxb66ZuJF6ePqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=KcNv0AL4; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=E2givfVT7WoQ/zZbJF
	GmioUFY0A/62R2IIhwhOxB6+w=; b=KcNv0AL4MjbfTxxU3dyjLbxiQY5c2jSB5u
	VYscjGIbDNBAA0H0xmfDeAEWb3H0DO0So0vhTM6/L9iJhsi0ovoBubzQTfxZ629z
	3KapyBJUwJ0VKl4HiuCXGri8m8VLS9jiy7GAzwmevzAeozva2aNEcOXsvUx/aPFb
	ngHoqzmPY=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXbn3kqF5njZLWAQ--.23908S2;
	Sun, 15 Dec 2024 18:01:09 +0800 (CST)
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
Subject: [PATCH V4] mm, compaction: don't use ALLOC_CMA in long term GUP flow
Date: Sun, 15 Dec 2024 18:01:07 +0800
Message-Id: <1734256867-19614-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wBXbn3kqF5njZLWAQ--.23908S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtry8Zr4kJrWUGr4xCr1kuFg_yoW3Jw45pF
	18Za4Yy395XF13GrW8tF409a1Yqw4xGF18JryIgw1xZw1akFn2v3WkKFy7AF15XryYyF4Y
	qFWq9ryDGFsxAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNAp5UUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOhO2G2deopcx1AAAst
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

V4:
- rich the commit log description

V3:
- fix build errors
- add ALLOC_CMA both in should_continue_reclaim() and compaction_ready()

V2:
- using the 'cc->alloc_flags' to determin if 'ALLOC_CMA' is needed
- rich the commit log description

 include/linux/compaction.h |  6 ++++--
 mm/compaction.c            | 18 +++++++++++-------
 mm/page_alloc.c            |  4 +++-
 mm/vmscan.c                |  4 ++--
 4 files changed, 20 insertions(+), 12 deletions(-)

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


