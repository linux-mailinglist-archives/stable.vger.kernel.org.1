Return-Path: <stable+bounces-203144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51453CD314F
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 16:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9718830198F8
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865632D593E;
	Sat, 20 Dec 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKbSROxq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DE26CE2C;
	Sat, 20 Dec 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766242816; cv=none; b=JDvbIXnu9uj7sC4Fio3E/QQmnqctImlTngdFBh3JNG9LHiA2WqL2zuC+oiWCHE3SBI8TTlUvdh4QQVwl0S48VB89rgZifyG6VqhPs0SOr7wsb31ztcmafJ2zM/eox/5eVk4Jxla/XoykZ2i3kSiFWLan3JnpXRLW4a8mYAt7sNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766242816; c=relaxed/simple;
	bh=uSnvQA1wkSEC1dHkQCd7ejRleGA1HqpoOspiSpwnylk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wi+g5iGOE9Bzu0Hmk6hA/boMJs+S5b9+v6npSp5bj6lCJPBlQtf9hc3Gv5zKmZTb+8j6WRyYbfMh+QQofdEIFmqxVM/Sng1sePWNAX4dxA7IuPDskR6zLuQdekd8hw0m1TqejlD9mO05wgMZtqiQn7eNKmu1Y2iP47sOIAXBWd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKbSROxq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766242814; x=1797778814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uSnvQA1wkSEC1dHkQCd7ejRleGA1HqpoOspiSpwnylk=;
  b=AKbSROxqsswvff4FNbDxuxUnHFpcUzR5zlAp9+2g1lKOzG1Q/xTDNAGF
   WqQ+ZIqG0/gPyVJp7REh1qgNJflfQswQJhwGnVIytTACVtePdh3Nu9hl9
   35dac042ThpHh+a3wv/N0KecZWhCl1H9tsS4nCx6Y98GZmYQROXcgXtEa
   kKlTMRteP1qCgvEQDTWmOSKVJ/cT3tjwBdac4nf+OD5oy2dR7KbZbtBCX
   W4niTG9APP2siGG/RqeEENbswUyr5yT6ORMrwkJ8bhpVINfVtp/lvNlFk
   ynbq+G2QsJCCZPiO46EYfStJO40tiKQvneZ1vW5jRaO2OYQEfLF5Cnnx6
   Q==;
X-CSE-ConnectionGUID: iMBOFmq2T8OB0L5SqPVbuw==
X-CSE-MsgGUID: D6JXmFSbSbiglmig3zmAVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="72034843"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="72034843"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 07:00:13 -0800
X-CSE-ConnectionGUID: imxei5xGQcSOqyMwLY3qDQ==
X-CSE-MsgGUID: cnKfc8VmRHW6tcsjhj20iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="198359995"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Dec 2025 07:00:12 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWyRF-000000004hb-0ajS;
	Sat, 20 Dec 2025 15:00:09 +0000
Date: Sat, 20 Dec 2025 22:59:12 +0800
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] clockevents: add a error handling in
 tick_broadcast_init_sysfs()
Message-ID: <202512202122.Alirqoxm-lkp@intel.com>
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
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20251220/202512202122.Alirqoxm-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202122.Alirqoxm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202122.Alirqoxm-lkp@intel.com/

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

