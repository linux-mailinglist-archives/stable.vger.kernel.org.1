Return-Path: <stable+bounces-50203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF24904C53
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5B411F237E7
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 07:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECAD16C683;
	Wed, 12 Jun 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztbXtLPC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA3E16C69E;
	Wed, 12 Jun 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176052; cv=none; b=SFYxOC3qSGr8boXln08BWNfe+PIWYw2m3raHy4zZ6RNGEsSwT+zcfGFzjL1BxP+qBr50dYIqISdSEvOjHwf5vMEopT/3yb3E3MIMkzb9CUdU8YEuyBfR4dck3CRoRwswDOKm+5f9ovaML8zRpiJKVRCAQbAngcAXzdh/hBZC6+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176052; c=relaxed/simple;
	bh=+YUgPW5c25TRz6pbWQMM+dmE1GdC7Q7SfIqSXdzEvCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLlZ+WHm77TAXe1iSmZnNuJFLeC3L8hOCfkbOTw8bubyCy4nxsq7gl9pflAIxYB+ZT/LtSRQ19T2urEZNyv8AqUAxmXFIRZMB5YitqUcJMv4vAJmRDYJMnVONDETLwfx14OMbQw8e5D9eRXyeFMAacFO8z/CSttTTe+EIMtbUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ztbXtLPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08598C3277B;
	Wed, 12 Jun 2024 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718176052;
	bh=+YUgPW5c25TRz6pbWQMM+dmE1GdC7Q7SfIqSXdzEvCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ztbXtLPCgGzGXhxdVipqgUVlhhdRqf6MLnT2wsd5MI2CglPVgTNnp6f7koCkB/Xg9
	 ZARawHbun5ow/0InrH+ABs9UezZycFxQiDZjWIklkMEvLafw7LJajHUNH0mrwsbzHR
	 PSSejEKyh+phAFXSBO9ugm107JD2DbHRqmpYXfn0=
Date: Wed, 12 Jun 2024 09:07:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuangyi Chiang <ki.chiang65@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] xhci: Don't issue Reset Device command to Etron xHCI host
Message-ID: <2024061227-cruelness-unwind-13a4@gregkh>
References: <20240612022256.7365-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612022256.7365-1-ki.chiang65@gmail.com>

On Wed, Jun 12, 2024 at 10:22:56AM +0800, Kuangyi Chiang wrote:
> Sometimes hub driver does not recognize USB device that is connected
> to external USB2.0 Hub when system resumes from S4.
> 
> This happens when xHCI driver issue Reset Device command to inform
> Etron xHCI host that USB device has been reset.
> 
> Seems that Etron xHCI host can not perform this command correctly,
> affecting that USB device.
> 
> Instead, to aviod this, xHCI driver should reassign device slot ID
> by calling xhci_free_dev() and then xhci_alloc_dev(), the effect is
> the same.

How is freeing and then allocating the device doing anything?

> 
> Add XHCI_ETRON_HOST quirk flag to invoke workaround in
> xhci_discover_or_reset_device().
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> ---
>  drivers/usb/host/xhci-pci.c |  2 ++
>  drivers/usb/host/xhci.c     | 11 ++++++++++-
>  drivers/usb/host/xhci.h     |  2 ++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 05881153883e..c7a88340a6f8 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -395,11 +395,13 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>  			pdev->device == PCI_DEVICE_ID_EJ168) {
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
> +		xhci->quirks |= XHCI_ETRON_HOST;
>  	}
>  	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
>  			pdev->device == PCI_DEVICE_ID_EJ188) {
>  		xhci->quirks |= XHCI_RESET_ON_RESUME;
>  		xhci->quirks |= XHCI_BROKEN_STREAMS;
> +		xhci->quirks |= XHCI_ETRON_HOST;
>  	}
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index 37eb37b0affa..aba4164b0873 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -3752,6 +3752,15 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
>  						SLOT_STATE_DISABLED)
>  		return 0;
>  
> +	if (xhci->quirks & XHCI_ETRON_HOST) {
> +		xhci_free_dev(hcd, udev);
> +		ret = xhci_alloc_dev(hcd, udev);

Wait, why are you freeing and then allocating the same device?  That
needs a lot of documentation here.

> +		if (ret == 1)
> +			return 0;

And why does the function return 1?

> +		else
> +			return -EINVAL;
> +	}
> +
>  	trace_xhci_discover_or_reset_device(slot_ctx);
>  
>  	xhci_dbg(xhci, "Resetting device with slot ID %u\n", slot_id);
> @@ -3862,7 +3871,7 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
>   * disconnected, and all traffic has been stopped and the endpoints have been
>   * disabled.  Free any HC data structures associated with that device.
>   */
> -static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
> +void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)

Why is this now global if you are only calling it in the same file?


>  {
>  	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
>  	struct xhci_virt_device *virt_dev;
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 30415158ed3c..f46b4dcb0613 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1627,6 +1627,7 @@ struct xhci_hcd {
>  #define XHCI_RESET_TO_DEFAULT	BIT_ULL(44)
>  #define XHCI_ZHAOXIN_TRB_FETCH	BIT_ULL(45)
>  #define XHCI_ZHAOXIN_HOST	BIT_ULL(46)
> +#define XHCI_ETRON_HOST	BIT_ULL(47)

Defining bit quirks just based on the vendor seems wrong to me, as that
information can be determined when needed at any time just by the pci
id, right?  So why is a quirk bit needed?

Shouldn't the quirk bit say what the broken functionality is?  Same
probably for the XHCI_ZHAOXIN_HOST, but that's not your issue to
solve...

>  
>  	unsigned int		num_active_eps;
>  	unsigned int		limit_active_eps;
> @@ -1863,6 +1864,7 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg);
>  irqreturn_t xhci_irq(struct usb_hcd *hcd);
>  irqreturn_t xhci_msi_irq(int irq, void *hcd);
>  int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev);
> +void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev);

Should not be needed.

thanks,

greg k-h

