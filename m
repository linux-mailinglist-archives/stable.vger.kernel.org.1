Return-Path: <stable+bounces-144844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED35ABBED6
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7D4162726
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 13:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9127935D;
	Mon, 19 May 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lNODyXUJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD33A55
	for <stable@vger.kernel.org>; Mon, 19 May 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660440; cv=none; b=rXeBhu0efLVOE5OnDdcXBOldSO142LuKYFhC8sTLn83IMo5G4dQ/Ik9F1hqfyls3EOnvPHDFsYKbNNFzjcpQ7vb4PpcF7j4LGJn0lmfADquD86I0hTsVvL6xxOO+NBNen5x3CniB96iG6FKtrCn3YbkfhVSLMDAO7x1LFxvuHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660440; c=relaxed/simple;
	bh=NmykDT4gcL28J9UQLwOj5cL1amqoADH3C6diuzQaR+w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tIaYbBNF0TBiSki1wl2s4t0BhJAiYnnOJd2VX/fOrJG8d/R644UDnpQ0GZE6gOKGIQGh1dv6xsjt5gxoUhGhBHbKM8hI/mFfqboLEm6Xr3HGhykOOemjLMIf3/0YAScRfo/AohkOM+OuWAM3BmaxCfq0vdj2Mm7mCeV8WEW0JHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lNODyXUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4982C4CEE4;
	Mon, 19 May 2025 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747660440;
	bh=NmykDT4gcL28J9UQLwOj5cL1amqoADH3C6diuzQaR+w=;
	h=Subject:To:Cc:From:Date:From;
	b=lNODyXUJKYAGfeTfrFrIKpU6ySFr5c6ld99/zRSRCRkCIFUijCC07besTtBfEckZ8
	 wdvA0yjD0AjTHbeQgdEoRL4TZuVx2N7qhcsl2R2hCLhmk8UxZyX53JsUvLKC47bNw5
	 E2nCNUAP93mZm5QvcDq8bhswnmkW1CH2Uf+87rCI=
Subject: FAILED: patch "[PATCH] mm/page_alloc: fix race condition in unaccepted memory" failed to apply to 6.6-stable tree
To: kirill.shutemov@linux.intel.com,akpm@linux-foundation.org,bp@alien8.de,hannes@cmpxchg.org,jackmanb@google.com,mhocko@suse.com,stable@vger.kernel.org,surenb@google.com,tglx@linutronix.de,vbabka@suse.cz
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 May 2025 15:13:47 +0200
Message-ID: <2025051947-dimly-marina-9d5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fefc075182275057ce607effaa3daa9e6e3bdc73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051947-dimly-marina-9d5e@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fefc075182275057ce607effaa3daa9e6e3bdc73 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Tue, 6 May 2025 16:32:07 +0300
Subject: [PATCH] mm/page_alloc: fix race condition in unaccepted memory
 handling

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

diff --git a/mm/internal.h b/mm/internal.h
index 25a29872c634..5c7a2b43ad76 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1590,7 +1590,6 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc);
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 void accept_page(struct page *page);
-void unaccepted_cleanup_work(struct work_struct *work);
 #else /* CONFIG_UNACCEPTED_MEMORY */
 static inline void accept_page(struct page *page)
 {
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 327764ca0ee4..eedce9321e13 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1441,7 +1441,6 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 
 #ifdef CONFIG_UNACCEPTED_MEMORY
 	INIT_LIST_HEAD(&zone->unaccepted_pages);
-	INIT_WORK(&zone->unaccepted_cleanup, unaccepted_cleanup_work);
 #endif
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7248e300d36e..8258349e49ac 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7172,16 +7172,8 @@ bool has_managed_dma(void)
 
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
@@ -7206,11 +7198,7 @@ static bool page_contains_unaccepted(struct page *page, unsigned int order)
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
@@ -7219,28 +7207,6 @@ static void __accept_page(struct zone *zone, unsigned long *flags,
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
@@ -7277,20 +7243,12 @@ static bool try_to_accept_memory_one(struct zone *zone)
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
 
@@ -7328,22 +7286,17 @@ static bool __free_unaccepted(struct page *page)
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
 


