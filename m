Return-Path: <stable+bounces-169503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647BB25B54
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 07:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07767257E3
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 05:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD28225760;
	Thu, 14 Aug 2025 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cm0813xJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C14224220
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 05:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150829; cv=none; b=hoYaoKiGBitSKKbm7S4lZZ3Vj7L7DDjBJoPGbGa2gkVBpDJPPhAn9oWJQ1f7quu9QuhLDyirIBRfUC82dP+7Jen+Po1yb7BvPQYDaCZGStH4LMXzPA7JhMoV3vfD/jqGbV8jugWMnoFpRzIPxaN1wNg/iFgBWFG33lad80d5xks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150829; c=relaxed/simple;
	bh=yXUooRU1ki1YrtyhVlgopVe9AfClWJ4pOfZEs8MoNAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PLvm4zfInrXO8BfcLxLgHaN/J5QSoRFWfdi6uwZaA6iH5C96Myzz/LYc/YX+hvhFXporUtairCeUaDwf38JTqQ6PGikAp3BTpuz+0TbzokYtwqHNOGovamXMMw4CnKIl3IqEl3PTRXhpjzTPwc8mrb+HCf8hvy+SdnwLeFPpnoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cm0813xJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755150827; x=1786686827;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=yXUooRU1ki1YrtyhVlgopVe9AfClWJ4pOfZEs8MoNAU=;
  b=Cm0813xJBtwmBGx5owGS49zSmCEB9v0CpfcfdUwZtuqBDjTyEio7U2HM
   LF1XztDTJyUE+c30b2/UwWvRA1AmezT8jSDsZ6reQOliRgT9ZXuHfsh1a
   c230+0EJAnrfpJ7nUK1wyMmKBE+6dVZvKBXSUG5+Dt1b+HHI1PsB+fYOr
   xZ/pHiDOO9fojxHbJrZQLnmQ9Nqm9+ewIwAZhiqvmykzWK3pNdZC9Thb5
   Jb1UepEjNWjzOzYw74GJ006p7cobIEF/SWrb+Mpe/4C6DAJj0vCmIXTJI
   Bt6DMDesiHtK4jOmqsnXTBbLv6t/FQZ+wnTHrxky9h0fmy1T+WI1xw/1E
   Q==;
X-CSE-ConnectionGUID: y3yh1McXSeOKV6RzYdX6Wg==
X-CSE-MsgGUID: KqU0EEXdTWiQb41mAQdI4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="57527316"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="57527316"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 22:53:46 -0700
X-CSE-ConnectionGUID: AzxGHVTTRPiSGQLZt3Zw0Q==
X-CSE-MsgGUID: FLZaYIJOSO6E+X4v0A1WAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="170806722"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 13 Aug 2025 22:53:45 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1umQuE-000Ad6-34;
	Thu, 14 Aug 2025 05:53:42 +0000
Date: Thu, 14 Aug 2025 13:52:55 +0800
From: kernel test robot <lkp@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH][RFC][CFT] use uniform permission checks for all mount
 propagation changes
Message-ID: <aJ15t0tdVvMkin4h@1a863d778a0f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814055142.GN222315@ZenIV>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH][RFC][CFT] use uniform permission checks for all mount propagation changes
Link: https://lore.kernel.org/stable/20250814055142.GN222315%40ZenIV

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




