Return-Path: <stable+bounces-241986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMXvNc/V8mnIugEAu9opvQ
	(envelope-from <stable+bounces-241986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:08:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC4649D33B
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3720F300D603
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E0335A3B1;
	Thu, 30 Apr 2026 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amORS5h5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04783247291;
	Thu, 30 Apr 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522124; cv=none; b=W3UafDhsOepwfIK83XeDNNSzUFOAMta+ogQY2RHUyVX+Hb85DpuGX+FgEC7HRhxruPdw7IX5HkF7tzCu+MWvFNOUegq1B/g8V2M520bJmTnkLDUP+b0ZloUcXCOdrY4QcVKMuFxZrEMGPigYddJvpYcAYBTWmJndM2DKzqbeGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522124; c=relaxed/simple;
	bh=3vodAGxGv7v9csp3ANmz5QgI5mL6m1EjmRlVUSN3/Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIE9hZpxq+wVHDOYHoI89vv4npnArmLJ7FvA7Z1EPAsxqPQbK+5rrQ2f1pZ9hLO1di/Ys7Rt0F+9P3qccOJSekKy0kK+Z+QVG/sXaaVusXNmtIF6au9Pa9ISfOwHZxPHbUk73GfPrtEldnYHU2pKSem/3k9n2BHTS7G9ER4JdJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amORS5h5; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777522123; x=1809058123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3vodAGxGv7v9csp3ANmz5QgI5mL6m1EjmRlVUSN3/Wc=;
  b=amORS5h5vLBlX9lQxRC3At+yFUg+LwMVAHEa0K62guayDOU9j0h5U+O4
   M1htni8jpE3In8u3VWnaYlnkITVuNTfABKWK0kyIBsCSNDHZG/igBnQTi
   493JI4NvyyAqpgBIDEkM4KlbaAw3r1+5Gm9Y/lqhjFXqbv0c6fGS+rkWW
   GHsxE3O+47+MOOHddw/o0V6sgxuuKRe76iG/kOkOoncdIoCPjISrjFeEV
   yyDRzrBxkMqXs7X8ftk91fspEuthPuGUcglolLnh45ablBahTnpbB7LGl
   QAZ4PUTsVPqjbbjXefjqvBDIiVZXIaDbF9Q7B6rjJubKDEOWCR1onCXzp
   g==;
X-CSE-ConnectionGUID: qtuCcKV0QOGsv3caeCMCGA==
X-CSE-MsgGUID: FaoU7bWsQseifGTJ3kS92A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78568233"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="78568233"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 21:08:43 -0700
X-CSE-ConnectionGUID: lkl76AHER5WlSDDVYqQ4Wg==
X-CSE-MsgGUID: JPYFO7GLS6GM9zJf+FZG5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="238438414"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 29 Apr 2026 21:08:40 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIIhZ-00000000BvE-1V0B;
	Thu, 30 Apr 2026 04:08:37 +0000
Date: Thu, 30 Apr 2026 12:07:53 +0800
From: kernel test robot <lkp@intel.com>
To: SnailSploit | Kai Aizen <kai.aizen.dev@gmail.com>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, tipc-discussion@lists.sourceforge.net,
	jmaloy@redhat.com, ying.xue@windriver.com, kuba@kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org,
	Kai Aizen <kai.aizen.dev@gmail.com>
Subject: Re: [PATCH] [PATCH net] tipc: fix UAF race in
 tipc_mon_peer_up/down/remove_peer vs bearer teardown
Message-ID: <202604301148.jfXKC9HF-lkp@intel.com>
References: <20260415061211.45530-1-95986478+SnailSploit@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415061211.45530-1-95986478+SnailSploit@users.noreply.github.com>
X-Rspamd-Queue-Id: 4FC4649D33B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,lists.sourceforge.net,redhat.com,windriver.com,kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241986-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url]

Hi SnailSploit,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/SnailSploit-Kai-Aizen/tipc-fix-UAF-race-in-tipc_mon_peer_up-down-remove_peer-vs-bearer-teardown/20260425-075205
base:   net/main
patch link:    https://lore.kernel.org/r/20260415061211.45530-1-95986478%2BSnailSploit%40users.noreply.github.com
patch subject: [PATCH] [PATCH net] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer vs bearer teardown
config: arc-randconfig-002-20260430 (https://download.01.org/0day-ci/archive/20260430/202604301148.jfXKC9HF-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604301148.jfXKC9HF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604301148.jfXKC9HF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/tipc/monitor.c:112:29: warning: 'tipc_monitor_rtnl' defined but not used [-Wunused-function]
    static struct tipc_monitor *tipc_monitor_rtnl(struct net *net, int bearer_id)
                                ^~~~~~~~~~~~~~~~~


vim +/tipc_monitor_rtnl +112 net/tipc/monitor.c

   110	
   111	/* tipc_monitor_rtnl - dereference monitors[] from RTNL-held control path. */
 > 112	static struct tipc_monitor *tipc_monitor_rtnl(struct net *net, int bearer_id)
   113	{
   114		return rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
   115	}
   116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

