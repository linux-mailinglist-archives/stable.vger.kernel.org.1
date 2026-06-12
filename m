Return-Path: <stable+bounces-262909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NlfkCtjkK2oAHQQAu9opvQ
	(envelope-from <stable+bounces-262909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 12:52:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E533678CB1
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 12:52:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=ROG16Wg1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262909-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262909-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4ECD73010205
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 10:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B98D37418C;
	Fri, 12 Jun 2026 10:52:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32BC20C00C;
	Fri, 12 Jun 2026 10:51:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261521; cv=none; b=LzlA8YS3/TfisX08N/dg5nd7J/aJlWmS9yWuKh8Ps5Xycxc+UHwfOEA/EeTXMNPg6qrl1F1LX7KhjpBbmpDrDq0fgoi05/OtYQEjHRW2GuQ7J1rWB4dJ9XK11iHn+2JvHmudBRcdk4ivAGpboePKJmM8OxVYyOnU6ANK5M0p6Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261521; c=relaxed/simple;
	bh=pMOnB/VdBXmdUjIVbiD9nrvItT0vIkK1YmjB2wpMXxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B14Xsq007rA3eEzTCiiZBBuNbJE2xOwiwdNEW8HsjE35j99pZAI8Jr50D2g1Pc20RtEP+Da4xbTWR4JFwG0j4UFE5bPJdDnbP/Dsx080ZeGJmzrw0vrb36nCwVZjY/GpW5SsELoXwds1lm4+juWCwbVT5t14XKYe+AlE5bmXtIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROG16Wg1; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781261518; x=1812797518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pMOnB/VdBXmdUjIVbiD9nrvItT0vIkK1YmjB2wpMXxQ=;
  b=ROG16Wg1KhrMWbKcNk5AWmYsE6lr7ewwPhPJxc66EO3FWyu1rzgesx06
   hEbQYFiBIspy9zIAMNILIr2Swxg4uIwLCOB3dk7IvWEUlgYYk9aaxHKxY
   j55N+KAFDEjMl/OMeuj33pcIppEVkHCfO35jogXGvqU+4A/jpb1Tud+Vn
   w9qb9DI5DNVsL7m11zsLe8dCePoSJLUn+Lx2DVoaf/moPKUvjytQTypHU
   EFeiuq6ALN5y8fmDcVSu/sokad7YxU9moOCIFjN8KTUIq99gZ2y0zCsT+
   8Bz7bKg0M6g3QSEjVFT0oNj6fOLltp0LUR64GFWstnpz/uCP3VUKSp8OY
   A==;
X-CSE-ConnectionGUID: gzHeI798RLqvVJKvPLnBFA==
X-CSE-MsgGUID: smLuZ+gRSwuIHMk9q1eurQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81225541"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81225541"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 03:51:57 -0700
X-CSE-ConnectionGUID: +m0b2O1nRG2ZVT/wGcft6Q==
X-CSE-MsgGUID: K7G8RJqfQ3ytrgkqBeLqGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="270834789"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jun 2026 03:51:55 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXzUO-00000000OdB-1fzT;
	Fri, 12 Jun 2026 10:51:52 +0000
Date: Fri, 12 Jun 2026 18:51:04 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Zeng <kylebot@openai.com>, jfs-discussion@lists.sourceforge.net
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>, outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] jfs: validate active AG before updating db_active
Message-ID: <202606121834.MtsXleJq-lkp@intel.com>
References: <20260611212956.10206-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611212956.10206-1-kylebot@openai.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262909-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:jfs-discussion@lists.sourceforge.net,m:llvm@lists.linux.dev,m:oe-kbuild-all@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:brauner@kernel.org,m:shaggy@kernel.org,m:outbounddisclosures@openai.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,git-scm.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E533678CB1

Hi Kyle,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master kleikamp-shaggy/jfs-next v7.1-rc7 next-20260611]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Zeng/jfs-validate-active-AG-before-updating-db_active/20260612-054255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260611212956.10206-1-kylebot%40openai.com
patch subject: [PATCH] jfs: validate active AG before updating db_active
config: s390-defconfig (https://download.01.org/0day-ci/archive/20260612/202606121834.MtsXleJq-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606121834.MtsXleJq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606121834.MtsXleJq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/jfs/file.c:52:3: error: call to undeclared function 'jfs_error'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      52 |                 jfs_error(inode->i_sb,
         |                 ^
   fs/jfs/file.c:52:3: note: did you mean 'xas_error'?
   include/linux/xarray.h:1435:19: note: 'xas_error' declared here
    1435 | static inline int xas_error(const struct xa_state *xas)
         |                   ^
   1 error generated.


vim +/jfs_error +52 fs/jfs/file.c

    43	
    44	static int jfs_get_active_ag(struct inode *inode, int *agp)
    45	{
    46		struct jfs_inode_info *ji = JFS_IP(inode);
    47		struct jfs_sb_info *sbi = JFS_SBI(inode->i_sb);
    48		struct bmap *bmap = sbi->bmap;
    49		u64 ag = BLKTOAG(addressPXD(&ji->ixpxd), sbi);
    50	
    51		if (ag >= bmap->db_numag) {
  > 52			jfs_error(inode->i_sb,
    53				  "inode %lu has invalid active ag %llu\n",
    54				  inode->i_ino, (unsigned long long)ag);
    55			return -EIO;
    56		}
    57	
    58		*agp = ag;
    59		return 0;
    60	}
    61	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

