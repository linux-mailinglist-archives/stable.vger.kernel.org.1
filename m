Return-Path: <stable+bounces-69545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310299567D7
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65271F2174A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84C15ECDB;
	Mon, 19 Aug 2024 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFh7TCt8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2E155337
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062154; cv=none; b=jUjMf3+oSl4QN2Q1fQcXXShA0cLhEnP/O6ixPPNXY1fLX98WhF74z/1nJRbD+eXDZgqzg+9QDpqp9MTZ8Zk9n+ou1ZSWZyFiq+zrC/vE9azEAx2JO2SyDA3ZDiCpJST8gpy61ZMrHpTZCowSD9308SsxxX5cSoiH6SCMMXyMyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062154; c=relaxed/simple;
	bh=skzj+IU1zYdF/MC3ihhWGenbt5eFU7HBX/s5NH+6Bx8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAL/pyFrC5bdKTWNOH6jPp6Q+wdA5EveWMaIrUjQ846o4kJ/joI4A8GRD28FcgUXQjpebVQs3KGIEDtxLRwxPEtzbwEmge27h0C/XsDiBMfMK4gdW0LTaFgqZ+hagNo6PqmmzdF1DCTcrVrKpSdb5WhLdzxwEfchiCdwIYLPEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFh7TCt8; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062153; x=1755598153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=skzj+IU1zYdF/MC3ihhWGenbt5eFU7HBX/s5NH+6Bx8=;
  b=EFh7TCt8RUGvYPw4kpfPgDxhS1mlXEwqfmzMO34nGQ6Br5CDBv0m51i3
   YW1+Gnum3gTjr+6byva9dA5121SCS4gdxuQ9pv7hDLM8oJS3x8cE5BU+C
   7qM1f72UHcYk4lA0zuTBQie2hI6ySAakdSReg5N2mPevHBn1ZMLoPFoCt
   xg4C5RgPYt6kUI4vqhg50wbsTJRBV3Gn0Jz5I7q72UhB/if09NtJUplUx
   siZYwDpLTdbEKHQR2EU2ob8+bZA0OHaJrR6DOgqVsikoMdSbdBRWYtiEH
   M9TYt68H+3xugygXNMxthWSLPV9Vu1awMp2BiN+L1yHUbo1b7ze9yjkKL
   g==;
X-CSE-ConnectionGUID: ekwmBV1jQCC8pnzRyBz1XQ==
X-CSE-MsgGUID: QX/1pQ+xSe239V5jtWgVTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="47700184"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="47700184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:09:12 -0700
X-CSE-ConnectionGUID: kjMQGGLFRFSjnvSlm0cZqw==
X-CSE-MsgGUID: iTVApdE+QA2rZMe1mUhsdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="91096386"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa001.fm.intel.com with ESMTP; 19 Aug 2024 03:09:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4B7262AA; Mon, 19 Aug 2024 13:09:08 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jianxiong Gao <jxgao@google.com>,
	David Hildenbrand <david@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mel Gorman <mgorman@suse.de>,
	Mike Rapoport <rppt@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm: fix endless reclaim on machines with unaccepted memory
Date: Mon, 19 Aug 2024 13:09:05 +0300
Message-ID: <20240819100905.3898072-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024081913-outbid-skincare-1e41@gregkh>
References: <2024081913-outbid-skincare-1e41@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unaccepted memory is considered unusable free memory, which is not counted
as free on the zone watermark check.  This causes get_page_from_freelist()
to accept more memory to hit the high watermark, but it creates problems
in the reclaim path.

The reclaim path encounters a failed zone watermark check and attempts to
reclaim memory.  This is usually successful, but if there is little or no
reclaimable memory, it can result in endless reclaim with little to no
progress.  This can occur early in the boot process, just after start of
the init process when the only reclaimable memory is the page cache of the
init executable and its libraries.

Make unaccepted memory free from watermark check point of view.  This way
unaccepted memory will never be the trigger of memory reclaim.  Accept
more memory in the get_page_from_freelist() if needed.

Link: https://lkml.kernel.org/r/20240809114854.3745464-2-kirill.shutemov@linux.intel.com
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Jianxiong Gao <jxgao@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Jianxiong Gao <jxgao@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>	[6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 807174a93d24c456503692dc3f5af322ee0b640a)
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 39bdbfb5313f..edb32635037f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -302,7 +302,7 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
-static bool try_to_accept_memory(struct zone *zone, unsigned int order);
+static bool cond_accept_memory(struct zone *zone, unsigned int order);
 static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
@@ -2830,9 +2830,6 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	if (!(alloc_flags & ALLOC_CMA))
 		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
-#ifdef CONFIG_UNACCEPTED_MEMORY
-	unusable_free += zone_page_state(z, NR_UNACCEPTED);
-#endif
 
 	return unusable_free;
 }
@@ -3126,16 +3123,16 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			}
 		}
 
+		cond_accept_memory(zone, order);
+
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (!zone_watermark_fast(zone, order, mark,
 				       ac->highest_zoneidx, alloc_flags,
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
@@ -3189,10 +3186,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
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
@@ -6619,9 +6614,6 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	struct page *page;
 	bool last;
 
-	if (list_empty(&zone->unaccepted_pages))
-		return false;
-
 	spin_lock_irqsave(&zone->lock, flags);
 	page = list_first_entry_or_null(&zone->unaccepted_pages,
 					struct page, lru);
@@ -6647,23 +6639,29 @@ static bool try_to_accept_memory_one(struct zone *zone)
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
@@ -6706,7 +6704,7 @@ static void accept_page(struct page *page, unsigned int order)
 {
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	return false;
 }
-- 
2.43.0


