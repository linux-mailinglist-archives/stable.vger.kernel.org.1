Return-Path: <stable+bounces-115117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E518A33CCD
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 11:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA883A2C8B
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7632135BC;
	Thu, 13 Feb 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0aFuAtIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41D6201006;
	Thu, 13 Feb 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442899; cv=none; b=RJsXxOBSH21VlmKElNiOgt0B5u4ol0RCxXJrrUsNAlJcjGYydMaujHjxtX32cLPeA3ZSmhzSjmZKveKqh79D3J74HxW3XWKoH97vNUQw//SpKT0CQtivCrHv5WdmAigMUud4nyf+/My5JH9e2qvzRLlzvUsLxZTvqqpqnexeNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442899; c=relaxed/simple;
	bh=JMaCGADzD7MFRF5VZqrFPk5oHwexej0iuTowZKSK75Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgBGDBrmGeZQxR3/HXuh4Ww9RfCg2vAq/RwBwQIWZI5RYHZ3PbC+NVxkHQvQ33loiA1EnNo+8ecDUpujuECVrFzRpDAQo1dxNwQqMNMf02MEB9AkL6ekz2KlNs6xNKkycPM3Gammkd9DkyltCKmKggk8prJfaeDeWTAcW4r0zfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0aFuAtIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B98C4CEE2;
	Thu, 13 Feb 2025 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739442898;
	bh=JMaCGADzD7MFRF5VZqrFPk5oHwexej0iuTowZKSK75Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0aFuAtIjv8g7Fff8KGc+azbZOCoEurRkR9XJ9JrTIgRUthqVoupb6ANdckgJAbnNF
	 6J5TV/o0D2WAuClIJIuOx5Mgrx1cmJkonVeu5UOqaHGhLicRSse86pjdffPVtVq4PO
	 4VXuOhMFzTBfvqep65WLOh/7VpEZdtaKwLCIU1os=
Date: Thu, 13 Feb 2025 11:34:50 +0100
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
Subject: Re: [PATCH] usb: xhci: lack of clearing xHC resources
Message-ID: <2025021359-culture-wow-55d5@gregkh>
References: <20250213101158.8153-1-pawell@cadence.com>
 <PH7PR07MB95384002E4FBBC7FE971862FDDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR07MB95384002E4FBBC7FE971862FDDFF2@PH7PR07MB9538.namprd07.prod.outlook.com>

On Thu, Feb 13, 2025 at 10:27:00AM +0000, Pawel Laszczak wrote:
> The xHC resources allocated for USB devices are not released in correct order after resuming in case when while suspend device was reconnected.

Please wrap your changelog text properly, checkpatch.pl should have
caught this, did you forget to run it?

> 
> This issue has been detected during the fallowing scenario:
> - connect hub HS to root port
> - connect LS/FS device to hub port
> - wait for enumeration to finish
> - force DUT to suspend
> - reconnect hub attached to root port
> - wake DUT
> 
> For this scenario during enumeration of USB LS/FS device the Cadence xHC reports completion error code for xHCi commands because the devices was not property disconnected and in result the xHC resources has not been correct freed.
> XHCI specification doesn't mention that device can be reset in any order so, we should not treat this issue as Cadence xHC controller bug.

But if it operates unlike all other xhci controllers, isn't that a bug
on its side?

> Similar as during disconnecting in this case the device should be cleared starting form the last usb device in tree toward the root hub.
> To fix this issue usbcore driver should disconnect all USB devices connected to hub which was reconnected while suspending.
> 
> Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
> cc: <stable@vger.kernel.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/core/hub.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c index 0cd44f1fd56d..2473cbf317a8 100644
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

This feels odd, and will hit more than just xhci controllers, right?
You aren't really disconnecting the hub, only resetting it (well the
logical disconnect will cause a real disconnect later on, so this should
be called from that code path, right?

thanks,

greg k-h

