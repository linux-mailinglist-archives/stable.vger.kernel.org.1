Return-Path: <stable+bounces-148090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE102AC7D87
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 14:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121D39E7E6A
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 11:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D020E223702;
	Thu, 29 May 2025 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZ//IFEx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E68382;
	Thu, 29 May 2025 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748520013; cv=none; b=fc2HyNSbUvhsVnn5jwRezM0YGgIyIGQas7WH2Nh8OcNZuqhhgACd0I0PAs30Z5iPWFcsBNbjD8Ok3JaBm9OZtAD9Xeth8YOTT8F99MsKQw7asjwtmHOQkM1erk0ZpXff41dQdta5ATohBXqzs2bpnfEJao43PBfOKjlsg16QTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748520013; c=relaxed/simple;
	bh=qsyx5szXg/RLR/SYQRYSoPWYWeRd9Dz2wDzGauGsOnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzHbaU+6ynzN4jcKRrGiguLQ9EMloHf5VfeXB0bGUlBeI0jr7swg6IU6edpCqsT/kx2lfv4WhQ5yn1s2BEB06uEIdCYbETkX4/Stcutve39TFIPk0IcjvWe0RNDBgjOaCBrXtofKHczCTHuWRUJtHN6+USUSKk+86iEPET4TpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZ//IFEx; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748520012; x=1780056012;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qsyx5szXg/RLR/SYQRYSoPWYWeRd9Dz2wDzGauGsOnE=;
  b=KZ//IFExtp9Egbet5FrqGkGB2m+PkuTvMe71pHSM+jAI3dZiqRKQiOp+
   2IdFsIcrkTzxAJPtAyq3AYXgBFgIG/eVehTq0sH/eixlV6WjiWZNoSSqU
   tzIthhujdF8G2r09PHAjOboW5ox2y7tnAKFfqmD0rI9s7C+1XB/PR3uQ7
   N4c+a05bOXz5a0H6UposA8sI1g/9gNwd3sHEaeMwx5oVEmPks5IScVN8J
   UUEi2PZtuTXifZAia8lPth0+n5GrOyGpsqOLmwoNrwymfoCemsgbnHI5d
   m+XHZVRgoT5/XZVF6ZAbWDgC1p31i5A7exZ/FloC8BI/ncMAv2hMrx7LW
   g==;
X-CSE-ConnectionGUID: mvIUR9/6Sg65vw0pqe9AiA==
X-CSE-MsgGUID: h7m8X1vyQRCTz6izZiirSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50275132"
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="50275132"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 05:00:11 -0700
X-CSE-ConnectionGUID: whAdq3RYS32r/OfE1EvC8A==
X-CSE-MsgGUID: qVB8dGHDRqCMZYdCKKAgBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,192,1744095600"; 
   d="scan'208";a="143882685"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 29 May 2025 05:00:06 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uKbvX-000Weq-2l;
	Thu, 29 May 2025 12:00:03 +0000
Date: Thu, 29 May 2025 19:59:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Hongyu Ning <hongyu.ning@linux.intel.com>, stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
Message-ID: <202505291930.NDyeQ06g-lkp@intel.com>
References: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529103832.2937460-1-kirill.shutemov@linux.intel.com>

Hi Kirill,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/mm-Fix-vmstat-after-removing-NR_BOUNCE/20250529-184044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250529103832.2937460-1-kirill.shutemov%40linux.intel.com
patch subject: [PATCH] mm: Fix vmstat after removing NR_BOUNCE
config: m68k-allnoconfig (https://download.01.org/0day-ci/archive/20250529/202505291930.NDyeQ06g-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250529/202505291930.NDyeQ06g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505291930.NDyeQ06g-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   mm/vmstat.c: In function 'vmstat_start':
>> include/linux/compiler_types.h:563:45: error: call to '__compiletime_assert_318' declared with attribute error: BUILD_BUG_ON failed: ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS
     563 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:544:25: note: in definition of macro '__compiletime_assert'
     544 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:563:9: note: in expansion of macro '_compiletime_assert'
     563 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   mm/vmstat.c:1872:9: note: in expansion of macro 'BUILD_BUG_ON'
    1872 |         BUILD_BUG_ON(ARRAY_SIZE(vmstat_text) < NR_VMSTAT_ITEMS);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_318 +563 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  549  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  550  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  551  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  552  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  553  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  554   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  555   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  556   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  557   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  558   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  559   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  560   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  561   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  562  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @563  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  564  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

