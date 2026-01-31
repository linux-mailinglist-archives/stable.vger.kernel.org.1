Return-Path: <stable+bounces-212944-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIZUBwElfmk3WAIAu9opvQ
	(envelope-from <stable+bounces-212944-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 16:51:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA2C2C7E
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5C55301A53D
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EBA32ABEC;
	Sat, 31 Jan 2026 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WB1kNw1P"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774B318EC4;
	Sat, 31 Jan 2026 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769874680; cv=none; b=iBSzDz/M20YfCUOlojBRV9q5sDuH4UAn4LLUaRu1zzT+C1Ba/tpWc9FaFTWx+MlfoK3w4KuGWa/JhQj2qubRG5mqk1iwcmPd7E2H0GTQ9jL1KjRhQvL1fz7uc8+vEqqghU+n+uHTWFB+2fYDuegeI5ZODt4tvDce5xkXMDXTdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769874680; c=relaxed/simple;
	bh=k7x77b3W3ADSBaDPL6FsspOeylNLRUTlxoCAl5BYycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6owKUvz9wEgB3AOYnz3z/ucHot5IgYc/CyUt8hwZKhvWj7pQDB0yYjy6Npi0/gU/mKdiuG3boN+kQ5twVZZSIl8ECExSAi+F+IzMpyUC47ycaInYDD18p0jgi7wHOmkjri9bLUyD30U6Yh6UksX8Od4fUObnTX+JXptZHdIaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WB1kNw1P; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769874679; x=1801410679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k7x77b3W3ADSBaDPL6FsspOeylNLRUTlxoCAl5BYycA=;
  b=WB1kNw1PmfuGzx++YG9Xmz1Ol74DCUTvthsgdWAJPR7p/gs7KfN+X3Ne
   2r1UaCqeUdb+QOFiTlJL402zmiL+8eYfHk27Nhxr8hgGlQXEgNe72ixDw
   gt59qeB1zOI8bQtltGvQVQDd+BOSL9Gt9ryxxJeeFVpBnS5DxEOGg1VTH
   579+lRwSrROhXJsHQpSGWDAf93aW5x2GImLbtNxyH5sRq20vlG2pqZSf7
   Vh1GtmVTyQMNQ96PCrKXya4Z/xwqyg1xDtBD+2rUPmwn6MPpdUSW3uwyp
   I2JI4DAwSfogdtmo4lw6aOFB5GZdqAGn+k7Lm0kCFfZQW87fc9+0yJQXa
   g==;
X-CSE-ConnectionGUID: m1qULCB8TuituCxMEUqB/A==
X-CSE-MsgGUID: ZsmlLJlTR7i8MRiwojbToQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71000739"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="71000739"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 07:51:18 -0800
X-CSE-ConnectionGUID: oj9/6QIuQ7eCnZRJ8oXo9A==
X-CSE-MsgGUID: BT1v+xNfSjyQJveBHKITMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="232032014"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 31 Jan 2026 07:51:14 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmDFg-00000000e7w-25kD;
	Sat, 31 Jan 2026 15:51:12 +0000
Date: Sat, 31 Jan 2026 23:50:49 +0800
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
Message-ID: <202601312359.c8Furmbm-lkp@intel.com>
References: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260131055217.729048-1-lihaoxiang@isrc.iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212944-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CACA2C2C7E
X-Rspamd-Action: no action

Hi Haoxiang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on tnguy-net-queue/dev-queue linus/master v6.19-rc7 next-20260130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoxiang-Li/i40e-add-an-error-handling-path-in-i40e_xsk_pool_enable/20260131-135447
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20260131055217.729048-1-lihaoxiang%40isrc.iscas.ac.cn
patch subject: [Intel-wired-lan] [PATCH v2] i40e: add an error handling path in i40e_xsk_pool_enable()
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20260131/202601312359.c8Furmbm-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260131/202601312359.c8Furmbm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601312359.c8Furmbm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_xsk_pool_enable':
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:130:9: error: implicit declaration of function 'i40e_xsk_pool_disable'; did you mean 'i40e_xsk_pool_enable'? [-Wimplicit-function-declaration]
     130 |         i40e_xsk_pool_disable(vsi, qid);
         |         ^~~~~~~~~~~~~~~~~~~~~
         |         i40e_xsk_pool_enable
   drivers/net/ethernet/intel/i40e/i40e_xsk.c: At top level:
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:141:12: error: conflicting types for 'i40e_xsk_pool_disable'; have 'int(struct i40e_vsi *, u16)' {aka 'int(struct i40e_vsi *, short unsigned int)'}
     141 | static int i40e_xsk_pool_disable(struct i40e_vsi *vsi, u16 qid)
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:142:1: note: an argument type that has a default promotion cannot match an empty parameter name list declaration
     142 | {
         | ^
   drivers/net/ethernet/intel/i40e/i40e_xsk.c:130:9: note: previous implicit declaration of 'i40e_xsk_pool_disable' with type 'int()'
     130 |         i40e_xsk_pool_disable(vsi, qid);
         |         ^~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_xsk.c: In function 'i40e_xsk_pool_enable':
>> drivers/net/ethernet/intel/i40e/i40e_xsk.c:131:1: warning: control reaches end of non-void function [-Wreturn-type]
     131 | }
         | ^


vim +131 drivers/net/ethernet/intel/i40e/i40e_xsk.c

aae425efdfd1b1 Jan Sokolowski  2022-10-12   72  
0a714186d3c0f7 Björn Töpel     2018-08-28   73  /**
1742b3d528690a Magnus Karlsson 2020-08-28   74   * i40e_xsk_pool_enable - Enable/associate an AF_XDP buffer pool to a
1742b3d528690a Magnus Karlsson 2020-08-28   75   * certain ring/qid
0a714186d3c0f7 Björn Töpel     2018-08-28   76   * @vsi: Current VSI
1742b3d528690a Magnus Karlsson 2020-08-28   77   * @pool: buffer pool
1742b3d528690a Magnus Karlsson 2020-08-28   78   * @qid: Rx ring to associate buffer pool with
0a714186d3c0f7 Björn Töpel     2018-08-28   79   *
0a714186d3c0f7 Björn Töpel     2018-08-28   80   * Returns 0 on success, <0 on failure
0a714186d3c0f7 Björn Töpel     2018-08-28   81   **/
1742b3d528690a Magnus Karlsson 2020-08-28   82  static int i40e_xsk_pool_enable(struct i40e_vsi *vsi,
1742b3d528690a Magnus Karlsson 2020-08-28   83  				struct xsk_buff_pool *pool,
0a714186d3c0f7 Björn Töpel     2018-08-28   84  				u16 qid)
0a714186d3c0f7 Björn Töpel     2018-08-28   85  {
f3fef2b6e1cc80 Jan Sokolowski  2018-12-18   86  	struct net_device *netdev = vsi->netdev;
0a714186d3c0f7 Björn Töpel     2018-08-28   87  	bool if_running;
0a714186d3c0f7 Björn Töpel     2018-08-28   88  	int err;
0a714186d3c0f7 Björn Töpel     2018-08-28   89  
0a714186d3c0f7 Björn Töpel     2018-08-28   90  	if (vsi->type != I40E_VSI_MAIN)
0a714186d3c0f7 Björn Töpel     2018-08-28   91  		return -EINVAL;
0a714186d3c0f7 Björn Töpel     2018-08-28   92  
0a714186d3c0f7 Björn Töpel     2018-08-28   93  	if (qid >= vsi->num_queue_pairs)
0a714186d3c0f7 Björn Töpel     2018-08-28   94  		return -EINVAL;
0a714186d3c0f7 Björn Töpel     2018-08-28   95  
f3fef2b6e1cc80 Jan Sokolowski  2018-12-18   96  	if (qid >= netdev->real_num_rx_queues ||
f3fef2b6e1cc80 Jan Sokolowski  2018-12-18   97  	    qid >= netdev->real_num_tx_queues)
0a714186d3c0f7 Björn Töpel     2018-08-28   98  		return -EINVAL;
0a714186d3c0f7 Björn Töpel     2018-08-28   99  
c4655761d3cf62 Magnus Karlsson 2020-08-28  100  	err = xsk_pool_dma_map(pool, &vsi->back->pdev->dev, I40E_RX_DMA_ATTR);
0a714186d3c0f7 Björn Töpel     2018-08-28  101  	if (err)
0a714186d3c0f7 Björn Töpel     2018-08-28  102  		return err;
0a714186d3c0f7 Björn Töpel     2018-08-28  103  
44ddd4f1709249 Björn Töpel     2019-02-12  104  	set_bit(qid, vsi->af_xdp_zc_qps);
44ddd4f1709249 Björn Töpel     2019-02-12  105  
0a714186d3c0f7 Björn Töpel     2018-08-28  106  	if_running = netif_running(vsi->netdev) && i40e_enabled_xdp_vsi(vsi);
0a714186d3c0f7 Björn Töpel     2018-08-28  107  
0a714186d3c0f7 Björn Töpel     2018-08-28  108  	if (if_running) {
0a714186d3c0f7 Björn Töpel     2018-08-28  109  		err = i40e_queue_pair_disable(vsi, qid);
0a714186d3c0f7 Björn Töpel     2018-08-28  110  		if (err)
a086001db7c4af Haoxiang Li     2026-01-31  111  			goto err_out;
0a714186d3c0f7 Björn Töpel     2018-08-28  112  
aae425efdfd1b1 Jan Sokolowski  2022-10-12  113  		err = i40e_realloc_rx_xdp_bi(vsi->rx_rings[qid], true);
aae425efdfd1b1 Jan Sokolowski  2022-10-12  114  		if (err)
a086001db7c4af Haoxiang Li     2026-01-31  115  			goto err_out;
aae425efdfd1b1 Jan Sokolowski  2022-10-12  116  
0a714186d3c0f7 Björn Töpel     2018-08-28  117  		err = i40e_queue_pair_enable(vsi, qid);
0a714186d3c0f7 Björn Töpel     2018-08-28  118  		if (err)
a086001db7c4af Haoxiang Li     2026-01-31  119  			goto err_out;
14ffeb52f3693a Magnus Karlsson 2019-01-29  120  
14ffeb52f3693a Magnus Karlsson 2019-01-29  121  		/* Kick start the NAPI context so that receiving will start */
9116e5e2b1fff7 Magnus Karlsson 2019-08-14  122  		err = i40e_xsk_wakeup(vsi->netdev, qid, XDP_WAKEUP_RX);
14ffeb52f3693a Magnus Karlsson 2019-01-29  123  		if (err)
a086001db7c4af Haoxiang Li     2026-01-31  124  			goto err_out;
0a714186d3c0f7 Björn Töpel     2018-08-28  125  	}
0a714186d3c0f7 Björn Töpel     2018-08-28  126  
0a714186d3c0f7 Björn Töpel     2018-08-28  127  	return 0;
a086001db7c4af Haoxiang Li     2026-01-31  128  
a086001db7c4af Haoxiang Li     2026-01-31  129  err_out:
a086001db7c4af Haoxiang Li     2026-01-31  130  	i40e_xsk_pool_disable(vsi, qid);
0a714186d3c0f7 Björn Töpel     2018-08-28 @131  }
0a714186d3c0f7 Björn Töpel     2018-08-28  132  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

