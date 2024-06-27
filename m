Return-Path: <stable+bounces-55964-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1861591A86B
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 15:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B8728754A
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848E519538A;
	Thu, 27 Jun 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AZc2ybgD"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EE194C7C;
	Thu, 27 Jun 2024 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496616; cv=none; b=Qy4j1R4LveBesLsROOWjjTrYVyYq0K7oFWWSAg4YryF/gRqe4MylbtV9gZY2fuksAmDPKd3D9GWQ9JvDZ6QPvYn9ouykcu14WrYxu9IE8Yu5Hpb/oDn+PWD0MD9cJbMLblKvzBOQpwofM/Fs+diYz+2vxog8c2FZNLaLrzaW3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496616; c=relaxed/simple;
	bh=CZmEcAnf9jtjaxGakn6h3QaBimf8B8jbkcBZVrAXoWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dafoqJreYK25v479KmkTVMEhpGryHpSOFzstqWA7ONtHADFXsMyrX3oNDGwMM7pUDYgjMgeeJjNEOSSQOfT6voBB8qR3tHohNKZRkMz+czPlH2Old65RWn/gEJ6uVdP6UVkWkbujUycU3dY3UlDeSJJ6D6AMNCmpG53SnMxJ8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AZc2ybgD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vMYtbU0m3UnYFrztkY1kdGT1q/qpGgwwrS0seV4fbgU=; b=AZc2ybgDm0EsRmt6h1PV5U+chc
	orZ5i9zeHk6uIHaGsClV63FsYkRTfyHRNy36+FjXNcSKp/swocNMyE/j9GJjm0y4/JjuPhUUlE652
	LoXpiMupZknaYgJ9swPzINw6AamHSzR5AnRSFLenlfRhYkOMnJ2ApWErtdZLhuEzNbV0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMpcB-001ASG-0V; Thu, 27 Jun 2024 15:56:43 +0200
Date: Thu, 27 Jun 2024 15:56:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net v1 1/1] net: phy: micrel: ksz8081: disable broadcast
 only if PHY address is not 0
Message-ID: <0720eddf-f023-47b4-9eed-93e0b326220e@lunn.ch>
References: <20240627053353.1416261-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627053353.1416261-1-o.rempel@pengutronix.de>

On Thu, Jun 27, 2024 at 07:33:53AM +0200, Oleksij Rempel wrote:
> Do not disable broadcast if we are using address 0 (broadcast) to
> communicate with this device. Otherwise we will use proper driver but no
> communication will be possible and no link changes will be detected.
> There are two scenarios where we can run in to this situation:
> - PHY is bootstrapped for address 0

What do you mean by bootstrapped to address 0? The strapping pins set
it to some other address, but the bootloader wrote to registers and
moved it to address 0? 

> - no PHY address is known and linux is scanning the MDIO bus, so first
>   respond and attached device will be on address 0.

So in this case, the PHY is really at address X, where X != 0. It
responds to all read requests, so the scanning finds it at all
addresses. It also stomps over other devices on the bus when scanning
for them, or probing them.

I'm not sure the current code is correct. But it is also going to be
messy to not break backwards compatibility for DT blobs say the device
is at address 0, when in fact it is not.

Is it possible to read the devices actual address from registers?

I'm wondering if probe should do something like:

int actual_address = phydev_read(phydev, 0x42);

if (actual_address == 0) {
	if (type->has_broadcast_disable) {
		phydev_dbg(phydev, "Disabling broadcast\n");
		kszphy_broadcast_disable(phydev);
	}

} else {
	if (actual_address != 0 &&
	 phydev->mdio.addr != actual_address &&
	 phydev->mdio.addr != 0) {
		if (type->has_broadcast_disable) {
			phydev_dbg(phydev, "Disabling broadcast\n");
			kszphy_broadcast_disable(phydev);
		}
        return -ENODEV;
	}
}

So if the devices really has an address is zero, turn off
broadcast. That will stop it stomping over other devices, but the
damage is probably already done in terms of scanning.

If the devices is really at some address other than 0, and we are
probing at a different address, and that address is not 0, turn off
broadcast and say the device does not exist. I think we need to
special case 0 because there are going to be some DT descriptions
which say the device is at 0, when in fact it is not. We might want to
add a phydev_warn() about this, to try to get the DT fixed.

> The fixes tag points to the latest refactoring, not to the initial point
> where kszphy_broadcast_disable() was introduced.
> 
> Fixes: 79e498a9c7da0 ("net: phy: micrel: Restore led_mode and clk_sel on resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Do you have a board which is going wrong because of this? Do you plan
to submit patches for earlier stable releases?

	Andrew

