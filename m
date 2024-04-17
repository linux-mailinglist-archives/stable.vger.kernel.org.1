Return-Path: <stable+bounces-40097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1DA8A8182
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 12:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE2D1C21E16
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2D13C81F;
	Wed, 17 Apr 2024 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uq4QSnok"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4647913C68E;
	Wed, 17 Apr 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351587; cv=none; b=jg5j8YayOeqUPsbhkou2MGd3glP1pb6e9wyoP1kGeET8g9yb8HvpXprz7UH8xZCts56L7hen9bmOEJ6gPSMp8+DR9UA4JoM9B2v1GleWNPLwQaAA6gh5H0FvVWtEZls236RTWx7RDMKwtNymtM6PEmcUMo/VH4puXHbZ0ZUHVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351587; c=relaxed/simple;
	bh=cmU7FEP7+gAfzRzY/2Uj0ANcSi3jAqVqok2HMkjHbBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8EQXvV2koxbCV6P08syBcYRBJXodg86xA0NNa4nH1nRshSgzK3kBoh0IQYtTNfL4VQWMtkW7p8+/m3Z0cJgD1iTvjzXritYOttgb0M6yG4UayGmi/iABIJVu1ks96ZD/ZRUZ52q4gnfNa0l1LtrfDt1ndyfcOsJSKDwqTwOosg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uq4QSnok; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713351585; x=1744887585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cmU7FEP7+gAfzRzY/2Uj0ANcSi3jAqVqok2HMkjHbBM=;
  b=Uq4QSnokd3AgLu3KcZUoLUDqvSNM8ZUzwFCQnZ0almyqpAfNtmHtyi73
   3GbzUG33cronnuvgy5Xt3PkSRQSaPsQ+1RSFrBVL7yVXn580BNKuljxWk
   Os8sxjo/Zr1p096lbbmTaq2fklty4qjmPTtwh8lsJ41+w8MRM/GNA6Oja
   ocTEIM0cwHtz18gy67dutmFHAE55RJG/I/yx1ZGqCCSgxV7U3If4r7EgR
   LmcHdUXLhFlEpkle023kXPo7LTExfFF2///AbNoNv0hp6hp9dexCA4idb
   TTI6x8ape8HzNqnphdCs3SAtfkLCRTRq3wYF2lHdLJPhofB7d4+aWBrcc
   Q==;
X-CSE-ConnectionGUID: 5ubGJBziQaSixqqXfuN2vw==
X-CSE-MsgGUID: 7EFvZxg+QD2CwP4Utym7mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="9386635"
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="9386635"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 03:59:45 -0700
X-CSE-ConnectionGUID: oIreVgWaRwGJG3OUgyr3KA==
X-CSE-MsgGUID: nRymCCveRBqshFKixxFmeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,209,1708416000"; 
   d="scan'208";a="53541746"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 17 Apr 2024 03:59:43 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rx30p-0006Vq-0Z;
	Wed, 17 Apr 2024 10:59:35 +0000
Date: Wed, 17 Apr 2024 18:58:50 +0800
From: kernel test robot <lkp@intel.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, John Youn <John.Youn@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: xhci-plat: Don't include xhci.h
Message-ID: <202404171847.XPIgGzM6-lkp@intel.com>
References: <900465dc09f1c8e12c4df98d625b9985965951a8.1713310411.git.Thinh.Nguyen@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900465dc09f1c8e12c4df98d625b9985965951a8.1713310411.git.Thinh.Nguyen@synopsys.com>

Hi Thinh,

kernel test robot noticed the following build errors:

[auto build test ERROR on 3d122e6d27e417a9fa91181922743df26b2cd679]

url:    https://github.com/intel-lab-lkp/linux/commits/Thinh-Nguyen/usb-xhci-plat-Don-t-include-xhci-h/20240417-074220
base:   3d122e6d27e417a9fa91181922743df26b2cd679
patch link:    https://lore.kernel.org/r/900465dc09f1c8e12c4df98d625b9985965951a8.1713310411.git.Thinh.Nguyen%40synopsys.com
patch subject: [PATCH 1/2] usb: xhci-plat: Don't include xhci.h
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20240417/202404171847.XPIgGzM6-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240417/202404171847.XPIgGzM6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404171847.XPIgGzM6-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/usb/host/xhci-rzv2m.c: In function 'xhci_rzv2m_init_quirk':
>> drivers/usb/host/xhci-rzv2m.c:21:33: error: invalid use of undefined type 'struct usb_hcd'
      21 |         struct device *dev = hcd->self.controller;
         |                                 ^~
>> drivers/usb/host/xhci-rzv2m.c:23:32: error: invalid use of undefined type 'struct device'
      23 |         rzv2m_usb3drd_reset(dev->parent, true);
         |                                ^~
   drivers/usb/host/xhci-rzv2m.c: In function 'xhci_rzv2m_start':
   drivers/usb/host/xhci-rzv2m.c:32:16: error: invalid use of undefined type 'struct usb_hcd'
      32 |         if (hcd->regs) {
         |                ^~
>> drivers/usb/host/xhci-rzv2m.c:34:26: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
      34 |                 int_en = readl(hcd->regs + RZV2M_USB3_INTEN);
         |                          ^~~~~
   drivers/usb/host/xhci-rzv2m.c:34:35: error: invalid use of undefined type 'struct usb_hcd'
      34 |                 int_en = readl(hcd->regs + RZV2M_USB3_INTEN);
         |                                   ^~
>> drivers/usb/host/xhci-rzv2m.c:14:33: error: implicit declaration of function 'BIT' [-Werror=implicit-function-declaration]
      14 | #define RZV2M_USB3_INT_XHC_ENA  BIT(0)
         |                                 ^~~
   drivers/usb/host/xhci-rzv2m.c:16:34: note: in expansion of macro 'RZV2M_USB3_INT_XHC_ENA'
      16 | #define RZV2M_USB3_INT_ENA_VAL  (RZV2M_USB3_INT_XHC_ENA \
         |                                  ^~~~~~~~~~~~~~~~~~~~~~
   drivers/usb/host/xhci-rzv2m.c:35:27: note: in expansion of macro 'RZV2M_USB3_INT_ENA_VAL'
      35 |                 int_en |= RZV2M_USB3_INT_ENA_VAL;
         |                           ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/usb/host/xhci-rzv2m.c:36:17: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
      36 |                 writel(int_en, hcd->regs + RZV2M_USB3_INTEN);
         |                 ^~~~~~
   drivers/usb/host/xhci-rzv2m.c:36:35: error: invalid use of undefined type 'struct usb_hcd'
      36 |                 writel(int_en, hcd->regs + RZV2M_USB3_INTEN);
         |                                   ^~
   cc1: some warnings being treated as errors


vim +21 drivers/usb/host/xhci-rzv2m.c

c52c9acc415eb6 Biju Das 2023-01-21  13  
c52c9acc415eb6 Biju Das 2023-01-21 @14  #define RZV2M_USB3_INT_XHC_ENA	BIT(0)
c52c9acc415eb6 Biju Das 2023-01-21  15  #define RZV2M_USB3_INT_HSE_ENA	BIT(2)
c52c9acc415eb6 Biju Das 2023-01-21  16  #define RZV2M_USB3_INT_ENA_VAL	(RZV2M_USB3_INT_XHC_ENA \
c52c9acc415eb6 Biju Das 2023-01-21  17  				 | RZV2M_USB3_INT_HSE_ENA)
c52c9acc415eb6 Biju Das 2023-01-21  18  
c52c9acc415eb6 Biju Das 2023-01-21  19  int xhci_rzv2m_init_quirk(struct usb_hcd *hcd)
c52c9acc415eb6 Biju Das 2023-01-21  20  {
c52c9acc415eb6 Biju Das 2023-01-21 @21  	struct device *dev = hcd->self.controller;
c52c9acc415eb6 Biju Das 2023-01-21  22  
c52c9acc415eb6 Biju Das 2023-01-21 @23  	rzv2m_usb3drd_reset(dev->parent, true);
c52c9acc415eb6 Biju Das 2023-01-21  24  
c52c9acc415eb6 Biju Das 2023-01-21  25  	return 0;
c52c9acc415eb6 Biju Das 2023-01-21  26  }
c52c9acc415eb6 Biju Das 2023-01-21  27  
c52c9acc415eb6 Biju Das 2023-01-21  28  void xhci_rzv2m_start(struct usb_hcd *hcd)
c52c9acc415eb6 Biju Das 2023-01-21  29  {
c52c9acc415eb6 Biju Das 2023-01-21  30  	u32 int_en;
c52c9acc415eb6 Biju Das 2023-01-21  31  
c52c9acc415eb6 Biju Das 2023-01-21  32  	if (hcd->regs) {
c52c9acc415eb6 Biju Das 2023-01-21  33  		/* Interrupt Enable */
c52c9acc415eb6 Biju Das 2023-01-21 @34  		int_en = readl(hcd->regs + RZV2M_USB3_INTEN);
c52c9acc415eb6 Biju Das 2023-01-21  35  		int_en |= RZV2M_USB3_INT_ENA_VAL;
c52c9acc415eb6 Biju Das 2023-01-21 @36  		writel(int_en, hcd->regs + RZV2M_USB3_INTEN);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

