Return-Path: <stable+bounces-55978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888A891AD3A
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FD71F26986
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6019A288;
	Thu, 27 Jun 2024 16:51:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF1199EA0
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719507113; cv=none; b=LS6KDbZ5k12s/uAMWHZRn86EundEPypEfghBYkJbRKb77mHHJ67w8BlGqDEBWgXLKyIAPRpRvMKzQDvkKPNPkkIc626w5QKrE4eFjuB8OCY/PnH4b74mjDHjS+fKL+WDi0UbUOar9L2TXXabfvS2VGZXyctWzyXTbAhFbRFfPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719507113; c=relaxed/simple;
	bh=YFMasvqhkq7Zj/uRTE2wg2o4nt9ClrilJA3cm3H0f+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3tuolitITNWS8SoqsW/9j8++KXvczUyE/Nwy98+TinyDQUKZlktYzgLEo9Xcx/52sRRx9H8KzJXZiNBZKUCbXYaZepsgrQGnvoP3Rsu7akRqRxvxz9/rZnSRxex2B70lxVFkcWAh8Twes2rHtF7Ug2p7Iv0oPTdTE1Vk9R+Evk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sMsLW-0001pw-If; Thu, 27 Jun 2024 18:51:42 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sMsLU-005PWK-Vs; Thu, 27 Jun 2024 18:51:40 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sMsLU-000XF3-2s;
	Thu, 27 Jun 2024 18:51:40 +0200
Date: Thu, 27 Jun 2024 18:51:40 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net v1 1/1] net: phy: micrel: ksz8081: disable broadcast
 only if PHY address is not 0
Message-ID: <Zn2YnC5aG0QIXup5@pengutronix.de>
References: <20240627053353.1416261-1-o.rempel@pengutronix.de>
 <0720eddf-f023-47b4-9eed-93e0b326220e@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0720eddf-f023-47b4-9eed-93e0b326220e@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

Hi Andrew,

hm... looks like my previous answer is lost. I had here some hiccups on
my side. Sending new answer, do not wunder if there will be double
mail.

On Thu, Jun 27, 2024 at 03:56:42PM +0200, Andrew Lunn wrote:
> On Thu, Jun 27, 2024 at 07:33:53AM +0200, Oleksij Rempel wrote:
> > Do not disable broadcast if we are using address 0 (broadcast) to
> > communicate with this device. Otherwise we will use proper driver but no
> > communication will be possible and no link changes will be detected.
> > There are two scenarios where we can run in to this situation:
> > - PHY is bootstrapped for address 0
> 
> What do you mean by bootstrapped to address 0? The strapping pins set
> it to some other address, but the bootloader wrote to registers and
> moved it to address 0?

No no. Just strapping from HW perspective, no SW is involved.

> > - no PHY address is known and linux is scanning the MDIO bus, so first
> >   respond and attached device will be on address 0.
> 
> So in this case, the PHY is really at address X, where X != 0. It
> responds to all read requests, so the scanning finds it at all
> addresses. It also stomps over other devices on the bus when scanning
> for them, or probing them.
> 
> I'm not sure the current code is correct. But it is also going to be
> messy to not break backwards compatibility for DT blobs say the device
> is at address 0, when in fact it is not.

It looks like this is the actual case on my board.

> Is it possible to read the devices actual address from registers?

Yes.

> I'm wondering if probe should do something like:
> 
> int actual_address = phydev_read(phydev, 0x42);
> 
> if (actual_address == 0) {
> 	if (type->has_broadcast_disable) {
> 		phydev_dbg(phydev, "Disabling broadcast\n");
> 		kszphy_broadcast_disable(phydev);
> 	}
> 
> } else {
> 	if (actual_address != 0 &&
> 	 phydev->mdio.addr != actual_address &&
> 	 phydev->mdio.addr != 0) {
> 		if (type->has_broadcast_disable) {
> 			phydev_dbg(phydev, "Disabling broadcast\n");
> 			kszphy_broadcast_disable(phydev);
> 		}
>         return -ENODEV;
> 	}
> }
> 
> So if the devices really has an address is zero, turn off
> broadcast. That will stop it stomping over other devices, but the

If i understand the documentation correctly, disable broadcast bit is
designed to resolve conflict between two KSZ8081 PHYs on same bus
in one shot:
"For applications that require two KSZ8081RNA/RND PHYs to share the same
MDIO interface with one PHY set to address 0h and the other PHY set to
address 3h, use PHY address 0h (defaults to broadcast after power-up) to
set both PHYs’ Register 16h, Bit [9] to ‘1’ to assign PHY address 0h as
a unique (non-broadcast) PHY address."

For this scenario, we can't read configured address from the HW in the
first place, this can be done safely only if (phydev->mdio.addr != 0)

> damage is probably already done in terms of scanning.
> 
> If the devices is really at some address other than 0, and we are
> probing at a different address, and that address is not 0, turn off
> broadcast and say the device does not exist. I think we need to
> special case 0 because there are going to be some DT descriptions
> which say the device is at 0, when in fact it is not. We might want to
> add a phydev_warn() about this, to try to get the DT fixed.

Assuming there are no other devices on the bus listening for broadcast
too.

> > The fixes tag points to the latest refactoring, not to the initial point
> > where kszphy_broadcast_disable() was introduced.
> > 
> > Fixes: 79e498a9c7da0 ("net: phy: micrel: Restore led_mode and clk_sel on resume")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Do you have a board which is going wrong because of this?

Yes, I can avoid this bug on the DT level. But the code side seems to be
broken too.

> Do you plan to submit patches for earlier stable releases?

Not so far. Should I?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

