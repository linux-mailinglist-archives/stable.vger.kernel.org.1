Return-Path: <stable+bounces-40040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 037318A7586
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 22:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86ACBB21EE9
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 20:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B6713A404;
	Tue, 16 Apr 2024 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NritWBja"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C313792D
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713299113; cv=none; b=pO+8aByYab4jpuYQw3+CclZWWG+cG/4qgiQce6Epi8R847C3OWgUuOyPEKsXfHLOlxNstdwYCGfftmvuwHmIDGOO7PSMWoa2Dyvj5U5n1Ba/xZ1GDGh9NlnohqlJG3Uz/1ql/TiJ4rd57UN7WfRD0UZIbz77fKOUyFfgojGkNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713299113; c=relaxed/simple;
	bh=5rBjmaJykJcshMBQd3WMoAB6p5hCfCD7fxaMbu1cnxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n1wumv5gRUi5K/12brIPDBuk7Hx/zPlJCrEqezc+X0I0CAq9bZevRDYcc2fjvxuqZSAMgGqaMf/LkYCh6HjkuE5NNaFF2r6WgEGBvXw43JlxN0l0F3TlZxAu+Hq3R3Enm75FYpwIysFfc5upfbZ65UQvBaCTY814ySb4CY5x3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NritWBja; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713299112; x=1744835112;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=5rBjmaJykJcshMBQd3WMoAB6p5hCfCD7fxaMbu1cnxs=;
  b=NritWBja37wDHOIsinZoCFYa8kuZkm9JzyB1dqvGee8J/Xp5aqPQJ+un
   5M8YvL4fwJqYtOF1Et2b/ak/sYg5vVdD+c6x2j0BVm6f4AMBK7YJ2SXCY
   Nl2j+rPiUUXsPLloh1f8jJAQm10Y9jX3tPFIWSR+fcNLcIK/6KEUoysrR
   ibwrj0PMNuV9ZN5nf9iifZMNAdLe1hHXruP7fsJfxLdJxLl7hl1pljs3I
   NW/7+j6qZtWMAAupUCyCyd8Lgbce0hdDsqPuHY4CFnXWRrfEaukuqygk6
   GWk8mk2NHErre6SV4YISf6sWGjwgcjClhLHENJVDCC1KRxn5QP7P/8Vlk
   w==;
X-CSE-ConnectionGUID: 1H0X+fK0S1uaXsyF26I52Q==
X-CSE-MsgGUID: mTBvoWI9SWGlMgwCyCfzsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8688590"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="8688590"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 13:24:51 -0700
X-CSE-ConnectionGUID: fKK4+hxxQluWoOg0AE4nHA==
X-CSE-MsgGUID: 5Fdb3+17RuuBzAcel9ll2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26942100"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 16 Apr 2024 13:24:50 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwpMG-0005iC-0e;
	Tue, 16 Apr 2024 20:24:48 +0000
Date: Wed, 17 Apr 2024 04:24:36 +0800
From: kernel test robot <lkp@intel.com>
To: cel@kernel.org
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Revert 2267b2e84593bd3d61a1188e68fba06307fa9dab
Message-ID: <Zh7ehE3vPA7p9gTJ@c8dd4cee2bb9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416202006.10194-1-cel@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Revert 2267b2e84593bd3d61a1188e68fba06307fa9dab
Link: https://lore.kernel.org/stable/20240416202006.10194-1-cel%40kernel.org

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




