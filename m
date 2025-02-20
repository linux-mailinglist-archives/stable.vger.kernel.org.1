Return-Path: <stable+bounces-118505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1792AA3E46D
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017C37A9C1A
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 18:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004726389B;
	Thu, 20 Feb 2025 18:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xyXblza+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38701C6FE9;
	Thu, 20 Feb 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077857; cv=none; b=NHTPen4iaBqVqI9dBx8cGjM3UM3vDN0jdzt5QJIStzCSXhNnZmU/zBAZu7p225hix10K6iIg2E8hQh1PyZiP2qRxWNWXPlx9K/lGzfISfJVV0l2cjkQjn7hXOzMGg+jc/Gt0gcINItNuV0+wyZ+0WGYLvMyhNJ+U6WI2nszwOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077857; c=relaxed/simple;
	bh=f4Sy5aHgWXeP34/uoGdOVhtADDX1fanqW5hZIfwVGik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7e+IuVmDhkPKSRI11lyASpfF3r7saDejUq0a5xDvDrc+ZzwaMB08RpbzNUXV1ximLvHkX4Fdx1JDbnFAgG6TkUKJFJwjWiosd6bd9YNyqgBDRelt58hbSpOylG5lbge2nk/Rb2Gxcug3oZincFfGN4ZSanBCqyogiQDCZOt9x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xyXblza+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62F5C4CED1;
	Thu, 20 Feb 2025 18:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740077856;
	bh=f4Sy5aHgWXeP34/uoGdOVhtADDX1fanqW5hZIfwVGik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xyXblza+2mY8EC2GL0p+51GwRMyqOatohzm1fdbNL8UsFTqkfFCqQHyRdsd7zwXEL
	 bht/sYAFTFZbun4oQsIVFvT9mDf1M4Ok+qPmA/MsCq5/Vg+PBVJhysMRX7PEEAZ6EO
	 wN6WknCaE4gBA2pDtp/+gBQiJDXTbnfe5XH04WGY=
Date: Thu, 20 Feb 2025 19:57:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: William McVicker <willmcvicker@google.com>
Cc: Prashanth K <prashanth.k@oss.qualcomm.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, andre.draszik@linaro.org,
	kernel-team@android.com
Subject: Re: [PATCH v2] usb: gadget: Set self-powered based on MaxPower and
 bmAttributes
Message-ID: <2025022032-cruelness-framing-2a10@gregkh>
References: <20250217120328.2446639-1-prashanth.k@oss.qualcomm.com>
 <Z7dv4rEILkC9yRwX@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dv4rEILkC9yRwX@google.com>

On Thu, Feb 20, 2025 at 10:09:38AM -0800, William McVicker wrote:
> Hi Prashanth,
> 
> On 02/17/2025, Prashanth K wrote:
> > Currently the USB gadget will be set as bus-powered based solely
> > on whether its bMaxPower is greater than 100mA, but this may miss
> > devices that may legitimately draw less than 100mA but still want
> > to report as bus-powered. Similarly during suspend & resume, USB
> > gadget is incorrectly marked as bus/self powered without checking
> > the bmAttributes field. Fix these by configuring the USB gadget
> > as self or bus powered based on bmAttributes, and explicitly set
> > it as bus-powered if it draws more than 100mA.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver of self-powered")
> > Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Didn't change anything from RFC.
> > - Link to RFC: https://lore.kernel.org/all/20250204105908.2255686-1-prashanth.k@oss.qualcomm.com/
> > 
> >  drivers/usb/gadget/composite.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> > index bdda8c74602d..1fb28bbf6c45 100644
> > --- a/drivers/usb/gadget/composite.c
> > +++ b/drivers/usb/gadget/composite.c
> > @@ -1050,10 +1050,11 @@ static int set_config(struct usb_composite_dev *cdev,
> >  	else
> >  		usb_gadget_set_remote_wakeup(gadget, 0);
> >  done:
> > -	if (power <= USB_SELF_POWER_VBUS_MAX_DRAW)
> > -		usb_gadget_set_selfpowered(gadget);
> > -	else
> > +	if (power > USB_SELF_POWER_VBUS_MAX_DRAW ||
> > +	    !(c->bmAttributes & USB_CONFIG_ATT_SELFPOWER))
> >  		usb_gadget_clear_selfpowered(gadget);
> > +	else
> > +		usb_gadget_set_selfpowered(gadget);
> >  
> >  	usb_gadget_vbus_draw(gadget, power);
> >  	if (result >= 0 && cdev->delayed_status)
> > @@ -2615,7 +2616,9 @@ void composite_suspend(struct usb_gadget *gadget)
> >  
> >  	cdev->suspended = 1;
> >  
> > -	usb_gadget_set_selfpowered(gadget);
> > +	if (cdev->config->bmAttributes & USB_CONFIG_ATT_SELFPOWER)
> > +		usb_gadget_set_selfpowered(gadget);
> 
> I'm hitting a null pointer derefence here on my Pixel 6 device on suspend.  I
> haven't dug deep into it how we get here, but in my case `cdev->config` is
> NULL. This happens immediate after booting my device. I verified that just
> adding a NULL check fixes the issue and dwc3 gadget can successfully suspend.

This was just fixed in my tree today with this commit:
	https://lore.kernel.org/r/20250220120314.3614330-1-m.szyprowski@samsung.com

Hope this helps,

greg k-h

