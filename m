Return-Path: <stable+bounces-203192-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 622A8CD4CB6
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 07:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 023173009F93
	for <lists+stable@lfdr.de>; Mon, 22 Dec 2025 06:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37441326D63;
	Mon, 22 Dec 2025 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MbuPQIiI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A3326937;
	Mon, 22 Dec 2025 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766384719; cv=none; b=aSsjOiLsN5S2CgyqdM9HJ6oEH5MVLTKzLgPWz2YkHYPWYmAOq/YWisp9ya86EW5KG5nsh7BHhDAc7clDSchYckyVYrlD7R9a8oDfrp0q733Fr5DZFsJLNIzvf6geEfYk79bM8veCLCw8HVBPC/p9CCsRV225U8V4eD5FR50qhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766384719; c=relaxed/simple;
	bh=NajQSvDFj6afByzC4DUuAXLFKxQGM0BHmRcJVNFTln0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuitpkZfrsHl1HZtQbVQQOJdbOXCwuN7vGJMIiYpkqY0SLo4o2TigyG972CqFDqZ8VwmXLGGyXLeb0f1TMDPYKVL3OugpQqqMW8o6tqdMuTf/s94Dw0mS3LbEByEiKEPF0zAewwM5wXFNUCPg3QoBSfp6h7G90lCuYiZZdU27Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MbuPQIiI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766384717; x=1797920717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NajQSvDFj6afByzC4DUuAXLFKxQGM0BHmRcJVNFTln0=;
  b=MbuPQIiIDX832atEF6L/AXBHGJyfSVl+FtKZb2K+hEayw2yY+h+5oV8M
   UP6vRzNsXH535ziYyYzX9PeLWzxwnBVkxUlrbzs/uqDpl9Hf0abFyqt8I
   3/QzBtdAEoAtgkuODoNTh/TleAzhCvuFPYgDmWKAKXT1df9M6JIz9ZxTv
   dUK0dkv6lJicyTMHRs7Tz2b57yvry/M1Uiovrd3JOby+TmSDiQPXgZxDx
   /780bnTLsnAACDl7OPOGpxlAb/GajsspqBilbP+D6je5KBRp1zoBocmUU
   AmpQqVcn1c5IiIN2Zvl4tQSl447MoXa75XBq4DMQf1tK2AzfwhM/eaCxI
   Q==;
X-CSE-ConnectionGUID: zBlC6BvNQyGjoZeI+RLoeA==
X-CSE-MsgGUID: 2RdahreoSwiSreXI4ZzK5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68177615"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68177615"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 22:25:17 -0800
X-CSE-ConnectionGUID: r2148qVwQYu8R3u2PYubKg==
X-CSE-MsgGUID: nZW1nG+XT/2Gs0JkICEANw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,167,1763452800"; 
   d="scan'208";a="199202111"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 21 Dec 2025 22:25:15 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXZM0-000000005O0-2lCW;
	Mon, 22 Dec 2025 06:25:12 +0000
Date: Mon, 22 Dec 2025 07:24:30 +0100
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] clockevents: add a error handling in
 tick_broadcast_init_sysfs()
Message-ID: <202512220734.2gooRBi1-lkp@intel.com>
References: <20251218090625.557965-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218090625.557965-1-lihaoxiang@isrc.iscas.ac.cn>

Hi Haoxiang,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/timers/core]
[also build test ERROR on linus/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoxiang-Li/clockevents-add-a-error-handling-in-tick_broadcast_init_sysfs/20251218-170931
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20251218090625.557965-1-lihaoxiang%40isrc.iscas.ac.cn
patch subject: [PATCH] clockevents: add a error handling in tick_broadcast_init_sysfs()
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20251222/202512220734.2gooRBi1-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251222/202512220734.2gooRBi1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512220734.2gooRBi1-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/time/clockevents.c: In function 'tick_broadcast_init_sysfs':
>> kernel/time/clockevents.c:737:17: error: implicit declaration of function 'put_deivce'; did you mean 'put_device'? [-Wimplicit-function-declaration]
     737 |                 put_deivce(&tick_bc_dev);
         |                 ^~~~~~~~~~
         |                 put_device


vim +737 kernel/time/clockevents.c

   731	
   732	static __init int tick_broadcast_init_sysfs(void)
   733	{
   734		int err = device_register(&tick_bc_dev);
   735	
   736		if (err) {
 > 737			put_deivce(&tick_bc_dev);
   738			return err;
   739		}
   740	
   741		err = device_create_file(&tick_bc_dev, &dev_attr_current_device);
   742		return err;
   743	}
   744	#else
   745	static struct tick_device *tick_get_tick_dev(struct device *dev)
   746	{
   747		return &per_cpu(tick_cpu_device, dev->id);
   748	}
   749	static inline int tick_broadcast_init_sysfs(void) { return 0; }
   750	#endif
   751	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

