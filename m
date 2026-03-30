Return-Path: <stable+bounces-231073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IhyBPpFymm/7AUAu9opvQ
	(envelope-from <stable+bounces-231073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:44:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D535869B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05364304A10F
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD0F3B4E88;
	Mon, 30 Mar 2026 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HuosuvKW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB33A3E96;
	Mon, 30 Mar 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863415; cv=none; b=aixnnWQp/p0jbhACUlqUvPph7/0a8ikmxQFE7a17k1NgfQBGhf0odofCoPiMHR3aWZLHUduH20LwWEoOXKPhPX7wr94CJTBaNQ+6m3AVzFaqaCaCE44Uikdicr4IMC4oha6o6/MpwphOtlz2zJ3wMoM6lVGKjtWtppCxzUi0E2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863415; c=relaxed/simple;
	bh=Dxo+2Ufg2CcWXxlSo8Ifdp4hA4ODMmBYIYL/vSgOdyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxG/AlKRpE6nFZsYF2x49nB4qm3uv5z6eDLt6EUVa4b6ytajgnPSMSWD4EY/CAj9P/J2OUEA9jziBXBhdb8bjU710AiYdaf1ZLXBZsh3NrQJeWFE3cv4gKsDxB/7KqgWyoy2E9DU8nNX60ZLBeTDV2FyOntc8BlqLiWAQdAXuvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HuosuvKW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774863414; x=1806399414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Dxo+2Ufg2CcWXxlSo8Ifdp4hA4ODMmBYIYL/vSgOdyA=;
  b=HuosuvKWu4TAViTWTRrc8pd3NhsBGpbGt6cDxAnuUXTzThJHEGjRQCjK
   o5cnM3d+ABPyyUH/moEI9Ukf4Y4XCDtkePSgIDLt0MaYyN9bPoUuL0+zn
   UUutCENtcxbmqPtQZuuIo5N+HvuOE5XO+cAYko9lWfU445onCMVQrHmBV
   an82to/fuJSs3LBXyIIcw0/9L6Ozt7bkGpPBAFHBFoUKAsGztR1BKTQBm
   XtbWh6iodFlVU8myieab93MOKPeMEMtUfFM9VBq4twbP5J99LNjCTL1tx
   cZpIn9GBd9APtkVGASU9wjdTxD4Ahxu0NWR0w7v0ycfaCSIlE2neNktzT
   A==;
X-CSE-ConnectionGUID: YJGY8YmMQuiFp2GGvh1jXw==
X-CSE-MsgGUID: rYocplYDQi6YAM6/jEGzuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="76041951"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="76041951"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 02:36:53 -0700
X-CSE-ConnectionGUID: if+G9b2RT2i+fj5n4Ki+5g==
X-CSE-MsgGUID: aDSCmdUMRDKeVVjcuZSAQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; 
   d="scan'208";a="219358518"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 30 Mar 2026 02:36:50 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w793A-000000000uv-2AJe;
	Mon, 30 Mar 2026 09:36:48 +0000
Date: Mon, 30 Mar 2026 17:36:40 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, marvin24@gmx.de
Cc: oe-kbuild-all@lists.linux.dev, ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?iso-8859-1?Q?Sebasti=E1n?= Alba Vives <sebasjosue84@gmail.com>
Subject: Re: [PATCH v2] staging: nvec: validate battery response length
 before memcpy
Message-ID: <202603301722.axpoITcy-lkp@intel.com>
References: <20260329210800.597697-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260329210800.597697-1-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.launchpad.net,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-231073-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,gmx.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 791D535869B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sebastian,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Josue-Alba-Vives/staging-nvec-validate-battery-response-length-before-memcpy/20260330-083704
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260329210800.597697-1-sebasjosue84%40gmail.com
patch subject: [PATCH v2] staging: nvec: validate battery response length before memcpy
config: arm64-randconfig-003-20260330 (https://download.01.org/0day-ci/archive/20260330/202603301722.axpoITcy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260330/202603301722.axpoITcy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603301722.axpoITcy-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/staging/nvec/nvec_power.c: In function 'nvec_power_bat_notifier':
>> drivers/staging/nvec/nvec_power.c:237:12: error: invalid storage class for function 'nvec_power_get_property'
    static int nvec_power_get_property(struct power_supply *psy,
               ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/nvec/nvec_power.c:253:12: error: invalid storage class for function 'nvec_battery_get_property'
    static int nvec_battery_get_property(struct power_supply *psy,
               ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/nvec/nvec_power.c:344:18: error: initializer element is not constant
     .get_property = nvec_battery_get_property,
                     ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:344:18: note: (near initialization for 'nvec_bat_psy_desc.get_property')
   drivers/staging/nvec/nvec_power.c:352:18: error: initializer element is not constant
     .get_property = nvec_power_get_property,
                     ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:352:18: note: (near initialization for 'nvec_psy_desc.get_property')
>> drivers/staging/nvec/nvec_power.c:363:13: error: invalid storage class for function 'nvec_power_poll'
    static void nvec_power_poll(struct work_struct *work)
                ^~~~~~~~~~~~~~~
>> drivers/staging/nvec/nvec_power.c:387:12: error: invalid storage class for function 'nvec_power_probe'
    static int nvec_power_probe(struct platform_device *pdev)
               ^~~~~~~~~~~~~~~~
>> drivers/staging/nvec/nvec_power.c:434:13: error: invalid storage class for function 'nvec_power_remove'
    static void nvec_power_remove(struct platform_device *pdev)
                ^~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:450:11: error: initializer element is not constant
     .probe = nvec_power_probe,
              ^~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:450:11: note: (near initialization for 'nvec_power_driver.probe')
   drivers/staging/nvec/nvec_power.c:451:12: error: initializer element is not constant
     .remove = nvec_power_remove,
               ^~~~~~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:451:12: note: (near initialization for 'nvec_power_driver.remove')
   In file included from include/linux/device.h:32,
                    from include/linux/platform_device.h:13,
                    from drivers/staging/nvec/nvec_power.c:12:
>> drivers/staging/nvec/nvec_power.c:457:24: error: invalid storage class for function 'nvec_power_driver_init'
    module_platform_driver(nvec_power_driver);
                           ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:267:19: note: in definition of macro 'module_driver'
    static int __init __driver##_init(void) \
                      ^~~~~~~~
   drivers/staging/nvec/nvec_power.c:457:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(nvec_power_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/staging/nvec/nvec_power.c:11:
   include/linux/compiler.h:276:44: error: initializer element is not constant
     __UNIQUE_ID(__PASTE(addressable_, sym)) = (void *)(uintptr_t)&sym;
                                               ^
   include/linux/compiler.h:279:2: note: in expansion of macro '___ADDRESSABLE'
     ___ADDRESSABLE(sym, __section(".discard.addressable"))
     ^~~~~~~~~~~~~~
   include/linux/init.h:251:2: note: in expansion of macro '__ADDRESSABLE'
     __ADDRESSABLE(fn)
     ^~~~~~~~~~~~~
   include/linux/init.h:256:2: note: in expansion of macro '__define_initcall_stub'
     __define_initcall_stub(__stub, fn)   \
     ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:269:2: note: in expansion of macro '____define_initcall'
     ____define_initcall(fn,     \
     ^~~~~~~~~~~~~~~~~~~
   include/linux/init.h:275:2: note: in expansion of macro '__unique_initcall'
     __unique_initcall(fn, id, __sec, __initcall_id(fn))
     ^~~~~~~~~~~~~~~~~
   include/linux/init.h:277:35: note: in expansion of macro '___define_initcall'
    #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
                                      ^~~~~~~~~~~~~~~~~~
   include/linux/init.h:306:30: note: in expansion of macro '__define_initcall'
    #define device_initcall(fn)  __define_initcall(fn, 6)
                                 ^~~~~~~~~~~~~~~~~
   include/linux/init.h:311:24: note: in expansion of macro 'device_initcall'
    #define __initcall(fn) device_initcall(fn)
                           ^~~~~~~~~~~~~~~
   include/linux/module.h:89:24: note: in expansion of macro '__initcall'
    #define module_init(x) __initcall(x);
                           ^~~~~~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:295:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:457:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(nvec_power_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/device.h:32,
                    from include/linux/platform_device.h:13,
                    from drivers/staging/nvec/nvec_power.c:12:
>> drivers/staging/nvec/nvec_power.c:457:24: error: invalid storage class for function 'nvec_power_driver_exit'
    module_platform_driver(nvec_power_driver);
                           ^~~~~~~~~~~~~~~~~
   include/linux/device/driver.h:272:20: note: in definition of macro 'module_driver'
    static void __exit __driver##_exit(void) \
                       ^~~~~~~~
   drivers/staging/nvec/nvec_power.c:457:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(nvec_power_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm64/include/asm/alternative.h:9,
                    from arch/arm64/include/asm/lse.h:12,
                    from arch/arm64/include/asm/cmpxchg.h:14,
                    from arch/arm64/include/asm/atomic.h:16,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/arm64/include/asm/bitops.h:25,
                    from include/linux/bitops.h:67,
                    from arch/arm64/include/asm/cache.h:40,
                    from include/vdso/cache.h:5,
                    from include/linux/cache.h:6,
                    from include/linux/time.h:5,
                    from arch/arm64/include/asm/stat.h:12,
                    from include/linux/stat.h:6,
                    from include/linux/module.h:13,
                    from drivers/staging/nvec/nvec_power.c:11:
   drivers/staging/nvec/nvec_power.c:457:24: error: initializer element is not constant
    module_platform_driver(nvec_power_driver);
                           ^~~~~~~~~~~~~~~~~
   include/linux/init.h:314:50: note: in definition of macro '__exitcall'
     static exitcall_t __exitcall_##fn __exit_call = fn
                                                     ^~
   include/linux/device/driver.h:276:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:295:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/staging/nvec/nvec_power.c:457:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(nvec_power_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/nvec/nvec_power.c:462:1: error: expected declaration or statement at end of input
    MODULE_ALIAS("platform:nvec-power");
    ^~~~~~~~~~~~


vim +/nvec_power_get_property +237 drivers/staging/nvec/nvec_power.c

32890b98308613 Marc Dietrich       2011-05-19  236  
32890b98308613 Marc Dietrich       2011-05-19 @237  static int nvec_power_get_property(struct power_supply *psy,
32890b98308613 Marc Dietrich       2011-05-19  238  				   enum power_supply_property psp,
32890b98308613 Marc Dietrich       2011-05-19  239  				   union power_supply_propval *val)
32890b98308613 Marc Dietrich       2011-05-19  240  {
297d716f6260cc Krzysztof Kozlowski 2015-03-12  241  	struct nvec_power *power = dev_get_drvdata(psy->dev.parent);
fa799617865037 Pawel Lebioda       2014-07-03  242  
32890b98308613 Marc Dietrich       2011-05-19  243  	switch (psp) {
32890b98308613 Marc Dietrich       2011-05-19  244  	case POWER_SUPPLY_PROP_ONLINE:
32890b98308613 Marc Dietrich       2011-05-19  245  		val->intval = power->on;
32890b98308613 Marc Dietrich       2011-05-19  246  		break;
32890b98308613 Marc Dietrich       2011-05-19  247  	default:
32890b98308613 Marc Dietrich       2011-05-19  248  		return -EINVAL;
32890b98308613 Marc Dietrich       2011-05-19  249  	}
32890b98308613 Marc Dietrich       2011-05-19  250  	return 0;
32890b98308613 Marc Dietrich       2011-05-19  251  }
32890b98308613 Marc Dietrich       2011-05-19  252  
32890b98308613 Marc Dietrich       2011-05-19 @253  static int nvec_battery_get_property(struct power_supply *psy,
32890b98308613 Marc Dietrich       2011-05-19  254  				     enum power_supply_property psp,
32890b98308613 Marc Dietrich       2011-05-19  255  				     union power_supply_propval *val)
32890b98308613 Marc Dietrich       2011-05-19  256  {
297d716f6260cc Krzysztof Kozlowski 2015-03-12  257  	struct nvec_power *power = dev_get_drvdata(psy->dev.parent);
32890b98308613 Marc Dietrich       2011-05-19  258  
162c7d8c4be2d5 Marc Dietrich       2011-09-27  259  	switch (psp) {
32890b98308613 Marc Dietrich       2011-05-19  260  	case POWER_SUPPLY_PROP_STATUS:
32890b98308613 Marc Dietrich       2011-05-19  261  		val->intval = power->bat_status;
32890b98308613 Marc Dietrich       2011-05-19  262  		break;
32890b98308613 Marc Dietrich       2011-05-19  263  	case POWER_SUPPLY_PROP_CAPACITY:
32890b98308613 Marc Dietrich       2011-05-19  264  		val->intval = power->bat_cap;
32890b98308613 Marc Dietrich       2011-05-19  265  		break;
32890b98308613 Marc Dietrich       2011-05-19  266  	case POWER_SUPPLY_PROP_PRESENT:
32890b98308613 Marc Dietrich       2011-05-19  267  		val->intval = power->bat_present;
32890b98308613 Marc Dietrich       2011-05-19  268  		break;
32890b98308613 Marc Dietrich       2011-05-19  269  	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
32890b98308613 Marc Dietrich       2011-05-19  270  		val->intval = power->bat_voltage_now;
32890b98308613 Marc Dietrich       2011-05-19  271  		break;
32890b98308613 Marc Dietrich       2011-05-19  272  	case POWER_SUPPLY_PROP_CURRENT_NOW:
32890b98308613 Marc Dietrich       2011-05-19  273  		val->intval = power->bat_current_now;
32890b98308613 Marc Dietrich       2011-05-19  274  		break;
32890b98308613 Marc Dietrich       2011-05-19  275  	case POWER_SUPPLY_PROP_CURRENT_AVG:
32890b98308613 Marc Dietrich       2011-05-19  276  		val->intval = power->bat_current_avg;
32890b98308613 Marc Dietrich       2011-05-19  277  		break;
32890b98308613 Marc Dietrich       2011-05-19  278  	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
32890b98308613 Marc Dietrich       2011-05-19  279  		val->intval = power->time_remain;
32890b98308613 Marc Dietrich       2011-05-19  280  		break;
32890b98308613 Marc Dietrich       2011-05-19  281  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
32890b98308613 Marc Dietrich       2011-05-19  282  		val->intval = power->charge_full_design;
32890b98308613 Marc Dietrich       2011-05-19  283  		break;
32890b98308613 Marc Dietrich       2011-05-19  284  	case POWER_SUPPLY_PROP_CHARGE_FULL:
32890b98308613 Marc Dietrich       2011-05-19  285  		val->intval = power->charge_last_full;
32890b98308613 Marc Dietrich       2011-05-19  286  		break;
32890b98308613 Marc Dietrich       2011-05-19  287  	case POWER_SUPPLY_PROP_CHARGE_EMPTY:
32890b98308613 Marc Dietrich       2011-05-19  288  		val->intval = power->critical_capacity;
32890b98308613 Marc Dietrich       2011-05-19  289  		break;
32890b98308613 Marc Dietrich       2011-05-19  290  	case POWER_SUPPLY_PROP_CHARGE_NOW:
32890b98308613 Marc Dietrich       2011-05-19  291  		val->intval = power->capacity_remain;
32890b98308613 Marc Dietrich       2011-05-19  292  		break;
32890b98308613 Marc Dietrich       2011-05-19  293  	case POWER_SUPPLY_PROP_TEMP:
32890b98308613 Marc Dietrich       2011-05-19  294  		val->intval = power->bat_temperature;
32890b98308613 Marc Dietrich       2011-05-19  295  		break;
32890b98308613 Marc Dietrich       2011-05-19  296  	case POWER_SUPPLY_PROP_MANUFACTURER:
32890b98308613 Marc Dietrich       2011-05-19  297  		val->strval = power->bat_manu;
32890b98308613 Marc Dietrich       2011-05-19  298  		break;
32890b98308613 Marc Dietrich       2011-05-19  299  	case POWER_SUPPLY_PROP_MODEL_NAME:
32890b98308613 Marc Dietrich       2011-05-19  300  		val->strval = power->bat_model;
32890b98308613 Marc Dietrich       2011-05-19  301  		break;
32890b98308613 Marc Dietrich       2011-05-19  302  	case POWER_SUPPLY_PROP_TECHNOLOGY:
32890b98308613 Marc Dietrich       2011-05-19  303  		val->intval = power->bat_type_enum;
32890b98308613 Marc Dietrich       2011-05-19  304  		break;
32890b98308613 Marc Dietrich       2011-05-19  305  	default:
32890b98308613 Marc Dietrich       2011-05-19  306  		return -EINVAL;
32890b98308613 Marc Dietrich       2011-05-19  307  	}
32890b98308613 Marc Dietrich       2011-05-19  308  	return 0;
32890b98308613 Marc Dietrich       2011-05-19  309  }
32890b98308613 Marc Dietrich       2011-05-19  310  
32890b98308613 Marc Dietrich       2011-05-19  311  static enum power_supply_property nvec_power_props[] = {
32890b98308613 Marc Dietrich       2011-05-19  312  	POWER_SUPPLY_PROP_ONLINE,
32890b98308613 Marc Dietrich       2011-05-19  313  };
32890b98308613 Marc Dietrich       2011-05-19  314  
32890b98308613 Marc Dietrich       2011-05-19  315  static enum power_supply_property nvec_battery_props[] = {
32890b98308613 Marc Dietrich       2011-05-19  316  	POWER_SUPPLY_PROP_STATUS,
32890b98308613 Marc Dietrich       2011-05-19  317  	POWER_SUPPLY_PROP_PRESENT,
32890b98308613 Marc Dietrich       2011-05-19  318  	POWER_SUPPLY_PROP_CAPACITY,
32890b98308613 Marc Dietrich       2011-05-19  319  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
32890b98308613 Marc Dietrich       2011-05-19  320  	POWER_SUPPLY_PROP_CURRENT_NOW,
32890b98308613 Marc Dietrich       2011-05-19  321  #ifdef EC_FULL_DIAG
32890b98308613 Marc Dietrich       2011-05-19  322  	POWER_SUPPLY_PROP_CURRENT_AVG,
32890b98308613 Marc Dietrich       2011-05-19  323  	POWER_SUPPLY_PROP_TEMP,
32890b98308613 Marc Dietrich       2011-05-19  324  	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
32890b98308613 Marc Dietrich       2011-05-19  325  #endif
32890b98308613 Marc Dietrich       2011-05-19  326  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
32890b98308613 Marc Dietrich       2011-05-19  327  	POWER_SUPPLY_PROP_CHARGE_FULL,
32890b98308613 Marc Dietrich       2011-05-19  328  	POWER_SUPPLY_PROP_CHARGE_EMPTY,
32890b98308613 Marc Dietrich       2011-05-19  329  	POWER_SUPPLY_PROP_CHARGE_NOW,
32890b98308613 Marc Dietrich       2011-05-19  330  	POWER_SUPPLY_PROP_MANUFACTURER,
32890b98308613 Marc Dietrich       2011-05-19  331  	POWER_SUPPLY_PROP_MODEL_NAME,
32890b98308613 Marc Dietrich       2011-05-19  332  	POWER_SUPPLY_PROP_TECHNOLOGY,
32890b98308613 Marc Dietrich       2011-05-19  333  };
32890b98308613 Marc Dietrich       2011-05-19  334  
32890b98308613 Marc Dietrich       2011-05-19  335  static char *nvec_power_supplied_to[] = {
32890b98308613 Marc Dietrich       2011-05-19  336  	"battery",
32890b98308613 Marc Dietrich       2011-05-19  337  };
32890b98308613 Marc Dietrich       2011-05-19  338  
297d716f6260cc Krzysztof Kozlowski 2015-03-12  339  static const struct power_supply_desc nvec_bat_psy_desc = {
32890b98308613 Marc Dietrich       2011-05-19  340  	.name = "battery",
32890b98308613 Marc Dietrich       2011-05-19  341  	.type = POWER_SUPPLY_TYPE_BATTERY,
32890b98308613 Marc Dietrich       2011-05-19  342  	.properties = nvec_battery_props,
32890b98308613 Marc Dietrich       2011-05-19  343  	.num_properties = ARRAY_SIZE(nvec_battery_props),
32890b98308613 Marc Dietrich       2011-05-19 @344  	.get_property = nvec_battery_get_property,
32890b98308613 Marc Dietrich       2011-05-19  345  };
32890b98308613 Marc Dietrich       2011-05-19  346  
297d716f6260cc Krzysztof Kozlowski 2015-03-12  347  static const struct power_supply_desc nvec_psy_desc = {
32890b98308613 Marc Dietrich       2011-05-19  348  	.name = "ac",
32890b98308613 Marc Dietrich       2011-05-19  349  	.type = POWER_SUPPLY_TYPE_MAINS,
32890b98308613 Marc Dietrich       2011-05-19  350  	.properties = nvec_power_props,
32890b98308613 Marc Dietrich       2011-05-19  351  	.num_properties = ARRAY_SIZE(nvec_power_props),
32890b98308613 Marc Dietrich       2011-05-19  352  	.get_property = nvec_power_get_property,
32890b98308613 Marc Dietrich       2011-05-19  353  };
32890b98308613 Marc Dietrich       2011-05-19  354  
162c7d8c4be2d5 Marc Dietrich       2011-09-27  355  static int counter;
dc31fc6ce69e03 Fatih Yildirim      2021-02-12  356  static const int bat_iter[] = {
32890b98308613 Marc Dietrich       2011-05-19  357  	SLOT_STATUS, VOLTAGE, CURRENT, CAPACITY_REMAINING,
32890b98308613 Marc Dietrich       2011-05-19  358  #ifdef EC_FULL_DIAG
32890b98308613 Marc Dietrich       2011-05-19  359  	AVERAGE_CURRENT, TEMPERATURE, TIME_REMAINING,
32890b98308613 Marc Dietrich       2011-05-19  360  #endif
32890b98308613 Marc Dietrich       2011-05-19  361  };
32890b98308613 Marc Dietrich       2011-05-19  362  
32890b98308613 Marc Dietrich       2011-05-19 @363  static void nvec_power_poll(struct work_struct *work)
32890b98308613 Marc Dietrich       2011-05-19  364  {
93eff83ff1640b Marc Dietrich       2013-01-27  365  	char buf[] = { NVEC_SYS, GET_SYSTEM_STATUS };
32890b98308613 Marc Dietrich       2011-05-19  366  	struct nvec_power *power = container_of(work, struct nvec_power,
32890b98308613 Marc Dietrich       2011-05-19  367  						poller.work);
32890b98308613 Marc Dietrich       2011-05-19  368  
32890b98308613 Marc Dietrich       2011-05-19  369  	if (counter >= ARRAY_SIZE(bat_iter))
32890b98308613 Marc Dietrich       2011-05-19  370  		counter = 0;
32890b98308613 Marc Dietrich       2011-05-19  371  
32890b98308613 Marc Dietrich       2011-05-19  372  	/* AC status via sys req */
32890b98308613 Marc Dietrich       2011-05-19  373  	nvec_write_async(power->nvec, buf, 2);
32890b98308613 Marc Dietrich       2011-05-19  374  	msleep(100);
32890b98308613 Marc Dietrich       2011-05-19  375  
66ad85d13f56b4 Simon Guinot        2015-12-09  376  	/*
66ad85d13f56b4 Simon Guinot        2015-12-09  377  	 * Select a battery request function via round robin doing it all at
66ad85d13f56b4 Simon Guinot        2015-12-09  378  	 * once seems to overload the power supply.
66ad85d13f56b4 Simon Guinot        2015-12-09  379  	 */
93eff83ff1640b Marc Dietrich       2013-01-27  380  	buf[0] = NVEC_BAT;
32890b98308613 Marc Dietrich       2011-05-19  381  	buf[1] = bat_iter[counter++];
32890b98308613 Marc Dietrich       2011-05-19  382  	nvec_write_async(power->nvec, buf, 2);
32890b98308613 Marc Dietrich       2011-05-19  383  
32890b98308613 Marc Dietrich       2011-05-19  384  	schedule_delayed_work(to_delayed_work(work), msecs_to_jiffies(5000));
32890b98308613 Marc Dietrich       2011-05-19  385  };
32890b98308613 Marc Dietrich       2011-05-19  386  
46620803c309d2 Bill Pemberton      2012-11-19 @387  static int nvec_power_probe(struct platform_device *pdev)
32890b98308613 Marc Dietrich       2011-05-19  388  {
297d716f6260cc Krzysztof Kozlowski 2015-03-12  389  	struct power_supply **psy;
297d716f6260cc Krzysztof Kozlowski 2015-03-12  390  	const struct power_supply_desc *psy_desc;
f5e3352e5185ef Marc Dietrich       2012-06-24  391  	struct nvec_power *power;
32890b98308613 Marc Dietrich       2011-05-19  392  	struct nvec_chip *nvec = dev_get_drvdata(pdev->dev.parent);
2dc9215d7c94f7 Krzysztof Kozlowski 2015-03-12  393  	struct power_supply_config psy_cfg = {};
32890b98308613 Marc Dietrich       2011-05-19  394  
f5e3352e5185ef Marc Dietrich       2012-06-24  395  	power = devm_kzalloc(&pdev->dev, sizeof(struct nvec_power), GFP_NOWAIT);
4c42d979816a0b Somya Anand         2015-03-16  396  	if (!power)
f5e3352e5185ef Marc Dietrich       2012-06-24  397  		return -ENOMEM;
f5e3352e5185ef Marc Dietrich       2012-06-24  398  
32890b98308613 Marc Dietrich       2011-05-19  399  	dev_set_drvdata(&pdev->dev, power);
32890b98308613 Marc Dietrich       2011-05-19  400  	power->nvec = nvec;
32890b98308613 Marc Dietrich       2011-05-19  401  
32890b98308613 Marc Dietrich       2011-05-19  402  	switch (pdev->id) {
32890b98308613 Marc Dietrich       2011-05-19  403  	case AC:
32890b98308613 Marc Dietrich       2011-05-19  404  		psy = &nvec_psy;
297d716f6260cc Krzysztof Kozlowski 2015-03-12  405  		psy_desc = &nvec_psy_desc;
2dc9215d7c94f7 Krzysztof Kozlowski 2015-03-12  406  		psy_cfg.supplied_to = nvec_power_supplied_to;
2dc9215d7c94f7 Krzysztof Kozlowski 2015-03-12  407  		psy_cfg.num_supplicants = ARRAY_SIZE(nvec_power_supplied_to);
32890b98308613 Marc Dietrich       2011-05-19  408  
32890b98308613 Marc Dietrich       2011-05-19  409  		power->notifier.notifier_call = nvec_power_notifier;
32890b98308613 Marc Dietrich       2011-05-19  410  
32890b98308613 Marc Dietrich       2011-05-19  411  		INIT_DELAYED_WORK(&power->poller, nvec_power_poll);
32890b98308613 Marc Dietrich       2011-05-19  412  		schedule_delayed_work(&power->poller, msecs_to_jiffies(5000));
32890b98308613 Marc Dietrich       2011-05-19  413  		break;
32890b98308613 Marc Dietrich       2011-05-19  414  	case BAT:
32890b98308613 Marc Dietrich       2011-05-19  415  		psy = &nvec_bat_psy;
297d716f6260cc Krzysztof Kozlowski 2015-03-12  416  		psy_desc = &nvec_bat_psy_desc;
32890b98308613 Marc Dietrich       2011-05-19  417  
32890b98308613 Marc Dietrich       2011-05-19  418  		power->notifier.notifier_call = nvec_power_bat_notifier;
32890b98308613 Marc Dietrich       2011-05-19  419  		break;
32890b98308613 Marc Dietrich       2011-05-19  420  	default:
32890b98308613 Marc Dietrich       2011-05-19  421  		return -ENODEV;
32890b98308613 Marc Dietrich       2011-05-19  422  	}
32890b98308613 Marc Dietrich       2011-05-19  423  
32890b98308613 Marc Dietrich       2011-05-19  424  	nvec_register_notifier(nvec, &power->notifier, NVEC_SYS);
32890b98308613 Marc Dietrich       2011-05-19  425  
32890b98308613 Marc Dietrich       2011-05-19  426  	if (pdev->id == BAT)
32890b98308613 Marc Dietrich       2011-05-19  427  		get_bat_mfg_data(power);
32890b98308613 Marc Dietrich       2011-05-19  428  
297d716f6260cc Krzysztof Kozlowski 2015-03-12  429  	*psy = power_supply_register(&pdev->dev, psy_desc, &psy_cfg);
297d716f6260cc Krzysztof Kozlowski 2015-03-12  430  
297d716f6260cc Krzysztof Kozlowski 2015-03-12  431  	return PTR_ERR_OR_ZERO(*psy);
32890b98308613 Marc Dietrich       2011-05-19  432  }
32890b98308613 Marc Dietrich       2011-05-19  433  
f1e870c45be5b6 Uwe Kleine-König    2023-04-03 @434  static void nvec_power_remove(struct platform_device *pdev)
3cdde3a3d55e64 Marc Dietrich       2012-06-24  435  {
3cdde3a3d55e64 Marc Dietrich       2012-06-24  436  	struct nvec_power *power = platform_get_drvdata(pdev);
3cdde3a3d55e64 Marc Dietrich       2012-06-24  437  
3cdde3a3d55e64 Marc Dietrich       2012-06-24  438  	cancel_delayed_work_sync(&power->poller);
c2b62f60f67e03 Marc Dietrich       2013-04-29  439  	nvec_unregister_notifier(power->nvec, &power->notifier);
3cdde3a3d55e64 Marc Dietrich       2012-06-24  440  	switch (pdev->id) {
3cdde3a3d55e64 Marc Dietrich       2012-06-24  441  	case AC:
297d716f6260cc Krzysztof Kozlowski 2015-03-12  442  		power_supply_unregister(nvec_psy);
3cdde3a3d55e64 Marc Dietrich       2012-06-24  443  		break;
3cdde3a3d55e64 Marc Dietrich       2012-06-24  444  	case BAT:
297d716f6260cc Krzysztof Kozlowski 2015-03-12  445  		power_supply_unregister(nvec_bat_psy);
3cdde3a3d55e64 Marc Dietrich       2012-06-24  446  	}
3cdde3a3d55e64 Marc Dietrich       2012-06-24  447  }
3cdde3a3d55e64 Marc Dietrich       2012-06-24  448  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

