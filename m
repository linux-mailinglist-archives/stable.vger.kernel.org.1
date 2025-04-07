Return-Path: <stable+bounces-128597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7168A7E940
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C081178384
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC60219A71;
	Mon,  7 Apr 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KnKOBp0t"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274DD2192E2
	for <stable@vger.kernel.org>; Mon,  7 Apr 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744048921; cv=none; b=Qq5EiSvlnjYyl+ruV3a6Mq6PXGMMoAtgdVLRw2UgHe9UCmLcOHcr1OpiiRpbS5CpHy2B/XVXwFnudEQpyG49bkXnQGp9rWsbnF6YhU93Qp+sx18A5F0k/pxFuRdh8cqDNSr1UEEqSZwfINMFYR70PWMeeP3gH5mqS2ao4DyXg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744048921; c=relaxed/simple;
	bh=OlubQZ/Pw1xCPoYgPf2Ou8I2Ct/l0oRNxp+u9ANWv+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rPAPY0uDw5AeXxvQ+U+lo0yoknmE1GHo8SzkxBTSkQoZ6ZgEd9SvN5XVUkFC2gj5HWFJTzkdtfL9y7vDAONRwjq8oLpmMyulsYFoZTVjVuS86bE08tIOzmxTfbpH8MA4ziCwXjgT6Ihd5aHGGxoRZ57xQInpQpuTlHXYUhJhPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KnKOBp0t; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8efefec89so41079076d6.3
        for <stable@vger.kernel.org>; Mon, 07 Apr 2025 11:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1744048917; x=1744653717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Vt8cqKYnz2MPMdOl9mwLikohokhtaGg2JyeHvDBS+M=;
        b=KnKOBp0tz14qvUqhJ/3dVfwNQIxC4ef2Yo74QbQO50eO3YijG64jHTENEzW20nizFY
         JBkuo1AVf6sbY87tUe6tI/qzPzzhrLjGj9KE3JWLcBh2WSJUT+arSeYoIkeAQQZB5HP8
         wMItP7c5SRkomCPLntOgYB2xOldbsB48OZ9klhcPwfhb34KaMeGhGSfElZD+9GjBBdXF
         dSo+4wog4C3aG3AY4Hp3EcJoWsM36U8tWOXMYnRJ8YbD1AstFO7Kj97WaRGDGrzOqNCn
         BglpFdSzvrAxytAQL+H2VKQv2wgvFOkWVRDsqDiva/4khMFE4z5h39d98NAXFKSfPqzc
         f8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744048917; x=1744653717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Vt8cqKYnz2MPMdOl9mwLikohokhtaGg2JyeHvDBS+M=;
        b=G39mLZ84L50npMYFz3Joz91Q7U+Cg2aF4mnURJXrhQRUdTrx/WRDtYmdo9p0MocQCt
         v2o2nVf8NCfxafpEWaTF6ia5nCjW/p34rM2aZMCkDg2nfnvqL4fz7CWyhh8lOIZY2rBM
         RN7wHC48CaX2r1Fd5I7w/5xYkcl/Ri13wzhgKBek0Iy6tlGfZszJsCXnq2mpTPkyIRX0
         NU3inSVMeAdV5VejnpXhd1uQbcuw5pyOWvqXXKFNxLrlixhQRLyaeQJhElr2ZAaSR9Ac
         yb6JgvvQZRvCNFXJtDwDRb6XLB9AhbW/D4b0GMi5Dtgua8sfPLus8J+VsmMx/bq8dSUM
         U/rA==
X-Forwarded-Encrypted: i=1; AJvYcCVat52EtySa7FNSqLJiflQ63sAZ4NJbQHYL1jJT9LQyYUKpyqwnUciTrpgyiOjB4M0pyXxcmLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySD7YusxnZvfd/CF9WLRW23vAK4pBf0sRLbHdLue9QyhJQvngv
	jdyoh8DscaOGrRBnKamrH07zowwvvznqpgx55sr61Qj4VcbqXE9IdRoNPUK9E5A=
X-Gm-Gg: ASbGncvDj6sXltsBUcT/gwr67G+1au2cbgv0Ju8Z4gaykskEkArXF1prXkr9SGwGjs/
	tul8ASqdcOZ3ZYyWwDKx7r5G9hVP3gpgV6b7BwFetE2qoGFNJmD4RpjH8+sPNepO8stb/hrEaaE
	N1h483ZITiO0B9NrnQBMJEHqUigR2lcR83dt0uJaCh+eOR21xOo2dHJ/uyenyX297zQSzk2qXaF
	hUBaVD1f7rElP27+S9iOoE+Tvqlscl63tdwu2KNbGr7px3ds6tpXgHTf6lifRncjhzKNNp3ZMGe
	Xa2I38VtxfSCfFhgaWzAYBFIjE7Hxh0b8930GjDiFOc=
X-Google-Smtp-Source: AGHT+IHfFCek/TyjJu8JV4kDrZVOMYWdBjD2hitXLlxQyYiBJ0cTlZewGMIdCZoA2TkopLyyoCy34g==
X-Received: by 2002:a05:6214:19c9:b0:6d4:1425:6d2d with SMTP id 6a1803df08f44-6f01e7e46dcmr204245356d6.43.1744048916738;
        Mon, 07 Apr 2025 11:01:56 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c76ea8304asm628078985a.103.2025.04.07.11.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:01:56 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Carlos Song <carlos.song@nxp.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
Date: Mon,  7 Apr 2025 14:01:53 -0400
Message-ID: <20250407180154.63348-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The test robot identified c2f6ea38fc1b ("mm: page_alloc: don't steal
single pages from biggest buddy") as the root cause of a 56.4%
regression in vm-scalability::lru-file-mmap-read.

Carlos reports an earlier patch, c0cd6f557b90 ("mm: page_alloc: fix
freelist movement during block conversion"), as the root cause for a
regression in worst-case zone->lock+irqoff hold times.

Both of these patches modify the page allocator's fallback path to be
less greedy in an effort to stave off fragmentation. The flip side of
this is that fallbacks are also less productive each time around,
which means the fallback search can run much more frequently.

Carlos' traces point to rmqueue_bulk() specifically, which tries to
refill the percpu cache by allocating a large batch of pages in a
loop. It highlights how once the native freelists are exhausted, the
fallback code first scans orders top-down for whole blocks to claim,
then falls back to a bottom-up search for the smallest buddy to steal.
For the next batch page, it goes through the same thing again.

This can be made more efficient. Since rmqueue_bulk() holds the
zone->lock over the entire batch, the freelists are not subject to
outside changes; when the search for a block to claim has already
failed, there is no point in trying again for the next page.

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

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Carlos Song <carlos.song@nxp.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block conversion")
Fixes: c2f6ea38fc1b ("mm: page_alloc: don't steal single pages from biggest buddy")
Closes: https://lore.kernel.org/oe-lkp/202503271547.fc08b188-lkp@intel.com
Cc: stable@vger.kernel.org	# 6.10+
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 100 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 26 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f51aa6051a99..03b0d45ed45a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2194,11 +2194,11 @@ try_to_claim_block(struct zone *zone, struct page *page,
  * The use of signed ints for order and current_order is a deliberate
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
- *
- * Return the stolen page, or NULL if none can be found.
  */
+
+/* Try to claim a whole foreign block, take a page, expand the remainder */
 static __always_inline struct page *
-__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
+__rmqueue_claim(struct zone *zone, int order, int start_migratetype,
 						unsigned int alloc_flags)
 {
 	struct free_area *area;
@@ -2236,14 +2236,26 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		page = try_to_claim_block(zone, page, current_order, order,
 					  start_migratetype, fallback_mt,
 					  alloc_flags);
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
+/* Try to steal a single page from a foreign block */
+static __always_inline struct page *
+__rmqueue_steal(struct zone *zone, int order, int start_migratetype)
+{
+	struct free_area *area;
+	int current_order;
+	struct page *page;
+	int fallback_mt;
+	bool claim_block;
 
-	/* No luck claiming pageblock. Find the smallest fallback page */
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
@@ -2253,25 +2265,28 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
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
 
@@ -2290,16 +2305,47 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 		}
 	}
 
-	page = __rmqueue_smallest(zone, order, migratetype);
-	if (unlikely(!page)) {
-		if (alloc_flags & ALLOC_CMA)
+	/*
+	 * Try the different freelists, native then foreign.
+	 *
+	 * The fallback logic is expensive and rmqueue_bulk() calls in
+	 * a loop with the zone->lock held, meaning the freelists are
+	 * not subject to any outside changes. Remember in *mode where
+	 * we found pay dirt, to save us the search on the next call.
+	 */
+	switch (*mode) {
+	case RMQUEUE_NORMAL:
+		page = __rmqueue_smallest(zone, order, migratetype);
+		if (page)
+			return page;
+		fallthrough;
+	case RMQUEUE_CMA:
+		if (alloc_flags & ALLOC_CMA) {
 			page = __rmqueue_cma_fallback(zone, order);
-
-		if (!page)
-			page = __rmqueue_fallback(zone, order, migratetype,
-						  alloc_flags);
+			if (page) {
+				*mode = RMQUEUE_CMA;
+				return page;
+			}
+		}
+		fallthrough;
+	case RMQUEUE_CLAIM:
+		page = __rmqueue_claim(zone, order, migratetype, alloc_flags);
+		if (page) {
+			/* Replenished native freelist, back to normal mode */
+			*mode = RMQUEUE_NORMAL;
+			return page;
+		}
+		fallthrough;
+	case RMQUEUE_STEAL:
+		if (!(alloc_flags & ALLOC_NOFRAGMENT)) {
+			page = __rmqueue_steal(zone, order, migratetype);
+			if (page) {
+				*mode = RMQUEUE_STEAL;
+				return page;
+			}
+		}
 	}
-	return page;
+	return NULL;
 }
 
 /*
@@ -2311,6 +2357,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
 	unsigned long flags;
 	int i;
 
@@ -2321,7 +2368,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	}
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+					      alloc_flags, &rmqm);
 		if (unlikely(page == NULL))
 			break;
 
@@ -2934,6 +2981,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 {
 	struct page *page;
 	unsigned long flags;
+	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
 
 	do {
 		page = NULL;
@@ -2945,7 +2993,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
+			page = __rmqueue(zone, order, migratetype, alloc_flags, &rmqm);
 
 			/*
 			 * If the allocation fails, allow OOM handling and
-- 
2.49.0


