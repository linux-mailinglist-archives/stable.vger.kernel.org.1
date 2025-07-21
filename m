Return-Path: <stable+bounces-163608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D02CB0C7C9
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281C73B44E3
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37D72DFA2F;
	Mon, 21 Jul 2025 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzNOqgWF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C32E03E1
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112267; cv=none; b=suWQSTLl98AhP18ovCDfvZnol/sTSRPYy6FV23Lt7RPTBoqJtfvk29NGsyUmvZbPqXsXohxG5JV2uhkHASQraA2E0bzu9F4omizICUjwZ4h5hD+B4XwOefw1T6jdJ73YGDAOnPUH4mbWWBiYLxjzNc2iPVyom6RYTHy0sQMK5OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112267; c=relaxed/simple;
	bh=I6CweaXq/1T60CXfZ0M3luYNGim2F3bGuyRiuvxOjtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=omC4nZGEhAPPC88VM71q3QOH8D6GIcF/jLtd18WNBJMCsp2cTlC6j0eCBS5+U/di6uOXMlX60V7rXRVTBxqlDy1t6j4tNglnCb0Oria39ruA9TjuCSjhRXrclCFiQJ1BvWNl8jZj6HFKBoGMFRvtoDMiu15YOaT4scB7f1HfXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzNOqgWF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753112266; x=1784648266;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=I6CweaXq/1T60CXfZ0M3luYNGim2F3bGuyRiuvxOjtw=;
  b=WzNOqgWFVO2DyNFIvpBdf0+g6tG8HMi1Ret5HA3P9l9AvdwUKFDb9TX1
   BkZDXmfB1iVobC4ZBhlb9idaTEZoZTm1PvGJCPtzD3uEuloN6+g9Q3Ccs
   oJ7SBwl5MBF1cfgMQC6H7E4C/GQhjgsVJ3Pj5OeuOv8rSR6v/9Kj61zaX
   l8G+KGb+lQZy1NLycK4FhlLZeRl7Y93zYIRKBbBD2s/yz6QLKWIyL3EHp
   m+qC3Hu8yp74LPaoHmPJJ64Ct0D4Z1X+DrLdhrgs1IF0DaGUzh2BVTaRj
   Cb5QRdM+8bIDKdmeYWVRhXs7rKMnCS0gsL52PHfHeOF8J9+IKMfZ6CdIb
   A==;
X-CSE-ConnectionGUID: HYyOHVBaSp+HIkyMYaiIqA==
X-CSE-MsgGUID: qd87gDwuTFC1dnvuvR+wGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="54431867"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="54431867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 08:37:45 -0700
X-CSE-ConnectionGUID: lltkx+lSQWiXCN3mZbd4JQ==
X-CSE-MsgGUID: 2D+2+C0iQaS5mXQi5jmaOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="189862786"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Jul 2025 08:37:44 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1udsaD-000Gvh-26;
	Mon, 21 Jul 2025 15:37:41 +0000
Date: Mon, 21 Jul 2025 23:37:40 +0800
From: kernel test robot <lkp@intel.com>
To: David Thompson <davthompson@nvidia.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v1] gpio-mlxbf2: only get IRQ for device instances 0 and 3
Message-ID: <aH5exOfeBDhvR9oB@6f60a8441bb9>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721153523.29258-1-davthompson@nvidia.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v1] gpio-mlxbf2: only get IRQ for device instances 0 and 3
Link: https://lore.kernel.org/stable/20250721153523.29258-1-davthompson%40nvidia.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




