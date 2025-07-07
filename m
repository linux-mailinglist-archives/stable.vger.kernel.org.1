Return-Path: <stable+bounces-160350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3F6AFAF16
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 11:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F0C17CE20
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81E828A40B;
	Mon,  7 Jul 2025 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tb+NA/Cg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F228541F;
	Mon,  7 Jul 2025 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751878880; cv=none; b=qO6etwVIqMQZCRj7bOx+mZTO8kzLY2U+BGwkoSAHy+ZZ3SWyvn1474wjZptZ9lXYOYAKrNl2FyQYnU5hXEod16I6pLNqxi6MyCEnu24qIagtx7cmf070CpnNbVb8rRVfUcwFg2Iwp4P4qHfHPh2UrnqUmVZu2T5gXnQa5ipxFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751878880; c=relaxed/simple;
	bh=owQYen0A3np2AWFZAuOj7mXVLYDF5MLfrCckdRW4AhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I56PY5/kmCjlCzlIZnMBIXTvCiH+shZnup840Pq5zCTnqMVjK9XL5UoDkc7+CWAM8Tmw4OwtWTHzMjT+bwzyC3sVuOXNVzzoSFkBcp/GAxhykPkkKJIdz6OMNFGUQJkqY5+P82VE4Ott3WXh7V02Vwg/Q2mSkJx0rp/7nPL+3OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tb+NA/Cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A49C4CEE3;
	Mon,  7 Jul 2025 09:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751878878;
	bh=owQYen0A3np2AWFZAuOj7mXVLYDF5MLfrCckdRW4AhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tb+NA/CgtxMr9uv74ndmI5dKqRBCbAMAJ8mwusqjA27rfKwBFnY52//0VC2Mbh4bz
	 QAfsvfP7ChRTRKqtaxXNbi7QoqJ7A/Ma1iQH8kQk73X+2QLw6sapCBQF68ZGme+sHf
	 osAfzDZVqEjh74uIW4D0nwK43fGzvjkmRmGilO5E=
Date: Mon, 7 Jul 2025 11:01:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc: John Youn <John.Youn@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v 6] usb: dwc2: gadget: Fix enter to hibernation for
 UTMI+ PHY
Message-ID: <2025070736-concierge-tumble-c7d9@gregkh>
References: <692110d3c3d9bb2a91cedf24528a7710adc55452.1751458314.git.Minas.Harutyunyan@synopsys.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692110d3c3d9bb2a91cedf24528a7710adc55452.1751458314.git.Minas.Harutyunyan@synopsys.com>

On Wed, Jul 02, 2025 at 12:21:22PM +0000, Minas Harutyunyan wrote:
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
> Changes in v6:
>  - Rabased on usb-next branch over commit 7481a97c5f49
> Changes in v5:
>  - Rebased on top of Linux 6.16-rc2
> Changes in v4:
>  - Rebased on top of Linux 6.15-rc6
> Changes in v3:
>  - Rebased on top of Linux 6.15-rc4
> Changes in v2:
>  - Added Cc: stable@vger.kernel.org

This constant rebasing is just not working, as this _STILL_ does not
apply to either of my branches.  Are you sure you are doing this
properly?  No other changes in your tree?

Ah, I see the issue:

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

Your email client ate all the tabs and spit out spaces, making this
impossible to apply to any branch anywhere.  Please fix your email
client to be able to send patches out properly.

Try sending one to yourself, and seeing if that can apply properly
afterward.  If so, then try sending it out to the world again.

thanks,

greg k-h

