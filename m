Return-Path: <stable+bounces-241958-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFOcM+OI8mlEsQEAu9opvQ
	(envelope-from <stable+bounces-241958-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:40:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A0549B1C6
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B23B3038AFA
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 22:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBBB438FF2;
	Wed, 29 Apr 2026 22:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGX4M6H3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B723B5304;
	Wed, 29 Apr 2026 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502409; cv=none; b=BWd0kF5PbYU05d3aBBlcQWjlOX+KTDBXctraj3oyKcBG6W1GKQE2vgCIHcjaM554YQAxQk/swXVLBn9m7lu7wUNlzucQo95FTIHCR/arygwmtK3pFyjCNz0br/P9R6ESpn6eYOJ0wslUT+mSKQz+k92kBeow0RFVcqaaPLw0fbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502409; c=relaxed/simple;
	bh=3BI/lWhI9SxVb1m3Bl2sciMIf9SP9rj77wH4xuxgpwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7hdbc70+DryFZGo7i0W6DNMCAbf8mbPWvcuSv/rn/vtKCk4ukGMyVnuFfqfjZNEvDvE0z9t+fwi3q5P/2JbIzu/JEFlMJD4Glh+x2eN609GBxEwxW/VLklR86TU4vLwx7qANxtyMe0wT5d/OFeh5+A2uzidiBfVg3OY8KMv9nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGX4M6H3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777502408; x=1809038408;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3BI/lWhI9SxVb1m3Bl2sciMIf9SP9rj77wH4xuxgpwI=;
  b=UGX4M6H34hmldHinU2WFbTB7bPdRV/wpc2GLK76mFUxC5Jq18UiAzqcN
   FYxL3i+mpOaCSVfBTI3KS7MiO/9X1OGx9lRnRdbm+OisHp4E9NG94/wC5
   GN/Y1G3ydXP2QrMp/al5TJKgr/42N/H54oG4FUjAt1h+0potbCePElhSH
   jUTRJKy8MagKT8YSEg+utaAdbPAZzom7YBw5BzRWjRIByB+3N2RjT+vzR
   9wcIXrzFQlq4rErMqJmcqStCCNOEc+9+DCt3fAbO/UZmBnQrqjNRk8yDX
   cehHtcuhjVXRcPSWd9WOWlV7VivdcdcQ1pgNXU4ffFPy4Sk6UM96lZfLz
   w==;
X-CSE-ConnectionGUID: Mb85oSVPSkWIc4H+ta0ETA==
X-CSE-MsgGUID: JnYTKA1mRYu3UFUcyzcrXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="82300141"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="82300141"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 15:40:08 -0700
X-CSE-ConnectionGUID: cKRv9UeZRVqfpGgESPXCPQ==
X-CSE-MsgGUID: BB03DqG1SqW9U5MiCPmFgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="238731195"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Apr 2026 15:40:04 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIDZY-00000000BbO-3PIY;
	Wed, 29 Apr 2026 22:40:00 +0000
Date: Thu, 30 Apr 2026 06:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/rtc: fix failed fallback RTC device registration
 handling
Message-ID: <202604300652.WxTbaLDu-lkp@intel.com>
References: <20260415193455.3869807-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415193455.3869807-1-lgs201920130244@gmail.com>
X-Rspamd-Queue-Id: 29A0549B1C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-241958-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,linux-foundation.org,aknet.ru,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

Hi Guangshuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on linus/master v7.1-rc1 next-20260429]
[cannot apply to tip/auto-latest tip/x86/core bp/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/x86-rtc-fix-failed-fallback-RTC-device-registration-handling/20260416-130623
base:   tip/master
patch link:    https://lore.kernel.org/r/20260415193455.3869807-1-lgs201920130244%40gmail.com
patch subject: [PATCH] x86/rtc: fix failed fallback RTC device registration handling
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20260430/202604300652.WxTbaLDu-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300652.WxTbaLDu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300652.WxTbaLDu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/rtc.c:142:2: error: use of undeclared identifier 'ret'
     142 |         ret = platform_device_register(&rtc_device);
         |         ^
   arch/x86/kernel/rtc.c:143:6: error: use of undeclared identifier 'ret'
     143 |         if (ret) {
         |             ^
   arch/x86/kernel/rtc.c:145:10: error: use of undeclared identifier 'ret'
     145 |                 return ret;
         |                        ^
   3 errors generated.


vim +/ret +142 arch/x86/kernel/rtc.c

   133	
   134	static __init int add_rtc_cmos(void)
   135	{
   136		if (cmos_rtc_platform_device_present)
   137			return 0;
   138	
   139		if (!x86_platform.legacy.rtc)
   140			return -ENODEV;
   141	
 > 142		ret = platform_device_register(&rtc_device);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

