Return-Path: <stable+bounces-47749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3687E8D54E7
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 23:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D067B28684A
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 21:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB91836E3;
	Thu, 30 May 2024 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhCgVx6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61061183089;
	Thu, 30 May 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717106111; cv=none; b=lot/FR9SnBI06MwAzDlQp0T5EzaGy0gHG6eSenrArsJfzAtISbD4Hn3lWWuUmvh8HxIpTH+4UrzqgWTWGNXP/IqpqS80qX4gz4tryXzpEbV/vx8wE9wIctK6v4JioDKXfwWHOvE50loPSKggisHZ1W38DjMKoL4zhCnmxIZyxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717106111; c=relaxed/simple;
	bh=AioVk8wkm7HveOl09BKYM+zAseZQ8CtD7sxKMh1BGsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmvJzkOVl8496W5hAZlUiGaWr/cOiXbFZ4jEQdOzA8Bgog/Mxuxq8VQepPpJPQ0qKCzxOlrDtK16H3nzgbYcKgz5WHF2snbRMpSc7Tqjy9QJUog4QnuUUukSsXClDnj7FhZut14O/+Go5Vx+fdsf5ZA3WlkyBei78m9Hfbx3+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhCgVx6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C599C32786;
	Thu, 30 May 2024 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717106109;
	bh=AioVk8wkm7HveOl09BKYM+zAseZQ8CtD7sxKMh1BGsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhCgVx6/A/uTKPQcNtolL25HFesohR9o/HJ/osjwz0KifrK58iVlCHOrk0YDumNf5
	 jKrZNMIoDElpJCDKCW8352wtPuEtFtzEmZLkAiAwUL41Mnk+6IFn48tpwkUnzcKR3u
	 cQ/y8kvhe1aNIFqwYxvFW2dB47nssFTBUKpe7/Fb/F9I/RionDqBrugYDZMmmbsPv2
	 IDX/yyk59YTmP3aEmjG6nule79Xig0d2SbK06vumun2j5EGY1m9fAB3yKE7NIWAKVF
	 Jk6B5LemWNjxW0I2rL52ZYjh4ypUrjMwLA0asOGBRRlOQq+XmzKHGZWwg8Ank3/zvl
	 CQ3rzyffbr/tw==
Date: Thu, 30 May 2024 23:55:05 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org, Tim Teichmann <teichmanntim@outlook.de>,
	linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340
Message-ID: <Zlj1uc9FcLaSPoOX@ryzen.lan>
References: <20240530212703.561517-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
> ---
> On the system reporting this issue, the HBA supports SALP (HIPM) and
> LPM states Partial and Slumber.
> 
> This drive only supports DIPM but not HIPM, however, that should not
> matter, as a DIPM request from the device still has to be acked by the
> HBA, and according to AHCI 1.3.1, section 5.3.2.11 P:Idle, if the link
> layer has negotiated to low power state based on device power management
> request, the HBA will jump to state PM:LowPower.
> 
> In PM:LowPower, the HBA will automatically request to wake the link
> (exit from Partial/Slumber) when a new command is queued (by writing to
> PxCI). Thus, there should be no need for host software to request an
> explicit wakeup (by writing PxCMD.ICC to 1).
> 
> Therefore, even with only DIPM supported/enabled, we shouldn't see command
> timeouts with the current code. Also, only enabling only DIPM (by
> modifying the AHCI driver) with another drive (which support both DIPM
> and HIPM), shows no errors. Thus, it seems like the drive is the problem.
> 
>  drivers/ata/libata-core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4f35aab81a0a..25b400f1c3de 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4155,6 +4155,9 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
>  						ATA_HORKAGE_ZERO_AFTER_TRIM |
>  						ATA_HORKAGE_NOLPM },
>  
> +	/* Apacer models with LPM issues */
> +	{ "Apacer AS340*",		NULL,	ATA_HORKAGE_NOLPM },
> +
>  	/* These specific Samsung models/firmware-revs do not handle LPM well */
>  	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM },
>  	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM },
> -- 
> 2.45.1
> 

One interesting fact which:
Apacer AS340, CT240BX500SSD1, and R3SL240G all have in common:
their SSD controller is made by Silicon Motion:
https://smarthdd.com/database/Apacer-AS340-120GB/U1014A0/
https://smarthdd.com/database/CT240BX500SSD1/M6CR013/
https://smarthdd.com/database/R3SL240G/P0422C/

Not sure if that is relevant or not...


Kind regards,
Niklas

