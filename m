Return-Path: <stable+bounces-262902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YR5sJLXVK2oFGAQAu9opvQ
	(envelope-from <stable+bounces-262902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:47:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF656786B4
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 11:47:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=eD0RBu9b;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262902-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262902-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7E9C30374A4
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7FD39769B;
	Fri, 12 Jun 2026 09:45:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927736657B;
	Fri, 12 Jun 2026 09:45:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257555; cv=none; b=WACWWD8qupbbb2BGuiaUn968SB6isd849loVKdYpC/rCezH2s6iJyQNb6+LBzEGNI/cfcFYL1vNz1jcdX6+UGMpSRdjZza55vWxF7ub7sTjxK5LNIc6XA79rLepVF2ecp0hGDMmCBuej6BON7ZkpnyvkWvNJ51gpTWk+/mRr/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257555; c=relaxed/simple;
	bh=5kZYGlAIeZV0FMnxTw7YDi5SkMcsdsV5OoS4J4WqUhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB3YYO4YHHrypzUKSDHem7JyoKqwR8U9r+nsPXUdOo/g31bOQtJMkP8dsCBP12e/oOc3R6hfnAsHXk+FoSk+wqvweqKPkU3cGTyZyIg4rVt61POMUywImseggioL11iEDMbvBYzEONbhQhCRXXdjCpbIYLC9RH3LDDOgjnq3cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eD0RBu9b; arc=none smtp.client-ip=198.175.65.21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781257554; x=1812793554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5kZYGlAIeZV0FMnxTw7YDi5SkMcsdsV5OoS4J4WqUhw=;
  b=eD0RBu9bwRYnNWh+qQoO7sankAGw9m1EP50hbHA1iTQSXui4G1RI0qQ6
   /KWAwFpPYP2SSZ4K4cPggt2AsWgoONhAzvbjIzyBxpbYTs7Td4seO+XAT
   elF9UUkVJMfYzpJkZFomiLCZ5+RWQbOXy1QrTDmgIpvqanHMBcJXtM4wk
   Y43D28cf61eJQ+7cqn4DzTnziNIbSjZdCHr6FqaLOVXB8wCrzqAWXry/a
   DuHmlEqd3CYsGbzIPczl5m2OQftGP4VcL/eRVEFBYsskY6NLKjWz9H+WC
   oBfphyh1Lits20rIh6f2Nl2BV1YDfsSc23Sq4fG405X3XxgLmxtMqG9sW
   A==;
X-CSE-ConnectionGUID: XazpO8uESweiLnUpBRdD6A==
X-CSE-MsgGUID: Ry12DRWaSXG8/2GglOfLyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81992484"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="81992484"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:45:53 -0700
X-CSE-ConnectionGUID: XwyvusprSpCsORDhyLtpDQ==
X-CSE-MsgGUID: vltGDbzWR7+p4T3OmRE3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="248664732"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Jun 2026 02:45:51 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXySS-00000000OZl-3xFe;
	Fri, 12 Jun 2026 09:45:48 +0000
Date: Fri, 12 Jun 2026 17:45:39 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Zeng <kylebot@openai.com>, jfs-discussion@lists.sourceforge.net
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Dave Kleikamp <shaggy@kernel.org>, outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>, stable@vger.kernel.org
Subject: Re: [PATCH] jfs: validate active AG before updating db_active
Message-ID: <202606121758.6bifYIqm-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262902-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kylebot@openai.com,m:jfs-discussion@lists.sourceforge.net,m:oe-kbuild-all@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:brauner@kernel.org,m:shaggy@kernel.org,m:outbounddisclosures@openai.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,01.org:url,git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFF656786B4

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
config: s390-randconfig-002-20260612 (https://download.01.org/0day-ci/archive/20260612/202606121758.6bifYIqm-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260612/202606121758.6bifYIqm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606121758.6bifYIqm-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/jfs/file.c: In function 'jfs_get_active_ag':
>> fs/jfs/file.c:52:3: error: implicit declaration of function 'jfs_error'; did you mean 'xas_error'? [-Werror=implicit-function-declaration]
      jfs_error(inode->i_sb,
      ^~~~~~~~~
      xas_error
   cc1: some warnings being treated as errors


vim +52 fs/jfs/file.c

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

