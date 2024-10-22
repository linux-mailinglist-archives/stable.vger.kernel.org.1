Return-Path: <stable+bounces-87660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED79A9692
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 05:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D8A1F232E8
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 03:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FADE13D8AC;
	Tue, 22 Oct 2024 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtgTCJAG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E713A863;
	Tue, 22 Oct 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566736; cv=none; b=uUzIzjfjuOi1RQnN3kvPd7iTAFhPivtmzyaI5iO5IpnvBSpbUC9M//vvVmRb/F/U4TmaVRvIwZTdcwUAPxm48PTiO5EjdkYCHP5eVeYlsUjOkhu34wY+sVvgOcP8CPPzCL2NxBoR8xw0WDqtjjTpj8f2K4CAd+izOeNASzjedZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566736; c=relaxed/simple;
	bh=fP+1+JuHEGhY4qB7oegLo0qvYsovRFMW4i47QEYmDvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qky3A5/ocKIytWjtPcqOZAMd5kIiiyVX0i6NLF4pD0c6EnDSCAt3cf66bcY0E9VbX2Yk29lNU8BQXD93GtSCYonrGmxsgrOG4ThV2G4lgdRPmly6AexE8HcKPuALJxcAKE+3ph0eYUEGUPjRgnF6WyV+7rr6IS67mWNRC7g2y9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtgTCJAG; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729566735; x=1761102735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fP+1+JuHEGhY4qB7oegLo0qvYsovRFMW4i47QEYmDvc=;
  b=mtgTCJAG6nRt0ETRky2PYuc5LmBoLRd8qMz3uV0fT2yhjVouleh6Su9B
   5WTKjA6ipTYyEGY54WOVVSXVI9nlQNGsqgPkklqs1AjeBzLL0w3fMwDah
   DYdfk+gCnY/jIsL6DKGtTRo7afkNguTIiwgxKA1lBXcqp4xHokguSj71W
   3x9Uj+TkThsNpFjzc9m9phDd7TJlHkhYoDxeJBJr5hOwkT5VEN1oYkulj
   KUCV8QBWWIZ+3p8vN2VVfwi1rmBTcCbgblOQd94ybRLemPiTTUTsiyQDN
   QYEFmugGj4fEOSLqXPGNACVKo3R1lp1IGp0Y97/Zm+hKJkLtA7lScB7lK
   g==;
X-CSE-ConnectionGUID: G+PCILBoTuy47/rX2K9y1Q==
X-CSE-MsgGUID: 6qZcbzXoST+swdTSu/JUYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="40466017"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="40466017"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 20:12:12 -0700
X-CSE-ConnectionGUID: KFwW+s6jQH2W8/yRcCIrgw==
X-CSE-MsgGUID: KzMNp8EORISIZhPPxB3MLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="80082481"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 20:12:08 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t35JW-000Syy-2l;
	Tue, 22 Oct 2024 03:12:06 +0000
Date: Tue, 22 Oct 2024 11:11:31 +0800
From: kernel test robot <lkp@intel.com>
To: Matt Johnston <matt@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Dung Cao <dung@os.amperecomputing.com>
Subject: Re: [PATCH net v2] mctp i2c: handle NULL header address
Message-ID: <202410221036.hs5xBVOp-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on cb560795c8c2ceca1d36a95f0d1b2eafc4074e37]

url:    https://github.com/intel-lab-lkp/linux/commits/Matt-Johnston/mctp-i2c-handle-NULL-header-address/20241021-123741
base:   cb560795c8c2ceca1d36a95f0d1b2eafc4074e37
patch link:    https://lore.kernel.org/r/20241021-mctp-i2c-null-dest-v2-1-4503e478517c%40codeconstruct.com.au
patch subject: [PATCH net v2] mctp i2c: handle NULL header address
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241022/202410221036.hs5xBVOp-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241022/202410221036.hs5xBVOp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410221036.hs5xBVOp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/mctp/mctp-i2c.c:599:9: error: incompatible pointer to integer conversion assigning to 'u8' (aka 'unsigned char') from 'const unsigned char *' [-Wint-conversion]
     599 |                 llsrc = dev->dev_addr;
         |                       ^ ~~~~~~~~~~~~~
   1 error generated.


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

