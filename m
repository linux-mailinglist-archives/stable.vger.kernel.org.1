Return-Path: <stable+bounces-119859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC6A488D9
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 20:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485A93A7A87
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 19:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6BB26E65F;
	Thu, 27 Feb 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1R4F8n5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE44526E649;
	Thu, 27 Feb 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684003; cv=none; b=F72t70xHNjcd9gV6Jyx5L57p8/0n1ChtVehOgnPlaO36IK7gWAl6O08651jnKCbrfZwVKI1auhwfl29r4/9jslUj7kJJIUHMLq6NgGH4aQ2YDvc0SZlq3d88vnXpzCp/DH9+8EaHCa6YNNPriHFR5ZvWUfa2GfAlFbA8xlcbBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684003; c=relaxed/simple;
	bh=9/QRe7sLuF6mdR2aq8VzjCObcNBmWE07UKQPAvkDe2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvZs/72DTxpkfsGFn/92bb/xxjZuTrqGHHeQh3gD7F0ZScYlZUuF3qof9AQQz1/z3m4MzerpLSuw71yoqIH4kH7fGsPGBLpzV4p3aE1NwM4LIsUlDSr59A14zcS7t7lAR+FhLLoaUmNwJxYUPrpKiO2sy7mRV7zJd5EqS80vaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1R4F8n5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740684002; x=1772220002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9/QRe7sLuF6mdR2aq8VzjCObcNBmWE07UKQPAvkDe2M=;
  b=g1R4F8n5AqLGSz+stq4EmCZzBn/jAzwx0wzHd/ISw7z1YtS4AqTNxHPh
   OH8w5Ab5am9uykxS1Wa2w9YNjHJB6MVsD8tLD6qwc7eGSVpkhMiDIXTbd
   m0CQn3eGkNLDckb3KggpgZt/hMeAflWkYDqK2vhG2U+H0J1JYHxlHxnUn
   o0qmUNOtQ9C0Bu+1w7G4rmOJ27Gu4fAAforZRY5Q9DE0wLDmGeragO/W+
   0u8+LXbPZUrOy7ikNG+ZBHA501eYnPBB02XOUMz0aohThbCVp86c3CWcM
   K9CnJAwOFKklMX4aqKwTzM/y0I3bkTJfVHf9omLUC2rohm4Jf5ZK5mQSE
   Q==;
X-CSE-ConnectionGUID: 8GgRXRzFQjiLHVhXh0wXmQ==
X-CSE-MsgGUID: gZ744N0cRsGs8sIFs5z40g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40838288"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40838288"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:20:01 -0800
X-CSE-ConnectionGUID: /eF76LhzRh2zzXKUwSgkvw==
X-CSE-MsgGUID: PjrYJu1DRu+YRi9VAMtUgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117301546"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Feb 2025 11:19:58 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnjQK-000Dvi-2H;
	Thu, 27 Feb 2025 19:19:56 +0000
Date: Fri, 28 Feb 2025 03:19:02 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn, stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Use polling play_dead() when resuming from
 hibernation
Message-ID: <202502280356.YjzMIJ8n-lkp@intel.com>
References: <20250225111812.3065545-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225111812.3065545-1-chenhuacai@loongson.cn>

Hi Huacai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc4 next-20250227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Use-polling-play_dead-when-resuming-from-hibernation/20250225-192024
base:   linus/master
patch link:    https://lore.kernel.org/r/20250225111812.3065545-1-chenhuacai%40loongson.cn
patch subject: [PATCH] LoongArch: Use polling play_dead() when resuming from hibernation
config: loongarch-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250228/202502280356.YjzMIJ8n-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280356.YjzMIJ8n-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280356.YjzMIJ8n-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/loongarch/kernel/smp.c:451:24: warning: 'poll_play_dead' defined but not used [-Wunused-function]
     451 | static void __noreturn poll_play_dead(void)
         |                        ^~~~~~~~~~~~~~


vim +/poll_play_dead +451 arch/loongarch/kernel/smp.c

   450	
 > 451	static void __noreturn poll_play_dead(void)
   452	{
   453		register uint64_t addr;
   454		register void (*init_fn)(void);
   455	
   456		idle_task_exit();
   457		__this_cpu_write(cpu_state, CPU_DEAD);
   458	
   459		__smp_mb();
   460		do {
   461			__asm__ __volatile__("nop\n\t");
   462			addr = iocsr_read64(LOONGARCH_IOCSR_MBUF0);
   463		} while (addr == 0);
   464	
   465		init_fn = (void *)TO_CACHE(addr);
   466		iocsr_write32(0xffffffff, LOONGARCH_IOCSR_IPI_CLEAR);
   467	
   468		init_fn();
   469		BUG();
   470	}
   471	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

