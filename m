Return-Path: <stable+bounces-203142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A88CCD30E5
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B0593011A9E
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0DE2C029A;
	Sat, 20 Dec 2025 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="leZxWeYH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400AB2BE629;
	Sat, 20 Dec 2025 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766241315; cv=none; b=eDj4yD1OnirAKpr0sAzXxKe2ElQKSD6vSNhnugs/a97XjURp3SqMFlZdEIqxQhdgA1NFXDKNnS5Obi1yOj5+W1nD9LQz3Dz9hZrHM/mGhWFVSvVrMmJIaYk1IRqcCa7Z+bHi5BB+FwkSIUJLSXY1y3HwDfxXbPjXI49LNeAAOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766241315; c=relaxed/simple;
	bh=wu8+gZqmV/Q3cWvG2M+eBTaZALLGCI+Ay02j/Vys4Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAUnpv1YuP4kCeGbaxIT8qSQD1ERkhtmOiXXXgxoczfWBquiXnJ04qHdlTtkwy0N6Rt9QdmH8+7joLrWhCPcWnlU2U2+fk6z9bzSQxS6fGnKyIakx/Tx4/ksauMlukZj8Y7GkKvc6W/MnavGLX0NUamBMUhl7yERRdyUtv+AS1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=leZxWeYH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766241313; x=1797777313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wu8+gZqmV/Q3cWvG2M+eBTaZALLGCI+Ay02j/Vys4Ac=;
  b=leZxWeYHPMWdZ946RXxWaeA/3eJtQk0wR8FAFdAN3GgwyHK9443ywToe
   LFqXxrd7hmZv0UOCr+k8VK5bykjhHuwjf2JExVhfjyN0i7BaYKsaIHg0s
   NFUhoxT91MWFpwVKxNhqrQ+bOKxNcTXpjcV63/POakRIubETL46g9n4u5
   E4cgOQU2ssZLMK3gpLJkmfvfU23aVycOC4378+NQQhzMMPPYQ+bc4BGz+
   rvYpB3i8+DeqELqC1KZpudY43Iojxw0qkkejPYdolaMju2DP/G8vKuL2n
   DKQV3DJroVayBZR7Tqnj7ZUFSIxMU8e6N4AOhrwxTjhaYJaSDA3eR9HNZ
   A==;
X-CSE-ConnectionGUID: c/qU09+ZRomH76J8CXUdrw==
X-CSE-MsgGUID: TL/H0CDoTxKsVLd7z3qiKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="93650020"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="93650020"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 06:35:10 -0800
X-CSE-ConnectionGUID: iqGqRvucS4OQca/iF3aKKQ==
X-CSE-MsgGUID: fBSaOj+4Tw+rSqPEqPjy/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199023546"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 20 Dec 2025 06:35:07 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWy2z-000000004eS-12Ne;
	Sat, 20 Dec 2025 14:35:05 +0000
Date: Sat, 20 Dec 2025 22:34:09 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, tobias@waldekranz.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <202512202210.PkOvVaCv-lkp@intel.com>
References: <20251214131204.4684-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214131204.4684-1-make24@iscas.ac.cn>

Hi Ma,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/net-dsa-Fix-error-handling-in-dsa_port_parse_of/20251214-211443
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251214131204.4684-1-make24%40iscas.ac.cn
patch subject: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20251220/202512202210.PkOvVaCv-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251220/202512202210.PkOvVaCv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512202210.PkOvVaCv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/dsa/dsa.c:1266:15: error: incompatible pointer types passing 'struct net_device *' to parameter of type 'struct device *' [-Werror,-Wincompatible-pointer-types]
    1266 |                         put_device(conduit);
         |                                    ^~~~~~~
   include/linux/device.h:1181:32: note: passing argument to parameter 'dev' here
    1181 | void put_device(struct device *dev);
         |                                ^
   1 error generated.


vim +1266 net/dsa/dsa.c

  1244	
  1245	static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
  1246	{
  1247		struct device_node *ethernet = of_parse_phandle(dn, "ethernet", 0);
  1248		const char *name = of_get_property(dn, "label", NULL);
  1249		bool link = of_property_read_bool(dn, "link");
  1250		int err = 0;
  1251	
  1252		dp->dn = dn;
  1253	
  1254		if (ethernet) {
  1255			struct net_device *conduit;
  1256			const char *user_protocol;
  1257	
  1258			conduit = of_find_net_device_by_node(ethernet);
  1259			of_node_put(ethernet);
  1260			if (!conduit)
  1261				return -EPROBE_DEFER;
  1262	
  1263			user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
  1264			err = dsa_port_parse_cpu(dp, conduit, user_protocol);
  1265			if (err)
> 1266				put_device(conduit);
  1267	
  1268			return err;
  1269		}
  1270	
  1271		if (link)
  1272			return dsa_port_parse_dsa(dp);
  1273	
  1274		return dsa_port_parse_user(dp, name);
  1275	}
  1276	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

