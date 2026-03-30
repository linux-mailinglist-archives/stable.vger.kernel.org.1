Return-Path: <stable+bounces-231295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C6xIVkCy2k2CgYAu9opvQ
	(envelope-from <stable+bounces-231295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 01:08:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 088AB36244B
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 01:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33F183042FF1
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ABF3B6BE8;
	Mon, 30 Mar 2026 23:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKph7jeG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACAB3A8FE1;
	Mon, 30 Mar 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911956; cv=none; b=rat2EL0al3WTPf8Nm9gjzjQrWA6qsZxkYVF92xCTa9IWHqyAiFbCcpj9/t83wc8xFn+m8/hWHCywpJ4N+QNGeL0oCbTnpxdLQbPF3qOpVBROEQuuKjv5CrHNohCsg9PwV3oqzyuRgCOVM/DqUd7kc7vx8K5dBqLVhbEMXObavqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911956; c=relaxed/simple;
	bh=bsGBeeaP7YCj4zXTIDV7UWWoZx7yvSrsM7TzxUtUiFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3H/OLOJ4WB+PTD6/soibSu1uSPjbfBLXJ1ePwGlECaiCg1ZntVPuIoKs/7HBuEFUQdQWp+M1h0VtiPTd7WHBX4EteHunhlGWFnLoyNXqVRqE3QtMZ28daEA3EOk0x5aW1Tkpz6TyqYLL4BNq2ZFbrCIyJMg+8inXmZDIIJM8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKph7jeG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911955; x=1806447955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bsGBeeaP7YCj4zXTIDV7UWWoZx7yvSrsM7TzxUtUiFc=;
  b=PKph7jeGiWJCRWCCWWAJsRZg1+zvOw8Oiypo4dgp7LPxzrkJ81p3jpPU
   LV6xmUmiW1Bcr5miQarkeEnxyppjN5JyVs77FcNeOw2m784/Ea+2GPL2X
   lydTNY/AsPW4UeGsSOjl2NAQd4ZIu+7SXL+xDSijjWAWh1fmr22TKOvew
   theazrCY4kshWDFoh4j3OosqhIKUXEI4RSp1FvE0uPo5AX+Uy+pl+i4nj
   Y1Rh6pP0CX39C/3HSm3wsW3l5T1b47+9G6ElfkW5avRup0L4nnJJ/jKwX
   TKcnCEhHu2uZMOx+tu+M/MYmKUcKrCwNDz+Oud2MnQZlb35Y8aIZ9i26s
   w==;
X-CSE-ConnectionGUID: txFSM+pMRnuwbkzyn9jlaA==
X-CSE-MsgGUID: Le9VM9fjT/+92Fo7tKCuRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86608827"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="86608827"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:05:54 -0700
X-CSE-ConnectionGUID: sdC6e3sJTT2WbgfgNCyD5w==
X-CSE-MsgGUID: mw1phzs3SvycRZitSSZr0Q==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 30 Mar 2026 16:05:52 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7Lg5-000000001pV-2ImJ;
	Mon, 30 Mar 2026 23:05:49 +0000
Date: Tue, 31 Mar 2026 07:05:00 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
	gregkh@linuxfoundation.org
Cc: oe-kbuild-all@lists.linux.dev, marvin24@gmx.de,
	linux-staging@lists.linux.dev, ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?iso-8859-1?Q?Sebasti=E1n?= Alba Vives <sebasjosue84@gmail.com>
Subject: Re: [PATCH v2] staging: nvec: validate battery response length
 before memcpy
Message-ID: <202603310649.6iHw5wAQ-lkp@intel.com>
References: <20260330060926.751031-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330060926.751031-1-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmx.de,lists.launchpad.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-231295-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 088AB36244B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Josue-Alba-Vives/staging-nvec-validate-battery-response-length-before-memcpy/20260330-174322
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260330060926.751031-1-sebasjosue84%40gmail.com
patch subject: [PATCH v2] staging: nvec: validate battery response length before memcpy
config: arm64-randconfig-r054-20260331 (https://download.01.org/0day-ci/archive/20260331/202603310649.6iHw5wAQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603310649.6iHw5wAQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603310649.6iHw5wAQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/staging/nvec/nvec_power.c: In function 'nvec_power_bat_notifier':
   drivers/staging/nvec/nvec_power.c:237:12: error: invalid storage class for function 'nvec_power_get_property'
     237 | static int nvec_power_get_property(struct power_supply *psy,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:253:12: error: invalid storage class for function 'nvec_battery_get_property'
     253 | static int nvec_battery_get_property(struct power_supply *psy,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:344:18: error: initializer element is not constant
     344 |  .get_property = nvec_battery_get_property,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:344:18: note: (near initialization for 'nvec_bat_psy_desc.get_property')
   drivers/staging/nvec/nvec_power.c:352:18: error: initializer element is not constant
     352 |  .get_property = nvec_power_get_property,
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:352:18: note: (near initialization for 'nvec_psy_desc.get_property')
   drivers/staging/nvec/nvec_power.c:363:13: error: invalid storage class for function 'nvec_power_poll'
     363 | static void nvec_power_poll(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:387:12: error: invalid storage class for function 'nvec_power_probe'
     387 | static int nvec_power_probe(struct platform_device *pdev)
         |            ^~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:434:13: error: invalid storage class for function 'nvec_power_remove'
     434 | static void nvec_power_remove(struct platform_device *pdev)
         |             ^~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:450:11: error: initializer element is not constant
     450 |  .probe = nvec_power_probe,
         |           ^~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:450:11: note: (near initialization for 'nvec_power_driver.probe')
   drivers/staging/nvec/nvec_power.c:451:12: error: initializer element is not constant
     451 |  .remove = nvec_power_remove,
         |            ^~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:451:12: note: (near initialization for 'nvec_power_driver.remove')
   In file included from include/linux/device.h:32,
                    from include/linux/platform_device.h:13,
                    from drivers/staging/nvec/nvec_power.c:12:
   drivers/staging/nvec/nvec_power.c:457:24: error: invalid storage class for function 'nvec_power_driver_init'
     457 | module_platform_driver(nvec_power_driver);
         |                        ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:267:19: note: in definition of macro 'module_driver'
     267 | static int __init __driver##_init(void) \
         |                   ^~~~~~~~
   drivers/staging/nvec/nvec_power.c:457:1: note: in expansion of macro 'module_platform_driver'
     457 | module_platform_driver(nvec_power_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/staging/nvec/nvec_power.c:11:
   include/linux/module.h:132:42: error: invalid storage class for function '__inittest'
     132 |  static inline initcall_t __maybe_unused __inittest(void)  \
         |                                          ^~~~~~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
     271 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:295:2: note: in expansion of macro 'module_driver'
     295 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:457:1: note: in expansion of macro 'module_platform_driver'
     457 | module_platform_driver(nvec_power_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/nvec/nvec_power.c:457:1: warning: 'alias' attribute ignored [-Wattributes]
   In file included from include/linux/device.h:32,
                    from include/linux/platform_device.h:13,
                    from drivers/staging/nvec/nvec_power.c:12:
   drivers/staging/nvec/nvec_power.c:457:24: error: invalid storage class for function 'nvec_power_driver_exit'
     457 | module_platform_driver(nvec_power_driver);
         |                        ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:272:20: note: in definition of macro 'module_driver'
     272 | static void __exit __driver##_exit(void) \
         |                    ^~~~~~~~
   drivers/staging/nvec/nvec_power.c:457:1: note: in expansion of macro 'module_platform_driver'
     457 | module_platform_driver(nvec_power_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/staging/nvec/nvec_power.c:11:
   include/linux/module.h:140:42: error: invalid storage class for function '__exittest'
     140 |  static inline exitcall_t __maybe_unused __exittest(void)  \
         |                                          ^~~~~~~~~~
   include/linux/device/driver.h:276:1: note: in expansion of macro 'module_exit'
     276 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:295:2: note: in expansion of macro 'module_driver'
     295 |  module_driver(__platform_driver, platform_driver_register, \
         |  ^~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:457:1: note: in expansion of macro 'module_platform_driver'
     457 | module_platform_driver(nvec_power_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/nvec/nvec_power.c:457:1: warning: 'alias' attribute ignored [-Wattributes]
   drivers/staging/nvec/nvec_power.c:462:1: error: expected declaration or statement at end of input
     462 | MODULE_ALIAS("platform:nvec-power");
         | ^~~~~~~~~~~~


vim +/alias +457 drivers/staging/nvec/nvec_power.c

32890b983086136 Marc Dietrich 2011-05-19  456  
9891b1ce6276912 Marc Dietrich 2012-06-24 @457  module_platform_driver(nvec_power_driver);
32890b983086136 Marc Dietrich 2011-05-19  458  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

