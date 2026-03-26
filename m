Return-Path: <stable+bounces-230508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOU8OAJsxWl1+AQAu9opvQ
	(envelope-from <stable+bounces-230508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:25:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC63391D4
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70BE4301CCC2
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6EF3B2FD3;
	Thu, 26 Mar 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzJZhbZw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168FF413259;
	Thu, 26 Mar 2026 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545833; cv=none; b=u3Kcj/QelIocoYEPmw3d/pA2S0qCa3k0kT50Vl+8Z8Srx75wWwYO1oRwhFmZaembd8Eu1G26dBbDqSgXehQurv9oxFj9Cv5Ug3rHGCo/THpghv1/m69wH4PWDftEc9/kwaujCSEZTzGZvc6EhBH1cHZb3NRZD+OkmaYzt3N8+/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545833; c=relaxed/simple;
	bh=jJmlpac80zwUsAWqRFRE5W5E4jpys3n9j4q3g4U5Cwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXBmdegZSm5Wq9iSYsnbMwEuXhCMIIsKmC2evzIEnwF03y0YxyrPKtwth5u9LJ8eivGVJo3X4Ex/iMR4BbvBr3Qh8HEFQHohq8406TrOuA2SReOr3LpVUns5+oYTcBlEue5EdpNOL19NfBm6x482dovtvpDl+aQjMmlQkdmLeUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzJZhbZw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774545830; x=1806081830;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJmlpac80zwUsAWqRFRE5W5E4jpys3n9j4q3g4U5Cwg=;
  b=ZzJZhbZw8cs6Wx1OtNEh9LepJUYMnq20VL+f8GbNvyd4ph3/HcS6TWOE
   gQvOuNYlLUdtrWJZ2iFNFVU/YoNrQ04NBeO04tonXsmJitoV6m2c2pkT+
   NHDTPQo9ZC7314JPme6SakdkbR/5ZwcJdE2gf7/KLZg5R+NrZ/bHmeqNh
   FJ6sPFt6WBAsYcac458qhRyigvPpRRl8xLdu9U/1/KBvuYn6O1MWFuxue
   kbvgZfmWqg0oM9wfr9+INU2dwQfxm+FZ2xGhW+80LkaMozAMVV0/lUmNB
   yAtC4mkoxESYE9QwpbZlLzQSHqIzKXlJXfvaF8VBaM2Sg6COhoCiQwETn
   A==;
X-CSE-ConnectionGUID: hJegtfcAQTaM7YLqCkkfZw==
X-CSE-MsgGUID: RgBL1HBxToKRS5qcRPRbdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75631368"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75631368"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 10:23:48 -0700
X-CSE-ConnectionGUID: XtXiMnUSROec8CzTHDfHvw==
X-CSE-MsgGUID: rU9dt+OTTjSVhCuTuzamLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="218464915"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Mar 2026 10:23:45 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5oQo-0000000097J-2irT;
	Thu, 26 Mar 2026 17:23:42 +0000
Date: Fri, 27 Mar 2026 01:23:10 +0800
From: kernel test robot <lkp@intel.com>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	shubhrajyoti.datta@amd.com, bp@alien8.de, tony.luck@intel.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] EDAC/versalnet: Fix device name memory leak
Message-ID: <202603270107.jJ92lLm3-lkp@intel.com>
References: <20260322131149.1684771-1-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322131149.1684771-1-ptsm@linux.microsoft.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-230508-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CDC63391D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Prasanna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260320]
[cannot apply to ras/edac-for-next linus/master v7.0-rc5 v7.0-rc4 v7.0-rc3 v7.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Prasanna-Kumar-T-S-M/EDAC-versalnet-Release-reference-to-remoteproc-device-in-remove/20260324-014933
base:   next-20260320
patch link:    https://lore.kernel.org/r/20260322131149.1684771-1-ptsm%40linux.microsoft.com
patch subject: [PATCH 5/5] EDAC/versalnet: Fix device name memory leak
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260327/202603270107.jJ92lLm3-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603270107.jJ92lLm3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603270107.jJ92lLm3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/edac/versalnet_edac.c:163 struct member 'mci_name' not described in 'mc_priv'
>> Warning: drivers/edac/versalnet_edac.c:163 struct member 'mci_name' not described in 'mc_priv'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

