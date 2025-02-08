Return-Path: <stable+bounces-114367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB8A2D41D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 06:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9C716B23D
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 05:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE0919C575;
	Sat,  8 Feb 2025 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7IS+KGI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD017BA6;
	Sat,  8 Feb 2025 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738993195; cv=none; b=EKdQVm9opc30OH2n5t9+nZjOdXPNRlH/gqmZ5E1EIRO8zYWDmANqPGDPatk+eMYwjmzQ6A9ExWQKgYDpQZ52kJCHarU77Uu1iT+bR+FpIRBBZCxNMMDHLPqruBwdRYLM/5NxUQ34EKFIdrCCbmGIgSAWBjQdyeaRuqxTGtGWhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738993195; c=relaxed/simple;
	bh=EIO2RApIMTaoQHu0AYGuzLxcnzfiMUbPkQ+Ttz9uEII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bezvMdVPi36fGf/NACaf7GAR/fnOWukpvgaCBdmM/uzREP7m951Eqa3VGg+lQD5skLg1YFN4isN60Iclq94A7+Y5pGgImaKYhH9X4XCrv4wRWil8hX6zndKvXMwo5Gp+a2McAgSjbJSS4GLdOwXM06ep+YajPjHxyR20Vd1vgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7IS+KGI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A947C4CED6;
	Sat,  8 Feb 2025 05:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738993194;
	bh=EIO2RApIMTaoQHu0AYGuzLxcnzfiMUbPkQ+Ttz9uEII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S7IS+KGI3Cu01/xSeKZlmjbimenl4l3+vdhqWbdTyYouNNAUtuuQyWwiHKVab3XdB
	 IB8DBjZoyV7v0hhgNXxbff/mQ4HWs+m6zW94oGZB5LRvd4hYLwvkeeoIn3ilJEvi6r
	 d5sR38oZnjxCT2bzT+5w4IMqQAl2yyowhLtQ14Cx4wgFbu/70jSYWyPIo+/4ANPurY
	 K2Vsydclww71WiA2sgAFS235YE0a/UI72AZy008IOfcGiw/Mo7tN8/zXACsW96UHkI
	 R6JA0YGDChkYHuY3eC0/8hCSicNYgXRy9TDwA71pP8+0ttdS7ftm/K4BaU25IZCoPJ
	 n/1jziYmSveFg==
Date: Sat, 8 Feb 2025 13:39:44 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: pawell@cadence.com, rogerq@kernel.org, gregkh@linuxfoundation.org,
	balbi@kernel.org, jun.li@nxp.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] usb: cdns3: exit cdns3_gadget_udc_start if
 FAST_REG_ACCESS cannot be set
Message-ID: <20250208053944.GA28062@nchen-desktop>
References: <20250206125943.786949-1-s-vadapalli@ti.com>
 <20250207022523.GA22848@nchen-desktop>
 <tf7qwkoybolexehzagzel67kdxdfsve2f3qdueomedld72v7pp@bquo47wpsxul>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tf7qwkoybolexehzagzel67kdxdfsve2f3qdueomedld72v7pp@bquo47wpsxul>

On 25-02-07 11:12:50, Siddharth Vadapalli wrote:
> On Fri, Feb 07, 2025 at 10:25:23AM +0800, Peter Chen wrote:
> 
> Hello Peter,
> 
> > On 25-02-06 18:29:36, Siddharth Vadapalli wrote:
> > > When the device is in a low power state, access to the following
> > > registers takes a long time:
> > > - EP_CFG
> > > - EP_TRADDR
> > > - EP_CMD
> > > - EP_SEL
> > > - EP_STS
> > > - USB_CONF
> > > 
> > > To address this, the fast register access feature can be enabled by
> > > setting PUSB_PWR_FST_REG_ACCESS bit of the USB_PWR register, which
> > > allows quick access by software. Software is expected to poll on
> > > PUSB_PWR_FST_REG_ACCESS_STAT to ensure that fast register access has
> > > been enabled by the controller. Attempting to access any of the
> > > aforementioned registers after setting PUSB_PWR_FST_REG_ACCESS but
> > > before PUSB_PWR_FST_REG_ACCESS_STAT has been set will result in
> > > undefined behavior and potentially result in system hang.
> > > 
> > > Hence, poll on PUSB_PWR_FST_REG_ACCESS_STAT before proceeding with
> > > gadget configuration, and exit if it cannot be enabled.
> > > 
> > > Fixes: b5148d946f45 ("usb: cdns3: gadget: set fast access bit")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > ---
> > > 
> > > Hello,
> > > 
> > > This patch is based on commit
> > > 92514ef226f5 Merge tag 'for-6.14-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > > of Mainline Linux.
> > > 
> > > Regards,
> > > Siddharth.
> > > 
> > >  drivers/usb/cdns3/cdns3-gadget.c | 18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
> > > index fd1beb10bba7..b62691944272 100644
> > > --- a/drivers/usb/cdns3/cdns3-gadget.c
> > > +++ b/drivers/usb/cdns3/cdns3-gadget.c
> > > @@ -2971,8 +2971,6 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
> > >  	/* enable generic interrupt*/
> > >  	writel(USB_IEN_INIT, &regs->usb_ien);
> > >  	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
> > > -	/*  keep Fast Access bit */
> > > -	writel(PUSB_PWR_FST_REG_ACCESS, &priv_dev->regs->usb_pwr);
> > >  
> > >  	cdns3_configure_dmult(priv_dev, NULL);
> > >  }
> > > @@ -2990,6 +2988,8 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
> > >  	struct cdns3_device *priv_dev = gadget_to_cdns3_device(gadget);
> > >  	unsigned long flags;
> > >  	enum usb_device_speed max_speed = driver->max_speed;
> > > +	int ret;
> > > +	u32 reg;
> > >  
> > >  	spin_lock_irqsave(&priv_dev->lock, flags);
> > >  	priv_dev->gadget_driver = driver;
> > > @@ -2997,6 +2997,20 @@ static int cdns3_gadget_udc_start(struct usb_gadget *gadget,
> > >  	/* limit speed if necessary */
> > >  	max_speed = min(driver->max_speed, gadget->max_speed);
> > >  
> > > +	/*  keep Fast Access bit */
> > > +	writel(PUSB_PWR_FST_REG_ACCESS, &priv_dev->regs->usb_pwr);
> > > +	reg = readl(&priv_dev->regs->usb_pwr);
> > > +	if (!(reg & PUSB_PWR_FST_REG_ACCESS_STAT)) {
> > > +		ret = readl_poll_timeout_atomic(&priv_dev->regs->usb_pwr, reg,
> > > +						(reg & PUSB_PWR_FST_REG_ACCESS_STAT),
> > > +						10, 1000);
> > > +		if (ret) {
> > > +			dev_err(priv_dev->dev, "Failed to enable fast access\n");
> > > +			spin_unlock_irqrestore(&priv_dev->lock, flags);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > >  	switch (max_speed) {
> > >  	case USB_SPEED_FULL:
> > >  		writel(USB_CONF_SFORCE_FS, &priv_dev->regs->usb_conf);
> > 
> > Hi Siddharth,
> > 
> > Would you please keep this change at cdns3_gadget_config in case the
> > controller is power lost during the system suspend?
> 
> I did think of that initially, but the problem with doing so is that we
> are already accessing USB_CONF above in the "switch(max_speed)" section.
> The PUSB_PWR_FST_REG_ACCESS bit needs to be set before accessing any of:
> - EP_CFG
> - EP_TRADDR
> - EP_CMD
> - EP_SEL
> - EP_STS
> - USB_CONF
> 
> Please let me know if you have an alternate suggestion to address the
> above.
> 

How about move cdns3_gadget_config at the beginning of function
cdns3_gadget_udc_start, and add your changes at cdns3_gadget_config?

Regards,
Peter

