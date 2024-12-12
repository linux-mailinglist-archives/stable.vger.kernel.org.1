Return-Path: <stable+bounces-100875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4AC9EE37A
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D776C162FDC
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB8E20E712;
	Thu, 12 Dec 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQ9QqcWz"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C2A13CF9C
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997176; cv=none; b=kp8HMEg/9p8i6GA70kZCjFIJBwGUjcaKr4d1YpUGRIK5TLlk0xZNYyPadWfBgdYobJpkpJIUkH7OzTNyITL23Oc7I8yBXtY9sc0NYCSvId/7Q7DXuO0CoiBAtddEZ4MSRQ9YSA5UiT5+g7cF2hL1BJs0XPQ6yehYRJbQ7CjLi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997176; c=relaxed/simple;
	bh=Z2m5/TwSIYTc/ivx0On8nWdm+GHqoAs8bzXWDjNa98E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=p0Bhyi+rQFW82zNdqyTdFCKsbzqyPjfuX/Pyjfdh+PIM1Aon6cHP/Fux4TjTo3jErOP8hO8Ag8yGY/IANwTDk9jT+EXG/zzDw4iOhQH74d4KpSnn5x0nB110/6lRGmKg8MN0JvMqnAkuAcC7Yg9A6HbMuLTYB7+OZPFCj7hRfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQ9QqcWz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733997175; x=1765533175;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Z2m5/TwSIYTc/ivx0On8nWdm+GHqoAs8bzXWDjNa98E=;
  b=NQ9QqcWzh3F2IVYthSJnfbrAOWzsQl7ibkL2XzTtEBzs7ujWmzftGAVg
   t5UsXdLriMOxXesQHsMoRIMIaRhAhdDPK2OLLGqFwcp86A4HDWdQVrD7Q
   umx+JFzrMq0SmdXsmvbtJ4U0sV9zTBEDvFj3lHOezlJ1v03wID9tI/gEK
   f+3HxWbZLpdU8TvURddIhucL0Aku712hbceS9ldwEegqBgEm/qZxe5Agt
   4mA+xLoOZIaEL59yAIeifgcZ/pAd76Ua67CYKxvMccoAKGYEpZbzrXkVN
   tAdDw65oD6y/qo5ONG3qJExviwCT+x0eX6pmj2Z03EfDsp8t5nLAm4M/c
   w==;
X-CSE-ConnectionGUID: KQU11eXZSBapvyLpoxkypQ==
X-CSE-MsgGUID: gHohOYKmTVqno+rbsYXgTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34133434"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34133434"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 01:52:55 -0800
X-CSE-ConnectionGUID: 2Tf/c2xfTceE0UCCTWTyuA==
X-CSE-MsgGUID: 5tWBdDPqRR6M+atqSxQ+9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96979225"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Dec 2024 01:52:53 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLfsI-0007gd-37;
	Thu, 12 Dec 2024 09:52:50 +0000
Date: Thu, 12 Dec 2024 17:52:23 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Przybylski <karprzy7@gmail.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCHv2] drm: zynqmp_dp: Fix integer overflow in
 zynqmp_dp_rate_get()
Message-ID: <Z1qyVwAS7diUYFd0@3b9f04db549b>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212095057.1015146-1-karprzy7@gmail.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCHv2] drm: zynqmp_dp: Fix integer overflow in zynqmp_dp_rate_get()
Link: https://lore.kernel.org/stable/20241212095057.1015146-1-karprzy7%40gmail.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




