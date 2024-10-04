Return-Path: <stable+bounces-80720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D767898FEFA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 10:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532D61F231C2
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 08:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA2C13D619;
	Fri,  4 Oct 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HGIw76Nj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3913BAC3;
	Fri,  4 Oct 2024 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728031336; cv=none; b=m+VSPsRUPEwJbwUgDNjame6VlXQ6AEJ6VKt9NTWXtr/ShOYv7PnoEx8+ieGePpb/XQv7IocVjMib70yvMt9wwQH31qFmyQzdCeYzOEaymh55YZnACw5qq1y9h+tcUsW1gwRyLVyE6hStFgYhLfy8zmXEJjU+urTf9lFPh6VyMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728031336; c=relaxed/simple;
	bh=pns61I65ZP7ckoYj8iUD/9/WF0Y59/fpgQSHHd2ExmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWBRB5JLL6EAxG9nkCknbUYoXvYRjQJ9A0v8RtAttn4FKsSftAl7rWxJmYyHkg+KhE2NEQVG8T6j2lfQwSD4bb2jR/TrDp83pW9735AzqIpx4EdwC0wwYgaym5bbKR/jCM/F+YsRgovA6G9cZeacp1R/HX8HxjfvRD+q9DEJ3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HGIw76Nj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728031333; x=1759567333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pns61I65ZP7ckoYj8iUD/9/WF0Y59/fpgQSHHd2ExmU=;
  b=HGIw76Nj268LzpXSi0qVw3tpVbU4847XTccxoQGENSJFSd9nhr5jIyDA
   KM2MhpUH/GHFeG5xBZC0Vkr1FbmLr6ETjp9PhaSrmDmQpCo4u+l3UKpMP
   IIliNWhxTsfiNhiDps9pZ2hAOznEHpRVRT2KVMsa/qxF887wD5fQD4vIp
   s8lHGLVmywKoc+2c3aLykCzseW0ALdaZv5cSDyXY80ZTs3tgnf5eckFST
   1x7fkXxs739MAhYoDH65Flo5lPrZN/tqytmiy6BdaGjSze7DRa2nPx6z4
   FU5Fbu2kljDaOtaZVY6aA6rkO8kZDTI1zpMJ8m2jsf+tar6Fmew3K6u6X
   A==;
X-CSE-ConnectionGUID: wl94fNJNSai7GXNe7e1+Ig==
X-CSE-MsgGUID: y4Y0B9y3R3mgneBxwB34dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="26715112"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="26715112"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 01:42:12 -0700
X-CSE-ConnectionGUID: +t/7UoSISImLoXtw8+CInA==
X-CSE-MsgGUID: LH/HnQDYQ5SGzCOxZRhHcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74958434"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 04 Oct 2024 01:42:10 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swdt1-0001OG-2O;
	Fri, 04 Oct 2024 08:42:07 +0000
Date: Fri, 4 Oct 2024 16:41:22 +0800
From: kernel test robot <lkp@intel.com>
To: Andrej Shadura <andrew.shadura@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	kernel@collabora.com, George Burgess <gbiv@chromium.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix type of len in
 rfcomm_sock_{bind,getsockopt_old}()
Message-ID: <202410041637.iOIxEAQQ-lkp@intel.com>
References: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>

Hi Andrej,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on bluetooth/master linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrej-Shadura/Bluetooth-Fix-type-of-len-in-rfcomm_sock_-bind-getsockopt_old/20241002-221656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20241002141217.663070-1-andrew.shadura%40collabora.co.uk
patch subject: [PATCH] Bluetooth: Fix type of len in rfcomm_sock_{bind,getsockopt_old}()
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20241004/202410041637.iOIxEAQQ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410041637.iOIxEAQQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410041637.iOIxEAQQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/bluetooth/rfcomm/sock.c: In function 'rfcomm_sock_bind':
>> include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_602' declared with attribute error: min(sizeof(sa), addr_len) signedness error
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:100:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:105:9: note: in expansion of macro '__careful_cmp_once'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:129:25: note: in expansion of macro '__careful_cmp'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^~~~~~~~~~~~~
   net/bluetooth/rfcomm/sock.c:339:15: note: in expansion of macro 'min'
     339 |         len = min(sizeof(sa), addr_len);
         |               ^~~


vim +/__compiletime_assert_602 +510 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  496  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  497  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  498  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  499  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  500  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  501   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  502   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  503   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  504   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  505   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  506   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  507   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  508   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  509  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @510  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  511  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

