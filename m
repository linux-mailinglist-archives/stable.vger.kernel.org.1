Return-Path: <stable+bounces-200908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06535CB8E57
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 14:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB14300C2B4
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E204C239085;
	Fri, 12 Dec 2025 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+QzrCZu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C55234984
	for <stable@vger.kernel.org>; Fri, 12 Dec 2025 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765545838; cv=none; b=gu+Ke0JC+VkcGhnY3iupUpUpvwdtHsbvgp7B6MoBSh8+DuOxQi/D6DnfFd7aTzhQku2GaTJI428al1uSRIru3jtg2bNCr8XvYVGDE/Jk0pz0CkW5zcWPsPEVZErX40c391YCKV6Qtv8u9bZVG3PUoEGucn8yV5P7K/Xgk5EG7U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765545838; c=relaxed/simple;
	bh=H0k4SAPYEpMTm3qOAd/GVa+N7spdQ1MjFkz0SQ4YXi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LBwsQAAjZB0VtNB99Wn2pHPSlK/TcYl+3cYVS9X30bXEnAR33tqVK8XB06TV+J6puwLn/QbMMQT/JSB612v+EPVaB9fxhXHOcS7I9myx9URRW8rlQP9y+8r8BDOV4pAAcdcESvlUyYXZ+Vjkf15wQNU/iRarE9nLpgBFaPJO3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+QzrCZu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765545837; x=1797081837;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=H0k4SAPYEpMTm3qOAd/GVa+N7spdQ1MjFkz0SQ4YXi0=;
  b=i+QzrCZuMt1rt8x+UzG37xQWPrKu7P65pW3EPkFL1XYvwBhNdJRA2Kzv
   K0WkGQozDzZpAK+YLwu56mAeqJt3HNr7rSewJ22yIHF6YY5MGVujv1ewU
   zxACNRT5GZZorCkgUja1ZTJMxtwt+mMdEcY5aT2ZRlEnUNVlZ11JLJKf7
   5rgYmETyTlzkLk3LphWEkjBkJJz0z/yiSr9eGrhqauaWN2njBwk/qql75
   GoWsIGcsEStpG8/eWZOMGR+IY/pIsAYdY8dujC1cZ/rGFKB1T68h/yyJl
   QZgXlwg/Uf72wVpyufFmNNsZnmP0EYm08jE+Dp3u0osdISeXBiK+VZnjx
   g==;
X-CSE-ConnectionGUID: tsWzmmLfQm6AaNGmixYqNQ==
X-CSE-MsgGUID: aeoUfPsHT2ukSBxJntiGPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="67706883"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="67706883"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 05:23:57 -0800
X-CSE-ConnectionGUID: bujPlIRURgOVbquV5Z6gAQ==
X-CSE-MsgGUID: EP4gDJ9kROGnQHMB1j6OAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="196994593"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 12 Dec 2025 05:23:55 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vU37h-00000000661-1LNk;
	Fri, 12 Dec 2025 13:23:53 +0000
Date: Fri, 12 Dec 2025 21:23:00 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Wachowski <karol.wachowski@linux.intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2] drm: Fix object leak in DRM_IOCTL_GEM_CHANGE_HANDLE
Message-ID: <aTwXNHzmC0SDNFGr@7da092942895>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212132052.474096-1-karol.wachowski@linux.intel.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v2] drm: Fix object leak in DRM_IOCTL_GEM_CHANGE_HANDLE
Link: https://lore.kernel.org/stable/20251212132052.474096-1-karol.wachowski%40linux.intel.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




