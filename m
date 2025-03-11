Return-Path: <stable+bounces-123707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32182A5C6E8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C90189B75D
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640B25EFA9;
	Tue, 11 Mar 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHwoQvlz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09F25BAAA;
	Tue, 11 Mar 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706732; cv=none; b=Y/QCOmYO3sbDUv2DFT1n3jyq9ANQihrZzmQnewebxvH5BhGQzMZD1fAawCbRnC6rLJxZSILqR3Ey3D5oiulcCB/qfbXv2PVxdUMyt0fO3KfgtS7C+h4XUin87vmXK5w0FQpVn7qwgvpSVDuHLNWJ3a5Va0IPkDNLmYXn7/M08lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706732; c=relaxed/simple;
	bh=/pbrJLS75cPqadHFhAbQ59M5jBD+PgdPS+fqzG7J4Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu3BZM3u8i7z95wWYaLQz5BOms/SIRziJt2y5LcCfDQrEUYzUdGvG851PxG1VgXHyFF/qxvkkjvHW7Pchr+2fTBxsshesxBgOm7SpzJSs6iUDteuH0M8nSOQksmlGVinlQfczr5hDUwoH858ylvZXV+OCq5TXYrH3pmSN1zrxqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHwoQvlz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741706730; x=1773242730;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/pbrJLS75cPqadHFhAbQ59M5jBD+PgdPS+fqzG7J4Sk=;
  b=dHwoQvlzpqYK3nVfICYgZb/r70V5uJiip0Lv9sMIgLvm/LLUrTUEDlyF
   0gdO3oUFeGJHZePTLj11ix1VrEg7rziU3xuNM9rwyvgdsDEaYjuuDSFgz
   vV8LHbVdtwJwDTP33GTYWHHBnQw3l3XyJ9D5ZkdNB/0cXH9vp3tBNVtOV
   UQaKHTe8qHetxSDgfomq5Zn+UjvJRMaxfqpHSMvNsPEgj2fKDwnUJ5Wkk
   7cJBSg85+FjqJPrWSNzI8xjNClxNKXOia/crUZVo7dqx8l3IMTM048gMz
   vF40oj8CIg4pt0dYc6JLHBW1x3TdRRi9VnKEUrTXnnvZGG8iwcx51d6uO
   A==;
X-CSE-ConnectionGUID: tBSP3go8Rvij5ihaqFO8fA==
X-CSE-MsgGUID: BIt5Fk1WR5uw5Oqd9hv+8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="53392534"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="53392534"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 08:25:29 -0700
X-CSE-ConnectionGUID: qQEz04IbR52YkzMO0LPcWw==
X-CSE-MsgGUID: P5XdEeuTSuKYolsweBzsbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="121049964"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 11 Mar 2025 08:25:26 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ts1Tw-00077A-17;
	Tue, 11 Mar 2025 15:25:24 +0000
Date: Tue, 11 Mar 2025 23:24:42 +0800
From: kernel test robot <lkp@intel.com>
To: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, osalvador@suse.de,
	42.hyeyoo@gmail.com, byungchul@sk.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	stable@vger.kernel.org, linux-mm@kvack.org,
	max.byungchul.park@sk.com, max.byungchul.park@gmail.com
Subject: Re: [PATCH] mm: introduce include/linux/pgalloc.h
Message-ID: <202503112344.GSI5KIK4-lkp@intel.com>
References: <20250311114420.240341-1-gwan-gyeong.mun@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311114420.240341-1-gwan-gyeong.mun@intel.com>

Hi Gwan-gyeong,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/mm]
[also build test ERROR on linus/master v6.14-rc6]
[cannot apply to akpm-mm/mm-everything tip/x86/core next-20250311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gwan-gyeong-Mun/mm-introduce-include-linux-pgalloc-h/20250311-194723
base:   tip/x86/mm
patch link:    https://lore.kernel.org/r/20250311114420.240341-1-gwan-gyeong.mun%40intel.com
patch subject: [PATCH] mm: introduce include/linux/pgalloc.h
config: x86_64-buildonly-randconfig-002-20250311 (https://download.01.org/0day-ci/archive/20250311/202503112344.GSI5KIK4-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250311/202503112344.GSI5KIK4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503112344.GSI5KIK4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/mm/init_64.c:236:6: error: redefinition of 'arch_sync_global_p4ds'
     236 | void arch_sync_global_p4ds(unsigned long start, unsigned long end) {}
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/mm/init_64.c:228:6: note: previous definition of 'arch_sync_global_p4ds' with type 'void(long unsigned int,  long unsigned int)'
     228 | void arch_sync_global_p4ds(unsigned long start, unsigned long end)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> arch/x86/mm/init_64.c:238:6: error: redefinition of 'arch_sync_global_pgds'
     238 | void arch_sync_global_pgds(unsigned long start, unsigned long end)
         |      ^~~~~~~~~~~~~~~~~~~~~
   arch/x86/mm/init_64.c:233:6: note: previous definition of 'arch_sync_global_pgds' with type 'void(long unsigned int,  long unsigned int)'
     233 | void arch_sync_global_pgds(unsigned long start, unsigned long end) {}
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/arch_sync_global_p4ds +236 arch/x86/mm/init_64.c

   234	
   235	#if CONFIG_PGTABLE_LEVELS > 4
 > 236	void arch_sync_global_p4ds(unsigned long start, unsigned long end) {}
   237	
 > 238	void arch_sync_global_pgds(unsigned long start, unsigned long end)
   239	{
   240		sync_global_pgds(start, end);
   241	}
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

