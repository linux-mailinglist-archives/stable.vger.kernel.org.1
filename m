Return-Path: <stable+bounces-254465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AjQD2VUFmo+lQcAu9opvQ
	(envelope-from <stable+bounces-254465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:18:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8CE5DE806
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 04:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE2DA302000F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 02:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E0432E6BC;
	Wed, 27 May 2026 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Knfu5Z3G"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F9273D76;
	Wed, 27 May 2026 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779848290; cv=none; b=VfZ4ME/cLjyycdyVM/xSJOkjils4siSdqK/4phIj0SM2+jgMLCcxa6PvYc598wBabSnfh14PiVjVmPfA/ZEm0GDz6tr00Nrcp1VBV71ZKD9LygcxBliduOYGDNqThjOLMaVNWI3kAN+c/MfoP8sTTIRNk/ytUFJvMYSNxPF2TyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779848290; c=relaxed/simple;
	bh=TMbvDbgUTPtTslZr8H7vu38wbe3gX1dFPoU4U/gtd6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5f48Unw3oZE9pDdTYhpWrbITOI3WRgsL0oBL/sS8lG1xrGLr2GPjUa1xRS/kT9bsNtaOpS9IkuQGbAeXlyvMLdgWWejVOFY0+IIpJucVWHiob93nTzWXdGHtSnEQpnvtpJeVqF7NIMpx1bSprRmIZmGLGWtSCogcyDB1ZEDqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Knfu5Z3G; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779848287; x=1811384287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TMbvDbgUTPtTslZr8H7vu38wbe3gX1dFPoU4U/gtd6g=;
  b=Knfu5Z3GyTKNOOOYcPKgbSqeAfM1Lf7SH/xX4oiVrIIOrMRz7u1pNJbD
   MDuS0lUKwsof31L0mnNsHOc4iJ3qjZKHE9gmzq+p/Wysndpf18ErKwHN8
   GM5HYFfLlJI/Ai7bLRI+9TM9A+v36JdfSoizO4eDntY/p5oLRkcol8YfG
   wCxvOS2tIsiWztuARREsXkmy6WOdS9UZ9Nk53GFB5RzxZrS5onja+jAoz
   TYcZxYmazyf39STc24r7uEM4176qHR7ab0wUEGAtTRjr6t8wnJRDdkR+m
   AjUaUQYp+W0TrKpTD4KrJ6iLcVWRi1vA4UpI4jLGiXTKLmQGB0sWWwO8L
   Q==;
X-CSE-ConnectionGUID: qoluhhBhRGqLI724/FXWvQ==
X-CSE-MsgGUID: 86gCkuyIR+OmF3DEEU35Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80521590"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80521590"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 19:18:06 -0700
X-CSE-ConnectionGUID: jA4+a52cRA6gVLIwhVEiIg==
X-CSE-MsgGUID: e4yCOGUFRruRmSukACaMpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="242262078"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 May 2026 19:18:02 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wS3qI-000000003G2-01vc;
	Wed, 27 May 2026 02:17:58 +0000
Date: Wed, 27 May 2026 10:17:16 +0800
From: kernel test robot <lkp@intel.com>
To: Myeonghun Pak <mhun512@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>, stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] drm/meson: clean up KMS polling on register failure
Message-ID: <202605271010.KFK2tlLa-lkp@intel.com>
References: <20260524160657.17802-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260524160657.17802-1-mhun512@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,baylibre.com,googlemail.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-254465-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linaro.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 7B8CE5DE806
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Myeonghun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v7.1-rc5 next-20260526]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Myeonghun-Pak/drm-meson-clean-up-KMS-polling-on-register-failure/20260525-000807
base:   https://gitlab.freedesktop.org/drm/misc/kernel.git drm-misc-next
patch link:    https://lore.kernel.org/r/20260524160657.17802-1-mhun512%40gmail.com
patch subject: [PATCH] drm/meson: clean up KMS polling on register failure
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260527/202605271010.KFK2tlLa-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260527/202605271010.KFK2tlLa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605271010.KFK2tlLa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/meson/meson_drv.c:363:1: warning: unused label 'uninstall_irq' [-Wunused-label]
     363 | uninstall_irq:
         | ^~~~~~~~~~~~~~
   1 warning generated.


vim +/uninstall_irq +363 drivers/gpu/drm/meson/meson_drv.c

8976eeee8de05f1 Neil Armstrong        2020-04-28  180  
8604889f83381ca Neil Armstrong        2017-05-29  181  static int meson_drv_bind_master(struct device *dev, bool has_components)
bbbe775ec5b5dac Neil Armstrong        2016-11-10  182  {
a41e82e6c4575b6 Neil Armstrong        2017-04-04  183  	struct platform_device *pdev = to_platform_device(dev);
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  184  	const struct meson_drm_match_data *match;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  185  	struct meson_drm *priv;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  186  	struct drm_device *drm;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  187  	struct resource *res;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  188  	void __iomem *regs;
8976eeee8de05f1 Neil Armstrong        2020-04-28  189  	int ret, i;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  190  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  191  	/* Checks if an output connector is available */
bbbe775ec5b5dac Neil Armstrong        2016-11-10  192  	if (!meson_vpu_has_available_connectors(dev)) {
bbbe775ec5b5dac Neil Armstrong        2016-11-10  193  		dev_err(dev, "No output connector available\n");
bbbe775ec5b5dac Neil Armstrong        2016-11-10  194  		return -ENODEV;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  195  	}
bbbe775ec5b5dac Neil Armstrong        2016-11-10  196  
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  197  	match = of_device_get_match_data(dev);
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  198  	if (!match)
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  199  		return -ENODEV;
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  200  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  201  	drm = drm_dev_alloc(&meson_driver, dev);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  202  	if (IS_ERR(drm))
bbbe775ec5b5dac Neil Armstrong        2016-11-10  203  		return PTR_ERR(drm);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  204  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  205  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  206  	if (!priv) {
bbbe775ec5b5dac Neil Armstrong        2016-11-10  207  		ret = -ENOMEM;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  208  		goto free_drm;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  209  	}
bbbe775ec5b5dac Neil Armstrong        2016-11-10  210  	drm->dev_private = priv;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  211  	priv->drm = drm;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  212  	priv->dev = dev;
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  213  	priv->compat = match->compat;
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  214  	priv->afbcd.ops = match->afbcd_ops;
528a25d040bc212 Julien Masson         2019-08-22  215  
d4cb82aa2e4bc0e Cai Huoqing           2021-08-31  216  	regs = devm_platform_ioremap_resource_byname(pdev, "vpu");
2c18107b9d58972 Christophe JAILLET    2018-03-12  217  	if (IS_ERR(regs)) {
2c18107b9d58972 Christophe JAILLET    2018-03-12  218  		ret = PTR_ERR(regs);
2c18107b9d58972 Christophe JAILLET    2018-03-12  219  		goto free_drm;
2c18107b9d58972 Christophe JAILLET    2018-03-12  220  	}
bbbe775ec5b5dac Neil Armstrong        2016-11-10  221  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  222  	priv->io_base = regs;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  223  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  224  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
01a9e9493fb3f65 Christophe JAILLET    2018-06-11  225  	if (!res) {
01a9e9493fb3f65 Christophe JAILLET    2018-06-11  226  		ret = -EINVAL;
01a9e9493fb3f65 Christophe JAILLET    2018-06-11  227  		goto free_drm;
01a9e9493fb3f65 Christophe JAILLET    2018-06-11  228  	}
bbbe775ec5b5dac Neil Armstrong        2016-11-10  229  	/* Simply ioremap since it may be a shared register zone */
bbbe775ec5b5dac Neil Armstrong        2016-11-10  230  	regs = devm_ioremap(dev, res->start, resource_size(res));
2c18107b9d58972 Christophe JAILLET    2018-03-12  231  	if (!regs) {
2c18107b9d58972 Christophe JAILLET    2018-03-12  232  		ret = -EADDRNOTAVAIL;
2c18107b9d58972 Christophe JAILLET    2018-03-12  233  		goto free_drm;
2c18107b9d58972 Christophe JAILLET    2018-03-12  234  	}
bbbe775ec5b5dac Neil Armstrong        2016-11-10  235  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  236  	priv->hhi = devm_regmap_init_mmio(dev, regs,
bbbe775ec5b5dac Neil Armstrong        2016-11-10  237  					  &meson_regmap_config);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  238  	if (IS_ERR(priv->hhi)) {
bbbe775ec5b5dac Neil Armstrong        2016-11-10  239  		dev_err(&pdev->dev, "Couldn't create the HHI regmap\n");
2c18107b9d58972 Christophe JAILLET    2018-03-12  240  		ret = PTR_ERR(priv->hhi);
2c18107b9d58972 Christophe JAILLET    2018-03-12  241  		goto free_drm;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  242  	}
bbbe775ec5b5dac Neil Armstrong        2016-11-10  243  
66cae477c380d1a Maxime Jourdan        2018-11-05  244  	priv->canvas = meson_canvas_get(dev);
2bf6b5b0e374fcc Maxime Jourdan        2019-03-11  245  	if (IS_ERR(priv->canvas)) {
2bf6b5b0e374fcc Maxime Jourdan        2019-03-11  246  		ret = PTR_ERR(priv->canvas);
2bf6b5b0e374fcc Maxime Jourdan        2019-03-11  247  		goto free_drm;
2bf6b5b0e374fcc Maxime Jourdan        2019-03-11  248  	}
2bf6b5b0e374fcc Maxime Jourdan        2019-03-11  249  
66cae477c380d1a Maxime Jourdan        2018-11-05  250  	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
66cae477c380d1a Maxime Jourdan        2018-11-05  251  	if (ret)
66cae477c380d1a Maxime Jourdan        2018-11-05  252  		goto free_drm;
f9a2348196d1ab9 Neil Armstrong        2018-11-06  253  	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_0);
a695949b2e9bb6b Yao Zi                2024-07-03  254  	if (ret)
a695949b2e9bb6b Yao Zi                2024-07-03  255  		goto free_canvas_osd1;
f9a2348196d1ab9 Neil Armstrong        2018-11-06  256  	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_1);
a695949b2e9bb6b Yao Zi                2024-07-03  257  	if (ret)
a695949b2e9bb6b Yao Zi                2024-07-03  258  		goto free_canvas_vd1_0;
f9a2348196d1ab9 Neil Armstrong        2018-11-06  259  	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_2);
a695949b2e9bb6b Yao Zi                2024-07-03  260  	if (ret)
a695949b2e9bb6b Yao Zi                2024-07-03  261  		goto free_canvas_vd1_1;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  262  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  263  	priv->vsync_irq = platform_get_irq(pdev, 0);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  264  
e770f6bf18182bc Christophe JAILLET    2018-03-12  265  	ret = drm_vblank_init(drm, 1);
e770f6bf18182bc Christophe JAILLET    2018-03-12  266  	if (ret)
a695949b2e9bb6b Yao Zi                2024-07-03  267  		goto free_canvas_vd1_2;
e770f6bf18182bc Christophe JAILLET    2018-03-12  268  
8976eeee8de05f1 Neil Armstrong        2020-04-28  269  	/* Assign limits per soc revision/package */
8976eeee8de05f1 Neil Armstrong        2020-04-28  270  	for (i = 0 ; i < ARRAY_SIZE(meson_drm_soc_attrs) ; ++i) {
8976eeee8de05f1 Neil Armstrong        2020-04-28  271  		if (soc_device_match(meson_drm_soc_attrs[i].attrs)) {
8976eeee8de05f1 Neil Armstrong        2020-04-28  272  			priv->limits = &meson_drm_soc_attrs[i].limits;
8976eeee8de05f1 Neil Armstrong        2020-04-28  273  			break;
8976eeee8de05f1 Neil Armstrong        2020-04-28  274  		}
8976eeee8de05f1 Neil Armstrong        2020-04-28  275  	}
8976eeee8de05f1 Neil Armstrong        2020-04-28  276  
6848c291a54f8cd Thomas Zimmermann     2021-04-12  277  	/*
6848c291a54f8cd Thomas Zimmermann     2021-04-12  278  	 * Remove early framebuffers (ie. simplefb). The framebuffer can be
6848c291a54f8cd Thomas Zimmermann     2021-04-12  279  	 * located anywhere in RAM
6848c291a54f8cd Thomas Zimmermann     2021-04-12  280  	 */
736db96696b6232 Thomas Zimmermann     2024-09-30  281  	ret = aperture_remove_all_conflicting_devices(meson_driver.name);
6848c291a54f8cd Thomas Zimmermann     2021-04-12  282  	if (ret)
a695949b2e9bb6b Yao Zi                2024-07-03  283  		goto free_canvas_vd1_2;
e3de0aa6c9afdca Maxime Jourdan        2018-12-10  284  
bd9ff7b521a647a Simona Vetter         2020-03-23  285  	ret = drmm_mode_config_init(drm);
bd9ff7b521a647a Simona Vetter         2020-03-23  286  	if (ret)
a695949b2e9bb6b Yao Zi                2024-07-03  287  		goto free_canvas_vd1_2;
a41e82e6c4575b6 Neil Armstrong        2017-04-04  288  	drm->mode_config.max_width = 3840;
a41e82e6c4575b6 Neil Armstrong        2017-04-04  289  	drm->mode_config.max_height = 2160;
a41e82e6c4575b6 Neil Armstrong        2017-04-04  290  	drm->mode_config.funcs = &meson_mode_config_funcs;
ce0210c12433031 Neil Armstrong        2019-01-14  291  	drm->mode_config.helper_private	= &meson_mode_config_helpers;
a41e82e6c4575b6 Neil Armstrong        2017-04-04  292  
a41e82e6c4575b6 Neil Armstrong        2017-04-04  293  	/* Hardware Initialization */
a41e82e6c4575b6 Neil Armstrong        2017-04-04  294  
09762525d6eafb3 Neil Armstrong        2017-12-06  295  	meson_vpu_init(priv);
a41e82e6c4575b6 Neil Armstrong        2017-04-04  296  	meson_venc_init(priv);
a41e82e6c4575b6 Neil Armstrong        2017-04-04  297  	meson_vpp_init(priv);
a41e82e6c4575b6 Neil Armstrong        2017-04-04  298  	meson_viu_init(priv);
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  299  	if (priv->afbcd.ops) {
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  300  		ret = priv->afbcd.ops->init(priv);
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  301  		if (ret)
a695949b2e9bb6b Yao Zi                2024-07-03  302  			goto free_canvas_vd1_2;
d1b5e41e13a7e9b Neil Armstrong        2019-10-21  303  	}
bbbe775ec5b5dac Neil Armstrong        2016-11-10  304  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  305  	/* Encoder Initialization */
bbbe775ec5b5dac Neil Armstrong        2016-11-10  306  
1a9e51bef89af0f Martin Blumenstingl   2024-02-18  307  	ret = meson_encoder_cvbs_probe(priv);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  308  	if (ret)
fa747d75f65d1b1 Martin Blumenstingl   2021-12-31  309  		goto exit_afbcd;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  310  
8604889f83381ca Neil Armstrong        2017-05-29  311  	if (has_components) {
6a044642988b5f8 Neil Armstrong        2023-05-30  312  		ret = component_bind_all(dev, drm);
a41e82e6c4575b6 Neil Armstrong        2017-04-04  313  		if (ret) {
a41e82e6c4575b6 Neil Armstrong        2017-04-04  314  			dev_err(drm->dev, "Couldn't bind all components\n");
6a044642988b5f8 Neil Armstrong        2023-05-30  315  			/* Do not try to unbind */
6a044642988b5f8 Neil Armstrong        2023-05-30  316  			has_components = false;
fa747d75f65d1b1 Martin Blumenstingl   2021-12-31  317  			goto exit_afbcd;
a41e82e6c4575b6 Neil Armstrong        2017-04-04  318  		}
8604889f83381ca Neil Armstrong        2017-05-29  319  	}
bbbe775ec5b5dac Neil Armstrong        2016-11-10  320  
1a9e51bef89af0f Martin Blumenstingl   2024-02-18  321  	ret = meson_encoder_hdmi_probe(priv);
e67f6037ae1be34 Neil Armstrong        2021-10-20  322  	if (ret)
6a044642988b5f8 Neil Armstrong        2023-05-30  323  		goto exit_afbcd;
e67f6037ae1be34 Neil Armstrong        2021-10-20  324  
42dcf15f901c822 Neil Armstrong        2023-05-30  325  	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A)) {
1a9e51bef89af0f Martin Blumenstingl   2024-02-18  326  		ret = meson_encoder_dsi_probe(priv);
42dcf15f901c822 Neil Armstrong        2023-05-30  327  		if (ret)
42dcf15f901c822 Neil Armstrong        2023-05-30  328  			goto exit_afbcd;
42dcf15f901c822 Neil Armstrong        2023-05-30  329  	}
42dcf15f901c822 Neil Armstrong        2023-05-30  330  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  331  	ret = meson_plane_create(priv);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  332  	if (ret)
6a044642988b5f8 Neil Armstrong        2023-05-30  333  		goto exit_afbcd;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  334  
f9a2348196d1ab9 Neil Armstrong        2018-11-06  335  	ret = meson_overlay_create(priv);
f9a2348196d1ab9 Neil Armstrong        2018-11-06  336  	if (ret)
6a044642988b5f8 Neil Armstrong        2023-05-30  337  		goto exit_afbcd;
f9a2348196d1ab9 Neil Armstrong        2018-11-06  338  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  339  	ret = meson_crtc_create(priv);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  340  	if (ret)
6a044642988b5f8 Neil Armstrong        2023-05-30  341  		goto exit_afbcd;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  342  
65a969655cb91fa Thomas Zimmermann     2021-07-06  343  	ret = request_irq(priv->vsync_irq, meson_irq, 0, drm->driver->name, drm);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  344  	if (ret)
6a044642988b5f8 Neil Armstrong        2023-05-30  345  		goto exit_afbcd;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  346  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  347  	drm_mode_config_reset(drm);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  348  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  349  	drm_kms_helper_poll_init(drm);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  350  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  351  	platform_set_drvdata(pdev, priv);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  352  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  353  	ret = drm_dev_register(drm, 0);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  354  	if (ret)
e31803f51415af4 Myeonghun Pak         2026-05-25  355  		goto uninstall_poll;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  356  
57a03512c49a2e3 Thomas Zimmermann     2024-09-24  357  	drm_client_setup(drm, NULL);
efbb9df91e03b31 Noralf Trønnes        2018-09-08  358  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  359  	return 0;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  360  
e31803f51415af4 Myeonghun Pak         2026-05-25  361  uninstall_poll:
e31803f51415af4 Myeonghun Pak         2026-05-25  362  	drm_kms_helper_poll_fini(drm);
2d8f92897ad816f Jean-Philippe Brucker 2019-03-22 @363  uninstall_irq:
65a969655cb91fa Thomas Zimmermann     2021-07-06  364  	free_irq(priv->vsync_irq, drm);
fa747d75f65d1b1 Martin Blumenstingl   2021-12-31  365  exit_afbcd:
fa747d75f65d1b1 Martin Blumenstingl   2021-12-31  366  	if (priv->afbcd.ops)
fa747d75f65d1b1 Martin Blumenstingl   2021-12-31  367  		priv->afbcd.ops->exit(priv);
a695949b2e9bb6b Yao Zi                2024-07-03  368  free_canvas_vd1_2:
a695949b2e9bb6b Yao Zi                2024-07-03  369  	meson_canvas_free(priv->canvas, priv->canvas_id_vd1_2);
a695949b2e9bb6b Yao Zi                2024-07-03  370  free_canvas_vd1_1:
a695949b2e9bb6b Yao Zi                2024-07-03  371  	meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
a695949b2e9bb6b Yao Zi                2024-07-03  372  free_canvas_vd1_0:
a695949b2e9bb6b Yao Zi                2024-07-03  373  	meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
a695949b2e9bb6b Yao Zi                2024-07-03  374  free_canvas_osd1:
a695949b2e9bb6b Yao Zi                2024-07-03  375  	meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  376  free_drm:
dcacf65139e3def Christophe JAILLET    2018-03-12  377  	drm_dev_put(drm);
bbbe775ec5b5dac Neil Armstrong        2016-11-10  378  
42dcf15f901c822 Neil Armstrong        2023-05-30  379  	meson_encoder_dsi_remove(priv);
6a044642988b5f8 Neil Armstrong        2023-05-30  380  	meson_encoder_hdmi_remove(priv);
6a044642988b5f8 Neil Armstrong        2023-05-30  381  	meson_encoder_cvbs_remove(priv);
6a044642988b5f8 Neil Armstrong        2023-05-30  382  
6a044642988b5f8 Neil Armstrong        2023-05-30  383  	if (has_components)
6a044642988b5f8 Neil Armstrong        2023-05-30  384  		component_unbind_all(dev, drm);
6a044642988b5f8 Neil Armstrong        2023-05-30  385  
bbbe775ec5b5dac Neil Armstrong        2016-11-10  386  	return ret;
bbbe775ec5b5dac Neil Armstrong        2016-11-10  387  }
bbbe775ec5b5dac Neil Armstrong        2016-11-10  388  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

