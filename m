Return-Path: <stable+bounces-214862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLmvEW+IiGmGqgQAu9opvQ
	(envelope-from <stable+bounces-214862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 13:58:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB35B108AD0
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 13:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A913012C4A
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3D423B60A;
	Sun,  8 Feb 2026 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D6vR2zVW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849D231830;
	Sun,  8 Feb 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770555489; cv=none; b=K8z/29F4i9I8aZdEvMhbWsREm4GFKLuqKtEjW7MIRHOxofwCgkxSxKdXeEUV46wJCWK7tG9lJ+jWIQqojD3Xo3v14Es8zParVZJskWgtuw8U/XsiHIZMaJvI3frbLRzJRCCc6bRnzjE+Mi7IW9Ie2tI4C5wFyRgCO3c0Tn7c4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770555489; c=relaxed/simple;
	bh=4FckoU7tRGnFSwq6BDx3GvojKcsbtSbNB5qBJ37fJZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxhax3yYRxJIf2s4NtLFQePh4gp5sIT7VSw9wW6h5W+G13xp26NiT4h9Kl8NRiNXKxqoTwa+xSvjO1KZmt14KR9JsTkb7lHVyP0NbZBVBNfGgZNE23eACC9YceKKE/gc4uxIxbh4YE2iRg6QUMS4LWx+4c84nk2nUXYq/gHUep0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D6vR2zVW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770555489; x=1802091489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4FckoU7tRGnFSwq6BDx3GvojKcsbtSbNB5qBJ37fJZY=;
  b=D6vR2zVW4uPtzMkqjacCKcHl0bJ7wn2r9D6HkQaOBWLflPU6VpmXAMO9
   5OFasd3KT5BtO/ou1WPf6sYsQsyN3ZD1Achh71wFx5AijD0tXhOLw1Q0u
   vEiRvD5223JlNS+729D1q6qbqU1IqiQMdeDFe9iWheODDsJTtItm1S2aV
   FjNeXOlxzpHNVzUwlcWXJtfO5/zhYyrdWJTxK0wprslQitSmTGhWyn5WN
   9hei5oFQqQ6Jry50G25sdPPQsG8wMdf5ydFkw71tG3M1uHuUgWj2icFZZ
   HctdNLr1qkrL4l5BGpV8tm4lUtUomCnZwpFx5g1gx25KdvmrhOmymi8ET
   Q==;
X-CSE-ConnectionGUID: 813/vvhkRIaeWAkR0K510g==
X-CSE-MsgGUID: DQjE4yNqTpqQAUM/zcrsFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="75309784"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="75309784"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 04:58:08 -0800
X-CSE-ConnectionGUID: Ugz/4magQtehsCwHA2s29A==
X-CSE-MsgGUID: J2CTL46ATPeAiMFkmMALLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="211028319"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 08 Feb 2026 04:58:06 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vp4MV-00000000mCU-3e7W;
	Sun, 08 Feb 2026 12:58:03 +0000
Date: Sun, 8 Feb 2026 20:57:06 +0800
From: kernel test robot <lkp@intel.com>
To: Maiquel Paiva <maiquelpaiva@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org, marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Bluetooth: mgmt: Fix race conditions in mesh
 handling
Message-ID: <202602082055.pF9xO7lP-lkp@intel.com>
References: <20260208081559.44983-3-maiquelpaiva@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208081559.44983-3-maiquelpaiva@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,linuxfoundation.org,holtmann.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214862-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: BB35B108AD0
X-Rspamd-Action: no action

Hi Maiquel,

kernel test robot noticed the following build errors:

[auto build test ERROR on bluetooth/master]
[also build test ERROR on bluetooth-next/master linus/master v6.19-rc8 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maiquel-Paiva/Bluetooth-mgmt-Fix-heap-overflow-in-mgmt_mesh_add/20260208-161842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20260208081559.44983-3-maiquelpaiva%40gmail.com
patch subject: [PATCH v4 2/2] Bluetooth: mgmt: Fix race conditions in mesh handling
config: i386-randconfig-r071-20260208 (https://download.01.org/0day-ci/archive/20260208/202602082055.pF9xO7lP-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260208/202602082055.pF9xO7lP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602082055.pF9xO7lP-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/bluetooth/mgmt_util.c:400:18: error: incompatible pointer types passing 'struct mutex *' to parameter of type 'spinlock_t *' (aka 'struct spinlock *') [-Werror,-Wincompatible-pointer-types]
     400 |         guard(spinlock)(&hdev->lock);
         |                         ^~~~~~~~~~~
   include/linux/spinlock.h:565:1: note: passing argument to parameter 'l' here
     565 | DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
         | ^
   include/linux/cleanup.h:508:60: note: expanded from macro 'DEFINE_LOCK_GUARD_1'
     508 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)               \
         |                                                                         ^
   include/linux/cleanup.h:490:77: note: expanded from macro '\
   __DEFINE_LOCK_GUARD_1'
     490 | static __always_inline class_##_name##_t class_##_name##_constructor(_type *l) \
         |                                                                             ^
   net/bluetooth/mgmt_util.c:422:18: error: incompatible pointer types passing 'struct mutex *' to parameter of type 'spinlock_t *' (aka 'struct spinlock *') [-Werror,-Wincompatible-pointer-types]
     422 |         guard(spinlock)(&hdev->lock);
         |                         ^~~~~~~~~~~
   include/linux/spinlock.h:565:1: note: passing argument to parameter 'l' here
     565 | DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
         | ^
   include/linux/cleanup.h:508:60: note: expanded from macro 'DEFINE_LOCK_GUARD_1'
     508 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)               \
         |                                                                         ^
   include/linux/cleanup.h:490:77: note: expanded from macro '\
   __DEFINE_LOCK_GUARD_1'
     490 | static __always_inline class_##_name##_t class_##_name##_constructor(_type *l) \
         |                                                                             ^
   2 errors generated.


vim +400 net/bluetooth/mgmt_util.c

   395	
   396	struct mgmt_mesh_tx *mgmt_mesh_find(struct hci_dev *hdev, u8 handle)
   397	{
   398		struct mgmt_mesh_tx *mesh_tx;
   399	
 > 400		guard(spinlock)(&hdev->lock);
   401	
   402		list_for_each_entry(mesh_tx, &hdev->mesh_pending, list) {
   403			if (mesh_tx->handle == handle)
   404				return mesh_tx;
   405		}
   406	
   407		return NULL;
   408	}
   409	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

