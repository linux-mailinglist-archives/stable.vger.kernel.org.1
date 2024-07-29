Return-Path: <stable+bounces-62353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492D093EBFF
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 05:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9FA28194E
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 03:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CD57BAE7;
	Mon, 29 Jul 2024 03:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep+5dEI8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349C83209
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 03:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722224855; cv=none; b=M9SiqT8SXhUoj5TNclbYvV+ZgZkDyew+fULsBg7iMmTwJbjCxN7ct7FjPxyQBOZk8jNGCH2pA2kisGHKoVkgiQHTcjiNmDuz1DsEHFJZ87LtjeTmStiFfT4llUTfTDBRaK/goPPw/AvydvrjIVXtNdNDTQNuCrIg5jqcYFcy9fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722224855; c=relaxed/simple;
	bh=Y2Xj9/NaYOXSo+36Vxi7K1pS8av9s7tSjvBzItMpzV0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KVTt3O6Y+oKPHsV+kU4V1B9XANNgMZHHFvAa0qlf8ELtFbAO9AxO90O9A43w0VQOzbLsE9MwgENYdhNZR9w7m2CnH3ka+3tiYGSGLei+XhxpQkF3T3LLCfR3ZI5sG4BBe2qWSEpi/GEherhm39TUmI/jXDR24wCusb0GCohU/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep+5dEI8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722224853; x=1753760853;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Y2Xj9/NaYOXSo+36Vxi7K1pS8av9s7tSjvBzItMpzV0=;
  b=Ep+5dEI8jGVmMDAEGFrY1DnuP0mwupzEjcFk52NpdpvNW1ZRVHLDcEU1
   zkbqB3QT+QvjgwnkicbF3gFa33GMoMAvmLC8QRM7Eu4BQVsatTBFxYoSI
   VR4P8n2L7NROAQiPH+96MhpNdTk3MKMNHvabeYxCQ8eUfIkixN6wb8M0a
   CbHEXGaqKG+weU/+L01GDzxZ3988JAprxwgX+p8jM/huPljCLz42HO75K
   NE6ZG3wA0U+kPGkb6y+5G+WqwktOtXwOkXfbtLQ/6ZR4+tCuVFdJrvYn9
   H/xEMYG+nfZ5DWxXSzI8twYNMK4FBLpJOW+758uqKyRkYM7jmR+GIef53
   Q==;
X-CSE-ConnectionGUID: v3VfcGARQ+SmW+V9GgSk+g==
X-CSE-MsgGUID: HZoj3SK9TByEU3b8tLIMPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="20077269"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="20077269"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 20:47:32 -0700
X-CSE-ConnectionGUID: 15c92RQCSoWfN7zLPC4kYg==
X-CSE-MsgGUID: qlZ0qQ9rTVCZ5na9vbUkQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="53526898"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 28 Jul 2024 20:47:31 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYHM9-000rNq-1V;
	Mon, 29 Jul 2024 03:47:29 +0000
Date: Mon, 29 Jul 2024 11:46:57 +0800
From: kernel test robot <lkp@intel.com>
To: Erpeng Xu <xuerpeng@uniontech.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1 3/3] Bluetooth: btusb: Add Realtek RTL8852BE support
 ID 0x13d3:0x3591
Message-ID: <ZqcQsT-J67Hq5Yo7@6724a33121ae>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283C6F6C7E72DF06+20240729034247.16448-3-xuerpeng@uniontech.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1 3/3] Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x13d3:0x3591
Link: https://lore.kernel.org/stable/283C6F6C7E72DF06%2B20240729034247.16448-3-xuerpeng%40uniontech.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




