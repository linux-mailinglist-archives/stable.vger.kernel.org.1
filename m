Return-Path: <stable+bounces-109292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532E1A13E2B
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 16:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB7E3AAAE2
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054E786329;
	Thu, 16 Jan 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPuzFI4v"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6221DED46
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042414; cv=none; b=jFH1d2J1R7Cgp/kvMjzrZCsVn94xPGqlF1PUiAvS0nxJ2vp3oPSFFvdWGgtIcnEU221qYv2zJnWTBQ6R4yvrkinvqDmSxUJbg2XdvqiAYarosBr0TvMBL4yPteuWjYXwjWI+EgrRtbVtGvVhnjacQzNco+PTUYtJ8lx9iywjjt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042414; c=relaxed/simple;
	bh=PTcuqldfo5f90uOLfGjb34O2Bl73zvoGjQCjmahtjLk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=enDW5ZL6QmW+O+4cDyTLnu94mrgVk1rMjP6bFMBva7XXfRaNndwVM/RGrZt1QFTQDCdNjK0cS1YthVQQFZ/d8q2r3Ncj+3c82IoUeoZEOYpY+DvMd0aW+s8wTvmo/WWfspfbEG6biQIQQ5urtaIMhhWum7JvxK8vUPgaYoKnKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPuzFI4v; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737042413; x=1768578413;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=PTcuqldfo5f90uOLfGjb34O2Bl73zvoGjQCjmahtjLk=;
  b=cPuzFI4vo70NjQs8oPeS4XnCLfXKLOt+t1LIhTJXZq4AXiyKcuCDvFdy
   pik4d8NJZWvqCFH3sQcZ7UiQuSD2CGJ8pMAH2MoQl3anXwG5rKzX9sUy8
   cKFbLtszBg2IRYTk2keH2kke2ThhjyltTJLajEKdH5mXlKNcjGCuUHKgt
   HXdBDCMoBEhk+SwxyNRA3lpwvqLEHwdJ+PoZLVerQXRlKC2QXJr9SBFVq
   YXMQIKNP9vKrYikRnmwqIHVhc0pIBcXvVPUWxd2p2KuEwqmI8LHkLp2n7
   AbXWn+sDwLnXpN6eAH4ksvUbIpEJw8YfJ0iyzxr/QnCQFA5nWuUPTxw/t
   Q==;
X-CSE-ConnectionGUID: JYWdI8l5QPuSsIOVx96edw==
X-CSE-MsgGUID: 5oyDGM6/S7GDP3raTGcS5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="54981790"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="54981790"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:46:24 -0800
X-CSE-ConnectionGUID: FIH5szs5RRWgmQSwJ7xGWQ==
X-CSE-MsgGUID: DrY63Q+ySyWfeFcwVHTQAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="106112917"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 16 Jan 2025 07:46:22 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYS4Z-000S67-2e;
	Thu, 16 Jan 2025 15:46:19 +0000
Date: Thu, 16 Jan 2025 23:46:04 +0800
From: kernel test robot <lkp@intel.com>
To: Mohan Kumar D <mkumard@nvidia.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] dmaengine: tegra210-adma: Fix build error due to
 64-by-32 division
Message-ID: <Z4kpvA5QXoJOBhXN@43dc66be142d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116154439.3889536-2-mkumard@nvidia.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/2] dmaengine: tegra210-adma: Fix build error due to 64-by-32 division
Link: https://lore.kernel.org/stable/20250116154439.3889536-2-mkumard%40nvidia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




