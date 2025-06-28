Return-Path: <stable+bounces-158824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9FAEC831
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 17:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E263BF510
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C4F20C469;
	Sat, 28 Jun 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i/QENAgF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513921D7989;
	Sat, 28 Jun 2025 15:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123762; cv=none; b=QVGOCyjAE/gu4dItBE12nDwVETaUeWR2/EmCHfGP59cc+hmBbegSYr5ez29AuaicRVmBEDGUYW+A9laPU9Q3+fGHP+qrrOmv3NSNM8i6R0c0We+Qt4LJRWE2QKOwQCnrxrCMN4HMC09Hziw4TTOLyDTdooBhz+jiYubFK+PeDrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123762; c=relaxed/simple;
	bh=gou9Z8xyn8tq2w3ereFBZj6X93kTTi3CeBaHKETqwHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrLVehY/YUArADtecVtPG7QPIND9D/HVG476m/fwPTWXTIF+Xf/tOQEBlSz33qa7d2yEm4PldV7RxaulyIVdubuuWOWrv/4CMTiYkcRkDrZl185Xv0rNRjn7tiFD61vtPCdDTg3ZBfOrqua3vtm2V3pdKmeF7cuWnVoRZXYESgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i/QENAgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FC2C4CEEA;
	Sat, 28 Jun 2025 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751123761;
	bh=gou9Z8xyn8tq2w3ereFBZj6X93kTTi3CeBaHKETqwHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/QENAgFbikJtMznSkjxvzgnKg2m2s2zJ8jQbp6rJFOjzZU9h+02FvpTj/4Ng5l/R
	 bNZE3Sx+p7frS+ffsEJzi99ey9Odl9hOMR/9Gzspu9vzApFureXzwevFxeZTPvYn2L
	 VM6Oo7BYl4MQgnJLD5JySyPHkkd/mpSQ91b9oFWc=
Date: Sat, 28 Jun 2025 17:15:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc: John Youn <John.Youn@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v 5] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Message-ID: <2025062839-scary-backroom-01d6@gregkh>
References: <7cbf0262dd5f9a98824b573b27f724250ea9b2be.1750769936.git.Minas.Harutyunyan@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cbf0262dd5f9a98824b573b27f724250ea9b2be.1750769936.git.Minas.Harutyunyan@synopsys.com>

On Wed, Jun 25, 2025 at 05:50:21AM +0000, Minas Harutyunyan wrote:
> For UTMI+ PHY, according to programming guide, first should be set
> PMUACTV bit then STOPPCLK bit. Otherwise, when the device issues
> Remote Wakeup, then host notices disconnect instead.
> For ULPI PHY, above mentioned bits must be set in reversed order:
> STOPPCLK then PMUACTV.
> 
> Fixes: 4483ef3c1685 ("usb: dwc2: Add hibernation updates for ULPI PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
> ---
>  Changes in v5:
>  - Rebased on top of Linux 6.16-rc2
>  Changes in v4:
>  - Rebased on top of Linux 6.15-rc6
>  Changes in v3:
>  - Rebased on top of Linux 6.15-rc4
>  Changes in v2:
>  - Added Cc: stable@vger.kernel.org
> 
>  drivers/usb/dwc2/gadget.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index d5b622f78cf3..0637bfbc054e 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -5389,20 +5389,34 @@ int dwc2_gadget_enter_hibernation(struct dwc2_hsotg *hsotg)
>         if (gusbcfg & GUSBCFG_ULPI_UTMI_SEL) {
>                 /* ULPI interface */
>                 gpwrdn |= GPWRDN_ULPI_LATCH_EN_DURING_HIB_ENTRY;
> -       }
> -       dwc2_writel(hsotg, gpwrdn, GPWRDN);
> -       udelay(10);
> +               dwc2_writel(hsotg, gpwrdn, GPWRDN);
> +               udelay(10);
> 
> -       /* Suspend the Phy Clock */
> -       pcgcctl = dwc2_readl(hsotg, PCGCTL);
> -       pcgcctl |= PCGCTL_STOPPCLK;
> -       dwc2_writel(hsotg, pcgcctl, PCGCTL);
> -       udelay(10);
> +               /* Suspend the Phy Clock */
> +               pcgcctl = dwc2_readl(hsotg, PCGCTL);
> +               pcgcctl |= PCGCTL_STOPPCLK;
> +               dwc2_writel(hsotg, pcgcctl, PCGCTL);
> +               udelay(10);
> 
> -       gpwrdn = dwc2_readl(hsotg, GPWRDN);
> -       gpwrdn |= GPWRDN_PMUACTV;
> -       dwc2_writel(hsotg, gpwrdn, GPWRDN);
> -       udelay(10);
> +               gpwrdn = dwc2_readl(hsotg, GPWRDN);
> +               gpwrdn |= GPWRDN_PMUACTV;
> +               dwc2_writel(hsotg, gpwrdn, GPWRDN);
> +               udelay(10);
> +       } else {
> +               /* UTMI+ Interface */
> +               dwc2_writel(hsotg, gpwrdn, GPWRDN);
> +               udelay(10);
> +
> +               gpwrdn = dwc2_readl(hsotg, GPWRDN);
> +               gpwrdn |= GPWRDN_PMUACTV;
> +               dwc2_writel(hsotg, gpwrdn, GPWRDN);
> +               udelay(10);
> +
> +               pcgcctl = dwc2_readl(hsotg, PCGCTL);
> +               pcgcctl |= PCGCTL_STOPPCLK;
> +               dwc2_writel(hsotg, pcgcctl, PCGCTL);
> +               udelay(10);
> +       }
> 
>         /* Set flag to indicate that we are in hibernation */
>         hsotg->hibernated = 1;
> 
> base-commit: 7aed15379db9c6ec67999cdaf5c443b7be06ea73
> --
> 2.41.0



Something is really wrong here, this doesn't apply at all to 6.16-rc2,
or my usb-linus branch or my usb-next branch.  Are you sure you made
this properly?  That "base commit" feels really odd...

confused.

greg k-h

