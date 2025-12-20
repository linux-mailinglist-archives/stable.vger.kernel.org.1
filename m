Return-Path: <stable+bounces-203152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9AFCD3779
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 22:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58387300854F
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 21:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB9827FB32;
	Sat, 20 Dec 2025 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h778bSiB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACCF260565;
	Sat, 20 Dec 2025 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766266492; cv=none; b=pofmxLPJPuyLUkhGcyoQ+oPtkhQTv135bzOf+sECkSUQrD67lFVok/DoaWF4RNDEEcMi3ycpXmUQkftEwoIV8bpMY7BJuTpOiaBTvBWoIH+DCTcW+r6+juY0RqTTj7EWTiC8aAOMeOuwJsJnXtMeNVNylITAjl1nMufbGqfVrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766266492; c=relaxed/simple;
	bh=TPrZbdGURUWVr83ioH21DlxQDqf0527AKNGtmtqm8rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tne52PRuIR4ChUEZiCn8p7lFxQUpXU6lS82UzAiuCzAZw4irP0xBH/F6X4tEEh7RI/x+bRuQnzpSjV//LBVtotBr1dcSzs16Gz4uX4s5MpotNf0tLbMUIk4qI+bFEGVoeTLkD913o5WQqadTh79ua1AxLvTk7sMAUt2iBz/KHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h778bSiB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766266491; x=1797802491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TPrZbdGURUWVr83ioH21DlxQDqf0527AKNGtmtqm8rE=;
  b=h778bSiBJcsbWS7/polYk1NWNkhwK6B3yUp6hzU2rmUXzg4aUr1wY13N
   s7aiQCRtvuP91a1wd5HkeaHNFAVvs7Oupk1eA6R27YR4Kms1+hzhgXZ9b
   X3ihWZgGC6ceYXRZtR4wt4sWUxmsv2NXGVsyPCux+mb3DqLvGd2C2vM+H
   g3kJPcuL3eQe5GvbQ5zTmjgif4ck7ECus3Gl0LJDJ0KyvCMogewyXGo4U
   xLk1zFKDNcZruVL5eHsB5Gl8oga21vL7Hrqy6h3VWjHS+HK9mTrib7tt6
   889fNBtn6PgRhTJg84Jr6CoSBPFXzV+nK0AuMlca9OE7HmsDbwG8xNpCU
   A==;
X-CSE-ConnectionGUID: 4hqqR8ghR9WllNXd4doynQ==
X-CSE-MsgGUID: wv7ueV47QVesrquekNWroQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="72032875"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="72032875"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 13:34:51 -0800
X-CSE-ConnectionGUID: HRAItO7LTgC4bB+OaeLogQ==
X-CSE-MsgGUID: wi1fM9ZfRKiJiOHsgTvoIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199416244"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 20 Dec 2025 13:34:48 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX4b7-000000004mu-261M;
	Sat, 20 Dec 2025 21:34:45 +0000
Date: Sat, 20 Dec 2025 22:34:34 +0100
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] clockevents: add a error handling in
 tick_broadcast_init_sysfs()
Message-ID: <202512202225.llvIQzJk-lkp@intel.com>
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
[also build test ERROR on linus/master v6.16-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoxiang-Li/clockevents-add-a-error-handling-in-tick_broadcast_init_sysfs/20251218-170931
base:   tip/timers/core
patch link:    https://lore.kernel.org/r/20251218090625.557965-1-lihaoxiang%40isrc.iscas.ac.cn
patch subject: [PATCH] clockevents: add a error handling in tick_broadcast_init_sysfs()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251220/202512202225.llvIQzJk-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202225.llvIQzJk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202225.llvIQzJk-lkp@intel.com/

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

