Return-Path: <stable+bounces-103981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3E79F0743
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7CC161F3E
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554001A01BE;
	Fri, 13 Dec 2024 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="oNtiZH5S"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC73157A6C;
	Fri, 13 Dec 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080962; cv=none; b=QedJKxqwFtfcbG9jCilTu+7uRISPF5THZ6qBccVqX4DalaYORUFZDA5cw4lmtcdtZpns+DuQXkSuVBIsjpBdKOebp9SCs/wqa61FU5vESt24rASwzG5YJVcDGal7H1lrVuiP9zsaFo2oqVbZGe5yAySkRPZK4dYKoN/PUl4/kJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080962; c=relaxed/simple;
	bh=p/kDpnOAmRuFrwuwWAmBCyskDVpa5M/lDVqr3+ucMis=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kWrrFOr418i+DCdux0mS9su5Mmfr/P6n8M5HP0msQzlNoZ2zLzrvuZSmfQw8T527RVA8IsSfhHf7pOOV9AJje/ac+oU1T2QGaM2NQy+/3Oz9pPRKsaQng5JF1ixETMxSjvO27UihiOL8wKD3mnfyrJYHEi/S8KWuv08BkxAy510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=oNtiZH5S; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=tZlbGahY/vZQF2ii+w
	yjY3Mp3aA9pSqBupXj4liHfDg=; b=oNtiZH5SL0WcRHrVKFYN6pvHfrqb6KqaOB
	OFXwroFWI1GAyXQpt5UC+EAStqJVJ6xw5veTQhwwxeZuAYydUxoJmLoRcOqX7/xt
	23f5ABq91jt6WhMHKYSA8DMoZoqAwv+Yb1svXQyXllFQG6EQv0Mra7wUoYlYkizU
	cnogHq34o=
Received: from hg-OptiPlex-7040.hygon.cn (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDHz7wu5FtnmTDGAA--.2052S2;
	Fri, 13 Dec 2024 15:37:18 +0800 (CST)
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
Subject: [PATCH] mm, compaction: don't use ALLOC_CMA in long term GUP flow
Date: Fri, 13 Dec 2024 15:37:12 +0800
Message-Id: <1734075432-14131-1-git-send-email-yangge1116@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID:_____wDHz7wu5FtnmTDGAA--.2052S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF4xCw1rXr1fXr4UCF17ZFb_yoWrXr1DpF
	4xA3WDAws8XFyYkr4kJw4v9F4Ykw4xGF45Gr92gw18uw1akFySv3Z7KFy7AFW5WryYya1Y
	qFWq93srAF43AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNLvKwUUUUU=
X-CM-SenderInfo: 51dqwwjhrrila6rslhhfrp/1tbiOge0G2db06TqnwAAss
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

To sum up, during long term GUP flow, we should remove ALLOC_CMA
both in __compaction_suitable() and __isolate_free_page().

Fixes: 984fdba6a32e ("mm, compaction: use proper alloc_flags in __compaction_suitable()")
Cc: <stable@vger.kernel.org>
Signed-off-by: yangge <yangge1116@126.com>
---
 mm/compaction.c | 8 +++++---
 mm/page_alloc.c | 4 +++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 07bd227..044c2247 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2384,6 +2384,7 @@ static bool __compaction_suitable(struct zone *zone, int order,
 				  unsigned long wmark_target)
 {
 	unsigned long watermark;
+	bool pin;
 	/*
 	 * Watermarks for order-0 must be met for compaction to be able to
 	 * isolate free pages for migration targets. This means that the
@@ -2395,14 +2396,15 @@ static bool __compaction_suitable(struct zone *zone, int order,
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
+	pin = !!(current->flags & PF_MEMALLOC_PIN);
 	return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
-				   ALLOC_CMA, wmark_target);
+				   pin ? 0 : ALLOC_CMA, wmark_target);
 }
 
 /*
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
 
-- 
2.7.4


