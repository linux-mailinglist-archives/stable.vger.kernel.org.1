Return-Path: <stable+bounces-158376-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5550DAE6312
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 12:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C919A4A7376
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE735285CAC;
	Tue, 24 Jun 2025 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bkWO3NQa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1082A291C3E
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762509; cv=none; b=K9HfdsSbwH3DZpLHPGVXTbXDLTt1MyG8kftmxOLaCM06DLpLrOqxAyTLcEpacdFWBopNBZqvARBWSwBDP9s3i9SlmCzGFoWcBGVDC97imd/bPME9xJfIx76AnDuvrTZMQBMZg+a8iuiCvdn2/vg0B00KnX/zNr4/OsdIIiTrQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762509; c=relaxed/simple;
	bh=YlKlfzW1PGYk+PABG2HK/yGcGwFf8jYOrFNVOEO5wPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=e3uGGy6WdH9P9tV8krdgeCYxmVNDgeAk6+OJRTS7pR9nnbhOzZIyQfxXo7vHMDS4X5YtBH8+T1KgV62UGRH41i71kFpneRK0srISbZ7iP4J1CkBEuIyWfxrHrQOs9W5vn5gcI4rZL1k3nRAQGvB2ORUJqcV5L0ZPiPZU7LrihfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bkWO3NQa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750762508; x=1782298508;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=YlKlfzW1PGYk+PABG2HK/yGcGwFf8jYOrFNVOEO5wPE=;
  b=bkWO3NQaZ2O2oAIDE+uO/mWCPSAxCDV4/2iQDF41R3Z21VhPiXlcZwnq
   LxzsUE1mrUXT61uVBh/D+jdq8EI3lacOFDEuT7LmOWnMt0FDH0fOnTbzx
   5JRW44Url98f0E9XwjHSmx7q5I0/BvD2YVTQ//Wc7QPIy3XShyXYiI/x7
   jFNXXuuXV3/oLSYstCnoHNOMqIW4iv0ST4Zh7H5Cv8xJGBV6b86ddP6Gq
   C2MybYxh2Zgx3eZcxPZxnScVUKjA+3QcDMjiaBOziV00cia2WCTDjfUcd
   JGoV92SZ8aWFUUQs4gnSMWR/pu9FUYB9AUmmch9kcKynuuag7mo3V9fu+
   w==;
X-CSE-ConnectionGUID: 9n8aSjwzSGaICiZfpjCMPA==
X-CSE-MsgGUID: MJiAg3LeQOOOJnpnVRYb+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56671784"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="56671784"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 03:55:07 -0700
X-CSE-ConnectionGUID: B89PWEPlTHShjZo+fJax4Q==
X-CSE-MsgGUID: V/VhNGipSsa0XoHrIuTgxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152409325"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 24 Jun 2025 03:55:06 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uU1Iu-000S2U-1S;
	Tue, 24 Jun 2025 10:55:04 +0000
Date: Tue, 24 Jun 2025 18:55:00 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Fix TRB reclaim logic for
 short transfers and ZLPs
Message-ID: <aFqEBGdUezWZHfsv@2e46cf93a049>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-dwc3-fix-gadget-mtp-v2-1-0e2d9979328f@leica-geosystems.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2 1/2] usb: dwc3: gadget: Fix TRB reclaim logic for short transfers and ZLPs
Link: https://lore.kernel.org/stable/20250624-dwc3-fix-gadget-mtp-v2-1-0e2d9979328f%40leica-geosystems.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




