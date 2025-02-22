Return-Path: <stable+bounces-118655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F19AA408D9
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 15:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AEA4420C7A
	for <lists+stable@lfdr.de>; Sat, 22 Feb 2025 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8427082F;
	Sat, 22 Feb 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDFxjoEl"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F522F37;
	Sat, 22 Feb 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740232958; cv=none; b=goDp+Z0d7eGeWLOk0rgjdYaOONJFnRNhcc87BinIFvyTj18RLX0bKVWw2L3KmTiKCdf76ttSyLPT42Z9A0d4ZD7ZpMTVBQqUS2CzGjYLYzTxnlLL5evdf0qNtopTS0LErvZNkoD64kLHl6pO4ESlvem+kZJyNFpeD9ZuubrvWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740232958; c=relaxed/simple;
	bh=cqLdn3pSfdlFMz8BT1qTRt7U9h2eoJo3ZzvxPRvlrbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=szhHB71bEZnWqzPtFlxnBG4nP8WqxasGGzkuAAqkSQh1LM1UMRKikMmhIUgqZ28hMMaFmNkr2qcqhtShaq7wBKMdN/xEi2/gyEj42uCoLgig9eE83DIwQn5Eg+Kdo+Kv7VTRUT5WmJ0LmLQnwbVWExSsKjKHEhnqMD2WuTAws2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDFxjoEl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740232955; x=1771768955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cqLdn3pSfdlFMz8BT1qTRt7U9h2eoJo3ZzvxPRvlrbM=;
  b=JDFxjoElTh4rI76Xacm/CsX5IL73wisLZm6FLcFTibYzPDR3iZr6Te0t
   HWd3UXehkWtUb786NXrQUBUdTk8FVHljZocmhIRS/w0otOaopX6vtaZ5B
   a5pf4ObDZVEME8sBWnI48aLXKa03ZRcOpeMmKe09IbxcjviyFG6q4yuyL
   mtcHXHriUtZAfyF4axzd0KuMY6fG3KM5Q82A4RGyWsjXOG3fPPLbv0A8F
   IB8dGzrQ7qs0dRRZA8gw2buZOL8w8ChxK8LiTCmCFRltuZZKoirjyz4Oi
   Z4CjLSM7oSYbo3r6Aipel3frTmxKXT2BgJsiuMHfIFFgclEevqzbx9HaE
   g==;
X-CSE-ConnectionGUID: S3QbqlE4SuyJ24cMEhy7/w==
X-CSE-MsgGUID: RdcOAyPLSuunxCJ3KJO2Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41247802"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41247802"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2025 06:02:35 -0800
X-CSE-ConnectionGUID: YpbMq6JwSYqlDX5v5TKBPw==
X-CSE-MsgGUID: 5foC5zoJSDSp20UImXrUdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,308,1732608000"; 
   d="scan'208";a="120722829"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 22 Feb 2025 06:02:32 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlq5N-0006d5-2d;
	Sat, 22 Feb 2025 14:02:29 +0000
Date: Sat, 22 Feb 2025 22:01:32 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Eggers <ceggers@arri.de>,
	Russell King <linux@armlinux.org.uk>,
	Yuntao Liu <liuyuntao12@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, ceggers@gmx.de,
	Christian Eggers <ceggers@arri.de>, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: add KEEP() keyword to ARM_VECTORS
Message-ID: <202502222158.UhwuvDZv-lkp@intel.com>
References: <20250221125520.14035-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221125520.14035-1-ceggers@arri.de>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.14-rc3 next-20250221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Eggers/ARM-add-KEEP-keyword-to-ARM_VECTORS/20250221-205720
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20250221125520.14035-1-ceggers%40arri.de
patch subject: [PATCH] ARM: add KEEP() keyword to ARM_VECTORS
config: arm-randconfig-003-20250222 (https://download.01.org/0day-ci/archive/20250222/202502222158.UhwuvDZv-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250222/202502222158.UhwuvDZv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502222158.UhwuvDZv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: ./arch/arm/kernel/vmlinux.lds:33: ( expected, but got }
   >>>  __vectors_lma = .; OVERLAY 0xffff0000 : AT(__vectors_lma) { .vectors { KEEP(*(.vectors)) } .vectors.bhb.loop8 { KEEP(*(.vectors.bhb.loop8)) } .vectors.bhb.bpiall { KEEP(*(.vectors.bhb.bpiall)) } } __vectors_start = LOADADDR(.vectors); __vectors_end = LOADADDR(.vectors) + SIZEOF(.vectors); __vectors_bhb_loop8_start = LOADADDR(.vectors.bhb.loop8); __vectors_bhb_loop8_end = LOADADDR(.vectors.bhb.loop8) + SIZEOF(.vectors.bhb.loop8); __vectors_bhb_bpiall_start = LOADADDR(.vectors.bhb.bpiall); __vectors_bhb_bpiall_end = LOADADDR(.vectors.bhb.bpiall) + SIZEOF(.vectors.bhb.bpiall); . = __vectors_lma + SIZEOF(.vectors) + SIZEOF(.vectors.bhb.loop8) + SIZEOF(.vectors.bhb.bpiall); __stubs_lma = .; .stubs ADDR(.vectors) + 0x1000 : AT(__stubs_lma) { *(.stubs) } __stubs_start = LOADADDR(.stubs); __stubs_end = LOADADDR(.stubs) + SIZEOF(.stubs); . = __stubs_lma + SIZEOF(.stubs); PROVIDE(vector_fiq_offset = vector_fiq - ADDR(.vectors));
   >>>                                                                                           ^

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

