Return-Path: <stable+bounces-53687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073B090E327
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847922840B4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F266A33B;
	Wed, 19 Jun 2024 06:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SJTeukPi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718A4A1D;
	Wed, 19 Jun 2024 06:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777701; cv=none; b=cs9prNd98Zd+eZChtRrKLS3BhdfIeRBPnCHhDDPx3BKa+g2dLT11/cP2OHcg3SZe0kjJoDQOfUYYBOldBHGmVr3d4dC85qUJaruBeELGSwPbVrB18vSR9YwMniuO+fuTfyCcmMOC27m8vYaHdK+xvuBDTwoR4hx1U2fmMfAUyN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777701; c=relaxed/simple;
	bh=60c30djlc6yW40sTp82eLHFt4jyff+jykZzIZjYegOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKciVm2RNllcOlxLsLrLVAvUWQebsnXucZQhgOlovVsUHqjE9bkW/yhgjzjuHCf8f4L61w6YzuqEz9fA9JeAMCII/aWa635KOCayWVMA82XJFcj2w0R/Dfkl/t2DqTGWCiYgdiFE2ASNbdje0AKcdWJ4/A5lUui/r4zqdJqyLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SJTeukPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD67C2BBFC;
	Wed, 19 Jun 2024 06:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718777700;
	bh=60c30djlc6yW40sTp82eLHFt4jyff+jykZzIZjYegOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJTeukPi+tXeIvcwj4yI72Y0QMpZlk606h4TEgy7I5LZcPKVdIpb6hmNa++lsAoRu
	 L8tetlagsZHxolbD1kW0QBmmq6eNOticHg1ePpG9j6xMn/UTnW9ko48WvJbsK+HQlQ
	 qqofUnZ53c7eDtOFRhbdo9Buh5Weqo3Ul26OSUk8=
Date: Wed, 19 Jun 2024 08:14:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] xhci: Don't issue Reset Device command to Etron xHCI
 host
Message-ID: <2024061903-shadow-pesky-1205@gregkh>
References: <20240619054808.12861-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619054808.12861-1-ki.chiang65@gmail.com>

On Wed, Jun 19, 2024 at 01:48:08PM +0800, Kuangyi Chiang wrote:
> Sometimes the hub driver does not recognize the USB device connected
> to the external USB2.0 hub when the system resumes from S4.
> 
> This happens when the xHCI driver issue the Reset Device command to
> inform the Etron xHCI host that the USB device has been reset.
> 
> Seems that the Etron xHCI host can not perform this command correctly,
> affecting the USB device.
> 
> Instead, to avoid this, disabling slot ID and then enabling slot ID
> is a workable solution to replace the Reset Device command.
> 
> An easy way to issue these commands in sequence is to call
> xhci_free_dev() and then xhci_alloc_dev().
> 
> Applying this patch then the issue is gone.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>

What commit id does this fix?

> ---
> Changes in v2:
> - Change commit log
> - Add a comment for the workaround
> - Revert "global xhci_free_dev()"
> - Remove XHCI_ETRON_HOST quirk bit
> 
>  drivers/usb/host/xhci.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 37eb37b0affa..c892750a89c5 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -3682,6 +3682,8 @@ void xhci_free_device_endpoint_resources(struct xhci_hcd *xhci,
>  				xhci->num_active_eps);
>  }
>  
> +static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev);
> +
>  /*
>   * This submits a Reset Device Command, which will set the device state to 0,
>   * set the device address to 0, and disable all the endpoints except the default
> @@ -3752,6 +3754,20 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
>  						SLOT_STATE_DISABLED)
>  		return 0;
>  
> +	if (dev_is_pci(hcd->self.controller) &&
> +		to_pci_dev(hcd->self.controller)->vendor == 0x1b6f) {

Odd indentation :(

Also, that's a specific value, shouldn't it be in a #define somewhere?

> +		/*
> +		 * Disabling and then enabling device slot ID to inform xHCI
> +		 * host that the USB device has been reset.
> +		 */
> +		xhci_free_dev(hcd, udev);
> +		ret = xhci_alloc_dev(hcd, udev);

You are relying on the behavior of free/alloc here to disable/enable the
slot id, why not just do that instead?  What happens if the free/alloc
call stops doing that?  This feels very fragile to me.

> +		if (ret == 1)
> +			return 0;
> +		else
> +			return -EINVAL;

Why -EINVAL?  What value was wrong?

thanks,

greg k-h

