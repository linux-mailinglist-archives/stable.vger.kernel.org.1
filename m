Return-Path: <stable+bounces-61816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947DC93CD8B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 07:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D8B281DB3
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 05:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270D364AE;
	Fri, 26 Jul 2024 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="if0WP0pI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0E282E5;
	Fri, 26 Jul 2024 05:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721971481; cv=none; b=BjChUNdpW3GcFbseTlaV/L26VVcyyGy3xIHl3a0vmOjawGqwpQcDr74fpKPyzp7tukNJRfWMQw3YvCxvT2UXo6WK3crlH385yA/5hiwyYzAnv4ZNnTWill/pBPffAYaFskRRzEP36lLU/RRhFnhPMLSAa0thuJMn+rjt6IKBSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721971481; c=relaxed/simple;
	bh=nemUc7egxO2j1LPV5UcxC1c3YR7xzygubEeRG+xRO7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCvXYQxoFegx9OMdfOAqf+IwxC4YbpmR0ABLyyacaZvL50lej/buk6pHud3p62HhFqeYyLh+YpGsN6jhUmZKuQXZ3QvHAgvwtR9S4iGe6slC8p3W/CNQx3N01jXw3hkiLw75LyPRDUYTYYRTvtG2r0nhE4UjZcZo5kVVw9tUG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=if0WP0pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648F9C32782;
	Fri, 26 Jul 2024 05:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721971481;
	bh=nemUc7egxO2j1LPV5UcxC1c3YR7xzygubEeRG+xRO7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if0WP0pIEQr0wVtSSrKsq5KB7LILhHMS530Ua0TTFH9qgabmXcXUYqsOHtTX7IABq
	 OdoqCTt2X/0r+lVq1kZyphkMAsS+AkFnaNguhEXEQXzpK3fmEZ18h4VHx8a8scwDdX
	 GFqkJJu8MnsuQBJZegCSfyI9MaXTpXBlSFuO7oFw=
Date: Fri, 26 Jul 2024 07:24:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: crwulff@gmail.com, linux-usb@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: core: Check for unset descriptor
Message-ID: <2024072650-stash-request-d5c6@gregkh>
References: <20240725010419.314430-2-crwulff@gmail.com>
 <2024072512-arguably-creole-a017@gregkh>
 <d24a4b7f-0d3a-4c24-9de3-5f14297b0904@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d24a4b7f-0d3a-4c24-9de3-5f14297b0904@rowland.harvard.edu>

On Thu, Jul 25, 2024 at 02:23:25PM -0400, Alan Stern wrote:
> On Thu, Jul 25, 2024 at 06:56:19AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jul 24, 2024 at 09:04:20PM -0400, crwulff@gmail.com wrote:
> > > From: Chris Wulff <crwulff@gmail.com>
> > > 
> > > Make sure the descriptor has been set before looking at maxpacket.
> > > This fixes a null pointer panic in this case.
> > > 
> > > This may happen if the gadget doesn't properly set up the endpoint
> > > for the current speed, or the gadget descriptors are malformed and
> > > the descriptor for the speed/endpoint are not found.
> > > 
> > > No current gadget driver is known to have this problem, but this
> > > may cause a hard-to-find bug during development of new gadgets.
> > > 
> > > Fixes: 54f83b8c8ea9 ("USB: gadget: Reject endpoints with 0 maxpacket value")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Chris Wulff <crwulff@gmail.com>
> > > ---
> > > v2: Added WARN_ONCE message & clarification on causes
> > > v1: https://lore.kernel.org/all/20240721192048.3530097-2-crwulff@gmail.com/
> > > ---
> > >  drivers/usb/gadget/udc/core.c | 10 ++++------
> > >  1 file changed, 4 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > > index 2dfae7a17b3f..81f9140f3681 100644
> > > --- a/drivers/usb/gadget/udc/core.c
> > > +++ b/drivers/usb/gadget/udc/core.c
> > > @@ -118,12 +118,10 @@ int usb_ep_enable(struct usb_ep *ep)
> > >  		goto out;
> > >  
> > >  	/* UDC drivers can't handle endpoints with maxpacket size 0 */
> > > -	if (usb_endpoint_maxp(ep->desc) == 0) {
> > > -		/*
> > > -		 * We should log an error message here, but we can't call
> > > -		 * dev_err() because there's no way to find the gadget
> > > -		 * given only ep.
> > > -		 */
> > > +	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
> > > +		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
> > > +			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
> > 
> > So you just rebooted a machine that hit this, that's not good at all.
> > Please log the error and recover, don't crash a system (remember,
> > panic-on-warn is enabled in billions of Linux systems.)
> 
> That should not be a problem.  This WARN_ONCE is expected never to be 
> triggered except by a buggy gadget driver.  It's a debugging tool; the 
> developer will get an indication in the kernel log of where the problem 
> is instead of just a panic.

Ok, if this can never be hit by a user action, then it's ok to leave
as-is, it wasn't obvious to me that this is the case, sorry.  I'll
queue this up after -rc1 is out.

thanks,

greg k-h

