Return-Path: <stable+bounces-89904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB149BD33E
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F06128145C
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EDA1E04BD;
	Tue,  5 Nov 2024 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOvjE3kJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6940414A09A;
	Tue,  5 Nov 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730827316; cv=none; b=ovD2EfZQtiFb0KgysjZf2cEMHgjFdxjseMfg+KQbboLHc3l7FWG3Vmkxl2zJuoGCW1kGugHVFsBBMZmLkSl+rF0z1cmq7BAxxQ6RbSzU6vQ7a78cAkMa/J3zar+8RkA04BrmlSg/ANc6qVp9W9eZtKMetF0DefSLm5habonOBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730827316; c=relaxed/simple;
	bh=rOY59W2R/svFpNaHoVjE2EshezTg7g1VzmcV3p0Fjto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vv8e2CAMnYopqt29Y93GB8r3cOl7b8kkd53nD5ipHE5nWyMwMGPy+X+ajvFwS0q4w6RgigMBhn2UrjdRWuYwZnv1bKvTNtjdvt/bBeuf8XVST97n0x7qY6qMXloY+/nUkBZLGQPmhpCcYBi/tin8nCbhufUkeGQCTK2NI+7Ajkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOvjE3kJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730827314; x=1762363314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rOY59W2R/svFpNaHoVjE2EshezTg7g1VzmcV3p0Fjto=;
  b=gOvjE3kJ7a8ia/t3k4Fg2mqYREtDOWjRlmjAEy5bM/7kqbaVRz337PBS
   8m9Svtmfqh/UBj9jmKxRuJ5rPOP6/2kfLwLz7UlOfhot7fbST2YDvpBwu
   8kkKsCEcIR0Z5Rb9yo4vxRugO+nKuBtqD8EKVqvpxMcXehKODhmDIKliW
   hMuNneFO1GGOHycfW8waB2Ym6wMemErdkPNicRCNzWC8Bp43yHIYtJlhA
   R6tJVxYEf+uacS87UvWCrTCmgIetBpaOj2H4vZIczNaxMqnmXff6J6L6Z
   4Pw6i8FsCD5e+i/gJ9+YNbldarw5bwZuWMGiw4NynGRLfSeiVg+ODnED9
   w==;
X-CSE-ConnectionGUID: SHryP5mDQy6Q+n6HltDtUw==
X-CSE-MsgGUID: CdXx2pgfTh6Dl4CZrLc8Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="34374971"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="34374971"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 09:21:42 -0800
X-CSE-ConnectionGUID: l9pNMaMnSd2DO0y9u/S/3g==
X-CSE-MsgGUID: tT/yi6oaR7OpOV+EOGw3mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="84487946"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Nov 2024 09:21:40 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8NFJ-000mHx-1j;
	Tue, 05 Nov 2024 17:21:37 +0000
Date: Wed, 6 Nov 2024 01:20:52 +0800
From: kernel test robot <lkp@intel.com>
To: Calvin Owens <calvin@wbinvd.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, Rodolfo Giometti <giometti@enneenne.com>,
	George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] pps: Fix a use-after-free
Message-ID: <202411060043.hC5KjYAw-lkp@intel.com>
References: <abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin@wbinvd.org>

Hi Calvin,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc6 next-20241105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Calvin-Owens/pps-Fix-a-use-after-free/20241105-155819
base:   linus/master
patch link:    https://lore.kernel.org/r/abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin%40wbinvd.org
patch subject: [PATCH v3] pps: Fix a use-after-free
config: i386-buildonly-randconfig-004-20241105 (https://download.01.org/0day-ci/archive/20241106/202411060043.hC5KjYAw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060043.hC5KjYAw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060043.hC5KjYAw-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ptp/ptp_ocp.c: In function 'ptp_ocp_complete':
>> drivers/ptp/ptp_ocp.c:4423:40: error: incompatible type for argument 2 of 'ptp_ocp_symlink'
    4423 |                 ptp_ocp_symlink(bp, pps->dev, "pps");
         |                                     ~~~^~~~~
         |                                        |
         |                                        struct device
   drivers/ptp/ptp_ocp.c:4387:52: note: expected 'struct device *' but argument is of type 'struct device'
    4387 | ptp_ocp_symlink(struct ptp_ocp *bp, struct device *child, const char *link)
         |                                     ~~~~~~~~~~~~~~~^~~~~


vim +/ptp_ocp_symlink +4423 drivers/ptp/ptp_ocp.c

773bda96492153 Jonathan Lemon  2021-08-03  4411  
773bda96492153 Jonathan Lemon  2021-08-03  4412  static int
773bda96492153 Jonathan Lemon  2021-08-03  4413  ptp_ocp_complete(struct ptp_ocp *bp)
773bda96492153 Jonathan Lemon  2021-08-03  4414  {
773bda96492153 Jonathan Lemon  2021-08-03  4415  	struct pps_device *pps;
773bda96492153 Jonathan Lemon  2021-08-03  4416  	char buf[32];
d7875b4b078f7e Vadim Fedorenko 2024-08-29  4417  
773bda96492153 Jonathan Lemon  2021-08-03  4418  	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
773bda96492153 Jonathan Lemon  2021-08-03  4419  	ptp_ocp_link_child(bp, buf, "ptp");
773bda96492153 Jonathan Lemon  2021-08-03  4420  
773bda96492153 Jonathan Lemon  2021-08-03  4421  	pps = pps_lookup_dev(bp->ptp);
773bda96492153 Jonathan Lemon  2021-08-03  4422  	if (pps)
773bda96492153 Jonathan Lemon  2021-08-03 @4423  		ptp_ocp_symlink(bp, pps->dev, "pps");
773bda96492153 Jonathan Lemon  2021-08-03  4424  
f67bf662d2cffa Jonathan Lemon  2021-09-14  4425  	ptp_ocp_debugfs_add_device(bp);
f67bf662d2cffa Jonathan Lemon  2021-09-14  4426  
773bda96492153 Jonathan Lemon  2021-08-03  4427  	return 0;
773bda96492153 Jonathan Lemon  2021-08-03  4428  }
773bda96492153 Jonathan Lemon  2021-08-03  4429  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

