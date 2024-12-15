Return-Path: <stable+bounces-104221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2014B9F221E
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 04:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EC8188507A
	for <lists+stable@lfdr.de>; Sun, 15 Dec 2024 03:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D79450;
	Sun, 15 Dec 2024 03:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DdsQfMBc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B9946C;
	Sun, 15 Dec 2024 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734233400; cv=none; b=b27fxNz/ggQAdKlpIkV5rkUe1SlPnUcEOKGORur1nRp3ir97gzCKLK16gHbyZzbP6euyB24FKuoQ87OvqjOBcHrqHBPaojQGka1ccZ6LkgmPUbUo6fpTHtXYuRlFxRn4d8G4mpVvFpL75A6L68mPqYVitzDoDS5vfOo7uw2zNo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734233400; c=relaxed/simple;
	bh=/NX2EoaKM0CshF8ayVfhRdRlhGgTbc6ZwoH2EXyMGFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5JTsA4EkjJeSK1SU+fYaU65/fnNYGtg2Lr4yfVgdd2OQA1V3o7pGDYGJiU9IJbenSQ0gy60ieQ0hpfHAR8L84kvU5JKNV05+UUDKPZLwkNXSroagU2v878vHJP5OkwUMETJzqkPgbbLiX05mxd2LAgV2JlEovWBuoOv21fI+Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DdsQfMBc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734233397; x=1765769397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/NX2EoaKM0CshF8ayVfhRdRlhGgTbc6ZwoH2EXyMGFQ=;
  b=DdsQfMBcVZbcLACDFwhECn+lA7iphNu4e4EQe5uVzS15LvLb5y5EZhXA
   iJeZ9CaJp4R3gf+eqI9a2zVkeGqDnK3fDzWhSZOjmGogpvl6caOVnas/b
   qRJSXb2/pztC4QimS6pPgyL2+uBVcHLTUSqBvU63emml1BnmvHsyCzBVs
   jEiPfi31qzGpVaHqO2Q3HAvKRixgFJ8go6ZkNBfsuekch5LI2/6KTTfd1
   gYNOMhmw35Sm+jaSp7ab67eTuway8AC5qrvJ+SuawHvUvRYk1yBZ5AYeE
   6c8cRgmDxkfjJAlT/UWEtRO7cf/6nJhmEKfxb3r6lj5OIAUWUocApHshX
   Q==;
X-CSE-ConnectionGUID: IaO9tpA8QZCNEsZ3md1zsw==
X-CSE-MsgGUID: s1gBHvZgQRWVQzR4XcX5iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="46040090"
X-IronPort-AV: E=Sophos;i="6.12,214,1728975600"; 
   d="scan'208";a="46040090"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 19:29:57 -0800
X-CSE-ConnectionGUID: JeaPkRPVQA2mB1GwWL2aeA==
X-CSE-MsgGUID: BmK1I43cRvGQvhA3Xj2xXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97679538"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Dec 2024 19:29:54 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMfKJ-000DP2-1X;
	Sun, 15 Dec 2024 03:29:51 +0000
Date: Sun, 15 Dec 2024 11:29:07 +0800
From: kernel test robot <lkp@intel.com>
To: yangge1116@126.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	21cnbao@gmail.com, david@redhat.com, baolin.wang@linux.alibaba.com,
	vbabka@suse.cz, liuzixing@hygon.cn, yangge <yangge1116@126.com>
Subject: Re: [PATCH V2] mm, compaction: don't use ALLOC_CMA in long term GUP
 flow
Message-ID: <202412151139.n93obAio-lkp@intel.com>
References: <1734157420-31110-1-git-send-email-yangge1116@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1734157420-31110-1-git-send-email-yangge1116@126.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/yangge1116-126-com/mm-compaction-don-t-use-ALLOC_CMA-in-long-term-GUP-flow/20241214-142453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/1734157420-31110-1-git-send-email-yangge1116%40126.com
patch subject: [PATCH V2] mm, compaction: don't use ALLOC_CMA in long term GUP flow
config: i386-buildonly-randconfig-004-20241215 (https://download.01.org/0day-ci/archive/20241215/202412151139.n93obAio-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412151139.n93obAio-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412151139.n93obAio-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/vmscan.c: In function 'should_continue_reclaim':
>> mm/vmscan.c:5822:21: error: too many arguments to function 'compaction_suitable'
    5822 |                 if (compaction_suitable(zone, sc->order, sc->reclaim_idx, 0))
         |                     ^~~~~~~~~~~~~~~~~~~
   In file included from mm/vmscan.c:36:
   include/linux/compaction.h:111:20: note: declared here
     111 | static inline bool compaction_suitable(struct zone *zone, int order,
         |                    ^~~~~~~~~~~~~~~~~~~
   mm/vmscan.c: In function 'compaction_ready':
   mm/vmscan.c:6050:14: error: too many arguments to function 'compaction_suitable'
    6050 |         if (!compaction_suitable(zone, sc->order, sc->reclaim_idx, 0))
         |              ^~~~~~~~~~~~~~~~~~~
   include/linux/compaction.h:111:20: note: declared here
     111 | static inline bool compaction_suitable(struct zone *zone, int order,
         |                    ^~~~~~~~~~~~~~~~~~~


vim +/compaction_suitable +5822 mm/vmscan.c

  5778	
  5779	/*
  5780	 * Reclaim/compaction is used for high-order allocation requests. It reclaims
  5781	 * order-0 pages before compacting the zone. should_continue_reclaim() returns
  5782	 * true if more pages should be reclaimed such that when the page allocator
  5783	 * calls try_to_compact_pages() that it will have enough free pages to succeed.
  5784	 * It will give up earlier than that if there is difficulty reclaiming pages.
  5785	 */
  5786	static inline bool should_continue_reclaim(struct pglist_data *pgdat,
  5787						unsigned long nr_reclaimed,
  5788						struct scan_control *sc)
  5789	{
  5790		unsigned long pages_for_compaction;
  5791		unsigned long inactive_lru_pages;
  5792		int z;
  5793	
  5794		/* If not in reclaim/compaction mode, stop */
  5795		if (!in_reclaim_compaction(sc))
  5796			return false;
  5797	
  5798		/*
  5799		 * Stop if we failed to reclaim any pages from the last SWAP_CLUSTER_MAX
  5800		 * number of pages that were scanned. This will return to the caller
  5801		 * with the risk reclaim/compaction and the resulting allocation attempt
  5802		 * fails. In the past we have tried harder for __GFP_RETRY_MAYFAIL
  5803		 * allocations through requiring that the full LRU list has been scanned
  5804		 * first, by assuming that zero delta of sc->nr_scanned means full LRU
  5805		 * scan, but that approximation was wrong, and there were corner cases
  5806		 * where always a non-zero amount of pages were scanned.
  5807		 */
  5808		if (!nr_reclaimed)
  5809			return false;
  5810	
  5811		/* If compaction would go ahead or the allocation would succeed, stop */
  5812		for (z = 0; z <= sc->reclaim_idx; z++) {
  5813			struct zone *zone = &pgdat->node_zones[z];
  5814			if (!managed_zone(zone))
  5815				continue;
  5816	
  5817			/* Allocation can already succeed, nothing to do */
  5818			if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
  5819					      sc->reclaim_idx, 0))
  5820				return false;
  5821	
> 5822			if (compaction_suitable(zone, sc->order, sc->reclaim_idx, 0))
  5823				return false;
  5824		}
  5825	
  5826		/*
  5827		 * If we have not reclaimed enough pages for compaction and the
  5828		 * inactive lists are large enough, continue reclaiming
  5829		 */
  5830		pages_for_compaction = compact_gap(sc->order);
  5831		inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
  5832		if (can_reclaim_anon_pages(NULL, pgdat->node_id, sc))
  5833			inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);
  5834	
  5835		return inactive_lru_pages > pages_for_compaction;
  5836	}
  5837	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

