Return-Path: <stable+bounces-66318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0938F94DCC0
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF4B1F21A36
	for <lists+stable@lfdr.de>; Sat, 10 Aug 2024 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D522157488;
	Sat, 10 Aug 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kV0DkQ9y"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC713E02A
	for <stable@vger.kernel.org>; Sat, 10 Aug 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723292771; cv=none; b=G5005thkEhqTsLwOyOvCh2y3s2cJJntiI+by2Vk0VZFi4LdYC2WvhC9BW9KKID+KKSXe5wsC2SSbQCqB5Ic2shBr/p+si1xToClGyfhWZ6p0JDfb/vzaergzgaHGXaMQwVSPDjZqaYEODMId6hhg15hf/f0mnKiCLdCe/5d3ixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723292771; c=relaxed/simple;
	bh=n6S/oGteTWAzvKyTeV+JlVkxczJJOB23hpbVAeIhq84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh72fpnO3izl2rrVVVAzIPIzjATLjVP96dbICnreAch7qQLPrFH6N0rzTVAGUAgyOIW9tWNyWmEkXUdUDawe2tDD2Zw3/0xsPA00emFVwYIGASSSIo4VGaR7xwX8McQ9NAP7civsft/xhs6P6xGMSaYMwCeq25PRHBrw3oJ/u7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kV0DkQ9y; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723292770; x=1754828770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n6S/oGteTWAzvKyTeV+JlVkxczJJOB23hpbVAeIhq84=;
  b=kV0DkQ9yy5U397iebDEcKruwJ1mQYDsis3tFwHfkdakraanN0NVtmSNp
   sV8Qxre4+/ezFXC7oix/V+9orULN2y2QFPv1eUa8dDtRix4ukt2QiGC2i
   13HhRYWUG9st19OldPdUW4koOeHnFB/290puimHX3ZjPlc0SD4x9D1Dp/
   TdV0xJz6yQv7OrN9P6GHX26PwkAMY/BIczujZ2EpFPcTcvc49BMLAErtq
   jouqFk4YPBt+J1IGSkfwbo5HhBqPp4bcJNh83vKBWiG2u9/V1l9y9PHj+
   xUHRXoFZSCvU6FnEiOu9wEzro33bqb2SMPxEsmxqZfm+D1Wb5Tk/lYHmC
   Q==;
X-CSE-ConnectionGUID: oGaLufA8Tv2H2hhBSIfhsg==
X-CSE-MsgGUID: HWVx0iibST2PcLbAiYO05A==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="25226957"
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="25226957"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 05:26:09 -0700
X-CSE-ConnectionGUID: pVlAOMANTumYDn0PJyDMyQ==
X-CSE-MsgGUID: KLhlkVf/SCKAi+8XtabK9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,279,1716274800"; 
   d="scan'208";a="62654847"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2024 05:26:06 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sclAa-0009v6-0A;
	Sat, 10 Aug 2024 12:26:04 +0000
Date: Sat, 10 Aug 2024 20:25:04 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
Subject: Re: [PATCH] video/aperture: match the pci device when calling
 sysfb_disable()
Message-ID: <202408102027.iWri1VXT-lkp@intel.com>
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
config: i386-randconfig-001-20240810 (https://download.01.org/0day-ci/archive/20240810/202408102027.iWri1VXT-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240810/202408102027.iWri1VXT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408102027.iWri1VXT-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: screen_info_pci_dev
   >>> referenced by aperture.c:358 (drivers/video/aperture.c:358)
   >>>               drivers/video/aperture.o:(aperture_remove_conflicting_pci_devices) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

