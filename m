Return-Path: <stable+bounces-90057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B309BDDEC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 05:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393DFB224F9
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 04:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98A318FDC8;
	Wed,  6 Nov 2024 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNHLMJNH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DD518F2DB;
	Wed,  6 Nov 2024 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730867111; cv=none; b=Hged2OvUmofGOzXCJTZO+33RNBVUueLe85YoS05vbPRVnT23S2cw2ZT+9jVFwPU8hZ4/DxClJbEc3JfKghHdeHBXIQIFLbYPz0LogOvycYkgnqgzmYUUC9v4V0DVafqJs2SsOyGMk05FbyAaHGyLsHSplY0BhHQVZGJWg45rKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730867111; c=relaxed/simple;
	bh=pWEctjQQTanA6z2UebLDRCkSZZqkGUMhJSZM7dfrgjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbg52ZRu9NnpSSwbXz92x1x0dAFNWQPhizz0MmdW1XVwkpfyjqxBHEQptLaczEJS9Nkqco8H6tO2OugWBgV+hzJclwb3QM+0gI9Zu1z9ecx4uWuwcQ9BHd84D15nyxzzwT7Y4DXK7W9tMeD5ILOusH+RHfUL/J2agTHltkwaqWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNHLMJNH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730867110; x=1762403110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pWEctjQQTanA6z2UebLDRCkSZZqkGUMhJSZM7dfrgjo=;
  b=GNHLMJNHsTQjLtxX89bt1Wdsz8oHJ9S5HSC573qeSHRICrRfGL8aztEf
   +XtZNTivrJsoYYjnVlbIZaUAr2xi2sXABc87p6CgXonSa2ahHPOjHF6Ej
   eWPzwZVU0cj0eyw4n9KizXSxkTnIwOPskZZ3HWVfNTWip5kZc7Lnbl5V+
   h4bDhkqri1qdcoi+ZbYYJqiPeOQ+QgNdO4EC+Jsnl+Luwg79lCmkMTJ0G
   ZHUO2t7qh4sjJ0Mq17MGbH1Hh+ZzlwNYxika7hqlbcMI9Vs8saRRwBigd
   m480+iaw4ycFfyCDa9iy95DUw+8d0f1hWxyLSEFXs6Ol6FdaYJ7veyCdz
   g==;
X-CSE-ConnectionGUID: CQRr9c46S/aVyKTasvd96g==
X-CSE-MsgGUID: SL/0eSHbSxO5su5pk/FGYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41751161"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41751161"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 20:25:09 -0800
X-CSE-ConnectionGUID: q+F05lRDQZC32BJiyyHpPA==
X-CSE-MsgGUID: 2Szh5VWpTsuALS2GF2zUlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="88869414"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Nov 2024 20:25:07 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8XbM-000mvh-2G;
	Wed, 06 Nov 2024 04:25:04 +0000
Date: Wed, 6 Nov 2024 12:24:50 +0800
From: kernel test robot <lkp@intel.com>
To: Calvin Owens <calvin@wbinvd.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rodolfo Giometti <giometti@enneenne.com>,
	George Spelvin <linux@horizon.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] pps: Fix a use-after-free
Message-ID: <202411061205.AZijSWPc-lkp@intel.com>
References: <abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin@wbinvd.org>

Hi Calvin,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.12-rc6 next-20241105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Calvin-Owens/pps-Fix-a-use-after-free/20241105-155819
base:   linus/master
patch link:    https://lore.kernel.org/r/abc43b18f21379c21a4d2c63372a04b2746be665.1730792731.git.calvin%40wbinvd.org
patch subject: [PATCH v3] pps: Fix a use-after-free
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20241106/202411061205.AZijSWPc-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 639a7ac648f1e50ccd2556e17d401c04f9cce625)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411061205.AZijSWPc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411061205.AZijSWPc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/ptp/ptp_ocp.c:10:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/ptp/ptp_ocp.c:10:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/ptp/ptp_ocp.c:10:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from drivers/ptp/ptp_ocp.c:10:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/ptp/ptp_ocp.c:4423:23: error: passing 'struct device' to parameter of incompatible type 'struct device *'; take the address with &
    4423 |                 ptp_ocp_symlink(bp, pps->dev, "pps");
         |                                     ^~~~~~~~
         |                                     &
   drivers/ptp/ptp_ocp.c:4387:52: note: passing argument to parameter 'child' here
    4387 | ptp_ocp_symlink(struct ptp_ocp *bp, struct device *child, const char *link)
         |                                                    ^
   13 warnings and 1 error generated.


vim +4423 drivers/ptp/ptp_ocp.c

773bda96492153 Jonathan Lemon  2021-08-03  4411  
773bda96492153 Jonathan Lemon  2021-08-03  4412  static int
773bda96492153 Jonathan Lemon  2021-08-03  4413  ptp_ocp_complete(struct ptp_ocp *bp)
773bda96492153 Jonathan Lemon  2021-08-03  4414  {
773bda96492153 Jonathan Lemon  2021-08-03  4415  	struct pps_device *pps;
773bda96492153 Jonathan Lemon  2021-08-03  4416  	char buf[32];
d7875b4b078f7e Vadim Fedorenko 2024-08-29  4417  
773bda96492153 Jonathan Lemon  2021-08-03  4418  	sprintf(buf, "ptp%d", ptp_clock_index(bp->ptp));
773bda96492153 Jonathan Lemon  2021-08-03  4419  	ptp_ocp_link_child(bp, buf, "ptp");
773bda96492153 Jonathan Lemon  2021-08-03  4420  
773bda96492153 Jonathan Lemon  2021-08-03  4421  	pps = pps_lookup_dev(bp->ptp);
773bda96492153 Jonathan Lemon  2021-08-03  4422  	if (pps)
773bda96492153 Jonathan Lemon  2021-08-03 @4423  		ptp_ocp_symlink(bp, pps->dev, "pps");
773bda96492153 Jonathan Lemon  2021-08-03  4424  
f67bf662d2cffa Jonathan Lemon  2021-09-14  4425  	ptp_ocp_debugfs_add_device(bp);
f67bf662d2cffa Jonathan Lemon  2021-09-14  4426  
773bda96492153 Jonathan Lemon  2021-08-03  4427  	return 0;
773bda96492153 Jonathan Lemon  2021-08-03  4428  }
773bda96492153 Jonathan Lemon  2021-08-03  4429  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

