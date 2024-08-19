Return-Path: <stable+bounces-69502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB33956772
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B53C1C2158D
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3BC15696E;
	Mon, 19 Aug 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z3UPq4wS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C265013B592
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060956; cv=none; b=ONsGseqmlcmzBWD39qd3wFmhJyt2IJ7d0wxae2/hUDNEsbVCAAa8qD+KOpWUzNIF1/OxClzaxeWcGu8hcpvBieHt8IGsNpuhfbeZlDkzhDHo9evINvo9yAYP781V6vWyqelsEIvMpT3Gd5Sg8pfa/WC31XiF0CaSJ3qpXnx9CQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060956; c=relaxed/simple;
	bh=438/xGI7Xb9HUPqGOqZdWbrJinAn1kkfPMjgPliCgko=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aHULSmfGF8RPn9Vy2prxPMZeqkKkwf87GW/mQThBpPc1Rplt3wkKVR55+/k3oNYB0KzEgrq3PW7x2PHhpcfmqc5DrVRVPrQCHXhs03mUlF4WGFPCEOKFqrr5edxHRAsC39O+ajvXgPvGQF1xPJbGqM99xJE7hynybCOgBxsmzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z3UPq4wS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6D0C4AF09;
	Mon, 19 Aug 2024 09:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724060956;
	bh=438/xGI7Xb9HUPqGOqZdWbrJinAn1kkfPMjgPliCgko=;
	h=Subject:To:Cc:From:Date:From;
	b=z3UPq4wSQtN2h4YDHN6973J5Xq4OqDmd/KrIViUphP89spyAdo6ELB01D3mz9iDx/
	 RF5bx6ru5l0M+ejyapUkbuzjbj1RH9fLCEn7TMyt1P4BEbXa9co71tnHOv4WEN+5BZ
	 ZTHQKGKahz4F/pARAVkOntSD4syJtTMoYMniPukI=
Subject: FAILED: patch "[PATCH] mm: fix endless reclaim on machines with unaccepted memory" failed to apply to 6.6-stable tree
To: kirill.shutemov@linux.intel.com,akpm@linux-foundation.org,bp@alien8.de,david@redhat.com,hannes@cmpxchg.org,jxgao@google.com,mgorman@suse.de,rppt@kernel.org,stable@vger.kernel.org,thomas.lendacky@amd.com,vbabka@suse.cz,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:49:13 +0200
Message-ID: <2024081913-outbid-skincare-1e41@gregkh>
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
git cherry-pick -x 807174a93d24c456503692dc3f5af322ee0b640a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081913-outbid-skincare-1e41@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

807174a93d24 ("mm: fix endless reclaim on machines with unaccepted memory")
57c0419c5f0e ("mm, pcp: decrease PCP high if free pages < high watermark")
51a755c56dc0 ("mm: tune PCP high automatically")
90b41691b988 ("mm: add framework for PCP high auto-tuning")
c0a242394cb9 ("mm, page_alloc: scale the number of pages that are batch allocated")
52166607ecc9 ("mm: restrict the pcp batch scale factor to avoid too long latency")
362d37a106dd ("mm, pcp: reduce lock contention for draining high-order pages")
94a3bfe4073c ("cacheinfo: calculate size of per-CPU data cache slice")
ca71fe1ad922 ("mm, pcp: avoid to drain PCP when process exit")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 807174a93d24c456503692dc3f5af322ee0b640a Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 9 Aug 2024 14:48:47 +0300
Subject: [PATCH] mm: fix endless reclaim on machines with unaccepted memory

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

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 875d76e8684a..8747087acee3 100644
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
@@ -6950,9 +6945,6 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	struct page *page;
 	bool last;
 
-	if (list_empty(&zone->unaccepted_pages))
-		return false;
-
 	spin_lock_irqsave(&zone->lock, flags);
 	page = list_first_entry_or_null(&zone->unaccepted_pages,
 					struct page, lru);
@@ -6978,23 +6970,29 @@ static bool try_to_accept_memory_one(struct zone *zone)
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
@@ -7037,7 +7035,7 @@ static void accept_page(struct page *page, unsigned int order)
 {
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	return false;
 }


