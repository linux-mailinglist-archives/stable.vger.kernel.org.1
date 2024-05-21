Return-Path: <stable+bounces-45530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3E38CB3F1
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EB11C21D4C
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 19:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CBE148820;
	Tue, 21 May 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0ffvS9U"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AA69DF7
	for <stable@vger.kernel.org>; Tue, 21 May 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716318041; cv=none; b=KvxWkLnVxE1oChbWBecwa7iM2RGHNUP1Ry70IoReyMdXS73rGBSoYoCERnvARDgC0dcMSopqFluELhFkwsrwKCuejpWZc54jtFBDlLWixbX4lHDEcpAm2Wz1WAMyQLlA4Q6dcaTXt+MomXdaJ+HnNKCfZ1LWcbMWxHU0wkGa4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716318041; c=relaxed/simple;
	bh=t8+mRO88om1UW+2EYYfZw6S+QbpWR1dse6sSI6RyE84=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QdfZ6pkhTEY9Cl7CuRJGrb9yajaH4maChtzXDS/sRxEUO2JXoxXIkgDaMqrwsbVdAzW5gWXeBk91a0ZyjXZ1sY58C8F5ZWXPjZwWe3YvBZv861r13oStUSGcOJfXBlK5LNltpNULr/9wgi2MTypXJijrE0yAVnBd7GxX6lf1adI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0ffvS9U; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716318039; x=1747854039;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=t8+mRO88om1UW+2EYYfZw6S+QbpWR1dse6sSI6RyE84=;
  b=J0ffvS9UVdny2H8g4i5ymkIeIFtHNMZJfmcAfki7USoo08BARlDw6CzK
   l9EnWM67xn3Gr3dgYECAaM/qXUdZILob0v3fjH8HlxtuQxRhaaoMkAq9q
   usD480/vHCigRqKklS79U+6E32iRZqVwrwiR3u8eGve9eNqvJDahTGDkW
   g0w+8FC/YrPCsCpMwNEQnX/f0KNm0ZZKcVQTWTym30Iruex93sACl0I5q
   RDQca+SFJceuoX4MnnysHhWKQYLy0Iu1sHJH/Q7rpPfrSeu5mV5RISXpA
   qx6TesiBLcJhVwPoj6Cov03xnCPVv622N1NIKGjkooySPKs07TSraMa9u
   Q==;
X-CSE-ConnectionGUID: qiazNG8QSHi9/ZfY/hxngQ==
X-CSE-MsgGUID: C6vQ4V6FSlGxzHSMWY8N0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="30060687"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="30060687"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 12:00:39 -0700
X-CSE-ConnectionGUID: ecTIzuHBQriBX/qF1IMIxg==
X-CSE-MsgGUID: z5qIi4seTwCI/mKW4HjYFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="32876702"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 21 May 2024 12:00:38 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s9Uix-0000d3-1I;
	Tue, 21 May 2024 19:00:35 +0000
Date: Wed, 22 May 2024 02:59:00 +0800
From: kernel test robot <lkp@intel.com>
To: Da Xue <da@libre.computer>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] net: mdio: meson-gxl set 28th bit in eth_reg2
Message-ID: <Zkzu9PU5Mq6O4OUD@9ce27862b6d0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx=8=9VhqZi13BCQQ@mail.gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] net: mdio: meson-gxl set 28th bit in eth_reg2
Link: https://lore.kernel.org/stable/CACqvRUbx-KsrMwCHYQS6eGXBohynD8Q1CQx%3D8%3D9VhqZi13BCQQ%40mail.gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




