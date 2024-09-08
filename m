Return-Path: <stable+bounces-73931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD9D97094C
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 20:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2462CB210C0
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB3175D2F;
	Sun,  8 Sep 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BTkkYqwx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889E344C77
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821675; cv=none; b=lWjWTmYeuSjM4LrZ472Xe6nwFzEZHahj+0BaaKmlAzYnO/EKJS7Luc2gTal5JzFq5r+GG4Y6lNtL/ZCqWi+SQtI27A64x765nMnAPPxY0CCheqnJlflZLT0hWSfho5j82QhXo27L+3wbVo2j3czxo+VQ0F2kQV+tzLdqAZYaJ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821675; c=relaxed/simple;
	bh=mdBTB1lAxQe2sjdcJUw5zE2U3niBBFhKuyy46aqgPHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r9lU0+Ib+TD8AWZLTNGgJDbew5o+3slAZ2PXtbFTfDjtPCsSMg0CMsmOeTrF8jjNX+QyuDKIFYtLsdSky9ctF2iDsOkfboEs2P3sHKSKlTqI0Ww+mcMG0oDUWVROU/OcUo+Gyg6Y9fhJ1wQu0Rlx0VO86jlpRvj+8611LTEATno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BTkkYqwx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725821674; x=1757357674;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=mdBTB1lAxQe2sjdcJUw5zE2U3niBBFhKuyy46aqgPHw=;
  b=BTkkYqwxCGmmO4i70WG82hGJj35V3b9RwbP1QGsS/Dwq3w511ZELRJHb
   fFyBlC2k80R+Rh76DQtzOw4mpIUbnE1SkMS8zO6BMmmbPZQ25UBUl3LmF
   XERqFs5cVkkQxHodq6DDTlcWfF0BP+68k93tibo6IUCM7UHTgr3zc1shR
   EidqlovQ8Ejj3UVmiyN5yJbpv89m/LVx/gmWaQOE4KxPutQ/DevJ2fLF5
   30gmTlj4BW3xzhI0r1IvSaB49T+dyOACEIvMKimbPCngiy/l8UEpHdKtX
   dvfCbUyQh8EPVj6BmnqFw9G84bGNsbGqeWslEvYTnzRA5wMbxSWrfKVKu
   Q==;
X-CSE-ConnectionGUID: jzEuMCVDRYWACTkajkOsHw==
X-CSE-MsgGUID: BWAqlYJeTo2NXtdFWa5asA==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24702586"
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="24702586"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 11:54:33 -0700
X-CSE-ConnectionGUID: EC+Q35LrSzWGtm6XWbedwA==
X-CSE-MsgGUID: hvd9B5TJT9KG5uhlBvk24Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,212,1719903600"; 
   d="scan'208";a="66448585"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Sep 2024 11:54:32 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snN3N-000Dql-1n;
	Sun, 08 Sep 2024 18:54:29 +0000
Date: Mon, 9 Sep 2024 02:54:12 +0800
From: kernel test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.11 regression fix 1/2] power: supply: Drop use_cnt
 check from power_supply_property_is_writeable()
Message-ID: <Zt3y1IVpLHiV0_ld@b20ea791c01f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908185337.103696-1-hdegoede@redhat.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.11 regression fix 1/2] power: supply: Drop use_cnt check from power_supply_property_is_writeable()
Link: https://lore.kernel.org/stable/20240908185337.103696-1-hdegoede%40redhat.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




