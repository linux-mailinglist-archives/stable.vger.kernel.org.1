Return-Path: <stable+bounces-212983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id b9kHGZHofmn2ggIAu9opvQ
	(envelope-from <stable+bounces-212983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 06:45:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B0C4FD0
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 06:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED4F030154A8
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 05:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A392D879B;
	Sun,  1 Feb 2026 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TE6xRE80"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270118859B;
	Sun,  1 Feb 2026 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769924749; cv=none; b=O3BY622qyULB53kFIxPtAWBXTc6o2azguGzPpySrWyadi6IzL7KGw80615AwjtuiOKldjcxFOLpwL6YxdvIr7ReQkO8iB9KvzQiWFoaw/ivE+UnA8PWsT5dm2Z3P0Da2EfP0KOhIYl/OO3EqGGW5xBWFzFFlxRwmqKxQ/0fBXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769924749; c=relaxed/simple;
	bh=wmdU6j24xok3QN+AvpOevv0hG+C0xnYZebCq708jyl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIgla/PHbzbl0cP4s2/4PSSXlSJAfDSP1MhI8tq3XuF0O/KhS/kr9rR4QDJ70BvO6BnGg9lyvK7SfFn9I0bFpuhiziyFRGR51ieXTNLaFho8hH0ufcGy1EbozYLxP6g2NpJhFzASrJtKcG9uH9/thiqss8Fx7myFSPrikYnEIpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TE6xRE80; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769924747; x=1801460747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wmdU6j24xok3QN+AvpOevv0hG+C0xnYZebCq708jyl4=;
  b=TE6xRE80v8f9zaplkyVDcgWqcl4HjE1XrHRnwWkZi8rc2BKW4vCfF7/Z
   LUGknvlp/IH8kzF2mQonQt8MgbO/KcKr2/3AEEbfHLb/mG3yy+7zvjCh1
   g2PUp0VuvawLm4bCExQBGfEmGDDp8JAENQANuvCxSt4AfE4NSddaVjLlI
   L2PEXsxqajZOmq5MkrgFERbKx6xDJ2VhPZMUfiqmlsoPjgE3R+AeodbBD
   4+lQ0rc3XrvPx6a6xTPirt+eRboHOGIvGScqU7q+D02yjhhLTZYxsbWbL
   hAxogGRzO3/Xo4wOa9fYni7Sy8m2icf8ST6Z4Eldj6kQZvYeruqIQp1WM
   Q==;
X-CSE-ConnectionGUID: JmE5L8prSpmGFkwS+FPNSQ==
X-CSE-MsgGUID: yEZjTtUVSmmaUyvLb+R8UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11688"; a="71017499"
X-IronPort-AV: E=Sophos;i="6.21,266,1763452800"; 
   d="scan'208";a="71017499"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 21:45:46 -0800
X-CSE-ConnectionGUID: ziBlGkAeS/OM7AIQFZruYA==
X-CSE-MsgGUID: T9cKmxjqQpaU1ewOp7BJZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,266,1763452800"; 
   d="scan'208";a="213731916"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Jan 2026 21:45:42 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmQHE-00000000ebw-1ReG;
	Sun, 01 Feb 2026 05:45:40 +0000
Date: Sun, 1 Feb 2026 13:44:54 +0800
From: kernel test robot <lkp@intel.com>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, daniel@iogearbox.net, magnus.karlsson@intel.com,
	bjorn@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in
 i40e_xsk_pool_enable()
Message-ID: <202602011335.eVX5YSY8-lkp@intel.com>
References: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212983-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 968B0C4FD0
X-Rspamd-Action: no action

Hi Haoxiang,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[also build test ERROR on tnguy-net-queue/dev-queue linus/master v6.19-rc7 next-20260130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoxiang-Li/i40e-add-an-error-handling-path-in-i40e_xsk_pool_enable/20260131-135447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20260131055217.729048-1-lihaoxiang%40isrc.iscas.ac.cn
patch subject: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in i40e_xsk_pool_enable()
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20260201/202602011335.eVX5YSY8-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260201/202602011335.eVX5YSY8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602011335.eVX5YSY8-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_xsk_pool_enable':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:130:9: error: implicit declaration of function 'i40e_xsk_pool_disable'; did you mean 'i40e_xsk_pool_enable'? [-Wimplicit-function-declaration]
     130 |         i40e_xsk_pool_disable(vsi, qid);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         i40e_xsk_pool_enable
   drivers/net/ethernet/intel/i40e/i40e_xsk.c: At top level:
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:141:12: error: conflicting types for 'i40e_xsk_pool_disable'; have 'int(struct i40e_vsi *, u16)' {aka 'int(struct i40e_vsi *, short unsigned int)'}
     141 | static int i40e_xsk_pool_disable(struct i40e_vsi *vsi, u16 qid)
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:142:1: note: an argument type that has a default promotion cannot match an empty parameter name list declaration
     142 | {
         | ^
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:130:9: note: previous implicit declaration of 'i40e_xsk_pool_disable' with type 'int()'
     130 |         i40e_xsk_pool_disable(vsi, qid);
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_xsk_pool_enable':
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:131:1: warning: control reaches end of non-void function [-Wreturn-type]
     131 | }
         | ^


vim +130 drivers/net/ethernet/intel/i40e/i40e_xsk.c

    72	
    73	/**
    74	 * i40e_xsk_pool_enable - Enable/associate an AF_XDP buffer pool to a
    75	 * certain ring/qid
    76	 * @vsi: Current VSI
    77	 * @pool: buffer pool
    78	 * @qid: Rx ring to associate buffer pool with
    79	 *
    80	 * Returns 0 on success, <0 on failure
    81	 **/
    82	static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
    83					struct xsk_buff_pool *pool,
    84					u16 qid)
    85	{
    86		struct net_device *netdev = vsi->netdev;
    87		bool if_running;
    88		int err;
    89	
    90		if (vsi->type != I40E_VSI_MAIN)
    91			return -EINVAL;
    92	
    93		if (qid >= vsi->num_queue_pairs)
    94			return -EINVAL;
    95	
    96		if (qid >= netdev->real_num_rx_queues ||
    97		    qid >= netdev->real_num_tx_queues)
    98			return -EINVAL;
    99	
   100		err = xsk_pool_dma_map(pool, &vsi->back->pdev->dev, I40E_RX_DMA_ATTR);
   101		if (err)
   102			return err;
   103	
   104		set_bit(qid, vsi->af_xdp_zc_qps);
   105	
   106		if_running = netif_running(vsi->netdev) && i40e_enabled_xdp_vsi(vsi);
   107	
   108		if (if_running) {
   109			err = i40e_queue_pair_disable(vsi, qid);
   110			if (err)
   111				goto err_out;
   112	
   113			err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
   114			if (err)
   115				goto err_out;
   116	
   117			err = i40e_queue_pair_enable(vsi, qid);
   118			if (err)
   119				goto err_out;
   120	
   121			/* Kick start the NAPI context so that receiving will start */
   122			err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
   123			if (err)
   124				goto err_out;
   125		}
   126	
   127		return 0;
   128	
   129	err_out:
 > 130		i40e_xsk_pool_disable(vsi, qid);
   131	}
   132	
   133	/**
   134	 * i40e_xsk_pool_disable - Disassociate an AF_XDP buffer pool from a
   135	 * certain ring/qid
   136	 * @vsi: Current VSI
   137	 * @qid: Rx ring to associate buffer pool with
   138	 *
   139	 * Returns 0 on success, <0 on failure
   140	 **/
 > 141	static int i40e_xsk_pool_disable(struct i40e_vsi *vsi, u16 qid)
   142	{
   143		struct net_device *netdev = vsi->netdev;
   144		struct xsk_buff_pool *pool;
   145		bool if_running;
   146		int err;
   147	
   148		pool = xsk_get_pool_from_qid(netdev, qid);
   149		if (!pool)
   150			return -EINVAL;
   151	
   152		if_running = netif_running(vsi->netdev) && i40e_enabled_xdp_vsi(vsi);
   153	
   154		if (if_running) {
   155			err = i40e_queue_pair_disable(vsi, qid);
   156			if (err)
   157				return err;
   158		}
   159	
   160		clear_bit(qid, vsi->af_xdp_zc_qps);
   161		xsk_pool_dma_unmap(pool, I40E_RX_DMA_ATTR);
   162	
   163		if (if_running) {
   164			err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], false);
   165			if (err)
   166				return err;
   167			err = i40e_queue_pair_enable(vsi, qid);
   168			if (err)
   169				return err;
   170		}
   171	
   172		return 0;
   173	}
   174	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

