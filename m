Return-Path: <stable+bounces-194504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D5DC4EBF7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583A71887D4C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C94335F8AC;
	Tue, 11 Nov 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kLcy8r3h"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575C33F8A4;
	Tue, 11 Nov 2025 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873911; cv=none; b=bpLGBrR+cFdmwATmL+Y8ej9Midmi8dL68cPprOdDnx1Nie0R+d0/Pt9Nmx+eq2dhSit4uIpwCJYEmUkgImghV4p6aWbj1dNE34jat4/JOTOMZtkfFo1t2HYMbNSq8Q7mt1++c1RrYxzxI/OYlJEVBS6TBOGulWj/Go8zjE7gYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873911; c=relaxed/simple;
	bh=ERMwIjPZPLyZ1m6vgFXRkTyy9Qrz1TNQE6MnkYJAz+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtoDXOzX6JCJjQSKmuOffJWc/KPb+br2OZ/PCf16Kl/gRcf8vF32kiG9ijCrDQWD0eiFSy9ZzbrxUVHxVwsRlW2828QmXDEudLSF4t1ZJDIJ0nEXSWRLvmcDjqkw6YAlUZ0/aXE37ijcQ7Bvd7GEst9i7pVB9iV0MIuxe5LzfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kLcy8r3h; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762873910; x=1794409910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ERMwIjPZPLyZ1m6vgFXRkTyy9Qrz1TNQE6MnkYJAz+k=;
  b=kLcy8r3hdiOC9QBIDTicvxEX2Rd8U9cdhMwsMXAUJwP5Dm7Bx+my8Uig
   1ZriZruSr+wd5N2wq7Hbp44++tojLlA1UUc9xDRNoVuTp8gOpuRiMRoSN
   S7exXVzVhvGLYNAuSpHRFbfqAlviisgjRZBDf9nV/n3HNVo/8WpriwAm0
   xRKufcLY3zRS6W3TMu+peDFaAgX4mM1xQsbXGedDzyl5UxepB8XDu/WoP
   9Sho36oRwUrQSVti0kbvjX8yHRFJRvvZoUvYPF1wUqilps6ckLKrf28s8
   O+NQy3VsAsPCFnd3EcooJbQaSEILbzXo7Y4ffm+mAQepDY+bKwpUQlBG5
   g==;
X-CSE-ConnectionGUID: sHkUsP+aSra+1JkKLacnFg==
X-CSE-MsgGUID: yi6nsrj5R2iOTsBh+Hx68Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64853652"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64853652"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 07:11:49 -0800
X-CSE-ConnectionGUID: Tg9WnHf0Q0eG8nSHQzPs6g==
X-CSE-MsgGUID: cx04bFEkTZy6uGjWzuertg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="212377532"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 11 Nov 2025 07:11:47 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIq24-0003H1-2H;
	Tue, 11 Nov 2025 15:11:44 +0000
Date: Tue, 11 Nov 2025 23:10:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, alexander.shishkin@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] intel_th: Fix error handling in intel_th_output_open
Message-ID: <202511112222.vMmKmHbd-lkp@intel.com>
References: <20251111024204.12299-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111024204.12299-1-make24@iscas.ac.cn>

Hi Ma,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc5 next-20251111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/intel_th-Fix-error-handling-in-intel_th_output_open/20251111-104412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251111024204.12299-1-make24%40iscas.ac.cn
patch subject: [PATCH] intel_th: Fix error handling in intel_th_output_open
config: x86_64-buildonly-randconfig-002-20251111 (https://download.01.org/0day-ci/archive/20251111/202511112222.vMmKmHbd-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511112222.vMmKmHbd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511112222.vMmKmHbd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hwtracing/intel_th/core.c:818:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     818 |         if (!fops)
         |             ^~~~~
   drivers/hwtracing/intel_th/core.c:836:9: note: uninitialized use occurs here
     836 |         return err;
         |                ^~~
   drivers/hwtracing/intel_th/core.c:818:2: note: remove the 'if' if its condition is always false
     818 |         if (!fops)
         |         ^~~~~~~~~~
     819 |                 goto out_put_device;
         |                 ~~~~~~~~~~~~~~~~~~~
   drivers/hwtracing/intel_th/core.c:813:6: warning: variable 'err' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     813 |         if (!dev || !dev->driver)
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/hwtracing/intel_th/core.c:836:9: note: uninitialized use occurs here
     836 |         return err;
         |                ^~~
   drivers/hwtracing/intel_th/core.c:813:2: note: remove the 'if' if its condition is always false
     813 |         if (!dev || !dev->driver)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
     814 |                 goto out_no_device;
         |                 ~~~~~~~~~~~~~~~~~~
>> drivers/hwtracing/intel_th/core.c:813:6: warning: variable 'err' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
     813 |         if (!dev || !dev->driver)
         |             ^~~~
   drivers/hwtracing/intel_th/core.c:836:9: note: uninitialized use occurs here
     836 |         return err;
         |                ^~~
   drivers/hwtracing/intel_th/core.c:813:6: note: remove the '||' if its condition is always false
     813 |         if (!dev || !dev->driver)
         |             ^~~~~~~
   drivers/hwtracing/intel_th/core.c:810:9: note: initialize the variable 'err' to silence this warning
     810 |         int err;
         |                ^
         |                 = 0
   3 warnings generated.


vim +818 drivers/hwtracing/intel_th/core.c

39f4034693b7c7 Alexander Shishkin 2015-09-22  804  
39f4034693b7c7 Alexander Shishkin 2015-09-22  805  static int intel_th_output_open(struct inode *inode, struct file *file)
39f4034693b7c7 Alexander Shishkin 2015-09-22  806  {
39f4034693b7c7 Alexander Shishkin 2015-09-22  807  	const struct file_operations *fops;
39f4034693b7c7 Alexander Shishkin 2015-09-22  808  	struct intel_th_driver *thdrv;
39f4034693b7c7 Alexander Shishkin 2015-09-22  809  	struct device *dev;
39f4034693b7c7 Alexander Shishkin 2015-09-22  810  	int err;
39f4034693b7c7 Alexander Shishkin 2015-09-22  811  
4495dfdd6193d9 Suzuki K Poulose   2019-07-23  812  	dev = bus_find_device_by_devt(&intel_th_bus, inode->i_rdev);
39f4034693b7c7 Alexander Shishkin 2015-09-22 @813  	if (!dev || !dev->driver)
b54f5a424fbe0f Ma Ke              2025-11-11  814  		goto out_no_device;
39f4034693b7c7 Alexander Shishkin 2015-09-22  815  
39f4034693b7c7 Alexander Shishkin 2015-09-22  816  	thdrv = to_intel_th_driver(dev->driver);
39f4034693b7c7 Alexander Shishkin 2015-09-22  817  	fops = fops_get(thdrv->fops);
39f4034693b7c7 Alexander Shishkin 2015-09-22 @818  	if (!fops)
b54f5a424fbe0f Ma Ke              2025-11-11  819  		goto out_put_device;
39f4034693b7c7 Alexander Shishkin 2015-09-22  820  
39f4034693b7c7 Alexander Shishkin 2015-09-22  821  	replace_fops(file, fops);
39f4034693b7c7 Alexander Shishkin 2015-09-22  822  
39f4034693b7c7 Alexander Shishkin 2015-09-22  823  	file->private_data = to_intel_th_device(dev);
39f4034693b7c7 Alexander Shishkin 2015-09-22  824  
39f4034693b7c7 Alexander Shishkin 2015-09-22  825  	if (file->f_op->open) {
39f4034693b7c7 Alexander Shishkin 2015-09-22  826  		err = file->f_op->open(inode, file);
b54f5a424fbe0f Ma Ke              2025-11-11  827  		if (err)
b54f5a424fbe0f Ma Ke              2025-11-11  828  			goto out_put_device;
39f4034693b7c7 Alexander Shishkin 2015-09-22  829  	}
39f4034693b7c7 Alexander Shishkin 2015-09-22  830  
39f4034693b7c7 Alexander Shishkin 2015-09-22  831  	return 0;
b54f5a424fbe0f Ma Ke              2025-11-11  832  
b54f5a424fbe0f Ma Ke              2025-11-11  833  out_put_device:
b54f5a424fbe0f Ma Ke              2025-11-11  834  	put_device(dev);
b54f5a424fbe0f Ma Ke              2025-11-11  835  out_no_device:
b54f5a424fbe0f Ma Ke              2025-11-11 @836  	return err;
39f4034693b7c7 Alexander Shishkin 2015-09-22  837  }
39f4034693b7c7 Alexander Shishkin 2015-09-22  838  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

