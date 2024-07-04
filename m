Return-Path: <stable+bounces-58032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2D2927311
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 11:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E871F22AEC
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 09:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC921AAE3C;
	Thu,  4 Jul 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGezsBPG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDD1AAE30;
	Thu,  4 Jul 2024 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085389; cv=none; b=i/1cRgFf9YECT83T0mk/sAS1q4BjscYArg6tr7haCd+E350dGL9ex/FStO7RQhYO1gS5Mh817En0Hn7Bpp2P0rQ0+A+++Wlf7149/vibqQDRKsaJ57cDhZhmmpAE30rbOvki7VcU9k0zIQApnGdghl6KDUxKMK1NDyglRQ4VOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085389; c=relaxed/simple;
	bh=Axd97M9p/3srgR4INvdNGDLRtqDDL73Rz3lAfhD0eac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcVI2iYLzCSmUWWhau+oeOvIUWgpyBgmeNokqvjcYrl8YwarJIXOkntq+vYDC+uQVF+drjHxdgouyiHCFzvtsXUymODNQ+6HiRds8oKq2ZacdI/qGwOJMkGN2vZTHJD+a5ABBME68jUnlN2nRFtTciOWt5B2+U0U3ax0xedfdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGezsBPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0F6C3277B;
	Thu,  4 Jul 2024 09:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720085389;
	bh=Axd97M9p/3srgR4INvdNGDLRtqDDL73Rz3lAfhD0eac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGezsBPGfLDfKPho8z8w1lmj7ZDHhsvVLrFxF9SIxGMDxgSfN8Gpz1KHi7JoooFzG
	 JNlrRJNOuxN2wikcuj/e6CMycV5sajMfvAoldaOUlXW7+3D2rf8YTk70fbLRmeeib4
	 f0te1ru/pxgXyyA9FkcRKcGf0WmY+5qviznOn4l0=
Date: Thu, 4 Jul 2024 11:29:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	francesco.dolcini@toradex.com
Subject: Re: [PATCH 6.1 091/128] serial: imx: set receiver level before
 starting uart
Message-ID: <2024070439-untried-utmost-17d1@gregkh>
References: <20240702170226.231899085@linuxfoundation.org>
 <20240702170229.664632784@linuxfoundation.org>
 <ZoT_qUw9BGuZ0Alm@eichest-laptop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoT_qUw9BGuZ0Alm@eichest-laptop>

On Wed, Jul 03, 2024 at 09:37:13AM +0200, Stefan Eichenberger wrote:
> Hi Greg,
> 
> On Tue, Jul 02, 2024 at 07:04:52PM +0200, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > 
> > commit a81dbd0463eca317eee44985a66aa6cc2ce5c101 upstream.
> > 
> > Set the receiver level to something > 0 before calling imx_uart_start_rx
> > in rs485_config. This is necessary to avoid an interrupt storm that
> > might prevent the system from booting. This was seen on an i.MX7 device
> > when the rs485-rts-active-low property was active in the device tree.
> > 
> > Fixes: 6d215f83e5fc ("serial: imx: warn user when using unsupported configuration")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > Link: https://lore.kernel.org/r/20240621153829.183780-1-eichest@gmail.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/tty/serial/imx.c |    4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1978,8 +1978,10 @@ static int imx_uart_rs485_config(struct
> >  
> >  	/* Make sure Rx is enabled in case Tx is active with Rx disabled */
> >  	if (!(rs485conf->flags & SER_RS485_ENABLED) ||
> > -	    rs485conf->flags & SER_RS485_RX_DURING_TX)
> > +	    rs485conf->flags & SER_RS485_RX_DURING_TX) {
> > +		imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
> >  		imx_uart_start_rx(port);
> > +	}
> >  
> >  	return 0;
> >  }
> 
> Unfortunately, I introduced a regression with this patch. The problem
> was detected by our automated tests when running a loopback test with
> SDMA enabled. Please do not apply this  patch to any stable branch. I
> could provide a fix for mainline on top of this change, or would you
> prefer to revert it for now?

Should now be fixed up, thanks.

greg k-h

