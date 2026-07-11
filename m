Return-Path: <stable+bounces-273382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nl6JMzQRUmrILgMAu9opvQ
	(envelope-from <stable+bounces-273382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 11:47:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D37411AB
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 11:47:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ObujDkOc;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273382-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273382-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B7453016936
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 09:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015753559F2;
	Sat, 11 Jul 2026 09:47:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D45233149;
	Sat, 11 Jul 2026 09:47:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783763247; cv=none; b=d5C5nbj3+6BvliByoEoL6ZKs0xT1DA9vb6IVNRW75BLk6M4PDN3oEJbJXYpm+DPd1JNa1+G83mczcQr9lP5qsyYoGz5NFkPKz6SpHYWmKcvKIyF3BoAOxfas7QqK1Rp8LuLxnkqsLoDTzVb9GC2KuuuOlri0a+HZB6svpar1rMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783763247; c=relaxed/simple;
	bh=Myl2BvsXEAApICtxbRdY9p3y0+4hx6JD5C+wzmSOtc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrvCkZC1px936L+SQiVviIMO5z+ZoNqEMcUCFgzJNSHj1+MMkTUJROiqcnmrpHr13Z8ZUncc1Fn4fI5ZoXi9lu+8+zSDAfwbA8whfAISsa14WDN4kM73+rVCGU6EMNTNJ2h0cd7pJBDuPJtcymiflIh3OwnhJJIN8HtttAGgrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObujDkOc; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783763246; x=1815299246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Myl2BvsXEAApICtxbRdY9p3y0+4hx6JD5C+wzmSOtc4=;
  b=ObujDkOcxcgimirjLCQAWpLjx2t8T1CxsyO5JypeWCz1au/8cE3surtE
   3325Tf2zsXnp1PClqe5plaWhbvnd5UxYyXMayEY4cKmQ91QBc92S0gg7S
   qXzMqQm+qfieborY/8/VINksbJDk66aE9dEXN+Le5Ca0ozIobttzgkPEq
   AkFeSoqpLiNnTrLVNY1lNLPuI3u4eCo6oSUIz4lK0YIyna/UOcDwNk1Ul
   NBVNwGT1VFBE7mcB++4roGJ67g7gsLeefNiNMy929Sd1Ox1gNzLlc6KcT
   gai9NkBIGHGB4Sd+fWY4v1xQo9ULsuLoXM7nuutgs34hTbQxKYacb1WM4
   g==;
X-CSE-ConnectionGUID: pSWjaTd4Q1mOuYL8E12JYQ==
X-CSE-MsgGUID: QVoAk7imQE6ZujoNdHW/Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84498500"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84498500"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 02:47:25 -0700
X-CSE-ConnectionGUID: qoBoc8+uRWGfOe7RGIyXEQ==
X-CSE-MsgGUID: U6O/wZskQk2LG90IzCZg4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251121304"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2026 02:47:23 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wiUIq-00000000JxC-0CYt;
	Sat, 11 Jul 2026 09:47:20 +0000
Date: Sat, 11 Jul 2026 17:47:09 +0800
From: kernel test robot <lkp@intel.com>
To: Hongling Zeng <zenghongling@kylinos.cn>, akpm@linux-foundation.org,
	david@fromorbit.com, qi.zheng@linux.dev, roman.gushchin@linux.dev,
	muchun.song@linux.dev
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: shrinker: fix double-free in alloc_shrinker_info
 error path
Message-ID: <202607111736.7pLPe0yR-lkp@intel.com>
References: <20260711041823.95135-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260711041823.95135-1-zenghongling@kylinos.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273382-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kvack.org,vger.kernel.org,126.com,kylinos.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:zenghongling@kylinos.cn,m:akpm@linux-foundation.org,m:david@fromorbit.com,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:oe-kbuild-all@lists.linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:zhongling0719@126.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A2D37411AB

Hi Hongling,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.2-rc2]
[cannot apply to akpm-mm/mm-everything linus/master next-20260710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hongling-Zeng/mm-shrinker-fix-double-free-in-alloc_shrinker_info-error-path/20260711-122040
base:   v7.2-rc2
patch link:    https://lore.kernel.org/r/20260711041823.95135-1-zenghongling%40kylinos.cn
patch subject: [PATCH] mm: shrinker: fix double-free in alloc_shrinker_info error path
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260711/202607111736.7pLPe0yR-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260711/202607111736.7pLPe0yR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202607111736.7pLPe0yR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/shrinker.c: In function 'alloc_shrinker_info':
   mm/shrinker.c:108:24: error: implicit declaration of function 'shrinker_info_protected' [-Werror=implicit-function-declaration]
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
>> mm/shrinker.c:108:22: warning: assignment to 'struct shrinker_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                      ^
   mm/shrinker.c: At top level:
   mm/shrinker.c:117:30: error: conflicting types for 'shrinker_info_protected'; have 'struct shrinker_info *(struct mem_cgroup *, int)'
     117 | static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
         |                              ^~~~~~~~~~~~~~~~~~~~~~~
   mm/shrinker.c:108:24: note: previous implicit declaration of 'shrinker_info_protected' with type 'int()'
     108 |                 info = shrinker_info_protected(memcg, nid);
         |                        ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +108 mm/shrinker.c

    76	
    77	int alloc_shrinker_info(struct mem_cgroup *memcg)
    78	{
    79		int nid, ret = 0;
    80		int array_size = 0;
    81		int failed_nid;
    82	
    83		mutex_lock(&shrinker_mutex);
    84		array_size = shrinker_unit_size(shrinker_nr_max);
    85		for_each_node(nid) {
    86			struct shrinker_info *info = kvzalloc_node(sizeof(*info) + array_size,
    87								   GFP_KERNEL, nid);
    88			if (!info)
    89				goto err;
    90			info->map_nr_max = shrinker_nr_max;
    91			if (shrinker_unit_alloc(info, NULL, nid)) {
    92				kvfree(info);
    93				goto err;
    94			}
    95			rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
    96		}
    97		mutex_unlock(&shrinker_mutex);
    98	
    99		return ret;
   100	
   101	err:
   102		failed_nid = nid;
   103		for_each_node(nid) {
   104			struct shrinker_info *info;
   105	
   106			if (nid >= failed_nid)
   107				break;
 > 108			info = shrinker_info_protected(memcg, nid);
   109			rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, NULL);
   110			shrinker_unit_free(info, 0);
   111			kvfree(info);
   112		}
   113		mutex_unlock(&shrinker_mutex);
   114		return -ENOMEM;
   115	}
   116	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

