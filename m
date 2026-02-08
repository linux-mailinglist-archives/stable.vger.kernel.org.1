Return-Path: <stable+bounces-214861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FIeLWWIiGmGqgQAu9opvQ
	(envelope-from <stable+bounces-214861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 13:58:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A1A108AC1
	for <lists+stable@lfdr.de>; Sun, 08 Feb 2026 13:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18430300A3A0
	for <lists+stable@lfdr.de>; Sun,  8 Feb 2026 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C504D224AF0;
	Sun,  8 Feb 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YcXsUsWK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2FD22156C;
	Sun,  8 Feb 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770555488; cv=none; b=SjrQCsiUDJFUOBV1NWL7ryC4VHJ6sQlRdPQqRRcXuAQ3MjVGuGIWpWx8uYI6s4Y+oqmdoNKbdV7j/iRd9vJoTXcbPXuYgmR6j6VlpNbQbxqM1alHuCHgsktgMdSrn0kuEZHeT86a3u7rxPDn/62x8WqcsluBLseOHu8gZhx4TUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770555488; c=relaxed/simple;
	bh=soW8MhiDWvsWnFp+P1cfvouA80sgn7yY/bwBWI78YdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNN1Mqe4hwIO1U0QN1UHPYbkkD68ChRoJKmt7wR4KbTCb0HqBvYE2MwAaN2iXGZxm34oQlTxzGiFs+ttYhgTPBgMJD3HbbfKWUUL3tDwLduk72axVkJWVc3CvnIcr2fiw6kWOfy0/Vpytnupzr2E8BhqT//+8mCsqfV1MTmYfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YcXsUsWK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770555489; x=1802091489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=soW8MhiDWvsWnFp+P1cfvouA80sgn7yY/bwBWI78YdI=;
  b=YcXsUsWKIfUqBhaM3vV6Zw9QvSdSp/0jc42ezcxc3pmuUoHDDuNL0xQr
   v8HhAiCZkIAxNy+PCHyQePC818lYJ2lb+HK/oHfEp6NF47q3FqduiaJoy
   pwhMzQ5F0YQ84Vlr7OJO7RQXzFIhmUb6v/8IpoPqUI6BjcHezDVUmyxlj
   OJCuSJB1SHFfLuc2RvYQsxKysYEj+woK4ceLZWy4I1K3OAx9PGmhmZ4MI
   /P278XltAA6Z4d2YLquDptUY0UDhn4CsJX7ecr6nYUBAzLPZqm7mfCXCO
   QtAa+arc70nFINJBB5wVuE+O6tWpV/UdOHXepEQ0LvN3/paiXXJsoqKum
   g==;
X-CSE-ConnectionGUID: bPlnc7ZTTR+7mExYfmLpjw==
X-CSE-MsgGUID: M1MV+GKRQPGWoQ0SSVsVGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11694"; a="71591099"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="71591099"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 04:58:09 -0800
X-CSE-ConnectionGUID: j6T2Tzc7Q166JP+2Gly8jA==
X-CSE-MsgGUID: 25HPp1gpR96eMHgeY3HohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="241970699"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2026 04:58:06 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vp4MV-00000000mCS-3XQX;
	Sun, 08 Feb 2026 12:58:03 +0000
Date: Sun, 8 Feb 2026 20:57:05 +0800
From: kernel test robot <lkp@intel.com>
To: Maiquel Paiva <maiquelpaiva@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org, marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Bluetooth: mgmt: Fix race conditions in mesh
 handling
Message-ID: <202602082014.LJf0O75Y-lkp@intel.com>
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
	TAGGED_FROM(0.00)[bounces-214861-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 40A1A108AC1
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
config: sparc-randconfig-002-20260208 (https://download.01.org/0day-ci/archive/20260208/202602082014.LJf0O75Y-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260208/202602082014.LJf0O75Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602082014.LJf0O75Y-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/bluetooth/mgmt_util.c: In function 'mgmt_mesh_find':
>> net/bluetooth/mgmt_util.c:400:25: error: passing argument 1 of 'class_spinlock_constructor' from incompatible pointer type [-Werror=incompatible-pointer-types]
     400 |         guard(spinlock)(&hdev->lock);
         |                         ^~~~~~~~~~~
         |                         |
         |                         struct mutex *
   In file included from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_32.h:67,
                    from arch/sparc/include/asm/cmpxchg.h:7,
                    from arch/sparc/include/asm/atomic_32.h:17,
                    from arch/sparc/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_32.h:102,
                    from arch/sparc/include/asm/bitops.h:7,
                    from include/linux/bitops.h:67,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/sparc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/jiffies.h:7,
                    from include/linux/ktime.h:25,
                    from include/linux/poll.h:7,
                    from include/net/bluetooth/bluetooth.h:29,
                    from net/bluetooth/mgmt_util.c:26:
   include/linux/cleanup.h:490:77: note: expected 'spinlock_t *' {aka 'struct spinlock *'} but argument is of type 'struct mutex *'
     490 | static __always_inline class_##_name##_t class_##_name##_constructor(_type *l) \
   include/linux/cleanup.h:509:1: note: in expansion of macro '__DEFINE_LOCK_GUARD_1'
     509 | __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
         | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:565:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_1'
     565 | DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
         | ^~~~~~~~~~~~~~~~~~~
   net/bluetooth/mgmt_util.c: In function 'mgmt_mesh_add':
   net/bluetooth/mgmt_util.c:422:25: error: passing argument 1 of 'class_spinlock_constructor' from incompatible pointer type [-Werror=incompatible-pointer-types]
     422 |         guard(spinlock)(&hdev->lock);
         |                         ^~~~~~~~~~~
         |                         |
         |                         struct mutex *
   In file included from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_32.h:67,
                    from arch/sparc/include/asm/cmpxchg.h:7,
                    from arch/sparc/include/asm/atomic_32.h:17,
                    from arch/sparc/include/asm/atomic.h:7,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_32.h:102,
                    from arch/sparc/include/asm/bitops.h:7,
                    from include/linux/bitops.h:67,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/sparc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/jiffies.h:7,
                    from include/linux/ktime.h:25,
                    from include/linux/poll.h:7,
                    from include/net/bluetooth/bluetooth.h:29,
                    from net/bluetooth/mgmt_util.c:26:
   include/linux/cleanup.h:490:77: note: expected 'spinlock_t *' {aka 'struct spinlock *'} but argument is of type 'struct mutex *'
     490 | static __always_inline class_##_name##_t class_##_name##_constructor(_type *l) \
   include/linux/cleanup.h:509:1: note: in expansion of macro '__DEFINE_LOCK_GUARD_1'
     509 | __DEFINE_LOCK_GUARD_1(_name, _type, _lock)
         | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:565:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_1'
     565 | DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
         | ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/class_spinlock_constructor +400 net/bluetooth/mgmt_util.c

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

