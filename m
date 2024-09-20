Return-Path: <stable+bounces-76809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA297D55E
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 14:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA12B1F23216
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 12:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37CB14A4FF;
	Fri, 20 Sep 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eeg2Hcsa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E5814F13E
	for <stable@vger.kernel.org>; Fri, 20 Sep 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726835331; cv=none; b=Jo9Cimu2ELt1SaGKhADomKoaE4uiEVvxWJmXHiRMkWutg+hAYunwLyUsJSPz8Noe5+OqCUCCwq7Wsa//jKWmfxdc4AWITwqpk+C1FgNUH3BJc89ACfnwHenOyRT3ehVfwLBUIwJM2K/q9ycaGaHpejI92UwCJ0Pre7Xhve/w/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726835331; c=relaxed/simple;
	bh=sYiQ9kYQGutlZmIzeO32FPizjO3PgQc76NG+QAN5Uaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=n6Gr73rBZmCc6AmIlhBPmye7dFoC9K67WiUj6qTwDQZGaecUu9pm6HdamcKkh4JNi2SSqoS7reIDxCAN/Hfw8jIdRjsqNzEypEh3pigWjlwpPysyldBCzD3tbIcL4EuXa9VqdiGoDJUeSn0bFLzQv7++Girx/M2AIGX3yEa2LtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eeg2Hcsa; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726835329; x=1758371329;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=sYiQ9kYQGutlZmIzeO32FPizjO3PgQc76NG+QAN5Uaw=;
  b=Eeg2HcsapJRbh8qkLpZ3JqHQYAykuoYF6SI7lN8snM3ot4gpD45KLu/2
   m4bjIaVeffnlcm1XFcfdHSrz017aoHU0Jm1xrBkeUQe7uf0QgXxHz8xBP
   l7uDbuDGD/WLhjWKeKI4mVZxsncXATII4IBFkqnEu7Swn88iS3YcypVtZ
   ZXSyejo2PKXTWB4C6U0qO43ZGP3mbAg5pIHT0tBdgp/pQdC6dhHhx0XS5
   hbPVWrhwlX+MfJCGBtVQ+d+8YxvZYtl4TciRJn0ZDAP7Zh2p6Xg0hHXQT
   4jkrgL3e0PxZrDJ1YhCH1nKe0Qmy5QCSuq+dSvOFu73Ak8bB/mLkNV5jO
   g==;
X-CSE-ConnectionGUID: kYpaqzTUQZGMAEaNKf8qzA==
X-CSE-MsgGUID: +Fvg1hi7TIa1LXmoQli33w==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25661610"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="25661610"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 05:28:49 -0700
X-CSE-ConnectionGUID: /kYgJFnrTomIX1r3s775bg==
X-CSE-MsgGUID: SLbHu1SWTEiaDhgJgl1xmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="70152410"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Sep 2024 05:28:48 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1srckf-000ENx-2m;
	Fri, 20 Sep 2024 12:28:45 +0000
Date: Fri, 20 Sep 2024 20:28:09 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/3] xfs: Do not unshare ranges beyond EOF
Message-ID: <Zu1qWVBt3EwXCPWH@3bb1e60d1c37>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920122621.215397-1-sunjunchao2870@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH 1/3] xfs: Do not unshare ranges beyond EOF
Link: https://lore.kernel.org/stable/20240920122621.215397-1-sunjunchao2870%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




