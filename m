Return-Path: <stable+bounces-142877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF24FAAFF53
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26CA3BB782
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9572798F6;
	Thu,  8 May 2025 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="kXvO07Mo"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEC277816
	for <stable@vger.kernel.org>; Thu,  8 May 2025 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718445; cv=none; b=pmnnQXFDFmeXSvA/IPTVxvUDxNQznKX/iEe6apWLVVmVVXnf4PvhoTb8Z/Moo3XGB1G7E7RY+Y+DUiCy0fsqaduzPhhiqJ2JeNw8yIVi/Vr+ucdkLioggumQz7YTrAdMEll/eu1GxSb/V04+irjxJPUo4gF+AC4f1LIyXeJOHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718445; c=relaxed/simple;
	bh=6tCcvoAREYNkPpUNAUPnXQQmCHKVj6aoDo+Y5fFQXSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egYy4MHXrepQwjr8fRk3z1/l/Ob4qNjge58KnymQYQwntIje8pGhTi3VwBzbyzyeg5FZJD9JZYHwCBenrAoLlCg5rBSpRFlqmPOYMf3B6I8fXK9HecGGVAs0B9s/8SnseqgGMBkFzTM2m3mLaGgqgWT8jwQz0ICDB101A55DgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=kXvO07Mo; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-7c5a88b34a6so123934885a.3
        for <stable@vger.kernel.org>; Thu, 08 May 2025 08:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746718440; x=1747323240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4daCCaodGjx+skYNAp4vPXzztHBB45eDPLPsC20XZIU=;
        b=kXvO07MomsiOlRpZZdfHjk9EDS92mBGyXwQizo6Si3M7decG7VfAKgg3ChGea5qhUh
         w4hb428PZTA9DWnYsXJdRAYUmkVgdPMhvUvFhIwUQlcrTXajCH+aeF5d5sYrjCjkv6E2
         nsqzZfbJoeeDK+TKphu0Dr5+ohAHAG8ZnmbMzwzB+X5WlTEym0yoambiNHoAQLtXphsJ
         GRg4k7HQKvjobCi0jDPcasbtT+hYfYg5pRsTYCpoTsMWyAAI6//RbACb8Wr6MgENCBQU
         yf3hMmjR8+J//tBhYlgcVrRKsFRE10UMlfnEt1E5Bm/qciMioqkVlO7suITdxH2s4vul
         EoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746718440; x=1747323240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4daCCaodGjx+skYNAp4vPXzztHBB45eDPLPsC20XZIU=;
        b=Z2ahGdrCWTaUQIDSfgocdb1yumuP8nVLpBPUKnHQDP60Vu2fI9sWG68pIyMA0RL2QC
         YZ+RIsxOX3LNB4G4zuKOzmGwmOQY/l15PvP6kkzoMtQaKZbDlBhCZhBbFogehh34gqyV
         JNWQJcYCkD+rV8/HMx1QtZdge7bbIXEJIAkQzZc/AxZ6i7q/yycE5MK4I8VhBIHekCMe
         uhigDE59eJWrp304/Effuf5oG1EZTonIK4t1u6Es/cq47DdDJX6HHrm5iwyXY4QzbVqe
         W7V6wqTrXf5k4RhGzuwOgbYzgwX9R1m9ljoEcH3w8tUPaK8a5FWMgaLBD++U+TzUv0T6
         W9hQ==
X-Gm-Message-State: AOJu0YyerxKHKE0rArmtVGl72jokCYOniX9X6s7Uz/tE4We6dCAVDSvD
	eifPWOMVm7bDhQwvqCUuMlHSO12uBiL2lMQ6tRcb3uD/f03E0EnxyLD3or2AWKbJ5nQCB4YPHXH
	LqM8KKQ==
X-Gm-Gg: ASbGncvPowqVSvIkL5P74GVBjobK2s4ysjV6/1kaGKFQ0DoNBdI0ksv8B/xQQXCTCJW
	WitT0YKIva0xMoElL2dZOLckg/X4jqs8koFmPKLdyHkQe2rGNEApHZ7sNxoshVn+74pMHOvtW59
	SH9G70EfPwYi9aAhlZfOoDyHXv9Cj5S1uwCskQtCEu13lOP1fi1WrZyt7vPnTOndqwgl+MchErU
	y4gQA5GVYWmebZfwkcjSXAZNWjZ1vmolx/mGf27EiAUl34aIkMRuRkHSmFtrUqM3bJitnsSjnU3
	T3wqTwAQR8wMLy0EmZ+zTlx9MJl3cLSH9ztwGqk=
X-Google-Smtp-Source: AGHT+IFf//z1WyutxmaWnCXpCydsc6+3UDBFV2zdG8DHmAMScANPEYoqUIQ4Ps4ncqn2zw/DUxNptA==
X-Received: by 2002:a05:620a:f12:b0:7c7:bb3f:fd40 with SMTP id af79cd13be357-7cd010d01b3mr19459285a.5.1746718439952;
        Thu, 08 May 2025 08:33:59 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd00f98908sm5958785a.52.2025.05.08.08.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:33:59 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.14.y 1/2] mm: page_alloc: don't steal single pages from biggest buddy
Date: Thu,  8 May 2025 11:33:53 -0400
Message-ID: <20250508153354.396788-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042149-busily-amaretto-e684@gregkh>
References: <2025042149-busily-amaretto-e684@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fallback code searches for the biggest buddy first in an attempt to
steal the whole block and encourage type grouping down the line.

The approach used to be this:

- Non-movable requests will split the largest buddy and steal the
  remainder. This splits up contiguity, but it allows subsequent
  requests of this type to fall back into adjacent space.

- Movable requests go and look for the smallest buddy instead. The
  thinking is that movable requests can be compacted, so grouping is
  less important than retaining contiguity.

c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block
conversion") enforces freelist type hygiene, which restricts stealing to
either claiming the whole block or just taking the requested chunk; no
additional pages or buddy remainders can be stolen any more.

The patch mishandled when to switch to finding the smallest buddy in that
new reality.  As a result, it may steal the exact request size, but from
the biggest buddy.  This causes fracturing for no good reason.

Fix this by committing to the new behavior: either steal the whole block,
or fall back to the smallest buddy.

Remove single-page stealing from steal_suitable_fallback().  Rename it to
try_to_steal_block() to make the intentions clear.  If this fails, always
fall back to the smallest buddy.

The following is from 4 runs of mmtest's thpchallenge.  "Pollute" is
single page fallback, "steal" is conversion of a partially used block.
The numbers for free block conversions (omitted) are comparable.

				     vanilla	      patched

@pollute[unmovable from reclaimable]:	  27		  106
@pollute[unmovable from movable]:	  82		   46
@pollute[reclaimable from unmovable]:	 256		   83
@pollute[reclaimable from movable]:	  46		    8
@pollute[movable from unmovable]:	4841		  868
@pollute[movable from reclaimable]:	5278		12568

@steal[unmovable from reclaimable]:	  11		   12
@steal[unmovable from movable]:		 113		   49
@steal[reclaimable from unmovable]:	  19		   34
@steal[reclaimable from movable]:	  47		   21
@steal[movable from unmovable]:		 250		  183
@steal[movable from reclaimable]:	  81		   93

The allocator appears to do a better job at keeping stealing and polluting
to the first fallback preference.  As a result, the numbers for "from
movable" - the least preferred fallback option, and most detrimental to
compactability - are down across the board.

Link: https://lkml.kernel.org/r/20250225001023.1494422-2-hannes@cmpxchg.org
Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block conversion")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit c2f6ea38fc1b640aa7a2e155cc1c0410ff91afa2)
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 80 +++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 46 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 542d25f77be8..6f6c18336cad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1908,13 +1908,12 @@ static inline bool boost_watermark(struct zone *zone)
  * can claim the whole pageblock for the requested migratetype. If not, we check
  * the pageblock for constituent pages; if at least half of the pages are free
  * or compatible, we can still claim the whole block, so pages freed in the
- * future will be put on the correct free list. Otherwise, we isolate exactly
- * the order we need from the fallback block and leave its migratetype alone.
+ * future will be put on the correct free list.
  */
 static struct page *
-steal_suitable_fallback(struct zone *zone, struct page *page,
-			int current_order, int order, int start_type,
-			unsigned int alloc_flags, bool whole_block)
+try_to_steal_block(struct zone *zone, struct page *page,
+		   int current_order, int order, int start_type,
+		   unsigned int alloc_flags)
 {
 	int free_pages, movable_pages, alike_pages;
 	unsigned long start_pfn;
@@ -1927,7 +1926,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	 * highatomic accounting.
 	 */
 	if (is_migrate_highatomic(block_type))
-		goto single_page;
+		return NULL;
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
@@ -1948,14 +1947,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
 		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
 
-	/* We are not allowed to try stealing from the whole block */
-	if (!whole_block)
-		goto single_page;
-
 	/* moving whole block can fail due to zone boundary conditions */
 	if (!prep_move_freepages_block(zone, page, &start_pfn, &free_pages,
 				       &movable_pages))
-		goto single_page;
+		return NULL;
 
 	/*
 	 * Determine how many pages are compatible with our allocation.
@@ -1988,9 +1983,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
-single_page:
-	page_del_and_expand(zone, page, order, current_order, block_type);
-	return page;
+	return NULL;
 }
 
 /*
@@ -2172,14 +2165,19 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 }
 
 /*
- * Try finding a free buddy page on the fallback list and put it on the free
- * list of requested migratetype, possibly along with other pages from the same
- * block, depending on fragmentation avoidance heuristics. Returns true if
- * fallback was found so that __rmqueue_smallest() can grab it.
+ * Try finding a free buddy page on the fallback list.
+ *
+ * This will attempt to steal a whole pageblock for the requested type
+ * to ensure grouping of such requests in the future.
+ *
+ * If a whole block cannot be stolen, regress to __rmqueue_smallest()
+ * logic to at least break up as little contiguity as possible.
  *
  * The use of signed ints for order and current_order is a deliberate
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
+ *
+ * Return the stolen page, or NULL if none can be found.
  */
 static __always_inline struct page *
 __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
@@ -2213,45 +2211,35 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		if (fallback_mt == -1)
 			continue;
 
-		/*
-		 * We cannot steal all free pages from the pageblock and the
-		 * requested migratetype is movable. In that case it's better to
-		 * steal and split the smallest available page instead of the
-		 * largest available page, because even if the next movable
-		 * allocation falls back into a different pageblock than this
-		 * one, it won't cause permanent fragmentation.
-		 */
-		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
-					&& current_order > order)
-			goto find_smallest;
+		if (!can_steal)
+			break;
 
-		goto do_steal;
+		page = get_page_from_free_area(area, fallback_mt);
+		page = try_to_steal_block(zone, page, current_order, order,
+					  start_migratetype, alloc_flags);
+		if (page)
+			goto got_one;
 	}
 
-	return NULL;
+	if (alloc_flags & ALLOC_NOFRAGMENT)
+		return NULL;
 
-find_smallest:
+	/* No luck stealing blocks. Find the smallest fallback page */
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
 				start_migratetype, false, &can_steal);
-		if (fallback_mt != -1)
-			break;
-	}
-
-	/*
-	 * This should not happen - we already found a suitable fallback
-	 * when looking for the largest page.
-	 */
-	VM_BUG_ON(current_order > MAX_PAGE_ORDER);
+		if (fallback_mt == -1)
+			continue;
 
-do_steal:
-	page = get_page_from_free_area(area, fallback_mt);
+		page = get_page_from_free_area(area, fallback_mt);
+		page_del_and_expand(zone, page, order, current_order, fallback_mt);
+		goto got_one;
+	}
 
-	/* take off list, maybe claim block, expand remainder */
-	page = steal_suitable_fallback(zone, page, current_order, order,
-				       start_migratetype, alloc_flags, can_steal);
+	return NULL;
 
+got_one:
 	trace_mm_page_alloc_extfrag(page, order, current_order,
 		start_migratetype, fallback_mt);
 
-- 
2.49.0


