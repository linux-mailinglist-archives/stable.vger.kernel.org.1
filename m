Return-Path: <stable+bounces-66317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C4194DC94
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 13:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED25D1C20ED4
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 11:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B3155332;
	Sat, 10 Aug 2024 11:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="maVue8W4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0EEC2
	for <stable@vger.kernel.org>; Sat, 10 Aug 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723290358; cv=none; b=muGDsyTF/BGvaGMOyMAiV8jAlpVqKwYGfMW6IFRJprVlrVLG6SMcQAnzWQ54/+MZFv37lLtHc96Kbz4Dcww56p13/r1d3aMCMFhSyQ2PO0JM/65DD1kRWEuCyXR+PBRJtxSY6c+FFSD7OmMZtOHob/8ZwGPPwc7/Jz2GPg/gwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723290358; c=relaxed/simple;
	bh=8DIEUv9amZ+E2lCgoLiQtJnnKGQaWds7ILyjPec/rbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXa07KVVIvk9bK6ypgAKfGp5boXhJFwESF51Acg9MQZIKTLSGMSQUywZkDesl8YgB3t/0PmyNUL/dHbqmMs2ION0dwrWb2DQzdsPfmYLOPHOHxe/VLy8FWjsSkpI+GxP/SQ0vYWbn3M8Bb+jPRmof0i5iwswCXbOPCbx41hkCjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=maVue8W4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723290357; x=1754826357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8DIEUv9amZ+E2lCgoLiQtJnnKGQaWds7ILyjPec/rbg=;
  b=maVue8W45+qEmCpoC0RdFy5FI75zJBa08cEet2kd2Fu+4Vm1d0SF7oyr
   Rc2phGWo8Zim0Xrd5cW3PFA80cLKUhWiQZlGZlagH8uwCP+lxJ+eqDOS5
   Swc7dTkNGoGZDmZnDBkasBXVstVa2/5KtjVilZTGEm2LAVTV5XilF0CN1
   FYt7ZbZCmAYwaH3hoBQJ3ZNjYueF7+kxW3T5F75AWgujHjeXNhOk+E/i8
   kj0apCq9CbYod9bNz3fwHhHVkFwYWRyybm9M6CG3IUsF/3o/nGMAnMcwl
   a45F40hHDGMovXaRUafnuwY9VcBv7MATVVkgkyCVQpicIIuREBsIWZZTP
   w==;
X-CSE-ConnectionGUID: anfk73kxRxGXqDTVJA4aJA==
X-CSE-MsgGUID: eCbN/8V7RbWkaXcpG7P2ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="21434574"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="21434574"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 04:45:56 -0700
X-CSE-ConnectionGUID: ZE69ZQ+cRkaODyeSfuUf/A==
X-CSE-MsgGUID: 8yfBQNjpRaGLylUsHtViLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="57701445"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 10 Aug 2024 04:45:06 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sckWt-0009tr-0P;
	Sat, 10 Aug 2024 11:45:03 +0000
Date: Sat, 10 Aug 2024 19:44:16 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] video/aperture: match the pci device when calling
 sysfb_disable()
Message-ID: <202408101951.tXyqYOzv-lkp@intel.com>
References: <20240809150327.2485848-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809150327.2485848-1-alexander.deucher@amd.com>

Hi Alex,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.11-rc2 next-20240809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Deucher/video-aperture-match-the-pci-device-when-calling-sysfb_disable/20240810-021357
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20240809150327.2485848-1-alexander.deucher%40amd.com
patch subject: [PATCH] video/aperture: match the pci device when calling sysfb_disable()
config: csky-randconfig-001-20240810 (https://download.01.org/0day-ci/archive/20240810/202408101951.tXyqYOzv-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408101951.tXyqYOzv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408101951.tXyqYOzv-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/video/aperture.o: in function `aperture_remove_conflicting_pci_devices':
>> aperture.c:(.text+0x222): undefined reference to `screen_info_pci_dev'
   csky-linux-ld: drivers/video/aperture.o: in function `devm_aperture_acquire_release':
>> aperture.c:(.text+0x2c0): undefined reference to `screen_info'
>> csky-linux-ld: aperture.c:(.text+0x2c4): undefined reference to `screen_info_pci_dev'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

