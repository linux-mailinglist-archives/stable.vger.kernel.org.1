Return-Path: <stable+bounces-134507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B626AA92E4E
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 01:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAE6172227
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176C82222DE;
	Thu, 17 Apr 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TkXKTDtu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144432222B5;
	Thu, 17 Apr 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932269; cv=none; b=afRhwuAGr2xwAeWEq5fttZ8MXaNSptXneW6/RoRd+Ub8WIaWyxQL118Y6M1HPoBW9CCYk9Y7gPHr4wVcEr9HpEz+RgxSiYvjiFBSrCj9o2qy/suJBRg4cf0Dmm7X2JTToCs5KUx84UaHyEjcvPcmFoEItXe8JkMoaPl4C9YCkJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932269; c=relaxed/simple;
	bh=XSxVGP9hXVpNkJP08GtFCM1fYw8yyPnJUvg/EHoHTiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIInMTbM7XqaS822Uf39Fy6uumqFvf9jmYiSRbdf57VE7XkJYvpsOLVY4x+y0Yq43+m/z0o4e0NBwck3zSsXYX6p2J/rcOM3im6HWoTvzH/bRdqGGLYaH0tn4AI0BQEXSn3jMyuiCQaAD9y/Za/W86AH5F0wLJmKYV3d5v1yJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TkXKTDtu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744932268; x=1776468268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XSxVGP9hXVpNkJP08GtFCM1fYw8yyPnJUvg/EHoHTiU=;
  b=TkXKTDtul+goa+jfl/jnoeUxyqqhyWK0rMPLzdiadOtutizAdSnLMnSh
   ZdaDDVfAzBFJ0qDY5l8X1KbMr8bWckXbVqHOFuXNafFYz5laZrzeObuGu
   yvrctyDi0IcEepj001Q97T4ERGJGbJxCNFzt6l5wFI4t1gdu1k06WpRzV
   6R2lDEMwSczsDoSam6sczbmjYzXYMuN7MSgN4MTI7V1FfYIkZUpPIq8Im
   Tedg2RkRRmukEE1Nm7drwX3p1sy/MvLXLzLZzrCkup0K99vCOKkEJV1Zo
   kO/93oal0nPGyc8dLjF/lcXhW7Qnme5STiVjWmSaUhBRKtrCOquu7Zmj/
   g==;
X-CSE-ConnectionGUID: w1t9/T2+QAi1F+u8r8Zsng==
X-CSE-MsgGUID: tKaxy5BzQCi8vVx+0mvBWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57201286"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="57201286"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 16:24:27 -0700
X-CSE-ConnectionGUID: VVnFoNmLSI+U+iizbdNHgg==
X-CSE-MsgGUID: e9noRkXTQo+bCoQEGNHJkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="161920270"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 17 Apr 2025 16:24:23 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u5Yaj-00029N-1p;
	Thu, 17 Apr 2025 23:24:21 +0000
Date: Fri, 18 Apr 2025 07:24:20 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v3 2/2] x86/devmem: Drop /dev/mem access for confidential
 guests
Message-ID: <202504180754.vQCz7zWh-lkp@intel.com>
References: <174491712829.1395340.5054725417641299524.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174491712829.1395340.5054725417641299524.stgit@dwillia2-xfh.jf.intel.com>

Hi Dan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0af2f6be1b4281385b618cb86ad946eded089ac8]

url:    https://github.com/intel-lab-lkp/linux/commits/Dan-Williams/x86-devmem-Remove-duplicate-range_is_allowed-definition/20250418-031657
base:   0af2f6be1b4281385b618cb86ad946eded089ac8
patch link:    https://lore.kernel.org/r/174491712829.1395340.5054725417641299524.stgit%40dwillia2-xfh.jf.intel.com
patch subject: [PATCH v3 2/2] x86/devmem: Drop /dev/mem access for confidential guests
config: arm-randconfig-004-20250418 (https://download.01.org/0day-ci/archive/20250418/202504180754.vQCz7zWh-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250418/202504180754.vQCz7zWh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504180754.vQCz7zWh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/char/mem.c:604:6: error: call to undeclared function 'cc_platform_has'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     604 |             cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
         |             ^
>> drivers/char/mem.c:604:22: error: use of undeclared identifier 'CC_ATTR_GUEST_MEM_ENCRYPT'
     604 |             cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
         |                             ^
   2 errors generated.


vim +/cc_platform_has +604 drivers/char/mem.c

   586	
   587	static int open_port(struct inode *inode, struct file *filp)
   588	{
   589		int rc;
   590	
   591		if (!capable(CAP_SYS_RAWIO))
   592			return -EPERM;
   593	
   594		rc = security_locked_down(LOCKDOWN_DEV_MEM);
   595		if (rc)
   596			return rc;
   597	
   598		/*
   599		 * Enforce encrypted mapping consistency and avoid unaccepted
   600		 * memory conflicts, "lockdown" /dev/mem for confidential
   601		 * guests.
   602		 */
   603		if (IS_ENABLED(CONFIG_STRICT_DEVMEM) &&
 > 604		    cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
   605			return -EPERM;
   606	
   607		if (iminor(inode) != DEVMEM_MINOR)
   608			return 0;
   609	
   610		/*
   611		 * Use a unified address space to have a single point to manage
   612		 * revocations when drivers want to take over a /dev/mem mapped
   613		 * range.
   614		 */
   615		filp->f_mapping = iomem_get_mapping();
   616	
   617		return 0;
   618	}
   619	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

