Return-Path: <stable+bounces-269804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tFPfF26pQmpR/QkAu9opvQ
	(envelope-from <stable+bounces-269804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 19:20:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1306DDA39
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 19:20:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Vb4sF2Wx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269804-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269804-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05E6A30293E5
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F16043D4F4;
	Mon, 29 Jun 2026 17:20:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CE83655F1;
	Mon, 29 Jun 2026 17:20:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753640; cv=none; b=q9qDkNUK+YT0kuE3asg7QUF6X4XZ6usyXGcrvYqjHGEwVoOGcYAoN/t6vhNWi0WODq2Ev3HnPBvtHCGPomfYkAP6JAl4RR1cgcV3VXoco7qgrHhIqiewwIGsp5MrmlDAtWJjP5+2f4lmJOFCbtVHKGfE9Zorib1RFQB1bFbkEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753640; c=relaxed/simple;
	bh=al5yQE0+dYMsecaa6NaCOaeK0Yanl/mTELVPQXEbJIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+3BtZsVBd+Avq8MrHaa7vDT6RwZIS33PDc6ohcUrmwKtCUHh1UKnTK2wlhC67K4gV6f872PXq3RQkHGZSYGGuhT/P4yc8kYbw0ojUQLA62A8f2Pw5cO38DeRSfWr8tjC4MS8MA5cpX87Y3GZbCFtImXP0TqWyNTwg0SCnzlOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vb4sF2Wx; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782753639; x=1814289639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=al5yQE0+dYMsecaa6NaCOaeK0Yanl/mTELVPQXEbJIs=;
  b=Vb4sF2WxOaICnsuNCJ8qXijkTZHz+/fEE/XSjY6ELFGj5WUGsWXVPWRI
   5IZuuyvDaOXZlr0HZC8t6CGrcFzPVCA9qbzsZxP/15dp144DM+HisLQHj
   NMCF3pnQTLTyVdRBcrzSVl1pn6gOi0swPVmnp9PIR8f0rTWlau/I4zHEC
   4m6le2SEg9cEZ6pyh4tcYWxiS6G0YAWpEuEEhb0e0XQ25knz6MauZJJjK
   bEiuu7pk07xz9z5xtp74eT+Fw4M2QAO59fSRD49ymtBW6p4/afPy/fxIa
   UlA7gmwYVepu6oyubMz6dATKVRSG6Gm+ST1vNu0nY1+0Ug0FsUcDAKUdQ
   Q==;
X-CSE-ConnectionGUID: Xvxip7/uQ0ecSRnjAJUoTQ==
X-CSE-MsgGUID: wtTNEFijRvm0kEBEk9mnRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="83651019"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="83651019"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 10:20:38 -0700
X-CSE-ConnectionGUID: 0vRtVAJ/SG22+p1DOcbZCg==
X-CSE-MsgGUID: sNaMJrLLR/K0VUi71Nij5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; 
   d="scan'208";a="250315835"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 29 Jun 2026 10:20:36 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1weFer-000000007bt-3yh3;
	Mon, 29 Jun 2026 17:20:33 +0000
Date: Tue, 30 Jun 2026 01:19:41 +0800
From: kernel test robot <lkp@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, syzkaller@googlegroups.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix mrec_lock ABBA deadlock in rename
Message-ID: <202606300141.H6Io52CJ-lkp@intel.com>
References: <53BDDD94CF346272+20260629105036.2137914-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53BDDD94CF346272+20260629105036.2137914-1-peiyang_he@smail.nju.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269804-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[smail.nju.edu.cn,kernel.org,gmail.com];
	FORGED_SENDER(0.00)[lkp@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:peiyang_he@smail.nju.edu.cn,m:linkinjeon@kernel.org,m:hyc.lee@gmail.com,m:oe-kbuild-all@lists.linux.dev,m:syzkaller@googlegroups.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA1306DDA39

Hi Peiyang,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1]

url:    https://github.com/intel-lab-lkp/linux/commits/Peiyang-He/ntfs-fix-mrec_lock-ABBA-deadlock-in-rename/20260629-185343
base:   1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
patch link:    https://lore.kernel.org/r/53BDDD94CF346272%2B20260629105036.2137914-1-peiyang_he%40smail.nju.edu.cn
patch subject: [PATCH] ntfs: fix mrec_lock ABBA deadlock in rename
config: arm-randconfig-001-20260629 (https://download.01.org/0day-ci/archive/20260630/202606300141.H6Io52CJ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260630/202606300141.H6Io52CJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606300141.H6Io52CJ-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "d_ancestor" [fs/ntfs/ntfs.ko] undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

