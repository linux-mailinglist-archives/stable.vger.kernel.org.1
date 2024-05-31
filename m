Return-Path: <stable+bounces-47786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210238D6242
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 14:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523A41C23069
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 12:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003A9158847;
	Fri, 31 May 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="USU2CRzF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F01138485;
	Fri, 31 May 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160368; cv=none; b=K9d1cyHrio6srIVzQ03h4eOi5kIMQ/mt8mUBdwoopzXH2BCSGlgxpyGqB5mVcaM2an3/m1u+l9Ku0Kkl8bdEwZY5WQaNnumUyCUjPpJ5c3p34PPfvplrqvKM1F5q+FNc91S86rK9d/S+ajOL1bk4PKVpemAi64ngyin67OmLcoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160368; c=relaxed/simple;
	bh=K8kZuppoP4Xv4LOZqV8dBfBJXaEBYHMoK4kN57wFsrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DC89r5XBe65Y1lxPLN8vdO8Dumg3sH9sWhtxojvWI8QFbpiA/TanJA1oBD+Yg1ZoB7/3aXcYkAISQqCnx7LNbHF66sXP1ndLCPR9f9QsJZ5sIgJ0MO8SwY9JhFD4HJw+dfbJUxJyaUX7iH6lbP2jiuw75qzHds6tGwb8KPteKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=USU2CRzF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717160367; x=1748696367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8kZuppoP4Xv4LOZqV8dBfBJXaEBYHMoK4kN57wFsrk=;
  b=USU2CRzF0KUTKl6/6N7nEYjJq6FRVNpGipV7RRc5NDP80szZ0q+NpgnD
   vcxL46XHnnz6e7lKDFXkBEXAVaOyRxfjiWzTX/WQarJV2X9XV+FrNbarK
   bapiNyq5TQPb5Rr9VXTH0hKwrKBs/7v3ZItv8HMSGSt04oEQrCCG+Kq1l
   eOObGKJZ+a7Z716KWMq56jvYTdLk3h8o52s3t98TCR3Guf8mEv5BVNqB6
   GlQwl3oRxOcDr26ft39GiSU56Ct1iqT2Nwi3+NjlNKvJmfSPcCXG5Nw2e
   VinO5FiPs5eaVaVVebyAvpQXQNpcyR/Cg0JsvsJdOINVSSyoVQuZEaJna
   w==;
X-CSE-ConnectionGUID: W74/62VZQsajZjVa5KCW2g==
X-CSE-MsgGUID: 2HT4uq7XT/+PvcCzVyDnjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13519288"
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="13519288"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 05:59:27 -0700
X-CSE-ConnectionGUID: WOJvKTS1TcuOQYrz7Vk5fQ==
X-CSE-MsgGUID: QJ/JHsAOS3qpecs7kBBGug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="36742438"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 31 May 2024 05:59:25 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7AA5F18E; Fri, 31 May 2024 15:59:23 +0300 (EEST)
Date: Fri, 31 May 2024 15:59:23 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>, stable@vger.kernel.org,
	Tim Teichmann <teichmanntim@outlook.de>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340
Message-ID: <20240531125923.GD1421138@black.fi.intel.com>
References: <20240530212703.561517-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530212703.561517-2-cassel@kernel.org>

On Thu, May 30, 2024 at 11:27:04PM +0200, Niklas Cassel wrote:
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
> The problem is that Apacer AS340 drives do not handle low power modes
> correctly. The problem was most likely not seen before because no one
> had used this drive with a AHCI controller with LPM enabled.
> 
> Add a quirk so that we do not enable LPM for this drive, since we see
> command timeouts if we do (even though the drive claims to support DIPM).
> 
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Cc: stable@vger.kernel.org
> Reported-by: Tim Teichmann <teichmanntim@outlook.de>
> Closes: https://lore.kernel.org/linux-ide/87bk4pbve8.ffs@tglx/
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

