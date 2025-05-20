Return-Path: <stable+bounces-145013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40384ABD05C
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56763B09C2
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7690925D207;
	Tue, 20 May 2025 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUYcgP0I"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBC325C711
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747725810; cv=none; b=amBVBshE0SsM0fE1kskpWJ+gFKtGt5ijtDOF+AnhRa7iFWoWTjYYZwbZ0Tu9bmRu2lk376KWDLAElXMj+EC69waE3+/U72W8kmx7R2xdUBU0eqGKlziyzVMaBAYwOqth1WgfQg+03c0T1MxPxQsSR7wlhEtI/PBIXGawm3uq/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747725810; c=relaxed/simple;
	bh=MS1qEWwSc+cPpRwfnoFMRCjUsypxvDK/6MU7VIuNZbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dd9IDnwDXWouWVAUa63eOg0EjSzEXMARoyW5byV4FloTBYRMpjmIiigFSeO0oZN2LGIqkwZkPmfBaB8yZGafSDzjoZ5Yq1EEd8DIGqjPBGf/P/nzZiDiIstcqFoFVdpaIQrrzaergyCplN0pdP8XdUlbXqwo6vI5YJqubN/V8hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUYcgP0I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747725808; x=1779261808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MS1qEWwSc+cPpRwfnoFMRCjUsypxvDK/6MU7VIuNZbQ=;
  b=gUYcgP0ImLivejhj9tgLoLWPScM8bqDgZARRMsBHUXt4Tz39O1CNWvTp
   rmJWhGq4RDUohAxgWpxdjXB9S7ZX4V4S4IXaiZRd65ojsX6x89usdjPHM
   RZG9Zqo0FxskaN5KOBID7NKGIiD0PSQnK+l3VDmsjR3hz2WLowMAKJ1bK
   j3Nlo+3QKOJiGobqUhTNyppXxv/ZhgYT8VeMa15IX7IVOrOrblEEB40Km
   tzJeK3Ci3vtDswFKfwTyGMo2SrzXa404JE+vzWEtgP0nzxAZTuVFqHEb+
   FvKg6duw4MLWYwKvvHLwDYmD6m4zHjgMzKi9mH/NxeC2na4w3ltYzyFKC
   w==;
X-CSE-ConnectionGUID: POAf4anZRp6feL6bnQJEOg==
X-CSE-MsgGUID: 2Wn9CJ70S66NZ4868AjIUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49746766"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49746766"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 00:23:27 -0700
X-CSE-ConnectionGUID: LEIX0AA8T1GIKxZ3HkqMHA==
X-CSE-MsgGUID: yvjS7gC7Q2WubxgeH8/oYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140617559"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 20 May 2025 00:23:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E08B9209; Tue, 20 May 2025 10:23:23 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: stable@vger.kernel.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.14.y] mm/page_alloc: fix race condition in unaccepted memory handling
Date: Tue, 20 May 2025 10:23:20 +0300
Message-ID: <20250520072320.605775-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025051944-undone-repayment-6c7e@gregkh>
References: <2025051944-undone-repayment-6c7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page allocator tracks the number of zones that have unaccepted memory
using static_branch_enc/dec() and uses that static branch in hot paths to
determine if it needs to deal with unaccepted memory.

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

Link: https://lkml.kernel.org/r/20250506133207.1009676-1-kirill.shutemov@linux.intel.com
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
Link: https://lore.kernel.org/all/20250506092445.GBaBnVXXyvnazly6iF@fat_crate.local
Reported-by: Borislav Petkov <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>	[6.5+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit fefc075182275057ce607effaa3daa9e6e3bdc73)
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/page_alloc.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 74a996a3508e..2cc8b3e36dc9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6951,9 +6951,6 @@ bool has_managed_dma(void)
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 
-/* Counts number of zones with unaccepted pages. */
-static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
-
 static bool lazy_accept = true;
 
 static int __init accept_memory_parse(char *p)
@@ -6980,11 +6977,7 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
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
@@ -6993,9 +6986,6 @@ static void __accept_page(struct zone *zone, unsigned long *flags,
 	accept_memory(page_to_phys(page), PAGE_SIZE << MAX_PAGE_ORDER);
 
 	__free_pages_ok(page, MAX_PAGE_ORDER, FPI_TO_TAIL);
-
-	if (last)
-		static_branch_dec(&zones_with_unaccepted_pages);
 }
 
 void accept_page(struct page *page)
@@ -7032,19 +7022,11 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	return true;
 }
 
-static inline bool has_unaccepted_memory(void)
-{
-	return static_branch_unlikely(&zones_with_unaccepted_pages);
-}
-
 static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	long to_accept, wmark;
 	bool ret = false;
 
-	if (!has_unaccepted_memory())
-		return false;
-
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
@@ -7078,22 +7060,17 @@ static bool __free_unaccepted(struct page *page)
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


