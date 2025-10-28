Return-Path: <stable+bounces-191491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E01EC1529A
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 15:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3533A971A
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C9225A39;
	Tue, 28 Oct 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUe9Exyq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E62EB10;
	Tue, 28 Oct 2025 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661340; cv=none; b=fkhykfVcbMYz3qJna2R1LBp6Ci1e243RGCXG1dAC/yIrjD7jgUGcOYLYk0u7sk3IWwWvIb6TPxN1u/52xxUjkhBgS9UlJ7f1yusFViVZccTGoDRsQmOSrgcH5SFUs87lRiRAUFSCSatX6pyUSg/+dJ1RiODxxBBeEsB8Vz4LZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661340; c=relaxed/simple;
	bh=px0MgSDxvp/2jAYLc+fSsb66AHIsm1T+dXEXQF/9FzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx7dAc/OFiOVlcvleE+3xZdGFXGEtJxyAG2nKcQK60nhx9D2p4fI5Rgp33OoHxmUIw+n+isVoGEtwIVRUgMZcIH/UnuK2z9o351fQphJqH1EPu/uKvJP+lVJBjdsLY4IUTQ//vJdthO/dIQr6ZhQnarxb0CZwyjDGWKQ+kYs9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUe9Exyq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761661340; x=1793197340;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=px0MgSDxvp/2jAYLc+fSsb66AHIsm1T+dXEXQF/9FzY=;
  b=GUe9ExyqbjD8lONrWgHPWSCsN4ZQlvBLs8GhursUzftl6on65VTc4YkQ
   wou4kWx9mzUMpewve/vxhDCKFQ7VhKnQLxohJezW6BtIUIW8HU4oeK2ab
   ZXOqXwKVeYcMJ8s+o0cdcm+qULSLwIrCbQxP7e/7qOSyfnkrvXmKDfUiV
   iHvBp6Y+i2fBzlqdbrwJVtG5s4cfC+EVTUXD8HcCbM6WvH+wF3Nmaf6Hl
   VmobcS2iJXGOI+6xCr7vrkJlmFiFyBJA+OxJbXaNYbHBJwLnNm5MrdPIV
   vzvjFjHLEBNouzMCupyNhNMU7gdr0QH8urmE6en30M6znknIdhgV1Urn/
   g==;
X-CSE-ConnectionGUID: a2whkGThR6alFawzbvFnyA==
X-CSE-MsgGUID: 7yo4SEZ8RAegow3H07XLTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63669582"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63669582"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 07:22:19 -0700
X-CSE-ConnectionGUID: cTls5HCJRuGpZlmY+dGByg==
X-CSE-MsgGUID: ug5gR5tiSbiJl0V4QntL/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185055954"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2025 07:22:16 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vDkaR-000JDt-0Q;
	Tue, 28 Oct 2025 14:22:13 +0000
Date: Tue, 28 Oct 2025 22:22:08 +0800
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
Message-ID: <202510282155.MdnvC7YI-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on linus/master v6.18-rc3 next-20251028]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miaoqian-Lin/drm-of-Fix-device-node-reference-leak-in-drm_of_panel_bridge_remove/20251028-141134
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20251028060918.65688-1-linmq006%40gmail.com
patch subject: [PATCH] drm/of: Fix device node reference leak in drm_of_panel_bridge_remove
config: x86_64-randconfig-161-20251028 (https://download.01.org/0day-ci/archive/20251028/202510282155.MdnvC7YI-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251028/202510282155.MdnvC7YI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510282155.MdnvC7YI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/tiny/arcpgu.c:23:
   include/drm/drm_of.h: In function 'drm_of_panel_bridge_remove':
   include/drm/drm_of.h:174:9: error: implicit declaration of function 'of_node_put' [-Wimplicit-function-declaration]
     174 |         of_node_put(remote);
         |         ^~~~~~~~~~~
   In file included from include/linux/of_reserved_mem.h:6,
                    from drivers/gpu/drm/tiny/arcpgu.c:28:
   include/linux/of.h: At top level:
>> include/linux/of.h:129:13: warning: conflicting types for 'of_node_put'; have 'void(struct device_node *)'
     129 | extern void of_node_put(struct device_node *node);
         |             ^~~~~~~~~~~
   include/drm/drm_of.h:174:9: note: previous implicit declaration of 'of_node_put' with type 'void(struct device_node *)'
     174 |         of_node_put(remote);
         |         ^~~~~~~~~~~


vim +129 include/linux/of.h

0829f6d1f69e4f Pantelis Antoniou 2013-12-13  126  
0f22dd395fc473 Grant Likely      2012-02-15  127  #ifdef CONFIG_OF_DYNAMIC
0f22dd395fc473 Grant Likely      2012-02-15  128  extern struct device_node *of_node_get(struct device_node *node);
0f22dd395fc473 Grant Likely      2012-02-15 @129  extern void of_node_put(struct device_node *node);
0f22dd395fc473 Grant Likely      2012-02-15  130  #else /* CONFIG_OF_DYNAMIC */
3ecdd0515287af Rob Herring       2011-12-13  131  /* Dummy ref counting routines - to be implemented later */
3ecdd0515287af Rob Herring       2011-12-13  132  static inline struct device_node *of_node_get(struct device_node *node)
3ecdd0515287af Rob Herring       2011-12-13  133  {
3ecdd0515287af Rob Herring       2011-12-13  134  	return node;
3ecdd0515287af Rob Herring       2011-12-13  135  }
0f22dd395fc473 Grant Likely      2012-02-15  136  static inline void of_node_put(struct device_node *node) { }
0f22dd395fc473 Grant Likely      2012-02-15  137  #endif /* !CONFIG_OF_DYNAMIC */
9448e55d032d99 Jonathan Cameron  2024-02-25  138  DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
3ecdd0515287af Rob Herring       2011-12-13  139  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

