Return-Path: <stable+bounces-142921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BEEAB02FC
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 20:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7AC50607A
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB36287518;
	Thu,  8 May 2025 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXmT0d0P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5748286D70;
	Thu,  8 May 2025 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729457; cv=none; b=i4diHn7LrbWI/Z/YlFkvg7DLTE0cudrvwqfH+aAwLKCRsyV3x4MkbuRXeLMFsH1xK5CPJjbIJstciOvS3+T9VktD3SfkdX8BacJ9izjxsr2ChlV302twivWnB3Ii9vpQljfjW07/6jtBAJYQaBv4++BNOuAa05f2xjD138/XFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729457; c=relaxed/simple;
	bh=LVtUUN2MrfsyK80smjhH6AaJQhd0Umzk+ryvBq/tDD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EshW895YmGkkiSWYj07fcF1tjFycAGmaB8XOhGbBJL7cC0gHdi+QvMnOtEQ/DwKrVa/6TpNss2Mhm1Z4891BayOZD7aYPyF5d/5LSPLmX/cCrTAouivupIyINYL71MmMwgYgksAdpm6VFhCPiwiWqfL9fLMYqMBizezk2ecCmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXmT0d0P; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746729456; x=1778265456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LVtUUN2MrfsyK80smjhH6AaJQhd0Umzk+ryvBq/tDD0=;
  b=IXmT0d0P9fCKY2BXh3/KgC9I6hBAB+XKPac/Klpq08xyPgWxPokjN/Pl
   2rDdlhwPOUgECqXBsVqS+7T2zuBJld6e78KIGeKVEsLTyTxqHobudHjzr
   8mHOt27TZJ5ug5dzkuRrzgJFhtz45dLyhvT4WyE4EmEhqzhqtM/KgNykz
   iWcQ2dWdQlfHQrTr2WqAI4T5lA4gx3+lrrrQN7/z7EkQtBUwcir2wuelq
   K4ktqu3nT6hQyNqTFakgL7s6uHCbo/isuhZjgOLAWUXvsmKquAtGw5Rbl
   GtkZJX2nt/A+77wn8NVXUwGTxm+rkk20jvjFg3oj5/Ktg33FwoK/T1T+B
   g==;
X-CSE-ConnectionGUID: vYPHGsWyS6G4X/qdwOOGrw==
X-CSE-MsgGUID: b+XNGQQ0T+KWzapp2ljwiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="65949376"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="65949376"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:37:36 -0700
X-CSE-ConnectionGUID: z4vP90/9SX26Xj5i1zn72w==
X-CSE-MsgGUID: JwEnOJrdQlmA6ZPuj15nnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="159678634"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 May 2025 11:37:31 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uD67d-000BGX-17;
	Thu, 08 May 2025 18:37:29 +0000
Date: Fri, 9 May 2025 02:37:04 +0800
From: kernel test robot <lkp@intel.com>
To: Vitor Soares <ivitro@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: oe-kbuild-all@lists.linux.dev, Vitor Soares <vitor.soares@toradex.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Aradhya Bhatia <aradhya.bhatia@linux.dev>,
	Jayesh Choudhary <j-choudhary@ti.com>, ivitro@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: cdns-dsi: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
Message-ID: <202505090233.0YCNNAzE-lkp@intel.com>
References: <20250507161800.527464-1-ivitro@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507161800.527464-1-ivitro@gmail.com>

Hi Vitor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.15-rc5 next-20250508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vitor-Soares/drm-bridge-cdns-dsi-Replace-deprecated-UNIVERSAL_DEV_PM_OPS/20250508-001902
base:   linus/master
patch link:    https://lore.kernel.org/r/20250507161800.527464-1-ivitro%40gmail.com
patch subject: [PATCH v2] drm/bridge: cdns-dsi: Replace deprecated UNIVERSAL_DEV_PM_OPS()
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20250509/202505090233.0YCNNAzE-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250509/202505090233.0YCNNAzE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505090233.0YCNNAzE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c:1148:12: warning: 'cdns_dsi_suspend' defined but not used [-Wunused-function]
    1148 | static int cdns_dsi_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c:1137:12: warning: 'cdns_dsi_resume' defined but not used [-Wunused-function]
    1137 | static int cdns_dsi_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~


vim +/cdns_dsi_suspend +1148 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c

  1136	
> 1137	static int cdns_dsi_resume(struct device *dev)
  1138	{
  1139		struct cdns_dsi *dsi = dev_get_drvdata(dev);
  1140	
  1141		reset_control_deassert(dsi->dsi_p_rst);
  1142		clk_prepare_enable(dsi->dsi_p_clk);
  1143		clk_prepare_enable(dsi->dsi_sys_clk);
  1144	
  1145		return 0;
  1146	}
  1147	
> 1148	static int cdns_dsi_suspend(struct device *dev)
  1149	{
  1150		struct cdns_dsi *dsi = dev_get_drvdata(dev);
  1151	
  1152		clk_disable_unprepare(dsi->dsi_sys_clk);
  1153		clk_disable_unprepare(dsi->dsi_p_clk);
  1154		reset_control_assert(dsi->dsi_p_rst);
  1155		dsi->link_initialized = false;
  1156		return 0;
  1157	}
  1158	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

