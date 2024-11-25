Return-Path: <stable+bounces-95335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47E9D7A01
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 03:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE45A162974
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 02:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCB2539A;
	Mon, 25 Nov 2024 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLrqO4Uf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD2632
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732501016; cv=none; b=k9oeQO66zcY5iV7MJXhOUUf991KGEcD40T1+fzreYH4kYokrzRZgCu9eBatS/RQ5AE8Nrh+nGspbVWZKFifGy1D3Fzu5ik1tIVZLTQZdTIYUb6ooFEriOcJV5IjsK3XKP+Q4SoiXs7s2XswrlepPqF/ReoMnwlBE3JNjwZDlb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732501016; c=relaxed/simple;
	bh=GT5JDvlNvVcKeOMszGaHwEYVmfV/pQUWMeAGYSsMsO8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D7laxqO5NWbqgvUQ9XmyRhge8kz/BXYJgb6srdxhXRO/LGYn3yaccRPMtNKBSvK3MiBV7vmXo85ZCc1JI1mN4+grGjygmTGqSNhlUp1PGseyJEZM2bwGaefVSedSRstn6NvGKKcL+FQM+7veJLIDIiaHMdqfj1JcQuXsg0unObw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLrqO4Uf; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732501015; x=1764037015;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=GT5JDvlNvVcKeOMszGaHwEYVmfV/pQUWMeAGYSsMsO8=;
  b=mLrqO4Ufyjdwy/c8jxEld52ilESaLZPmFuceVylUkugUtLMPLS2MEXEh
   3mawikHVQBi2blzWg0O1lTFaQl6ZVjeGhVnsFZowlX8H2INWp2YY1EOoF
   GxaoKPHulkyrREA3ETiu3mMIkT1wPUvHvgTGQOrmHYtAF7U0flfmX7sqc
   FANQhjtecMAMfgLVhBGSmP5zLYpr3zhSjlbo+H6EVq60XCpjfCy10mp3J
   /75KoytwzuKK480+0nIACNWeLZEkI8kmc30fjFVMiEyBHj1g6ALwQE3tL
   kl/aHL4HUVc53EXk1dPqVLFJ1kOwrxdChl2mRQNLldn2YCjhgFSxoYdQZ
   g==;
X-CSE-ConnectionGUID: Ya98Anz4RjSNzu0kvtkqEQ==
X-CSE-MsgGUID: E6+tplWcT0WjEJHNcPEJuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="55093475"
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="55093475"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2024 18:16:54 -0800
X-CSE-ConnectionGUID: E1siENF7QJeEnUB+pF7+nA==
X-CSE-MsgGUID: qB7sB/XmQbWq1lijJuR6zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,182,1728975600"; 
   d="scan'208";a="95213925"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 24 Nov 2024 18:16:52 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tFOeg-0005Sf-1K;
	Mon, 25 Nov 2024 02:16:50 +0000
Date: Mon, 25 Nov 2024 10:16:22 +0800
From: kernel test robot <lkp@intel.com>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] cifs: Fix buffer overflow when parsing NFS reparse points
Message-ID: <Z0Pd9slDKJNM0n3T@ca93ea81d97d>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122134410.124563-1-mngyadam@amazon.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] cifs: Fix buffer overflow when parsing NFS reparse points
Link: https://lore.kernel.org/stable/20241122134410.124563-1-mngyadam%40amazon.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




