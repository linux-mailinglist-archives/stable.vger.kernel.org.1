Return-Path: <stable+bounces-128409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85914A7CC83
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 04:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D961891593
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 02:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFE035976;
	Sun,  6 Apr 2025 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NmuVZBQe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350F36FC3;
	Sun,  6 Apr 2025 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743905426; cv=none; b=atiAeHf1O1/2946SpuZXk4NH1sNLyxrgA9WBC9jOcZzncTSt2K35Rny2NE8IgNm3iOOCS7xEYTuiGCEuapQQBz08Oi4boEAgFL47+AnxTyVopqIm/vAHzEoMNmPFCUWEE7+Q6Jc30trh/fnP/VftSvySYs9ZWS7i8iS+4qmGBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743905426; c=relaxed/simple;
	bh=rq+UJuHUiO3etF702qVSpgpAY5zF9H86GYrlKDApfSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7NQMd7SUgpzzMZKklOicNmJurHmxbYSNT+adsygF7DBsXjVrPePjv0GSgjWPJ6zCh9fMvDR30YOsQOPhmxUFNU6c6EhljQtFlhfFTTWFmpNsyARh4sJXlgL9q0iUl04hCEZnBEC9PQG7AudmnGSec5vScO8zn/uljkD/GeZ0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NmuVZBQe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743905424; x=1775441424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rq+UJuHUiO3etF702qVSpgpAY5zF9H86GYrlKDApfSc=;
  b=NmuVZBQe6U7+VIHQGgNkZsC7FgncDZR5oxDBqeOT7G3/pEYuHD+uifH5
   u6hBgu9d2fxpDsft8Kn4C37xTk3hWcHh406zPkweDuq+fuk7HdnPlqKnO
   ck/XH67s4zdFz6d0kwZT/ktG25Oz83scavk0g5Z5L9nGndDdyVhPRLawv
   pmQ1qJCdoV/OXABgsjiAFXyp9Fl+94fSYh0zHG/veO/LCabREDsN4tFUf
   s+8iLqVOjrnykXLbZxI+srN3RW9sf17i/snwssz3SkTI6uPfowSpKkjjK
   wm5g1ECqlKJNIsb5/WSdlwss5ddoYZ8++r6ErfiBZnol99+kR1JabK6t8
   A==;
X-CSE-ConnectionGUID: PwM/hcYQQRiwPGsZH5hdYw==
X-CSE-MsgGUID: lA4eZILZTIulZcxi75Q+8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11395"; a="45433990"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="45433990"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2025 19:10:23 -0700
X-CSE-ConnectionGUID: X//MYxyTR5SfRgEcP7kAVA==
X-CSE-MsgGUID: BU1KU/RWShiZAEYwyV93TA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="132763052"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Apr 2025 19:10:21 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1FSk-0002OX-37;
	Sun, 06 Apr 2025 02:10:18 +0000
Date: Sun, 6 Apr 2025 10:10:05 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8723bs: Add error handling for sd_read()
Message-ID: <202504060905.XvK4ueHM-lkp@intel.com>
References: <20250405160546.2639-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405160546.2639-1-vulab@iscas.ac.cn>

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/staging-rtl8723bs-Add-error-handling-for-sd_read/20250406-001458
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20250405160546.2639-1-vulab%40iscas.ac.cn
patch subject: [PATCH v4] staging: rtl8723bs: Add error handling for sd_read()
config: arm64-randconfig-001-20250406 (https://download.01.org/0day-ci/archive/20250406/202504060905.XvK4ueHM-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 92c93f5286b9ff33f27ff694d2dc33da1c07afdd)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250406/202504060905.XvK4ueHM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504060905.XvK4ueHM-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/rtl8723bs/hal/sdio_ops.c:190:17: error: expected ';' after expression
     190 |                         kfree(tmpbuf)
         |                                      ^
         |                                      ;
   1 error generated.


vim +190 drivers/staging/rtl8723bs/hal/sdio_ops.c

   150	
   151	static u32 sdio_read32(struct intf_hdl *intfhdl, u32 addr)
   152	{
   153		struct adapter *adapter;
   154		u8 mac_pwr_ctrl_on;
   155		u8 device_id;
   156		u16 offset;
   157		u32 ftaddr;
   158		u8 shift;
   159		u32 val;
   160		s32 __maybe_unused err;
   161		__le32 le_tmp;
   162	
   163		adapter = intfhdl->padapter;
   164		ftaddr = _cvrt2ftaddr(addr, &device_id, &offset);
   165	
   166		rtw_hal_get_hwreg(adapter, HW_VAR_APFM_ON_MAC, &mac_pwr_ctrl_on);
   167		if (
   168			((device_id == WLAN_IOREG_DEVICE_ID) && (offset < 0x100)) ||
   169			(!mac_pwr_ctrl_on) ||
   170			(adapter_to_pwrctl(adapter)->fw_current_in_ps_mode)
   171		) {
   172			err = sd_cmd52_read(intfhdl, ftaddr, 4, (u8 *)&le_tmp);
   173			return le32_to_cpu(le_tmp);
   174		}
   175	
   176		/*  4 bytes alignment */
   177		shift = ftaddr & 0x3;
   178		if (shift == 0) {
   179			val = sd_read32(intfhdl, ftaddr, NULL);
   180		} else {
   181			u8 *tmpbuf;
   182	
   183			tmpbuf = rtw_malloc(8);
   184			if (!tmpbuf)
   185				return SDIO_ERR_VAL32;
   186	
   187			ftaddr &= ~(u16)0x3;
   188			err = sd_read(intfhdl, ftaddr, 8, tmpbuf);
   189			if (err) {
 > 190				kfree(tmpbuf)
   191				return SDIO_ERR_VAL32;
   192			}
   193	
   194			memcpy(&le_tmp, tmpbuf + shift, 4);
   195			val = le32_to_cpu(le_tmp);
   196	
   197			kfree(tmpbuf);
   198		}
   199		return val;
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

