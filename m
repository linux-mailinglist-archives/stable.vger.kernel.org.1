Return-Path: <stable+bounces-73979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EB8971042
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 09:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39A1B21136
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C1A172BCE;
	Mon,  9 Sep 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKY9iyJA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29E1ACE0C
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 07:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868248; cv=none; b=b+pH4P9wATyxnATUcTbfSIXNeajwYqKbhEsMpOqZOpdvcGoBuQeOOHm2YXqWdG+KaXvT4Rw/lcQx+Dca/5PnV+5b+VZuJg5sfmKRC6q+5EBy2lyX8yBe78eEkKXA2S3ZyygdzxuxIrdxE6xBkq9+IaoMvRdpKZ/tkvmbw/aGy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868248; c=relaxed/simple;
	bh=W7ipozDiK/bNPjaDwsStCapigELXVSnOsj4pR0dTcLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V2cad6V04ON7zxuhJ0zihWFj0MhOVqbjYOKjz/RpK6EXR5d3M4cs6x6dPrvPr9o+AniYuMlAyfPDdUvkRuBsJtU5gZkrNzmgsPj5oTo5J2I/SDjjBGEpevyQjbtcYRfgncfa9x4DKG4iH9RXowy8amBMcPgLIcf26n9+1J3X5U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKY9iyJA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725868247; x=1757404247;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=W7ipozDiK/bNPjaDwsStCapigELXVSnOsj4pR0dTcLs=;
  b=FKY9iyJAjKTgEeG3X3VcPdAQ1eO68maA3A98dBKylvsmUWyDhGm+Siiq
   fXux2b873tiHB16JZriSxbFujXlfZVT6VXGSnw1+vBqTX3q7ShoddVsfs
   KOthg1dlOs834KjxIPU+TIzVgXSacCpOyGfSG6KZk1uxPy6CYdtuvL+q+
   ldtdl/52zuapnZc5a5z6x2wBWNdpJ9sLNzrjYsI5VQZjU76H5I1Vu3B+c
   YoiiT13efx80B0H4WNdMP+Xy1KlooTb6jLxvIThrfurlILJpD2k90mNg/
   PGA0hy3+HohmnD13IjX2wuUcjgsq7zdJo6gxkPG56aEVSTwflZR4+OW4g
   g==;
X-CSE-ConnectionGUID: igNnG9o1QfKgkyRfTnthKg==
X-CSE-MsgGUID: WkQURCLnRnCZw5E5fjwmJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="24688860"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="24688860"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 00:50:46 -0700
X-CSE-ConnectionGUID: 1UU9PxpgQgCF3GDjjFYeOA==
X-CSE-MsgGUID: q3HR4NaZQHqEHPhqSGIgpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="67112476"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Sep 2024 00:50:45 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snZAY-000EUR-1G;
	Mon, 09 Sep 2024 07:50:42 +0000
Date: Mon, 9 Sep 2024 15:49:51 +0800
From: kernel test robot <lkp@intel.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.6 1/4] riscv: dts: starfive: add assigned-clock* to
 limit frquency
Message-ID: <Zt6on1lO_zTcfG2k@b20ea791c01f>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D200DC520B462771+20240909074645.1161554-1-wangyuli@uniontech.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.6 1/4] riscv: dts: starfive: add assigned-clock* to limit frquency
Link: https://lore.kernel.org/stable/D200DC520B462771%2B20240909074645.1161554-1-wangyuli%40uniontech.com

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




