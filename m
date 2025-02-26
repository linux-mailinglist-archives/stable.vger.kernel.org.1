Return-Path: <stable+bounces-119707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FBFA465CD
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 16:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91EB426B64
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 15:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F5223333;
	Wed, 26 Feb 2025 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="cNjkJU2i"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6531C21CC42
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584839; cv=none; b=lOSj5mu1H1f4aVuxtuQZFGqYxe0x3e7aRYRkabYieeVc1UosvbKOSTUXej/5bCxw7sYFLxxVVy2kr7e2NbnAOMaQRmghsq6/Nv4pt3ZQv/RJ4v/u6VLNf65E1gsd5AYIIBAEINpjyDqQAf6+0CuGVvx5NeUHHOfBK1w0gkugtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584839; c=relaxed/simple;
	bh=KkcDFKGNORF8N3ndYvi8Zu1GWOK+AXO7JtJDxvpy1n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InN3LinExzYDPl4mWhY1aVgFG+dc5yRbP35ZfE7y4NRpij3sFoVtMIjpLM1QNI2cPg53bpulgtsaBm69rRlhsTi1hdsd4FRzh2f/W6oKsjva/mw6EsZtNpEpUFZNJlFh4G0HY0/Kz47rTBfVgdJcXhQNMS/F+chLOKUhrvl1fg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=cNjkJU2i; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e660740061so60867986d6.3
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 07:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1740584836; x=1741189636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VONNoJ/cBoc8MLsKjGDT1kUXif3zX3VU1i8UHB4Qh0g=;
        b=cNjkJU2i/JHsPEYSW46WkL0qF+cFBAF3tXTvPpCatAK3H/mx0+BiEN//aLlgof9fh1
         wXZNApVqDq7T4QPKXp74pJlNHeRjSMZzke8LPmORQKwpjlKhREy/Y16xAoMuq9tzllDU
         1gen8VuDJjO8B7fWPBbUbv5PZwBakDPejOHWjqCetIsZqfCdc5R8JAxXY0fP83IJdXQO
         anM77tWI61jUKaLEIlqnVRI2EIkP1htxz9iE18oxR9Ec6YSCyhX1tgTPF3NRdEQVfCwd
         6t65ZMHJNCe+i4oL+E9gsjjwD4lfyY7wVmfx7lPTvE0jRKQ/A5LPJg25VH6czR4slb7g
         yW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584836; x=1741189636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VONNoJ/cBoc8MLsKjGDT1kUXif3zX3VU1i8UHB4Qh0g=;
        b=RmGFvI8ORCXkxVOuYW8eyMdlm4ejp/m1qHOJFkPpjSorUJq2U/ZuTszgbJf4ustWRo
         S5Hm6NBK4E//sjvp5uVg1LnSomvDLTeB79drSiZoJYfC0SisUcrRRl+O+J8UadYf0Prb
         tU9Eju0sZ2H2mXOBIkqMdlZLCqcegt3cD27qBfGWqljSW0N6oBJUp6j9NmfFisuyAmcr
         1/XeJCWNVRiD9fsoUcv2k5kHsAe1rcS3lmNg2qlbysfdOuS3nKGYzlc4AAfX4yAGumsH
         KkF9viJcc5gi/8I+PYZGq88/tupPK80xS0gxUc2uSZlC7GYOHWejhBip009Dlv1P55+W
         /VCw==
X-Forwarded-Encrypted: i=1; AJvYcCVIsNtYKqOLNualR/jVmBkrT7GK6cyz5Q+bnaDlrQcJpToBjEwmpyEDOPzdl41u+JeW51cCtyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6lk1sfU/SZiZVd2BYhgZYsaZWAzX5fhVKdC6WbgvxSysy/9ey
	ODYnrX45ZZNeNp6z0RsQLq+ngI+ynZkNq4nW1cq0d6D5jJcv9aXJcswsu+gpQA==
X-Gm-Gg: ASbGncsmb9bT73AeEnRsai6ypsZimIFuIC2m20YmxFyleqNAjc5oKMM6VKkdAcEA2RT
	6gflAQ4R3URweYzy/TvvIRAtbVBj8sfW8IMEgPnMMTHyZ7T1xxfa1EUQgdgSmj2OHv+DcjHgncf
	pqY32k5aSWs7oMgHLy4EbUFMN521FQNCv3hMCzzdDRf43POxn5GlVPsd8rWpSRkdysA9dck3zef
	IG+qJxyVx0byGw88w+F+hwrYhjRSdlAn8VVblWN5ECeKCdUDMbSf2X+HbmINb94AHzBkSDtJ3Vu
	/cXx9uvKuG2nD4fPPT6+w0MayBx4lNGx3zgz7nB3bDdRzwzd85p7brbqsWbRGvdrNA0Zj8xG/y2
	EJgO0DeJk0Hsl//INP/s=
X-Google-Smtp-Source: AGHT+IF84oRPv24RC/bqUZFf9WpN3z/FuXo7ShtrwcYRvstSANP/wjsBQF7bNpavDspgemd7XCgxtQ==
X-Received: by 2002:a05:6214:2482:b0:6e6:606b:a7be with SMTP id 6a1803df08f44-6e8868fd4c1mr56444906d6.34.1740584836173;
        Wed, 26 Feb 2025 07:47:16 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-24.harvard-secure.wrls.harvard.edu. [65.112.8.24])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dc0esm23754866d6.22.2025.02.26.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:47:15 -0800 (PST)
Date: Wed, 26 Feb 2025 10:47:13 -0500
From: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"peter.chen@nxp.com" <peter.chen@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: xhci: lack of clearing xHC resources
Message-ID: <a78164bc-67c4-4f31-bbe1-609e19134ddf@rowland.harvard.edu>
References: <20250226071646.4034220-1-pawell@cadence.com>
 <PH7PR07MB95385E2766D01F3741D418ABDDC22@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95385E2766D01F3741D418ABDDC22@PH7PR07MB9538.namprd07.prod.outlook.com>

On Wed, Feb 26, 2025 at 07:23:16AM +0000, Pawel Laszczak wrote:
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
> used for devices has not been property released.

s/property/properly/

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
> 
> ---
> Changelog:
> v2:
> - Replaced disconnection procedure with releasing only the xHC resources
> 
>  drivers/usb/core/hub.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index a76bb50b6202..d3f89528a414 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -6065,6 +6065,36 @@ void usb_hub_cleanup(void)
>  	usb_deregister(&hub_driver);
>  } /* usb_hub_cleanup() */
>  
> +/**
> + * hub_hc_release_resources - clear resources used by host controller
> + * @pdev: pointer to device being released
> + *
> + * Context: task context, might sleep
> + *
> + * Function releases the host controller resources in correct order before
> + * making any operation on resuming usb device. The host controller resources
> + * allocated for devices in tree should be released starting from the last
> + * usb device in tree toward the root hub. This function is used only during
> + * resuming device when usb device require reinitialization - that is, when
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
> @@ -6131,6 +6161,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
>  
>  	mutex_lock(hcd->address0_mutex);
>  
> +	if (udev->reset_resume)
> +		hub_hc_release_resources(udev);

Don't you want to do this before taking the address0_mutex lock?

> +
>  	for (i = 0; i < PORT_INIT_TRIES; ++i) {
>  		if (hub_port_stop_enumerate(parent_hub, port1, i)) {
>  			ret = -ENODEV;

Doing it this way, you will call hcd->driver->reset_device() multiple 
times for the same device: once for the hub(s) above the device and then 
once for the device itself.  But since this isn't a hot path, maybe that 
doesn't matter.

Alan Stern

