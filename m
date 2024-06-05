Return-Path: <stable+bounces-47969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D64DF8FC20C
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 04:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF7B284569
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 02:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959EA6BFAA;
	Wed,  5 Jun 2024 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qxe5hnBP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1885433A9;
	Wed,  5 Jun 2024 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717556253; cv=none; b=uLxBTEkR3Y7bi5Nz74vG+4pRV2tUX3wDVlP6iWwHRCOUob80AVIswH15jysGRF7cq0psfRauD5QA65BVwG0wCLW5gtHVFEXPExv9AULK13+U/crjeCcl5WDGrI8siEYM/CO9/p0wZsQKqItxkyY9rhXtZMteRfVQVSiGTTs53MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717556253; c=relaxed/simple;
	bh=Tf3EId6rxeexzyTsHKLQ6hT9dw4h2JfE1+v1zFOFQ4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzZ8dtxAEcLt7ewt5VeTdEIWc9U+OCaHaqwDPmzozYGUcTChP9g3EoVKkXty01FTYF/OvZV8y1CgO5BEnBa+GYoF9H/6bVnxlmbZ10WetRf+egMjKqV34SFKSFQeCQkp2n87Vjg9oQUYX7TutFKV1IRG/1oYHJbmPVQgpnc28vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qxe5hnBP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717556252; x=1749092252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tf3EId6rxeexzyTsHKLQ6hT9dw4h2JfE1+v1zFOFQ4g=;
  b=Qxe5hnBPym7jCPiVUMBXmD/M385aaDshYNYkJFAEnZhSOdpERyjohcNd
   VTyCYok+qxeiP3WLrj0DLFS0s0pn71P+jv4Z/PFsMqfwko/jmbY3YAXag
   lSX5TxNCmilrlTh+0UeZLzPAUmR4sCMWV4G2YhrM8Ywl2EeAe1AUJbeR9
   5N1w9qupUsJ2OOknxZPa40DRBrMbSVuajYPB22VC3htx0g4DXYInOQPdM
   0o8WcEriB2xhufVur3qkm13FYH1dh72Lm2icjIKzHdO+t23oSNsGi6gvX
   rq2x59JuBAEIHQ13PvAN5Ztt/vzCWs6T2LIgoiAVYsANtWufG/N9fhkLh
   Q==;
X-CSE-ConnectionGUID: pYNwPXMWQSmAjuOQm3l5gA==
X-CSE-MsgGUID: XuhrYnSySNKWhXfA/5s70g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13889968"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13889968"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:57:31 -0700
X-CSE-ConnectionGUID: iK6PlWzmT6a05HZ7diAK5Q==
X-CSE-MsgGUID: KHRIZ7fMR2C2Zb6tAzgy/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="42550156"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 04 Jun 2024 19:57:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEgq5-0000q3-0N;
	Wed, 05 Jun 2024 02:57:25 +0000
Date: Wed, 5 Jun 2024 10:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: Yang Shi <yang@os.amperecomputing.com>, peterx@redhat.com,
	oliver.sang@intel.com, paulmck@kernel.org, david@redhat.com,
	willy@infradead.org, riel@surriel.com, vivek.kasireddy@intel.com,
	cl@linux.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, yang@os.amperecomputing.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: gup: do not call try_grab_folio() in slow path
Message-ID: <202406051039.9m00gwIx-lkp@intel.com>
References: <20240604234858.948986-2-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604234858.948986-2-yang@os.amperecomputing.com>

Hi Yang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Shi/mm-gup-do-not-call-try_grab_folio-in-slow-path/20240605-075027
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240604234858.948986-2-yang%40os.amperecomputing.com
patch subject: [PATCH 2/2] mm: gup: do not call try_grab_folio() in slow path
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240605/202406051039.9m00gwIx-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240605/202406051039.9m00gwIx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406051039.9m00gwIx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/gup.c:131:22: warning: 'try_grab_folio_fast' defined but not used [-Wunused-function]
     131 | static struct folio *try_grab_folio_fast(struct page *page, int refs,
         |                      ^~~~~~~~~~~~~~~~~~~


vim +/try_grab_folio_fast +131 mm/gup.c

   101	
   102	/**
   103	 * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
   104	 * @page:  pointer to page to be grabbed
   105	 * @refs:  the value to (effectively) add to the folio's refcount
   106	 * @flags: gup flags: these are the FOLL_* flag values.
   107	 *
   108	 * "grab" names in this file mean, "look at flags to decide whether to use
   109	 * FOLL_PIN or FOLL_GET behavior, when incrementing the folio's refcount.
   110	 *
   111	 * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
   112	 * same time. (That's true throughout the get_user_pages*() and
   113	 * pin_user_pages*() APIs.) Cases:
   114	 *
   115	 *    FOLL_GET: folio's refcount will be incremented by @refs.
   116	 *
   117	 *    FOLL_PIN on large folios: folio's refcount will be incremented by
   118	 *    @refs, and its pincount will be incremented by @refs.
   119	 *
   120	 *    FOLL_PIN on single-page folios: folio's refcount will be incremented by
   121	 *    @refs * GUP_PIN_COUNTING_BIAS.
   122	 *
   123	 * Return: The folio containing @page (with refcount appropriately
   124	 * incremented) for success, or NULL upon failure. If neither FOLL_GET
   125	 * nor FOLL_PIN was set, that's considered failure, and furthermore,
   126	 * a likely bug in the caller, so a warning is also emitted.
   127	 *
   128	 * It uses add ref unless zero to elevate the folio refcount and must be called
   129	 * in fast path only.
   130	 */
 > 131	static struct folio *try_grab_folio_fast(struct page *page, int refs,
   132						 unsigned int flags)
   133	{
   134		struct folio *folio;
   135	
   136		/* Raise warn if it is not called in fast GUP */
   137		VM_WARN_ON_ONCE(!irqs_disabled());
   138	
   139		if (WARN_ON_ONCE((flags & (FOLL_GET | FOLL_PIN)) == 0))
   140			return NULL;
   141	
   142		if (unlikely(!(flags & FOLL_PCI_P2PDMA) && is_pci_p2pdma_page(page)))
   143			return NULL;
   144	
   145		if (flags & FOLL_GET)
   146			return try_get_folio(page, refs);
   147	
   148		/* FOLL_PIN is set */
   149	
   150		/*
   151		 * Don't take a pin on the zero page - it's not going anywhere
   152		 * and it is used in a *lot* of places.
   153		 */
   154		if (is_zero_page(page))
   155			return page_folio(page);
   156	
   157		folio = try_get_folio(page, refs);
   158		if (!folio)
   159			return NULL;
   160	
   161		/*
   162		 * Can't do FOLL_LONGTERM + FOLL_PIN gup fast path if not in a
   163		 * right zone, so fail and let the caller fall back to the slow
   164		 * path.
   165		 */
   166		if (unlikely((flags & FOLL_LONGTERM) &&
   167			     !folio_is_longterm_pinnable(folio))) {
   168			if (!put_devmap_managed_folio_refs(folio, refs))
   169				folio_put_refs(folio, refs);
   170			return NULL;
   171		}
   172	
   173		/*
   174		 * When pinning a large folio, use an exact count to track it.
   175		 *
   176		 * However, be sure to *also* increment the normal folio
   177		 * refcount field at least once, so that the folio really
   178		 * is pinned.  That's why the refcount from the earlier
   179		 * try_get_folio() is left intact.
   180		 */
   181		if (folio_test_large(folio))
   182			atomic_add(refs, &folio->_pincount);
   183		else
   184			folio_ref_add(folio,
   185					refs * (GUP_PIN_COUNTING_BIAS - 1));
   186		/*
   187		 * Adjust the pincount before re-checking the PTE for changes.
   188		 * This is essentially a smp_mb() and is paired with a memory
   189		 * barrier in folio_try_share_anon_rmap_*().
   190		 */
   191		smp_mb__after_atomic();
   192	
   193		node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
   194	
   195		return folio;
   196	}
   197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

