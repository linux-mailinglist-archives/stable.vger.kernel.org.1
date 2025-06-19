Return-Path: <stable+bounces-154723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377EADFBC9
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 05:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195DC3B22AF
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 03:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C51C174A;
	Thu, 19 Jun 2025 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgqULIaO"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFAF747F;
	Thu, 19 Jun 2025 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750302969; cv=none; b=QVaI895ToVNvaLPL1DWExOKLLKUhOE67LdrvlNXHhw8+IOtm802wmRuxFbA7qH2/A+euy0Rn+oM+LfyMBUC3GqTMcIMJ6bnl6gpaZyb0dYlMAMZ4uLHB/QVcVBRNsuXqJl/FXKI8DEL40uLo4mVh9n8Qc3MWPXCSyK2PFsPbtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750302969; c=relaxed/simple;
	bh=5sH5Wz1HUKV90VGTx6qnpjtvAboF1jBUTgU2GkBERGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiEdM7PxswDyEHgvJ7yAH6pkcybtolmWXNlS16sKC0+8MTzHY0GqT9DT4b8t/J5TmquHouVhQj9GfrYDuRjzYlmxHT9d5SAuY2tnkeBvl0Gb+AIuHVmE3NvaoZt9mcwApzV/k4j+WXM8WxU34JSPffIxU6/0wnpmQZ32K61iTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgqULIaO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750302967; x=1781838967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5sH5Wz1HUKV90VGTx6qnpjtvAboF1jBUTgU2GkBERGc=;
  b=kgqULIaO3cP3ogbPqcc3OgU5I7SYDuk8caxkSSVrAEC497xFru9hTxd4
   1aAzwoGkQu1xIKFj1VN9NWG0mkcwUZUEEmHM1FeIDOM/eLbAAA1zp3H+z
   tGjbl2Q5SknFERQYJcSSNf2ZOzT88sxnLPMmFfOQ26xtdElA6gYLBGGKo
   YF+hlYxWEBA4bRzx3iaR/w02w78Hxf4Uol9OmGHqUOkivfmhV2vzWtcem
   LJMdpQOiX1hF8ccgBN47HmWQHyvgIjNAr0dDo7bdDKKKo2VrW7Fzq4GoS
   KG0VJNOSLeGcnCZ/DeebAJPZe3hiKZhHRx/9oxNrvGLBbrQLpQSDsDbtU
   g==;
X-CSE-ConnectionGUID: x7KsbY7pTbCYC+Vop7LfRw==
X-CSE-MsgGUID: 5i0hITkbSbWnym9D+5dDLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52411221"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="52411221"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 20:16:07 -0700
X-CSE-ConnectionGUID: hjOCqu8GQ3uqYhmM01HOgw==
X-CSE-MsgGUID: 0YJZIqslRDWbDMWq6F3Mng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="154345832"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Jun 2025 20:16:04 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uS5kw-000KMg-0W;
	Thu, 19 Jun 2025 03:16:02 +0000
Date: Thu, 19 Jun 2025 11:15:38 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	westeri@kernel.org, YehezkelShB@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
	Alexander Kovacs <Alexander.Kovacs@amd.com>,
	mika.westerberg@linux.intel.com, linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix wake on connect at runtime
Message-ID: <202506191059.us9cF6qt-lkp@intel.com>
References: <20250618145911.3266251-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618145911.3266251-1-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on westeri-thunderbolt/next]
[also build test WARNING on linus/master v6.16-rc2 next-20250618]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/thunderbolt-Fix-wake-on-connect-at-runtime/20250618-230420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git next
patch link:    https://lore.kernel.org/r/20250618145911.3266251-1-superm1%40kernel.org
patch subject: [PATCH] thunderbolt: Fix wake on connect at runtime
config: parisc-randconfig-r072-20250619 (https://download.01.org/0day-ci/archive/20250619/202506191059.us9cF6qt-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250619/202506191059.us9cF6qt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506191059.us9cF6qt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/thunderbolt/usb4.c:409 function parameter 'runtime' not described in 'usb4_switch_set_wake'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

