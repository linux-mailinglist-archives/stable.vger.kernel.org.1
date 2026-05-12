Return-Path: <stable+bounces-246686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CLqKKSgA2p78QEAu9opvQ
	(envelope-from <stable+bounces-246686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:50:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F852AA01
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8DEC3011564
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 21:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD2738A706;
	Tue, 12 May 2026 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QIEZg6vF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A22D29C8;
	Tue, 12 May 2026 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622611; cv=none; b=ZYb93nka2LRx5qR1Pa6Im1U60bBxddZ8dDVRGhqzrnb9B3EOB+y4bGYm1SeKc6L9wOF1+VeDn9lNDu4YLgnanRVBKWRrD0YZNZ2qbUEcTnJnwo95t/XRe+A8VScXyHw8CT9YOR1rANT9AeXiOdGvNsjYnHcPWkE7AkJvV4kKjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622611; c=relaxed/simple;
	bh=7TCUYNaAC8cK2hOC7Q7WOO0KP2o92/Q696cJKWNFRlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXWP9lMRU/7vykxsrpP/QUcE1gWZ29WccAVeBsJYxKO7zt+RZ+ewWcRGCbVCmS2N6+8FAZ8VKafhYAH8XK1iPw9f3cWrX5hYbEWWttn2kU8PAZEgyhwJ6KzO70KC5WkP9BsJU2pGsDWhsq8cVif1A1+m3N6X3oT34IIV2jH8zdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QIEZg6vF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778622610; x=1810158610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7TCUYNaAC8cK2hOC7Q7WOO0KP2o92/Q696cJKWNFRlc=;
  b=QIEZg6vFXVyAbOmqKoLxPrtgaSLBxoSvs00uMP3WDx8HMnlq9KHyAVHb
   LEGMeqUovTVlT3XrDBO0HWL9EBbFUHwEVyo5fHGFNEqNEw6YtumBUnyIx
   vdthbvLI3EbR076bL0jByZnSmqgWb71VRmAs0tf1wl1SDaxwLjmzG3ARV
   KOVWRDMLfhftH3b45LaFNSjp23dsYor7iajppS5o2Xu1iIN4SCmpn4jOt
   fjTtIz4czkYWDjNZQAHN8HKC06Jllu1JGJsze8QtB/KjMnWqgBGMxqP00
   HfeJyTz3eQRV3M70+hhE0MsKCiujXKUbGdRebqePww9YDwyT9mgxAkcl8
   A==;
X-CSE-ConnectionGUID: 2uE8h0buRNKn+AdjsEGR7A==
X-CSE-MsgGUID: 9Sb/sIrPQmeW+6C4hDLU+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="67068884"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="67068884"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 14:50:09 -0700
X-CSE-ConnectionGUID: VPrZie23RMGzMDiK/XRSuQ==
X-CSE-MsgGUID: BKF1IlxvQzKfXBptR1wqIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="239700291"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 May 2026 14:50:07 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMuzM-000000002s3-3tIf;
	Tue, 12 May 2026 21:50:04 +0000
Date: Wed, 13 May 2026 05:49:50 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, linux@armlinux.org.uk,
	airlied@gmail.com, simona@ffwll.ch
Cc: oe-kbuild-all@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/armada: fix device_node reference leak in
 armada_lcd_bind()
Message-ID: <202605130528.fPiFL3HJ-lkp@intel.com>
References: <20260509091821.963513-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509091821.963513-1-vulab@iscas.ac.cn>
X-Rspamd-Queue-Id: AA1F852AA01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246686-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[iscas.ac.cn,armlinux.org.uk,gmail.com,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,git-scm.com:url,intel.com:email,intel.com:mid,intel.com:dkim,01.org:url]
X-Rspamd-Action: no action

Hi Wentao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on daeinki-drm-exynos/exynos-drm-next]
[also build test WARNING on drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master rmk-arm/drm-armada-devel v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-armada-fix-device_node-reference-leak-in-armada_lcd_bind/20260512-194755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20260509091821.963513-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/armada: fix device_node reference leak in armada_lcd_bind()
config: arm-randconfig-002-20260513 (https://download.01.org/0day-ci/archive/20260513/202605130528.fPiFL3HJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130528.fPiFL3HJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130528.fPiFL3HJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/armada/armada_crtc.c: In function 'armada_lcd_bind':
   drivers/gpu/drm/armada/armada_crtc.c:1039:9: error: 'ret' undeclared (first use in this function); did you mean 'res'?
    1039 |         ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
         |         ^~~
         |         res
   drivers/gpu/drm/armada/armada_crtc.c:1039:9: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/armada/armada_crtc.c:1043:1: warning: control reaches end of non-void function [-Wreturn-type]
    1043 | }
         | ^


vim +1043 drivers/gpu/drm/armada/armada_crtc.c

d8c96083cf5e4a Russell King 2014-04-22  1007  
d8c96083cf5e4a Russell King 2014-04-22  1008  static int
d8c96083cf5e4a Russell King 2014-04-22  1009  armada_lcd_bind(struct device *dev, struct device *master, void *data)
d8c96083cf5e4a Russell King 2014-04-22  1010  {
d8c96083cf5e4a Russell King 2014-04-22  1011  	struct platform_device *pdev = to_platform_device(dev);
d8c96083cf5e4a Russell King 2014-04-22  1012  	struct drm_device *drm = data;
d8c96083cf5e4a Russell King 2014-04-22  1013  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
d8c96083cf5e4a Russell King 2014-04-22  1014  	int irq = platform_get_irq(pdev, 0);
d8c96083cf5e4a Russell King 2014-04-22  1015  	const struct armada_variant *variant;
9611cb93fa65dd Russell King 2014-06-15  1016  	struct device_node *port = NULL;
e1704914867872 Rob Herring  2023-10-20  1017  	struct device_node *np, *parent = dev->of_node;
d8c96083cf5e4a Russell King 2014-04-22  1018  
d8c96083cf5e4a Russell King 2014-04-22  1019  	if (irq < 0)
d8c96083cf5e4a Russell King 2014-04-22  1020  		return irq;
d8c96083cf5e4a Russell King 2014-04-22  1021  
d8c96083cf5e4a Russell King 2014-04-22  1022  
e1704914867872 Rob Herring  2023-10-20  1023  	variant = device_get_match_data(dev);
e1704914867872 Rob Herring  2023-10-20  1024  	if (!variant)
d8c96083cf5e4a Russell King 2014-04-22  1025  		return -ENXIO;
d8c96083cf5e4a Russell King 2014-04-22  1026  
e1704914867872 Rob Herring  2023-10-20  1027  	if (parent) {
9611cb93fa65dd Russell King 2014-06-15  1028  		np = of_get_child_by_name(parent, "ports");
9611cb93fa65dd Russell King 2014-06-15  1029  		if (np)
9611cb93fa65dd Russell King 2014-06-15  1030  			parent = np;
9611cb93fa65dd Russell King 2014-06-15  1031  		port = of_get_child_by_name(parent, "port");
9611cb93fa65dd Russell King 2014-06-15  1032  		of_node_put(np);
9611cb93fa65dd Russell King 2014-06-15  1033  		if (!port) {
4bf99144d2b407 Rob Herring  2017-07-18  1034  			dev_err(dev, "no port node found in %pOF\n", parent);
9611cb93fa65dd Russell King 2014-06-15  1035  			return -ENXIO;
9611cb93fa65dd Russell King 2014-06-15  1036  		}
d8c96083cf5e4a Russell King 2014-04-22  1037  	}
d8c96083cf5e4a Russell King 2014-04-22  1038  
2627b8898b0e61 Wentao Liang 2026-05-09  1039  	ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
2627b8898b0e61 Wentao Liang 2026-05-09  1040  	if (ret)
2627b8898b0e61 Wentao Liang 2026-05-09  1041  		of_node_put(port);
2627b8898b0e61 Wentao Liang 2026-05-09  1042  	return ret;
d8c96083cf5e4a Russell King 2014-04-22 @1043  }
d8c96083cf5e4a Russell King 2014-04-22  1044  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

