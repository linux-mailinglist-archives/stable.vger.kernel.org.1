Return-Path: <stable+bounces-111797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 533A8A23C7F
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 11:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA86E165100
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960401B6D11;
	Fri, 31 Jan 2025 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zyUYTVGp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5911990CD;
	Fri, 31 Jan 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320584; cv=none; b=RQSKyDCMcZnm4AAR5KlYygWDHMpB4dBBnuiPAcW4Hj4kjzbBdJK/NwqesUJl131up7eFyiKnLeybkM7DplEP75UP7K2Hy8nm/Bv+QFJo9wvZeE1GREwIG/bfG66MaW6eJTpwhjSgW+jTEfRPLaufUFG4XaezHOdNhNV1onlakG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320584; c=relaxed/simple;
	bh=XmiqwnwNqml1SVhskavNlk9Jl8XcEgxJ7vjStzv5Wm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFQZGPdwA5jnEhgnnVaLJpkCgdjkeShjB+udQ8EuUIPLJyuwZTnomwgJVIeLDga+xtuFU7Vln7cItX+TnoMdE5JpFQM+YGJMPJGz2C0H+g7iLQ3h6pzLkiTpgsPE3C0dofd+NlVfDhsuAMGD5eBf/jTopOXfrtb65koFCamTaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zyUYTVGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E64C4CED1;
	Fri, 31 Jan 2025 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738320583;
	bh=XmiqwnwNqml1SVhskavNlk9Jl8XcEgxJ7vjStzv5Wm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zyUYTVGpiY0jcDR0Q7MlvooaFdG9gfYMLYioKWsc+K9gqcsR4DdcJzofH7CTLevqe
	 MJ5sv/lkt+mmWEzfsICfBYOe2rZ44pUyg+jPXQUryiNK/XOXaHYZ4mikLfYFHXlooT
	 2yuyuKE/BazZ7y3mCBqm2NzzRe6oU038Xw+C3+bQ=
Date: Fri, 31 Jan 2025 11:49:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
Message-ID: <2025013133-saddled-reptilian-63c3@gregkh>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131100630.342995-1-chenhuacai@loongson.cn>

On Fri, Jan 31, 2025 at 06:06:30PM +0800, Huacai Chen wrote:
> Now we only enable the remote wakeup function for the USB wakeup source
> itself at usb_port_suspend(). But on pre-XHCI controllers this is not
> enough to enable the S3 wakeup function for USB keyboards, so we also
> enable the root_hub's remote wakeup (and disable it on error). Frankly
> this is unnecessary for XHCI, but enable it unconditionally make code
> simple and seems harmless.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

What commit id does this fix?

> ---
>  drivers/usb/core/hub.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c3f839637cb5..efd6374ccd1d 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3480,6 +3480,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  			if (PMSG_IS_AUTO(msg))
>  				goto err_wakeup;
>  		}
> +		usb_enable_remote_wakeup(udev->bus->root_hub);
>  	}
>  
>  	/* disable USB2 hardware LPM */
> @@ -3543,8 +3544,10 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
>  		/* Try to enable USB2 hardware LPM again */
>  		usb_enable_usb2_hardware_lpm(udev);
>  
> -		if (udev->do_remote_wakeup)
> +		if (udev->do_remote_wakeup) {
>  			(void) usb_disable_remote_wakeup(udev);
> +			(void) usb_disable_remote_wakeup(udev->bus->root_hub);

This feels wrong, what about all of the devices inbetween this device
and the root hub?

thanks,

greg k-h

