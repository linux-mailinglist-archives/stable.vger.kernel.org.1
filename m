Return-Path: <stable+bounces-98218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FFB9E3202
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B7EB20993
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 03:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE4C6F31E;
	Wed,  4 Dec 2024 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAwnhcgR"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C02374FF
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282419; cv=none; b=Tcq/IFXjb8HJeuuzDj+TRfJ4LFbyWpl14ibDtmohXMOrNZlTxiBNid/dEueZcO38HApnmBXrprKKvRgk/8FFqHkETsBxN1ve2E7HyuOgTX5wMJBLEdkB6OmolhshY7Xr5n5nO/wXyOj6+Dd8qfjpRJTcevqYWOpo4dmNXCG3Oqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282419; c=relaxed/simple;
	bh=K9TBe0Dvrs7BK6n7BsEVLjUQ6ytLahEijjRyzXF/cbg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sU3vcqsr8jmvm8HfWqIfGyF2DEJghC6Z5h3w5M899W6e6mYNut2EfQpQqTuBFDWr+qdRUXyczU3EdxCCE7Ukpiw7epk4+IUO5wjVd30osqZKZUrJHixdH+IOH677gnyDg1kyHYkJfLDh/Szl2CsrR1MMW8hzjGt/QFb8a05fpis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAwnhcgR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733282418; x=1764818418;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=K9TBe0Dvrs7BK6n7BsEVLjUQ6ytLahEijjRyzXF/cbg=;
  b=kAwnhcgRxR+0iNulRsa2sSLdaJWvxhzYNocWg8iYmvsihcrgylf8+tQe
   cH3587LRu4FTF21oyZcfT1LOJR3jatvWoYmV/zcp8WJUgYWCvSqGIjl46
   R4XOYOKfa2rRU9YoJIyfvh8O4Y361ehbEirzcKThxw90y/zNBnvzKRld9
   h22zmCRMPBOjkNRlZ9yPgU46XKDPytpLCBvgt6wsNI7ClkxHRROwQGN6G
   G9cHMG7DzcndFKurnY4/uKvwdwBTqc7ivis+HdJNYZo5dPpmJ5iDHLOzT
   qF2MORQwvDRkLSwH9f5Kc+6xDahmbP7hWZ/YDG7GzwPIYDuyXnp5X/QDO
   Q==;
X-CSE-ConnectionGUID: Cgu5l9ieQU+YLmIPI3IIbA==
X-CSE-MsgGUID: BwUGj5EwQ+SE4AZ2NsMiiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="32891282"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="32891282"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 19:20:17 -0800
X-CSE-ConnectionGUID: SvT0dZ8fShq4YGkVjzh0kA==
X-CSE-MsgGUID: WDFbm2pQT5eafbhQL/Y3iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="93481975"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 03 Dec 2024 19:20:16 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIfvx-0001jB-2R;
	Wed, 04 Dec 2024 03:20:13 +0000
Date: Wed, 4 Dec 2024 11:19:14 +0800
From: kernel test robot <lkp@intel.com>
To: Haoyu Li <lihaoyu499@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: wireless: sme: Initialize n_channels before
 accessing channels in cfg80211_conn_scan
Message-ID: <Z0_KMj-UU-HaXPpt@24ad928833eb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203152049.348806-1-lihaoyu499@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] net: wireless: sme: Initialize n_channels before accessing channels in cfg80211_conn_scan
Link: https://lore.kernel.org/stable/20241203152049.348806-1-lihaoyu499%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




