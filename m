Return-Path: <stable+bounces-126568-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9462EA702D2
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F19E162277
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A1E25522E;
	Tue, 25 Mar 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKPjDZQw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503731DC9A2
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910487; cv=none; b=stxWy2PLSjZBkLfy7wIH4dVXOs78Ps0DbxLlLxM5aDoM/+fTi0wBYHkpvfymmiuRvmAfeCrTvwqyfCHesyF31a3ytilU8VyXydDafx5GyFpbscqZ9PnYDRsAz7lRKyAQPese54nrYCQ6Q93kEVjTLk9cQpqEoWB8hArD4oypeZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910487; c=relaxed/simple;
	bh=1/aQYIHFQoNh4MYWRRZN607HcXB5i8XZ3AxCLJdo6J0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PVP9qI4oZA1jXVrVc2foYRXbwEFL2Hx5Fsc2LS/J1sQTAOh7s/XyMvMcQkPe5DCol30M7s4VukGc6rX9a9z8Sz83WA0vnUDr5Zee003n1jP71AcS9AOHlTAe7Z5t+1P2R/1lNMlARBeUrAzn7NxcVPHwUOpTgLDeHuartAk8gj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKPjDZQw; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742910485; x=1774446485;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=1/aQYIHFQoNh4MYWRRZN607HcXB5i8XZ3AxCLJdo6J0=;
  b=FKPjDZQwDgDGjkGBTX2NdKU7k3p0Kvlx5+wbeOhTBAc3WHBRhmPnKuvZ
   xP7hiFoDgRX/yzI4Mpgk8SbN48e8C02R+VH5A8dtTEkOyA21XmDqwno1F
   G57AZ452Tspf+UQprcRYAgnhl2x4OLxxsgDYOBiTvB3W9SvizAgNzp9LI
   dXM1J463Ul0CzoytIdDtnvNwZ0prD7dGMPy81j/zx5iIJXRcx6qgYLEJH
   H5evmnNOfDu9kCAvmeT2xzxCBykT9MJeSY6dYG9CqW+T5gPnoB8FZPpGD
   mUYP3e6y6Hq5hS1MmyLd+skHA9Aofjnc7VwBfIzqcf52rL8RslFncwWRD
   Q==;
X-CSE-ConnectionGUID: qxqTS9gqRRaTNSer0Iw+ug==
X-CSE-MsgGUID: j7d9R1TqRV+SWIAqZcX4pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11384"; a="44339492"
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="44339492"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 06:48:05 -0700
X-CSE-ConnectionGUID: COwEK8C8QDaCRVwi/j7XTg==
X-CSE-MsgGUID: FayvB1dpQuan1XOkeSvs1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,275,1736841600"; 
   d="scan'208";a="147562364"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 25 Mar 2025 06:48:04 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tx4dK-0004vL-0d;
	Tue, 25 Mar 2025 13:47:59 +0000
Date: Tue, 25 Mar 2025 21:47:04 +0800
From: kernel test robot <lkp@intel.com>
To: Aaro =?iso-8859-1?Q?M=E4kinen?= <aaro@tuxera.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] hfsplus: Return null terminated string from
 hfsplus_uni2asc()
Message-ID: <Z-Kz2MTBTHchLsWq@f921524d7199>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325132947.55401-1-aaro@tuxera.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH] hfsplus: Return null terminated string from hfsplus_uni2asc()
Link: https://lore.kernel.org/stable/20250325132947.55401-1-aaro%40tuxera.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




