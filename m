Return-Path: <stable+bounces-104397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4DA9F39A4
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 20:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6FB16B87E
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6CB207DF4;
	Mon, 16 Dec 2024 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lcl5AVFw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B70206F35
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376841; cv=none; b=LCCvNl/rFokLWcobO1/vyhGrWbb1hSPzZsJ6KHH/RPQ4f1qg/QGmoVMGrKaipKSuwWSSsdYCEEaseQurpY/k0n8xyxuoCLDVPp7e8UJWGj7N2H5+AR07CgWyXtgNBm/8QE+KqpT1dRC8cDse7ryUixLWVZOHa6NqcMjjYnyS00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376841; c=relaxed/simple;
	bh=mllcLUMzvoL09M7DCQNujqAJrwd8v3A3lKCOGuhyctY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XQfZZyB9imk0cUJbyDIZCAI4OyVQiMZPsf4cvV/98kJkL/bPN2hJWd7HVY99RosXYrMEjiYFqY6Rrzo0XUpkrgbmHQmfmjzkOkoVgDafxh9gJ4TR1wCvtoGi4Chijdf5vrtDoBZVWEKeThDiGIynuot8wiy97ZEBPnt/FuPKui4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lcl5AVFw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734376839; x=1765912839;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=mllcLUMzvoL09M7DCQNujqAJrwd8v3A3lKCOGuhyctY=;
  b=Lcl5AVFwF+plqMJCRdgF67p0BdzNuio5CEk934jFi6gGm8nsC5uZnKU9
   E1PABrxEKlBV+nZXa30/nC4gS1WkXmmKLyp/E9fnkJNeowbrBfwo3me5+
   wFHIWtOvJVRhe2ltOP22PVTA6wl/VDnDukLahCYbAHD3VFWMKOwt436PM
   n9L34rZc/UkD4OJBwmJ/sOCd66biVVV/Sb/Bxckc6PUp2zqy2yi/9N9as
   wvTlUTjS/yT41+n5kJRnQNnJpkcbWcjpyvXL2ZAXumKuG9ND45t6fSIMW
   S95e/KF32NuFl5qpKHW0dmPW//Q4mtp2gdr9qH+xCX6v6Ldntfa8WGoO5
   A==;
X-CSE-ConnectionGUID: RDQYOHVaTzep5IVHAOC+8Q==
X-CSE-MsgGUID: JDwgKMYhR0CXQzOGgUHC3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45781895"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45781895"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 11:20:29 -0800
X-CSE-ConnectionGUID: ZnoGV93ETveBDZVHv6KImw==
X-CSE-MsgGUID: ZzOCeJrkRK+UAXNCzy4hxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101902889"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 16 Dec 2024 11:20:24 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tNGdi-000EQm-0d;
	Mon, 16 Dec 2024 19:20:22 +0000
Date: Tue, 17 Dec 2024 03:20:07 +0800
From: kernel test robot <lkp@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/4] serial: sc16is7xx: refactor FIFO access functions to
 increase commonality
Message-ID: <Z2B9Z5QHrJGolzEc@0d54cbd93456>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216191818.1553557-3-hugo@hugovil.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 2/4] serial: sc16is7xx: refactor FIFO access functions to increase commonality
Link: https://lore.kernel.org/stable/20241216191818.1553557-3-hugo%40hugovil.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




