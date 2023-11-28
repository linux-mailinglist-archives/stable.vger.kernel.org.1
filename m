Return-Path: <stable+bounces-3099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B1C7FC913
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 23:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9CEB21314
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F2D481B1;
	Tue, 28 Nov 2023 22:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiWsexO6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E7E19A
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701209249; x=1732745249;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Pxp3UcYpBtuzj8IL2Mk1issR1zD8ClBfiwj+hHfw34k=;
  b=NiWsexO6h8B8J/ZY4U3TrityxFv0CXuQqDvoQ8tTThk3dT+T2ej3D0Md
   jSOQxS4BoB5FA0OQfYU3MfPehy1h6q+4/ie+EXxVhbjy1LZ9plaZoYexT
   sXi+0bBRGaDNV/q2i/aFxhnzkh4OSg88p1gZPgVg7lgLcWrFrmpWiEqdv
   nqRv9gYZt7AzBtCcHVS5BKQnzjjIACQvJ9wGJmqQsY3qiurWpOUE5hTs5
   sBiqP8E4RqI2iBVVFM8pIA6ybLrcybB5Zi/hrZGEDQeih1M3qnxu/Vv7A
   88PWZgEqtZ0taPgQPjXlLHJjP017ssGwIAjqJO53IuraVVfAuqmuBU5xc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="457373299"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="457373299"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 14:07:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="718534511"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="718534511"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Nov 2023 14:07:28 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r86En-0008BQ-2R;
	Tue, 28 Nov 2023 22:07:25 +0000
Date: Wed, 29 Nov 2023 06:05:05 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] NFSD: Fix checksum mismatches in the duplicate reply
 cache
Message-ID: <ZWZkEUduQK8ZqWr-@520bc4c78bef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170120889657.1725.7300213662876041857.stgit@klimt.1015granger.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/2] NFSD: Fix checksum mismatches in the duplicate reply cache
Link: https://lore.kernel.org/stable/170120889657.1725.7300213662876041857.stgit%40klimt.1015granger.net

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




