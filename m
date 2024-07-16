Return-Path: <stable+bounces-59407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CEF932703
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C959B2132A
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EFD17B431;
	Tue, 16 Jul 2024 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aqut2V7+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D22AE6A;
	Tue, 16 Jul 2024 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721134823; cv=none; b=QnZEzwqjxtLxpQgtgSfGu9ySP5q7jCsbsfyUSm0mEQus8ZDrvriYeZo1o44ZfjcnffCmZYvdiNWShd0OqL8FAUyTsyH6l/apOAb20P8wk7kKxULK4f+3YYrOgVW48JgdfP0/9WKvfZ59qPpFS5iViLl9c5QVwnQG/6/yshKC6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721134823; c=relaxed/simple;
	bh=vkXu+n2x+kK4Knb2Er0q+C2Cf7zQzcoq0Ifv0jXYYTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7dVihdLLW3dylCY6pPkJ8LrJ+G10/8nY5RPpPKryS0DyfJ4oXxnHe+yej0fnFvcQNr5VqHEyenF9Idb2QxoW1Y6F3Hdyyuw1gvuujvezdnYTJ2u1/ex2TysahqCBzy0XKUcIjwG2tWzbFGYoGT/0n1vy/jKBny5FnxkYsvuVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aqut2V7+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721134822; x=1752670822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vkXu+n2x+kK4Knb2Er0q+C2Cf7zQzcoq0Ifv0jXYYTc=;
  b=aqut2V7+vUfYLusKPiI0NF8hboLMhPJ6UX7HviI/F25BJJgrUKE7zDRP
   edv8V02OhmXlCfyXsZ/EZ0rp4Yn/jfGtsxqWEZAXBCLUgVGWpjDvh5hNQ
   KzGlW+JmKdS621qawbaOcY3koqxKtOCHjfgiDxdFAtPCZb7zTg91qEXG9
   qp9/OS85P3uWuXDfE2zFhLHldOBIIhAq/N+4/KbAh795Lc/0607jd3ivG
   jRbyfr1gvb114J333bVvEP7jIW8wg0CTdkNVZr3XP7vY0PsdMyHuc7K5b
   LKX0mEMSKbdqLqAY05HROhD3RwiPaxmpeF1L82UEPsmr9FJ3QNK8g4eJo
   w==;
X-CSE-ConnectionGUID: g1tFF/T/R0SB99DTBTMLtw==
X-CSE-MsgGUID: 73ia1qbKQTOWe7ITzoXSCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="43996805"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="43996805"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 06:00:21 -0700
X-CSE-ConnectionGUID: n4gQ5CMgS02+x3zdGaW6Gw==
X-CSE-MsgGUID: CEfPQWtlT3qjfhagLIcJPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54541430"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 16 Jul 2024 06:00:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E4400341; Tue, 16 Jul 2024 16:00:17 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Mel Gorman <mgorman@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jianxiong Gao <jxgao@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: Fix endless reclaim on machines with unaccepted memory.
Date: Tue, 16 Jul 2024 16:00:13 +0300
Message-ID: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

To address this issue, teach shrink_node() and shrink_zones() to accept
memory before attempting to reclaim.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Jianxiong Gao <jxgao@google.com>
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Cc: stable@vger.kernel.org # v6.5+
---
 mm/internal.h   |  9 +++++++++
 mm/page_alloc.c |  8 +-------
 mm/vmscan.c     | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cc2c5e07fad3..ea55cbad061f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1515,4 +1515,13 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+bool try_to_accept_memory(struct zone *zone, unsigned int order);
+#else
+static inline bool try_to_accept_memory(struct zone *zone, unsigned int order)
+{
+	return false;
+}
+#endif /* CONFIG_UNACCEPTED_MEMORY */
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..9a108c92245f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -287,7 +287,6 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
-static bool try_to_accept_memory(struct zone *zone, unsigned int order);
 static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
@@ -6940,7 +6939,7 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	return true;
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+bool try_to_accept_memory(struct zone *zone, unsigned int order)
 {
 	long to_accept;
 	int ret = false;
@@ -6999,11 +6998,6 @@ static void accept_page(struct page *page, unsigned int order)
 {
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
-{
-	return false;
-}
-
 static inline bool has_unaccepted_memory(void)
 {
 	return false;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..b2af1263b1bc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5900,12 +5900,44 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
 }
 
+#ifdef CONFIG_UNACCEPTED_MEMORY
+static bool node_try_to_accept_memory(pg_data_t *pgdat, struct scan_control *sc)
+{
+	bool progress = false;
+	struct zone *zone;
+	int z;
+
+	for (z = 0; z <= sc->reclaim_idx; z++) {
+		zone = pgdat->node_zones + z;
+		if (!managed_zone(zone))
+			continue;
+
+		if (try_to_accept_memory(zone, sc->order))
+			progress = true;
+	}
+
+	return progress;
+}
+#else
+static inline bool node_try_to_accept_memory(pg_data_t *pgdat,
+					     struct scan_control *sc)
+{
+	return false;
+}
+#endif /* CONFIG_UNACCEPTED_MEMORY */
+
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 {
 	unsigned long nr_reclaimed, nr_scanned, nr_node_reclaimed;
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 
+	/* Try to accept memory before going for reclaim */
+	if (node_try_to_accept_memory(pgdat, sc)) {
+		if (!should_continue_reclaim(pgdat, 0, sc))
+			return;
+	}
+
 	if (lru_gen_enabled() && root_reclaim(sc)) {
 		lru_gen_shrink_node(pgdat, sc);
 		return;
@@ -6118,6 +6150,10 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
 						 GFP_KERNEL | __GFP_HARDWALL))
 				continue;
 
+			/* Try to accept memory before going for reclaim */
+			if (try_to_accept_memory(zone, sc->order))
+				continue;
+
 			/*
 			 * If we already have plenty of memory free for
 			 * compaction in this zone, don't free any more.
-- 
2.43.0


