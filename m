Return-Path: <stable+bounces-189271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ABAC08E89
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 11:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAA104E67FA
	for <lists+stable@lfdr.de>; Sat, 25 Oct 2025 09:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019E92E6CBB;
	Sat, 25 Oct 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nRFp7MWJ"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0851F1932;
	Sat, 25 Oct 2025 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761385092; cv=none; b=Qudh7sP5bkaXb75HZpDpeB+KAzrrapdvaAXz0aWrR1kuJPy9sciA8gRmq0B7J7cWIfMfcOKCnnmuZD2Ehvl1cj1+i78Y5HGgpyUapVsHUZpMQc6XC0XkcekFiwSX/hVIbcjVYG0qMLFPuWP1uKICkZ6NPjh95IL2rG6dckGfZDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761385092; c=relaxed/simple;
	bh=qKeh5cxyw+7Gml1biLwuWJ/nM8sHMmP0hyx9XSDwCDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCmknSx8MA29IQdXuicxWg32UBFzGWZq5kaTUYXuIaybH636sOhATN5axjpyGkTTcg5MffovTfe9OwIren3hiG1AZmvRGypvBNacfIKTCBo19RvtjViV0gxMg8Nhup73MuclnwAbEUBZjxIimKtiNLiKwUipy/Z2xeE+EptUVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nRFp7MWJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m71c3FooNtQtr8y26hSGiucyyGJcYCSbaK6kuqcT358=; b=nRFp7MWJHcj0hBpft31gI2THeL
	8ka0Zyuf5+40gCgGx0g4m4X07Mu43tVcHyY3Kxf3P9sLuFrsuhKcJEnnLCq8vu/9q1fSwRu12lE6W
	owBAOq9DSBqKUixI0RrCiZJgl/H844rsqdHRdvJR27iq8I2v1xg6jr08b3gWzsEv/OI2s9yfA3q/r
	wT98DDQKs8J5bKU74+s0wA5hJ2z0iHq3kXQOowrdiiglhx5W67RN3oYfgfVmbD3UO4U3W+jcoRL1W
	LO1DkC2tQejGALxFelRQ+LEtRW7coFWYZKPJKWkMYBnNNJWxZ3qAap904IZj7TrGydoo2gQTImvAs
	jc/EjOOw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56308)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vCain-000000008SL-45Ut;
	Sat, 25 Oct 2025 10:38:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vCail-000000003Z0-15vv;
	Sat, 25 Oct 2025 10:37:59 +0100
Date: Sat, 25 Oct 2025 10:37:59 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <aPyad0PUR9lY70rk@shell.armlinux.org.uk>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <aPyN7z8Vk4EiS20b@shell.armlinux.org.uk>
 <aPyWHRphEYOdk2MG@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPyWHRphEYOdk2MG@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Oct 25, 2025 at 11:19:25AM +0200, Oleksij Rempel wrote:
> On Sat, Oct 25, 2025 at 09:44:31AM +0100, Russell King (Oracle) wrote:
> > On Thu, Oct 23, 2025 at 04:48:53PM +0200, Emanuele Ghidoli wrote:
> > > While the DP83867 PHYs report EEE capability through their feature
> > > registers, the actual hardware does not support EEE (see Links).
> > > When the connected MAC enables EEE, it causes link instability and
> > > communication failures.
> > > 
> > > The issue is reproducible with a iMX8MP and relevant stmmac ethernet port.
> > > Since the introduction of phylink-managed EEE support in the stmmac driver,
> > > EEE is now enabled by default, leading to issues on systems using the
> > > DP83867 PHY.
> > 
> > Wasn't it enabled before? See commit 4218647d4556 ("net: stmmac:
> > convert to phylink managed EEE support").
> > 
> > stmmac's mac_link_up() was:
> > 
> > -       if (phy && priv->dma_cap.eee) {
> > -               phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
> > -                                            STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
> > -               priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
> > -               stmmac_eee_init(priv, phy->enable_tx_lpi);
> >                 stmmac_set_eee_pls(priv, priv->hw, true);
> > -       }
> > 
> > So, if EEE is enabled in the core synthesis, then EEE will be
> > configured depending on what phylib says.
> > 
> > In stmmac_init_phy(), there was this:
> > 
> > -               if (priv->dma_cap.eee)
> > -                       phy_support_eee(phydev);
> > -
> >                 ret = phylink_connect_phy(priv->phylink, phydev);
> > 
> > So phylib was told to enable EEE support on the PHY if the dwmac
> > core supports EEE.
> > 
> > So, from what I can see, converting to phylink managed EEE didn't
> > change this. So what really did change?
> 
> I suspect it is a change in board designs. iMX8MP EVB variants are using
> Realtek PHYs with the SmartEEE variant. Therefore, the MAC is not able
> to control LPI behavior. Designs based on the EVB design (with the
> Realtek PHY) are not affected. I mean, any bug on the MAC or software
> side will stay invisible.
> 
> Some new designs with special requirements for TSN, for example
> low-latency TI PHYs, are a different story. They promise "Extra low
> latency TX < 90ns, RX < 290ns" and also announce EEE support. These two
> promises are not compatible with each other anyway, and at the same
> time, even if LPI does work, it will most probably fail with the FEC
> driver. I do not know about STMMAC.

What's annoying me is this "we spotted a change in the driver, we're
going to blame that for our problems" attitude that there seems to be
towards phylink.

When I make changes such as when porting a driver to a new facility,
I try to do it with _no_ behavioural change. Yet, people still blame
phylink for their problems. In 99% of cases, it turns out to be
incorrect blame.

This commit description is stating that the conversion of stmmac to
phylink-managed EEE changed the behaviour to default to enabling EEE.
I claim that the driver _already_ defaulted to enabling EEE. So
the commit description is nonsense, and just pulling at straws to
justify the probem.

What I'm asking for is people to _properly_ investigate their problems
rather than just looking at the commit history, and pulling out some
random commit to blame, which invariably seems to be phylink related.

Having one's hard efforts constantly slated in this way is unhelpful.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

