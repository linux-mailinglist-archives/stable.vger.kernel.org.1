Return-Path: <stable+bounces-194888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9D8C61EA2
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 23:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BDEB35A81D
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6F28726D;
	Sun, 16 Nov 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXK6kOpd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427C327B32C;
	Sun, 16 Nov 2025 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763332754; cv=none; b=K+6raDiTLPVGJLuCXtEC5KNbDxnZOiI3RF1K1ZBeRTrRl0M+xzlXVEHAwNkUpabvmHD4iPAdV8EFm4X4B/8yfXA1zxUgVZtxyPs73t6BIQ0K+SIRqyZjOoqNH1ArLBnthPJTfFDVVOSfqeCl2qwy7gxuDL1WsYjn0ohTQD/RJCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763332754; c=relaxed/simple;
	bh=02EvVrOPvHK3ycSr4xdL6Ct7ZgclQPlSgosQiWeSxpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TznNPkcRkFv/Kan4sz5Q2AIyMbdLU8Y6eIJSX6nBQWjxqTacXmkuOFpyDp9aMNRppTsriy1k+uHBieNHUdRNhyH1wTzCwXWtMWdv8T1BqxWnpeUU7iOscNJD0WyKVzDquLdPgjO3k58VHnAHNftFplAICwk+zXv1j0eHaP3NBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXK6kOpd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763332753; x=1794868753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=02EvVrOPvHK3ycSr4xdL6Ct7ZgclQPlSgosQiWeSxpM=;
  b=kXK6kOpdGMSOhcB2BHEcYLBLnsBF+4Tu5F6tI7hNKWFIN17D8jc6HTVr
   TzJGGk0mBn+iUI3BFyCaEZ9Xk9rd9k/0teCzoNDGgS1XV3DACGHA1xEdc
   oewt8zIkrHYcv/0s062PhVvvJMq0CXzXJpJEA66Ibq09AkCfUU6Wq1i/y
   BcAj43G2DBFYCxZfLj58Wria9wR4+HUAFTcKVZPQm54dtVkn+QmYp8pJR
   aQyRd8ty8nxofNTdoxTtZPMAdK0SeAyxcTh6lQl3lZMLFuFXwUUU8ud7v
   nI8gk3JvTbg9DLl0eB0FqZMI5WSaIBoqlL4HU+UHev7tapa4I6/aM2Sal
   w==;
X-CSE-ConnectionGUID: usFHLXE/SiW7cWhLurbEmw==
X-CSE-MsgGUID: sI6cfWwIQLmtN6RtG/lIXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="65270403"
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="65270403"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 14:39:12 -0800
X-CSE-ConnectionGUID: vdRJyfc7RWCVKcuvKEZ6eQ==
X-CSE-MsgGUID: uyuqrEC1RAig1JK2VQ0bPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,310,1754982000"; 
   d="scan'208";a="194618049"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Nov 2025 14:39:08 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKlOk-00097n-1V;
	Sun, 16 Nov 2025 22:39:06 +0000
Date: Mon, 17 Nov 2025 06:38:24 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, vkoul@kernel.org, kishon@kernel.org,
	andriy.shevchenko@linux.intel.com, mchehab+huawei@kernel.org,
	mani@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] phy: HiSilicon: Fix error handling in
 hi3670_pcie_get_resources_from_pcie
Message-ID: <202511170524.sEQYJ4MB-lkp@intel.com>
References: <20251116073231.22676-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116073231.22676-1-make24@iscas.ac.cn>

Hi Ma,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc5 next-20251114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/phy-HiSilicon-Fix-error-handling-in-hi3670_pcie_get_resources_from_pcie/20251116-153458
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20251116073231.22676-1-make24%40iscas.ac.cn
patch subject: [PATCH] phy: HiSilicon: Fix error handling in hi3670_pcie_get_resources_from_pcie
config: m68k-randconfig-r072-20251117 (https://download.01.org/0day-ci/archive/20251117/202511170524.sEQYJ4MB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251117/202511170524.sEQYJ4MB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511170524.sEQYJ4MB-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/phy/hisilicon/phy-hi3670-pcie.c: In function 'hi3670_pcie_get_resources_from_pcie':
>> drivers/phy/hisilicon/phy-hi3670-pcie.c:564:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     564 |  int ret = 0;
         |      ^~~


vim +/ret +564 drivers/phy/hisilicon/phy-hi3670-pcie.c

   558	
   559	static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
   560	{
   561		struct device_node *pcie_port;
   562		struct device *dev = phy->dev;
   563		struct device *pcie_dev = NULL;
 > 564		int ret = 0;
   565	
   566		pcie_port = of_get_child_by_name(dev->parent->of_node, "pcie");
   567		if (!pcie_port) {
   568			dev_err(dev, "no pcie node found in %s\n",
   569				dev->parent->of_node->full_name);
   570			return -ENODEV;
   571		}
   572	
   573		pcie_dev = bus_find_device_by_of_node(&platform_bus_type, pcie_port);
   574		if (!pcie_dev) {
   575			dev_err(dev, "Didn't find pcie device\n");
   576			ret = -ENODEV;
   577			goto out_put_node;
   578		}
   579	
   580		/*
   581		 * We might just use NULL instead of the APB name, as the
   582		 * pcie-kirin currently registers directly just one regmap (although
   583		 * the DWC driver register other regmaps).
   584		 *
   585		 * Yet, it sounds safer to warrant that it will be accessing the
   586		 * right regmap. So, let's use the named version.
   587		 */
   588		phy->apb = dev_get_regmap(pcie_dev, "kirin_pcie_apb");
   589		if (!phy->apb) {
   590			dev_err(dev, "Failed to get APB regmap\n");
   591			ret = -ENODEV;
   592			goto out_put_device;
   593		}
   594	
   595	out_put_device:
   596		put_device(pcie_dev);
   597	out_put_node:
   598		of_node_put(pcie_port);
   599		return 0;
   600	}
   601	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

