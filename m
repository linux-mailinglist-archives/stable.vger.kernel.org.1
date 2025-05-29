Return-Path: <stable+bounces-148051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC60AC7701
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 06:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7F44E46DC
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 04:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9560624DFF4;
	Thu, 29 May 2025 04:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaRfZniK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909324A06F;
	Thu, 29 May 2025 04:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491830; cv=none; b=sQjsKga/78YDaA5+in+PQKXelCQ04ZGfQHiG+KBitqlcT+pEmPXpxRQ+b6SnrnEGS8bpahaQLZsJhkoWO1dvFUzCpeEHvj0VVP3m2CI8A5RKqLv810evEII9owQrNURLIRZiLs58ub1v5lJ161pos5oSWcp5o7QpoO/4iVcL96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491830; c=relaxed/simple;
	bh=SJuvA/C+Z8/BjsjREOqXFo7k0ZLVmXu/MbjVcwYY0lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RKT8qo5mpXyb9tcPmwOr7Bp1TONJ+N2b8/eVK7hZ9E6baraYmgLyYvMIQakFOUaL5jKmk3/bO3jYtCMmI3RszmjlbaSI9dabJEpxK27PT1sBKLG91dN0Yu12uz/F5XESJpXciObT+PCfDjSxsT4SVcuHKhLBosN0oP/8V5akKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaRfZniK; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748491829; x=1780027829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SJuvA/C+Z8/BjsjREOqXFo7k0ZLVmXu/MbjVcwYY0lA=;
  b=VaRfZniKEpl+g1bk+IAd4X9kw7uPZiRQYLCSicnlqdamI2Oakj2oZnV8
   HyhR3nFyrTBB7gHuGEqyC5GZWGPtIaPqlRbcnl4DeAcW8TvCohKjGYcCb
   qwTZpf0ffgbixyV4nhmrXsFZ5lu0l4NlKPQxoq6sw7PUUIip2Oy3vqRSJ
   9//KcYXH3fXcSO6CEqvu8IoPUBTijwaIJXXy2XMZnR2PckyVvfJZART0V
   JouxAClr+baPTvnGhiebA72SDOyTDrYEkdMy9I2Bmly/BorSeBAS0Y1CC
   DcKQdMYG2QHi5Z+qijhk46mZFDbkq2cmkZ1BejiOvsyIMViM89bKn8GS5
   g==;
X-CSE-ConnectionGUID: lXEpUUetQ5+1+u/AFh3uDg==
X-CSE-MsgGUID: FKMr5m5SSMWFxf1U/qhvmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="60799753"
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="60799753"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 21:10:28 -0700
X-CSE-ConnectionGUID: iQ5U1i82SSKqtzYHqGYglw==
X-CSE-MsgGUID: EimyRNP5QRCCimvkLdAKXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,322,1739865600"; 
   d="scan'208";a="143908909"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 28 May 2025 21:10:24 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKUb0-000WJW-1b;
	Thu, 29 May 2025 04:10:22 +0000
Date: Thu, 29 May 2025 12:09:55 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, xin@zytor.com,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Message-ID: <202505291124.eAZ7fgbG-lkp@intel.com>
References: <20250528123557.12847-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528123557.12847-4-jgross@suse.com>

Hi Juergen,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on tip/x86/core linus/master v6.15 next-20250528]
[cannot apply to tip/x86/mm tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/x86-execmem-don-t-use-PAGE_KERNEL-protection-for-code-pages/20250528-204423
base:   tip/master
patch link:    https://lore.kernel.org/r/20250528123557.12847-4-jgross%40suse.com
patch subject: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
config: x86_64-buildonly-randconfig-002-20250529 (https://download.01.org/0day-ci/archive/20250529/202505291124.eAZ7fgbG-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505291124.eAZ7fgbG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505291124.eAZ7fgbG-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/alternative.c:2353:6: error: use of undeclared identifier 'its_page'
    2353 |         if (its_page)
         |             ^
>> arch/x86/kernel/alternative.c:2354:3: error: call to undeclared function 'its_set_kernel_ro'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2354 |                 its_set_kernel_ro(its_page);
         |                 ^
   arch/x86/kernel/alternative.c:2354:21: error: use of undeclared identifier 'its_page'
    2354 |                 its_set_kernel_ro(its_page);
         |                                   ^
   arch/x86/kernel/alternative.c:2355:2: error: use of undeclared identifier 'its_page'
    2355 |         its_page = NULL;
         |         ^
   4 errors generated.


vim +/its_page +2353 arch/x86/kernel/alternative.c

  2308	
  2309	void __init alternative_instructions(void)
  2310	{
  2311		u64 ibt;
  2312	
  2313		int3_selftest();
  2314	
  2315		/*
  2316		 * The patching is not fully atomic, so try to avoid local
  2317		 * interruptions that might execute the to be patched code.
  2318		 * Other CPUs are not running.
  2319		 */
  2320		stop_nmi();
  2321	
  2322		/*
  2323		 * Don't stop machine check exceptions while patching.
  2324		 * MCEs only happen when something got corrupted and in this
  2325		 * case we must do something about the corruption.
  2326		 * Ignoring it is worse than an unlikely patching race.
  2327		 * Also machine checks tend to be broadcast and if one CPU
  2328		 * goes into machine check the others follow quickly, so we don't
  2329		 * expect a machine check to cause undue problems during to code
  2330		 * patching.
  2331		 */
  2332	
  2333		/*
  2334		 * Make sure to set (artificial) features depending on used paravirt
  2335		 * functions which can later influence alternative patching.
  2336		 */
  2337		paravirt_set_cap();
  2338	
  2339		/* Keep CET-IBT disabled until caller/callee are patched */
  2340		ibt = ibt_save(/*disable*/ true);
  2341	
  2342		__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
  2343				__cfi_sites, __cfi_sites_end, true);
  2344	
  2345		/*
  2346		 * Rewrite the retpolines, must be done before alternatives since
  2347		 * those can rewrite the retpoline thunks.
  2348		 */
  2349		apply_retpolines(__retpoline_sites, __retpoline_sites_end);
  2350		apply_returns(__return_sites, __return_sites_end);
  2351	
  2352		/* Make potential last thunk page read-only. */
> 2353		if (its_page)
> 2354			its_set_kernel_ro(its_page);
  2355		its_page = NULL;
  2356	
  2357		/*
  2358		 * Adjust all CALL instructions to point to func()-10, including
  2359		 * those in .altinstr_replacement.
  2360		 */
  2361		callthunks_patch_builtin_calls();
  2362	
  2363		apply_alternatives(__alt_instructions, __alt_instructions_end);
  2364	
  2365		/*
  2366		 * Seal all functions that do not have their address taken.
  2367		 */
  2368		apply_seal_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
  2369	
  2370		ibt_restore(ibt);
  2371	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

