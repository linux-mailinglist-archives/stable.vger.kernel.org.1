Return-Path: <stable+bounces-177666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2BFB42BA7
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 23:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E37B2B8D
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 21:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDDE2D63EE;
	Wed,  3 Sep 2025 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g0AvJSnm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64FC1F948
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934180; cv=none; b=L5vT/YGJNo5WGVTQXmoRSI/OgwY/IIq8SusV79AK85o92euABjB5752BqFVPJ1p0potZN1GchL3yMI92hi5SptlHfylE2vnSP6tz8v+H4cIw7DHre8tWsUznNH2+MuX7YaXfEFkRUcOq2nZE8hNGiEfyHOavRjrUoBR+TwcwT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934180; c=relaxed/simple;
	bh=UzDezVzqcx6neVGBx5JVwLNDCCuoPPE1J56Dg3JVFxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=kxWbwEa3vUUPNdwnv+ALuasak4KjBXb1/qzbwMd4oFE8te60CLGzeqklN/rNvC278u9lD2HlJwNnG9tCO24u957Wjfsfasr6IBPLkwo1KcZDIsDjx3pAyglAjBOX7yc7BibfxdlxcvLiJ3lkpaSJzOc3kEBVVeOkDC98C2b8WYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g0AvJSnm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756934179; x=1788470179;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=UzDezVzqcx6neVGBx5JVwLNDCCuoPPE1J56Dg3JVFxM=;
  b=g0AvJSnmre5SN8QKZUIICTFPpCRnmsf5+ti0rudDK6IBa6syWUnydVnJ
   5Cgn5W5i4WxEEynIXk32TYu+ZyFwEA7r4a9cnMIHfEi4deneKCcRqRtKh
   VKfXOnweVhZV8/BlLCJGHyb/jA0y0yb+fKF3y5C9tJTWdIhv4rtOq7kIb
   n63fcifZgI8n2UCa4VtTxl9rQmykUAjCuhZItiO3Xgxw8JQf+gJvo0pA9
   KaOlbel50PSGANEAJrCWcDNXiZpnz2RsxQzupxYpr3l4UcGwSNv/76hN9
   PotG+v+Di0iQf7OPXtJWMJkUBihYOhjAZH9aI2bOmcOm7EDA8NcexGi/5
   Q==;
X-CSE-ConnectionGUID: A4ugkUJURu2xtVSrnSubFw==
X-CSE-MsgGUID: Mcp0E48LRbaiUxG80oXO2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63095420"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63095420"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 14:16:06 -0700
X-CSE-ConnectionGUID: dS1Gzh/KS+OUVFXNRSXBng==
X-CSE-MsgGUID: 97zVp05vSj2b7ur3Z9T9Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171257036"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 03 Sep 2025 14:16:04 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utuoi-0004Qv-0X;
	Wed, 03 Sep 2025 21:15:41 +0000
Date: Thu, 4 Sep 2025 05:13:02 +0800
From: kernel test robot <lkp@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 5.4 only v2] powerpc: boot: Remove leading zero in label
 in udelay()
Message-ID: <aLivXntAMi0RN47F@c0d94d4ed04f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903211158.2844032-1-nathan@kernel.org>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 5.4 only v2] powerpc: boot: Remove leading zero in label in udelay()
Link: https://lore.kernel.org/stable/20250903211158.2844032-1-nathan%40kernel.org

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




