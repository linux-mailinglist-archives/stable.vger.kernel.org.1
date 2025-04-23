Return-Path: <stable+bounces-135213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14A6A97B79
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 02:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2BA17CBCD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 00:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183212701DA;
	Wed, 23 Apr 2025 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oo2xdRW+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9524689;
	Wed, 23 Apr 2025 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745366487; cv=none; b=iQvbuukooN6OEOdVCbY3h2f9gUOQ63LbcdBWQEuPDBB5wsaqh8rtJV5+vJR6oeD8Db0NDAPtXj6D6InLwLmjXaYM6R5btoPjoZsU4fjmYoPuBwqydynn/1SboP0DSkAea9U1hZ8n2GmLOgBnaq6+dxbqU2eWwT6bi/N4oRnGD1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745366487; c=relaxed/simple;
	bh=weyfJbTWEyO2rrCelTiBVub3jIwlIWeXRb7GV7JeALo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQV7F2yBi7eIdKOxplOmGMGjA3+j8PsoXhXht6lnNrK3oRTo0yCjJKB6C2hi/vcoX113CLKkcRhnsE77rbC2xopxB3YJO+8Jr83b3TKBTuVKH7vJ+QpnGEPLcAUlu8p6gJIK2R1+iT8jemAqlqiJq6hN6iwwiDjDUIHxnZARV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oo2xdRW+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745366486; x=1776902486;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=weyfJbTWEyO2rrCelTiBVub3jIwlIWeXRb7GV7JeALo=;
  b=Oo2xdRW+q4Tsgn9ciikES8u/DG2nnT5mvHQkeuZQ14oPjcKJ9METgxLl
   mz8N9Tyrjwzav2YvAQBBVZ2l7xFntw1Qc5DEBDK3cY0lhbZ51kZgQN297
   mm36pHJJgu2w9kS7HYuqSN4B40vEyAxXUXvmaTrSTrqOf/9JsS8QKzgcJ
   HyKJ3Pw2HWqkpWmSxSSEGvwYV7kze+E+94W9TNLGtEhQzEi6R0JQKTHE5
   W98+p/o4fm6PwbJ23UIla5L1n+r6Q96Emn0+nWol7BoMsy3/DUqa8RtM8
   sBtFCbBws8XjpKW9dJhmYr+tWvzGhC2wzoOmDEa2tTCBbFacT1isr7kqS
   w==;
X-CSE-ConnectionGUID: omWrXjJeQxaVBZDaX0303g==
X-CSE-MsgGUID: HfOOogR9TKuITPebcQO7aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="64473718"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="64473718"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 17:01:25 -0700
X-CSE-ConnectionGUID: KXlNhm73REuidp51nGuUyw==
X-CSE-MsgGUID: ODJS1dHkRcGIMYUxL3/eNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="137141044"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 22 Apr 2025 17:01:21 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7NYF-0001Pb-1G;
	Wed, 23 Apr 2025 00:01:19 +0000
Date: Wed, 23 Apr 2025 08:00:21 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, alexander.deucher@amd.com,
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	simona@ffwll.ch, YiPeng.Chai@amd.com, tao.zhou1@amd.com
Cc: oe-kbuild-all@lists.linux.dev, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/amdgpu: Remove redundant return value checks
 for amdgpu_ras_error_data_init
Message-ID: <202504230730.y8eas9Se-lkp@intel.com>
References: <20250422073505.2378-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422073505.2378-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-exynos/exynos-drm-next]
[also build test ERROR on linus/master drm/drm-next drm-misc/drm-misc-next v6.15-rc3 next-20250422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-amdgpu-Remove-redundant-return-value-checks-for-amdgpu_ras_error_data_init/20250422-153759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20250422073505.2378-1-vulab%40iscas.ac.cn
patch subject: [PATCH RESEND] drm/amdgpu: Remove redundant return value checks for amdgpu_ras_error_data_init
config: x86_64-buildonly-randconfig-001-20250423 (https://download.01.org/0day-ci/archive/20250423/202504230730.y8eas9Se-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250423/202504230730.y8eas9Se-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504230730.y8eas9Se-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function 'amdgpu_reserve_page_direct':
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:170:13: warning: unused variable 'ret' [-Wunused-variable]
     170 |         int ret;
         |             ^~~
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c: In function 'amdgpu_ras_create_obj':
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:690:51: error: expected ';' before 'obj'
     690 |         amdgpu_ras_error_data_init(&obj->err_data)
         |                                                   ^
         |                                                   ;
     691 | 
     692 |         obj->head = *head;
         |         ~~~                                        


vim +690 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c

   664	
   665	/* make one obj and return it. */
   666	static struct ras_manager *amdgpu_ras_create_obj(struct amdgpu_device *adev,
   667			struct ras_common_if *head)
   668	{
   669		struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
   670		struct ras_manager *obj;
   671	
   672		if (!adev->ras_enabled || !con)
   673			return NULL;
   674	
   675		if (head->block >= AMDGPU_RAS_BLOCK_COUNT)
   676			return NULL;
   677	
   678		if (head->block == AMDGPU_RAS_BLOCK__MCA) {
   679			if (head->sub_block_index >= AMDGPU_RAS_MCA_BLOCK__LAST)
   680				return NULL;
   681	
   682			obj = &con->objs[AMDGPU_RAS_BLOCK__LAST + head->sub_block_index];
   683		} else
   684			obj = &con->objs[head->block];
   685	
   686		/* already exist. return obj? */
   687		if (alive_obj(obj))
   688			return NULL;
   689	
 > 690		amdgpu_ras_error_data_init(&obj->err_data)
   691	
   692		obj->head = *head;
   693		obj->adev = adev;
   694		list_add(&obj->node, &con->head);
   695		get_obj(obj);
   696	
   697		return obj;
   698	}
   699	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

