Return-Path: <stable+bounces-104307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C6E9F2978
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 06:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BC41885A36
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 05:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313EE19644B;
	Mon, 16 Dec 2024 05:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tFLv2l8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756C101DE;
	Mon, 16 Dec 2024 05:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734326398; cv=none; b=U+9GtUDVRyLf3YvaD3fanwpgQkIYiJLwPtwWecOhrpV7C1/nymgzr6aFhCTBVLsRXm7xQiJ7l4cvsGjhcYYMAMBhm4OeFWn4F79WBUK1n5KGVo91UA1gWRQ20k+Rw5s3QOfz70K/5MjZ+x2bJOGesVnizsseg0gujbEkIMhQQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734326398; c=relaxed/simple;
	bh=icacqnachTe38ZTd6yONyOo/ht5NIHsCSc4yyu7t3EI=;
	h=Date:To:From:Subject:Message-Id; b=ewoPpkK2uBkPnSzg0PH8CLEL2kXxhTlVshuz0YwU6dKPQacPtIGj5rq4g86YXZunuxRwMiGB7/iNXmrW6SySBvvhGy2huEEKFB1b9BZl1Qo7GxEzQMEaeX0PCiYWQzFbohb3CACiV3d7quvurrCddqfR9R5YRwwqJIv/7aUu4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tFLv2l8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F2AC4CED0;
	Mon, 16 Dec 2024 05:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734326398;
	bh=icacqnachTe38ZTd6yONyOo/ht5NIHsCSc4yyu7t3EI=;
	h=Date:To:From:Subject:From;
	b=tFLv2l8w/MxfXz3X87bntof5ANXjAkdWsDEtqX0+uzFwDJFUOlK7aX4rwswWJJQCa
	 ZO0vI0klUbla/jygut5y3ZWSSdhB36F4HSByiF60r6uelOM6D/2cMgD3yAJnnwyGUO
	 EeY+yCWC5gessg8h84jUcOqOoz1zp7MRgfGOghI0=
Date: Sun, 15 Dec 2024 21:19:57 -0800
To: mm-commits@vger.kernel.org,vbabka@suse.cz,stable@vger.kernel.org,david@redhat.com,baolin.wang@linux.alibaba.com,yangge1116@126.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow.patch added to mm-hotfixes-unstable branch
Message-Id: <20241216051958.10F2AC4CED0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm, compaction: don't use ALLOC_CMA in long term GUP flow
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: yangge <yangge1116@126.com>
Subject: mm, compaction: don't use ALLOC_CMA in long term GUP flow
Date: Sun, 15 Dec 2024 18:01:07 +0800

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

For costly allocations, because __compaction_suitable() always returns
true, __alloc_pages_slowpath() can't exit at the appropriate place,
resulting in excessively long virtual machine startup times.

Call trace:
__alloc_pages_slowpath
    if (compact_result == COMPACT_SKIPPED ||
        compact_result == COMPACT_DEFERRED)
        goto nopage; // should exit __alloc_pages_slowpath() from here

In order to quickly fall back to remote node, we should remove ALLOC_CMA
both in __compaction_suitable() and __isolate_free_page() in long term GUP
flow.  After this fix, starting a 32GB virtual machine with device
passthrough takes only a few seconds.

Link: https://lkml.kernel.org/r/1734256867-19614-1-git-send-email-yangge1116@126.com
Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
Signed-off-by: yangge <yangge1116@126.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/compaction.h |    6 ++++--
 mm/compaction.c            |   18 +++++++++++-------
 mm/page_alloc.c            |    4 +++-
 mm/vmscan.c                |    4 ++--
 4 files changed, 20 insertions(+), 12 deletions(-)

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
@@ -2379,9 +2379,11 @@ static enum compact_result compact_finis
 
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
@@ -2393,25 +2395,27 @@ static bool __compaction_suitable(struct
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
@@ -2472,7 +2476,7 @@ bool compaction_zonelist_suitable(struct
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
-					  available))
+					  alloc_flags, available))
 			return true;
 	}
 
@@ -2497,7 +2501,7 @@ compaction_suit_allocation_order(struct
 			      alloc_flags))
 		return COMPACT_SUCCESS;
 
-	if (!compaction_suitable(zone, order, highest_zoneidx))
+	if (!compaction_suitable(zone, order, highest_zoneidx, alloc_flags))
 		return COMPACT_SKIPPED;
 
 	return COMPACT_CONTINUE;
--- a/mm/page_alloc.c~mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow
+++ a/mm/page_alloc.c
@@ -2812,6 +2812,7 @@ int __isolate_free_page(struct page *pag
 {
 	struct zone *zone = page_zone(page);
 	int mt = get_pageblock_migratetype(page);
+	bool pin;
 
 	if (!is_migrate_isolate(mt)) {
 		unsigned long watermark;
@@ -2822,7 +2823,8 @@ int __isolate_free_page(struct page *pag
 		 * exists.
 		 */
 		watermark = zone->_watermark[WMARK_MIN] + (1UL << order);
-		if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
+		pin = !!(current->flags & PF_MEMALLOC_PIN);
+		if (!zone_watermark_ok(zone, 0, watermark, 0, pin ? 0 : ALLOC_CMA))
 			return 0;
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

mm-compaction-dont-use-alloc_cma-in-long-term-gup-flow.patch


