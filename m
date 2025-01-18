Return-Path: <stable+bounces-109440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE44A15CB2
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 13:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F413A03BD
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0778F18C933;
	Sat, 18 Jan 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmXQdxIp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB1213BADF
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737203170; cv=none; b=jmr1Z1B993aHGDITMknd0OQ1K//plKlG/GkeBG2PewkpRCEmLtkPJ4w5kt2lgej3XXyBxhjno7nQr6J26ZK03TcKbiOeXiKL8Jzp5H2rUdXs3kM5u28s77o1gl0RM7IMJvlVAqiUdFnipYtfHfXRC1KzdeSRWj1o9Hq43lIcCg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737203170; c=relaxed/simple;
	bh=9GozWhGiXzbSaJc3Gm9n9GFF06XkQppQRXajrAmB2qM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EAnEJ5rAZT7nm8bNymLccF2Utg0+QqcFSBprg9UfbjoICMNsIpxBRGYRAwnYPBGXQXRX1STwlF2LguwshNMC7z3pjJQWOTC9r659+PwBdXGVI9jD3x67smjli6rSP9yqCi2cuaj7M2iK27kd4gnuKfrruTdnNXkWxqfjD6LMhZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmXQdxIp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737203169; x=1768739169;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=9GozWhGiXzbSaJc3Gm9n9GFF06XkQppQRXajrAmB2qM=;
  b=BmXQdxIp2j2GW8SS3QSE3BVubRIYTTWmBvrkA2MKsSBedtqcgzmgr2wT
   JoDmY7qnKpnO/6c1zcssbT1SJGZ6oSsNXh18ouMERnzXK2DcEHcudd34S
   aPoD7E5j9Nw5u9HWuD8NXnPhqV3SxQu/JozBsUOh7vCd2aF3dLYMK6adO
   hEKVJ3KC2Smh6H0LdzGcdI0sE+SgPmE2x/8vWBIyMHdAalwfm5IYB1gL7
   59tQQaGCFrENTV/5in5phfWliFJk7I6IxmJUD2Tl167ADItkT8aH2DXvS
   R08xBQrHTFds5zH/ROQdP0HctzbrEzavSczX5TP6F5xZ+HcQEfY5XoOB5
   g==;
X-CSE-ConnectionGUID: sMtiKr4YTpq2woqjcgO6DQ==
X-CSE-MsgGUID: MH6WftJ/SqaUGj8juu75Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11319"; a="25227524"
X-IronPort-AV: E=Sophos;i="6.13,215,1732608000"; 
   d="scan'208";a="25227524"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2025 04:26:08 -0800
X-CSE-ConnectionGUID: 9V3KoMZuR8ahI/Gqs0ip5Q==
X-CSE-MsgGUID: R01mUOanRGCgdr11vyhMHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110106648"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 18 Jan 2025 04:26:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZ7tt-000UQl-0b;
	Sat, 18 Jan 2025 12:26:05 +0000
Date: Sat, 18 Jan 2025 20:26:02 +0800
From: kernel test robot <lkp@intel.com>
To: Ron Economos <re@w6rz.net>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef
 for CONFIG_PM conditionals
Message-ID: <Z4ud2ua6GrwqaaBl@9bc2624f7252>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118122409.4052121-1-re@w6rz.net>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Rule: The upstream commit ID must be specified with a separate line above the commit text.
Subject: [PATCH 6.1] Partial revert of xhci: use pm_ptr() instead #ifdef for CONFIG_PM conditionals
Link: https://lore.kernel.org/stable/20250118122409.4052121-1-re%40w6rz.net

Please ignore this mail if the patch is not relevant for upstream.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




