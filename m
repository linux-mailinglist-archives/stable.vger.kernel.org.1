Return-Path: <stable+bounces-81303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD61992D62
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9CC1F234F1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62E1D45FF;
	Mon,  7 Oct 2024 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NMQ069vW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C941D434E
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 13:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307916; cv=none; b=K5ukuiG9E3mxAbKLUd1E/s/tl+4orLmS3QzUZufRpqK4aPBvii2bXGkmEou1M6n7eSBMCAiKcvKZeXaa0iMKteA2O51pewjnumKGcwT/hzdr2o3JoqWWhgq06WvnlQhBRr/WPGghLZ9cV6i6HrWXyi+9B9HVea0NfPHUzL3ybtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307916; c=relaxed/simple;
	bh=1I+yJu0PI6OE5Ei7RYULnfVT3Ab5UjS/ved/f3Ay1JI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bgvSS9gE/EHp6OsSxRwL+xWHLoPAibtH93PRJbYG2v2OF4JSmx++v9qKQAlhnFpMn4Nfe96ADKl2wZIL7S6gYmQAuq4zadL35tDYNnfKNxYn4DOd0MT+wtT1k5r0tXUnKsUYHpvLjGM5eUONvBWJhWV/AXEu1QpnMBusasGPzDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NMQ069vW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728307914; x=1759843914;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=1I+yJu0PI6OE5Ei7RYULnfVT3Ab5UjS/ved/f3Ay1JI=;
  b=NMQ069vWbzALU20R/5MJ7/PYBpYHOPs0uZASh0eWjdFUi1vZhwrYxb5W
   ij73ujZAqlomxlj4+J9kT6n38YHR0bn5yoMOxrpXKPJOO+Q/3C6Xh4WOi
   X8AsHu1GNYhzllpCb3fhRKISqXjKbxMsnCTUMbq3dQ2gjDzKPchVyaueF
   uZFJXM6wf1dHOO3K184+eLEzjqDlJqoc4RXaDknHwKkq8qTesWxvgMs7C
   tDt98Wi4hYbITvAOtvGBa5OQX3h4G07nsyvp3fH4ecQRT297XJINGSjKr
   uBpeTY7yoj9uni1sulZniWmIV8qLFbuwYpu9CPZS2soNFjPseiYVFWBRr
   w==;
X-CSE-ConnectionGUID: Ab7ZJGenQGCYLAsNfoilVQ==
X-CSE-MsgGUID: PoWZotxmQb+preoL8i9sVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="38842237"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="38842237"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:31:54 -0700
X-CSE-ConnectionGUID: WmL8NB/OR+yAJhS+t+XoFw==
X-CSE-MsgGUID: 6laoIrV4TEqOF/sseBELLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75444421"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 07 Oct 2024 06:31:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxnq2-000526-1A;
	Mon, 07 Oct 2024 13:31:50 +0000
Date: Mon, 7 Oct 2024 21:31:19 +0800
From: kernel test robot <lkp@intel.com>
To: Yonatan Maman <ymaman@nvidia.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] nouveau/dmem: Fix privileged error in copy engine
 channel
Message-ID: <ZwPip8E2iWotS_Zp@83e7b27afa97>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007132700.982800-2-ymaman@nvidia.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/2] nouveau/dmem: Fix privileged error in copy engine channel
Link: https://lore.kernel.org/stable/20241007132700.982800-2-ymaman%40nvidia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




