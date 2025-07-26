Return-Path: <stable+bounces-164828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DABB12A07
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 12:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5603E3A4D0A
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 10:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DCB241679;
	Sat, 26 Jul 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UssYt3xG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04A23ED6A;
	Sat, 26 Jul 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753525591; cv=none; b=obQpH0UGIUvynWXYycaVDTTC4Optjsis6gM69tkbt2MdeyvvNoHVuZpWYSUAjohSQGpbeI+8aiUXBCd19QVg9eoDls9eK49XtRkAt5zmFZUwyrNC826XNuCLzyrwJ9AZ+M27vhVlNFPSUPURYpIemH/ADbIBzSaDEwPE6/0CQmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753525591; c=relaxed/simple;
	bh=rdLbrjse36XtzLBFRtpD0P4XKQsz7lIV+X4u+ba+Dm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLoZOjGb/TGGfQRz8bsL7ATs2ot/3ioIQ7PeATqgUITuRm3Fvyw48TqTFa5pa+qFkQx799A0s4Ok+rfrXiXhpUZWeu9y7APxPWpwvhZKpI5b+xDgZbC1gm44aaSjkJorFn2IkkuA4ADyEmVEgEMg3pM7TPVi9nQsPHrYTWJMng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UssYt3xG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753525590; x=1785061590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdLbrjse36XtzLBFRtpD0P4XKQsz7lIV+X4u+ba+Dm8=;
  b=UssYt3xGXiTV0WGlfxWikD0ZjnLfa/lklrIaklazaAdFQjImSbAPfqtJ
   CL7j9UL/V07wf8Pqui4dNKR44pqFJ13pPJm+V6KKLVT0ooZxxcj64Ajl5
   sbUgr3Hn2MRQ8x54O5QxZkzhh5gH7/NxXImSjmBBxRsfT8MKoNzgSjfJE
   Mjs8AVjDbxrepF1DdThkYwzKpxzHP2QnF1SxxXR9ePLWWOVsmBY+vPd73
   2Amx159uM0po7rWWFc+eJMebFmHTh7qLbtD/07tG1VdQ1WQFkgFoo4nfl
   W4348nmsKigyycqvLjY78Ut/hbfcQ6j3XY7RS9s2Fhc+/6QjlCtry/3eU
   A==;
X-CSE-ConnectionGUID: 5sQAUelwQCafEds76BbvSA==
X-CSE-MsgGUID: ffsd8rUsQR2qKQkMcSPYEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="59497447"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="59497447"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 03:26:29 -0700
X-CSE-ConnectionGUID: /9KvRXspRjO1plGsRBv9Tw==
X-CSE-MsgGUID: lo/mTwlERoGabMdfexlmsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="185142011"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jul 2025 03:26:26 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufc6h-000Ls7-2K;
	Sat, 26 Jul 2025 10:26:23 +0000
Date: Sat, 26 Jul 2025 18:26:12 +0800
From: kernel test robot <lkp@intel.com>
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mmc: sdhci-pci-gli: Add a new function to
 simplify the code
Message-ID: <202507261828.pgCE5fRD-lkp@intel.com>
References: <20250725105257.59145-2-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725105257.59145-2-victorshihgli@gmail.com>

Hi Victor,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v6.16-rc7 next-20250725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Victor-Shih/mmc-sdhci-pci-gli-Add-a-new-function-to-simplify-the-code/20250725-185611
base:   linus/master
patch link:    https://lore.kernel.org/r/20250725105257.59145-2-victorshihgli%40gmail.com
patch subject: [PATCH V2 1/2] mmc: sdhci-pci-gli: Add a new function to simplify the code
config: i386-buildonly-randconfig-001-20250726 (https://download.01.org/0day-ci/archive/20250726/202507261828.pgCE5fRD-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250726/202507261828.pgCE5fRD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507261828.pgCE5fRD-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/sdhci-pci-gli.c: In function 'sdhci_gli_mask_replay_timer_timeout':
>> drivers/mmc/host/sdhci-pci-gli.c:296:39: error: 'pdev' undeclared (first use in this function); did you mean 'dev'?
     296 |         aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
         |                                       ^~~~
         |                                       dev
   drivers/mmc/host/sdhci-pci-gli.c:296:39: note: each undeclared identifier is reported only once for each function it appears in


vim +296 drivers/mmc/host/sdhci-pci-gli.c

   288	
   289	/* Genesys Logic chipset */
   290	static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *dev)
   291	{
   292		int aer;
   293		u32 value;
   294	
   295		/* mask the replay timer timeout of AER */
 > 296		aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
   297		if (aer) {
   298			pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
   299			value |= PCI_ERR_COR_REP_TIMER;
   300			pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
   301		}
   302	}
   303	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

