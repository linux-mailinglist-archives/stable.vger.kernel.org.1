Return-Path: <stable+bounces-142878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7A7AAFF54
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 17:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6770F9C6326
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD05276023;
	Thu,  8 May 2025 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RwyM6beM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0C279350
	for <stable@vger.kernel.org>; Thu,  8 May 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718447; cv=none; b=DsXb85U6VDt1X0PlcG9qjuzudzp52BR7UIP4LXIvoagPLeZZW+XFpizFCNGaQkCvLk1gOFzO1TBywJet8Ogptu8dY1ZiC9ft5y/oEQp1dQeM/a0Ziwk5sp6wWFcSpw7C9b7y/ICKC2qN4DmCemJ1Ab40IdORQmxKE//3A6Apb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718447; c=relaxed/simple;
	bh=Y8MYje9/rgOZUEunX1DoQFdfisgb+RfVaREdQILNFqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsLlli3ZR9kvlPidwjOJcgVx1uzfZyS7KTL3QQhoAxhKBhJU0aq9VZbkJYgiC5S07S+tyTXHHR060vBuvEK6h9tddkgHMUOYd/Yd+4pdEuBuozvlg0Uav6vkYuWUriewur1XBSkAF7sdlZxkZx3YeArhtYLahd/vJeYH5EFfiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RwyM6beM; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-7c559b3eb0bso82409485a.1
        for <stable@vger.kernel.org>; Thu, 08 May 2025 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746718442; x=1747323242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=930qNqvh+xEEH1eUocWCLEF+MmlsffTSQwP34ISCgRw=;
        b=RwyM6beMiaPkon68VC9Uaq5QUUd63gdM+2hg5cWFjqhgNTAKA0RQ59hT+Dcd0PhuyO
         LMTwgM7pbsMO9aWiRZ0XsInCNmm1AadEHb4p2RG5VnIIkVjZyEO9p60th+3AY1GsFZpk
         6C49fdhl/agt9hzR2p141vMDNx2fF4oYocEW1GdhSOSkdIDUetDQLyvc/pV9I/fpobKx
         11ma1dHgbttRz4bhg2jpbAyUeQESEPH7z9K2xfbVG3Sqqp4E6fALAgvacd7JpfSPVoDL
         Y4FASzjsnLsp9Sodzw8mHH45Raw3rSH9MBHAySu39SNmcos5MCGwoNGrhE9CzympVE/c
         cNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746718442; x=1747323242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=930qNqvh+xEEH1eUocWCLEF+MmlsffTSQwP34ISCgRw=;
        b=edBKU7D5oFF2rEK9eRxtnoKF1CcJNzU395Fu2YpBCruHPk/7JiVj+68mJv1rjRWfwz
         AGi8bfI5onPwpqEnnQco4oPYBFeB9ckwFylpN52SH6bcBB/cqT11tdzOlOF/v6d4+TSP
         kJt8183VJRjlxnqWPezHN4po6tlu44zLaV3IXvr7hRf0KcVjbdGxaprDsyNmufhf7M44
         GfZFVNenkuPw2EmLqcSYfm35t21z0SreMYc9n+0ue0yELL6sljl1B8cfEKc6s2kbYAcm
         zGt76v3dpa8+ig1QnjmMEYpR92JEGFK8KB8SwQnlsg0lDcL1QLzyUt5y46DKiA1EOzkT
         R0Ag==
X-Gm-Message-State: AOJu0Ywn2zPSId43P5cp3VEJ4niBsWNgG8ju+U00xoAk5hrKRbT5eLKW
	jl4ccKce5pdSeJxgtv2XWDEqoUPEpNgmoVdTCjHPYovt/VXZCZeV/hrN6uy3jdZyiEvm1su0Des
	ICNgKPg==
X-Gm-Gg: ASbGncsoXeG2pk81LFE43pFFbYgtxAVnueP76QC/jnnXmipGhDF6eox3zVH0vt+JCKS
	gi3WezzM7Z2d3HGN/eqEX//MXrpFRgAA4HHhCbnFJ0NK9WShc76hSBRvtXYRLoKUL4bav71MdD2
	QryWK82V0kqbm3kwjeeQ1BTXNnm6/W2sSbaBeDjvd2GPdLFDKlq18rCVujUJaSmGQFivtQT/U2n
	P6TIHfIR5bbh/9BsUTKFEseA4+rGCN0xjz8X0useOO39uKnkGFfWCuSsUa2QxJlya0V2hh16w67
	WjUWCTqMpF4Jaf1WMzaF7vRWbovC7Pid2WA3gmI=
X-Google-Smtp-Source: AGHT+IHstfNGDUJy6m7irHI+XpAoH+b/A/uAIzBzYGKbRTK6nk7lNOOWmsxdTpjVOizwkd+ff7mBJw==
X-Received: by 2002:a05:620a:1a1b:b0:7c5:3d60:7f88 with SMTP id af79cd13be357-7cd010f0818mr18227785a.16.1746718441735;
        Thu, 08 May 2025 08:34:01 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd00f4d55asm6216985a.12.2025.05.08.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:34:00 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: stable@vger.kernel.org
Cc: Brendan Jackman <jackmanb@google.com>,
	kernel test robot <oliver.sang@intel.com>,
	Carlos Song <carlos.song@nxp.com>,
	Shivank Garg <shivankg@amd.com>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.14.y 2/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
Date: Thu,  8 May 2025 11:33:54 -0400
Message-ID: <20250508153354.396788-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508153354.396788-1-hannes@cmpxchg.org>
References: <2025042149-busily-amaretto-e684@gregkh>
 <20250508153354.396788-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The test robot identified c2f6ea38fc1b ("mm: page_alloc: don't steal
single pages from biggest buddy") as the root cause of a 56.4% regression
in vm-scalability::lru-file-mmap-read.

Carlos reports an earlier patch, c0cd6f557b90 ("mm: page_alloc: fix
freelist movement during block conversion"), as the root cause for a
regression in worst-case zone->lock+irqoff hold times.

Both of these patches modify the page allocator's fallback path to be less
greedy in an effort to stave off fragmentation.  The flip side of this is
that fallbacks are also less productive each time around, which means the
fallback search can run much more frequently.

Carlos' traces point to rmqueue_bulk() specifically, which tries to refill
the percpu cache by allocating a large batch of pages in a loop.  It
highlights how once the native freelists are exhausted, the fallback code
first scans orders top-down for whole blocks to claim, then falls back to
a bottom-up search for the smallest buddy to steal.  For the next batch
page, it goes through the same thing again.

This can be made more efficient.  Since rmqueue_bulk() holds the
zone->lock over the entire batch, the freelists are not subject to outside
changes; when the search for a block to claim has already failed, there is
no point in trying again for the next page.

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

[jackmanb@google.com: comment updates]
  Link: https://lkml.kernel.org/r/D92AC0P9594X.3BML64MUKTF8Z@google.com
[hannes@cmpxchg.org: reset rmqueue_mode in rmqueue_buddy() error loop, per Yunsheng Lin]
  Link: https://lkml.kernel.org/r/20250409140023.GA2313@cmpxchg.org
Link: https://lkml.kernel.org/r/20250407180154.63348-1-hannes@cmpxchg.org
Fixes: c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block conversion")
Fixes: c2f6ea38fc1b ("mm: page_alloc: don't steal single pages from biggest buddy")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Carlos Song <carlos.song@nxp.com>
Tested-by: Carlos Song <carlos.song@nxp.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503271547.fc08b188-lkp@intel.com
Reviewed-by: Brendan Jackman <jackmanb@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>	[6.10+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 90abee6d7895d5eef18c91d870d8168be4e76e9d)
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 115 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 34 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6f6c18336cad..74a996a3508e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2165,22 +2165,15 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
 }
 
 /*
- * Try finding a free buddy page on the fallback list.
- *
- * This will attempt to steal a whole pageblock for the requested type
- * to ensure grouping of such requests in the future.
- *
- * If a whole block cannot be stolen, regress to __rmqueue_smallest()
- * logic to at least break up as little contiguity as possible.
+ * Try to allocate from some fallback migratetype by claiming the entire block,
+ * i.e. converting it to the allocation's start migratetype.
  *
  * The use of signed ints for order and current_order is a deliberate
  * deviation from the rest of this file, to make the for loop
  * condition simpler.
- *
- * Return the stolen page, or NULL if none can be found.
  */
 static __always_inline struct page *
-__rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
+__rmqueue_claim(struct zone *zone, int order, int start_migratetype,
 						unsigned int alloc_flags)
 {
 	struct free_area *area;
@@ -2217,14 +2210,29 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 		page = get_page_from_free_area(area, fallback_mt);
 		page = try_to_steal_block(zone, page, current_order, order,
 					  start_migratetype, alloc_flags);
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
+/*
+ * Try to steal a single page from some fallback migratetype. Leave the rest of
+ * the block as its current migratetype, potentially causing fragmentation.
+ */
+static __always_inline struct page *
+__rmqueue_steal(struct zone *zone, int order, int start_migratetype)
+{
+	struct free_area *area;
+	int current_order;
+	struct page *page;
+	int fallback_mt;
+	bool can_steal;
 
-	/* No luck stealing blocks. Find the smallest fallback page */
 	for (current_order = order; current_order < NR_PAGE_ORDERS; current_order++) {
 		area = &(zone->free_area[current_order]);
 		fallback_mt = find_suitable_fallback(area, current_order,
@@ -2234,25 +2242,28 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
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
 
@@ -2271,16 +2282,49 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
 		}
 	}
 
-	page = __rmqueue_smallest(zone, order, migratetype);
-	if (unlikely(!page)) {
-		if (alloc_flags & ALLOC_CMA)
+	/*
+	 * First try the freelists of the requested migratetype, then try
+	 * fallbacks modes with increasing levels of fragmentation risk.
+	 *
+	 * The fallback logic is expensive and rmqueue_bulk() calls in
+	 * a loop with the zone->lock held, meaning the freelists are
+	 * not subject to any outside changes. Remember in *mode where
+	 * we found pay dirt, to save us the search on the next call.
+	 */
+       switch (*mode) {
+       case RMQUEUE_NORMAL:
+               page = __rmqueue_smallest(zone, order, migratetype);
+               if (page)
+                       return page;
+               fallthrough;
+       case RMQUEUE_CMA:
+               if (alloc_flags & ALLOC_CMA) {
 			page = __rmqueue_cma_fallback(zone, order);
-
-		if (!page)
-			page = __rmqueue_fallback(zone, order, migratetype,
-						  alloc_flags);
-	}
-	return page;
+			if (page) {
+				*mode = RMQUEUE_CMA;
+				return page;
+			}
+	       }
+	       fallthrough;
+       case RMQUEUE_CLAIM:
+	       page = __rmqueue_claim(zone, order, migratetype, alloc_flags);
+	       if (page) {
+                       /* Replenished preferred freelist, back to normal mode. */
+                       *mode = RMQUEUE_NORMAL;
+                       return page;
+               }
+               fallthrough;
+       case RMQUEUE_STEAL:
+               if (!(alloc_flags & ALLOC_NOFRAGMENT)) {
+                       page = __rmqueue_steal(zone, order, migratetype);
+                       if (page) {
+                               *mode = RMQUEUE_STEAL;
+                               return page;
+                       }
+               }
+       }
+
+       return NULL;
 }
 
 /*
@@ -2292,13 +2336,14 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
+	enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
 	unsigned long flags;
 	int i;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+					      alloc_flags, &rmqm);
 		if (unlikely(page == NULL))
 			break;
 
@@ -2899,7 +2944,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
+			enum rmqueue_mode rmqm = RMQUEUE_NORMAL;
+
+			page = __rmqueue(zone, order, migratetype, alloc_flags, &rmqm);
 
 			/*
 			 * If the allocation fails, allow OOM handling and
-- 
2.49.0


