Return-Path: <stable+bounces-238464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LWTKEv04WnT0AAAu9opvQ
	(envelope-from <stable+bounces-238464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:50:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9360418F08
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D22D2302617D
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5153B0AF8;
	Fri, 17 Apr 2026 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6gjYnys"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9408337267A;
	Fri, 17 Apr 2026 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415647; cv=none; b=Fl5wiCs+cfe94eevVarKIvtgyNMzqFiAefewmCarU9M/u6RxqlgHZzqXZMcQ5rMBIClITxPU1TkZHAtiVwAMK8J1geT7/f08Zz9qrH9hQ7fCd89kBaI38CtU5h/RK+0SJnpoamw4tqyu1PERW6lMgEerhEh3uA03iRGf5GDF/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415647; c=relaxed/simple;
	bh=wxUNApV633COIbhu4Xx2lJEqtFqLK8JVUO2pg0Q4brE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAXa1lkRtwsWkDhKE1y1Fdl+lZAAM33rBXjfcqMxVAmPjsBwwYIOj7wWOH+OlLhVU0r8cEuoMYd5Zjgajhrt/HPbBSfw7UuhbenNwfHXIdE7dxnHAwaTe1p9G4q18wUjVBItQBd3AvB1yzLNBkU0PbfwuSkY2z5myYmTiRm0z1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6gjYnys; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776415644; x=1807951644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wxUNApV633COIbhu4Xx2lJEqtFqLK8JVUO2pg0Q4brE=;
  b=J6gjYnys+3qGpxiZXisBzOUD2AbmjyHSFSdBruZry/doP4YZxtx1vUVP
   JIClbRAC9gXADAbURiPaiOrpo6Taj34L2EMks8ViwGm6WtdSaUJ2St9bv
   fJlCTu33b6B9q8BuXkVaKYX7797JqNuJCnrHDFBcgXbvK6Er5lD1zmgey
   ToXT+qNCc/7PQLGzJjuvmjoRDPYrNY9AE1fm4phyEFFa3aKeKQ9DchtT6
   9nCmt99Iax1d7oHcbPV164/9jav+KG/+uXWBg/hV1gzUOgFZKa/v5VzOX
   YRq4A2XFI02tyw8HTySiDqlxhw2Q/dXDvU15NC7OVijk0R9+b2+VPS0ws
   g==;
X-CSE-ConnectionGUID: QMUAUYtlRhaB2mExyulHAA==
X-CSE-MsgGUID: P0l9VpjRTpWbB8ey7+uyuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77337556"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77337556"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:47:24 -0700
X-CSE-ConnectionGUID: DogULTTsS2OPAZEbXrka1A==
X-CSE-MsgGUID: X4eVROXqTSi/ns/gTSMauQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="230911379"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 17 Apr 2026 01:47:22 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDer9-0000000008b-1BLm;
	Fri, 17 Apr 2026 08:47:19 +0000
Date: Fri, 17 Apr 2026 16:46:57 +0800
From: kernel test robot <lkp@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, Olof Johansson <olof@lixom.net>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: fix reference leak on failed device
 registration
Message-ID: <202604171609.wl8JLCit-lkp@intel.com>
References: <20260415175038.3633384-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415175038.3633384-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238464-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,chromium.org,kernel.org,lixom.net,lists.linux.dev,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D9360418F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Guangshuo,

kernel test robot noticed the following build errors:

[auto build test ERROR on chrome-platform/for-next]
[also build test ERROR on chrome-platform/for-firmware-next linus/master v7.0 next-20260416]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guangshuo-Li/platform-chrome-fix-reference-leak-on-failed-device-registration/20260416-135638
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next
patch link:    https://lore.kernel.org/r/20260415175038.3633384-1-lgs201920130244%40gmail.com
patch subject: [PATCH] platform/chrome: fix reference leak on failed device registration
config: x86_64-randconfig-013-20260417 (https://download.01.org/0day-ci/archive/20260417/202604171609.wl8JLCit-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260417/202604171609.wl8JLCit-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604171609.wl8JLCit-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/platform/chrome/chromeos_pstore.c:131:3: error: use of undeclared identifier 'ret'
     131 |                 ret = platform_device_register(&chromeos_ramoops);
         |                 ^
   drivers/platform/chrome/chromeos_pstore.c:132:7: error: use of undeclared identifier 'ret'
     132 |                 if (ret)
         |                     ^
   drivers/platform/chrome/chromeos_pstore.c:135:10: error: use of undeclared identifier 'ret'
     135 |                 return ret;
         |                        ^
   3 errors generated.


vim +/ret +131 drivers/platform/chrome/chromeos_pstore.c

   119	
   120	static int __init chromeos_pstore_init(void)
   121	{
   122		bool acpi_dev_found;
   123	
   124		if (ecc_size > 0)
   125			chromeos_ramoops_data.ecc_info.ecc_size = ecc_size;
   126	
   127		/* First check ACPI for non-hardcoded values from firmware. */
   128		acpi_dev_found = chromeos_check_acpi();
   129	
   130		if (acpi_dev_found || dmi_check_system(chromeos_pstore_dmi_table)) {
 > 131			ret = platform_device_register(&chromeos_ramoops);
   132			if (ret)
   133				platform_device_put(&chromeos_ramoops);
   134	
   135			return ret;
   136		}
   137	
   138		return -ENODEV;
   139	}
   140	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

