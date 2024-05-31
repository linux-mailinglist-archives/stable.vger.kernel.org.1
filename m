Return-Path: <stable+bounces-47787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA78D6248
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 15:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BF61C2311B
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B46315747C;
	Fri, 31 May 2024 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWHYfN6s"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7876381AD;
	Fri, 31 May 2024 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160431; cv=none; b=lit47bhW863Ltyxl/pHVHyd9pUUWcwK1AzU4D0ein7PcfUfx/xOVJbmp7Gn5+mb3923giZlPi5lk/hp+wNZok7TXaaTM7dAkCO3EmS9D9kJwkO7VKWyM63ggyOYIHhoe/a4FvacXNpUWHASE4AmSfiNOiz99WHI0JoqQ+QczXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160431; c=relaxed/simple;
	bh=naOE++1E37BWHUwak8mFZXoCMaJOS9N5XYkePwUS/ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVyKcgpL/bmE0sTbAerpUaoWXAzJTvmtaSdXjrfkVsujJI7b5Ky10aft6XEE8hmgC2Rsuuert2F4WJFV5qxAJpfhq6tXlihIIcaVLHqjtZpeF9ZHfcs+C9Qmz+yN3IQgOpvYPsTSfH6MF5ISk+IeOEUWuKlRVJnmd9Ma3KkjDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWHYfN6s; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717160430; x=1748696430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=naOE++1E37BWHUwak8mFZXoCMaJOS9N5XYkePwUS/ho=;
  b=ZWHYfN6sUdYqvBXtfopusCHRR7xfpLLIL7OND5BPqNLRwU7jCOmWJIqY
   UWjm/yXx9n2G8UVOMAEEchO4Xyi9LxQHQbM6wU4qTXBVRVcS59coXajJQ
   4k+I+1eI7iMwBaZ9XIMmL869aJpRwXBJ2Ku4a6noN3y62PpwNVkfKBHBZ
   Bsn6WGH0sciqMrzMz8C9qTPC6XdQRNj35wfUwyeML5h+cOfV72NvTZtY4
   nMZ1ySwqpTJVFeJTJCyvIvXq7ntuvGQPzDYszXTLlhh1EGcVAeFdAJu1C
   jtG7xQ1WHKTGtV9w+YIkAyIvi6T5cvKLc5M0UBqZ9bvAmujitV+RVj5Pe
   g==;
X-CSE-ConnectionGUID: xK8F9FskTcycYDzIAlTCaA==
X-CSE-MsgGUID: kMdm6PwsQ/SqQbJ6qaC6oA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13519402"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13519402"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 06:00:29 -0700
X-CSE-ConnectionGUID: 1YWH9sXOSuKEBhU9k5vofA==
X-CSE-MsgGUID: L65jv/znQACT8SqP+qyEXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36742821"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 31 May 2024 06:00:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D741F18E; Fri, 31 May 2024 16:00:25 +0300 (EEST)
Date: Fri, 31 May 2024 16:00:25 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>, stable@vger.kernel.org,
	Aarrayy <lp610mh@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Crucial
 CT240BX500SSD1
Message-ID: <20240531130025.GE1421138@black.fi.intel.com>
References: <20240530212816.561680-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530212816.561680-2-cassel@kernel.org>

On Thu, May 30, 2024 at 11:28:17PM +0200, Niklas Cassel wrote:
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
> The problem is that Crucial CT240BX500SSD1 drives do not handle low power
> modes correctly. The problem was most likely not seen before because no
> one had used this drive with a AHCI controller with LPM enabled.
> 
> Add a quirk so that we do not enable LPM for this drive, since we see
> command timeouts if we do (even though the drive claims to support DIPM).
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Reported-by: Aarrayy <lp610mh@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218832
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

