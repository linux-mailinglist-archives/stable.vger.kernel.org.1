Return-Path: <stable+bounces-196565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC5C7B759
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 20:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2245A368699
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9A12FD692;
	Fri, 21 Nov 2025 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ccOI44VC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502BA2F99B0;
	Fri, 21 Nov 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752476; cv=none; b=XgMGYjG0IBISpSwa3GzpglQ2Pkibk4l7gYKXs/4ChC6G1fpX+7PMrwg3zbEhtvcrDFyUIROps/A82s/pDuK1DMQT3eYLJSzlZyeuPgVJZVjfhpyDJ3ewBaqLPv2fY9UGdvA2essw4hQHkjmLSMMSvlHt0puU4FHuAKlXOUE2ClQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752476; c=relaxed/simple;
	bh=Sq7InRy7vQv3Am7QucNFmVEs8KWoC3b59FzoPbem2sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi4KeyWqz/GfYm5OpF99dq3raRkQ6hAUmpH6z1gBOgnXN8t//3wKuS3A9Ha55z84CH5752ARt/84Lhmso9DEoj1rE6nbX74X3T4uv4785VozXaC319GDjP5/yQvIBSY0al9eU9TeK1OmP91mdQmGnE1H7ew+W2nPQYiKQozMC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ccOI44VC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763752475; x=1795288475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sq7InRy7vQv3Am7QucNFmVEs8KWoC3b59FzoPbem2sM=;
  b=ccOI44VCYQ68WV8WABsyNgFUdJq2jmyoClCBXzKye+teD66wN4BMpd+a
   LRtThXLSL6Ooh0cOE7nd7stWi92EUJb5/viGRIsyn4uPlWCnTWZcA2+VK
   U7RaiutQCUHVV/uQtyjxh2g6qLq9JazNJjW7e5JZon2WbUugfnEFDPIdQ
   enLlipgajslPp/Pu8fotLm55Zmej6eFLLDxatrKtTiSYi5971bgODhMdS
   amil0JrGFD/q9nnWO7u/Cocb1SES9ASaWHJ5YeTtOiL7MK1g7g8Vags2+
   v/oEryA4WI26qBm4+PEU5RbKPpFIKm0njVoGKW8Q3LiavNsHaV6lXlV1e
   g==;
X-CSE-ConnectionGUID: sMk8gWkzSgCRj8oeVtSC+Q==
X-CSE-MsgGUID: DvDOmGJ6T6CFbJUsG7l4+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="53424122"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="53424122"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 11:14:33 -0800
X-CSE-ConnectionGUID: BpTgHjmEQHaQmTruCPUJ6A==
X-CSE-MsgGUID: ia2OXpdSQ2GcSFhTM5c1NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="196238714"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 11:14:28 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vMWaP-0006m5-1Y;
	Fri, 21 Nov 2025 19:14:25 +0000
Date: Sat, 22 Nov 2025 03:13:49 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, florian.fainelli@broadcom.com,
	stephen@networkplumber.org, robh@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: Fix error handling in dsa_port_parse_of
Message-ID: <202511220203.nggER5yL-lkp@intel.com>
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
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251122/202511220203.nggER5yL-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251122/202511220203.nggER5yL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511220203.nggER5yL-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/dsa/dsa.c: In function 'dsa_port_parse_of':
>> net/dsa/dsa.c:1265:36: error: passing argument 1 of 'put_device' from incompatible pointer type [-Wincompatible-pointer-types]
    1265 |                         put_device(conduit);
         |                                    ^~~~~~~
         |                                    |
         |                                    struct net_device *
   In file included from net/dsa/dsa.c:10:
   include/linux/device.h:1181:32: note: expected 'struct device *' but argument is of type 'struct net_device *'
    1181 | void put_device(struct device *dev);
         |                 ~~~~~~~~~~~~~~~^~~


vim +/put_device +1265 net/dsa/dsa.c

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

