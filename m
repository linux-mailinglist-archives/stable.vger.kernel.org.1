Return-Path: <stable+bounces-60790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 579CC93A20E
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231A9B230FB
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF0153BE4;
	Tue, 23 Jul 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0IgMIvB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3386315380D;
	Tue, 23 Jul 2024 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742792; cv=none; b=M1jROSDBRI8LQ7Ca3CHa5hE0l2fBsZs52s8mYC9X9gnHhxg3dXpfbwonuE97J+idxOdOeLL0g/6Q9Z6ImkHU+joL4RMgk2VtrcyUnbCJismM+HDkJK/nvNXGLwKk5sbKpXMmexEDasqSZ549aKquGTC5gBxqVRKxZYCh+8Hok7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742792; c=relaxed/simple;
	bh=9eIWzhU6PHUeZcWjbzL9hcWDlD4iJH3dlG5ZDJi3+yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaszaKOtqBAjtmMj9MpBnZpIkhvv8Flwmw1KJvkAq8K8WGByUG0yzWWjvbWrngBuEV32j1GFNmgVFSqKSUtngDPQ9Ue+3qBG1bDU0JJKaqRU8DHXc4IMrdBDHSU17fSRF7fZOi0zOt6NW133+L39CScYqdPMBHnYNU+oXMKmxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0IgMIvB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721742790; x=1753278790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9eIWzhU6PHUeZcWjbzL9hcWDlD4iJH3dlG5ZDJi3+yI=;
  b=F0IgMIvBMgTTBMdbnprQUp5DaXWh6FEi9efAg9DI+euLK09hxr2cVD5Q
   tEoKpBgFj8gZFUh/omxtIUksC5yzQhIlKqGEGYU5Dt7hzjjwRousOtMrp
   HDhGcc+Fr+w4+0assZfzU5wvQ2ioKDgGWbrGiPQHs6mg7RFryd+zWADXz
   I759AHNus27P2b/PvQZQZ0yhzHc064t9hPLfZDmv2AO+mVburL3v6lkKo
   kffv6hYZR3/nBx76rxBtD654w9tunvRrzcI2+1HWB+4MXMvJof2U/HmBM
   9U6htFQHpJoCsGBIS1KJhatth3/Otb757Nfgg10Lc8yLkeYrltkzfxuCc
   g==;
X-CSE-ConnectionGUID: +UIr3BZET+mMhrWhhzDAzg==
X-CSE-MsgGUID: /5KZz38HSK2UbO9tjtCf8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="44791310"
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="44791310"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 06:53:10 -0700
X-CSE-ConnectionGUID: LNctsrrjTcmE1nFGbnMeWA==
X-CSE-MsgGUID: MZMeXLF1SF6STUXCCbCX9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,230,1716274800"; 
   d="scan'208";a="57085378"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 23 Jul 2024 06:53:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 8C119178; Tue, 23 Jul 2024 16:53:05 +0300 (EEST)
Date: Tue, 23 Jul 2024 16:53:05 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mel Gorman <mgorman@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jianxiong Gao <jxgao@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Message-ID: <mdsrik4ryedfe62hnhokejq7botphyvodydcvsbcrdsmwufv7w@oasahvgppsbd>
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
 <ZpdwcOv9WiILZNvz@tiehlicka>
 <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>
 <Zpez1rkIQzVWxi7q@tiehlicka>
 <brjw4kb3x4wohs4a6y5lqxr6a5zlz3m45hiyyyht5mgrqcryk7@m7mdyojo4h6a>
 <564ff8e4-42c9-4a00-8799-eaa1bef9c338@suse.cz>
 <dili5kn3xjjzamwmyxjgdkf5vvh6sqftm7qk4f2vbxuizfzlb2@xrtxlvlqaos5>
 <Zp-aIfs3DNhAVBmO@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp-aIfs3DNhAVBmO@tiehlicka>

On Tue, Jul 23, 2024 at 01:55:13PM +0200, Michal Hocko wrote:
> On Tue 23-07-24 12:49:41, Kirill A. Shutemov wrote:
> > On Tue, Jul 23, 2024 at 09:30:27AM +0200, Vlastimil Babka wrote:
> [...]
> > > Although just removing the lazy accept mode would be much more appealing
> > > solution than this :)
> > 
> > :P
> > 
> > Not really an option for big VMs. It might add many minutes to boot time.
> 
> Well a huge part of that can be done in the background so the boot
> doesn't really have to wait for all of it. If we really have to start
> playing whack-a-mole to plug all the potential ways to trigger reclaim
> imbalance I think it is fair to re-evaluate how much lazy should the
> initialization really be.

One other option I see is to treat unaccepted memory as free, so
watermarks would not fail if we have unaccepted memory. No spinning in
kswapd in this case.

Only get_page_from_freelist() and __alloc_pages_bulk() is aware about
unaccepted memory.

The quick patch below shows the idea.

I am not sure how it would affect __isolate_free_page() callers. IIUC,
they expect to see pages on free lists, but might not find them there
in this scenario because they are not accepted yet.
I need to look closer at this.

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c11b7cde81ef..5e0bdfbe2f1f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -667,6 +667,7 @@ enum zone_watermarks {
 #define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
 #define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
 #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
+#define promo_wmark_pages(z) (z->_watermark[WMARK_PROMO] + z->watermark_boost)
 #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14d39f34d336..254bfe29eaf1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -304,7 +304,7 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 static bool page_contains_unaccepted(struct page *page, unsigned int order);
 static void accept_page(struct page *page, unsigned int order);
-static bool try_to_accept_memory(struct zone *zone, unsigned int order);
+static bool cond_accept_memory(struct zone *zone, unsigned int order);
 static inline bool has_unaccepted_memory(void);
 static bool __free_unaccepted(struct page *page);
 
@@ -2947,9 +2947,6 @@ static inline long __zone_watermark_unusable_free(struct zone *z,
 	if (!(alloc_flags & ALLOC_CMA))
 		unusable_free += zone_page_state(z, NR_FREE_CMA_PAGES);
 #endif
-#ifdef CONFIG_UNACCEPTED_MEMORY
-	unusable_free += zone_page_state(z, NR_UNACCEPTED);
-#endif
 
 	return unusable_free;
 }
@@ -3243,6 +3240,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			}
 		}
 
+		cond_accept_memory(zone, order);
+
 		/*
 		 * Detect whether the number of free pages is below high
 		 * watermark.  If so, we will decrease pcp->high and free
@@ -3268,10 +3267,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
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
@@ -3325,10 +3322,8 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 
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
@@ -4456,12 +4451,25 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			goto failed;
 		}
 
+		cond_accept_memory(zone, 0);
+retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages;
 		if (zone_watermark_fast(zone, 0,  mark,
 				zonelist_zone_idx(ac.preferred_zoneref),
 				alloc_flags, gfp)) {
 			break;
 		}
+
+		if (cond_accept_memory(zone, 0))
+			goto retry_this_zone;
+
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+		/* Try again if zone has deferred pages */
+		if (deferred_pages_enabled()) {
+			if (_deferred_grow_zone(zone, 0))
+				goto retry_this_zone;
+		}
+#endif
 	}
 
 	/*
@@ -6833,9 +6841,6 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	struct page *page;
 	bool last;
 
-	if (list_empty(&zone->unaccepted_pages))
-		return false;
-
 	spin_lock_irqsave(&zone->lock, flags);
 	page = list_first_entry_or_null(&zone->unaccepted_pages,
 					struct page, lru);
@@ -6861,23 +6866,29 @@ static bool try_to_accept_memory_one(struct zone *zone)
 	return true;
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
 	long to_accept;
 	int ret = false;
 
-	/* How much to accept to get to high watermark? */
-	to_accept = high_wmark_pages(zone) -
-		    (zone_page_state(zone, NR_FREE_PAGES) -
-		    __zone_watermark_unusable_free(zone, order, 0));
+	if (!has_unaccepted_memory())
+		return false;
 
-	/* Accept at least one page */
-	do {
+	if (list_empty(&zone->unaccepted_pages))
+		return false;
+
+	/* How much to accept to get to high watermark? */
+	to_accept = promo_wmark_pages(zone) -
+		    (zone_page_state(zone, NR_FREE_PAGES) -
+		    __zone_watermark_unusable_free(zone, order, 0) -
+		    zone_page_state(zone, NR_UNACCEPTED));
+
+	while (to_accept > 0) {
 		if (!try_to_accept_memory_one(zone))
 			break;
 		ret = true;
 		to_accept -= MAX_ORDER_NR_PAGES;
-	} while (to_accept > 0);
+	}
 
 	return ret;
 }
@@ -6920,7 +6931,7 @@ static void accept_page(struct page *page, unsigned int order)
 {
 }
 
-static bool try_to_accept_memory(struct zone *zone, unsigned int order)
+static bool cond_ccept_memory(struct zone *zone, unsigned int order)
 {
 	return false;
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

