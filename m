Return-Path: <stable+bounces-192563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CB4C38BA2
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 02:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54841A20353
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 01:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D34223DED;
	Thu,  6 Nov 2025 01:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbrAmcbq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5C718C031;
	Thu,  6 Nov 2025 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762393387; cv=none; b=qMGBjH+gtbv3w29DRNU/v6WU2vyc7iKVoC/fsHmWJq4X9DK/YToGmnK9YWOercQ8EDU6TjKxzqA+4JmJRwsKCAtXxY590cay2jk5rat0W50lGNL9NjJjVLNLHca1rDTYRPYbSEwhCWQvNmxH8zQmD5tIsmpdXd7xPESWrlpvxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762393387; c=relaxed/simple;
	bh=2BVMpR3FHyZ+X/hxS26Deu2WAC/NgwDf1oq+a7rG/6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3sKnaOl67n1wpDd07KjiEgoc4Mxq6UkMToyTJjGRdCGcCUqVTGkgJ/S8TJibBa0FLd+j6WMU0GcYdBmNpjBhkqGViZkfkxygs6aocwib+cXNXRuJHPmTzVVkBRLCKjs4Q46IhshfrNkGAfElBTOFcN7M4XobGJQhG5IyxNAo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbrAmcbq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762393385; x=1793929385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2BVMpR3FHyZ+X/hxS26Deu2WAC/NgwDf1oq+a7rG/6Y=;
  b=SbrAmcbqOwN3lwaGv+n3OISDKLp8NXV/nVp0Hs5BUUNdKxxaGTNOCWqA
   GaRbgfFEPAOCJS1rS2qKxvqaMbKz28VWYByn21Bgf/hc2q/K5xKLza0ix
   U1asKXqfuH3G+4FGRWwM6303fJv3RH6X7PihioejnokATV76MdibjRBUi
   hWCcRAomMFECwpHckwIWqIKIhu2tsEaCEiQoO2/jQUrkI5KJQH+n6/844
   jesXf7exWzOZjKhPYgZ5QBXcarjXcXwxzEAoRVZ8yNpZYRT2TaJmbOvPs
   KXih1bEH+g3ODCQ7zK68rwbQPvD1e6sb6MJWBIerGBc56XvFyFtS0aZer
   Q==;
X-CSE-ConnectionGUID: gk71Oh83SSG9z7ZbSbmSDg==
X-CSE-MsgGUID: uymcymCLQAyOxD62sUkXuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="75132864"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="75132864"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 17:43:04 -0800
X-CSE-ConnectionGUID: CJWimRuKSDGhm1KNZzS0Ug==
X-CSE-MsgGUID: iOJKe8OyRfez6UZyGvb2Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="191976026"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 05 Nov 2025 17:43:00 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGp1e-000TL2-02;
	Thu, 06 Nov 2025 01:42:58 +0000
Date: Thu, 6 Nov 2025 09:42:22 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	m.wieczorretman@pm.me, stable@vger.kernel.org,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kasan: Unpoison pcpu chunks with base address tag
Message-ID: <202511060927.eg2dcKpK-lkp@intel.com>
References: <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc4 next-20251105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Wieczor-Retman/kasan-Unpoison-pcpu-chunks-with-base-address-tag/20251104-225204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman%40pm.me
patch subject: [PATCH v1 1/2] kasan: Unpoison pcpu chunks with base address tag
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20251106/202511060927.eg2dcKpK-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d2625a438020ad35330cda29c3def102c1687b1b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251106/202511060927.eg2dcKpK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511060927.eg2dcKpK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/kasan/common.c:584:6: warning: no previous prototype for function '__kasan_unpoison_vmap_areas' [-Wmissing-prototypes]
     584 | void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
         |      ^
   mm/kasan/common.c:584:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     584 | void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
         | ^
         | static 
   1 warning generated.


vim +/__kasan_unpoison_vmap_areas +584 mm/kasan/common.c

   583	
 > 584	void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

