Return-Path: <stable+bounces-142903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0D5AB005E
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2248C1C26700
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5F627979F;
	Thu,  8 May 2025 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="GE2TfEJT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD327876E
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721473; cv=none; b=IoXsgDeM7krbXW3mPjTMymYYUr8KZDrwOjtoyFsK9+4gf9AYlo87i4nPxOXmy4i2CvbTDIfwXKe93qAximMmQRzcTnFG8GcvIRC4lMaKkJBYSIMeMl5V7o8JQiPR5c9V4qk4I0HJIz+QA5wZQfTCDKdrkD05DNQ5ipf7uVuCFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721473; c=relaxed/simple;
	bh=hWXxBgunOmkTJ2dh06RhjMs9qkioCzF7zc/vpb5A9Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux2+1QEKBKWuFeCw9iiZLY0lf8Owrn/e29xBCccYmEfp0gudL1HChS4g7d8Jn9kkjkNp/R2oBeySxV6PJC/aJf3+NhfYuDWBxYGlpaTdV1EoMpVKivkmCQZfbueRbeW3n+splxpUtQWRY9qMq2402kiws2iKEWFDzju85gyFR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=GE2TfEJT; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-7c54b651310so163247485a.0
        for <stable@vger.kernel.org>; Thu, 08 May 2025 09:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746721468; x=1747326268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXDeLks4UETEqO1B8MMUZkZFgU4qQ1kr1mfMNZUv0Xs=;
        b=GE2TfEJT/Gwm/DTUxifFS6gxPOn/Tw3wo5Y4CADtOKNAiXB0rBARgDlNo3XOCUzVzf
         k43nmETpY147KKZyIZUlfzhw/FHIsbOJB4R4peh2wTBGy4nzQyyUKK/7y2hwPWTKPO7Z
         6RP8t51SNkH3iGBtmYFPugTbq8QQLGBXE4qLtmFTorzBQ86oOg32ue1/LaQc3OmTFbR+
         AJb7eszDuWZ6j9uIbcSMDMCgjVbUUVvJv0C+OpwNzB2zBY/yzXLrWWJbOZbheus0rQxZ
         VwB7TFgEqiNrfTiJJ5+LRP/jUiAi4wt1sZdRbWO8lDn3A+XVgHJUizIEfiXl5BhB7l1X
         53QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746721468; x=1747326268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXDeLks4UETEqO1B8MMUZkZFgU4qQ1kr1mfMNZUv0Xs=;
        b=pFt2D3fbBy/y0MLfvTQuI3RQ/AaH5IqmdA2iJ1TF7u3EaYUGoUzsQemx0wb7+yBUcB
         0Uwd3kewCOKeAhSMAvX2TIIDJ1HfaBrJBiDtT1mkzPO/wT30DOtoTaNQH/ewBs7Q4vKD
         XMy1Pstjuz2cbrN3WynQQm6W+5B63XOjsPbcySUcko6IMMDxECshvMaGAFchHjenMZJp
         eA1o5efJ3JRBaIYBR62wo2s+qZr0vFBKa2cjYoAw0VWv6uoyUJ7O4fiiLwkKWfNv7691
         5N3+S4znhj1bV4Q5sDZA8lefrejaQtPkmT8mEq7Rg9E34qfNT5a3+jjwdfhqWCaXcwwq
         IwoQ==
X-Gm-Message-State: AOJu0YzNDXk9nAKKNdWJjK+Qodt1fA5bjoyYDwPCcx2waF4wiZZpiL+a
	AUcYwhwUoQvc3MfCYeyw1w51APj2QmCeWV3QVp0ziAlfn08wJSf3gpjvyeelEscMiJQet9VCJAd
	qADM3qg==
X-Gm-Gg: ASbGncsAVMWBmten9UseCoGPxgkfw+MPXa86rS3SIJngZeRjhGnTJY10fOTByNl6t8G
	udmxdxCmBKANDORZFsDlGWqz8n3UQOd92Ddm2FJ/0ezfqOEj6UPa1bvzOXUB29uDPYUMe42IS4T
	5dy1GSK6sgQbfnAoxKeoVTk1uDbWE63yvZcGx57FV/1y7RhUdcrM+vsBbZMqBRY5+Ih5gHaUL3B
	+fEoJMmdUrWtt/6SMxsOcUU2XekM/WlvK0dAE3yugEZj2CmAX7yKTF8WKj5sws1j2d7MTBlLogY
	W4HgIEomi+SNtATh5uE7c+LXNx2w4kAwi3UBveo=
X-Google-Smtp-Source: AGHT+IFnAK4RvVe2N43/XadF7O9OOACE3U3wHVU4uxWbeGbq0ZLv7UTSCkqwD0hpdRPDECx+5LAkCA==
X-Received: by 2002:a05:620a:318f:b0:7c5:4adb:781b with SMTP id af79cd13be357-7cd010d52bbmr51709785a.7.1746721467805;
        Thu, 08 May 2025 09:24:27 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd00f63c0fsm11552685a.32.2025.05.08.09.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:24:27 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: stable@vger.kernel.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y 1/2] mm: page_alloc: don't steal single pages from biggest buddy
Date: Thu,  8 May 2025 12:24:25 -0400
Message-ID: <20250508162426.427619-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042150-hardiness-hunting-0780@gregkh>
References: <2025042150-hardiness-hunting-0780@gregkh>
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
index fd4e0e1cd65e..bfc0139d2f45 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1907,13 +1907,12 @@ static inline bool boost_watermark(struct zone *zone)
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
@@ -1926,7 +1925,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 	 * highatomic accounting.
 	 */
 	if (is_migrate_highatomic(block_type))
-		goto single_page;
+		return NULL;
 
 	/* Take ownership for orders >= pageblock_order */
 	if (current_order >= pageblock_order) {
@@ -1947,14 +1946,10 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
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
@@ -1987,9 +1982,7 @@ steal_suitable_fallback(struct zone *zone, struct page *page,
 		return __rmqueue_smallest(zone, order, start_type);
 	}
 
-single_page:
-	page_del_and_expand(zone, page, order, current_order, block_type);
-	return page;
+	return NULL;
 }
 
 /*
@@ -2171,14 +2164,19 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
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
@@ -2212,45 +2210,35 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
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


