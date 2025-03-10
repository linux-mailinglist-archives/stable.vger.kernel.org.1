Return-Path: <stable+bounces-121637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFA9A589DF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61FA7A3D54
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 01:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E723594A;
	Mon, 10 Mar 2025 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2HtYue1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3BA81E;
	Mon, 10 Mar 2025 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741569375; cv=none; b=hoZ9ub2D87PCE85SfHa0uBZ5t9aHiopT7fhL2BQDHX/p8jWZznol3/QpaWDRF+31eAufDaH0gHVb05h/0v3uBYAqcEFOIFuy/G1lsALAPDMHHPfFIt4oqF7U5EBYyNGvTFu24SEe+S8f06ntsysDTuSpVQxICcqBuYf7jrF/FaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741569375; c=relaxed/simple;
	bh=fItbnL0VfJSCXWPmbaXP/wonhs74sgjKr0ENQ6tOn88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pgr2/9dKIacGF0y6fcoJQGin0NcM/5Wl7P3rlaqSFfJ3QypUDyZz4lPNCKrsohpie18hMDsy4vgVNm7D2Sw8yNaDWO3q0bVO9/mMD5hg452A4pjP9dBB7nWrSEQDFiBcHSBDkGwSIAhKTO3QN2WWRd8eHkKKWG1eFAetwgascf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2HtYue1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B82DC4CEE3;
	Mon, 10 Mar 2025 01:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741569374;
	bh=fItbnL0VfJSCXWPmbaXP/wonhs74sgjKr0ENQ6tOn88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2HtYue1etjgjLFvcSzEWnKt7vtjBGU3/LluPT4Gt1uWAPxhX268bAstUqUVg7V8M
	 cAFL+RDVkw7qtrJJIgivE0bh06IsKj+boJ0uqUaxcVFSNpNQoBiQ4I8ESZSxv6C8HJ
	 aab452vHSI3hQgKUZhqRzfYzi1sUQkDXOiyp/aUzT6L36YTDQvj/KGUJ2CQitPstLp
	 PyW8MhjPvPWXc2zS8x8A9wjeuoLrReX+N7Y20PiBPHSfwEGL19bE/6NOOl07rCCMUu
	 m/23Z7pw6gChKciHiM5Bfs7fEw1QWrYHpbFTRaXUYwI+k4ZZ8pz1I3hKsgzBZ6ExAL
	 6TjNPU5EogXsg==
Date: Mon, 10 Mar 2025 09:16:04 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"peter.chen@nxp.com" <peter.chen@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] usb: hub: lack of clearing xHC resources
Message-ID: <Z849VPcttlQXTEoW@nchen-desktop>
References: <20250228074307.728010-1-pawell@cadence.com>
 <PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>

On 25-02-28 07:50:25, Pawel Laszczak wrote:
> The xHC resources allocated for USB devices are not released in correct
> order after resuming in case when while suspend device was reconnected.
> 
> This issue has been detected during the fallowing scenario:
> - connect hub HS to root port
> - connect LS/FS device to hub port
> - wait for enumeration to finish
> - force host to suspend
> - reconnect hub attached to root port
> - wake host
> 
> For this scenario during enumeration of USB LS/FS device the Cadence xHC
> reports completion error code for xHC commands because the xHC resources
> used for devices has not been properly released.
> XHCI specification doesn't mention that device can be reset in any order
> so, we should not treat this issue as Cadence xHC controller bug.
> Similar as during disconnecting in this case the device resources should
> be cleared starting form the last usb device in tree toward the root hub.
> To fix this issue usbcore driver should call hcd->driver->reset_device
> for all USB devices connected to hub which was reconnected while
> suspending.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Tested at Cixtech sky1 SoC which uses Cadence USB SSP IP.

Tested-by: Peter Chen <peter.chen@cixtech.com>

Peter
> 
> ---
> Changelog:
> v3:
> - Changed patch title
> - Corrected typo
> - Moved hub_hc_release_resources above mutex_lock(hcd->address0_mutex)
> 
> v2:
> - Replaced disconnection procedure with releasing only the xHC resources
> 
>  drivers/usb/core/hub.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a76bb50b6202..dcba4281ea48 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -6065,6 +6065,36 @@ void usb_hub_cleanup(void)
>  	usb_deregister(&hub_driver);
>  } /* usb_hub_cleanup() */
>  
> +/**
> + * hub_hc_release_resources - clear resources used by host controller
> + * @udev: pointer to device being released
> + *
> + * Context: task context, might sleep
> + *
> + * Function releases the host controller resources in correct order before
> + * making any operation on resuming usb device. The host controller resources
> + * allocated for devices in tree should be released starting from the last
> + * usb device in tree toward the root hub. This function is used only during
> + * resuming device when usb device require reinitialization – that is, when
> + * flag udev->reset_resume is set.
> + *
> + * This call is synchronous, and may not be used in an interrupt context.
> + */
> +static void hub_hc_release_resources(struct usb_device *udev)
> +{
> +	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
> +	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
> +	int i;
> +
> +	/* Release up resources for all children before this device */
> +	for (i = 0; i < udev->maxchild; i++)
> +		if (hub->ports[i]->child)
> +			hub_hc_release_resources(hub->ports[i]->child);
> +
> +	if (hcd->driver->reset_device)
> +		hcd->driver->reset_device(hcd, udev);
> +}
> +
>  /**
>   * usb_reset_and_verify_device - perform a USB port reset to reinitialize a device
>   * @udev: device to reset (not in SUSPENDED or NOTATTACHED state)
> @@ -6129,6 +6159,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
>  	bos = udev->bos;
>  	udev->bos = NULL;
>  
> +	if (udev->reset_resume)
> +		hub_hc_release_resources(udev);
> +
>  	mutex_lock(hcd->address0_mutex);
>  
>  	for (i = 0; i < PORT_INIT_TRIES; ++i) {
> -- 
> 2.43.0
> 

-- 

Best regards,
Peter

