Return-Path: <stable+bounces-142904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCB3AB005F
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91D997B3DFA
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010B2820C9;
	Thu,  8 May 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="cLnmR2YI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA922B8DB
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721475; cv=none; b=QDtazfVkeWmPFjj1bSfKHjetgA8ADHJqGmJFiCjE20UgPsy9XSLKQOyhLuIJ5OwjoKU+16MBYOkD0ZgUAoFzLUhtIEfiKljuGsJ5qvnPfRZFetzPzchEhWn9W2pmir5ldwDa3mNikf71L9K8V0fhiK5ORLzxUgS8d0DmM3RFqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721475; c=relaxed/simple;
	bh=5UKCAaB5HWfYEUCVHcScgxqFD9mIZJdPWmrrW/OWr5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpBhCkCJM4GCdA0J870b0qFYSrQtIX/asClCngx29ptoTM+WMdlfk2MvAAusqPu39x1PaOqDkt17atNZnJbo415/VkBAQvaRPlzlVra/BOsJh4dS2irRnUscYBiycINtJYdaN9/4BtSkLbBUlRiOCn3H66lta+AA2ru4f/MgDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=cLnmR2YI; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-47677b77725so12570741cf.3
        for <stable@vger.kernel.org>; Thu, 08 May 2025 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1746721470; x=1747326270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evoV24c74OyNWadvZaBN6elrbHipQaEllekDlYjGmj0=;
        b=cLnmR2YIyBSjpYwy9Thr/sbXSs8DzNBr3a4/0G/k3jmTH5882N1pv5ifBAqeJeNdbF
         iZ1ZMpG5sXjrTf2tEkG9i5mosYUPT7hLyqz0hniQ/8BHrG+6skUHuKfPTiKNQwPwBAgF
         p6yEUjN4SrNWjS4dr07lPKkqvLHn0PTaBgQvn7ZP9b9moEr2mreL5y9kj2Eq3eaemmxJ
         8hKjGJntEiPQt8dD7wR8dNUUeqiQFLy5014Xz640+i1bGhfPWHFWrdN8oXYaMpqPyGUK
         BND0yXF7cQXo1Et7Qenw2JFdpqZIw93yjnZtu07ncVJeUy9w/CZDJiV8lU/dm+Xd26+O
         rXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746721470; x=1747326270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evoV24c74OyNWadvZaBN6elrbHipQaEllekDlYjGmj0=;
        b=Hk29TpOMisn8v69T6sTqzE23ZeI/Myn96lV2NxAzd0Su6rJvcdDsWpMC7SGISiJqyn
         FMnYlARIFCDfQmJLbun5ue4FUrsRJgik1b9VTfU5aeiahF0fKcYBSJg5MGK+u3dr8c5b
         8mOXwGKp5+wmKaTugUS6Qisv40PKF8p7OQHBi8Ga4qtN+3+9ecatAoRPR1meYge8UTDY
         /UgJp8zu3A5WnUl9Dy+1f+XLpIW/q4uDHG+MkcY9+DxCyN7Y7X4q8SdZjWnPP7Uzetpz
         Hd64oUvYmVEXuArTwALLCNU8nTcwn152KU3eegSShy3SPLmAvyLO8qVS8yBTfeWS9y0z
         DixQ==
X-Gm-Message-State: AOJu0YzUoxOSauUV5fq308gXZkHDxLWWd7rUQFXV5mxgEISCO49RJ0Z/
	vYbVR7MybfcZnu7klq/MULYUrudhoEtSEyKNbE3S0nKDNkPcU8IIbqLTul3eGhO4cmqvSrfkmy4
	H1LlsEQ==
X-Gm-Gg: ASbGnct5NjLAYpIgzrE+LHvg0SvPHAY8dUK47GdNI94vXvoVCcs3wJtR2tfwJGvnnY+
	HZrcdN9rIFoCemKnOuQtEz2EW6fCfbL/bKCpSA6bqIWW7JAW+c9cQYL3soXj7Wk/UttcID0UjEn
	0ytd1TbaBjUh83EymLKWWKNSaFt0NqeDu/1KabxVcAuU0q4nTqvC+h2R4gRNFaID6JtlRRIyrIL
	RVy592QMrySYzZozo1GmUbrcU1b9vV5dbGm/vxjmNNrgeBYQ+SncdBBdcYSJ6K4sDzCAyINGnLG
	rxdY5sMQwvDxaam9YtWB/SWOh9Y/8fudvu+aA7U=
X-Google-Smtp-Source: AGHT+IFFcad8xCXt+QqWTM3+sj7HTW74QJNp9zhi4+GyHHbCrgugr6XXYAtlZ9bA11tOrOjwoEfMGA==
X-Received: by 2002:a05:622a:2d5:b0:476:77ba:f7 with SMTP id d75a77b69052e-4944961b7e6mr64284361cf.34.1746721469338;
        Thu, 08 May 2025 09:24:29 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f6e3a47327sm1482156d6.80.2025.05.08.09.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 09:24:28 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: stable@vger.kernel.org
Cc: Brendan Jackman <jackmanb@google.com>,
	kernel test robot <oliver.sang@intel.com>,
	Carlos Song <carlos.song@nxp.com>,
	Shivank Garg <shivankg@amd.com>,
	Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.12.y 2/2] mm: page_alloc: speed up fallbacks in rmqueue_bulk()
Date: Thu,  8 May 2025 12:24:26 -0400
Message-ID: <20250508162426.427619-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508162426.427619-1-hannes@cmpxchg.org>
References: <2025042150-hardiness-hunting-0780@gregkh>
 <20250508162426.427619-1-hannes@cmpxchg.org>
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
 mm/page_alloc.c | 113 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 80 insertions(+), 33 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bfc0139d2f45..d29da0c6a7f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2164,22 +2164,15 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
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
@@ -2216,14 +2209,29 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
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
@@ -2233,25 +2241,28 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
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
 
@@ -2270,16 +2281,49 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
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
+			/* Replenished preferred freelist, back to normal mode. */
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
+
+	return NULL;
 }
 
 /*
@@ -2291,13 +2335,14 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
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
 
@@ -2898,7 +2943,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
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


