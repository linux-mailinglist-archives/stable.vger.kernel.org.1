Return-Path: <stable+bounces-109416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D084DA15A3C
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 01:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E5B18877AB
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 00:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FD64D;
	Sat, 18 Jan 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSnJFEnP"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B702195;
	Sat, 18 Jan 2025 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737158998; cv=none; b=oNztOj9HuTm76sbNSc4Ud++KAvg/fktp7F6eC3kOhnwintDWWqrXT/f39Zf6KrZY8Zy4jCMPv3en4TfJCiUTDJNbKDNQCpbn7QGvhX7rSi8g5jqoPcbkkPUT4/JxnwmTbw1YPRc+0JD+Z4vo6IpfTBvziOBdvaH9MvldfhUyVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737158998; c=relaxed/simple;
	bh=fWb6fS0xl2IfrGBjsnDoAvlLsvH6sWapTEfnkNR0tH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlGJwLdsNsmlbUahLZNPhZIJOr1eSlhrvrG3siPC8lHQVhjRVQuXJuYhfd23BB2eRI7nHZiX0VW0AdEfSYp1jZsfRsN3i2IcjUAK5r2FPNukfzfFox4Dym15IaQXBP4CvOCMia6fnKUSnO1jld96D+639d1m1taF+Sxku3xqHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSnJFEnP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737158996; x=1768694996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fWb6fS0xl2IfrGBjsnDoAvlLsvH6sWapTEfnkNR0tH0=;
  b=TSnJFEnPHbH6QIqixyCtKCeHu7f7PdO5a4yqG9XxPyFSP5HiBf3sxF+U
   ul2ZwGFDhc6XNhB0+Pgfg2kXXgI1YiL5Pz7COvKLeiO6D5LIFmnhz8Z6E
   zTuAGsFbrbvi7uwvQF0B6oPOyHi/ik4LuccxhVY2cOcc9K33krmIsLsqW
   x1d33bumSzVSDAtLpCJB0OXWTXPUb2B1jECy0hGrVGY2Qsae5ZZKyYl3G
   ct9NahIkL+n9a9GLOPuWM6nlZtrMfJv1y7LBUNUqFSEMNk/AKa05oxM1z
   48tKWO9leltvX8o0oIvpcMdIpB0kxd7PXhAQeimAc88W14lnXTxspI58g
   A==;
X-CSE-ConnectionGUID: MMoOPOROQ6m27SAsEyE1zQ==
X-CSE-MsgGUID: c/T39tgKS0iy5KaeWYbm2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="36882007"
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="36882007"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 16:09:55 -0800
X-CSE-ConnectionGUID: I/M0CykhTxm0sKMYmbolmw==
X-CSE-MsgGUID: OZWBn/3/Q+GbJFbL/Xp87g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,213,1732608000"; 
   d="scan'208";a="105977308"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Jan 2025 16:09:53 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYwPO-000Ts3-28;
	Sat, 18 Jan 2025 00:09:50 +0000
Date: Sat, 18 Jan 2025 08:09:08 +0800
From: kernel test robot <lkp@intel.com>
To: Qiu-ji Chen <chenqiuji666@gmail.com>, nipun.gupta@amd.com,
	nikhil.agarwal@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	greg@kroah.com, Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] cdx: Fix possible UAF error in driver_override_show()
Message-ID: <202501180719.sDmtGnhD-lkp@intel.com>
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
config: arm64-randconfig-004-20250116 (https://download.01.org/0day-ci/archive/20250118/202501180719.sDmtGnhD-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f5cd181ffbb7cb61d582fe130d46580d5969d47a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250118/202501180719.sDmtGnhD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501180719.sDmtGnhD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cdx/cdx.c:473:10: warning: variable 'len' set but not used [-Wunused-but-set-variable]
     473 |         ssize_t len;
         |                 ^
>> drivers/cdx/cdx.c:478:1: warning: non-void function does not return a value [-Wreturn-type]
     478 | }
         | ^
   2 warnings generated.


vim +478 drivers/cdx/cdx.c

48a6c7bced2a78 Nipun Gupta 2023-03-13  468  
48a6c7bced2a78 Nipun Gupta 2023-03-13  469  static ssize_t driver_override_show(struct device *dev,
48a6c7bced2a78 Nipun Gupta 2023-03-13  470  				    struct device_attribute *attr, char *buf)
48a6c7bced2a78 Nipun Gupta 2023-03-13  471  {
48a6c7bced2a78 Nipun Gupta 2023-03-13  472  	struct cdx_device *cdx_dev = to_cdx_device(dev);
4228bb0224f83f Qiu-ji Chen 2025-01-15  473  	ssize_t len;
48a6c7bced2a78 Nipun Gupta 2023-03-13  474  
4228bb0224f83f Qiu-ji Chen 2025-01-15  475  	device_lock(dev);
4228bb0224f83f Qiu-ji Chen 2025-01-15  476  	len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
4228bb0224f83f Qiu-ji Chen 2025-01-15  477  	device_unlock(dev);
48a6c7bced2a78 Nipun Gupta 2023-03-13 @478  }
48a6c7bced2a78 Nipun Gupta 2023-03-13  479  static DEVICE_ATTR_RW(driver_override);
48a6c7bced2a78 Nipun Gupta 2023-03-13  480  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

