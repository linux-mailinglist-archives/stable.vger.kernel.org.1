Return-Path: <stable+bounces-96183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EACD9E113E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 03:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFA7162DC4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 02:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF767CF16;
	Tue,  3 Dec 2024 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlfTP42e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE738460;
	Tue,  3 Dec 2024 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192977; cv=none; b=jCPOXLqg1DymMtUiUg6r11aahOaA+P68bsS2DVsF6TrCL9U0Mp0BqIp7HwBV4liHJG08WgnJELtJYCmAZWM9HQ9ypdPm7Y2RMUxFeGRgDjdllUlsJsBcXcjr12Jy8yvWo9f/aFjrLeX8mbJbzeQ852F8z+qi2baj5/9iEh7osXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192977; c=relaxed/simple;
	bh=PZN9zYd19RfhnrB//bv7GB/2Hbdkt8V1j4xAJFbC1II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBKEJtj2e+RK+/S8dtYh4XU9J9XBwa0t4x+nv9IdtFfjxlYDudYBsklyN0YpaNOpCGLkw2ogvnod/Mf2YyXuHlW+F4jRsoRAup20v+9RGZsvODnNCbRA78M6J958DgLbsLVEnvXCRj3jZLCLk/JH1L5wiSnlLBQ5vOzVGi6jiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SlfTP42e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46182C4CED1;
	Tue,  3 Dec 2024 02:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733192976;
	bh=PZN9zYd19RfhnrB//bv7GB/2Hbdkt8V1j4xAJFbC1II=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SlfTP42eEEYXzvAazMnAu6C2pAk9+igIWybmh9h6qATN/YD/p/y9Dw8EPSrfHlQNj
	 lHJJDHwv1xR09v2qxAjCVkFnf9uKil2qwrKs3q89xer+XcfiYTwzPj/f3TLdiD/Sos
	 x4aK81AjiEQWwjB5cxlPlNciMoBGmotXtrU9+RqFqVWiWJKWPIjbM4yd2b9CtEEcXL
	 ScLgH7RM7QNdmeXLojQSCibqeReoQa06KLDsggZ9I6IzHO9Ccz8VXlkZZXBar91euG
	 UirWIYIOxsO3hlvDI5pGIFI5+kJD5cvmnOGSriVQJjudseoLG5xMJ+FO8uUb5rn0i4
	 Bjlsa4ld2OYAQ==
Date: Mon, 2 Dec 2024 18:29:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: 'Dominique MARTINET' <dominique.martinet@atmark-techno.com>
Cc: David Laight <David.Laight@aculab.com>, Oliver Neukum
 <oneukum@suse.com>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Greg Thelen <gthelen@google.com>, John Sperbeck
 <jsperbeck@google.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net] net: usb: usbnet: fix name regression
Message-ID: <20241202182935.75e8850c@kernel.org>
In-Reply-To: <Z05cdCEgqyea-qBD@atmark-techno.com>
References: <20241017071849.389636-1-oneukum@suse.com>
	<Z00udyMgW6XnAw6h@atmark-techno.com>
	<e53631b5108b4d0fb796da2a56bc137f@AcuMS.aculab.com>
	<Z01xo_7lbjTVkLRt@atmark-techno.com>
	<20241202065600.4d98a3fe@kernel.org>
	<Z05FQ-Z6yv16lSnY@atmark-techno.com>
	<20241202162653.62e420c5@kernel.org>
	<Z05cdCEgqyea-qBD@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 10:18:44 +0900 'Dominique MARTINET' wrote:
> Jakub Kicinski wrote on Mon, Dec 02, 2024 at 04:26:53PM -0800:
> > > My problematic device here has FLAG_POINTTOPOINT and a (locally
> > > admistered) mac address set, so it was not renamed up till now,
> > > but the new check makes the locally admistered mac address being set
> > > mean that it is no longer eligible to keep the usbX name.  
> > 
> > Ideally, udev would be the best option, like Greg said.
> > This driver is already a fragile pile of workarounds.  
> 
> Right, as I replied to Greg I'm fine with this as long as it's what was
> intended.

In theory unintentional != bug, but yes, its very likely unintentional.

> Half of the reason I sent the mail in the first place is I don't
> understand what commit 8a7d12d674ac ("net: usb: usbnet: fix name
> regression") actually fixes: the commit message desribes something about
> mac address not being set before bind() but the code does not change
> what address is looked at (net->dev_addr), just which bits of the
> address is checked; and I don't see what which bytes are being looked at
> changing has anything to do with the "fixed" commit bab8eb0dd4cb9 ("usbnet:
> modern method to get random MAC")

We moved where the random address is assigned, we used to assign random
(local) addr at init, now we assign it after calling ->bind().

Previously we checked "if local" as a shorthand for checking "if driver
updated". This check should really have been "if addr == node_id".

> ... And now we've started discussing this and I understand the check
> better, I also don't see what having a mac set by the previous driver
> has to do with the link not being P2P either.
> 
> 
> (The other half was I was wondering what kind of policy stable would have
> for this kind of things, but that was made clear enough)
> 
> 
> > If you really really want the old behavior tho, let's convert 
> > the zero check to  !is_zero_ether_addr() && !is_local_ether_addr().  
> 
> As far as I understand, !is_local_ether_addr (mac[0] & 0x2) implies
> !is_zero_ether_addr (all bits of mac or'd), so that'd get us back to
> exactly the old check.

Let the compiler discover that, this is control path code, so write
it for the human reader... The condition we want is "driver did not
initialize the MAC address, or it initialized it to a local MAC
address".

> > Maybe factor out the P2P + address validation to a helper because
> > the && vs || is getting complicated.  
> 
> ... And I can definitely relate to this part :)
> 
> So:
> - final behavior wise I have no strong feeling, we'll fix our userspace
> (... and documentation) whatever is decided here
> - let's improve the comment and factor the check anyway.
> As said above I don't understand why having a mac set matters, if that
> can be explained I'll be happy to send a patch.
> Or if we go with the local address version, something like the
> following?
> 
> ----
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 44179f4e807f..240ae86adf08 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -178,6 +178,13 @@ int usbnet_get_ethernet_addr(struct usbnet *dev, int iMACAddress)
>  }
>  EXPORT_SYMBOL_GPL(usbnet_get_ethernet_addr);
>  
> +static bool usbnet_dev_is_two_host (struct usbnet *dev, struct net_device *net)

static bool usenet_needs_usb_name_format(...

> +{
> +	/* device is marked point-to-point with a local mac address */

	/* Point to point devices which don't have a real MAC address
	 * (or report a fake local one) have historically used the usb%d
	 * naming. Preserve this..
	 */

> +	return (dev->driver_info->flags & FLAG_POINTTOPOINT) != 0 &&
> +		is_local_ether_addr(net->dev_addr);

	if ((dev->driver_info->flags & FLAG_POINTTOPOINT) &&
	    (is_zero_ether_addr(net->dev_addr) ||
	     is_local_ether_addr(net->dev_addr));

> +}

Up to you if you want to send this.

