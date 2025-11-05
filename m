Return-Path: <stable+bounces-192476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 900C0C33ECA
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 05:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 690014E14B1
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 04:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCDF24A074;
	Wed,  5 Nov 2025 04:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W8yWVUdD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0742F56;
	Wed,  5 Nov 2025 04:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762316455; cv=none; b=SHWjVo2DT6VXvv3uMtTQR4OE3ptKMd5msLO1Nu4dNI5o4TWkjOtrcjDJaXqyplp65a+r/xOpIzCL8IGOuiQuAP40Z7hFLHsoUj/+AyS59sV3mu843niL/7GvmMnGhp4eVuFnGLh6F5+Bcxj19z1raR11Qighw5bvkfwD5uzZFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762316455; c=relaxed/simple;
	bh=TZ/iCpQhqI2k8DgkkaFJpNQayv4Ws2h8B/Abzdxr+K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7EBD2R3wd7V38AICl8pwI3O5noQZbxpiGwMcuYDQCvT+QvDyvH72JWFptQyhLGXUMLj8Fd+rvlI2cqTolbe10ED87Hrqd7z3GBrpFrnqJJu9cLMrJDpYcRX8rjusqAyUM0Wpk0NgYhyoJt00CFhD8Gwxr4Lb9uF7U+FoYAbMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W8yWVUdD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762316454; x=1793852454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TZ/iCpQhqI2k8DgkkaFJpNQayv4Ws2h8B/Abzdxr+K8=;
  b=W8yWVUdD1FaY2RlBNXtU7S27+xqLYRMHtUcreWHJyrrGcOoYN8wKt4Kq
   BRhiGPZCfCEKRQSp0VGlsxg3jQX3ZWFU25IujHK6Zam5Hcr9ODzxt3OM9
   hYyhO5Dv7+HntsDIKoYBBcGqzCACHXIEahD2mGiKQ/z5N6C78Ou5tWlAA
   MSv/RfYzlx6PaIfngAYhjyAwQmhCQ+Vsq2zuRClIhLTlntiAhcnchGWow
   enuD8fjSyJaqsqJbJ4d8Ikk3jJJpF8047Rw8Shu7HhyoOrk8GzyEj3D2C
   C7zi4WgWznUpGbDsGQ4iTHWCcMdkNk3QP8sNdzFeazWs1XzBpZEzEqy7x
   A==;
X-CSE-ConnectionGUID: EzyIoh2QTAqwrCHIPsJ7ug==
X-CSE-MsgGUID: MJaRriBaT0GO0JRbX/ypmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="74716731"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="74716731"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 20:20:53 -0800
X-CSE-ConnectionGUID: QYLtRUMnQEeRSfVzBGxQ5A==
X-CSE-MsgGUID: FzSmdCbGRSq8R4gHd8Yy8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="191698524"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 04 Nov 2025 20:20:48 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGV0e-000S9y-33;
	Wed, 05 Nov 2025 04:20:38 +0000
Date: Wed, 5 Nov 2025 12:20:07 +0800
From: kernel test robot <lkp@intel.com>
To: Maciej Wieczor-Retman <m.wieczorretman@pm.me>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	m.wieczorretman@pm.me, stable@vger.kernel.org,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Baoquan He <bhe@redhat.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kasan: Unpoison pcpu chunks with base address tag
Message-ID: <202511051219.fmeaqcaq-lkp@intel.com>
References: <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman@pm.me>

Hi Maciej,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.18-rc4 next-20251104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maciej-Wieczor-Retman/kasan-Unpoison-pcpu-chunks-with-base-address-tag/20251104-225204
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/821677dd824d003cc5b7a77891db4723e23518ea.1762267022.git.m.wieczorretman%40pm.me
patch subject: [PATCH v1 1/2] kasan: Unpoison pcpu chunks with base address tag
config: x86_64-buildonly-randconfig-003-20251105 (https://download.01.org/0day-ci/archive/20251105/202511051219.fmeaqcaq-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511051219.fmeaqcaq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511051219.fmeaqcaq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/kasan/common.c:584:6: warning: no previous prototype for '__kasan_unpoison_vmap_areas' [-Wmissing-prototypes]
     584 | void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__kasan_unpoison_vmap_areas +584 mm/kasan/common.c

   583	
 > 584	void __kasan_unpoison_vmap_areas(struct vm_struct **vms, int nr_vms)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

