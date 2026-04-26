Return-Path: <stable+bounces-241170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK07AAYf7mmRqwAAu9opvQ
	(envelope-from <stable+bounces-241170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 16:19:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FFB46A4BB
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7F4F30028CD
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBAA3644CF;
	Sun, 26 Apr 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Scw3s7WY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B63603F0;
	Sun, 26 Apr 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777213183; cv=none; b=jPpxslRBVRB7KwrkKQt/Qjbs+yQsS5J/h7U8GrLyzxAzq8Y0+m+IlHW9S5LTaa6T2zmyZ+/NXOpfqP6XKyYeSdSCgVTHsA6VW3b3/Qwm2H2wKNAPLT1clqrWJLAFw0KEVE9+8Bj5Itfpvnn3bbNHbcGrnj6mhLvpLbOJUtvBeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777213183; c=relaxed/simple;
	bh=URvyEJiznvxr1mg7MT1vmtVH/KoUn/kPWKJIrV3eitw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6zUdH8O+0J0Vt93JtBUloPIDb4v+uCvvGdq196Yq63cUG44WcUeuYpECZGbjq9nJbGAxrMB2XAKJ4XndG0e4Uk6h7/61WpyLA6l8EpPWspMuASgd17lS2hd12JQiMFs/vQ4pog9byiQoDtWEQ72WM1psCxt7NjVIZgvQ9OeDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Scw3s7WY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777213181; x=1808749181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=URvyEJiznvxr1mg7MT1vmtVH/KoUn/kPWKJIrV3eitw=;
  b=Scw3s7WYHF60s/r6KDtc8HLX+Ql0wMg14hdVxZLkAhdPIcOSIsi+NCTf
   ybet85+ouFKpPrOwBt8ebvBKnSBl0omhC57zRRkJET/4SBzyEbjIY4xFE
   ua0zSOORYzuf6ChmpyYxvU0AxqzxUACHRewXncXsOePdIXsMFXV90Q5L5
   7dcvxZ9v8UowZ5AXpGNXtnYTR6RjmEjqG7FlUvgTkJohEITFFqOWpwN9K
   BcHoVKjrdd9N5d/5vUvbbctOJwKyIlACD2XhX7gHJBiY3MLxAd0gAYqyw
   b3mwHEcXLOf6vZ3yQyjm7qxMW7om8m61akOzpQN2ByLG5NekycIJQw4SI
   A==;
X-CSE-ConnectionGUID: fzxv3Hi6TeyeX8VaN7soxQ==
X-CSE-MsgGUID: QPN6KKrtTDCD1L8Rir+KQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="78308283"
X-IronPort-AV: E=Sophos;i="6.23,200,1770624000"; 
   d="scan'208";a="78308283"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2026 07:19:41 -0700
X-CSE-ConnectionGUID: ziOmEDTvSCe9EljfjscO9A==
X-CSE-MsgGUID: UdPkb92JS5m4WCwW7FbKag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,200,1770624000"; 
   d="scan'208";a="233683673"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Apr 2026 07:19:37 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wH0Kd-000000007wL-0HYX;
	Sun, 26 Apr 2026 14:19:35 +0000
Date: Sun, 26 Apr 2026 22:19:15 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, Georgi Djakov <djakov@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wentao Liang <vulab@iscas.ac.cn>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: imx: fix use-after-free in
 imx_icc_node_init_qos()
Message-ID: <202604262216.MLuzg6nl-lkp@intel.com>
References: <20260408153022.401123-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408153022.401123-1-vulab@iscas.ac.cn>
X-Rspamd-Queue-Id: F2FFB46A4BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,pengutronix.de,gmail.com,iscas.ac.cn,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241170-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on amd-pstate/linux-next]
[also build test ERROR on amd-pstate/bleeding-edge linus/master shawnguo/for-next v7.0 next-20260424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/interconnect-imx-fix-use-after-free-in-imx_icc_node_init_qos/20260424-225513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20260408153022.401123-1-vulab%40iscas.ac.cn
patch subject: [PATCH v2] interconnect: imx: fix use-after-free in imx_icc_node_init_qos()
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260426/202604262216.MLuzg6nl-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260426/202604262216.MLuzg6nl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604262216.MLuzg6nl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/interconnect/imx/imx.c:123:22: error: use of undeclared identifier '__free_device_nod'; did you mean '__free_device_node'?
     123 |         struct device_node *__free(device_nod) dn = of_parse_phandle(dev->of_node,
         |                             ^~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:213:33: note: expanded from macro '__free'
     213 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^~~~~~~~~~~~~~
   <scratch space>:42:1: note: expanded from here
      42 | __free_device_nod
         | ^~~~~~~~~~~~~~~~~
   include/linux/of.h:138:1: note: '__free_device_node' declared here
     138 | DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
         | ^
   include/linux/cleanup.h:211:30: note: expanded from macro 'DEFINE_FREE'
     211 |         static __always_inline void __free_##_name(void *p) { _type _T = *(_type *)p; _free; }
         |                                     ^
   <scratch space>:227:1: note: expanded from here
     227 | __free_device_node
         | ^
   1 error generated.


vim +123 drivers/interconnect/imx/imx.c

   116	
   117	static int imx_icc_node_init_qos(struct icc_provider *provider,
   118					 struct icc_node *node)
   119	{
   120		struct imx_icc_node *node_data = node->data;
   121		const struct imx_icc_node_adj_desc *adj = node_data->desc->adj;
   122		struct device *dev = provider->dev;
 > 123		struct device_node *__free(device_nod) dn = of_parse_phandle(dev->of_node,
   124				adj->phandle_name, 0);
   125		struct platform_device *pdev;
   126	
   127		if (adj->main_noc) {
   128			node_data->qos_dev = dev;
   129			dev_dbg(dev, "icc node %s[%d] is main noc itself\n",
   130				node->name, node->id);
   131		} else {
   132			if (!dn) {
   133				dev_warn(dev, "Failed to parse %s\n",
   134					 adj->phandle_name);
   135				return -ENODEV;
   136			}
   137			/* Allow scaling to be disabled on a per-node basis */
   138			if (!of_device_is_available(dn)) {
   139				dev_warn(dev, "Missing property %s, skip scaling %s\n",
   140					 adj->phandle_name, node->name);
   141				return 0;
   142			}
   143	
   144			pdev = of_find_device_by_node(dn);
   145			if (!pdev) {
   146				dev_warn(dev, "node %s[%d] missing device for %pOF\n",
   147					 node->name, node->id, dn);
   148				return -EPROBE_DEFER;
   149			}
   150			node_data->qos_dev = &pdev->dev;
   151			dev_dbg(dev, "node %s[%d] has device node %pOF\n",
   152				node->name, node->id, dn);
   153		}
   154	
   155		return dev_pm_qos_add_request(node_data->qos_dev,
   156					      &node_data->qos_req,
   157					      DEV_PM_QOS_MIN_FREQUENCY, 0);
   158	}
   159	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

