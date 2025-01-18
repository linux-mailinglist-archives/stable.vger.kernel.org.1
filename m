Return-Path: <stable+bounces-109418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF9A15ADB
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 02:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493B77A3B20
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 01:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A31EA6F;
	Sat, 18 Jan 2025 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1ngFTRE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31015E8B;
	Sat, 18 Jan 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737163688; cv=none; b=Suj5SVjNZXyqKqpZMVW+pIcSUSWwg/jjMKcl7nTJtZXkj8f9YW7z8HeIXrREU07NHDPXiAjMk/xT6Matq0f7v6QOtz05iYIaBX3EPRtcU8rnuo1TTL4oY2Sp2L84jXqMBwGXzJH80Otl6BS6vnajSlghKMvBxv9ph9/a2TNs2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737163688; c=relaxed/simple;
	bh=NJ7NpbhAPAP57dh4PrVe0Z1KUNmYoad1EwEWmAA1QGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP8x8dZnANFQ38j1BEIQI0t3AuUJh6cCQzfnLC4TnF7SkVmNEZ+WCKvHItVEXBuhdhhput0tz3ZVv6wqJzJoo12iIkUlLEXWHTxAWZLMjmsgsQdvWKIW3HZxiXfP6GhSCfHLxEvSW+7cMlGBCckrNu3SaR18/l+BrZEbtnQ+q3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1ngFTRE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737163687; x=1768699687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NJ7NpbhAPAP57dh4PrVe0Z1KUNmYoad1EwEWmAA1QGM=;
  b=E1ngFTREnAK21xIMveLltFLhFjcp+TuDsF/y70seYYq3ic8yb3sJb1uI
   u73teKR3+yozUaFPGtAyh7kCqWVC9jYJda+lmbG9td/DrCLUxB7PwWKrr
   VcEIfXjDrPounf1SPDFh5O8Yq45HrCoyfMzTQPhbKxj6MlblI+DAj45CO
   ZVN56bRORHTj5IXVypXedSUFoFESt8YeZAHbBwmhczeC7FuCTQVcmbR6U
   a1JbpNWnrKBSHPhh14H7sqxSeWFQuDLmFvLGZTJQqlY/Cqq2nZ5JtDZas
   F/UT2+TwqlQYRPTTgPW9cOz/pdU4h3yKB7p6OOKVfVdM+nnWuc1zWvX9s
   g==;
X-CSE-ConnectionGUID: xVxxKrz1S5elJg+tOQ4YDg==
X-CSE-MsgGUID: LKwWOrpHTZCy+dHSab7CCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="41541170"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="41541170"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 17:26:03 -0800
X-CSE-ConnectionGUID: e0vhducvRNa7lzSB0O0LaA==
X-CSE-MsgGUID: zruhicW+S5yJ1azEwjFxJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110019627"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jan 2025 17:26:02 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYxb4-000Tv7-2d;
	Sat, 18 Jan 2025 01:25:58 +0000
Date: Sat, 18 Jan 2025 09:25:06 +0800
From: kernel test robot <lkp@intel.com>
To: Qiu-ji Chen <chenqiuji666@gmail.com>, nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, greg@kroah.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] cdx: Fix possible UAF error in driver_override_show()
Message-ID: <202501180932.8MILoqSq-lkp@intel.com>
References: <20250115090449.102060-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115090449.102060-1-chenqiuji666@gmail.com>

Hi Qiu-ji,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.13-rc7 next-20250117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qiu-ji-Chen/cdx-Fix-possible-UAF-error-in-driver_override_show/20250115-170808
base:   linus/master
patch link:    https://lore.kernel.org/r/20250115090449.102060-1-chenqiuji666%40gmail.com
patch subject: [PATCH v3] cdx: Fix possible UAF error in driver_override_show()
config: arm64-randconfig-002-20250116 (https://download.01.org/0day-ci/archive/20250118/202501180932.8MILoqSq-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501180932.8MILoqSq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501180932.8MILoqSq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cdx/cdx.c: In function 'driver_override_show':
>> drivers/cdx/cdx.c:473:17: warning: variable 'len' set but not used [-Wunused-but-set-variable]
     473 |         ssize_t len;
         |                 ^~~
>> drivers/cdx/cdx.c:478:1: warning: no return statement in function returning non-void [-Wreturn-type]
     478 | }
         | ^


vim +/len +473 drivers/cdx/cdx.c

   468	
   469	static ssize_t driver_override_show(struct device *dev,
   470					    struct device_attribute *attr, char *buf)
   471	{
   472		struct cdx_device *cdx_dev = to_cdx_device(dev);
 > 473		ssize_t len;
   474	
   475		device_lock(dev);
   476		len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
   477		device_unlock(dev);
 > 478	}
   479	static DEVICE_ATTR_RW(driver_override);
   480	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

