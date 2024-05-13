Return-Path: <stable+bounces-43688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410208C435C
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE50F283496
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB11848;
	Mon, 13 May 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqUVsDD0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756ACA3F
	for <stable@vger.kernel.org>; Mon, 13 May 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715611056; cv=none; b=E4HzLAALbWkNCb7GcM8GXg4auRgFRkSu37o6xzy4a8gIlzpithjmXhgr/Fr/ln9EBFIBH+NaOXFznStKKdPjqPGlXP1J0wJrXwuf0JgjTg35+h50d8o4b+logUR5omaryjc/qonEHa+O0Qe8HPJEPGK7wm1jkWsp5NwlM+zAySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715611056; c=relaxed/simple;
	bh=yF8iscflAu+MzTK+twhhojAwgHm31zWYJw8suwnA/Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NbAzqakhhdC+GOfmeyK02huIRqTZl/pmhevim8YCzmmq5dVw/K1bA1Hp/KqkzvrCji7hmhBbHVZ7Vx2Eyha9dBnwpdy6g69VFsCLMYc0JoU2GnCFHozBJpB5gEvB97prG45cn4BHrVnjOdae6jIBWuVH7oOVR8zlQvqdK9CTlJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqUVsDD0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715611054; x=1747147054;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yF8iscflAu+MzTK+twhhojAwgHm31zWYJw8suwnA/Kg=;
  b=hqUVsDD0FHD4I4EjoJUuRfW16+cSy86Ot9Y5DZ8myGfuFRUpj5+hljHQ
   B66A5QoRn4XtxuKubm3uWSCEPwAbr7g6AG6LsHiHnp/BLCOsJVJIBvpqf
   q5n+d7dvbE5yVj1iBwxP1crAIRwAUeeRG7LGVqRQPoaGJr6xbvj38EjXr
   pXGuP7mHcrkWV4n3EhprK1S4W9G4ewCHmUbAeWb/Iq/XMz5ba2SeJIOgI
   +1XHQb6Ww1up2hzV+ggqbzoK09Ywhggze2ZE+CKjiAFs0paOenEb5ilBH
   G4tQhjYH43MaO/UVcDKSxbuJ9JBr1ztkV5yhNCRRpyGnE2vOtUJ3vEMMI
   w==;
X-CSE-ConnectionGUID: 4CjyMEvoSuqXNxggZHZE5Q==
X-CSE-MsgGUID: cbSR1tM/Simk2f9BmCiqUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11493145"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="11493145"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 07:37:34 -0700
X-CSE-ConnectionGUID: LkxqN1VmSPGGHf2lp3Fc/g==
X-CSE-MsgGUID: R+XYKfzZTlihJlxcWqQvTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30422399"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 13 May 2024 07:37:33 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6Wny-000AB5-1Y;
	Mon, 13 May 2024 14:37:30 +0000
Date: Mon, 13 May 2024 22:36:54 +0800
From: kernel test robot <lkp@intel.com>
To: Jiasheng Jiang <jiashengjiangcool@outlook.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] drm/i915: Fix memory leak by correcting cache object
 name in error handler
Message-ID: <ZkIlhlw2DvHUmx_K@974e639ab07c>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR03MB4168C6D020B750EAF8021731ADE22@BYAPR03MB4168.namprd03.prod.outlook.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] drm/i915: Fix memory leak by correcting cache object name in error handler
Link: https://lore.kernel.org/stable/BYAPR03MB4168C6D020B750EAF8021731ADE22%40BYAPR03MB4168.namprd03.prod.outlook.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




