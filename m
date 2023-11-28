Return-Path: <stable+bounces-3093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A977FC8FE
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 23:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D558A1C20E74
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0399481AD;
	Tue, 28 Nov 2023 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6JXJw/F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986F198
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 14:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701208895; x=1732744895;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=5KI3is8YLLHz1vFiO6Rb3+hK1YP9s0d+k3YCz6I9Rm0=;
  b=d6JXJw/Fcwa6Fj2Vl83OweQOYN6lmXQI2wyreXD3ZpvDSDx3chR6k4ja
   dJXaR8YEk+bQgem6Bdy/838LwBzMHFujT1w+R+0mnYbdheI0ucFAXfX+0
   3TpbzAMbZEx8Erq2w7K0t4v3sbguYhqvOwasd97RBlY6B88ml2i0K4eHD
   1tJ2jdOrLvm6DzEWE3jwlMi2dogkJXrjoWgBAlY4JucF8Taa27SvQ3CFi
   adTralhvR5ec7NmfxH/N9iJJcgXUxxy9e7UjgiIjxE0l2vs75Lj2RC7Jq
   Gewf3kuBLCV+iHkx5MP/pRJIeCACXx70MiI+ltlAprDpUvpszanukA+tI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="373221026"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="373221026"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:01:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="718531332"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="718531332"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2023 14:01:33 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r8694-0008Ae-2U;
	Tue, 28 Nov 2023 22:01:30 +0000
Date: Wed, 29 Nov 2023 05:59:55 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] NFSD: Fix "start of NFS reply" pointer passed to
 nfsd_cache_update()
Message-ID: <ZWZi2y1vDXZF9BBJ@520bc4c78bef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170120871426.1376.10151990384789497254.stgit@klimt.1015granger.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/2] NFSD: Fix "start of NFS reply" pointer passed to nfsd_cache_update()
Link: https://lore.kernel.org/stable/170120871426.1376.10151990384789497254.stgit%40klimt.1015granger.net

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




