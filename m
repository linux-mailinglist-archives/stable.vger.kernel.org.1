Return-Path: <stable+bounces-241786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OmlNjY08WkgegEAu9opvQ
	(envelope-from <stable+bounces-241786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:27:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18348C910
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 00:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5842A30A9AEA
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BCD37DEB0;
	Tue, 28 Apr 2026 22:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c7tZ/4h5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064831B83B;
	Tue, 28 Apr 2026 22:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415201; cv=none; b=X7rN4C49rIfw+hQcaMctZqsFjaAGEpFI9ihSFLEkumRQJ+FOLF2EYzIFQd2Z9Ce2LDz7OLkXCSMbUCJGEPrU2P5s7WpI3ITDOh+HZD84YX/XMFdEwNOk9frAJVYNJ2F3vxNogPcd1VpowOPHuHUbT+TraZfGqqAhfyDhK1t46Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415201; c=relaxed/simple;
	bh=+ZMMz1Azx4YiMaUbzhvU1xkhQVlg/rYUrZYBIyZYrao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oggcvS9yO0RUyPK95/sfkl5JBlktQibNh3LuqjU75wTx3C+KAzw7PQyDrgx6eovZtKxwOZT+bkFUQ/oDGNEV80wmigrx8FqXn3j2Mvqo/wy2qKGztMfLHxDxWnPTXoWKqCTp/XkG+o3GNtzS3KDL+O+iZQdgg4J/6aNlNdjovDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c7tZ/4h5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777415200; x=1808951200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ZMMz1Azx4YiMaUbzhvU1xkhQVlg/rYUrZYBIyZYrao=;
  b=c7tZ/4h5sDfTDhuTJmGN1HqfswFL3fQaAN6riXjmhE8vds2miBjT9WT/
   UEkEoeSNxiJSQEBHUzDV95Nt/G1/9tfvMrz1c7h85zt2yfqfnA65JF4WF
   xOzqhFwODaHmO6gDaF8IMQUB+VWACbHGJl05ljS0Vihdv7e9nzlgjDACF
   FARcdn8i5QfMyy0vP7wMz510+65zp95W8eNb6bYIo23KGBVW3aSW5D/r0
   gCT2VRFb2Yg3mnQcHTiZjlEBneCJkDh2k7/g/gO8CS4UPk939lMM1cMMl
   ajOByTrxEkRHK5eHtzmZgHObWhMRkFnz92NzyOMbVvhQeWnpAFs9JsBGd
   g==;
X-CSE-ConnectionGUID: xiVHYS4ySF6+M/fNGDfPOQ==
X-CSE-MsgGUID: nqqQQDGjR42XyUa3TCKKNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89035811"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="89035811"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 15:26:39 -0700
X-CSE-ConnectionGUID: Vld6TlSiTkyuFnolSu64xQ==
X-CSE-MsgGUID: ii8X8X3WSf+bZExeBPVHng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="230939066"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Apr 2026 15:26:36 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wHqsz-00000000AJo-3SuK;
	Tue, 28 Apr 2026 22:26:33 +0000
Date: Wed, 29 Apr 2026 06:26:24 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Guan <guanwentao@uniontech.com>, chenhuacai@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	wuqianhai@loongson.cn, kernel@xen0n.name, jiaxun.yang@flygoat.com,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] LoongArch: Fix potential ade in
 loongson_gpu_fixup_dma_hang()
Message-ID: <202604290645.yU3tIquW-lkp@intel.com>
References: <20260428095051.746295-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428095051.746295-1-guanwentao@uniontech.com>
X-Rspamd-Queue-Id: 5F18348C910
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241786-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]

Hi Wentao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on chenhuacai-loongson/loongarch-fixes]
[also build test WARNING on linus/master v7.1-rc1 next-20260428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Guan/LoongArch-Fix-potential-ade-in-loongson_gpu_fixup_dma_hang/20260428-222642
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git loongarch-fixes
patch link:    https://lore.kernel.org/r/20260428095051.746295-1-guanwentao%40uniontech.com
patch subject: [PATCH v3] LoongArch: Fix potential ade in loongson_gpu_fixup_dma_hang()
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20260429/202604290645.yU3tIquW-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260429/202604290645.yU3tIquW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604290645.yU3tIquW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/loongarch/pci/pci.c:122:14: warning: variable 'regbase' is uninitialized when used here [-Wuninitialized]
     122 |                 crtc_reg = regbase + 0x1240;
         |                            ^~~~~~~
   arch/loongarch/pci/pci.c:114:41: note: initialize the variable 'regbase' to silence this warning
     114 |         void __iomem *crtc_reg, *base, *regbase;
         |                                                ^
         |                                                 = NULL
   1 warning generated.


vim +/regbase +122 arch/loongarch/pci/pci.c

95db0c9f526d58 Huacai Chen 2026-03-26  110  
95db0c9f526d58 Huacai Chen 2026-03-26  111  static void loongson_gpu_fixup_dma_hang(struct pci_dev *pdev, bool on)
95db0c9f526d58 Huacai Chen 2026-03-26  112  {
95db0c9f526d58 Huacai Chen 2026-03-26  113  	u32 i, val, count, crtc_offset, device;
95db0c9f526d58 Huacai Chen 2026-03-26  114  	void __iomem *crtc_reg, *base, *regbase;
95db0c9f526d58 Huacai Chen 2026-03-26  115  	static u32 crtc_status[CRTC_NUM_MAX] = { 0 };
95db0c9f526d58 Huacai Chen 2026-03-26  116  
95db0c9f526d58 Huacai Chen 2026-03-26  117  	base = pdev->bus->ops->map_bus(pdev->bus, pdev->devfn + 1, 0);
95db0c9f526d58 Huacai Chen 2026-03-26  118  	device = readw(base + PCI_DEVICE_ID);
95db0c9f526d58 Huacai Chen 2026-03-26  119  
95db0c9f526d58 Huacai Chen 2026-03-26  120  	switch (device) {
95db0c9f526d58 Huacai Chen 2026-03-26  121  	case PCI_DEVICE_ID_LOONGSON_DC2:
95db0c9f526d58 Huacai Chen 2026-03-26 @122  		crtc_reg = regbase + 0x1240;
95db0c9f526d58 Huacai Chen 2026-03-26  123  		crtc_offset = 0x10;
95db0c9f526d58 Huacai Chen 2026-03-26  124  		break;
95db0c9f526d58 Huacai Chen 2026-03-26  125  	case PCI_DEVICE_ID_LOONGSON_DC3:
95db0c9f526d58 Huacai Chen 2026-03-26  126  		crtc_reg = regbase;
95db0c9f526d58 Huacai Chen 2026-03-26  127  		crtc_offset = 0x400;
95db0c9f526d58 Huacai Chen 2026-03-26  128  		break;
c2fa5cb09709c4 Wentao Guan 2026-04-28  129  	default:
c2fa5cb09709c4 Wentao Guan 2026-04-28  130  		return;
c2fa5cb09709c4 Wentao Guan 2026-04-28  131  	}
c2fa5cb09709c4 Wentao Guan 2026-04-28  132  
c2fa5cb09709c4 Wentao Guan 2026-04-28  133  	regbase = ioremap(readq(base + PCI_BASE_ADDRESS_0) & ~0xffull, SZ_64K);
c2fa5cb09709c4 Wentao Guan 2026-04-28  134  	if (!regbase) {
c2fa5cb09709c4 Wentao Guan 2026-04-28  135  		pci_err(pdev, "Failed to ioremap()\n");
c2fa5cb09709c4 Wentao Guan 2026-04-28  136  		return;
95db0c9f526d58 Huacai Chen 2026-03-26  137  	}
95db0c9f526d58 Huacai Chen 2026-03-26  138  
95db0c9f526d58 Huacai Chen 2026-03-26  139  	for (i = 0; i < CRTC_NUM_MAX; i++, crtc_reg += crtc_offset) {
95db0c9f526d58 Huacai Chen 2026-03-26  140  		val = readl(crtc_reg);
95db0c9f526d58 Huacai Chen 2026-03-26  141  
95db0c9f526d58 Huacai Chen 2026-03-26  142  		if (!on)
95db0c9f526d58 Huacai Chen 2026-03-26  143  			crtc_status[i] = val;
95db0c9f526d58 Huacai Chen 2026-03-26  144  
95db0c9f526d58 Huacai Chen 2026-03-26  145  		/* No need to fixup if the status is off at startup. */
95db0c9f526d58 Huacai Chen 2026-03-26  146  		if (!(crtc_status[i] & CRTC_OUTPUT_ENABLE))
95db0c9f526d58 Huacai Chen 2026-03-26  147  			continue;
95db0c9f526d58 Huacai Chen 2026-03-26  148  
95db0c9f526d58 Huacai Chen 2026-03-26  149  		if (on)
95db0c9f526d58 Huacai Chen 2026-03-26  150  			val |= CRTC_OUTPUT_ENABLE;
95db0c9f526d58 Huacai Chen 2026-03-26  151  		else
95db0c9f526d58 Huacai Chen 2026-03-26  152  			val &= ~CRTC_OUTPUT_ENABLE;
95db0c9f526d58 Huacai Chen 2026-03-26  153  
95db0c9f526d58 Huacai Chen 2026-03-26  154  		mb();
95db0c9f526d58 Huacai Chen 2026-03-26  155  		writel(val, crtc_reg);
95db0c9f526d58 Huacai Chen 2026-03-26  156  
95db0c9f526d58 Huacai Chen 2026-03-26  157  		for (count = 0; count < 40; count++) {
95db0c9f526d58 Huacai Chen 2026-03-26  158  			val = readl(crtc_reg) & CRTC_OUTPUT_ENABLE;
95db0c9f526d58 Huacai Chen 2026-03-26  159  			if ((on && val) || (!on && !val))
95db0c9f526d58 Huacai Chen 2026-03-26  160  				break;
95db0c9f526d58 Huacai Chen 2026-03-26  161  			udelay(1000);
95db0c9f526d58 Huacai Chen 2026-03-26  162  		}
95db0c9f526d58 Huacai Chen 2026-03-26  163  
95db0c9f526d58 Huacai Chen 2026-03-26  164  		pci_info(pdev, "DMA hang fixup at reg[0x%lx]: 0x%x\n",
95db0c9f526d58 Huacai Chen 2026-03-26  165  				(unsigned long)crtc_reg & 0xffff, readl(crtc_reg));
95db0c9f526d58 Huacai Chen 2026-03-26  166  	}
95db0c9f526d58 Huacai Chen 2026-03-26  167  
95db0c9f526d58 Huacai Chen 2026-03-26  168  	iounmap(regbase);
95db0c9f526d58 Huacai Chen 2026-03-26  169  }
95db0c9f526d58 Huacai Chen 2026-03-26  170  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

