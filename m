Return-Path: <stable+bounces-46263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B797D8CF685
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 00:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE0A281B0E
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 22:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E1A84D30;
	Sun, 26 May 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAoPWJ6/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0922C15D;
	Sun, 26 May 2024 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716762253; cv=none; b=Y97tAvilU9C4PwDfaolxa9K74wi+TuMgsOlqK1bavyes+wh2Q6IA1/rlNYsreFRk+se+NPx9z6Fw0nv9XVsrnTd9OKyJscipB+FXdjuHswp5A5ByrMGHlIp6Emnv87RwDFWiwEBrOPOyaA/TEOIJD0cTa22m/08EQN4vXaYbI80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716762253; c=relaxed/simple;
	bh=zwKstD3lioMVt2D17H5ZgaYpuRrgTkKfoVAlPT6ZOr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2P6z0BbqrGZv6C0glmBGTuu9iz0tXHVIWvr+Y4Q33M9fXhvTbsIPNRS2KvyjtBtf/CkPUiLLlJi98H2lj47omKQnBKiLvcJlDcpYQi+UH8XtkKQ0chL8OtzsL5Wpurc3vLmEZI93Clm22HrCEZqpLo9oSxYa8rfJHQZHZyWywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAoPWJ6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEF3C2BD10;
	Sun, 26 May 2024 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716762252;
	bh=zwKstD3lioMVt2D17H5ZgaYpuRrgTkKfoVAlPT6ZOr0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JAoPWJ6/UWwscZxI+qeg8ORPwqQK5SBkp4usvIOkvdcBHtj8IXPm5EaJBckl7Bjzz
	 Vq+SR12ri2euZT+bbrueXy3sa/8wnTw4jMVNXP0NlcPSC/GkGnaRhu8MWBF8eUz5Ln
	 gGKydBZyYDI8mk79sislpfmdMD+uo7sCeR7rF56cDwRRoKh+1D71yNuiDKxvxIsQYY
	 nhTAiqQGkdqx8yngbQbVmzj/e7VKpQoxzUETLmPP9FDs74YKkHBWFwaROZQ/q9OMDf
	 pCFwrH+nv0WhKKvf6RcMd2gXdwK9L6OaNLZ1szhcOsnXk/q6BUUFUNwsUaV3dpoPCU
	 gQhpu/VHKikXQ==
Message-ID: <addf0f96-68f2-40e1-992a-7c63cf66425e@kernel.org>
Date: Mon, 27 May 2024 07:24:11 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "ata: libata: move ata_{port,link,dev}_dbg to standard pr_XXX()
 macros" - 742bef476ca5352b16063161fb73a56629a6d995 changed logging behavior
 and disabled a number of messages
To: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>,
 Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
 IDE/ATA development list <linux-ide@vger.kernel.org>, stable@vger.kernel.org
References: <fd285ecd-597f-4770-b9ac-8e9f6ca37587@ans.pl>
 <ZjlQV-6dEgwhf-vc@ryzen.lan>
 <9140fb43-8c58-4a01-85ab-08d179a6cb59@kernel.org>
 <d7a8ca73-3625-4d13-8ece-fc38519594d6@ans.pl>
 <81f19ca4-bb63-4d72-a197-c27f1bb7d381@kernel.org>
 <a116c331-530e-4d45-a32c-37c57542724a@ans.pl>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <a116c331-530e-4d45-a32c-37c57542724a@ans.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/24 3:39 PM, Krzysztof Olędzki wrote:
> Thank you. How about the following patch? I'm sure I missed something
> but it should bring us close to where we were before the logging cleanup.
> 
> If something like this is acceptable, perpahs it would be also possible
> to include it in the -stable kernels, I think up to and including 5.15?

Please send a proper patch with afixes tag and cc-stable tag instead of
something as a reply to this thread. We will do the review of that.

> 
> From b1f93347828a3d8c52ae4a73f9fb48341d0c2afb Mon Sep 17 00:00:00 2001
> From: Krzysztof Piotr Oledzki <ole@ans.pl>
> Date: Sat, 25 May 2024 22:35:58 -0700
> Subject: [PATCH] ata: libata: restore visibility of important messages
> 
> With the recent cleanup and migration to standard
> pr_{debug,info,notice,warn,err} macros instead of the
> hand-crafted printk helpers some important messages
> disappeared from dmesg unless dynamic debug is enabled.

Very short lines. Please format this up to 72 chars per line.
And instead of using the very subjective "recent" term for the message changes,
please reference the commit that did it.

> 
> Restore their visibility by promoting them to info or err (when
> appropriate).
> 
> Also, improve or add information about features disabled due to
> ATA_HORKAGE workarounds like NONCQ, NO_NCQ_ON_ATI and NO_FUA.

This part should be a different patch as it is not "fixing" the previous
changes but adds new messages.

> 
> For ATA_HORKAGE_DIAGNOSTIC and ATA_HORKAGE_FIRMWARE_WARN convert the
> message to a single line and update the ata.wiki.kernel.org link.

Hmmm... I have no idea who created that wiki nor if it is maintained at all...
We (the libata maintainers) are for sure not maintaining it. So I would prefer
to entirely remove that link as I am not sure the information there is correct
at all. If anything needs to be documented, then add a note in
Documentation/./driver-api/libata.rst". (note that I have actually never looked
at this doc file either since taking on libata maintainership. Its content may
not be up-to-date. Will need to review it.).

> Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
> ---
>  drivers/ata/libata-core.c | 49 +++++++++++++++++++++------------------
>  drivers/ata/libata-eh.c   |  2 +-
>  2 files changed, 28 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 4f35aab81a0a..0603849692ae 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1793,7 +1793,7 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  
>  	if (err_mask) {
>  		if (err_mask & AC_ERR_NODEV_HINT) {
> -			ata_dev_dbg(dev, "NODEV after polling detection\n");
> +			ata_dev_err(dev, "NODEV after polling detection\n");

The "NODEV" mention here makes no sense given that we return -ENOENT. Let's
instead print the error mask with the usual format.

>  			return -ENOENT;
>  		}
>  
> @@ -1825,8 +1825,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  			 * both flavors of IDENTIFYs which happens
>  			 * sometimes with phantom devices.
>  			 */
> -			ata_dev_dbg(dev,
> -				    "both IDENTIFYs aborted, assuming NODEV\n");
> +			ata_dev_info(dev,
> +				     "both IDENTIFYs aborted, assuming NODEV\n");

This is not really normal, so let's make this a "warn". And replace "NODEV"
with "no device present.".

>  			return -ENOENT;
>  		}
>  
> @@ -1857,9 +1857,9 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>  	if (class == ATA_DEV_ATA || class == ATA_DEV_ZAC) {
>  		if (!ata_id_is_ata(id) && !ata_id_is_cfa(id))
>  			goto err_out;
> -		if (ap->host->flags & ATA_HOST_IGNORE_ATA &&
> -							ata_id_is_ata(id)) {
> -			ata_dev_dbg(dev,
> +		if ((ap->host->flags & ATA_HOST_IGNORE_ATA) &&
> +		    ata_id_is_ata(id)) {
> +			ata_dev_info(dev,
>  				"host indicates ignore ATA devices, ignored\n");

Let's improve the wording here as "host" has a meaning (e.g. scsi host). Let's
make this something like:

		 ata_dev_info(dev,
			"ATA_HOST_IGNORE_ATA set: ignoring device.\n");

>  			return -ENOENT;
>  		}
> @@ -2247,7 +2247,8 @@ static void ata_dev_config_ncq_send_recv(struct ata_device *dev)
>  		memcpy(cmds, ap->sector_buf, ATA_LOG_NCQ_SEND_RECV_SIZE);
>  
>  		if (dev->horkage & ATA_HORKAGE_NO_NCQ_TRIM) {
> -			ata_dev_dbg(dev, "disabling queued TRIM support\n");
> +			ata_dev_info(dev, "disabling queued TRIM - "
> +					  "known buggy device\n");

There is no need to change the message text here: it is clear. And because this
is a horkage, let's use ata_dev_warn() and capitalize the first letter of the
message:

			ata_dev_warn(dev, "Disabling NCQ TRIM support\n");

Note that we could define a common format for all horkage related messages. E.g.:
		
ata_dev_warn(dev,
	"ATA_HORKAGE_NO_NCQ_TRIM set: Disabling queued TRIM support\n");

But I am not sure that is really useful as long as the same message text is not
repeated for a different reason. That will avoid the long lines :)

>  			cmds[ATA_LOG_NCQ_SEND_RECV_DSM_OFFSET] &=
>  				~ATA_LOG_NCQ_SEND_RECV_DSM_TRIM;
>  		}
> @@ -2335,13 +2336,13 @@ static int ata_dev_config_ncq(struct ata_device *dev,
>  	if (!IS_ENABLED(CONFIG_SATA_HOST))
>  		return 0;
>  	if (dev->horkage & ATA_HORKAGE_NONCQ) {
> -		snprintf(desc, desc_sz, "NCQ (not used)");
> +		snprintf(desc, desc_sz, "NCQ (not used - known buggy device)");

I think we should replace this snprintf() with a ata_dev_warn() message similar
to the above NCQ TRIM. E.g.:

		ata_dev_warn(dev, "Disabling NCQ support\n");

>  		return 0;
>  	}
>  
>  	if (dev->horkage & ATA_HORKAGE_NO_NCQ_ON_ATI &&
>  	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI)) {
> -		snprintf(desc, desc_sz, "NCQ (not used)");
> +		snprintf(desc, desc_sz, "NCQ (not used - known buggy device/host adapter)");

Same as above.

>  		return 0;
>  	}
>  
> @@ -2397,7 +2398,7 @@ static void ata_dev_config_sense_reporting(struct ata_device *dev)
>  
>  	err_mask = ata_dev_set_feature(dev, SETFEATURE_SENSE_DATA, 0x1);
>  	if (err_mask) {
> -		ata_dev_dbg(dev,
> +		ata_dev_err(dev,
>  			    "failed to enable Sense Data Reporting, Emask 0x%x\n",
>  			    err_mask);
>  	}
> @@ -2479,7 +2480,7 @@ static void ata_dev_config_trusted(struct ata_device *dev)
>  
>  	trusted_cap = get_unaligned_le64(&ap->sector_buf[40]);
>  	if (!(trusted_cap & (1ULL << 63))) {
> -		ata_dev_dbg(dev,
> +		ata_dev_err(dev,
>  			    "Trusted Computing capability qword not valid!\n");

I think this fits in one line. So let's drop the line break.

>  		return;
>  	}
> @@ -2688,9 +2689,15 @@ static void ata_dev_config_fua(struct ata_device *dev)
>  	if (!(dev->flags & ATA_DFLAG_LBA48) || !ata_id_has_fua(dev->id))
>  		goto nofua;
>  
> -	/* Ignore known bad devices and devices that lack NCQ support */
> -	if (!ata_ncq_supported(dev) || (dev->horkage & ATA_HORKAGE_NO_FUA))
> +	/* Ignore devices that lack NCQ support */
> +	if (!ata_ncq_supported(dev))
> +		goto nofua;
> +
> +	/* Finally, ignore buggy devices */
> +	if (dev->horkage & ATA_HORKAGE_NO_FUA) {
> +		ata_dev_info(dev, "disabling FUA - known buggy device");

Use ata_dev_warn():

		ata_dev_warn(dev, "Disabling FUA support.\n");

>  		goto nofua;
> +	}
>  
>  	dev->flags |= ATA_DFLAG_FUA;
>  
> @@ -3060,24 +3067,22 @@ int ata_dev_configure(struct ata_device *dev)
>  	if (ap->ops->dev_config)
>  		ap->ops->dev_config(dev);
>  
> -	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
> +	if ((dev->horkage & ATA_HORKAGE_DIAGNOSTIC) && print_info) {
>  		/* Let the user know. We don't want to disallow opens for
>  		   rescue purposes, or in case the vendor is just a blithering
>  		   idiot. Do this after the dev_config call as some controllers
>  		   with buggy firmware may want to avoid reporting false device
>  		   bugs */

While at it, please fix this comment block format.

>  
> -		if (print_info) {
> -			ata_dev_warn(dev,
> -"Drive reports diagnostics failure. This may indicate a drive\n");
> -			ata_dev_warn(dev,
> -"fault or invalid emulation. Contact drive vendor for information.\n");
> -		}
> +		ata_dev_warn(dev, "Drive reports diagnostics failure."
> +				  " This may indicate a drive fault or invalid emulation."
> +				  " Contact drive vendor for information.\n");
>  	}
>  
>  	if ((dev->horkage & ATA_HORKAGE_FIRMWARE_WARN) && print_info) {
> -		ata_dev_warn(dev, "WARNING: device requires firmware update to be fully functional\n");
> -		ata_dev_warn(dev, "         contact the vendor or visit http://ata.wiki.kernel.org\n");
> +		ata_dev_warn(dev, "WARNING: device requires firmware update to be"
> +				  " fully functional contact the vendor or visit"
> +				  " http://ata.wiki.kernel.org/index.php/Known_issues\n");

As mentioned, I think we shoud drop the wiki link. It is not maintained.

>  	}
>  
>  	return 0;
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 214b935c2ced..5b9382ef261c 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -2667,7 +2667,7 @@ int ata_eh_reset(struct ata_link *link, int classify,
>  
>  		if (rc) {
>  			if (rc == -ENOENT) {
> -				ata_link_dbg(link, "port disabled--ignoring\n");
> +				ata_link_info(link, "port disabled--ignoring\n");

I think ata_link_warn() is better here. And let's reformat the message:

				ata_link_warn(link,
					      "Ignoring disabled port\n");

>  				ehc->i.action &= ~ATA_EH_RESET;
>  
>  				ata_for_each_dev(dev, link, ALL)

-- 
Damien Le Moal
Western Digital Research


