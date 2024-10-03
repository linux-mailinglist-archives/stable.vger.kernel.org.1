Return-Path: <stable+bounces-80646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B72198F12E
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 16:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABE51F21E59
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3CB19CC3D;
	Thu,  3 Oct 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X36bucQA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE0E1865EB;
	Thu,  3 Oct 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965060; cv=none; b=mgNlEMsADlXC8EPNVN4/VaiMC7cPWrer2Ptsw7NJtEYJ0wkC4nq/2cwVydvujlQKn2UfvJkTsrqBHgNlsSgrAw7a9jioH1ntI5VsGZ+LgkqjHKOXe1ETyoE94chGZhgntiIifbChyBlmj3uUWx6f0PZVk5BegArYpE9UDdhY/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965060; c=relaxed/simple;
	bh=G+Fubbp/rA7RALzFHwAcUC/zODqThiiFh668LGAqJGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAL4Azg4EQ86neQYVx/VYUxO/QsjDbUNjRrfvmePtc8BaJobkH+/E7mXZRBDK4Vq+oh4jSvs9NxiIdE60ZohE56sP/NMMHynoCrWyUm/cwHm4RytgJgydohbpuOmqrTKvjkh6VQ+yf8cTcYwmwpWe9Vkr7bMGsbHgX+uHmrg+kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X36bucQA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727965058; x=1759501058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+Fubbp/rA7RALzFHwAcUC/zODqThiiFh668LGAqJGI=;
  b=X36bucQAonWaF2pEronN7B+o5V7gpb/hdWbvfxYCinklk0Mw1dQ8T5h1
   zBMpgMOwjx+zMqgTfq+truAFANCT/Yx8HXio2VVbHWEvjj89M8lk1sWYK
   Z+zs6E8T/xBwlJCh3OF0swbdyYIincMMmste7D8HBOeUegwD4dq+/shVm
   FLpLFZQLv2eClrJQsf9FlmwPjE++qZAaysHiVFkYNcl1aXixW7mVUmo8X
   bnNkPHJ1wbqYlR73PU+0WK0agC2rXfevVJPpZ4FA5fnX9ag06gbF+pZ4/
   SoMcchgHC1jRwHERSGnxJU7Sbv+o39E5XaQxRj+wge8GyKpKbuPqTZae2
   Q==;
X-CSE-ConnectionGUID: LKZ/fRHJSned0PFBK7JJpw==
X-CSE-MsgGUID: DrnBEL8PT0mDXYE4ykCUSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="44686777"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="44686777"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 07:17:37 -0700
X-CSE-ConnectionGUID: x3s19jX5Tu+FhXyOFq4ERg==
X-CSE-MsgGUID: mnZTxqodSGGwzW7kIoVZ9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74041819"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 03 Oct 2024 07:17:34 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swMe4-0000VO-1B;
	Thu, 03 Oct 2024 14:17:32 +0000
Date: Thu, 3 Oct 2024 22:17:03 +0800
From: kernel test robot <lkp@intel.com>
To: Ard Biesheuvel <ardb+git@google.com>, x86@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, Fangrui Song <i@maskray.me>,
	Brian Gerst <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/stackprotector: Work around strict Clang TLS symbol
 requirements
Message-ID: <202410032133.9218ziFI-lkp@intel.com>
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
config: i386-buildonly-randconfig-006-20241003 (https://download.01.org/0day-ci/archive/20241003/202410032133.9218ziFI-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241003/202410032133.9218ziFI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410032133.9218ziFI-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/mm/testmmiotrace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
>> WARNING: modpost: EXPORT symbol "__ref_stack_chk_guard" [vmlinux] version generation failed, symbol will not be versioned.
Is "__ref_stack_chk_guard" prototyped in <asm/asm-prototypes.h>?
>> WARNING: modpost: "__ref_stack_chk_guard" [arch/x86/events/amd/amd-uncore.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [arch/x86/events/intel/intel-uncore.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [arch/x86/kernel/apm.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [arch/x86/crypto/serpent-sse2-i586.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [arch/x86/platform/iris/iris.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [kernel/locking/locktorture.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [kernel/rcu/rcutorture.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [kernel/rcu/rcuscale.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [kernel/time/test_udelay.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [kernel/trace/ring_buffer_benchmark.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [kernel/backtracetest.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [fs/quota/quota_v1.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [fs/configfs/configfs.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [fs/nls/nls_base.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [fs/nls/nls_euc-jp.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [fs/nls/nls_utf8.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [fs/autofs/autofs4.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [fs/fuse/fuse.ko] has no CRC!
>> WARNING: modpost: "__ref_stack_chk_guard" [crypto/geniv.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/echainiv.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/crypto_null.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/xts.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/ctr.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/ccm.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/chacha20poly1305.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/cryptd.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/chacha_generic.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/authenc.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/authencesn.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/lzo.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/lzo-rle.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/essiv.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/ecdh_generic.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [crypto/crypto_simd.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/kunit/kunit-example-test.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/math/rational-test.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/crypto/libcurve25519-generic.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/crypto/libdes.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_hexdump.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/cpumask_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_hash.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_ubsan.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_vmalloc.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_scanf.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_xarray.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_maple_tree.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/test_lockup.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/842/842_compress.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/842/842_decompress.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/lzo/lzo_compress.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/overflow_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [lib/siphash_kunit.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/bus/mhi/host/mhi.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/bus/mhi/host/mhi_pci_generic.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/allwinner/phy-sun6i-mipi-dphy.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/intel/phy-intel-lgm-emmc.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/marvell/phy-berlin-sata.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/mediatek/phy-mtk-pcie.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/mediatek/phy-mtk-hdmi-drv.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/mediatek/phy-mtk-mipi-dsi-drv.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/qualcomm/phy-qcom-qmp-combo.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/qualcomm/phy-qcom-qmp-usbc.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/qualcomm/phy-qcom-qmp-usb-legacy.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/qualcomm/phy-qcom-snps-femto-v2.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/ralink/phy-ralink-usb.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/rockchip/phy-rockchip-pcie.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/ti/phy-da8xx-usb.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/ti/phy-am654-serdes.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/phy/ti/phy-j721e-wiz.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/freescale/pinctrl-imx.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/nuvoton/pinctrl-wpcm450.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/pxa/pinctrl-pxa25x.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/pxa/pinctrl-pxa27x.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/qcom/pinctrl-msm.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/qcom/pinctrl-ssbi-gpio.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/qcom/pinctrl-ssbi-mpp.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/qcom/pinctrl-lpass-lpi.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/sprd/pinctrl-sprd.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/pinctrl-da9062.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/pinctrl-max77620.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/pinctrl-microchip-sgpio.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/pinctrl-single.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pinctrl/meson/pinctrl-meson.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-104-dio-48e.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-aspeed.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-ath79.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-bd71815.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-cadence.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-da9055.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-eic-sprd.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-hlwd.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-idt3243x.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-lp873x.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-max77620.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-mc33880.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-pch.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-sch311x.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-sim.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-syscon.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-tps65912.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-ts4800.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-ts4900.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-uniphier.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-wm8994.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-xgene-sb.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/gpio/gpio-xra1403.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pci/hotplug/cpqphp.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pci/controller/pcie-altera.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pci/controller/pcie-mt7621.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/pci/pci-stub.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/video/backlight/ams369fg06.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/video/backlight/l4f00242t03.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/video/backlight/lms283gf05.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/video/backlight/88pm860x_bl.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/video/backlight/aat2870_bl.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/video/backlight/adp8870_bl.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/video/backlight/as3711_bl.ko] has no CRC!
WARNING: modpost: "__ref_stack_chk_guard" [drivers/video/backlight/backlight.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

