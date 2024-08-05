Return-Path: <stable+bounces-65393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80183947D68
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A181F21F78
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 15:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C149915B10F;
	Mon,  5 Aug 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zb1ywRae"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FD1552E1;
	Mon,  5 Aug 2024 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869994; cv=none; b=TPweh6naicUnRc6lvVH+Dj9Gw5LXDnyozElpCV6+1d56tWR9yKcTg8RhEF5GESHdu9BMXkJL4ym4AC92QCivatjcqE6m9SonyOmJZG/hPiKWXiQMTebaJPoxA9tMmgiYuugYxB8qz1cwy6gjlrxdFgdxuBLrm5gkRBTu5Vk0plM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869994; c=relaxed/simple;
	bh=wmXqjcepXOvmD9mxVJqk0suOyn9vecB7qQ8hDHFk0qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao7xEqWC+jbLK3tsf148jozRNjjdyT6qBUqaPmhbQtONYRFICHHkCfmhVJaOp2BZmC4fMvGEtK/3hyhHP53dWKPuKO246FxORB6+jr5iPbYUPFCSwRtWct/iHcEr8p7ZgftPQR6svNZe0a3BFq6M5b1F0kVWqJB1FE50qdEMUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zb1ywRae; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722869993; x=1754405993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wmXqjcepXOvmD9mxVJqk0suOyn9vecB7qQ8hDHFk0qw=;
  b=Zb1ywRae7W17L/rnTEv9Nd3LkU0WrghFb1s4cdY/9AQco1FWXLIWAFcx
   vD2C+8ToyYjdr+iSL3o6171lJwV260eFK08r33teWsxMfwLAhrTbD0KA2
   XAdYGQyRR8ClK8w2H4dRFWwAC3sw8v4mGCCleiWizhSpGubo6BdpPN7lO
   sP1aG+fxYC1L1f4LRz8ZDOufzRuyLTWMvwfLjr4+EqN3SdtLEwstAaXIu
   xQP10FsSboF7XUWbIoRiosDztgoeIThMd220LQxl7pXEPDGdgXx9qc5VE
   0yBCoPGPQheUrGfh4Kohdo9tuhp0+UNUezcr/7PykNYHRW2nCBHyc6eG6
   A==;
X-CSE-ConnectionGUID: c22WvdOJRtmEZm+x/mGW0Q==
X-CSE-MsgGUID: C6FvVCrbRNm3eai/uQfPaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20980942"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="20980942"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 07:59:50 -0700
X-CSE-ConnectionGUID: +89Um3x/TxS1tnSa7qsbkw==
X-CSE-MsgGUID: Nu7NFvCCROW8lc7o1GLDdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="61157248"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2024 07:59:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 626E0122; Mon, 05 Aug 2024 17:59:45 +0300 (EEST)
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
Subject: [PATCH 1/8] mm: Fix endless reclaim on machines with unaccepted memory
Date: Mon,  5 Aug 2024 17:59:33 +0300
Message-ID: <20240805145940.2911011-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
References: <20240805145940.2911011-1-kirill.shutemov@linux.intel.com>
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
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Cc: stable@vger.kernel.org # v6.5+
---
 mm/page_alloc.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 28f80daf5c04..aa9b1eaa638c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -287,7 +287,7 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
-static bool try_to_accept_memory(struct zone *zone, unsigned int order);
+static bool cond_accept_memory(struct zone *zone, unsigned int order);
 static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
@@ -3072,9 +3072,6 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	if (!(alloc_flags & ALLOC_CMA))
 		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
-#ifdef CONFIG_UNACCEPTED_MEMORY
-	unusable_free += zone_page_state(z, NR_UNACCEPTED);
-#endif
 
 	return unusable_free;
 }
@@ -3368,6 +3365,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			}
 		}
 
+		cond_accept_memory(zone, order);
+
 		/*
 		 * Detect whether the number of free pages is below high
 		 * watermark.  If so, we will decrease pcp->high and free
@@ -3393,10 +3392,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
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
@@ -3450,10 +3447,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
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
@@ -6951,9 +6946,6 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	struct page *page;
 	bool last;
 
-	if (list_empty(&zone->unaccepted_pages))
-		return false;
-
 	spin_lock_irqsave(&zone->lock, flags);
 	page = list_first_entry_or_null(&zone->unaccepted_pages,
 					struct page, lru);
@@ -6979,23 +6971,29 @@ static bool try_to_accept_memory_one(struct zone *zone)
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
@@ -7038,7 +7036,7 @@ static void accept_page(struct page *page, unsigned int order)
 {
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	return false;
 }
-- 
2.43.0


