Return-Path: <stable+bounces-191488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB98C1508C
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 15:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 006114F20BB
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404652E62C7;
	Tue, 28 Oct 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZzFMTol"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77624676A;
	Tue, 28 Oct 2025 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660082; cv=none; b=JZUxbBwiSGuaZRkIVuYZ9nA87W8hO5tLhxbuWc0AG6Fbl2p7SGURIFRWXvE1r9JmumG/UfuoPGU7h3Jh6WTA8FuDiBoyMilqnePS3qdj9ryBBGHmR5+Cu3vhHoi4BRwPR45v5it9JdE9lZ14cNVigUQHMHTOVeGoAiaNO6pvxJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660082; c=relaxed/simple;
	bh=Q+JKkHpI7G2bnBrn++zkM52PKJ8LvFbwXnn+LgOzPvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1CT7cFxQ9+wN3OB80yh/FMZdhwjdzEW+yHAtX2xLdnn7K4cYsLJk5bG4I8KI2FIljJ5traeAe6Gj+KwW1QbkbJCklRDDI/+6eR80yUhXm5xJvNRIYYMtMi1CvrJfxqksQnYiDoM7cIk2+lcWqlWhvwhTeex914HSj0mma+UZ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZzFMTol; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761660079; x=1793196079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q+JKkHpI7G2bnBrn++zkM52PKJ8LvFbwXnn+LgOzPvI=;
  b=nZzFMTolApOFVvhgKjn/dOdxyXlANIJL+OILDq05KFMqxnZkzBw9Aojh
   /Zo8JhtcOTxEd3YzgNH5D9eylUYvc2lggIuxTB7A+oFZyPE/C+hb/+yYW
   zyRVSVv8HyLDkQ9zmLzf8Ed4yKfdJUBBNrsuZ5iKIuksMN1Pqky0S4roV
   5LhvtEkMNsakaf6DcHOROjoQa1a+CYjK+JpVHfCxmNRwDaRloYtV5GyCc
   T9KKEosGKkmzybltOvX/ss3NrO9YFSJIVFiRDMKNLss3hfQ3BeBeNvKLL
   EZghlEh9IjNqrAYx/6Y5/MiawPitUoE4OUX7xGpusBHRc58Wx+seIvi1i
   g==;
X-CSE-ConnectionGUID: +SrZZ8YkQ769aVaX0VCyBA==
X-CSE-MsgGUID: TjHfzLu4Tj+B3oRcQhVJ2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63667220"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63667220"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:01:19 -0700
X-CSE-ConnectionGUID: u16gAOxzRcO5A15rT/ulKQ==
X-CSE-MsgGUID: dCJ8mXX6S42gCVfap5q90Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="208948271"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 28 Oct 2025 07:01:12 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDkG6-000JBZ-0W;
	Tue, 28 Oct 2025 14:01:10 +0000
Date: Tue, 28 Oct 2025 22:00:31 +0800
From: kernel test robot <lkp@intel.com>
To: Miaoqian Lin <linmq006@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
	Philippe Cornu <philippe.cornu@st.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linmq006@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/of: Fix device node reference leak in
 drm_of_panel_bridge_remove
Message-ID: <202510282123.AjUbRs11-lkp@intel.com>
References: <20251028060918.65688-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028060918.65688-1-linmq006@gmail.com>

Hi Miaoqian,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.18-rc3 next-20251028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miaoqian-Lin/drm-of-Fix-device-node-reference-leak-in-drm_of_panel_bridge_remove/20251028-141134
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251028060918.65688-1-linmq006%40gmail.com
patch subject: [PATCH] drm/of: Fix device node reference leak in drm_of_panel_bridge_remove
config: mips-randconfig-r072-20251028 (https://download.01.org/0day-ci/archive/20251028/202510282123.AjUbRs11-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project e1ae12640102fd2b05bc567243580f90acb1135f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510282123.AjUbRs11-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510282123.AjUbRs11-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/drm_bridge.c:37:
>> include/drm/drm_of.h:174:2: error: call to undeclared function 'of_node_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     174 |         of_node_put(remote);
         |         ^
   1 error generated.
--
   In file included from drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c:10:
>> include/drm/drm_of.h:174:2: error: call to undeclared function 'of_node_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     174 |         of_node_put(remote);
         |         ^
   In file included from drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c:13:
   In file included from include/linux/backlight.h:13:
   In file included from include/linux/fb.h:5:
   In file included from include/uapi/linux/fb.h:6:
   In file included from include/linux/i2c.h:21:
   In file included from include/linux/irqdomain.h:14:
>> include/linux/of.h:129:13: error: conflicting types for 'of_node_put'
     129 | extern void of_node_put(struct device_node *node);
         |             ^
   include/drm/drm_of.h:174:2: note: previous implicit declaration is here
     174 |         of_node_put(remote);
         |         ^
   2 errors generated.


vim +/of_node_put +174 include/drm/drm_of.h

   153	
   154	/*
   155	 * drm_of_panel_bridge_remove - remove panel bridge
   156	 * @np: device tree node containing panel bridge output ports
   157	 *
   158	 * Remove the panel bridge of a given DT node's port and endpoint number
   159	 *
   160	 * Returns zero if successful, or one of the standard error codes if it fails.
   161	 */
   162	static inline int drm_of_panel_bridge_remove(const struct device_node *np,
   163						     int port, int endpoint)
   164	{
   165	#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
   166		struct drm_bridge *bridge;
   167		struct device_node *remote;
   168	
   169		remote = of_graph_get_remote_node(np, port, endpoint);
   170		if (!remote)
   171			return -ENODEV;
   172	
   173		bridge = of_drm_find_bridge(remote);
 > 174		of_node_put(remote);
   175		drm_panel_bridge_remove(bridge);
   176	
   177		return 0;
   178	#else
   179		return -EINVAL;
   180	#endif
   181	}
   182	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

