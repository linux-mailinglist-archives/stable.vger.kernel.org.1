Return-Path: <stable+bounces-80678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4CC98F59E
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 19:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03FB3B20F9A
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D071A7AE4;
	Thu,  3 Oct 2024 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI6omeBD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F71A76CA;
	Thu,  3 Oct 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727978209; cv=none; b=amaGURewKAIyVsF6A+ZhZjuViyLPaMkOfeapWZEeVQhCql6kKXCURWi7Hbq/jtYYMiI6hBiYsIkZAUf9inqGms+s8pQYa+MBdEO5hivuB/ZX2JYA8Ak2Q1aqZmO1ewB7JC+0p0gZaJRqJ7zXVdR9VmRhHDzGPJy/at97nqNOwpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727978209; c=relaxed/simple;
	bh=Tdz26YASw+9dvuOBtCyGwKlhjo+jgUjMABkC2CrdMsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMdWvoWd3vtstIMt7CBTWs+McvtQP18misAFCwtiHtb7nH7gYCsthJ1NGNk7LJYLPgLAvZyMbVFG5N2qS1JsFHEDk98pW0RQ4gQDprXU2//BCb89qIHOddiGOBw8uOEu/WiwOVDswisE0j1NIuezm0Q5TrgFIB09PlkOpwACttQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iI6omeBD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727978207; x=1759514207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tdz26YASw+9dvuOBtCyGwKlhjo+jgUjMABkC2CrdMsU=;
  b=iI6omeBDc2JFg4iVnzvJlwN0tG/INzff2Nh2TziMIjczvXUS6SObFQOX
   SXIFMmyANFRtiRlo7HoSJvv2BYQ+UopkH7v0YTleX4ofdg8x/bGA9dTMG
   jj1a4L0LzUUTzOEjU7QONFF0ttO5myJzNG+uw67V5FiUsOr58AWPf5lz3
   2dmQ4kNXqaJCKOE/4SJK+uVA7MrJChaqwj7I27YfEFXLJeJIDrGYChMDb
   q4JPYsfaDX+jMQAxZNmQV9BIwvwj0e5deNnUWIoABLj3OT3sYhCTeP0oZ
   FFBMnnF9LOFoLfo21OZ3Dh4DY4iUQ177OJraLQVA0rr0XucF1hDj/VDow
   w==;
X-CSE-ConnectionGUID: M6/GC9aqQx6KayUWHhAKVA==
X-CSE-MsgGUID: 51ntRmi/QmqSK+DhTj5Ylw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37749978"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="37749978"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 10:56:47 -0700
X-CSE-ConnectionGUID: 11Robe9ISIGg+2J4PucE6A==
X-CSE-MsgGUID: cra+AehDQ1ivTOPes+L8Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="74012973"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 03 Oct 2024 10:56:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swQ4A-0000kR-1v;
	Thu, 03 Oct 2024 17:56:42 +0000
Date: Fri, 4 Oct 2024 01:55:55 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb+git@google.com>, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, Fangrui Song <i@maskray.me>,
	Brian Gerst <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: Work around strict Clang TLS symbol
 requirements
Message-ID: <202410040122.shftyeMf-lkp@intel.com>
References: <20241002092534.3163838-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002092534.3163838-2-ardb+git@google.com>

Hi Ard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on tip/master linus/master tip/x86/asm v6.12-rc1 next-20241003]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ard-Biesheuvel/x86-stackprotector-Work-around-strict-Clang-TLS-symbol-requirements/20241002-172733
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20241002092534.3163838-2-ardb%2Bgit%40google.com
patch subject: [PATCH] x86/stackprotector: Work around strict Clang TLS symbol requirements
config: i386-randconfig-061-20241003 (https://download.01.org/0day-ci/archive/20241004/202410040122.shftyeMf-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410040122.shftyeMf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410040122.shftyeMf-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: EXPORT symbol "__ref_stack_chk_guard" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ref_stack_chk_guard" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "__ref_stack_chk_guard" [kernel/rcu/refscale.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [kernel/torture.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [fs/nfs/nfsv4.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [fs/unicode/utf8-selftest.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [fs/smb/client/cifs.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/gcm.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [lib/kunit/kunit-test.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/string_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/string_helpers_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_hexdump.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_hash.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [lib/test_printf.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_scanf.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_bitmap.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_uuid.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [lib/cmdline_kunit.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [lib/memcpy_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/overflow_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/stackinit_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/fortify_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/siphash_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpu/drm/tests/drm_cmdline_parser_test.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpu/drm/tests/drm_connector_test.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpu/drm/tests/drm_format_helper_test.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpu/drm/display/drm_display_helper.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/base/test/property-entry-test.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/power/supply/test_power.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [net/mptcp/mptcp_crypto_test.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [net/dns_resolver/dns_resolver.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

