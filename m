Return-Path: <stable+bounces-235679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TSgtAHSW2WlfrAgAu9opvQ
	(envelope-from <stable+bounces-235679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 02:31:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B573DDB83
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 02:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B01B3004D15
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C90282F04;
	Sat, 11 Apr 2026 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FfNCVnmu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848871A2C0B;
	Sat, 11 Apr 2026 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867501; cv=none; b=oRTZz6DtL/etVmZEUaIMBV2BqBji50tizcCT59oOAARB7uPflzJJz64dRSMK5b5TloTllkA4kmKSo28VY5x6GHZMiI1N4MersrcAqkIiA9AWLw7gNirgGpulJu4uWQrj23lRqXJVhpup6NHP30/bqQd410xI8Eb+HLxY6bqU7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867501; c=relaxed/simple;
	bh=dVDQNOGwtDFVlDJtIVCvFSoT4S89W4qmZQOGM/EHZxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfbB3TKPSrREskDQW54cBvdMPhMXLLevaAP6k0EGwrRgc94VXFxnfD/65g2QpE88D8kEVsslSAbz49BO247VAgjxf/s/WHIla3JG9JkbplmcEy7IKyZOfGmMR0Oye3EMTLxcHZbq+IvVW8p4t1oaG60mSXL11kPl/tk3fspAvoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FfNCVnmu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775867501; x=1807403501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dVDQNOGwtDFVlDJtIVCvFSoT4S89W4qmZQOGM/EHZxE=;
  b=FfNCVnmuMSkTHJ75qB+1TO6v6BdFKa28R6us/MAAXXPGwQ1srXchPlOe
   pUH7+TtKcBAQEBjyUBkAvni0oiFIEEYtO3WC1Zv0ITa1D9mgP8rJieK7z
   rjAEa1vwJx/wwy2q5tbvr1JbjzyleGEjQ3/2Q+ZjMpBGNrlFO10FkTpx7
   An1i95Dm6ZHWQJZPYbKh1H4zb49yVPMteNgCZ2Xbek3un9e14LoIpD28n
   IBw/ehCsdjafHtFMtatgjXsXm4hNBO2/eHrio6b++GTxtu/77ctSlpf3b
   7kGXa9lN+gqEd1Ka4yITEvNuPMelOS3MTvuffHG+SDSqJLY5ieF02cM2q
   g==;
X-CSE-ConnectionGUID: cg0xm7Y9TXivpToDgTgaVQ==
X-CSE-MsgGUID: 1ZU+6c8zQo+qTRlzj8a9xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="94467958"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="94467958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:31:40 -0700
X-CSE-ConnectionGUID: mfdpzJpeQdW45ctNkNwMTQ==
X-CSE-MsgGUID: JTzVCBYWS++fDNQuxIrmOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="226524924"
Received: from lkp-server01.sh.intel.com (HELO 3eaaf1a74b89) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 10 Apr 2026 17:31:38 -0700
Received: from kbuild by 3eaaf1a74b89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wBMG7-000000000UL-1RBI;
	Sat, 11 Apr 2026 00:31:35 +0000
Date: Sat, 11 Apr 2026 08:31:10 +0800
From: kernel test robot <lkp@intel.com>
To: Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Show CPU vulnerabilites correctly
Message-ID: <202604110810.YFUm5KE1-lkp@intel.com>
References: <20260409122348.2438400-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409122348.2438400-1-chenhuacai@loongson.cn>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-235679-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: C7B573DDB83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Huacai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v7.0-rc7 next-20260410]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/LoongArch-Show-CPU-vulnerabilites-correctly/20260411-011556
base:   linus/master
patch link:    https://lore.kernel.org/r/20260409122348.2438400-1-chenhuacai%40loongson.cn
patch subject: [PATCH] LoongArch: Show CPU vulnerabilites correctly
config: loongarch-randconfig-001-20260411 (https://download.01.org/0day-ci/archive/20260411/202604110810.YFUm5KE1-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260411/202604110810.YFUm5KE1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604110810.YFUm5KE1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/loongarch/kernel/cpu-probe.c:407:36: warning: 'struct device_attribute' declared inside parameter list will not be visible outside of this definition or declaration
     407 |                             struct device_attribute *attr, char *buf)
         |                                    ^~~~~~~~~~~~~~~~
>> arch/loongarch/kernel/cpu-probe.c:406:9: warning: no previous prototype for 'cpu_show_spectre_v1' [-Wmissing-prototypes]
     406 | ssize_t cpu_show_spectre_v1(struct device *dev,
         |         ^~~~~~~~~~~~~~~~~~~


vim +407 arch/loongarch/kernel/cpu-probe.c

   405	
 > 406	ssize_t cpu_show_spectre_v1(struct device *dev,
 > 407				    struct device_attribute *attr, char *buf)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

