Return-Path: <stable+bounces-195140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAECCC6C5C0
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 03:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 88F5B2C7CA
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB6281357;
	Wed, 19 Nov 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxRFVSeE"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C4283FCD;
	Wed, 19 Nov 2025 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763518790; cv=none; b=iJz8WaiQ3qcffqWB0TqoS5pD96RcFwPXtsXSTOGKieyMp1nkZyokazf9k97HKL2qqDMvvBQP48vtFKXT1qBIOVZQaFXlGyHZ7eR2R/BYONi1XH1X+RnuNmM2kaKo5rZ71v2Lyv5ogwh1mWxrfNzyR3ovk9xBWdJ0de2k6WZic8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763518790; c=relaxed/simple;
	bh=4f7gJIQWgLg8egaLamrLeN6ir5B4LMiYkH+4nMPn5VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlSZcXmd7Xnc9cSoSf+hcihQ6KXY/5pJepSjbRsdm7TW0yZzBkDTq2ffw8K17zRXJ9cjE+2ygXkxh+tkNz6UsgBZtveb6AzWcMH0eg1jgFS37NMZNJYNoOSMokX5edX9dDQuSFNdBs8GtKm7QGER1xGYz9rtpHRgu4IEPSeC//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxRFVSeE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763518789; x=1795054789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4f7gJIQWgLg8egaLamrLeN6ir5B4LMiYkH+4nMPn5VY=;
  b=bxRFVSeEsAdhYmcrYFxgAmWylHlAt59lN8dTcFtiQw/YOIL8FUTUA77p
   EBhc12I9NJ7N9I3cZSkh+13UfhkPdIRKel0RXj/j4bP1x2vr9iqfHszMu
   IzGFDXJfGhvhpNAaP+Q9Bc73/sGOlCU0OPXtPswOFjh03p0+iy4zA6miZ
   mOw5RhtbFacwN4PHm1MAYHK+BOfJj7EkRcsjPeuP8zZq3oXdu3+GpkzVx
   Y2FaHTfP3nH/QkhCyvJEN2RszvwAwvPvSMZjk8LY5qXrwd+tHGVN0yeez
   1MRVyjzm0U+nbVmZH9cT1vRYKnOxeHE1xNPdwSSncANpO3nHq9K32dFyL
   Q==;
X-CSE-ConnectionGUID: VAm/+doqR968fn4TkiEuRg==
X-CSE-MsgGUID: ucZ7wIdzQPG9BK9l9oZulA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="68159912"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="68159912"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 18:19:48 -0800
X-CSE-ConnectionGUID: hKCkixGvSxyEC1c/NN7a4Q==
X-CSE-MsgGUID: wykPRSN6RnmgS5QGq1opmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190723996"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Nov 2025 18:19:43 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLXnJ-0002Lt-0h;
	Wed, 19 Nov 2025 02:19:41 +0000
Date: Wed, 19 Nov 2025 10:19:26 +0800
From: kernel test robot <lkp@intel.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Bajjuri Praneeth <praneeth@ti.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	"Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
	stable@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jyri Sarha <jyri.sarha@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3] drm/tilcdc: Fix removal actions in case of failed
 probe
Message-ID: <202511191009.muedhmup-lkp@intel.com>
References: <20251118133850.125561-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118133850.125561-1-kory.maincent@bootlin.com>

Hi Kory,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.18-rc6 next-20251118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kory-Maincent/drm-tilcdc-Fix-removal-actions-in-case-of-failed-probe/20251118-214022
base:   linus/master
patch link:    https://lore.kernel.org/r/20251118133850.125561-1-kory.maincent%40bootlin.com
patch subject: [PATCH v3] drm/tilcdc: Fix removal actions in case of failed probe
config: arm-randconfig-003-20251119 (https://download.01.org/0day-ci/archive/20251119/202511191009.muedhmup-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 0bba1e76581bad04e7d7f09f5115ae5e2989e0d9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191009.muedhmup-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511191009.muedhmup-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/tilcdc/tilcdc_drv.c:391:1: warning: unused label 'destroy_crtc' [-Wunused-label]
     391 | destroy_crtc:
         | ^~~~~~~~~~~~~
   1 warning generated.


vim +/destroy_crtc +391 drivers/gpu/drm/tilcdc/tilcdc_drv.c

   329	
   330		if (priv->is_componentized) {
   331			ret = component_bind_all(dev, ddev);
   332			if (ret < 0)
   333				goto unregister_cpufreq_notif;
   334	
   335			ret = tilcdc_add_component_encoder(ddev);
   336			if (ret < 0)
   337				goto unbind_component;
   338		} else {
   339			ret = tilcdc_attach_external_device(ddev);
   340			if (ret)
   341				goto unregister_cpufreq_notif;
   342		}
   343	
   344		if (!priv->external_connector &&
   345		    ((priv->num_encoders == 0) || (priv->num_connectors == 0))) {
   346			dev_err(dev, "no encoders/connectors found\n");
   347			ret = -EPROBE_DEFER;
   348			goto unbind_component;
   349		}
   350	
   351		ret = drm_vblank_init(ddev, 1);
   352		if (ret < 0) {
   353			dev_err(dev, "failed to initialize vblank\n");
   354			goto unbind_component;
   355		}
   356	
   357		ret = platform_get_irq(pdev, 0);
   358		if (ret < 0)
   359			goto unbind_component;
   360		priv->irq = ret;
   361	
   362		ret = tilcdc_irq_install(ddev, priv->irq);
   363		if (ret < 0) {
   364			dev_err(dev, "failed to install IRQ handler\n");
   365			goto unbind_component;
   366		}
   367	
   368		drm_mode_config_reset(ddev);
   369	
   370		drm_kms_helper_poll_init(ddev);
   371	
   372		ret = drm_dev_register(ddev, 0);
   373		if (ret)
   374			goto stop_poll;
   375	
   376		drm_client_setup_with_color_mode(ddev, bpp);
   377	
   378		return 0;
   379	
   380	stop_poll:
   381		drm_kms_helper_poll_fini(ddev);
   382		tilcdc_irq_uninstall(ddev);
   383	unbind_component:
   384		if (priv->is_componentized)
   385			component_unbind_all(dev, ddev);
   386	unregister_cpufreq_notif:
   387	#ifdef CONFIG_CPU_FREQ
   388		cpufreq_unregister_notifier(&priv->freq_transition,
   389					    CPUFREQ_TRANSITION_NOTIFIER);
   390	#endif
 > 391	destroy_crtc:
   392		tilcdc_crtc_destroy(priv->crtc);
   393	disable_pm:
   394		pm_runtime_disable(dev);
   395		clk_put(priv->clk);
   396	free_wq:
   397		destroy_workqueue(priv->wq);
   398	put_drm:
   399		platform_set_drvdata(pdev, NULL);
   400		ddev->dev_private = NULL;
   401		drm_dev_put(ddev);
   402	
   403		return ret;
   404	}
   405	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

