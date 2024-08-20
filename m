Return-Path: <stable+bounces-69765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7909590DB
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 01:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4870D2851EC
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 23:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25961C822E;
	Tue, 20 Aug 2024 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4d9DfIi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446018A6C9
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195042; cv=none; b=deAf1DFi68aKtxe46loTPhz/jIr3zRwDhs85dBzKJdK0x+omEc+bgcRFg8phexouaklgDGVGL8pQq90qr7klnyuGz00ZCdZ7oVqAClvsiP8FVVtSWLZyN+5OIbLa1mLvqjgzx7cwy1XFUDhQGK47YySwn6PaHquDopG3bGHCYR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195042; c=relaxed/simple;
	bh=WnnlRbrqcAg01SpPX//j1Z5O3c2B//kviZT/SH1mq+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLibTca+hoWaYnGY8NfVRhtruATOR0i+fxIhMnPPtDa3tzU76goetZ8geKk+mHVxfAWwSipnMgaBsponF6ZrzM14P+npr7/bi+0UqQTlYsIRcDPThIlHobQ0ux/lqLgk29GonZJ1YEuEgm8Iu4mefBR3buhVeS1DbnlzFDHjHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4d9DfIi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724195040; x=1755731040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WnnlRbrqcAg01SpPX//j1Z5O3c2B//kviZT/SH1mq+A=;
  b=V4d9DfIiw8W/pfxp9kUz1iW7ljfZpCmnat904nwlY8AmmlOK9gRPU2sY
   ERMJwjrK9IZen5MFp7haLGvTivyJfibMsNzmPCWYYX9/+G3eCcaJOW0Oe
   +U4taeJt+n6ant33PFnwpd7cvoqIhASG/LdTjdwj2+6SiIQ3vLGDUbkHa
   Bch0Y+aGgnffS5Blim0mYPyibBv8ZqndxIx1D/zEf3k0ZCrUh5HZqOUP5
   l5hssWASJqkF2/VhTd/nH9fgh3d7D+ZvY98/uysPRnoUKIlBF8wp8FOw/
   xL5Kezm3aLzkiDv5tPKbt26uN5gTNgfOX6s4DKSkyq211C2WzFjwL1Egu
   Q==;
X-CSE-ConnectionGUID: 564CzEDDRnWdDGPhuhno4A==
X-CSE-MsgGUID: MG++kk9uSSKL3iWppR/NBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22716749"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="22716749"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 16:03:59 -0700
X-CSE-ConnectionGUID: Sn+Kj9asQpqkeoV4X7v8gQ==
X-CSE-MsgGUID: zTQ5XgucSEKZkwpsSXb6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="60846798"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Aug 2024 16:03:57 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgXtK-000AgA-1U;
	Tue, 20 Aug 2024 23:03:54 +0000
Date: Wed, 21 Aug 2024 07:03:41 +0800
From: kernel test robot <lkp@intel.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: oe-kbuild-all@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
Subject: Re: [PATCH V2] video/aperture: match the pci device when calling
 sysfb_disable()
Message-ID: <202408210620.nTCwLpCO-lkp@intel.com>
References: <20240819165341.799848-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819165341.799848-1-alexander.deucher@amd.com>

Hi Alex,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-tip/drm-tip]
[also build test WARNING on robh/for-next drm-misc/drm-misc-next linus/master v6.11-rc4 next-20240820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alex-Deucher/video-aperture-match-the-pci-device-when-calling-sysfb_disable/20240820-005528
base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
patch link:    https://lore.kernel.org/r/20240819165341.799848-1-alexander.deucher%40amd.com
patch subject: [PATCH V2] video/aperture: match the pci device when calling sysfb_disable()
config: i386-randconfig-054-20240820 (https://download.01.org/0day-ci/archive/20240821/202408210620.nTCwLpCO-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408210620.nTCwLpCO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408210620.nTCwLpCO-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: sysfb_disable+0x7a (section: .text) -> sysfb_pci_dev_is_enabled (section: .init.text)
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/asn1_decoder.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

