Return-Path: <stable+bounces-145024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6802ABD144
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 10:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760F816914A
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85520E71D;
	Tue, 20 May 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QESuIcSA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC994B1E72
	for <stable@vger.kernel.org>; Tue, 20 May 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728051; cv=none; b=Diy3BI5kfsGoqt0CXaeXN/l973pWrhz8KjuTkrINobbwcKKvhnb5vWwuMzKrFo72r+NDHg6LOoMgP6HE6RMzzvihHPQ6EvofK0GTg5bk2X0lFQcS50QEkaNvY9lj4C+Wt4UNFMO6zsZEjO78yU30GhlGsOlM2fgLsqlBMNBbTu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728051; c=relaxed/simple;
	bh=BENfNcDlZdrcShm4/1nC70Evj6UQQ23PpQvS9SafHU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=msDZ2HFDyO/t/AlZXhS1SNJSNTxQO4i4QNAa3p6LBWCZ6tbkjCwXD2/+fz2K0dEUk547Tk41BpLRjn4XQlWIEv0JllqdL+Zwq1GDrBznFKrlZEfGqG9+5aLjfHyWOAwr8aMS6u7LX8y7tMw7npAVVzZaVTti9R9v9E8Ig0xxjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QESuIcSA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747728050; x=1779264050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BENfNcDlZdrcShm4/1nC70Evj6UQQ23PpQvS9SafHU8=;
  b=QESuIcSAnkrXfBoyo2z4IwcjpXPRgY9WKFkKkE7HxP6AiJJGN4huqOeo
   b9O00I69+xXCjo32DwjGsN/2MYrFfiMDpkPQTZax/QqNBAprAKQMEEwEs
   uXSJoIB7ipQKBOgVAPddc1wXhd35haTZsSMPafBLWiWq+M3TKZ4UCzids
   XpOjP1CvQFAcDUsrnU1wlefVLY281BjMWG1zJGrWQrBivpfBhMgGjv8Vj
   s0pfLiltUyq18cQWVNkj8cc1QkwxoDGF24i3bfG187YDHqmvHsa+i8pWV
   aZQumVtymcCo70s5LgoD7qwECO7Ye75Uz0yao5EpLubzXUGOlcM7oAiat
   g==;
X-CSE-ConnectionGUID: B48zs6bbSkeDUPHJxH7vKQ==
X-CSE-MsgGUID: RvJB3gHsQPOelDAmtkNwQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="53450843"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="53450843"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 01:00:49 -0700
X-CSE-ConnectionGUID: PcDYMF+gSFqpKWaSdelCDg==
X-CSE-MsgGUID: vyQn3o8tQtKVRzbg+rPSZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140029961"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 20 May 2025 01:00:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 502F2209; Tue, 20 May 2025 11:00:45 +0300 (EEST)
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
Subject: [PATCH 6.6.y] mm/page_alloc: fix race condition in unaccepted memory handling
Date: Tue, 20 May 2025 11:00:39 +0300
Message-ID: <20250520080039.679077-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2025051947-dimly-marina-9d5e@gregkh>
References: <2025051947-dimly-marina-9d5e@gregkh>
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
 mm/page_alloc.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bc62bb2a3b13..74737c35082b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -303,7 +303,6 @@ EXPORT_SYMBOL(nr_online_nodes);
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
 static bool cond_accept_memory(struct zone *zone, unsigned int order);
-static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
 int page_group_by_mobility_disabled __read_mostly;
@@ -6586,9 +6585,6 @@ bool has_managed_dma(void)
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 
-/* Counts number of zones with unaccepted pages. */
-static DEFINE_STATIC_KEY_FALSE(zones_with_unaccepted_pages);
-
 static bool lazy_accept = true;
 
 static int __init accept_memory_parse(char *p)
@@ -6624,7 +6620,6 @@ static bool try_to_accept_memory_one(struct zone *zone)
 {
 	unsigned long flags;
 	struct page *page;
-	bool last;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	page = list_first_entry_or_null(&zone->unaccepted_pages,
@@ -6635,7 +6630,6 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	}
 
 	list_del(&page->lru);
-	last = list_empty(&zone->unaccepted_pages);
 
 	__mod_zone_freepage_state(zone, -MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, -MAX_ORDER_NR_PAGES);
@@ -6645,9 +6639,6 @@ static bool try_to_accept_memory_one(struct zone *zone)
 
 	__free_pages_ok(page, MAX_ORDER, FPI_TO_TAIL);
 
-	if (last)
-		static_branch_dec(&zones_with_unaccepted_pages);
-
 	return true;
 }
 
@@ -6656,9 +6647,6 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	long to_accept, wmark;
 	bool ret = false;
 
-	if (!has_unaccepted_memory())
-		return false;
-
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
@@ -6688,30 +6676,20 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	return ret;
 }
 
-static inline bool has_unaccepted_memory(void)
-{
-	return static_branch_unlikely(&zones_with_unaccepted_pages);
-}
-
 static bool __free_unaccepted(struct page *page)
 {
 	struct zone *zone = page_zone(page);
 	unsigned long flags;
-	bool first = false;
 
 	if (!lazy_accept)
 		return false;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	first = list_empty(&zone->unaccepted_pages);
 	list_add_tail(&page->lru, &zone->unaccepted_pages);
 	__mod_zone_freepage_state(zone, MAX_ORDER_NR_PAGES, MIGRATE_MOVABLE);
 	__mod_zone_page_state(zone, NR_UNACCEPTED, MAX_ORDER_NR_PAGES);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
-	if (first)
-		static_branch_inc(&zones_with_unaccepted_pages);
-
 	return true;
 }
 
@@ -6731,11 +6709,6 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	return false;
 }
 
-static inline bool has_unaccepted_memory(void)
-{
-	return false;
-}
-
 static bool __free_unaccepted(struct page *page)
 {
 	BUILD_BUG();
-- 
2.47.2


