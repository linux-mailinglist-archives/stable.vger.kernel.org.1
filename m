Return-Path: <stable+bounces-46015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7415E8CDCD0
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 00:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B031C24393
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 22:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7286AFA;
	Thu, 23 May 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPIpX5yG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AA1823B0;
	Thu, 23 May 2024 22:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716502727; cv=none; b=rAsnw6HGfuKO84A0xTgyyNzvTb9Zn8dHYID/kjHb7poGYWnKL6GMmuvY9MMTaiEy05fx21NR4DX+VfqNAINlevclixJdAlD0Mxrpo9gzD5m57yVAN4lXzC4vRac6ojlEAgWX9f9aQRTQ57+LfZetsc5CTzvNSbvFd/vAD8mysPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716502727; c=relaxed/simple;
	bh=1NaIoGRUhnN6xYMOU6GSlsoHT9TyOUpfTCPyfZr+ldw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8twpdiKqy7Fxsvz5pPDbFOGxXu8u6mC8xrKlQOfmhEqLhu1DKxBLtwY+Z+reNf2NShPEiUKyAZ63xkxgkZ5wRXWSwwHYjko1kH3/prVor/uJ0ZuB2KilU2KMxRB1zhFnFcb1nVXnZ1ZHM/6Apoo+41uT71QGuWN8LIQhP4vDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPIpX5yG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716502725; x=1748038725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1NaIoGRUhnN6xYMOU6GSlsoHT9TyOUpfTCPyfZr+ldw=;
  b=RPIpX5yG1H0aVvXAf5bYmtGuf+EYoQwnXmMYln0lB4NwzoCyRIYgxe6i
   dD9nGQlRLbktTHujCHDqgxPfi6gSxAgeHRqSZfSzAPJ/ZzoO4u1p/nUqc
   Fl/Yp05KWwWficvvzu4y4zuEoOuElodRYanYr+FLss+a8rufr5Yygi1RC
   L0B78g9AWPnQXYv1WTdad3RpADobbTb1V5tmGGvVY5bArRL7pXQPaHCqT
   XxRTHT4/+rU3jy8mCiqZ0wy7+v7dmPUWEagaBzDtJM3iYgwNZ/kGKDsJm
   +uIl95uuIEfJtHtb85vow7Thn/uklvt8VvE/jrKFyBXRNLukezGpEbBsJ
   g==;
X-CSE-ConnectionGUID: c91IAtIaTYysQmiaj8X6/w==
X-CSE-MsgGUID: 2iGeNS/wSBuNz6vF/vns2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="38238845"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38238845"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 15:18:44 -0700
X-CSE-ConnectionGUID: 8bcP8lf1R3WRQCBr8yIoaA==
X-CSE-MsgGUID: ewHfpK7hRvi7w0A1/Gu0IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38668287"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 23 May 2024 15:18:42 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAGlj-0003Zv-2o;
	Thu, 23 May 2024 22:18:39 +0000
Date: Fri, 24 May 2024 06:17:44 +0800
From: kernel test robot <lkp@intel.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/4] LoongArch: smp: Add all CPUs enabled by fdt to NUMA
 node 0
Message-ID: <202405240627.5Ey7vV8v-lkp@intel.com>
References: <20240521-loongarch-booting-fixes-v1-2-659c201c0370@flygoat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521-loongarch-booting-fixes-v1-2-659c201c0370@flygoat.com>

Hi Jiaxun,

kernel test robot noticed the following build errors:

[auto build test ERROR on 124cfbcd6d185d4f50be02d5f5afe61578916773]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiaxun-Yang/LoongArch-Fix-built-in-DTB-detection/20240522-041534
base:   124cfbcd6d185d4f50be02d5f5afe61578916773
patch link:    https://lore.kernel.org/r/20240521-loongarch-booting-fixes-v1-2-659c201c0370%40flygoat.com
patch subject: [PATCH 2/4] LoongArch: smp: Add all CPUs enabled by fdt to NUMA node 0
config: loongarch-randconfig-001-20240524 (https://download.01.org/0day-ci/archive/20240524/202405240627.5Ey7vV8v-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405240627.5Ey7vV8v-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405240627.5Ey7vV8v-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/loongarch/kernel/smp.c: In function 'fdt_smp_setup':
>> arch/loongarch/kernel/smp.c:287:17: error: implicit declaration of function 'set_cpuid_to_node'; did you mean 'set_cpu_numa_node'? [-Werror=implicit-function-declaration]
     287 |                 set_cpuid_to_node(cpuid, 0);
         |                 ^~~~~~~~~~~~~~~~~
         |                 set_cpu_numa_node
   cc1: some warnings being treated as errors


vim +287 arch/loongarch/kernel/smp.c

   259	
   260	static void __init fdt_smp_setup(void)
   261	{
   262	#ifdef CONFIG_OF
   263		unsigned int cpu, cpuid;
   264		struct device_node *node = NULL;
   265	
   266		for_each_of_cpu_node(node) {
   267			if (!of_device_is_available(node))
   268				continue;
   269	
   270			cpuid = of_get_cpu_hwid(node, 0);
   271			if (cpuid >= nr_cpu_ids)
   272				continue;
   273	
   274			if (cpuid == loongson_sysconf.boot_cpu_id) {
   275				cpu = 0;
   276			} else {
   277				cpu = cpumask_next_zero(-1, cpu_present_mask);
   278			}
   279	
   280			num_processors++;
   281			set_cpu_possible(cpu, true);
   282			set_cpu_present(cpu, true);
   283			__cpu_number_map[cpuid] = cpu;
   284			__cpu_logical_map[cpu] = cpuid;
   285	
   286			early_numa_add_cpu(cpu, 0);
 > 287			set_cpuid_to_node(cpuid, 0);
   288			numa_add_cpu(cpu);
   289		}
   290	
   291		loongson_sysconf.nr_cpus = num_processors;
   292		set_bit(0, loongson_sysconf.cores_io_master);
   293	#endif
   294	}
   295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

