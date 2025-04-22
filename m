Return-Path: <stable+bounces-135092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED42A96704
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6EC189B954
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDE1277805;
	Tue, 22 Apr 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlC2RnTS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2722777F5;
	Tue, 22 Apr 2025 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320284; cv=none; b=CBBv77vFvQqFPqA8wHGZPQ+XcUY506VK88OOWn/kEKbkwA0UlAZxrNpRchO2WaD9VwpTeIDpfcGSRv5oNgTRCIzDFP1C43HRJhbA7AR5ylvlM7/OTz6tVTdsJf7HAKWAYUT12WjtXUix6xXJzfze3DqWpn6rptFgAJAKYGO1T8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320284; c=relaxed/simple;
	bh=GgJCNAGMvR0NtaDv652psAyvJcAiYqq6JDbJevX2YzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbbyuXYnUE1GapMZ0Mye30a5mVQg3C5k8Fhkuhr5FWRnY9Of33if9zUDB71o9JGCSy7DOX0bXo4tTRpaT0D2+lIF0i5VKWoKfEL0BoBx7rqLCWngaeXIrTJpshUPnncuI/4SOVVfF0UfCYNtrdODf9MAVNWvdgJGAdiZt1TSjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlC2RnTS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745320283; x=1776856283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GgJCNAGMvR0NtaDv652psAyvJcAiYqq6JDbJevX2YzQ=;
  b=ZlC2RnTSXAENMuzxGYVsUwPsaBAkFed/mPDu87oYPhaOx4egpTic0bPO
   WUSmjfhjp/wPuV/ztwXbpfqXCVXOtNZBYHDH2NZO8CrTVC/OHTX3Axtzc
   4PNHyreP+f6e0ML4gqe4Ohjbsh139dqW8I3hBaQRrA05seR4W17eztiom
   b/xvevI2mWrUbTRS4GXlJQ7nLSA3bz5PuT+UIx+b5NbjsXEsKbQl2XceV
   mT1A13BKb8n/kO31WANS5cn3GBWgZaCiBJ9eGqghEDfjRlM7m4VFThYon
   JdSqZIyVfvgcP11ou3vkXO15rc75v7rZ7IMiGeAfkY7btKaAb++x+oIF8
   Q==;
X-CSE-ConnectionGUID: X/2L9IOMSjSUf6d9t2MFGA==
X-CSE-MsgGUID: sqYPRoWbTDOysSSp+TNMsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="57537199"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="57537199"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 04:11:22 -0700
X-CSE-ConnectionGUID: YdRcZeB1TpiEuEaveCHjDg==
X-CSE-MsgGUID: 7y+61/VvTvaQNkl5z4jmSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="169189240"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 22 Apr 2025 04:11:18 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u7BX1-0000tP-2l;
	Tue, 22 Apr 2025 11:11:15 +0000
Date: Tue, 22 Apr 2025 19:10:24 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, alexander.deucher@amd.com,
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	simona@ffwll.ch, YiPeng.Chai@amd.com, tao.zhou1@amd.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/amdgpu: Remove redundant return value checks
 for amdgpu_ras_error_data_init
Message-ID: <202504221807.hOSkO5OB-lkp@intel.com>
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
[also build test ERROR on linus/master v6.15-rc3 next-20250417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-amdgpu-Remove-redundant-return-value-checks-for-amdgpu_ras_error_data_init/20250422-153759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20250422073505.2378-1-vulab%40iscas.ac.cn
patch subject: [PATCH RESEND] drm/amdgpu: Remove redundant return value checks for amdgpu_ras_error_data_init
config: i386-buildonly-randconfig-005-20250422 (https://download.01.org/0day-ci/archive/20250422/202504221807.hOSkO5OB-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250422/202504221807.hOSkO5OB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504221807.hOSkO5OB-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:170:6: warning: unused variable 'ret' [-Wunused-variable]
     170 |         int ret;
         |             ^~~
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:690:44: error: expected ';' after expression
     690 |         amdgpu_ras_error_data_init(&obj->err_data)
         |                                                   ^
         |                                                   ;
   1 warning and 1 error generated.


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

