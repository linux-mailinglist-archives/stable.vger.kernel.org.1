Return-Path: <stable+bounces-115122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F546A33DC9
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 12:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CA8188DFFC
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C92A221739;
	Thu, 13 Feb 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmXXXcrr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1A4221708;
	Thu, 13 Feb 2025 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445624; cv=none; b=DIiq2VZaYBWReAouwrXi2qSh3SPVxhk24G197qpvKNNWHPbXaO2AtfYIjYISu1aBPfhRPSPBThLqeXCFBl1M5IxfKvEDFM33kP7TrAkaKhW9o6e5U5x7V69oJH/cmS4evgapZbjUSYnh8damiynM4NtCUL9G9TMBCT3Dr8PvAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445624; c=relaxed/simple;
	bh=NCCx4YVnsVLzOQ8d17oCuZGX9ttdU8tyQhskq7ys0r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bO4F3a35SrCLkVECyMZCMCAbzK8xR8ROxSeyq8SKzwIgvASCOPIv6O0u1vRgrZelyZBSnTYVudj+P/5g0eDP+zw7oYDFrrI0uVwSbcGAB3O9msxYgu8RLCAPF59JgCeseMKZW37nYIQnDyqjUuGpCNxufRRsu4PCjPnYNKL3SeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmXXXcrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED83EC4CED1;
	Thu, 13 Feb 2025 11:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739445623;
	bh=NCCx4YVnsVLzOQ8d17oCuZGX9ttdU8tyQhskq7ys0r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmXXXcrr3Sre5r3HfVbwsqe/7kHlTR6c5WtciC/SIpqapPx17FA04P35+wSesiYqB
	 zcAy27txYtVPWgDM4SQjvMILvzP/LSWDssJYtjYA5r4GoMfHK7gdUgj07qLqtRobn9
	 azwI2ePINYy2tixGRt4mALwv9DyqZooFpgT45odk=
Date: Thu, 13 Feb 2025 12:20:19 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Pawel Laszczak <pawell@cadence.com>
Cc: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
	"javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
	"make_ruc2021@163.com" <make_ruc2021@163.com>,
	"peter.chen@nxp.com" <peter.chen@nxp.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Eichler <peichler@cadence.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: FW: [PATCH] usb: xhci: lack of clearing xHC resources
Message-ID: <2025021306-rally-making-d5f0@gregkh>
References: <20250213101158.8153-1-pawell@cadence.com>
 <PH7PR07MB9538F08AF8B1D7FF5070DA76DDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB9538F08AF8B1D7FF5070DA76DDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>

On Thu, Feb 13, 2025 at 10:46:06AM +0000, Pawel Laszczak wrote:
> The xHC resources allocated for USB devices are not released in correct
> order after resuming in case when while suspend device was reconnected.
> 
> This issue has been detected during the fallowing scenario:
> - connect hub HS to root port
> - connect LS/FS device to hub port
> - wait for enumeration to finish
> - force DUT to suspend
> - reconnect hub attached to root port
> - wake DUT
> 
> For this scenario during enumeration of USB LS/FS device the Cadence xHC
> reports completion error code for xHCi commands because the devices was not
> property disconnected and in result the xHC resources has not been
> correct freed.
> XHCI specification doesn't mention that device can be reset in any order
> so, we should not treat this issue as Cadence xHC controller bug.
> Similar as during disconnecting in this case the device should be cleared
> starting form the last usb device in tree toward the root hub.
> To fix this issue usbcore driver should disconnect all USB
> devices connected to hub which was reconnected while suspending.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/core/hub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 0cd44f1fd56d..2473cbf317a8 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3627,10 +3627,12 @@ static int finish_port_resume(struct usb_device *udev)
>  		 * the device will be rediscovered.
>  		 */
>   retry_reset_resume:
> -		if (udev->quirks & USB_QUIRK_RESET)
> +		if (udev->quirks & USB_QUIRK_RESET) {
>  			status = -ENODEV;
> -		else
> +		} else {
> +			hub_disconnect_children(udev);
>  			status = usb_reset_and_verify_device(udev);
> +		}
>  	}
>  
>  	/* 10.5.4.5 says be sure devices in the tree are still there.
> -- 
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

