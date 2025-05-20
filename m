Return-Path: <stable+bounces-144987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F24ABCBEB
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 02:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E507A8D2F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682EE1C1F22;
	Tue, 20 May 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NASBEsxb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A801B042C;
	Tue, 20 May 2025 00:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699831; cv=none; b=QxdxdX6/9wncWYMbe0uZZ9bK0+wDQNCSkAjt4UlBA5WBbZHxXedT5hLU/mPzdo25HdvXRSYgAuSwG5J8RVBcnWWCe2QnGzBostiAVKXFAyXvDOxexX0/A1GE1rjI7hRm515p6QcEdGKtkRFtOJ4XD5DFB9tYM3zR6V3qnvNul3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699831; c=relaxed/simple;
	bh=fpW1z6JAwhT/LbCvwhlOwFt1f2dC69euiK/l3k6G1VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAwXoo998dkoaS5VFSKpJe0hi3zifLCkvqC934p9Ap03MJwwF80TSu9CFpu/TcPiyOOwbp6nbAAPGEC3MZYV6+HQf1/tcpl9ATCBQ1mtZSzVqfzuHewifwShvC7l98kyMT+5ZhoxYvEP9pkd9XSREWjztR5nkt4AxqsDHjS+324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NASBEsxb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747699828; x=1779235828;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fpW1z6JAwhT/LbCvwhlOwFt1f2dC69euiK/l3k6G1VE=;
  b=NASBEsxbYEI6wy4mfvS7Ciwq8qEC6zrL/hMnRwwfwedy3VsctmA+u34D
   xy55ayb0pi5RIjsQHR6vkICnSLzux0KldByBBQsXEADqvMgYv/Nhuc2q1
   iQ/Wl9JQNfrWfzEAnFo2YzZIcCuftnhYpBS0zKHrHPOz5kT4OE37QWYZx
   MX773lIKiRhAGgry4zM6ktxjy7Q+ih60R7CPiVlIFAAeoYiDOyuxiPmfv
   5MwamvyQekf5IR8S6+IcgiIBbN5FLrWzZbr1Rc0XsRhm8vxzk1t2iNO4K
   IYOl5zT2zssLJGv5B/0VzHN1QqMsYilAN6RZJ+sKHnSiBJQUG4/dyHGEl
   A==;
X-CSE-ConnectionGUID: 5TZX00j4Qd+E+V+vip8e6w==
X-CSE-MsgGUID: GvzoYnDORhqcGlH398XCKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="61008770"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="61008770"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:10:27 -0700
X-CSE-ConnectionGUID: xb/wyjMtTACFqV1nNAi5Hw==
X-CSE-MsgGUID: KuZYUgR7Rx+HLRDNJFgMHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139425255"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 May 2025 17:10:25 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHAYp-000M0a-1M;
	Tue, 20 May 2025 00:10:23 +0000
Date: Tue, 20 May 2025 08:09:24 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, adrian.hunter@intel.com,
	vigneshr@ti.com, ulf.hansson@linaro.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci-omap: Add error handling for
 sdhci_runtime_suspend_host()
Message-ID: <202505200727.1k4LfYCQ-lkp@intel.com>
References: <20250519125143.2331-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519125143.2331-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.15-rc7 next-20250516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/mmc-sdhci-omap-Add-error-handling-for-sdhci_runtime_suspend_host/20250519-205341
base:   linus/master
patch link:    https://lore.kernel.org/r/20250519125143.2331-1-vulab%40iscas.ac.cn
patch subject: [PATCH] mmc: sdhci-omap: Add error handling for sdhci_runtime_suspend_host()
config: sparc-randconfig-001-20250520 (https://download.01.org/0day-ci/archive/20250520/202505200727.1k4LfYCQ-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250520/202505200727.1k4LfYCQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505200727.1k4LfYCQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-omap.c: In function 'sdhci_omap_runtime_suspend':
>> drivers/mmc/host/sdhci-omap.c:1449:6: error: void value not ignored as it ought to be
     ret = sdhci_omap_context_save(omap_host);
         ^


vim +1449 drivers/mmc/host/sdhci-omap.c

  1435	
  1436	static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
  1437	{
  1438		struct sdhci_host *host = dev_get_drvdata(dev);
  1439		struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
  1440		struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
  1441		int ret;
  1442	
  1443		if (host->tuning_mode != SDHCI_TUNING_MODE_3)
  1444			mmc_retune_needed(host->mmc);
  1445	
  1446		if (omap_host->con != -EINVAL)
  1447			sdhci_runtime_suspend_host(host);
  1448	
> 1449		ret = sdhci_omap_context_save(omap_host);
  1450		if (ret)
  1451			return ret;
  1452	
  1453		pinctrl_pm_select_idle_state(dev);
  1454	
  1455		return 0;
  1456	}
  1457	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

