Return-Path: <stable+bounces-66257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FF194CF86
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 13:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4FF284731
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52120194AD8;
	Fri,  9 Aug 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daypgCBf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEC1940B3;
	Fri,  9 Aug 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204157; cv=none; b=slLCTM0NXl94p/GCA/ZOqwwgF51jbMM+pIoy8+J0Uw/nao4uqYBpYRwoUL2VlpGqZMQDtf7PTRiF0gSnfYCQbq784Ef0k/E8rdNR+tXm1VbLaefZwx3RRRxDjdMERQU3ZqZiW3DwJDYC8oso9sDiaSQOK5695vmk9/lyAHkbxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204157; c=relaxed/simple;
	bh=SK6555nvVLN6liKsrnsOkA+XODJGhiDFiIQx9X5haBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhVIKy65bvsRpna2jsV+23c2DUqAW59ITvPPMkoSc8CJL+YQQWD4zSh1n3/18UZMLGuwz2phxB2aViEnI8Xs06Ro9gaMf2ysBPDiFaoe23xjDpwn2IFFzymshKdjuT1G2WRI97CZFZTXri/WeiuYDH1H72ztgJ2eSLFXq4ARbd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daypgCBf; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204155; x=1754740155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SK6555nvVLN6liKsrnsOkA+XODJGhiDFiIQx9X5haBs=;
  b=daypgCBfoHTkW2GYEkxxvS+Msuq44yd486/g1S785+2zSdiV57zSG4L1
   LPixAdIgm8tVDpEGlQEVQMhIqND/u9FGxA2XegTujRWdPAk40mFSDDCY0
   aiw1Uh86LCdO+vxFqFKw9q6LDhQMx2N9sRLB1Ba/d7WAfPbiTCS9Rtb2j
   t+N1Wa3IrHRNoPp6mx8NP2t5riWo1mKnDHiGI7rmhOJcO3QoPuRvQoIOV
   n22pHfVPjjJG8kZ/Tid49KIrKBizWK7eE+zXqcYMkvbfs53/7QMErixev
   XL87HTHyCnjEK/2f0MM9/Sco38cSEEdbS9MJN2sLndjbSSGuX+bhpEyDV
   Q==;
X-CSE-ConnectionGUID: i7/2CFVGTlOLu32oQpCdsA==
X-CSE-MsgGUID: JqTTwyUnTj648fuEec23MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="24280321"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="24280321"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:49:10 -0700
X-CSE-ConnectionGUID: 7BLDRKQVTJG1D1Ux70Uajg==
X-CSE-MsgGUID: qgriSKmHSL+s9l8ao6oQnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="57423600"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2024 04:49:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 31F3919E; Fri, 09 Aug 2024 14:49:02 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jianxiong Gao <jxgao@google.com>,
	stable@vger.kernel.org
Subject: [PATCHv2 1/8] mm: Fix endless reclaim on machines with unaccepted memory
Date: Fri,  9 Aug 2024 14:48:47 +0300
Message-ID: <20240809114854.3745464-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unaccepted memory is considered unusable free memory, which is not
counted as free on the zone watermark check. This causes
get_page_from_freelist() to accept more memory to hit the high
watermark, but it creates problems in the reclaim path.

The reclaim path encounters a failed zone watermark check and attempts
to reclaim memory. This is usually successful, but if there is little or
no reclaimable memory, it can result in endless reclaim with little to
no progress. This can occur early in the boot process, just after start
of the init process when the only reclaimable memory is the page cache
of the init executable and its libraries.

Make unaccepted memory free from watermark check point of view. This way
unaccepted memory will never be the trigger of memory reclaim.
Accept more memory in the get_page_from_freelist() if needed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Cc: stable@vger.kernel.org # v6.5+
---
 mm/page_alloc.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5b5f99f4b20a..a9a89980f3f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -287,7 +287,7 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
-static bool try_to_accept_memory(struct zone *zone, unsigned int order);
+static bool cond_accept_memory(struct zone *zone, unsigned int order);
 static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
@@ -3108,9 +3108,6 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	if (!(alloc_flags & ALLOC_CMA))
 		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
-#ifdef CONFIG_UNACCEPTED_MEMORY
-	unusable_free += zone_page_state(z, NR_UNACCEPTED);
-#endif
 
 	return unusable_free;
 }
@@ -3404,6 +3401,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			}
 		}
 
+		cond_accept_memory(zone, order);
+
 		/*
 		 * Detect whether the number of free pages is below high
 		 * watermark.  If so, we will decrease pcp->high and free
@@ -3429,10 +3428,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				       gfp_mask)) {
 			int ret;
 
-			if (has_unaccepted_memory()) {
-				if (try_to_accept_memory(zone, order))
-					goto try_this_zone;
-			}
+			if (cond_accept_memory(zone, order))
+				goto try_this_zone;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/*
@@ -3486,10 +3483,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
 			return page;
 		} else {
-			if (has_unaccepted_memory()) {
-				if (try_to_accept_memory(zone, order))
-					goto try_this_zone;
-			}
+			if (cond_accept_memory(zone, order))
+				goto try_this_zone;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 			/* Try again if zone has deferred pages */
@@ -6988,9 +6983,6 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	struct page *page;
 	bool last;
 
-	if (list_empty(&zone->unaccepted_pages))
-		return false;
-
 	spin_lock_irqsave(&zone->lock, flags);
 	page = list_first_entry_or_null(&zone->unaccepted_pages,
 					struct page, lru);
@@ -7016,23 +7008,29 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	return true;
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	long to_accept;
-	int ret = false;
+	bool ret = false;
+
+	if (!has_unaccepted_memory())
+		return false;
+
+	if (list_empty(&zone->unaccepted_pages))
+		return false;
 
 	/* How much to accept to get to high watermark? */
 	to_accept = high_wmark_pages(zone) -
 		    (zone_page_state(zone, NR_FREE_PAGES) -
-		    __zone_watermark_unusable_free(zone, order, 0));
+		    __zone_watermark_unusable_free(zone, order, 0) -
+		    zone_page_state(zone, NR_UNACCEPTED));
 
-	/* Accept at least one page */
-	do {
+	while (to_accept > 0) {
 		if (!try_to_accept_memory_one(zone))
 			break;
 		ret = true;
 		to_accept -= MAX_ORDER_NR_PAGES;
-	} while (to_accept > 0);
+	}
 
 	return ret;
 }
@@ -7075,7 +7073,7 @@ static void accept_page(struct page *page, unsigned int order)
 {
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	return false;
 }
-- 
2.43.0


