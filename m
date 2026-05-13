Return-Path: <stable+bounces-246718-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE1RKf3nA2q6AAIAu9opvQ
	(envelope-from <stable+bounces-246718-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 04:54:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D552C736
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 04:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AE1330128D7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 02:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE2A39061A;
	Wed, 13 May 2026 02:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HY7FEwZ9"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02874145B11;
	Wed, 13 May 2026 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640821; cv=none; b=CNPvuKyQHI1nGbKT/5aQXFKdcICRN1g9HalmMTLEsZdL7baHyQzqS3NzzvdZpPPEkNtfSahSNVqOs/Uo9G+udZcWguvOUavtM8RrHOlybgcVrS6cogzRwMsDrtG/vQbOZbp96cjbSmbxPLGI/1CDBJAotmCJ4JsEr1OqYSTpDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640821; c=relaxed/simple;
	bh=gktVRTQwx0kuPYssen49JKdkggZ0ZSpaMiBgWqEuarg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lh7KV5SIb3k2APdILgEh+XHDpMYA65usUn1gNmfDqcwHXMeDfdX0gZ1qG92M9orpRLAzF8v8geGjjHoKnNa911xslbkI3VZfO77d4vpQwAb8v6ucarVSoz0ZXNRfQ7EGdWshGlt4Ko3Yu9jYSqAZT7JJ3B4aVFf/pcSfjngELls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HY7FEwZ9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778640819; x=1810176819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gktVRTQwx0kuPYssen49JKdkggZ0ZSpaMiBgWqEuarg=;
  b=HY7FEwZ9BSJZ3wyQ2pgWHa3W4I3+D1se5EH5yQnd/ztRou7dUNvvnM6h
   bzAsbK7i60MRjdM1G2+C81hwwsD1A4GHZ8h1IAdoqs6E9RABFQMDAOivO
   s9s0EHnK8xQfQE+2pW/9WL+W1py43UwQPd2prtjGPPnJTIy1WlSjA51Nu
   K9tGnM1zjb392YYlHKck5/0nObdkImsNtBalf8AIX9UPur+TFHVyIIsTa
   w0qf8wv3Qe0fMp1sc0Gd5E4vau4TXEjwKs/C0RRBGu/Css0x7nm1cguiv
   ZQ8EHPQt9uDxCX9Mv7MePgkz7Q4grqtAKSe3a/zKY6xFGuqq3NBV/nI+a
   g==;
X-CSE-ConnectionGUID: ypzjrFzDT1euHWjinAvl+Q==
X-CSE-MsgGUID: AnS1phyeR/2K1F7Qv94n3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79738483"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79738483"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 19:53:39 -0700
X-CSE-ConnectionGUID: ZtxaRZz2TcOFTzfqBh/Dpg==
X-CSE-MsgGUID: YNhP+ZQbRe2VbetB28kmwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="235282242"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 12 May 2026 19:53:36 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMzj3-000000003G7-07sR;
	Wed, 13 May 2026 02:53:33 +0000
Date: Wed, 13 May 2026 10:52:57 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, linux@armlinux.org.uk,
	airlied@gmail.com, simona@ffwll.ch
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/armada: fix device_node reference leak in
 armada_lcd_bind()
Message-ID: <202605131053.Tvq0phKC-lkp@intel.com>
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
X-Rspamd-Queue-Id: 2E6D552C736
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246718-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[iscas.ac.cn,armlinux.org.uk,gmail.com,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,git-scm.com:url,01.org:url]
X-Rspamd-Action: no action

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on daeinki-drm-exynos/exynos-drm-next]
[also build test ERROR on drm/drm-next drm-i915/for-linux-next drm-i915/for-linux-next-fixes drm-misc/drm-misc-next drm-tip/drm-tip linus/master rmk-arm/drm-armada-devel v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/drm-armada-fix-device_node-reference-leak-in-armada_lcd_bind/20260512-194755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git exynos-drm-next
patch link:    https://lore.kernel.org/r/20260509091821.963513-1-vulab%40iscas.ac.cn
patch subject: [PATCH] drm/armada: fix device_node reference leak in armada_lcd_bind()
config: arm-randconfig-003-20260512 (https://download.01.org/0day-ci/archive/20260513/202605131053.Tvq0phKC-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131053.Tvq0phKC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131053.Tvq0phKC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/armada/armada_crtc.c:1039:2: error: use of undeclared identifier 'ret'; did you mean 'res'?
    1039 |         ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
         |         ^~~
         |         res
   drivers/gpu/drm/armada/armada_crtc.c:1013:19: note: 'res' declared here
    1013 |         struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         |                          ^
>> drivers/gpu/drm/armada/armada_crtc.c:1039:6: error: incompatible integer to pointer conversion assigning to 'struct resource *' from 'int' [-Wint-conversion]
    1039 |         ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/armada/armada_crtc.c:1040:6: error: use of undeclared identifier 'ret'; did you mean 'res'?
    1040 |         if (ret)
         |             ^~~
         |             res
   drivers/gpu/drm/armada/armada_crtc.c:1013:19: note: 'res' declared here
    1013 |         struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         |                          ^
   drivers/gpu/drm/armada/armada_crtc.c:1042:9: error: use of undeclared identifier 'ret'; did you mean 'res'?
    1042 |         return ret;
         |                ^~~
         |                res
   drivers/gpu/drm/armada/armada_crtc.c:1013:19: note: 'res' declared here
    1013 |         struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
         |                          ^
>> drivers/gpu/drm/armada/armada_crtc.c:1042:9: error: incompatible pointer to integer conversion returning 'struct resource *' from a function with result type 'int' [-Wint-conversion]
    1042 |         return ret;
         |                ^~~
   5 errors generated.


vim +1039 drivers/gpu/drm/armada/armada_crtc.c

  1007	
  1008	static int
  1009	armada_lcd_bind(struct device *dev, struct device *master, void *data)
  1010	{
  1011		struct platform_device *pdev = to_platform_device(dev);
  1012		struct drm_device *drm = data;
  1013		struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
  1014		int irq = platform_get_irq(pdev, 0);
  1015		const struct armada_variant *variant;
  1016		struct device_node *port = NULL;
  1017		struct device_node *np, *parent = dev->of_node;
  1018	
  1019		if (irq < 0)
  1020			return irq;
  1021	
  1022	
  1023		variant = device_get_match_data(dev);
  1024		if (!variant)
  1025			return -ENXIO;
  1026	
  1027		if (parent) {
  1028			np = of_get_child_by_name(parent, "ports");
  1029			if (np)
  1030				parent = np;
  1031			port = of_get_child_by_name(parent, "port");
  1032			of_node_put(np);
  1033			if (!port) {
  1034				dev_err(dev, "no port node found in %pOF\n", parent);
  1035				return -ENXIO;
  1036			}
  1037		}
  1038	
> 1039		ret = armada_drm_crtc_create(drm, dev, res, irq, variant, port);
  1040		if (ret)
  1041			of_node_put(port);
> 1042		return ret;
  1043	}
  1044	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

