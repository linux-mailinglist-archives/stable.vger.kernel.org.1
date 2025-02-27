Return-Path: <stable+bounces-119864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB6A489B8
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 21:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3AB162EAC
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 20:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8665026E95D;
	Thu, 27 Feb 2025 20:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvlEYPyq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1B71D6182;
	Thu, 27 Feb 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687707; cv=none; b=fRmdOzSz19kx0mO5iA6DVQKhnOCxdgc8GN0j/KHWkdGWF93wWQP1ffaU5KSyRXIeqDUxUOzB+iKZUe2V26pfG2bqqWE5eFbXEnGfwxDSt0+TqBMlKVogUYsqYvJxkxo9hYvzyizS0lMRm2kYTJnw7Na+yRGC97gXHyfmHfR2EJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687707; c=relaxed/simple;
	bh=yJLvp2oI0sbx31hYDIXLNAAq0hg/gtAY3C68UTWPF8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBCpu4gmKEoAR8/g1CAH2WRHFlaKJ0J8L5n2HrQN47GrlzEO0iosB89Tw73hm0SwKRJha2OmYnVX0BzSR3Wa15O3Ur1WSGF+ofYuphxFYLslqCNhtOmiA26X0Sbw4PZhshp4RS+Z4ZjUaK3V3M0vRKtMvJDWbSoCKiDGwgsIujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvlEYPyq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CCFC4CEDD;
	Thu, 27 Feb 2025 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740687706;
	bh=yJLvp2oI0sbx31hYDIXLNAAq0hg/gtAY3C68UTWPF8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvlEYPyqID3xG6JZnddwKCBj86r3Ccp80AYP8Ur+fzaXY/aU9kwpIhJiV7j0AEFfC
	 ikcFpnhFkTSSMgHP+SXGqfjt9zHxjNb7cz9GA8d1V9by1Vo7X4ytcXHk0q7Rxzzs97
	 f0YbwqkoW1aVPUHeNo9CPAAGczlcJVUYyF5h0YEk=
Date: Thu, 27 Feb 2025 12:20:36 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Oliver Upton <oliver.upton@linux.dev>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] xhci: Restrict USB4 tunnel detection for USB3 devices to
 Intel hosts
Message-ID: <2025022709-unread-mystified-ddf1@gregkh>
References: <20250227194529.2288718-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227194529.2288718-1-maz@kernel.org>

On Thu, Feb 27, 2025 at 07:45:29PM +0000, Marc Zyngier wrote:
> When adding support for USB3-over-USB4 tunnelling detection, a check
> for an Intel-specific capability was added. This capability, which
> goes by ID 206, is used without any check that we are actually
> dealing with an Intel host.
> 
> As it turns out, the Cadence XHCI controller *also* exposes an
> extended capability numbered 206 (for unknown purposes), but of
> course doesn't have the Intel-specific registers that the tunnelling
> code is trying to access. Fun follows.
> 
> The core of the problems is that the tunnelling code blindly uses
> vendor-specific capabilities without any check (the Intel-provided
> documentation I have at hand indicates that 192-255 are indeed
> vendor-specific).
> 
> Restrict the detection code to Intel HW for real, preventing any
> further explosion on my (non-Intel) HW.
> 
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org
> Fixes: 948ce83fbb7df ("xhci: Add USB4 tunnel detection for USB3 devices on Intel hosts")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/usb/host/xhci-hub.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
> index 9693464c05204..69c278b64084b 100644
> --- a/drivers/usb/host/xhci-hub.c
> +++ b/drivers/usb/host/xhci-hub.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/unaligned.h>
>  #include <linux/bitfield.h>
> +#include <linux/pci.h>
>  
>  #include "xhci.h"
>  #include "xhci-trace.h"
> @@ -770,9 +771,16 @@ static int xhci_exit_test_mode(struct xhci_hcd *xhci)
>  enum usb_link_tunnel_mode xhci_port_is_tunneled(struct xhci_hcd *xhci,
>  						struct xhci_port *port)
>  {
> +	struct usb_hcd *hcd;
>  	void __iomem *base;
>  	u32 offset;
>  
> +	/* Don't try and probe this capability for non-Intel hosts */
> +	hcd = xhci_to_hcd(xhci);
> +	if (!dev_is_pci(hcd->self.controller) ||
> +	    to_pci_dev(hcd->self.controller)->vendor != PCI_VENDOR_ID_INTEL)
> +		return USB_LINK_UNKNOWN;

Ugh, nice catch.

Mathias, want me to just take this directly for now and not wait for you
to resend it?

thanks,

greg k-h

