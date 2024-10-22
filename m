Return-Path: <stable+bounces-87652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D29A9477
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 02:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8211F22874
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 00:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFE9EC2;
	Tue, 22 Oct 2024 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkzLoIif"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9858B41C62;
	Tue, 22 Oct 2024 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555504; cv=none; b=ltGuDfPq1C3wm0h3FBQllT7/4yJxsghBEHQ4/ouAGtw/3MzepaC7Rg2hGqDnH3lbUboj2rVhlNeuHrmjv6fd/aW5976ziBFB4EZK29yo21R3+i7hlKXTF4TGN5fRGu0nJplH8M9cK+F6fjzeAXrx+NJZw0bA3lHfuJ4mrK7wskI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555504; c=relaxed/simple;
	bh=5x6gGOwyX7rO1kjd/9hTV8Rr5+e03ZltQc1RADfVmoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM32TRPIZXmZT+mmg0uhP13XljTIlLyZqxywoiXqNv/bYFvOqw77ehLJJ0keZIusW+7khD1d2n0S9zxLEHpRAAl1XVZWsTYkcqcJRNs/1nYPgeGhaVSqUt+Ej3MGbIQJh4FhI5dzpAKLU8SUu51Hq7X5Kb6Jh8auPtHb7lCwWV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkzLoIif; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729555503; x=1761091503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5x6gGOwyX7rO1kjd/9hTV8Rr5+e03ZltQc1RADfVmoQ=;
  b=nkzLoIif2yEWIWanrIhi5gL/Ilo1HCggIzyGYklHdmtHUMoLTXPnCCG8
   z+InFtHzgiEMsyABMdC6WWDT+7NW4tSkPLePeYbJeWKl9nCmb9Y0MGUtm
   Yg0s8l+1Api7aJi5dEm5qaoWdNVvj+TCWaVFVd+83KLxN6Pojko0lrKYf
   7Fnf1FOmf/ccFGByMDjfSx6hLIDX6Edjt/oF5Yj4Zil+HdHeIy5JAa/nB
   ia0pk2FXmxS1D3sZbDWcrIoWyOBTuf2Vciu4fd5vQslaY2mVFEKXKAy4t
   KPcfT3spuVAeLP7gZ5S3SyEDbSYlm7WVi9mHCXKRuF2rDA7p1a6Tb0Duk
   g==;
X-CSE-ConnectionGUID: /nEG6bMqTm2LLT7jUy6nQg==
X-CSE-MsgGUID: dPyFGuhdQnuZtQGfBEci9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29177789"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29177789"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 17:05:03 -0700
X-CSE-ConnectionGUID: YU9ncK1OQ2mbg8Ce91GwZw==
X-CSE-MsgGUID: di1qBU7GSqWyiBP0vUKKeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79853197"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 21 Oct 2024 17:04:59 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t32OO-000Sn0-2G;
	Tue, 22 Oct 2024 00:04:56 +0000
Date: Tue, 22 Oct 2024 08:04:32 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dung Cao <dung@os.amperecomputing.com>
Subject: Re: [PATCH net v2] mctp i2c: handle NULL header address
Message-ID: <202410220730.90gh2nXQ-lkp@intel.com>
References: <20241021-mctp-i2c-null-dest-v2-1-4503e478517c@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-mctp-i2c-null-dest-v2-1-4503e478517c@codeconstruct.com.au>

Hi Matt,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cb560795c8c2ceca1d36a95f0d1b2eafc4074e37]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/mctp-i2c-handle-NULL-header-address/20241021-123741
base:   cb560795c8c2ceca1d36a95f0d1b2eafc4074e37
patch link:    https://lore.kernel.org/r/20241021-mctp-i2c-null-dest-v2-1-4503e478517c%40codeconstruct.com.au
patch subject: [PATCH net v2] mctp i2c: handle NULL header address
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20241022/202410220730.90gh2nXQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410220730.90gh2nXQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410220730.90gh2nXQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/mctp/mctp-i2c.c: In function 'mctp_i2c_header_create':
>> drivers/net/mctp/mctp-i2c.c:599:23: warning: assignment to 'u8' {aka 'unsigned char'} from 'const unsigned char *' makes integer from pointer without a cast [-Wint-conversion]
     599 |                 llsrc = dev->dev_addr;
         |                       ^

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +599 drivers/net/mctp/mctp-i2c.c

   579	
   580	static int mctp_i2c_header_create(struct sk_buff *skb, struct net_device *dev,
   581					  unsigned short type, const void *daddr,
   582					  const void *saddr, unsigned int len)
   583	{
   584		struct mctp_i2c_hdr *hdr;
   585		struct mctp_hdr *mhdr;
   586		u8 lldst, llsrc;
   587	
   588		if (len > MCTP_I2C_MAXMTU)
   589			return -EMSGSIZE;
   590	
   591		if (daddr)
   592			lldst = *((u8 *)daddr);
   593		else
   594			return -EINVAL;
   595	
   596		if (saddr)
   597			llsrc = *((u8 *)saddr);
   598		else
 > 599			llsrc = dev->dev_addr;
   600	
   601		skb_push(skb, sizeof(struct mctp_i2c_hdr));
   602		skb_reset_mac_header(skb);
   603		hdr = (void *)skb_mac_header(skb);
   604		mhdr = mctp_hdr(skb);
   605		hdr->dest_slave = (lldst << 1) & 0xff;
   606		hdr->command = MCTP_I2C_COMMANDCODE;
   607		hdr->byte_count = len + 1;
   608		hdr->source_slave = ((llsrc << 1) & 0xff) | 0x01;
   609		mhdr->ver = 0x01;
   610	
   611		return sizeof(struct mctp_i2c_hdr);
   612	}
   613	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

