Return-Path: <stable+bounces-126802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 020A1A72047
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 21:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 247267A4674
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B04C1A2541;
	Wed, 26 Mar 2025 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WfXoNLVp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6CA25E455
	for <stable@vger.kernel.org>; Wed, 26 Mar 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022696; cv=none; b=h/yLifjnDSybImrIGLIcxZVqdVIkq0fSLD59z1fwm9KdiuDUVYzLCB7QREqZAy6mWAWakidUAbVNrwa9KJdIuCpk6waybvxswrMOnnd1vH2CXHLabcVMbisrVH/T4/Btwx8S7QWQdkM6hGB+LZdXXjaM7E5k26fuC6g8DfcrQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022696; c=relaxed/simple;
	bh=dFH+ukUiMghBOSWrE7ldW4a+uXo8ERhXdImArjAiSRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bLvV/JWxtQSBywMH4C4ArWgm4QYHP/LJecFgjCCKrjH9CJ4p477NMGSbpnigSY5EWWrCSiwmwXIX816ugucCB/XoN9A/wLWMPt/dGbmP8tN4yY0qZrmBpavgb5xw8CXGTk1+uHjY6ZQozZ9xismL+8foNRz9XTlcPsAxlMdk9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WfXoNLVp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743022695; x=1774558695;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=dFH+ukUiMghBOSWrE7ldW4a+uXo8ERhXdImArjAiSRg=;
  b=WfXoNLVpijXIudWxw9h2jau8b7zOQHFFN7AUAC1B2ri54BlwpcmuOwsj
   yOHIKEiI5KYqqfy+hYnzY6zzglWAr6yBAQ0/UIblhtkDealskFVlUgI75
   NKpDejfO0FY744T7aQHYxJPv2A0YHapiXdnKaqiQzbCT6GYP3VHaUSUHM
   G+xp4uZZ2ZNUUYjVkVh7KWd04Kp1VhfpvSCdVE19oXaIeb6Ny+R+jqo8w
   b1EEvGHQJGuKdvBiv2AXpzvbX/9jWH0JgoXL3r7Ru4PqYDAchm0rzXsVD
   23u5zsp/PcrS3XxV2G7Pqm0g0/k9SL9Jjhe3AIM8clTpf7IAtk3z+9w8A
   A==;
X-CSE-ConnectionGUID: DO0WA4H4QYOLRL8Egn80aw==
X-CSE-MsgGUID: fVocJH8LQnOObE1tXWMbUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44455485"
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="44455485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 13:58:14 -0700
X-CSE-ConnectionGUID: RLEQXjNXQAiLBnTAulmYuA==
X-CSE-MsgGUID: 2avq7hJATQycnUngcCSJfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,278,1736841600"; 
   d="scan'208";a="155827783"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 26 Mar 2025 13:58:13 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1txXpC-00064V-2l;
	Wed, 26 Mar 2025 20:58:10 +0000
Date: Thu, 27 Mar 2025 04:57:11 +0800
From: kernel test robot <lkp@intel.com>
To: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] RDMA/cma: Fix workqueue crash in
 cma_netevent_work_handler
Message-ID: <Z-RqJ8Rf6ziGFiQb@06395982a548>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d53331-4b88-48bc-9266-f8862d75b156@oracle.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] RDMA/cma: Fix workqueue crash in cma_netevent_work_handler
Link: https://lore.kernel.org/stable/01d53331-4b88-48bc-9266-f8862d75b156%40oracle.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




