Return-Path: <stable+bounces-45121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A97C48C6004
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F1E1F22F3E
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 05:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBE39AF4;
	Wed, 15 May 2024 05:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJHvZLvK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B378D38FA3;
	Wed, 15 May 2024 05:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749469; cv=none; b=N9m8xCwwVtkzmQm+bCNWHIxqHPpn7uOVgDIwuudWa/lZjvnZxUHnxRKf9/XYLP0sr/MHiq3VBAuUyk2aEa+Ha5/7CFGCECyVSvbUjBZO2v8V0DeUafVInMDy7/Mk7j6akADBDBXfQJbzD4jfqeGJgmPmDlHOidCozJmDyPFh23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749469; c=relaxed/simple;
	bh=h8jEMkjr9a6UEUBdDnobak1Ak3GF70nbpnDd0R9vzec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BghRGBPtI32hNr+a7LS3WJWMHYeekEtcI3Orvblt1n9BAfg5M7XNGj7uF8NZgBKADMeQKW2SA2Hlwb+Q/oPEkq77uXw0h0dec6xj+iImZCQcPkxwOTrjcvPpl2pBp5uYTnCOnSPcUp6I9GIscCD57K7qoCwhRgI/YCxG18pWvh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJHvZLvK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715749466; x=1747285466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h8jEMkjr9a6UEUBdDnobak1Ak3GF70nbpnDd0R9vzec=;
  b=gJHvZLvKg3IYmUgQ3HwoR90SAfVyYHhXIVuKZeloJKrhLn8wJi5axXZ0
   hfBKGg/Q36EiRTnpsdOaXCJbKFU7a5+FX7OsCWnSgKgIJhaKWxIkDXtus
   OU4SiEHJ1cYHW78KBDWjQC6+vTelNR4YbWJxhV8hJ0it2cnYfXuJXRg+G
   KnqT6OfYKgg22vC0IeDh47x3FDdF9Mt6gAY9FAyVId/8EMMft7z04ptxu
   YVzm+mQLWpSPdNiVIOqozazh0+iS+BzUGW32NSelUc7NaX+XVwvo9lixK
   vC5jVlajjCri9HnwbXmx+fxZBS5z8REG6AnomI9nVXfEPZtoH7nj1Lbfk
   w==;
X-CSE-ConnectionGUID: 4ef7Uwg7RKOcOey1D4/VoQ==
X-CSE-MsgGUID: 0lrAvFUVSiW0yXgr/NwLOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="11893463"
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="11893463"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 22:04:26 -0700
X-CSE-ConnectionGUID: KnAIlQCySpS87twm+Dvf+A==
X-CSE-MsgGUID: xCmFryzPRnqZx8RLc3fMCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,160,1712646000"; 
   d="scan'208";a="35459391"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 14 May 2024 22:04:24 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s76oO-000CSR-2n;
	Wed, 15 May 2024 05:04:20 +0000
Date: Wed, 15 May 2024 13:04:05 +0800
From: kernel test robot <lkp@intel.com>
To: Carlos Llamas <cmllamas@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-team@android.com, stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] locking/atomic: fix trivial typo in comment
Message-ID: <202405151209.U1zWe95G-lkp@intel.com>
References: <20240514224625.3280818-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514224625.3280818-1-cmllamas@google.com>

Hi Carlos,

kernel test robot noticed the following build errors:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp linus/master v6.9 next-20240514]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Carlos-Llamas/locking-atomic-fix-trivial-typo-in-comment/20240515-064934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20240514224625.3280818-1-cmllamas%40google.com
patch subject: [PATCH] locking/atomic: fix trivial typo in comment
config: openrisc-defconfig (https://download.01.org/0day-ci/archive/20240515/202405151209.U1zWe95G-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240515/202405151209.U1zWe95G-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405151209.U1zWe95G-lkp@intel.com/

All errors (new ones prefixed by >>):

>> error: include/linux/atomic/atomic-instrumented.h has been modified.
   make[3]: *** [./Kbuild:68: .checked-atomic-instrumented.h] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1197: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

