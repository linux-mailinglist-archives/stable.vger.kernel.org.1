Return-Path: <stable+bounces-36186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA5489AF51
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 10:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A51111F21E3B
	for <lists+stable@lfdr.de>; Sun,  7 Apr 2024 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1A7101EC;
	Sun,  7 Apr 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYyB1oWj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71713F4E7
	for <stable@vger.kernel.org>; Sun,  7 Apr 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712476807; cv=none; b=i4zAA8b3Sfp5u3ZeA9h9hj7/nBuND572UlDuYVwy9dg5cK4102PepczPa/Xht31BwDi1qYvIxN4yuNLlcqoaXRltmUUtZs+IYmZ+pNYwAMYcokq0yju6q6rSafxkVXP10ENuGzgaxi+aIYrJcjGFUco56otqK3n3b39voW6uXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712476807; c=relaxed/simple;
	bh=WAFQJ1Ci/HWXSAfFVWNnf6DkxE2bj08GEmJVsJ+nZJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V83hoHHYQ0qsTbBAMRBfqrDd1aSXoRXexdN+0kfB6ykf6I0fISePFUbiGFu7JErze4BUhhv0QDrh5xMn21JikoJTykYpo+OIxYoVOxvtMZxZfx3Zu4nBlJIABy2z9MrNL+ae1Lkl4CLhON5Y3NxjfmqBTAMzRXWC+Imc4VRr29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYyB1oWj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712476805; x=1744012805;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=WAFQJ1Ci/HWXSAfFVWNnf6DkxE2bj08GEmJVsJ+nZJ0=;
  b=ZYyB1oWjQeJF55u9C1RWU8VecrPDUKIPbSRr81WH+EwPHtjqEO/nxCsG
   bJn3h5aoJOfTS33fdjLWbSd1/6njn26/iBgS/kyIaTUbTPGAEEI/kIR03
   n7ta061ZZUkOnL8vvnklBFVSf++X9Qg/FwLTO2wKkIvJsA+b0uzbHwOOg
   oTM1x2USQF8goVm/dP+dX2W7kKs1W+nK7FkPfhhKu6pTg1AuJuucllC5c
   AZNdj4OSAkT4/G9zeqdX15YkVh2krQrkJe/8H7eY0OnBBUKG/G9aGfn+F
   ggIUWiyLxfvGAvYrUcloFxkMwCNhL6bhrCilxdKx4UMVG/UohXtS9ewCa
   A==;
X-CSE-ConnectionGUID: MfWchB1ERGC8a4QLR3Wo5g==
X-CSE-MsgGUID: TGM2LL+FTlmQERcae/uz9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="18490891"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="18490891"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2024 01:00:04 -0700
X-CSE-ConnectionGUID: Uk2Z8lf6Q4Cu/t1F8Xanig==
X-CSE-MsgGUID: iRdqR5MmTyq4C424Tx0TyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="50552576"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 07 Apr 2024 01:00:04 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtNRZ-0004DC-08;
	Sun, 07 Apr 2024 08:00:01 +0000
Date: Sun, 7 Apr 2024 15:59:45 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Yang <yiyang13@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net 2/2] net: usb: asix: Replace the direct return with
 goto statement
Message-ID: <ZhJScfSgCeGPJYeN@92629a18465e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407075513.923435-3-yiyang13@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH net 2/2] net: usb: asix: Replace the direct return with goto statement
Link: https://lore.kernel.org/stable/20240407075513.923435-3-yiyang13%40huawei.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




