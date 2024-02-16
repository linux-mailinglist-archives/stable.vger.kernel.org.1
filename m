Return-Path: <stable+bounces-20354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D52E857C65
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 13:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EF1F23660
	for <lists+stable@lfdr.de>; Fri, 16 Feb 2024 12:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E450C7868C;
	Fri, 16 Feb 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi1ob1v7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6F1BC57;
	Fri, 16 Feb 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085785; cv=none; b=bmsUUft7xYCQyP62PHbWdjMPi5U1/WjijyMct/JCXF2QglQTmDUsNFSBgFDMLT8ZiFFuICNW+rZV4capiVw/kdbiN3IJc2NJSSVH4ThQybWFTJTe3077NQyAq6/ZIL7bswt/YoGs9zyQiUD+hOpOAmwvToUZqalpFOoQ8I2pY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085785; c=relaxed/simple;
	bh=gvRXMuEERxbCVJUoyPappjaj9g7paEIR/M6OHu9YhKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=plvdMOHea0FHHMZnwc4rSGF32kdaeYPPyvmFzEJ/iiCiwQjKuoJXuDgGcZ566bmJ4kFPx+RlPz1+pWgH+6KWAn2N8BLRcvhhGUEkLUPwOjWMfaUSKQTFpJ70gO/Cwh9MvAteBc4QFOWrH8eJ6jFWXhgGutFGj6RnkdIV9Yco20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi1ob1v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BD1C433F1;
	Fri, 16 Feb 2024 12:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708085785;
	bh=gvRXMuEERxbCVJUoyPappjaj9g7paEIR/M6OHu9YhKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Mi1ob1v72PpAedlPwp7UQ6Vy8Yd1wl38U1nOhWqQ3TNVGD6V/+7A+jvs++2noX9qE
	 OEHNcbfpa/k4+AzlSEtSuKfyJMtitjZGB1qsfeAi5qBJEpK80t5sWWT3s9ZBfAhIok
	 1M+0U9wopm6VVMGKINscP0wJGYK3NGuRj+WknJmXQ8eTrQZsNroLD/nNypf5GOJ1hC
	 3YQ/eOyStOBVhcfjKYZUVWDOOYLmewJBlJ4swPJNmXebXUe6rjKMEIZ8xpCk2r4cwZ
	 WeWZJhmNPw6kFHLshThQISUwHIMaFec7jMXwuk0M4mBB1NgyfZVqTFX8h1jrz8o5Oy
	 96mz7D9J9dM3Q==
Message-ID: <c2054321-401d-4b16-9c20-20ea11929f49@kernel.org>
Date: Fri, 16 Feb 2024 21:16:23 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Do not call ata_dev_power_set_standby()
 twice
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>,
 linux-ide@vger.kernel.org
References: <20240216112008.1112538-1-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240216112008.1112538-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/16/24 20:20, Niklas Cassel wrote:
> From: Damien Le Moal <dlemoal@kernel.org>
> 
> For regular system shutdown, ata_dev_power_set_standby() will be
> executed twice: once the scsi device is removed and another when
> ata_pci_shutdown_one() executes and EH completes unloading the devices.
> 
> Make the second call to ata_dev_power_set_standby() do nothing by using
> ata_dev_power_is_active() and return if the device is already in
> standby.
> 
> Fixes: 2da4c5e24e86 ("ata: libata-core: Improve ata_dev_power_set_active()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> This fix was originally part of patch that contained both a fix and
> a revert in a single patch:
> https://lore.kernel.org/linux-ide/20240111115123.1258422-3-dlemoal@kernel.org/
> 
> This patch contains the only the fix (as it is valid even without the
> revert), without the revert.
> 
> Updated the Fixes tag to point to a more appropriate commit, since we
> no longer revert any code.
> 
>  drivers/ata/libata-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index d9f80f4f70f5..af2334bc806d 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -85,6 +85,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
>  static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
>  static void ata_dev_xfermask(struct ata_device *dev);
>  static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
> +static bool ata_dev_power_is_active(struct ata_device *dev);

I forgot what I did originally but didn't I move the code of
ata_dev_power_is_active() before ata_dev_power_set_standby() to avoid this
forward declaration ?

With that, the code is a little odd as ata_dev_power_is_active() is defined
between ata_dev_power_set_standby() and ata_dev_power_set_active() but both
functions use it...

>  
>  atomic_t ata_print_id = ATOMIC_INIT(0);
>  
> @@ -2017,8 +2018,9 @@ void ata_dev_power_set_standby(struct ata_device *dev)
>  	struct ata_taskfile tf;
>  	unsigned int err_mask;
>  
> -	/* If the device is already sleeping, do nothing. */
> -	if (dev->flags & ATA_DFLAG_SLEEPING)
> +	/* If the device is already sleeping or in standby, do nothing. */
> +	if ((dev->flags & ATA_DFLAG_SLEEPING) ||
> +	    !ata_dev_power_is_active(dev))
>  		return;
>  
>  	/*

-- 
Damien Le Moal
Western Digital Research


