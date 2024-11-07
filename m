Return-Path: <stable+bounces-91754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A869BFD5F
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 05:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DA22839B9
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 04:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A1018FC9D;
	Thu,  7 Nov 2024 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nPn467A4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA24185B5F;
	Thu,  7 Nov 2024 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953322; cv=none; b=TfdeRt1+xyhL5yxdjgS4iY8p7R5nyNqkxvgw6447pGUxUgvXHJORd1XuPICTrmpVkCZr2PRGOcSAAUSVo9wm9Sr3PdT4J6WQbmqOLiCh6R5DFRYiXeH7DX0Kyp8JZHBt1DjwB2KdSzeJ8lWkD/lLPYuX/LguqrX+SgnIh/40Sog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953322; c=relaxed/simple;
	bh=x1GdMOh3arTXFvBx2uNVn2vtEdkSMO/HtDKxEyTy4g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDap+vgIO8w83dZ8EzNtuvxAvozbnMiWPwzMDaEgYT73NJRha0EqM9TEJRkjKaVukQT9e5YICwp7ceYrREGnKnlQ+zbUXmBsORjgmetWTJckiIFuYuaFYifMtZ7zay4Vc1iiXTYOWu8J7WMrAd5IEbgZyAroFdYY0rmYYWQRX7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nPn467A4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730953321; x=1762489321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x1GdMOh3arTXFvBx2uNVn2vtEdkSMO/HtDKxEyTy4g0=;
  b=nPn467A4HPRBmnxrZ99NEvfR3rGXYt/1b7qvS/rtw5YJRiGTr4yGshjQ
   ATTeXaCt9ddmhuxSShTsaGB0kh9qavEKYsvhkLQ7DprBcF1x/xVTiEj3s
   p5efX5vJijYPIRdmXAOVh5StYNf+QmWi2PpeGNF/W2bzdRicgbyUUK9ls
   7nCjIMK+SARhUSHUHVCO5rpQWmwoxrhts4qMt5FrODh/QIv4E9LvGvSXG
   v3RhKljLBhv65ayJnMjTdEyzE9b+9cLrD3uKevoGd1AG9YqEF3XC5TELi
   /UR/ilhvC7/Bp9tJ6uBO5f+irEq4tat5n9teGp1t+CHJnTD0v/5OVcw+f
   w==;
X-CSE-ConnectionGUID: zZ6VmV8ETKWV6Dg51DftXw==
X-CSE-MsgGUID: J/pOHhrCRmmZh8YFLUQYYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="34557140"
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="34557140"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 20:22:00 -0800
X-CSE-ConnectionGUID: VNw69FuVREWsBZMH8gQ3eQ==
X-CSE-MsgGUID: I7THNe+oQu2XtDn3yfgL3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,264,1725346800"; 
   d="scan'208";a="89750882"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2024 20:21:56 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8u1p-000pow-0Q;
	Thu, 07 Nov 2024 04:21:53 +0000
Date: Thu, 7 Nov 2024 12:21:41 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ivan Delalande <colona@arista.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev, Dmitry Safonov <0x7f454c46@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/6] net/diag: Do not race on dumping MD5 keys with
 adding new MD5 keys
Message-ID: <202411071218.G7g6a8JG-lkp@intel.com>
References: <20241106-tcp-md5-diag-prep-v1-1-d62debf3dded@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-tcp-md5-diag-prep-v1-1-d62debf3dded@gmail.com>

Hi Dmitry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2e1b3cc9d7f790145a80cb705b168f05dab65df2]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Safonov-via-B4-Relay/net-diag-Do-not-race-on-dumping-MD5-keys-with-adding-new-MD5-keys/20241107-025054
base:   2e1b3cc9d7f790145a80cb705b168f05dab65df2
patch link:    https://lore.kernel.org/r/20241106-tcp-md5-diag-prep-v1-1-d62debf3dded%40gmail.com
patch subject: [PATCH net 1/6] net/diag: Do not race on dumping MD5 keys with adding new MD5 keys
config: arm64-randconfig-003-20241107 (https://download.01.org/0day-ci/archive/20241107/202411071218.G7g6a8JG-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411071218.G7g6a8JG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411071218.G7g6a8JG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/ipv4/tcp_diag.c:9:
   In file included from include/linux/net.h:24:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/ipv4/tcp_diag.c:70:3: warning: variable 'md5sig_count' is uninitialized when used here [-Wuninitialized]
      70 |                 md5sig_count++;
         |                 ^~~~~~~~~~~~
   net/ipv4/tcp_diag.c:60:36: note: initialize the variable 'md5sig_count' to silence this warning
      60 |         unsigned int attrlen, md5sig_count;
         |                                           ^
         |                                            = 0
   5 warnings generated.


vim +/md5sig_count +70 net/ipv4/tcp_diag.c

c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  54  
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  55  static int tcp_diag_put_md5sig(struct sk_buff *skb,
4a6144fbc706b3c Dmitry Safonov 2024-11-06  56  			       const struct tcp_md5sig_info *md5sig,
4a6144fbc706b3c Dmitry Safonov 2024-11-06  57  			       struct nlmsghdr *nlh)
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  58  {
4a6144fbc706b3c Dmitry Safonov 2024-11-06  59  	size_t key_size = sizeof(struct tcp_diag_md5sig);
4a6144fbc706b3c Dmitry Safonov 2024-11-06  60  	unsigned int attrlen, md5sig_count;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  61  	const struct tcp_md5sig_key *key;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  62  	struct tcp_diag_md5sig *info;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  63  	struct nlattr *attr;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  64  
4a6144fbc706b3c Dmitry Safonov 2024-11-06  65  	/*
4a6144fbc706b3c Dmitry Safonov 2024-11-06  66  	 * Userspace doesn't like to see zero-filled key-values, so
4a6144fbc706b3c Dmitry Safonov 2024-11-06  67  	 * allocating too large attribute is bad.
4a6144fbc706b3c Dmitry Safonov 2024-11-06  68  	 */
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  69  	hlist_for_each_entry_rcu(key, &md5sig->head, node)
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31 @70  		md5sig_count++;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  71  	if (md5sig_count == 0)
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  72  		return 0;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  73  
4a6144fbc706b3c Dmitry Safonov 2024-11-06  74  	attrlen = skb_availroom(skb) - NLA_HDRLEN;
4a6144fbc706b3c Dmitry Safonov 2024-11-06  75  	md5sig_count = min(md5sig_count, attrlen / key_size);
4a6144fbc706b3c Dmitry Safonov 2024-11-06  76  	attr = nla_reserve(skb, INET_DIAG_MD5SIG, md5sig_count * key_size);
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  77  	if (!attr)
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  78  		return -EMSGSIZE;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  79  
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  80  	info = nla_data(attr);
4a6144fbc706b3c Dmitry Safonov 2024-11-06  81  	memset(info, 0, md5sig_count * key_size);
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  82  	hlist_for_each_entry_rcu(key, &md5sig->head, node) {
4a6144fbc706b3c Dmitry Safonov 2024-11-06  83  		/* More keys on a socket than pre-allocated space available */
4a6144fbc706b3c Dmitry Safonov 2024-11-06  84  		if (md5sig_count-- == 0) {
4a6144fbc706b3c Dmitry Safonov 2024-11-06  85  			nlh->nlmsg_flags |= NLM_F_DUMP_INTR;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  86  			break;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  87  		}
4a6144fbc706b3c Dmitry Safonov 2024-11-06  88  		tcp_diag_md5sig_fill(info++, key);
4a6144fbc706b3c Dmitry Safonov 2024-11-06  89  	}
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  90  
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  91  	return 0;
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  92  }
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  93  #endif
c03fa9bcacd9ac0 Ivan Delalande 2017-08-31  94  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

