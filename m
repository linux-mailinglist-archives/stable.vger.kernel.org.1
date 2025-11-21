Return-Path: <stable+bounces-196550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691E7C7B3A3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4073A3CDE
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE92472A8;
	Fri, 21 Nov 2025 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOvQU55g"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEEE22D7B6;
	Fri, 21 Nov 2025 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748505; cv=none; b=qpoYV5jjjJsPBlWUFdYpNjDBxnydB0Te7dZfjmC6il0vAsCFxs26eZ4p7pXRZ/uVvoHc4+aJe5G3GjKFotbySV5WHiisLDlWnX4mt7385pM75a3KLImvXuX3v3DXcoWpOOQr8JjqBLUn169FStW1alp2Nyo6EvVPa/WenJJpYYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748505; c=relaxed/simple;
	bh=Rqzf1u36v+Fn3pFvdEKJ3si42YdU9CY2oTNiKex1Z1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqbLWEroO7JUNcN21KDeZZfgMLvNR9S1BiMjKrdHEhe35nQAyg4wiEW6SFFg05dfcGMWWjZn3R+t6eFzGqg5+U9C5JMeshTb6YzzG2V5hhdhjFP1dFnVCwN3nMgPViozJSwYZ53b21rl6rllJgLnQeV4Y0gz0MuHYB+YRs1kP+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOvQU55g; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763748503; x=1795284503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rqzf1u36v+Fn3pFvdEKJ3si42YdU9CY2oTNiKex1Z1E=;
  b=SOvQU55gXQWJ1s8UBywf9rd/Rq/WBH5+xqJFSFnPc87lLHByIr0h5kBX
   BvSC+JrlHx2N24LmIGYGPwhumB90ibXlNxqfHywxzgMYf1XPVAHo+V13r
   NrpTfEWJXKFh5eiuszS1B1i1zACONS7PuLU1V2Wl3avBs/t3m8y0vQeA5
   /n/Rv6YUCMs5xAOu2CI0AnJ+eigG9cmAEK535MQ4Ok4pdpJ9xRllpJfxH
   V37OpfSRca0TzhdpPVqPAVaEDyHxWH8oMisxT3B5wyrDe0R0M/CjwbPMk
   HeIMzr4rTZIjjV3laM04No0FtuvE2I9tDAlDTsupK5IQXQW1UWAHqdjTv
   Q==;
X-CSE-ConnectionGUID: fUPU4+q5QXK6YmZt/uid3Q==
X-CSE-MsgGUID: vhCSjF7zQ0i+p533AxDe8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="77210408"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="77210408"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 10:08:22 -0800
X-CSE-ConnectionGUID: OGPKsRdfSqeat4kp4O8W4A==
X-CSE-MsgGUID: znsec5FOQVinlKu5tecIbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="190941786"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 21 Nov 2025 10:08:17 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMVYN-0006gN-1o;
	Fri, 21 Nov 2025 18:08:15 +0000
Date: Sat, 22 Nov 2025 02:07:20 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, florian.fainelli@broadcom.com,
	stephen@networkplumber.org, robh@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <202511220109.1PvI00Sr-lkp@intel.com>
References: <20251121035130.16020-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121035130.16020-1-make24@iscas.ac.cn>

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.18-rc6 next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/net-dsa-Fix-error-handling-in-dsa_port_parse_of/20251121-115449
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251121035130.16020-1-make24%40iscas.ac.cn
patch subject: [PATCH] net: dsa: Fix error handling in dsa_port_parse_of
config: i386-randconfig-004-20251121 (https://download.01.org/0day-ci/archive/20251122/202511220109.1PvI00Sr-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511220109.1PvI00Sr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511220109.1PvI00Sr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/dsa/dsa.c:1265:15: error: incompatible pointer types passing 'struct net_device *' to parameter of type 'struct device *' [-Werror,-Wincompatible-pointer-types]
    1265 |                         put_device(conduit);
         |                                    ^~~~~~~
   include/linux/device.h:1181:32: note: passing argument to parameter 'dev' here
    1181 | void put_device(struct device *dev);
         |                                ^
   1 error generated.


vim +1265 net/dsa/dsa.c

  1243	
  1244	static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
  1245	{
  1246		struct device_node *ethernet = of_parse_phandle(dn, "ethernet", 0);
  1247		const char *name = of_get_property(dn, "label", NULL);
  1248		bool link = of_property_read_bool(dn, "link");
  1249		int err;
  1250	
  1251		dp->dn = dn;
  1252	
  1253		if (ethernet) {
  1254			struct net_device *conduit;
  1255			const char *user_protocol;
  1256	
  1257			conduit = of_find_net_device_by_node(ethernet);
  1258			of_node_put(ethernet);
  1259			if (!conduit)
  1260				return -EPROBE_DEFER;
  1261	
  1262			user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
  1263			err = dsa_port_parse_cpu(dp, conduit, user_protocol);
  1264			if (err) {
> 1265				put_device(conduit);
  1266				return err;
  1267			}
  1268	
  1269			return 0;
  1270		}
  1271	
  1272		if (link)
  1273			return dsa_port_parse_dsa(dp);
  1274	
  1275		return dsa_port_parse_user(dp, name);
  1276	}
  1277	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

