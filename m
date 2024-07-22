Return-Path: <stable+bounces-60704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B047A939052
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 16:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328D31F21F19
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C14D16D9CA;
	Mon, 22 Jul 2024 14:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHQO925r"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B78F5E;
	Mon, 22 Jul 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657279; cv=none; b=cywAROSnvO8o6IlvGi//32YRVOLGPdJc5Yru2GxjezyWTLMQpCu9XGRy0Avb3KUr+3B4yea/Tn8hi/DRyJn2UsElzArZ/TZfG4EwWE2YRYz1Ke+gkZHbKKEEAmjip/hIR8Ulk4YX4ROg2vH9/7PM2qdXl/93sAFXECIoAt/CE2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657279; c=relaxed/simple;
	bh=+eZHdJDabvhe4yJl+I++bXRcuLcMT5qaWJvUi9IaS8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg3762vJgd9T97vgnskq/jIn4VKI1IAGsCCgru/XOAgS5FubkrfHmpeAdgXRzFJgx8cXffbgnsiyVla3AajTGyJZ3UMpPfb+ShJzPI36I3J4G2xyWcF1fdqCHl62r21lZ2+/dLdMk6DIEAetSJjch7utQTtSdhLqXfIGH/Sx86s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHQO925r; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721657278; x=1753193278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+eZHdJDabvhe4yJl+I++bXRcuLcMT5qaWJvUi9IaS8A=;
  b=VHQO925rkFnZO6wJnRhzk8njwDFsIbyIx1Ydx82tt+Hy3BCfl9HHgp/Z
   A+jupAvxF2Ts0vf4uIKCQDzHIUUGZ44OJt7Vcu1zR+U2uPwdlqJGp/We1
   hY139+d78IQhjfUhVS7Y0PrKHkbD9983JO+6yChgCjcZotvWEgIKL9XUf
   9C3XG+7pRY5LjceKAPaFjaD/GyTKVrxNnzWX2jDpjz0Iw1g12M+7m3emZ
   iyjjprQ/p7vBAR/TthYfh24lpsYmshAvuNGV+mku2zR56sn4GdTmRL6al
   EcFVhX1E0GFJlzigyQK5gKvC2yi7gGvDrLx6ynxB0fCb8OBMd3/wolVzi
   g==;
X-CSE-ConnectionGUID: TPw3bl/BRp6JZ/KG4NZ91g==
X-CSE-MsgGUID: ypr4qVZBSzGv7/moWLHjIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="18932538"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="18932538"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 07:07:49 -0700
X-CSE-ConnectionGUID: ofWiXJEZQwS3NF984WTZng==
X-CSE-MsgGUID: wQZBfRJeTvOFGUBExfTpLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="82537212"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 22 Jul 2024 07:07:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E0A04540; Mon, 22 Jul 2024 17:07:44 +0300 (EEST)
Date: Mon, 22 Jul 2024 17:07:44 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jianxiong Gao <jxgao@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted
 memory.
Message-ID: <brjw4kb3x4wohs4a6y5lqxr6a5zlz3m45hiyyyht5mgrqcryk7@m7mdyojo4h6a>
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
 <ZpdwcOv9WiILZNvz@tiehlicka>
 <xtcmz6b66wayqxzfio4funmrja7ezgmp3mvudjodt5xfx64rot@s6whj735oimb>
 <Zpez1rkIQzVWxi7q@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zpez1rkIQzVWxi7q@tiehlicka>

On Wed, Jul 17, 2024 at 02:06:46PM +0200, Michal Hocko wrote:
> Please try to investigate this further. The patch as is looks rather
> questionable to me TBH. Spilling unaccepted memory into the reclaim
> seems like something we should avoid if possible as this is something

Okay, I believe I have a better understanding of the situation:

- __alloc_pages_bulk() takes pages from the free list without accepting
  more memory. This can cause number of free pages to fall below the
  watermark.

  This issue can be resolved by accepting more memory in
  __alloc_pages_bulk() if the watermark check fails.

  The problem is not only related to unallocated memory. I think the
  deferred page initialization mechanism could result in premature OOM if
  __alloc_pages_bulk() allocates pages faster than deferred page
  initialization can add them to the free lists. However, this scenario is
  unlikely.

- There is nothing that compels the kernel to accept more memory after the
  watermarks have been calculated in __setup_per_zone_wmarks(). This can
  put us under the watermark.

  This issue can be resolved by accepting memory up to the watermark after
  the watermarks have been initialized.

- Once kswapd is started, it will begin spinning if we are below the
  watermark and there is no memory that can be reclaimed. Once the above
  problems are fixed, the issue will be resolved.

- The kernel needs to accept memory up to the PROMO watermark. This will
  prevent unaccepted memory from interfering with NUMA balancing.

The patch below addresses the issues I listed earlier. It is not yet ready
for application. Please see the issues listed below.

Andrew, please drop the current patch.

There are a few more things I am worried about:

- The current get_page_from_freelist() and patched __alloc_pages_bulk()
  only try to accept memory if the requested (alloc_flags & ALLOC_WMARK_MASK)
  watermark check fails. For example, if a requested allocation with
  ALLOC_WMARK_MIN is called, we will not try to accept more memory, which
  could potentially put us under the high/promo watermark and cause the
  following kswapd start to get us into an endless loop.

  Do we want to make memory acceptance in these paths independent of
  alloc_flags?

- __isolate_free_page() removes a page from the free list without
  accepting new memory. The function is called with the zone lock taken.
  It is bad idea to accept memory while holding the zone lock, but
  the alternative of pushing the accept to the caller is not much better.

  I have not observed any issues caused by __isolate_free_page() in
  practice, but there is no reason why it couldn't potentially cause
  problems.
 
- The function take_pages_off_buddy() also removes pages from the free
  list without accepting new memory. Unlike the function
  __isolate_free_page(), it is called without the zone lock being held, so
  we can accept memory there. I believe we should do so.

I understand why adding unaccepted memory handling into the reclaim path
is questionable. However, it may be the best way to handle cases like
__isolate_free_page() and possibly others in the future that directly take
memory from free lists.

Any thoughts?

I am still new to reclaim code and may be overlooking something
significant. Please correct any misconceptions you see.

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
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c62805dbd608..d537c633c6e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1748,7 +1748,7 @@ static bool pgdat_free_space_enough(struct pglist_data *pgdat)
 			continue;
 
 		if (zone_watermark_ok(zone, 0,
-				      wmark_pages(zone, WMARK_PROMO) + enough_wmark,
+				      promo_wmark_pages(zone) + enough_wmark,
 				      ZONE_MOVABLE, 0))
 			return true;
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 14d39f34d336..b744743d14a2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4462,6 +4462,22 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 				alloc_flags, gfp)) {
 			break;
 		}
+
+		if (has_unaccepted_memory()) {
+			if (try_to_accept_memory(zone, 0))
+				break;
+		}
+
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+		/*
+		 * Watermark failed for this zone, but see if we can
+		 * grow this zone if it contains deferred pages.
+		 */
+		if (deferred_pages_enabled()) {
+			if (_deferred_grow_zone(zone, 0))
+				break;
+		}
+#endif
 	}
 
 	/*
@@ -5899,6 +5915,9 @@ static void __setup_per_zone_wmarks(void)
 		zone->_watermark[WMARK_PROMO] = high_wmark_pages(zone) + tmp;
 
 		spin_unlock_irqrestore(&zone->lock, flags);
+
+		if (managed_zone(zone))
+			try_to_accept_memory(zone, 0);
 	}
 
 	/* update totalreserve_pages */
@@ -6866,8 +6885,8 @@ static bool try_to_accept_memory(struct zone *zone, unsigned int order)
 	long to_accept;
 	int ret = false;
 
-	/* How much to accept to get to high watermark? */
-	to_accept = high_wmark_pages(zone) -
+	/* How much to accept to get to promo watermark? */
+	to_accept = wmark_pages(zone, WMARK_PROMO) -
 		    (zone_page_state(zone, NR_FREE_PAGES) -
 		    __zone_watermark_unusable_free(zone, order, 0));
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3ef654addd44..d20242e36904 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6607,7 +6607,7 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
 			continue;
 
 		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
-			mark = wmark_pages(zone, WMARK_PROMO);
+			mark = promo_wmark_pages(zone);
 		else
 			mark = high_wmark_pages(zone);
 		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

