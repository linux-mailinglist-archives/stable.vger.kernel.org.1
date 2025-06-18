Return-Path: <stable+bounces-154647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AC9ADE70F
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 11:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29841167039
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 09:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172262836A0;
	Wed, 18 Jun 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fyWZozvw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B581E2312;
	Wed, 18 Jun 2025 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239101; cv=none; b=hTxVvomaXmKkDy+VLpiYnt7yXQTpD/fLDWOXNitL+s5Z1BgqZJPcQpEE6Tqy57C+/hVqSDBEZP730S1esaep0ZHDaesCBjwfBnG5izAudNx/i36tYwyTLAyfYnIKlF3XJrzWk3F9b7MIqh38Pxw6dsuzZeCarCiQIGGJ8osPyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239101; c=relaxed/simple;
	bh=3Z0xQCvFb/abBaZUrRdrq6mu6yGaXylQBFf0l9XBU5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwtEUa7hn8OiWTOsnvi0dM99/I/rhR/a6v9z3Ex1NGXfLUsmc0NyUPr4Bsp1rtgkLVWR3gk8y99y0mUkpea9quRlgapaAnHsvD8cZHNqWdFD1JBH+IF8pypUdAixfwXOw9FQFP9TyjoffY1l7Fos6+GuR6VU/G1OttHMf38JS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fyWZozvw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D58C4CEF0;
	Wed, 18 Jun 2025 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750239101;
	bh=3Z0xQCvFb/abBaZUrRdrq6mu6yGaXylQBFf0l9XBU5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fyWZozvwhojXFUFfkGR/0tn0UBw+AyB9Uuj1H1lTEZBzD/zwLVoXIFR9tNmG9mVZL
	 fwcy/iR8gH3WpYEcuRNN6iY5Fe6qtQBljvu6ZYj43nIybx497g/7kjqIQ/0lK5B3Za
	 hB3rmGiu6R+sTaQRo3fgzUTB27rb6xUvhh6Krb9U=
Date: Wed, 18 Jun 2025 11:31:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: xiehongyu1@kylinos.cn
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	mathias.nyman@intel.com, oneukum@suse.de, stable@vger.kernel.org
Subject: Re: [PATCH v2] xhci: Disable stream for xHC controller with
 XHCI_BROKEN_STREAMS
Message-ID: <2025061826-slapstick-duration-6221@gregkh>
References: <20250618074648.109879-1-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618074648.109879-1-xiehongyu1@kylinos.cn>

On Wed, Jun 18, 2025 at 03:46:48PM +0800, xiehongyu1@kylinos.cn wrote:
> From: Hongyu Xie <xiehongyu1@kylinos.cn>
> 
> Disable stream for platform xHC controller with broken stream.
> 
> Fixes: 14aec589327a6 ("storage: accept some UAS devices if streams are unavailable")
> Cc: stable@vger.kernel.org # 5.4
> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/usb/host/xhci-plat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 6dab142e72789..c79d5ed48a08b 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -328,7 +328,8 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
>  	}
>  
>  	usb3_hcd = xhci_get_usb3_hcd(xhci);
> -	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4)
> +	if (usb3_hcd && HCC_MAX_PSA(xhci->hcc_params) >= 4 &&
> +	    !(xhci->quirks & XHCI_BROKEN_STREAMS))
>  		usb3_hcd->can_do_streams = 1;
>  
>  	if (xhci->shared_hcd) {
> -- 
> 2.25.1
> 
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

