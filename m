Return-Path: <stable+bounces-124798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EB2A674CD
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 14:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE0117A932D
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054320D50A;
	Tue, 18 Mar 2025 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwc4TleZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4920D4F0
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303928; cv=none; b=EJGnRDTWtwNzmMBSm/GpCLsg92Ez/C9l+sPsWSR8Fdz7eRVIgTYu6aUYrhCtIuJBvO+xo1uxtj5UvC+TUTSZpP5LgxaU/k94Vlf6ibjfF9HLQgXDvQWfvSLbJiLBRgucOnn7Oqvwyd/eJVMHQaA47pBoyg8HepKrouOyf6FynAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303928; c=relaxed/simple;
	bh=hz2v0C2mE7ZdxfI3g27x84Iofq4u2FmSHLaMhh75KtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bnQaRGYtZGBvm4rq1v1J827v1M4Rc+nu6zZshMH624B5z539F3zDEpujmJ4bWfX5NRTvadcaDirF5x8WCo5BxQIsZsSgfKsj+iwcWHnf4hkbPY00KCm/O1DKMOIkMsBr0XY6CcN/3v1l693ufNP7uRaTWmNfJvvp4Yd8fjq2BXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwc4TleZ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742303927; x=1773839927;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=hz2v0C2mE7ZdxfI3g27x84Iofq4u2FmSHLaMhh75KtI=;
  b=nwc4TleZWoScfSWwx3rMGm523dzfirzvT1JJrxg2IKMvHlkrZUR9mteJ
   WA2IZho826hGGtvkuf3g8ZviW9jSdbh0imN5B/IFe1zRJVh7AEptPjfEL
   hjqoH4mZY3QvRRy8ZvBTVC0g6dXrPkPkCMZ3QbPwZF3TVZnRfsAQCVOo2
   rE4qUTUxNI5RqVTsgFnrbDXUci2705QnZanulU6el5phSJexotV+XVPRN
   F/RT+xK1ASR6cGjwW1kGnsgPpoDyW69G4caLGD6keqXE3p1jnYBAzChR1
   HCP8GcYUO2ZW8onWwr8bL3bFyFrb4bXIBrSo5i05x+W6pfeEBHK1KqrJn
   Q==;
X-CSE-ConnectionGUID: rf0OhsyjTE62CRqTroCOZQ==
X-CSE-MsgGUID: q/B1JgOSTBCKlE7etCMkjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43614709"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43614709"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:18:47 -0700
X-CSE-ConnectionGUID: Nijdv+ukRSeG3ys+mBllpg==
X-CSE-MsgGUID: aVTKrgVUQpm4psfQNxoCCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122755268"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 18 Mar 2025 06:18:45 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuWqB-000Do3-0h;
	Tue, 18 Mar 2025 13:18:43 +0000
Date: Tue, 18 Mar 2025 21:18:22 +0800
From: kernel test robot <lkp@intel.com>
To: Dhruv Deshpande <dhrv.d@proton.me>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] ALSA: hda/realtek: Support mute LED on HP Laptop
 15s-du3xxx The mute LED on this HP laptop uses ALC236 and requires a quirk
 to function. This patch enables the existing quirk for the device.
Message-ID: <Z9lynnWSBAe2fIL5@4d9b5d180ac0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317083319.42195-1-dhrv.d@proton.me>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] ALSA: hda/realtek: Support mute LED on HP Laptop 15s-du3xxx The mute LED on this HP laptop uses ALC236 and requires a quirk to function. This patch enables the existing quirk for the device.
Link: https://lore.kernel.org/stable/20250317083319.42195-1-dhrv.d%40proton.me

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




