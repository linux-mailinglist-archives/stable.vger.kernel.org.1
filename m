Return-Path: <stable+bounces-142956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F2DAB07BF
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 04:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654DA7B5E99
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 02:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54B22D9E2;
	Fri,  9 May 2025 02:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drsKpsa2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFF1AA782
	for <stable@vger.kernel.org>; Fri,  9 May 2025 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746756315; cv=none; b=g7iZ6fcNs9sb83S4uKKyk7wVwQLfQpkLXl8IdTCEcl1A3NI4EpnJNr+PStocakMI0DyHpgcEnOX6vu2GAhiJDL7ueHaU0fsCmhocpCIU4g29l4YIxdkxCS3PxEVX5BhAewUQWPSdM0KqqyKAquzUR0X3IsdobBAvMsYoKKkrrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746756315; c=relaxed/simple;
	bh=Fr3afaaBiQ1fuEPmraQ/CCsY3pGVvM5uDnGuwCFO/bE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tZJuKXfdYd6pf0GeQuPI7S+KHZ0ZYAGuNgZDN2is1dEYCRYzYp5d3dHVdNz30Z/76olRksw/nhvJah1KTsNKJ1QBuNJvz3HAzf7ug9z/a/6XRvmtNg7hliLzWIxqAXmGEW0M4hrqol9ChXJ32I3Lv+TsX94/KXGDhUqhnpCwxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drsKpsa2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746756313; x=1778292313;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=Fr3afaaBiQ1fuEPmraQ/CCsY3pGVvM5uDnGuwCFO/bE=;
  b=drsKpsa2ulhy/I2aBP8fViGDxw+BtSzdgxhv+RPW0HlqEON3RxDGM0PI
   9TDthaUo+CfxrScKtpxeU+eIPCnCy/y2nfrdL+WoejxYaRKrp4W695IXl
   0S2l6+isaQi16FSbxF9zYNypvw1XSh+BaL6yAveRrc4kUPzobxyZlIvUP
   mh8GWwfUmYAsTU1pbj2zH8HHEbFC9EMNAs40tjvstxpW9IqmIVYUDu2Tp
   YRd14Ea7GKx4jlAyKtl8Jlwhn7etKFuk/SKTWRfgMTtd557QStm0bX7XM
   ZA6y1zjynoMpJIV4Y84DWD2vfJF93eKO6hPhwF3rdJec2XMzltTNDQ2em
   Q==;
X-CSE-ConnectionGUID: jzWwIQ5zRnaP/xxoEHV26A==
X-CSE-MsgGUID: KEotKltSRiCHuYgBDTg6lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48477639"
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="48477639"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 19:05:12 -0700
X-CSE-ConnectionGUID: i6y03PySQ/OxAWUIV12pTg==
X-CSE-MsgGUID: lm3m+0cuS0uw0Azwei0k2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="137402965"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 May 2025 19:05:11 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uDD6q-000BZf-2r;
	Fri, 09 May 2025 02:05:08 +0000
Date: Fri, 9 May 2025 10:04:45 +0800
From: kernel test robot <lkp@intel.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 3/4] dma-mapping: benchmark: add support for dma_map_sg
Message-ID: <aB1ivUFR5Vm_QGih@c5bf816c9d15>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509020238.3378396-4-xiaqinxin@huawei.com>

Hi,

Thanks for your patch.

FYI: kernel test robot notices the stable kernel rule is not satisfied.

The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
Subject: [PATCH v3 3/4] dma-mapping: benchmark: add support for dma_map_sg
Link: https://lore.kernel.org/stable/20250509020238.3378396-4-xiaqinxin%40huawei.com

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




