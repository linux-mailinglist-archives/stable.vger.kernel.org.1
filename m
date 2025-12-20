Return-Path: <stable+bounces-203149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F311CCD33C5
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 17:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D68BF3018F42
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 16:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6291730DED0;
	Sat, 20 Dec 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jc+46oJN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F1130C61F;
	Sat, 20 Dec 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766248952; cv=none; b=H7CiC5VkxSpS20CcGpD6IyGZc/ZW3veVxC2+6wD/ABArU4CPtX/6hrmzQ98E6/wzX75KDMA+dn7MYAWoQVJoiVSbMiH68yRQ0ApmbUgvj7D0DbImFFx7RlccvXlN4LnRIY3WZWeNbVljqADIw/d+lubAsDrzOSUuR2b/lcV+IkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766248952; c=relaxed/simple;
	bh=TXnF+6Y/X/cvzV+gzLc9kK5K/qf4PUFeAfhUcqk0IiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRTqNhIHDAmcuJie1/nYTY2c4XaQ2XsDZhlS/Bz/sAcsp4cVKPPXPGcIIGx8QXb7vHh36CoZ16xOkT8uMVAkObXWc1kExaaUZ3CfQUc+rX7pcs2/rdY8IBoGznnDQgvQJ8mKeI9ZpyfsUnXnGxQIwdSkfJJX8XuFGjpgpDjQpIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jc+46oJN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766248951; x=1797784951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TXnF+6Y/X/cvzV+gzLc9kK5K/qf4PUFeAfhUcqk0IiI=;
  b=Jc+46oJNln39kOMQWHa+XSLnj09iUKru/FSBG+xOLuzHFOsqZ7zVLG4a
   O9xqLhGcq1fNEmREazQYG1GcvXyzuisJwpgHhPhOncXn8QOqK3R7P0FPx
   6l7cHR7ACY1iA+5QAZEMG0iYA0rVGKIwIuBXhCq46pfVIu6Adl7/E+HVW
   gapz9a78DLv/7sHbrju8AZbkQBgOPqlYiUbV/JSPb3tBThQ0BbdoCguBx
   0ILKAN8lqkS2gjnZm7jWeHflLQDv34e/f//63GG/NxKEgjVNQFAxxBTqL
   KTua53+4gxDPgx9B7MzbWDrmdtUQVdnBf7fR01mJK0JlkVrIwkU4P3cNg
   Q==;
X-CSE-ConnectionGUID: tF0lJBGARPian6BrUqTIBA==
X-CSE-MsgGUID: vzoKGo1pTHKGz6ZaeTFayw==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="85764593"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="85764593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 08:42:30 -0800
X-CSE-ConnectionGUID: qC9C4mkYTJ6Du3i4F1bxqQ==
X-CSE-MsgGUID: cKF+9GaETzqL8blds+JfXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199170422"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Dec 2025 08:42:26 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX02B-000000004tH-319A;
	Sat, 20 Dec 2025 16:42:23 +0000
Date: Sun, 21 Dec 2025 00:41:46 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, tobias@waldekranz.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <202512210004.b6WzJwXn-lkp@intel.com>
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
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20251221/202512210004.b6WzJwXn-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project b324c9f4fa112d61a553bf489b5f4f7ceea05ea8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210004.b6WzJwXn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210004.b6WzJwXn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/dsa/dsa.c:1266:15: error: incompatible pointer types passing 'struct net_device *' to parameter of type 'struct device *' [-Wincompatible-pointer-types]
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

