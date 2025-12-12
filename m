Return-Path: <stable+bounces-200897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2EACB8B76
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 12:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7AF03077CCC
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 11:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74331A568;
	Fri, 12 Dec 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+nHw3Uz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00C3168E0;
	Fri, 12 Dec 2025 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765539057; cv=none; b=BgxvvZu3EyLglCw0m2fzETbiRclorx2wQGaA8KgCp5wcKlbeRy5ObY5R5R22bffRJ03XDGwB8SpBwgb4m0vo1zKdz3rZGHwvEJzvmQQsO2o3ViptvIcK7Xma44HxSMxmJUpJyJQOZlbE6J/F8FdmNXAO6z93e57E4HA5h9Fv6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765539057; c=relaxed/simple;
	bh=s7N5PsuoGa/vkzrx/uwZeikSw8IgRvpjFlw+5Bfsccc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJVaGVityB2v9uGJRCzRpkIYGMS76OLZTt3f07O7EBI/N2X5P+VA8RPzaiwTJjX+4Sw3q7zwGOf/2zyiPM8ex6xdeNdczlWT8PukN44pTX0HTPFVe4Ops9/g3RUSlSrwljUyZ7uLBU8lecCt7h78q12vnR/UAYLVbZlamlhuSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+nHw3Uz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765539055; x=1797075055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s7N5PsuoGa/vkzrx/uwZeikSw8IgRvpjFlw+5Bfsccc=;
  b=G+nHw3Uz+kL3vt7CSEqXgsUACGzU2Hr4gKRxRSEkiiRvTgaxWQU7FVYU
   aV75hWtwTY4MQ1fiXgyl3BHV6GquQUNb9UswNLVhTqFVLZyWRX51PCZFe
   ZuZM9lAr66/DnwWMpwnG77QStJoVbg8PGWNCOXJl2kYZth2CdQsUVSNsg
   X1uWZxgeSXNP6AaH6GInDdcdq2MEpNhOXmpHClSaqVlpYYJWspeMeeMs+
   D4fHU6Kdrjdu2ms1gmqHY73PVjmJALk78RMhBQnVZutrzlBoqcG8FwR7A
   Vkq3ZPtHSgnY8i8A7PEQgKsGybN9pWyv9GfE/O9d2xxRZD4zOkccccQze
   g==;
X-CSE-ConnectionGUID: /xZxAh3sQ9qIVfT/3WjEhg==
X-CSE-MsgGUID: c8sZAlgeTvuxH657FoQp7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="71380803"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="71380803"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 03:30:53 -0800
X-CSE-ConnectionGUID: Yb/HT7O5RN+NIsS37ktrDw==
X-CSE-MsgGUID: sil4P7BuRxCEw+1M0tRtdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="196669182"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 12 Dec 2025 03:30:50 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vU1MF-000000005z3-2orb;
	Fri, 12 Dec 2025 11:30:47 +0000
Date: Fri, 12 Dec 2025 19:30:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ilya Krutskih <devsec@tpz.ru>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: oe-kbuild-all@lists.linux.dev, Ilya Krutskih <devsec@tpz.ru>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow
 in
Message-ID: <202512121907.n3Bzh2zF-lkp@intel.com>
References: <20251211173035.852756-1-devsec@tpz.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211173035.852756-1-devsec@tpz.ru>

Hi Ilya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master v6.18 next-20251212]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ilya-Krutskih/net-fealnx-fix-possible-card_idx-integer-overflow-in/20251212-013335
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251211173035.852756-1-devsec%40tpz.ru
patch subject: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow in
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251212/202512121907.n3Bzh2zF-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251212/202512121907.n3Bzh2zF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512121907.n3Bzh2zF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/fealnx.c: In function 'fealnx_init_one':
>> drivers/net/ethernet/fealnx.c:496:35: warning: '%d' directive writing between 1 and 11 bytes into a region of size 6 [-Wformat-overflow=]
     496 |         sprintf(boardname, "fealnx%d", card_idx);
         |                                   ^~
   drivers/net/ethernet/fealnx.c:496:28: note: directive argument in the range [-2147483647, 2147483647]
     496 |         sprintf(boardname, "fealnx%d", card_idx);
         |                            ^~~~~~~~~~
   drivers/net/ethernet/fealnx.c:496:9: note: 'sprintf' output between 8 and 18 bytes into a destination of size 12
     496 |         sprintf(boardname, "fealnx%d", card_idx);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +496 drivers/net/ethernet/fealnx.c

8f14820801042c Jakub Kicinski 2023-03-07  491  
8626fa3323cd34 Ilya Krutskih  2025-12-11  492  	if (card_idx == INT_MAX)
8626fa3323cd34 Ilya Krutskih  2025-12-11  493  		return -EINVAL;
8626fa3323cd34 Ilya Krutskih  2025-12-11  494  	else
8f14820801042c Jakub Kicinski 2023-03-07  495  		card_idx++;
8f14820801042c Jakub Kicinski 2023-03-07 @496  	sprintf(boardname, "fealnx%d", card_idx);
8f14820801042c Jakub Kicinski 2023-03-07  497  
8f14820801042c Jakub Kicinski 2023-03-07  498  	option = card_idx < MAX_UNITS ? options[card_idx] : 0;
8f14820801042c Jakub Kicinski 2023-03-07  499  
8f14820801042c Jakub Kicinski 2023-03-07  500  	i = pci_enable_device(pdev);
8f14820801042c Jakub Kicinski 2023-03-07  501  	if (i) return i;
8f14820801042c Jakub Kicinski 2023-03-07  502  	pci_set_master(pdev);
8f14820801042c Jakub Kicinski 2023-03-07  503  
8f14820801042c Jakub Kicinski 2023-03-07  504  	len = pci_resource_len(pdev, bar);
8f14820801042c Jakub Kicinski 2023-03-07  505  	if (len < MIN_REGION_SIZE) {
8f14820801042c Jakub Kicinski 2023-03-07  506  		dev_err(&pdev->dev,
8f14820801042c Jakub Kicinski 2023-03-07  507  			   "region size %ld too small, aborting\n", len);
8f14820801042c Jakub Kicinski 2023-03-07  508  		return -ENODEV;
8f14820801042c Jakub Kicinski 2023-03-07  509  	}
8f14820801042c Jakub Kicinski 2023-03-07  510  
8f14820801042c Jakub Kicinski 2023-03-07  511  	i = pci_request_regions(pdev, boardname);
8f14820801042c Jakub Kicinski 2023-03-07  512  	if (i)
8f14820801042c Jakub Kicinski 2023-03-07  513  		return i;
8f14820801042c Jakub Kicinski 2023-03-07  514  
8f14820801042c Jakub Kicinski 2023-03-07  515  	irq = pdev->irq;
8f14820801042c Jakub Kicinski 2023-03-07  516  
8f14820801042c Jakub Kicinski 2023-03-07  517  	ioaddr = pci_iomap(pdev, bar, len);
8f14820801042c Jakub Kicinski 2023-03-07  518  	if (!ioaddr) {
8f14820801042c Jakub Kicinski 2023-03-07  519  		err = -ENOMEM;
8f14820801042c Jakub Kicinski 2023-03-07  520  		goto err_out_res;
8f14820801042c Jakub Kicinski 2023-03-07  521  	}
8f14820801042c Jakub Kicinski 2023-03-07  522  
8f14820801042c Jakub Kicinski 2023-03-07  523  	dev = alloc_etherdev(sizeof(struct netdev_private));
8f14820801042c Jakub Kicinski 2023-03-07  524  	if (!dev) {
8f14820801042c Jakub Kicinski 2023-03-07  525  		err = -ENOMEM;
8f14820801042c Jakub Kicinski 2023-03-07  526  		goto err_out_unmap;
8f14820801042c Jakub Kicinski 2023-03-07  527  	}
8f14820801042c Jakub Kicinski 2023-03-07  528  	SET_NETDEV_DEV(dev, &pdev->dev);
8f14820801042c Jakub Kicinski 2023-03-07  529  
8f14820801042c Jakub Kicinski 2023-03-07  530  	/* read ethernet id */
8f14820801042c Jakub Kicinski 2023-03-07  531  	for (i = 0; i < 6; ++i)
8f14820801042c Jakub Kicinski 2023-03-07  532  		addr[i] = ioread8(ioaddr + PAR0 + i);
8f14820801042c Jakub Kicinski 2023-03-07  533  	eth_hw_addr_set(dev, addr);
8f14820801042c Jakub Kicinski 2023-03-07  534  
8f14820801042c Jakub Kicinski 2023-03-07  535  	/* Reset the chip to erase previous misconfiguration. */
8f14820801042c Jakub Kicinski 2023-03-07  536  	iowrite32(0x00000001, ioaddr + BCR);
8f14820801042c Jakub Kicinski 2023-03-07  537  
8f14820801042c Jakub Kicinski 2023-03-07  538  	/* Make certain the descriptor lists are aligned. */
8f14820801042c Jakub Kicinski 2023-03-07  539  	np = netdev_priv(dev);
8f14820801042c Jakub Kicinski 2023-03-07  540  	np->mem = ioaddr;
8f14820801042c Jakub Kicinski 2023-03-07  541  	spin_lock_init(&np->lock);
8f14820801042c Jakub Kicinski 2023-03-07  542  	np->pci_dev = pdev;
8f14820801042c Jakub Kicinski 2023-03-07  543  	np->flags = skel_netdrv_tbl[chip_id].flags;
8f14820801042c Jakub Kicinski 2023-03-07  544  	pci_set_drvdata(pdev, dev);
8f14820801042c Jakub Kicinski 2023-03-07  545  	np->mii.dev = dev;
8f14820801042c Jakub Kicinski 2023-03-07  546  	np->mii.mdio_read = mdio_read;
8f14820801042c Jakub Kicinski 2023-03-07  547  	np->mii.mdio_write = mdio_write;
8f14820801042c Jakub Kicinski 2023-03-07  548  	np->mii.phy_id_mask = 0x1f;
8f14820801042c Jakub Kicinski 2023-03-07  549  	np->mii.reg_num_mask = 0x1f;
8f14820801042c Jakub Kicinski 2023-03-07  550  
8f14820801042c Jakub Kicinski 2023-03-07  551  	ring_space = dma_alloc_coherent(&pdev->dev, RX_TOTAL_SIZE, &ring_dma,
8f14820801042c Jakub Kicinski 2023-03-07  552  					GFP_KERNEL);
8f14820801042c Jakub Kicinski 2023-03-07  553  	if (!ring_space) {
8f14820801042c Jakub Kicinski 2023-03-07  554  		err = -ENOMEM;
8f14820801042c Jakub Kicinski 2023-03-07  555  		goto err_out_free_dev;
8f14820801042c Jakub Kicinski 2023-03-07  556  	}
8f14820801042c Jakub Kicinski 2023-03-07  557  	np->rx_ring = ring_space;
8f14820801042c Jakub Kicinski 2023-03-07  558  	np->rx_ring_dma = ring_dma;
8f14820801042c Jakub Kicinski 2023-03-07  559  
8f14820801042c Jakub Kicinski 2023-03-07  560  	ring_space = dma_alloc_coherent(&pdev->dev, TX_TOTAL_SIZE, &ring_dma,
8f14820801042c Jakub Kicinski 2023-03-07  561  					GFP_KERNEL);
8f14820801042c Jakub Kicinski 2023-03-07  562  	if (!ring_space) {
8f14820801042c Jakub Kicinski 2023-03-07  563  		err = -ENOMEM;
8f14820801042c Jakub Kicinski 2023-03-07  564  		goto err_out_free_rx;
8f14820801042c Jakub Kicinski 2023-03-07  565  	}
8f14820801042c Jakub Kicinski 2023-03-07  566  	np->tx_ring = ring_space;
8f14820801042c Jakub Kicinski 2023-03-07  567  	np->tx_ring_dma = ring_dma;
8f14820801042c Jakub Kicinski 2023-03-07  568  
8f14820801042c Jakub Kicinski 2023-03-07  569  	/* find the connected MII xcvrs */
8f14820801042c Jakub Kicinski 2023-03-07  570  	if (np->flags == HAS_MII_XCVR) {
8f14820801042c Jakub Kicinski 2023-03-07  571  		int phy, phy_idx = 0;
8f14820801042c Jakub Kicinski 2023-03-07  572  
8f14820801042c Jakub Kicinski 2023-03-07  573  		for (phy = 1; phy < 32 && phy_idx < ARRAY_SIZE(np->phys);
8f14820801042c Jakub Kicinski 2023-03-07  574  			       phy++) {
8f14820801042c Jakub Kicinski 2023-03-07  575  			int mii_status = mdio_read(dev, phy, 1);
8f14820801042c Jakub Kicinski 2023-03-07  576  
8f14820801042c Jakub Kicinski 2023-03-07  577  			if (mii_status != 0xffff && mii_status != 0x0000) {
8f14820801042c Jakub Kicinski 2023-03-07  578  				np->phys[phy_idx++] = phy;
8f14820801042c Jakub Kicinski 2023-03-07  579  				dev_info(&pdev->dev,
8f14820801042c Jakub Kicinski 2023-03-07  580  				       "MII PHY found at address %d, status "
8f14820801042c Jakub Kicinski 2023-03-07  581  				       "0x%4.4x.\n", phy, mii_status);
8f14820801042c Jakub Kicinski 2023-03-07  582  				/* get phy type */
8f14820801042c Jakub Kicinski 2023-03-07  583  				{
8f14820801042c Jakub Kicinski 2023-03-07  584  					unsigned int data;
8f14820801042c Jakub Kicinski 2023-03-07  585  
8f14820801042c Jakub Kicinski 2023-03-07  586  					data = mdio_read(dev, np->phys[0], 2);
8f14820801042c Jakub Kicinski 2023-03-07  587  					if (data == SeeqPHYID0)
8f14820801042c Jakub Kicinski 2023-03-07  588  						np->PHYType = SeeqPHY;
8f14820801042c Jakub Kicinski 2023-03-07  589  					else if (data == AhdocPHYID0)
8f14820801042c Jakub Kicinski 2023-03-07  590  						np->PHYType = AhdocPHY;
8f14820801042c Jakub Kicinski 2023-03-07  591  					else if (data == MarvellPHYID0)
8f14820801042c Jakub Kicinski 2023-03-07  592  						np->PHYType = MarvellPHY;
8f14820801042c Jakub Kicinski 2023-03-07  593  					else if (data == MysonPHYID0)
8f14820801042c Jakub Kicinski 2023-03-07  594  						np->PHYType = Myson981;
8f14820801042c Jakub Kicinski 2023-03-07  595  					else if (data == LevelOnePHYID0)
8f14820801042c Jakub Kicinski 2023-03-07  596  						np->PHYType = LevelOnePHY;
8f14820801042c Jakub Kicinski 2023-03-07  597  					else
8f14820801042c Jakub Kicinski 2023-03-07  598  						np->PHYType = OtherPHY;
8f14820801042c Jakub Kicinski 2023-03-07  599  				}
8f14820801042c Jakub Kicinski 2023-03-07  600  			}
8f14820801042c Jakub Kicinski 2023-03-07  601  		}
8f14820801042c Jakub Kicinski 2023-03-07  602  
8f14820801042c Jakub Kicinski 2023-03-07  603  		np->mii_cnt = phy_idx;
8f14820801042c Jakub Kicinski 2023-03-07  604  		if (phy_idx == 0)
8f14820801042c Jakub Kicinski 2023-03-07  605  			dev_warn(&pdev->dev,
8f14820801042c Jakub Kicinski 2023-03-07  606  				"MII PHY not found -- this device may "
8f14820801042c Jakub Kicinski 2023-03-07  607  			       "not operate correctly.\n");
8f14820801042c Jakub Kicinski 2023-03-07  608  	} else {
8f14820801042c Jakub Kicinski 2023-03-07  609  		np->phys[0] = 32;
8f14820801042c Jakub Kicinski 2023-03-07  610  /* 89/6/23 add, (begin) */
8f14820801042c Jakub Kicinski 2023-03-07  611  		/* get phy type */
8f14820801042c Jakub Kicinski 2023-03-07  612  		if (ioread32(ioaddr + PHYIDENTIFIER) == MysonPHYID)
8f14820801042c Jakub Kicinski 2023-03-07  613  			np->PHYType = MysonPHY;
8f14820801042c Jakub Kicinski 2023-03-07  614  		else
8f14820801042c Jakub Kicinski 2023-03-07  615  			np->PHYType = OtherPHY;
8f14820801042c Jakub Kicinski 2023-03-07  616  	}
8f14820801042c Jakub Kicinski 2023-03-07  617  	np->mii.phy_id = np->phys[0];
8f14820801042c Jakub Kicinski 2023-03-07  618  
8f14820801042c Jakub Kicinski 2023-03-07  619  	if (dev->mem_start)
8f14820801042c Jakub Kicinski 2023-03-07  620  		option = dev->mem_start;
8f14820801042c Jakub Kicinski 2023-03-07  621  
8f14820801042c Jakub Kicinski 2023-03-07  622  	/* The lower four bits are the media type. */
8f14820801042c Jakub Kicinski 2023-03-07  623  	if (option > 0) {
8f14820801042c Jakub Kicinski 2023-03-07  624  		if (option & 0x200)
8f14820801042c Jakub Kicinski 2023-03-07  625  			np->mii.full_duplex = 1;
8f14820801042c Jakub Kicinski 2023-03-07  626  		np->default_port = option & 15;
8f14820801042c Jakub Kicinski 2023-03-07  627  	}
8f14820801042c Jakub Kicinski 2023-03-07  628  
8f14820801042c Jakub Kicinski 2023-03-07  629  	if (card_idx < MAX_UNITS && full_duplex[card_idx] > 0)
8f14820801042c Jakub Kicinski 2023-03-07  630  		np->mii.full_duplex = full_duplex[card_idx];
8f14820801042c Jakub Kicinski 2023-03-07  631  
8f14820801042c Jakub Kicinski 2023-03-07  632  	if (np->mii.full_duplex) {
8f14820801042c Jakub Kicinski 2023-03-07  633  		dev_info(&pdev->dev, "Media type forced to Full Duplex.\n");
8f14820801042c Jakub Kicinski 2023-03-07  634  /* 89/6/13 add, (begin) */
8f14820801042c Jakub Kicinski 2023-03-07  635  //      if (np->PHYType==MarvellPHY)
8f14820801042c Jakub Kicinski 2023-03-07  636  		if ((np->PHYType == MarvellPHY) || (np->PHYType == LevelOnePHY)) {
8f14820801042c Jakub Kicinski 2023-03-07  637  			unsigned int data;
8f14820801042c Jakub Kicinski 2023-03-07  638  
8f14820801042c Jakub Kicinski 2023-03-07  639  			data = mdio_read(dev, np->phys[0], 9);
8f14820801042c Jakub Kicinski 2023-03-07  640  			data = (data & 0xfcff) | 0x0200;
8f14820801042c Jakub Kicinski 2023-03-07  641  			mdio_write(dev, np->phys[0], 9, data);
8f14820801042c Jakub Kicinski 2023-03-07  642  		}
8f14820801042c Jakub Kicinski 2023-03-07  643  /* 89/6/13 add, (end) */
8f14820801042c Jakub Kicinski 2023-03-07  644  		if (np->flags == HAS_MII_XCVR)
8f14820801042c Jakub Kicinski 2023-03-07  645  			mdio_write(dev, np->phys[0], MII_ADVERTISE, ADVERTISE_FULL);
8f14820801042c Jakub Kicinski 2023-03-07  646  		else
8f14820801042c Jakub Kicinski 2023-03-07  647  			iowrite32(ADVERTISE_FULL, ioaddr + ANARANLPAR);
8f14820801042c Jakub Kicinski 2023-03-07  648  		np->mii.force_media = 1;
8f14820801042c Jakub Kicinski 2023-03-07  649  	}
8f14820801042c Jakub Kicinski 2023-03-07  650  
8f14820801042c Jakub Kicinski 2023-03-07  651  	dev->netdev_ops = &netdev_ops;
8f14820801042c Jakub Kicinski 2023-03-07  652  	dev->ethtool_ops = &netdev_ethtool_ops;
8f14820801042c Jakub Kicinski 2023-03-07  653  	dev->watchdog_timeo = TX_TIMEOUT;
8f14820801042c Jakub Kicinski 2023-03-07  654  
8f14820801042c Jakub Kicinski 2023-03-07  655  	err = register_netdev(dev);
8f14820801042c Jakub Kicinski 2023-03-07  656  	if (err)
8f14820801042c Jakub Kicinski 2023-03-07  657  		goto err_out_free_tx;
8f14820801042c Jakub Kicinski 2023-03-07  658  
8f14820801042c Jakub Kicinski 2023-03-07  659  	printk(KERN_INFO "%s: %s at %p, %pM, IRQ %d.\n",
8f14820801042c Jakub Kicinski 2023-03-07  660  	       dev->name, skel_netdrv_tbl[chip_id].chip_name, ioaddr,
8f14820801042c Jakub Kicinski 2023-03-07  661  	       dev->dev_addr, irq);
8f14820801042c Jakub Kicinski 2023-03-07  662  
8f14820801042c Jakub Kicinski 2023-03-07  663  	return 0;
8f14820801042c Jakub Kicinski 2023-03-07  664  
8f14820801042c Jakub Kicinski 2023-03-07  665  err_out_free_tx:
8f14820801042c Jakub Kicinski 2023-03-07  666  	dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
8f14820801042c Jakub Kicinski 2023-03-07  667  			  np->tx_ring_dma);
8f14820801042c Jakub Kicinski 2023-03-07  668  err_out_free_rx:
8f14820801042c Jakub Kicinski 2023-03-07  669  	dma_free_coherent(&pdev->dev, RX_TOTAL_SIZE, np->rx_ring,
8f14820801042c Jakub Kicinski 2023-03-07  670  			  np->rx_ring_dma);
8f14820801042c Jakub Kicinski 2023-03-07  671  err_out_free_dev:
8f14820801042c Jakub Kicinski 2023-03-07  672  	free_netdev(dev);
8f14820801042c Jakub Kicinski 2023-03-07  673  err_out_unmap:
8f14820801042c Jakub Kicinski 2023-03-07  674  	pci_iounmap(pdev, ioaddr);
8f14820801042c Jakub Kicinski 2023-03-07  675  err_out_res:
8f14820801042c Jakub Kicinski 2023-03-07  676  	pci_release_regions(pdev);
8f14820801042c Jakub Kicinski 2023-03-07  677  	return err;
8f14820801042c Jakub Kicinski 2023-03-07  678  }
8f14820801042c Jakub Kicinski 2023-03-07  679  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

