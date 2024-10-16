Return-Path: <stable+bounces-86530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4369A1134
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 20:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A105A285D6E
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 18:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BDE18C030;
	Wed, 16 Oct 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOm0X0sr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C216DEAC;
	Wed, 16 Oct 2024 18:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101940; cv=none; b=BOR2qfJGvmq6yv0PI9bjFrGTtkQid+2HsG14Hrlmt9Bd1pT4SsESe1pKcM1b/Kmi8UqHMkzWlbr5I1rRQkLsV6hM76HVkyZJsL3jHZ7nbfSDHEvbZeS530QVql8ScODpfWGI/DDs1OThpXV9IjRbTkRdrGAGwiunRqH0Ego6c9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101940; c=relaxed/simple;
	bh=Uqn6nJwh3np3K3wO0/gNSwr2u+wCMIt0uK+ye+P+3Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUoWffb5kPEPGeMOOv+U73sb3wLFOo4Qm3ORZCy+RRYyq1W8D1IrzSCjWtbVw7nEcgo2Hn9jQTwVT7VyNN6bPz7q8zrXv4OwoGCbjANSMfKWErm2QRPlBwgFxfY8kERkUKim9ZoAnFhk5llkAAkejtL5jHHwfS8CADWGVBbE/5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOm0X0sr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729101939; x=1760637939;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Uqn6nJwh3np3K3wO0/gNSwr2u+wCMIt0uK+ye+P+3Ao=;
  b=kOm0X0sr1SmbItd0ZFe6ogpD+I7SM6g4qHn5THyAmtv7OnvDjbsKLDkf
   6puHjjhf8Y1Lkn+NKwMvuRYh1cj5/KEjr3ePx+6HzQQyUzfCwDkRs5xUS
   cOrIg+dm/Z6oqDcKiMhUsClpLcVsqd8XeLPZJCh9gHBqRsdhu6lxcVGiS
   EuCePV4DjjLXRZydXG7PVQS6G3Lrp+tgv4t41xvVmCq4uJIUWm1OT2aax
   0q2iX1xDO1bGKHBvwF710QKQuy0gHVdTNnp4xv/duI+Xn44UgotuMo0vS
   HxxCrux/FHdVOUtlZ5y3WeAv1AUAbj8bDuqTOQa2NVRl5kM4UZFv+nB9Q
   g==;
X-CSE-ConnectionGUID: 2qwnkbTpRjaFAz+ReQq9IQ==
X-CSE-MsgGUID: ksLcyLf8QsOJ/++NTKKMBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="39144185"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="39144185"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 11:05:38 -0700
X-CSE-ConnectionGUID: YC5HAXFITW+7ybKROyyHyw==
X-CSE-MsgGUID: j+OvdoFtT8SA1TF881bQHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="78194029"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 16 Oct 2024 11:05:36 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t18Or-000LDu-20;
	Wed, 16 Oct 2024 18:05:33 +0000
Date: Thu, 17 Oct 2024 02:05:09 +0800
From: kernel test robot <lkp@intel.com>
To: Jann Horn <jannh@google.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Frank Mori Hess <fmh6jj@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2] comedi: Flush partial mappings in error case
Message-ID: <202410170111.K30oyTWa-lkp@intel.com>
References: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>

Hi Jann,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6485cf5ea253d40d507cd71253c9568c5470cd27]

url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/comedi-Flush-partial-mappings-in-error-case/20241016-022809
base:   6485cf5ea253d40d507cd71253c9568c5470cd27
patch link:    https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-cafb0e27dd9a%40google.com
patch subject: [PATCH v2] comedi: Flush partial mappings in error case
config: arm-randconfig-004-20241016 (https://download.01.org/0day-ci/archive/20241017/202410170111.K30oyTWa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241017/202410170111.K30oyTWa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410170111.K30oyTWa-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/comedi/comedi_fops.o: in function `comedi_mmap':
>> comedi_fops.c:(.text+0x4be): undefined reference to `zap_vma_ptes'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

