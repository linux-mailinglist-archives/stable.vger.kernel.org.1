Return-Path: <stable+bounces-203145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 089CDCD3229
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43CE3301459A
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96D26E173;
	Sat, 20 Dec 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FC5b3Lur"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53735231A55;
	Sat, 20 Dec 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766244800; cv=none; b=NvYz2qMn2M/l+ZFGPF5FipRAS2GruxM0j9lFVqAbOk2k9OzfdjZTYYqypEvwX4M76kAbsM8ZUgXK3Vqt86ZyV7S7s9wU/esqDvhZRWJ149DZhjHUxvqjQ2+hK7BT/oKlT1RELpNQgRJD4nFkB7E0qlyMuG/dwNb1MV6iMHL1uVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766244800; c=relaxed/simple;
	bh=IDiedDHtvhFt0TbPFX0QHbV/pDojRx7fXZRbFgxQ/90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMrsVkoUM/ZqvgEUlUpudP7IdwPaAKma+rG92OWsHGyOcFQjA+MCSs3sF0Uq2t/u2S59PtdmOc3UiOwmyDro2MYIOrekbAzimanK4V+drTOO9o6tFU+qUudCKjQTXyX6bkemb1XaPdduR8LW5hnZQZOAv6n8LAD0rEW1H2LFj2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FC5b3Lur; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766244799; x=1797780799;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDiedDHtvhFt0TbPFX0QHbV/pDojRx7fXZRbFgxQ/90=;
  b=FC5b3LuroRgD/pln9fffuqTXp1J105zpPf4UjIkWwmhFIo91OSR15lqa
   UmxwdpiAaeWe3T/VNfSaGbMVTLZ6A7dUWR+RfKglnAsp0m/MFxtnopVXJ
   kkake3ZGEPE3om7HUUHengAQGepk/wlc6g8+9OGMX4VeLeCrbUwFWjzF5
   VdtW4FDOja3Zdq11hJlUWL24zmir3AdirKiLmHlzW4B+++qZxohiNsiHs
   4xFNPTtiSNKxP1i4kptMvMUcLCjfO/sehGjgCY3rzR7QmtFP97QrDjAkR
   J8rpIHbU97+PoIHdQwtuKF6GJAToZlW//D5IQTSuseD6IESoU2hR2mkrz
   g==;
X-CSE-ConnectionGUID: u/Elq+1YQdaQOmEMH+6rYg==
X-CSE-MsgGUID: 1ErvY97nTvGv4zc5wVcEpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68114315"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68114315"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:33:19 -0800
X-CSE-ConnectionGUID: E/NbZsPRQhCsmJ5xGE1UKg==
X-CSE-MsgGUID: HZtdf3WFRueoxAQTjt/R4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199357869"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Dec 2025 07:33:16 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWyxG-000000004kn-1DZc;
	Sat, 20 Dec 2025 15:33:14 +0000
Date: Sat, 20 Dec 2025 23:33:08 +0800
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] clockevents: add a error handling in
 tick_broadcast_init_sysfs()
Message-ID: <202512202244.AR00sdAe-lkp@intel.com>
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
[also build test ERROR on linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoxiang-Li/clockevents-add-a-error-handling-in-tick_broadcast_init_sysfs/20251218-170931
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20251218090625.557965-1-lihaoxiang%40isrc.iscas.ac.cn
patch subject: [PATCH] clockevents: add a error handling in tick_broadcast_init_sysfs()
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20251220/202512202244.AR00sdAe-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202244.AR00sdAe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202244.AR00sdAe-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/time/clockevents.c:737:3: error: call to undeclared function 'put_deivce'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     737 |                 put_deivce(&tick_bc_dev);
         |                 ^
   kernel/time/clockevents.c:737:3: note: did you mean 'put_device'?
   include/linux/device.h:1162:6: note: 'put_device' declared here
    1162 | void put_device(struct device *dev);
         |      ^
   1 error generated.


vim +/put_deivce +737 kernel/time/clockevents.c

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

