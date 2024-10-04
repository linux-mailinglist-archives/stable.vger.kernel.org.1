Return-Path: <stable+bounces-80761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C604A990735
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 17:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A0B284296
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19111AA795;
	Fri,  4 Oct 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ij4FxpK8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F71AA785;
	Fri,  4 Oct 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728054869; cv=none; b=H0f1WTuk9ajQpjnYw5vvKf4BkeZfqEnKIpCkeMvAXd2o324psZHNNQwTBIRSeGBPmqz7NsR5mwcztTFOYyOp1F0fDt15B3j9jm4cASu2SR7d1lohSFK/B8474gLnibNeAnVBxY/sZWmX86hcInxrSscQVDCfNOoZn4Jio/cLp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728054869; c=relaxed/simple;
	bh=BBd2cv0aSYI8t2ZKTirS9fLNsi+alLAsqNd1tjSZuF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1I8/maPDmvyzASNHyh9nwq96QRSTnzB/UT2Ch1hC+gdBNMVh+K1gDpUQgIZy35iprKOr2ATSPYjf/dj9C/t2fQUhnK2FbAoNIMv6Bx6xtboRrHiOaGc+KJBxfkEOr0/68BwdDlUKaBiGx65XU+c9KaoVrjEB7ypj3Y/lOJMscI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ij4FxpK8; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728054866; x=1759590866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BBd2cv0aSYI8t2ZKTirS9fLNsi+alLAsqNd1tjSZuF4=;
  b=ij4FxpK8H6wzji7rGzQnMeUpjNvNBDyB5bE+qV7wz48YjuDIJgotNU2n
   dTzKy5hxf6eatOzggqoGSyTmcsvjVC+YMbIWIOGrFoKYcBy8zaoVBQPQ1
   lmvESk387Y7O3LJXUCWC+LHr+yBwp4m4BB+qjEhjLmNQD6E2dl8JfJkwS
   WMmYCBdJsI+2qYgeT5Y5AXOBab120g8v6+Y5J+GIKvOoaIARq5mjITJac
   1i1rWS/jKM0TJdoSC46Emp9VkLsDEV2ewh4AXISHagqFDG90eLzyGSVcZ
   l44h1AgsG8pJn3vf0unliWcrKD6gYk/Mt2avO08j21RzdlMWAulL0t6U9
   w==;
X-CSE-ConnectionGUID: AUaoghCgRdmQfJHv5cDLcg==
X-CSE-MsgGUID: PzNiJ50dTBmhutgxA2Sc3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="27371410"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="27371410"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 08:14:26 -0700
X-CSE-ConnectionGUID: hxCBzj0TQP2HhxetTbj6og==
X-CSE-MsgGUID: dZeT7LeyQjG7WqGPPsjAFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79305543"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 04 Oct 2024 08:14:24 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swk0b-0001oW-1u;
	Fri, 04 Oct 2024 15:14:21 +0000
Date: Fri, 4 Oct 2024 23:13:28 +0800
From: kernel test robot <lkp@intel.com>
To: Andrej Shadura <andrew.shadura@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>, kernel@collabora.com,
	George Burgess <gbiv@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix type of len in
 rfcomm_sock_{bind,getsockopt_old}()
Message-ID: <202410042221.Phncg973-lkp@intel.com>
References: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>

Hi Andrej,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on bluetooth/master linus/master v6.12-rc1 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrej-Shadura/Bluetooth-Fix-type-of-len-in-rfcomm_sock_-bind-getsockopt_old/20241002-221656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20241002141217.663070-1-andrew.shadura%40collabora.co.uk
patch subject: [PATCH] Bluetooth: Fix type of len in rfcomm_sock_{bind,getsockopt_old}()
config: arm-randconfig-001-20241004 (https://download.01.org/0day-ci/archive/20241004/202410042221.Phncg973-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410042221.Phncg973-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410042221.Phncg973-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/bluetooth/rfcomm/sock.c:32:
   In file included from include/net/bluetooth/bluetooth.h:30:
   In file included from include/net/sock.h:46:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm/include/asm/cacheflush.h:10:
   In file included from include/linux/mm.h:2232:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> net/bluetooth/rfcomm/sock.c:339:8: error: call to '__compiletime_assert_549' declared with 'error' attribute: min(sizeof(sa), addr_len) signedness error
     339 |         len = min(sizeof(sa), addr_len);
         |               ^
   include/linux/minmax.h:129:19: note: expanded from macro 'min'
     129 | #define min(x, y)       __careful_cmp(min, x, y)
         |                         ^
   include/linux/minmax.h:105:2: note: expanded from macro '__careful_cmp'
     105 |         __careful_cmp_once(op, x, y, __UNIQUE_ID(x_), __UNIQUE_ID(y_))
         |         ^
   include/linux/minmax.h:100:2: note: expanded from macro '__careful_cmp_once'
     100 |         BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),        \
         |         ^
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:174:1: note: expanded from here
     174 | __compiletime_assert_549
         | ^
   1 warning and 1 error generated.


vim +339 net/bluetooth/rfcomm/sock.c

   326	
   327	static int rfcomm_sock_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
   328	{
   329		struct sockaddr_rc sa;
   330		struct sock *sk = sock->sk;
   331		int err = 0;
   332		size_t len;
   333	
   334		if (!addr || addr_len < offsetofend(struct sockaddr, sa_family) ||
   335		    addr->sa_family != AF_BLUETOOTH)
   336			return -EINVAL;
   337	
   338		memset(&sa, 0, sizeof(sa));
 > 339		len = min(sizeof(sa), addr_len);
   340		memcpy(&sa, addr, len);
   341	
   342		BT_DBG("sk %p %pMR", sk, &sa.rc_bdaddr);
   343	
   344		lock_sock(sk);
   345	
   346		if (sk->sk_state != BT_OPEN) {
   347			err = -EBADFD;
   348			goto done;
   349		}
   350	
   351		if (sk->sk_type != SOCK_STREAM) {
   352			err = -EINVAL;
   353			goto done;
   354		}
   355	
   356		write_lock(&rfcomm_sk_list.lock);
   357	
   358		if (sa.rc_channel &&
   359		    __rfcomm_get_listen_sock_by_addr(sa.rc_channel, &sa.rc_bdaddr)) {
   360			err = -EADDRINUSE;
   361		} else {
   362			/* Save source address */
   363			bacpy(&rfcomm_pi(sk)->src, &sa.rc_bdaddr);
   364			rfcomm_pi(sk)->channel = sa.rc_channel;
   365			sk->sk_state = BT_BOUND;
   366		}
   367	
   368		write_unlock(&rfcomm_sk_list.lock);
   369	
   370	done:
   371		release_sock(sk);
   372		return err;
   373	}
   374	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

