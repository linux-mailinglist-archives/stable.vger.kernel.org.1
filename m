Return-Path: <stable+bounces-134503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4DEA92D43
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 00:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323E74A2BBE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24692192E3;
	Thu, 17 Apr 2025 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoNSTZ8H"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE42153DA;
	Thu, 17 Apr 2025 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929085; cv=none; b=shjZyCmW79dP0kSQJ7dLcXuUWhvKuq+ZGZGQSMme9Te1+1TP4B8RYNFHdMiIMkq5Ao86PR53GJAQ2oe2aKFsuAdfO8+n/NTkK/WInwPz0C8WL/jXzAXm3Zn9xfZUXOtWc55pGY5ovCCBVPqNr3LAVUf/DMs3zCEzpfN0ApfKdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929085; c=relaxed/simple;
	bh=vn1J2xsoHaKRRR5gEBvbJFfe7rTGH95sSYVPpYSFX1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAL3XVq+MsckAZ/sl041vajjZrD/uzj3gKH3p10JhwgWivG91hX2lP66APV0S+Kd5B1FqedRjdL3sZ7UoOpMZT3yLK4oNjl2hy97QAtG/UDuac/MAlM9XqDuvtllS++GQfWINBwqjHjTvysG8HjAxEb2ZeU6H8PIZXA/IlEqO+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoNSTZ8H; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744929084; x=1776465084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vn1J2xsoHaKRRR5gEBvbJFfe7rTGH95sSYVPpYSFX1w=;
  b=DoNSTZ8HOV1rTO83zIRkcKa6DgIEJZ8aIoXAy4xU42srYXCsAtRNPaoI
   yXhVFQWd7atElrlvoIqh93NY4StQFSS4MGKrbtZzWMU1Ru1cuy66rpz+Z
   ts4Ght9zM6IEiuMyreLeBg9MVq3SdN9lIEckPZmnNfoCYC1Kflyvuw1CQ
   MEfBQmA1LNlyFAaI9by0Ksz6lbwVSBqzzwW3u/wSgHUqSHC58/eZs1T3l
   QlOTsVYJc3Yq1KlDMHfNAxYZkA4R+S4S88KID20fbhcvuiLHkkrCpkTgh
   kt452Ype6Zi/dcF/62ChqwTOql5tDKEUhVVituDXDlWO4TvC0sWVl4fi4
   g==;
X-CSE-ConnectionGUID: tx2LYcy5SEe5OQx2yaXd5Q==
X-CSE-MsgGUID: E59QKVbFShmBQSV0B5NRXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="57916242"
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="57916242"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 15:31:23 -0700
X-CSE-ConnectionGUID: sgPx69gGQUmAcBfh+diB0g==
X-CSE-MsgGUID: F43qLPHRSEaSbB4nMS+1Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,220,1739865600"; 
   d="scan'208";a="130938428"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 17 Apr 2025 15:31:19 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u5XlM-000263-34;
	Thu, 17 Apr 2025 22:31:16 +0000
Date: Fri, 18 Apr 2025 06:31:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v3 2/2] x86/devmem: Drop /dev/mem access for confidential
 guests
Message-ID: <202504180628.qlDJEl1e-lkp@intel.com>
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
config: arc-randconfig-001-20250418 (https://download.01.org/0day-ci/archive/20250418/202504180628.qlDJEl1e-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250418/202504180628.qlDJEl1e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504180628.qlDJEl1e-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/char/mem.c: In function 'open_port':
>> drivers/char/mem.c:604:13: error: implicit declaration of function 'cc_platform_has' [-Wimplicit-function-declaration]
     604 |             cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
         |             ^~~~~~~~~~~~~~~
>> drivers/char/mem.c:604:29: error: 'CC_ATTR_GUEST_MEM_ENCRYPT' undeclared (first use in this function)
     604 |             cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/char/mem.c:604:29: note: each undeclared identifier is reported only once for each function it appears in


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

