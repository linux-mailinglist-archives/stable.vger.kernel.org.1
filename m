Return-Path: <stable+bounces-47788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1242E8D624F
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 15:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435461C212DB
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7530C1581FB;
	Fri, 31 May 2024 13:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boz965ri"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3890381AD;
	Fri, 31 May 2024 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160553; cv=none; b=ff9BKQESzX16/rmBvBp7X61N7RoZfinahOy3HNUwzM33XZuapVNIsrEXDSKocCuJ1/4SeSE+xVZ2sbuogeUcZB5iAU6SH/0KHX4y1woWczJAi+83DEdYwiOCI5elZqvjB++AEpihPh1k/mYmxr6yn+WmeEj4l3N3D+amG54mcc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160553; c=relaxed/simple;
	bh=vzPN99AVskkXBre/NkgI4J7Qk6aKO+24u2Z+6j+jxIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KH4XOHey5u/Do/zOmH1xhbTSi94e+VpIxo4AGBhiWP/n7Cvyu2aViD3Y5bEF9FmFViAiILyXyeJEZqJKkBt4lKgjmabvU8Aqdg9WUMneYPJTjXlNF668MHcO4PyP5WV2WvgtwHXI1OB069xsOF8hoDQSBdUhbhWAQJ2kNafxeyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boz965ri; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717160552; x=1748696552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzPN99AVskkXBre/NkgI4J7Qk6aKO+24u2Z+6j+jxIs=;
  b=boz965ri61fxXrMoKueix3UUSE7uLFgUct+Y/wQEDFNrD+FQ+xwkK1rh
   Za/vwVWbTon3/3FTnmtV7qwgvC2EM5IL5iC08LGXepgGLyoWGddJlmJPs
   uFFRPnc0v4Z/EV5NFUXPIRcKkQWgKA441OxFVSjICemqvqKIjK7yHOGgx
   AXoGpxDV6ztHWHaapxKBktQEVgSODucotkbdwInHFc8uC/ltOdxB7Tqzl
   HRw5gQi08ysgJA/KBh2tY1UswL5uah9rpIAgqMJPfFMYhcKv2lXeF+qx5
   v+RjeeJ2FCS6y4VcgShd9FQyHGulbyclF3kJsWAg9tmx/Zv8gAbzHJtrz
   g==;
X-CSE-ConnectionGUID: 39f3qJTeSFa+cAuKV4n2DQ==
X-CSE-MsgGUID: pFHdEPgkTuqeC56EaXeikA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25101837"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="25101837"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:02:31 -0700
X-CSE-ConnectionGUID: lYPfG7t1RSai3U5/C2mcmw==
X-CSE-MsgGUID: Tbq1OeOzTCCh7jMHMtcDEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="67011803"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 31 May 2024 06:02:29 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B904218E; Fri, 31 May 2024 16:02:27 +0300 (EEST)
Date: Fri, 31 May 2024 16:02:27 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>, stable@vger.kernel.org,
	Doru Iorgulescu <doru.iorgulescu1@gmail.com>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for AMD Radeon
 S3 SSD
Message-ID: <20240531130227.GF1421138@black.fi.intel.com>
References: <20240530213244.562464-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530213244.562464-2-cassel@kernel.org>

On Thu, May 30, 2024 at 11:32:44PM +0200, Niklas Cassel wrote:
> Commit 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> dropped the board_ahci_low_power board type, and instead enables LPM if:
> -The AHCI controller reports that it supports LPM (Partial/Slumber), and
> -CONFIG_SATA_MOBILE_LPM_POLICY != 0, and
> -The port is not defined as external in the per port PxCMD register, and
> -The port is not defined as hotplug capable in the per port PxCMD
>  register.
> 
> Partial and Slumber LPM states can either be initiated by HIPM or DIPM.
> 
> For HIPM (host initiated power management) to get enabled, both the AHCI
> controller and the drive have to report that they support HIPM.
> 
> For DIPM (device initiated power management) to get enabled, only the
> drive has to report that it supports DIPM. However, the HBA will reject
> device requests to enter LPM states which the HBA does not support.
> 
> The problem is that AMD Radeon S3 SSD drives do not handle low power modes
> correctly. The problem was most likely not seen before because no one
> had used this drive with a AHCI controller with LPM enabled.
> 
> Add a quirk so that we do not enable LPM for this drive, since we see
> command timeouts if we do (even though the drive claims to support DIPM).
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Reported-by: Doru Iorgulescu <doru.iorgulescu1@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

