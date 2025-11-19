Return-Path: <stable+bounces-195145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AB4C6C8AF
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 04:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BBE74EA72C
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 03:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732C2E5B2E;
	Wed, 19 Nov 2025 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWyVOyGe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B962E5B36;
	Wed, 19 Nov 2025 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763522095; cv=none; b=AefT6DzkL/OLUyHAEgLMPY5buI8ISPgH4y5jRU0M6nrTfCmhPC7Zmp6lgQxBKtB2fx6s/ZJDFquYjvV/JhAR4ljBZk/MfCd+E76+KYGwfa4jq7OQICUuljsarlm4OA7pCCWcA++oK/WNrugGGCPnIhiQT29O71VU3LtbvZyOg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763522095; c=relaxed/simple;
	bh=/ccyBx+YhFT29oQ7gLE2zB60k1DOJq5+Z2PCcK4u/U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLO7Vrhx3ZH5tRROQ9JpgzRtONw/jsMV/bbQ45auggAccqD6bk5CNJrj8WrhwsdlPMgSWYGG4JkBKMbhN8NSGIEjOWFENymPAomnChCYruoUgmnYH/103fJPuT2bI0VF7nwLpwrchXFagn0TRGxtqgtRqG5c3nee04jAZaJcP54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWyVOyGe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763522094; x=1795058094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ccyBx+YhFT29oQ7gLE2zB60k1DOJq5+Z2PCcK4u/U0=;
  b=dWyVOyGeVfUfURXfxaOdj6EW5EQjBO5Rrmv7y6zSYPqQPcbF9HVIigyk
   EntFy0hSWlp3fhRZ00Hq2Rlxj3uWbAbLS/K4phtq7GJlYnsTNVrGVhdmV
   bRD8FFlTznkN6yJ1MReZhtwqSjpY5QL0U+29cV42twbETUSGrx9tgRcwj
   nNEPXE6NJqTkAzzw08B7O2wElA08uxCdpV8TDUDsdHAF/rxIRxtYvFBAT
   9aNs8SWAuED6bU1AXlgot/UIVjsbnlzCNwX593LNXA6W3VehgEJhYgRbA
   ECzS9eMxMBj3jeyU1K/Zk+tSNA4G4InuvNVcWwMvIuhLVaB4hc+KOEuP/
   g==;
X-CSE-ConnectionGUID: 2yLGKPF0TO6woEWW3ekhgg==
X-CSE-MsgGUID: hi+9GJSvQ+md2wPPsfcfzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76166932"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="76166932"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 19:14:53 -0800
X-CSE-ConnectionGUID: nWNx85HhR82WCNMjIbSNpQ==
X-CSE-MsgGUID: nkNp4cycQseSePuC18IcQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190730543"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Nov 2025 19:14:50 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vLYec-0002ON-2s;
	Wed, 19 Nov 2025 03:14:46 +0000
Date: Wed, 19 Nov 2025 11:14:11 +0800
From: kernel test robot <lkp@intel.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Ripard <mripard@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Bajjuri Praneeth <praneeth@ti.com>,
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
Message-ID: <202511191045.bW4DdgHX-lkp@intel.com>
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
config: arm-randconfig-004-20251119 (https://download.01.org/0day-ci/archive/20251119/202511191045.bW4DdgHX-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251119/202511191045.bW4DdgHX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511191045.bW4DdgHX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/tilcdc/tilcdc_drv.c: In function 'tilcdc_init':
>> drivers/gpu/drm/tilcdc/tilcdc_drv.c:391:1: warning: label 'destroy_crtc' defined but not used [-Wunused-label]
     391 | destroy_crtc:
         | ^~~~~~~~~~~~


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

