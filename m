Return-Path: <stable+bounces-47816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71548D6E04
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 07:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A961C217F7
	for <lists+stable@lfdr.de>; Sat,  1 Jun 2024 05:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E400B64B;
	Sat,  1 Jun 2024 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/mDr8e2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87AF9CC;
	Sat,  1 Jun 2024 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717219211; cv=none; b=JnIwwX+6PN8S8AQ5zORXg3AeUm/chPkXd7J92lGWqWCg0ChdrSj9VxfsDOO4MUc1vMwSp1NPeSJMtJ8KkR4ZPKEVaFzZrQXX9G5rjWd5RFoeJKp9kheBvxQVCHVYMnAm0gTSaqqPu/XC4YquV3QcxGHVitKJSXH5p99xlxJEmZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717219211; c=relaxed/simple;
	bh=F37TZpHVwLcm3fW7tNFu6Jl5Qzq7pHJIpm3FmoVNQZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERuV/Ehq8lmOUgAk1fVHePGGfeAYsX/yxYSChLqPFJvwC+QQq4QnEMBTEeIdz7bfDdzkB7nXEKENksyPYSOigEP5D+WAqveMMW84MJKD07oGbvFMLNRB3+gfMoleIe4ewV/cp7h71Z0ykX6DI1wCt43AHYfXQuyWwAc6o1ETu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M/mDr8e2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717219210; x=1748755210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F37TZpHVwLcm3fW7tNFu6Jl5Qzq7pHJIpm3FmoVNQZo=;
  b=M/mDr8e2+/n/BmTKSNjYv12FxGMbUU9OLPohG7SpvsCtEo9tXSzuoDTr
   ZdYHH0+4g16URGhoNCkTU1aZdAT44z3kV+VxZPCRSl8PP2EiVhP/TWtfp
   NkbOle04NfPeK8/m47zPkNuNo8Jg3x2ar9DSQpS+0BcAoGFI05Okxk8mi
   k4i/EmRHOgf3VpdvAxkzueQmDllluvGCqrqjo7j3uZM7KAAR6XtXumC9w
   jEWz2HW9MsBtl3OYZQVdlc/j/N16BCIXzxvg/FFRFy67h3WEcNVbrYYvP
   VjUWuhXs30qtw/cdgRumftEICOCNLvbzVgXNuNOVddwet9ef0DLW6ijgo
   w==;
X-CSE-ConnectionGUID: njX/XrvWTvG4iTKts9NIlg==
X-CSE-MsgGUID: u3tX4qfOSRGCiuSGvTPm+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13618126"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="13618126"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 22:20:10 -0700
X-CSE-ConnectionGUID: TQcw1yjrSeWxR1JKsJDeMA==
X-CSE-MsgGUID: I6KDIsNISyOatKivwMuAPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="41288006"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 31 May 2024 22:20:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5D3AB128; Sat, 01 Jun 2024 08:20:06 +0300 (EEST)
Date: Sat, 1 Jun 2024 08:20:06 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>, stable@vger.kernel.org,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: Do not enable LPM if no LPM states are
 supported by the HBA
Message-ID: <20240601052006.GG1421138@black.fi.intel.com>
References: <20240531120711.660691-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531120711.660691-2-cassel@kernel.org>

On Fri, May 31, 2024 at 02:07:11PM +0200, Niklas Cassel wrote:
> LPM consists of HIPM (host initiated power management) and DIPM
> (device initiated power management).
> 
> ata_eh_set_lpm() will only enable HIPM if both the HBA and the device
> supports it.
> 
> However, DIPM will be enabled as long as the device supports it.
> The HBA will later reject the device's request to enter a power state
> that it does not support (Slumber/Partial/DevSleep) (DevSleep is never
> initiated by the device).
> 
> For a HBA that doesn't support any LPM states, simply don't set a LPM
> policy such that all the HIPM/DIPM probing/enabling will be skipped.
> 
> Not enabling HIPM or DIPM in the first place is safer than relying on
> the device following the AHCI specification and respecting the NAK.
> (There are comments in the code that some devices misbehave when
> receiving a NAK.)
> 
> Performing this check in ahci_update_initial_lpm_policy() also has the
> advantage that a HBA that doesn't support any LPM states will take the
> exact same code paths as a port that is external/hot plug capable.
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> We have not received any bug reports with this.
> The devices that were quirked recently all supported both Partial and
> Slumber.
> This is more a defensive action, as it seems unnecessary to enable DIPM
> in the first place, if the HBA doesn't support any LPM states.
> 
>  drivers/ata/ahci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 07d66d2c5f0d..214de08de642 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1735,6 +1735,12 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap)
>  	if (ap->pflags & ATA_PFLAG_EXTERNAL)
>  		return;
>  
> +	/* If no LPM states are supported by the HBA, do not bother with LPM */
> +	if ((ap->host->flags & ATA_HOST_NO_PART) &&
> +	    (ap->host->flags & ATA_HOST_NO_SSC) &&
> +	    (ap->host->flags & ATA_HOST_NO_DEVSLP))

For debugging purposes in case of potential issues, perhaps add a debug
log here so it is visible that we don't enable LPM?

> +		return;
> +
>  	/* user modified policy via module param */
>  	if (mobile_lpm_policy != -1) {
>  		policy = mobile_lpm_policy;
> -- 
> 2.45.1

