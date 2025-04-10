Return-Path: <stable+bounces-132122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20373A846D2
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 16:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6029C5A17
	for <lists+stable@lfdr.de>; Thu, 10 Apr 2025 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175C328EA63;
	Thu, 10 Apr 2025 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e4ZyCHPC"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B928EA5C;
	Thu, 10 Apr 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744296247; cv=none; b=S9VrZ/qSkBOHpe1/Ihvq2l+/czvEMz0d0/Q+cdNAtTW1T4EUYfTn2X1BR6pe7hiUJAzWzd1WXXmDQ7LMsw+N4fb1HkoXHdpoJzG53+SU6Y1tEgestFeQG+WdREImS929L54sL1PEEE+h3r0ZIXPPlG0TIlb/BzVpXtIKvWatPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744296247; c=relaxed/simple;
	bh=7NA7IGx3px2lpOhipDVT0MQpDVEshcCBzuvv5Sl1hlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rt5UZ0yUgnx8bxAV2Qgu7p9UxLp4/0na4pQyq7yDjZIRjAnzH05hkGnTB0ELdmMOd0p68Keewq0+8wzFHRG8d50xWmT1Pi/6jpf2KN/r4+C9w15FE/tVC84GEB7Xta1mDC5eR9b5vTYvd9lDYpFZTtN44ITqW7tk0yioxsfXtWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e4ZyCHPC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CmP5rnVgOFbK3FaMkFul90NMSZkbXqvY+iGtx4H41h0=; b=e4ZyCHPC5onj6x7WOAwSiwT+dY
	pAtfK+20WpMJ9guxwIrL8g1DCGIjQt4ZvL+WNbTtWCXOAHMBoV8C1t3407tnXrZ3ze/XhvLR5mv71
	47zDwd2QhsBc6tMuIj+XnHLQCOUn9eRScXZE/mNAPV3uCMelesUXMLAIZUsK4Zsh0LXY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2t8E-008gyh-Dj; Thu, 10 Apr 2025 16:43:54 +0200
Date: Thu, 10 Apr 2025 16:43:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: netdev@vger.kernel.org,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-list@raspberrypi.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: Enforce a minimum interrupt polling
 period
Message-ID: <0901d90d-3f20-4a10-b680-9c978e04ddda@lunn.ch>
References: <20250310165932.1201702-1-fiona.klute@gmx.de>
 <11f5be1d-9250-4aba-8f51-f231b09d3992@lunn.ch>
 <4577e7d7-cadc-41c6-b93f-eca7d5a8eb46@gmx.de>
 <42b5d49b-caf8-492d-8dba-b5292279478a@lunn.ch>
 <dc8ef510-8f7d-4c96-9fd8-76b67a22aaf9@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8ef510-8f7d-4c96-9fd8-76b67a22aaf9@gmx.de>

> > Ah, O.K. This tells me the PHY is a lan88xx. And there is a workaround
> > involved for an issue in this PHY. Often PHYs are driven by polling
> > for status changes once per second. Not all PHYs/boards support
> > interrupts. It could be this workaround has only been tested with
> > polling, not interrupts, and so is broken when interrupts are used.
> > 
> > As a quick hack test, in lan78xx_phy_init()
> > 
> > 	/* if phyirq is not set, use polling mode in phylib */
> > 	if (dev->domain_data.phyirq > 0)
> > 		phydev->irq = dev->domain_data.phyirq;
> > 	else
> > 		phydev->irq = PHY_POLL;
> > 
> > Hard code phydev->irq to PHY_POLL, so interrupts are not used.
> > 
> > See if you can reproduce the issue when interrupts are not used.
> It took a while, but I'm fairly confident now that the workaround works,
> I've had over 1000 boots on the hardware in question and didn't see the
> bug. Someone going by upsampled reported the same in the issue on Github
> [1], and pointed out that people working with some Nvidia board and a
> LAN7800 USB device came to the same conclusion a while ago [2].
> 
> That leaves me with the question, what does that mean going forward?
> Would it make sense to add a quirk to unconditionally force polling on
> lan88xx, at least until/unless the interrupt handling can be fixed?

I don't think you need a quirk:

static struct phy_driver microchip_phy_driver[] = {
{
        .phy_id         = 0x0007c132,
        /* This mask (0xfffffff2) is to differentiate from
         * LAN8742 (phy_id 0x0007c130 and 0x0007c131)
         * and allows future phy_id revisions.
         */
        .phy_id_mask    = 0xfffffff2,
        .name           = "Microchip LAN88xx",

        /* PHY_GBIT_FEATURES */

        .probe          = lan88xx_probe,
        .remove         = lan88xx_remove,

        .config_init    = lan88xx_config_init,
        .config_aneg    = lan88xx_config_aneg,
        .link_change_notify = lan88xx_link_change_notify,

        .config_intr    = lan88xx_phy_config_intr,
        .handle_interrupt = lan88xx_handle_interrupt,

Just remove .config_intr and .handle_interrupt. If these are not
provided, phylib will poll, even if an interrupt number has been
passed. And since these functions are not shared with any other PHY,
you can remove them.

Please write a good commit message, we want it clear why they where
removed, to try to prevent somebody putting them back again.

And please aim this for net, not net-next:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The change will then get back ported to stable kernels.

	Andrew

