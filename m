Return-Path: <stable+bounces-172662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB4B32C23
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 23:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC49E2984
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 21:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1E12EA175;
	Sat, 23 Aug 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1RBuD+U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C715C0;
	Sat, 23 Aug 2025 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755986033; cv=none; b=SQ6AT6nLgrif3P0/tZOKoLcXMIoWL69uMRs/eVdO0hEKNp0aDXRKlLyWJ97SludagXPfv71uhiEVKQ7DH2t5mR2lgIdH04lFYqnWsHPnz0V/RAoKr6W/HYxZetVf9kKbtw1dhkAww+A1s3HPRsOnxY3q6Z1axOpX7zDRZJCZ02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755986033; c=relaxed/simple;
	bh=9BXIzaov3cIKsITFD2kYAmNOig9QKsNDG5ar116bKPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSoRrGJcLfrMmt7NXjWPQVpW0Q4TjxXLoCB9QSvnRf8yFzaJnOvARJhYJsEud6DTXh77usNJDVJZX3sVDn7+vk9VVjraphPh/2Z5OfBLGaMKR77rK4g61MJf8TdM8oHXwZsyV/yplXqWG6w6Q2YwZfgxk2LYFwI/IjkiOQPSyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1RBuD+U; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755986031; x=1787522031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BXIzaov3cIKsITFD2kYAmNOig9QKsNDG5ar116bKPs=;
  b=F1RBuD+UGGawQMj0uVGegqI/GFe/9guSB/nSFH4JF2N4tgCYSa0xmuwZ
   IMlL+vWVYx7NG7Bg9Ci52oUdDjdJyQvb5/Myyf7LVOwJwknCW7dlGkHSe
   KMz/ET+Kj42chNncvI5fjoIS3fR/4E02lBsu/qSkDwc/vY1YCqlx1j6l1
   9RrOgimZg/SD0impyqhVAJ6Vz3gTt37pEwZiu1p+kksz1zJCaUqA+GJs7
   B9SZJMVp3f0M4GmMZ5JJr2tbN9/4B35UXpD6a8YRNXncZjLxGMwd3ZVqP
   6XSfyiAUfawIZZmXYROxTlRdiSP39AIKjhZusAfC8RD2oynwbtICAVUZr
   A==;
X-CSE-ConnectionGUID: Tra55mtVT72rtchuTamBmQ==
X-CSE-MsgGUID: N9rN2BaEQ5OB4EEfQf7Xdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58319421"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="58319421"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2025 14:53:50 -0700
X-CSE-ConnectionGUID: XxiiGVKgSbGjo2/uo1qaBQ==
X-CSE-MsgGUID: RpzRL/2pTRGLvAstCrrpKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="168210962"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 23 Aug 2025 14:53:44 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upwBB-000Mch-25;
	Sat, 23 Aug 2025 21:53:41 +0000
Date: Sun, 24 Aug 2025 05:53:22 +0800
From: kernel test robot <lkp@intel.com>
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
	fthain@linux-m68k.org, geert@linux-m68k.org, mhiramat@kernel.org,
	senozhatsky@chromium.org
Cc: oe-kbuild-all@lists.linux.dev, lance.yang@linux.dev,
	amaindex@outlook.com, anna.schumaker@oracle.com,
	boqun.feng@gmail.com, ioworker0@gmail.com, joel.granados@kernel.org,
	jstultz@google.com, kent.overstreet@linux.dev,
	leonylgao@tencent.com, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, longman@redhat.com,
	mingo@redhat.com, mingzhe.yang@ly.com, oak@helsinkinet.fi,
	rostedt@goodmis.org, tfiga@chromium.org, will@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on
 lock structures
Message-ID: <202508240539.ARmC1Umu-lkp@intel.com>
References: <20250823074048.92498-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823074048.92498-1-lance.yang@linux.dev>

Hi Lance,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on akpm-mm/mm-everything sysctl/sysctl-next linus/master v6.17-rc2 next-20250822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lance-Yang/hung_task-fix-warnings-by-enforcing-alignment-on-lock-structures/20250823-164122
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20250823074048.92498-1-lance.yang%40linux.dev
patch subject: [PATCH 1/1] hung_task: fix warnings by enforcing alignment on lock structures
config: x86_64-buildonly-randconfig-001-20250823 (https://download.01.org/0day-ci/archive/20250824/202508240539.ARmC1Umu-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250824/202508240539.ARmC1Umu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508240539.ARmC1Umu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from sound/soc/codecs/mt6660.c:15:
>> sound/soc/codecs/mt6660.h:28:1: warning: alignment 1 of 'struct mt6660_chip' is less than 8 [-Wpacked-not-aligned]
      28 | };
         | ^
>> sound/soc/codecs/mt6660.h:25:22: warning: 'io_lock' offset 49 in 'struct mt6660_chip' isn't aligned to 8 [-Wpacked-not-aligned]
      25 |         struct mutex io_lock;
         |                      ^~~~~~~


vim +28 sound/soc/codecs/mt6660.h

f289e55c6eeb43 Jeff Chang 2020-01-16  19  
f289e55c6eeb43 Jeff Chang 2020-01-16  20  struct mt6660_chip {
f289e55c6eeb43 Jeff Chang 2020-01-16  21  	struct i2c_client *i2c;
f289e55c6eeb43 Jeff Chang 2020-01-16  22  	struct device *dev;
f289e55c6eeb43 Jeff Chang 2020-01-16  23  	struct platform_device *param_dev;
f289e55c6eeb43 Jeff Chang 2020-01-16  24  	struct mt6660_platform_data plat_data;
f289e55c6eeb43 Jeff Chang 2020-01-16 @25  	struct mutex io_lock;
f289e55c6eeb43 Jeff Chang 2020-01-16  26  	struct regmap *regmap;
f289e55c6eeb43 Jeff Chang 2020-01-16  27  	u16 chip_rev;
f289e55c6eeb43 Jeff Chang 2020-01-16 @28  };
f289e55c6eeb43 Jeff Chang 2020-01-16  29  #pragma pack(pop)
f289e55c6eeb43 Jeff Chang 2020-01-16  30  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

