Return-Path: <stable+bounces-241155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DyOFI2j7WnTlwAAu9opvQ
	(envelope-from <stable+bounces-241155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 07:33:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0A4468C77
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 07:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480B73028B01
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 05:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82B2DF13A;
	Sun, 26 Apr 2026 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7oLmcsX"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62592750E6;
	Sun, 26 Apr 2026 05:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777181532; cv=none; b=fwy0wrnSCo7rMmJBjwCRVKD8N8gtWl9e7DZgAInGvGckVQn8g/ednlF1VRfkE8aIVuOGKiv+pZxSf3Wm0/eRRJl8rV13rDYAEh+bKQF5sy1OnIZdk04B7Fb5OAMdcqNDVFDdbbROPuHnmx7WS4Itm+KABjKMJHXiAAFb0AK2FKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777181532; c=relaxed/simple;
	bh=FZxW/0xc3tlPxseOGzaG8aEguh7TK5Jw7ofxFY9FK88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InP9S72IUCh0IdAV6jL7UMGBLCSSNuuVm0FCi6wLvFKm8KxcNB4iA2Y6wY7v98z8Fg0rzomyetVY4EVYiA9p2kY+iskzBru4/Ct2Zrp3sJ8l9rh42gZVibR7Y0unuFPk6qAsafUnkt+oB5SakD07hlG15BntAxg9ABXlFCQ5uvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7oLmcsX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777181531; x=1808717531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FZxW/0xc3tlPxseOGzaG8aEguh7TK5Jw7ofxFY9FK88=;
  b=U7oLmcsX2bHCzf1w4hCVNkQgqIkcw9c2t/fnz1hQYxVCeHP9FdrJamGU
   zZEjl/z1Z68BAbFn5m3jyhF1S/rhDGZrgM9hWuaz+XYNZTWi2wTFHTGQU
   KAarM0GY+lk0X7hbSwRshkQXBjos91zc8sQeDzFsHxcx2gYJpzYhbvAmQ
   w0JLrAflw5Eiq6x1CvhNPnIAcuBCdudWMflvlxYhP4GqlP34epn39JWtC
   5T4DDuqakk4WPxnfVZzRNaANeZv9vUmgkxbw6JAFtZOK6CAdU/kJGtBO5
   ABeNrw2IiByjBYPvlI4sVFHa8vawcZs2Wd+KQzw4rhf434KEX+Pf9KbTR
   g==;
X-CSE-ConnectionGUID: oPvEDgczTqq0cwGArVV6yg==
X-CSE-MsgGUID: Rsbw6SUvTG20simdOJHk2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11767"; a="65636106"
X-IronPort-AV: E=Sophos;i="6.23,199,1770624000"; 
   d="scan'208";a="65636106"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2026 22:32:10 -0700
X-CSE-ConnectionGUID: uvJyIYwRSLK2wagYQHwDAg==
X-CSE-MsgGUID: Z8sWPRqgQIK9RunmgA3kRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,199,1770624000"; 
   d="scan'208";a="238323720"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Apr 2026 22:32:07 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wGs69-000000007W5-04Xp;
	Sun, 26 Apr 2026 05:32:05 +0000
Date: Sun, 26 Apr 2026 13:31:13 +0800
From: kernel test robot <lkp@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, Georgi Djakov <djakov@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Wentao Liang <vulab@iscas.ac.cn>, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: imx: fix use-after-free in
 imx_icc_node_init_qos()
Message-ID: <202604261347.QzG9r7Ym-lkp@intel.com>
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
X-Rspamd-Queue-Id: BF0A4468C77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241155-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,pengutronix.de,gmail.com,iscas.ac.cn,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid]

Hi Wentao,

kernel test robot noticed the following build errors:

[auto build test ERROR on amd-pstate/linux-next]
[also build test ERROR on amd-pstate/bleeding-edge linus/master v7.0 next-20260424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wentao-Liang/interconnect-imx-fix-use-after-free-in-imx_icc_node_init_qos/20260424-225513
base:   https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git linux-next
patch link:    https://lore.kernel.org/r/20260408153022.401123-1-vulab%40iscas.ac.cn
patch subject: [PATCH v2] interconnect: imx: fix use-after-free in imx_icc_node_init_qos()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260426/202604261347.QzG9r7Ym-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260426/202604261347.QzG9r7Ym-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604261347.QzG9r7Ym-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/interconnect/imx/imx.c: In function 'imx_icc_node_init_qos':
>> drivers/interconnect/imx/imx.c:123:16: error: cleanup argument not a function
     123 |         struct device_node *__free(device_nod) dn = of_parse_phandle(dev->of_node,
         |                ^~~~~~~~~~~


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

