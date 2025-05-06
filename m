Return-Path: <stable+bounces-141813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B5BAAC66A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97931BC2721
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AF028136C;
	Tue,  6 May 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxaT0/ca"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21D527FD58;
	Tue,  6 May 2025 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538339; cv=none; b=KsvnUClGygBIfDpVu5N1PVbijxiNzlZxIj1GQXmBAUXjTG/HJLbplEU4hn0q8HfF85cP3wL2p/Tb8n+TnsFV3gPny/BTN2nE/tsjspsY0WmYrSucf30mUL/4LN0pobHoWTFlQRvFbvL0HwXGFhPNvkSmj+xrniayuqCvOxaHGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538339; c=relaxed/simple;
	bh=lsc3eUoKvFKPzNR9orxqXQOQOwzxYCdjulF2UbsE9LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKvQ99yOJfLvjDSMBvHYTz/2H/eSoxJ4XrncstXo2Jtnm+kuNlX8BCI9P4koKfaBK9F8eFtgOW4g/O9MqNiTI5GSZAh+vaB+5CpVHe7btRk8P9mxgMWzz5pPGzWN45pBqNJOMXAsLeb5YfjMwGfpNeLEHt9yPuOu1PBnFrtOaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxaT0/ca; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746538337; x=1778074337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lsc3eUoKvFKPzNR9orxqXQOQOwzxYCdjulF2UbsE9LE=;
  b=TxaT0/ca769RXH9qyvq7KVU5UHxHRA0NFv3P2CSetzGRJXYKe3ljABod
   hR1j4rxpkfW4ia/Yu4mH6cziKM4whjix+t8PKa83uicYcjVbeQE/VBveO
   ixXwvSxBHL7we1GB2cBY62xfGjgrq6aIzOHmq5t+ZcE0645VdZSBKtpqS
   aZqHFb/PdRU5J7tNtOy7rtw17mBfbAfcoiDavaicpjYLSHzjvaxwbdHfH
   nb1UYjl1Uay+yr34OzmAJCGJjK7/8baTYyHRJuL6USeXlegdXh8K0+95P
   bQOeRSXCO0XjIoeV8I4qku3yA9nyzKpNSfzFcywvluIi0rx3iyjXlmXGs
   g==;
X-CSE-ConnectionGUID: FnGMPQqMRji31liEFSfu8A==
X-CSE-MsgGUID: 1YYAf4jWQGa+RgXYH/yWBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48340775"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="48340775"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 06:32:16 -0700
X-CSE-ConnectionGUID: 1xyVPh6iSv6MJoXWIGvdcg==
X-CSE-MsgGUID: rRGbgryYQ7yjJYAG7YmzcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="140740965"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 06 May 2025 06:32:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 98CFF172; Tue, 06 May 2025 16:32:10 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: bp@alien8.de
Cc: akpm@linux-foundation.org,
	ast@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	kirill.shutemov@linux.intel.com,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	stable@vger.kernel.org,
	surenb@google.com,
	tglx@linutronix.de,
	vbabka@suse.cz
Subject: [PATCHv2] mm/page_alloc: Fix race condition in unaccepted memory handling
Date: Tue,  6 May 2025 16:32:07 +0300
Message-ID: <20250506133207.1009676-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250506124341.GDaBoD_cYkXsnTmRdj@fat_crate.local>
References: <20250506124341.GDaBoD_cYkXsnTmRdj@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page allocator tracks the number of zones that have unaccepted
memory using static_branch_enc/dec() and uses that static branch in hot
paths to determine if it needs to deal with unaccepted memory.

Borislav and Thomas pointed out that the tracking is racy: operations on
static_branch are not serialized against adding/removing unaccepted pages
to/from the zone.

Sanity checks inside static_branch machinery detects it:

WARNING: CPU: 0 PID: 10 at kernel/jump_label.c:276 __static_key_slow_dec_cpuslocked+0x8e/0xa0

The comment around the WARN() explains the problem:

	/*
	 * Warn about the '-1' case though; since that means a
	 * decrement is concurrent with a first (0->1) increment. IOW
	 * people are trying to disable something that wasn't yet fully
	 * enabled. This suggests an ordering problem on the user side.
	 */

The effect of this static_branch optimization is only visible on
microbenchmark.

Instead of adding more complexity around it, remove it altogether.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Link: https://lore.kernel.org/all/20250506092445.GBaBnVXXyvnazly6iF@fat_crate.local
Reported-by: Borislav Petkov <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org # v6.5+
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---

 v2:
   - Update commit message;
   - Apply Borislav's Tested-by tag;

---
 mm/internal.h   |  1 -
 mm/mm_init.c    |  1 -
 mm/page_alloc.c | 47 -----------------------------------------------
 3 files changed, 49 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e9695baa5922..50c2f590b2d0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1595,7 +1595,6 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc);
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 void accept_page(struct page *page);
-void unaccepted_cleanup_work(struct work_struct *work);
 #else /* CONFIG_UNACCEPTED_MEMORY */
 static inline void accept_page(struct page *page)
 {
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9659689b8ace..84f14fa12d0d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1441,7 +1441,6 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	INIT_LIST_HEAD(&zone->unaccepted_pages);
-	INIT_WORK(&zone->unaccepted_cleanup, unaccepted_cleanup_work);
 #endif
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5fccf5fce084..a4a4df2daedb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7175,16 +7175,8 @@ bool has_managed_dma(void)
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 
-/* Counts number of zones with unaccepted pages. */
-static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
-
 static bool lazy_accept = true;
 
-void unaccepted_cleanup_work(struct work_struct *work)
-{
-	static_branch_dec(&zones_with_unaccepted_pages);
-}
-
 static int __init accept_memory_parse(char *p)
 {
 	if (!strcmp(p, "lazy")) {
@@ -7209,11 +7201,7 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
 static void __accept_page(struct zone *zone, unsigned long *flags,
 			  struct page *page)
 {
-	bool last;
-
 	list_del(&page->lru);
-	last = list_empty(&zone->unaccepted_pages);
-
 	account_freepages(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
 	__ClearPageUnaccepted(page);
@@ -7222,28 +7210,6 @@ static void __accept_page(struct zone *zone, unsigned long *flags,
 	accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
 
 	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
-
-	if (last) {
-		/*
-		 * There are two corner cases:
-		 *
-		 * - If allocation occurs during the CPU bring up,
-		 *   static_branch_dec() cannot be used directly as
-		 *   it causes a deadlock on cpu_hotplug_lock.
-		 *
-		 *   Instead, use schedule_work() to prevent deadlock.
-		 *
-		 * - If allocation occurs before workqueues are initialized,
-		 *   static_branch_dec() should be called directly.
-		 *
-		 *   Workqueues are initialized before CPU bring up, so this
-		 *   will not conflict with the first scenario.
-		 */
-		if (system_wq)
-			schedule_work(&zone->unaccepted_cleanup);
-		else
-			unaccepted_cleanup_work(&zone->unaccepted_cleanup);
-	}
 }
 
 void accept_page(struct page *page)
@@ -7280,20 +7246,12 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	return true;
 }
 
-static inline bool has_unaccepted_memory(void)
-{
-	return static_branch_unlikely(&zones_with_unaccepted_pages);
-}
-
 static bool cond_accept_memory(struct zone *zone, unsigned int order,
 			       int alloc_flags)
 {
 	long to_accept, wmark;
 	bool ret = false;
 
-	if (!has_unaccepted_memory())
-		return false;
-
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
@@ -7331,22 +7289,17 @@ static bool __free_unaccepted(struct page *page)
 {
 	struct zone *zone = page_zone(page);
 	unsigned long flags;
-	bool first = false;
 
 	if (!lazy_accept)
 		return false;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	first = list_empty(&zone->unaccepted_pages);
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
 	account_freepages(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
 	__SetPageUnaccepted(page);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	if (first)
-		static_branch_inc(&zones_with_unaccepted_pages);
-
 	return true;
 }
 
-- 
2.47.2


