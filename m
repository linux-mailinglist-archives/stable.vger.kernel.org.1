Return-Path: <stable+bounces-3615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FD38007D3
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 10:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C51B2111E
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96B200CA;
	Fri,  1 Dec 2023 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NvlsasK+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE41736
	for <stable@vger.kernel.org>; Fri,  1 Dec 2023 01:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701424773; x=1732960773;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=V4x3Q/R7T7QKX19PnQKvBjiTh2TY7lk7gqSGHtPYTTA=;
  b=NvlsasK+j/ZMm5D2ZNb0+ScIN+res4bMoiDmcS7oMPDM80so3GZzbV/y
   gZbBUceFt2anytj4NphZ6/Chvypq96kkj7tEPirx0y2EsDFJxm4KQ6WL7
   HDCQYoqC8/xGx5d5l/0pSVByS4qF9o0xhhnc37PTOnjtnQjZZ1YcnXYUj
   CIA1/K8y+otF1HvOydw0kzsOZSilPpa2xMNh8ohMNW12/K+cAlv2jJdSr
   +0yF1ykLT0ea0VmOCMx7vHtyh/WfNf4BkNUDfT+eDToFsaUkCW+Pqhqi7
   wFHwiOm1vFvsJTreRKO7yak3Pidnp4yp26dtbapmJJy3oCl4HmV4ukzUZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="496291"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="496291"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 01:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="913535819"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="913535819"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 01 Dec 2023 01:59:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r90Iz-0003Sy-31;
	Fri, 01 Dec 2023 09:59:29 +0000
Date: Fri, 1 Dec 2023 17:58:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCHv2] mmc: rpmb: fixes pause retune on all RPMB partitions.
Message-ID: <ZWmuRiVovprlOVQE@520bc4c78bef>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201095608.1022191-1-jorge@foundries.io>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCHv2] mmc: rpmb: fixes pause retune on all RPMB partitions.
Link: https://lore.kernel.org/stable/20231201095608.1022191-1-jorge%40foundries.io

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




