Return-Path: <stable+bounces-4940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D95808CF6
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 17:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FEF7B21064
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 16:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D48746B94;
	Thu,  7 Dec 2023 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BdawM9b3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1AA10FF;
	Thu,  7 Dec 2023 08:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701965685; x=1733501685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p1g4KkA0JbfZhaiHdJWzaUcY/5IFDKB88xgppTOzQ6s=;
  b=BdawM9b3V+uzVZP6wlb26V6F9hTsU8jHERFgFUZaDwcxy9SUV5j93xGt
   EUSSRQ6akFXGXIJKBfhWh73fN/yNsv8fIQKOcSRYzWkT9CosI3Q80fuR5
   zhBk6YtfgeWdy4lsIEGkHUBXGA5yHxq4kawchdpJ6FLJeBnKf9UXNhy6z
   0XmGueR/veIFF+8EmSdUUFBzOuuAasIUEU7O5deIx/bkS0b7PviQMYMca
   xzm8Wnl3QlhDCsMXVqROL3ueb6N/i17aj8XpsAmqJEdSRYZBC3xrpamKF
   POlpeRygJXzjPV6QF/tSx5ztoCRwBvMu6h4N3S26YeWPzk6N5kdlRo+s3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1083991"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1083991"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 08:14:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889797110"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="889797110"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2023 08:14:34 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBH1E-000CTW-1F;
	Thu, 07 Dec 2023 16:14:32 +0000
Date: Fri, 8 Dec 2023 00:13:51 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	stable@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/hdm: Fix dpa translation locking
Message-ID: <202312080021.eQEtUpnB-lkp@intel.com>
References: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170192142664.461900.3169528633970716889.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc4 next-20231207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/cxl-hdm-Fix-dpa-translation-locking/20231207-115958
base:   linus/master
patch link:    https://lore.kernel.org/r/170192142664.461900.3169528633970716889.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH] cxl/hdm: Fix dpa translation locking
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20231208/202312080021.eQEtUpnB-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080021.eQEtUpnB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080021.eQEtUpnB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/port.c:231:36: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
           return sysfs_emit(buf, "%#llx\n", cxl_dpa_resource_start(cxled));
                                   ~~~~~     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                                   %#x
   1 warning generated.


vim +231 drivers/cxl/core/port.c

   224	
   225	static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
   226				    char *buf)
   227	{
   228		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
   229	
   230		guard(rwsem_read)(&cxl_dpa_rwsem);
 > 231		return sysfs_emit(buf, "%#llx\n", cxl_dpa_resource_start(cxled));
   232	}
   233	static DEVICE_ATTR_RO(dpa_resource);
   234	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

