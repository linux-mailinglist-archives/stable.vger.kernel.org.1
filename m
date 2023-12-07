Return-Path: <stable+bounces-4935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2A9808C10
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 16:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A864281485
	for <lists+stable@lfdr.de>; Thu,  7 Dec 2023 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5CE44C9E;
	Thu,  7 Dec 2023 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btEsKlcj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA0310CA;
	Thu,  7 Dec 2023 07:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701963634; x=1733499634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TRQrcR82gGZ4bilKmvDQp3/BMwMwwJ+qVGy8M9ph6/E=;
  b=btEsKlcj26vYmtsfZKYndZz0lSA8Cd/hgmpzT0edfW8AO13mAHiw+tvK
   W3gdWMFZw+FaRzqDKSugL0M6VC+NINjpl82ppV+xAT6ILsjVFMKXgqBxN
   7G2u44io82pWUvqPozyaYRIatkp6DQQX5nzD6n4NlbAPjU6YuQ+AlRPE3
   oVKDgKTgQnXv/SwRE63sZxBPZVT/yO8vVnoxPZDUOo78AeJMvTwF9gqcy
   /Psz6czL/VdNHDz7+Kj31Vb86AlH0qVH7IlYMWlHNFY2AcNI7aaIQe+Fq
   lK8uMzYLdTK7l4Kcolg3QGVmkrAzSyGfTUrosLVMeqYo3dtUN/pV+D+7+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="393121337"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="393121337"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 07:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="771770862"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="771770862"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2023 07:40:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBGUH-000CQw-1t;
	Thu, 07 Dec 2023 15:40:29 +0000
Date: Thu, 7 Dec 2023 23:40:22 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/hdm: Fix dpa translation locking
Message-ID: <202312072350.QQTkSsY7-lkp@intel.com>
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
config: i386-buildonly-randconfig-003-20231207 (https://download.01.org/0day-ci/archive/20231207/202312072350.QQTkSsY7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312072350.QQTkSsY7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312072350.QQTkSsY7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cxl/core/port.c: In function 'dpa_resource_show':
>> drivers/cxl/core/port.c:231:37: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     231 |         return sysfs_emit(buf, "%#llx\n", cxl_dpa_resource_start(cxled));
         |                                 ~~~~^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                     |     |
         |                                     |     resource_size_t {aka unsigned int}
         |                                     long long unsigned int
         |                                 %#x


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

