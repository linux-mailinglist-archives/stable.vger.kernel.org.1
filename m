Return-Path: <stable+bounces-240295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZZVgN/+M6Gl/MQIAu9opvQ
	(envelope-from <stable+bounces-240295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:55:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3964D443AC3
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6A83007F58
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2DE3BFE3C;
	Wed, 22 Apr 2026 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Df/kHEcK"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3153B27F3;
	Wed, 22 Apr 2026 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848121; cv=none; b=V9I5iGkvcsd0utm0Jy86/K8kQHNr24yVHs2mBkluFy0095gfEAzWIxmmBdBAllfabuMCoXSAneNKox6AT6JoWXAJqrAB95A0frOWm8UeWrwhJre2ILHFZkxp0gT2mqF2MXgSCGhjU52GUAolvNqHJG7KNj2qMFG7WW17P7vv9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848121; c=relaxed/simple;
	bh=eOkmPRPYTp5oCLIg6v7jpCiPYUCRmqpat94cyp5tfUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ+D6rON+FG/q577FV3bNMDi9o6x35SMfwn11Ko+X1XOLsfK+yjTxPXGQbz03MnhQTRgekVdJ2Ej9lV2xyHF0SckJ14iXRmOiLfgFKWFbsGbqoqTJPx5WBnTq83Zmf0b+glzSzmEDPT6kAFctj8QbJca+aRkUTROCjIyuHpQlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Df/kHEcK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776848120; x=1808384120;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eOkmPRPYTp5oCLIg6v7jpCiPYUCRmqpat94cyp5tfUg=;
  b=Df/kHEcKnF4238D536U4MLTkZ+ubRIB9DJkaiQpFcUj6GJzG7qzb3UHS
   ZvQ138wpbkzJspo14b+GvUVVrR+kB7y8WA/+IsrWCx9JM0mxdpwriT+Qv
   Pdkfi2Ki+gk870icqc9XVcabvz2QQg0SqiY8PhEca/zVTC2nQCTv9ENcW
   mc4EQuJI8OqoZU9BMycBJjHZez7lWh88JI1EECXw0ugYTfrAzVg0tKD3X
   ABOYCKDgXobUWJKQNG2kXDWZyLbLhy8uAu0ydI1W8c/JS3Kj452nTGZp6
   yIGJlA7teXI3L51r/9rsFYFmDaBxOzCbIdk7S3tPYT20B9MP6CF8M0qZ3
   w==;
X-CSE-ConnectionGUID: lfkZHd4pSTGfFBJ/Kvpffw==
X-CSE-MsgGUID: la0PjGMFRcO0MMg7LDGuUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="76958548"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="76958548"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:55:19 -0700
X-CSE-ConnectionGUID: BufUmKSQSnqvnke0qTAdQA==
X-CSE-MsgGUID: YFpuhfBWSr+3MjDBZSbH1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232204588"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 22 Apr 2026 01:55:16 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wFTMX-000000000Ll-0gKp;
	Wed, 22 Apr 2026 08:55:13 +0000
Date: Wed, 22 Apr 2026 16:54:41 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/pseries/papr-hvpipe: fix NULL dereference in
 handle creation
Message-ID: <202604221653.KzDQsCY8-lkp@intel.com>
References: <20260420132429.128075-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420132429.128075-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240295-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.ibm.com,ellerman.id.au,kernel.org,lists.ozlabs.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 3964D443AC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guangshuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes linus/master v7.0 next-20260421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/powerpc-pseries-papr-hvpipe-fix-NULL-dereference-in-handle-creation/20260420-224327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/20260420132429.128075-1-lgs201920130244%40gmail.com
patch subject: [PATCH v2] powerpc/pseries/papr-hvpipe: fix NULL dereference in handle creation
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20260422/202604221653.KzDQsCY8-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260422/202604221653.KzDQsCY8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604221653.KzDQsCY8-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/platforms/pseries/papr-hvpipe.c: In function 'papr_hvpipe_dev_create_handle':
>> arch/powerpc/platforms/pseries/papr-hvpipe.c:513:24: error: invalid use of void expression
     513 |         owned_src_info = retain_and_null_ptr(src_info);
         |                        ^


vim +513 arch/powerpc/platforms/pseries/papr-hvpipe.c

   479	
   480	static int papr_hvpipe_dev_create_handle(u32 srcID)
   481	{
   482		struct hvpipe_source_info *src_info __free(kfree) = NULL;
   483		struct hvpipe_source_info *owned_src_info;
   484	
   485		spin_lock(&hvpipe_src_list_lock);
   486		/*
   487		 * Do not allow more than one process communicates with
   488		 * each source.
   489		 */
   490		src_info = hvpipe_find_source(srcID);
   491		if (src_info) {
   492			spin_unlock(&hvpipe_src_list_lock);
   493			pr_err("pid(%d) is already using the source(%d)\n",
   494					src_info->tsk->pid, srcID);
   495			return -EALREADY;
   496		}
   497		spin_unlock(&hvpipe_src_list_lock);
   498	
   499		src_info = kzalloc_obj(*src_info, GFP_KERNEL_ACCOUNT);
   500		if (!src_info)
   501			return -ENOMEM;
   502	
   503		src_info->srcID = srcID;
   504		src_info->tsk = current;
   505		init_waitqueue_head(&src_info->recv_wqh);
   506	
   507		FD_PREPARE(fdf, O_RDONLY | O_CLOEXEC,
   508			   anon_inode_getfile("[papr-hvpipe]", &papr_hvpipe_handle_ops,
   509					      (void *)src_info, O_RDWR));
   510		if (fdf.err)
   511			return fdf.err;
   512	
 > 513		owned_src_info = retain_and_null_ptr(src_info);
   514		spin_lock(&hvpipe_src_list_lock);
   515		/*
   516		 * If two processes are executing ioctl() for the same
   517		 * source ID concurrently, prevent the second process to
   518		 * acquire FD.
   519		 */
   520		if (hvpipe_find_source(srcID)) {
   521			spin_unlock(&hvpipe_src_list_lock);
   522			return -EALREADY;
   523		}
   524		list_add(&owned_src_info->list, &hvpipe_src_list);
   525		spin_unlock(&hvpipe_src_list_lock);
   526		return fd_publish(fdf);
   527	}
   528	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

