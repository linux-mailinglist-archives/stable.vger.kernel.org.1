Return-Path: <stable+bounces-181803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44ABA5838
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 04:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EE21896807
	for <lists+stable@lfdr.de>; Sat, 27 Sep 2025 02:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF370808;
	Sat, 27 Sep 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9drGIpZ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C0F24B28
	for <stable@vger.kernel.org>; Sat, 27 Sep 2025 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758940307; cv=none; b=BHMdFYp02+Hg5vfO2ywUmZ8y9nY3M/mVUT4YF9kpth7gxD8aQSRaZlHv5V4SKJCvOeL2b2hiKSM6nEHUJmF/JcEmIUdwbJdsk8vA5Kv0OK7MlowSAxNfvb5rqgdM6Jflw7xckEd48lFj2U+om6Gqq3d1azl0PocN9Sxr4Onu+7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758940307; c=relaxed/simple;
	bh=CFP8RCYP76k1ZwNhRvBrhFf1ZGaWFS19DpI2vwkvosc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ImWJDpySs2kOi/Cp9a1JI3lL0IPu0HJMr5zLpGcZrel4t9eW1g2tNoe0axQxn1t99OS7QhDDqesbQ42SMz0+WTVkgpep0TzY4+7eVPayI7swlLh9QyVx67mfa0IDKSfhN5zgTfgN1/+SE353xP1wPB0Ct7OU7+489FWwfBHw0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9drGIpZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758940306; x=1790476306;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=CFP8RCYP76k1ZwNhRvBrhFf1ZGaWFS19DpI2vwkvosc=;
  b=b9drGIpZ4rcZRLeVMzbJhqhp/rsP1IFe7fRW1HrmirmRCojndp7Ll0gX
   jEvDA6TGAn2F5VqHq1+NPd7/Nx+cmSh9wIJnpVMMTuHWpIu0wV/LiIZtp
   eYcg5dRwF7GBLyucLsozXu5GZatZ1ccGLj12cTwG/HLyu5iXXlx+1uWM1
   u6e86sSDGS4Mx/pOObRzI4l1RydHqxARg40qkWjF5vIbRkL6v3ae6Lmys
   WSOTZsUgHAGw0KP8wW/I5kUmjFjAWHHfYJCfFFQz5pevu8v8ef9Lj/yeT
   wxgEYyIm8NUUeNKj4TyJP8O9vnCNS0y0cmcPHaU2VJ1VRQDJ/dumLvSOp
   w==;
X-CSE-ConnectionGUID: lf0VM7czSDWwvMtWoR8cog==
X-CSE-MsgGUID: 28qyxjBLRyCiA32U45NQaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11565"; a="71520247"
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="71520247"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 19:31:46 -0700
X-CSE-ConnectionGUID: 4fKnMWVpQPi/bAxGRIh66Q==
X-CSE-MsgGUID: 5aN65N1qT9qL2GB46X4cfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,296,1751266800"; 
   d="scan'208";a="177316999"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Sep 2025 19:31:44 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v2Kis-0006jn-16;
	Sat, 27 Sep 2025 02:31:42 +0000
Date: Sat, 27 Sep 2025 10:31:25 +0800
From: kernel test robot <lkp@intel.com>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Bluetooth: btusb: Add one more ID 0x13d3:0x3612 for
 Realtek 8852CE
Message-ID: <aNdMfeel0qGmgWjB@c9c1bd7d5eb8>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927-ble-13d3-3612-v1-1-c62bbb0bc77c@outlook.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] Bluetooth: btusb: Add one more ID 0x13d3:0x3612 for Realtek 8852CE
Link: https://lore.kernel.org/stable/20250927-ble-13d3-3612-v1-1-c62bbb0bc77c%40outlook.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




