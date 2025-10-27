Return-Path: <stable+bounces-189991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A5BC0E420
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67D514F9725
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653873081C5;
	Mon, 27 Oct 2025 13:57:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F8306D54
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573462; cv=none; b=COjqXFKLBWPSydTvojR2qb+3wVR0m0yYPkkeGramoizLS5czFbMRDkcrxhjS+0w1iQu8FKjiJexjdnf1GvD/yXxqbgRhJHVW+IXDeWdWaqubGLwJfLr0w+0FDtTOcrIwXrNghay+b+KOSYMYjvRKGk2xmQK6obKbSK9IE0CUY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573462; c=relaxed/simple;
	bh=s5ydlXE4nNlwua1OJy3Gc8lsdx7wWBSAUSvBSEnAlgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5LOAZtnKbkyy1YMALt+tcm36Rp4/2UyW5pdr0BSCiVQCW3OHfCysChYWgT51J/457Ep4loth9kYy/1/RMlZ80G8JZPwwcu9HEuWsg5SeT3BbWMxbR0XnEdDQNVIhQxcINg9hkCWs1/EoQaAy3+ZA/CD5eP0CCZkANSh4QsJv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vDNiw-0003CX-Tf; Mon, 27 Oct 2025 14:57:26 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vDNiv-005iVn-2K;
	Mon, 27 Oct 2025 14:57:25 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vDNiv-003COV-1v;
	Mon, 27 Oct 2025 14:57:25 +0100
Date: Mon, 27 Oct 2025 14:57:25 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <aP96RVclYQaoBxSO@pengutronix.de>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
 <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
 <df3aac25-e8e9-46cb-bd92-637822665080@lunn.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df3aac25-e8e9-46cb-bd92-637822665080@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

On Mon, Oct 27, 2025 at 02:25:12PM +0100, Andrew Lunn wrote:
> On Mon, Oct 27, 2025 at 01:57:48PM +0100, Emanuele Ghidoli wrote:
> > 
> > 
> > On 27/10/2025 00:45, Andrew Lunn wrote:
> > >> Since the introduction of phylink-managed EEE support in the stmmac driver,
> > >> EEE is now enabled by default, leading to issues on systems using the
> > >> DP83867 PHY.
> > > 
> > > Did you do a bisect to prove this?
> > Yes, I have done a bisect and the commit that introduced the behavior on our
> > board is 4218647d4556 ("net: stmmac: convert to phylink managed EEE support").
> > 
> > > 
> > >> Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
> > > 
> > > What has this Fixes: tag got to do with phylink?
> > I think that the phylink commit is just enabling by default the EEE support,
> > and my commit is not really fixing that. It is why I didn't put a Fixes: tag
> > pointing to that.
> > 
> > I’ve tried to trace the behavior, but it’s quite complex. From my testing, I
> > can summarize the situation as follows:
> > 
> > - ethtool, after that patch, returns:
> > ethtool --show-eee end0
> > EEE settings for end0:
> >         EEE status: enabled - active
> >         Tx LPI: 1000000 (us)
> >         Supported EEE link modes:  100baseT/Full
> >                                    1000baseT/Full
> >         Advertised EEE link modes:  100baseT/Full
> >                                     1000baseT/Full
> >         Link partner advertised EEE link modes:  100baseT/Full
> >                                                  1000baseT/Full
> > - before that patch returns, after boot:
> > EEE settings for end0:
> >         EEE status: disabled
> >         Tx LPI: disabled
> >         Supported EEE link modes:  100baseT/Full
> >                                    1000baseT/Full
> >         Advertised EEE link modes:  Not reported
> >         Link partner advertised EEE link modes:  100baseT/Full
> >                                                  1000baseT/Full
> > - Enabling EEE manually using ethtool, triggers the problem too (and ethtool
> > -show-eee report eee status enabled):
> > ethtool --set-eee end0 eee on tx-lpi on
> > ethtool --show-eee end0
> > EEE settings for end0:
> >         EEE status: enabled - active
> >         Tx LPI: 1000000 (us)
> >         Supported EEE link modes:  100baseT/Full
> >                                    1000baseT/Full
> >         Advertised EEE link modes:  100baseT/Full
> >                                     1000baseT/Full
> >         Link partner advertised EEE link modes:  100baseT/Full
> >                                                  1000baseT/Full
> > 
> > I understand Russell point of view but from my point of view EEE is now
> > enabled by default, and before it wasn't, at least on my setup.
> 
> We like to try to understand what is going on, and give accurate
> descriptions. You have given us important information here, which at
> minimum should go into the commit message, but more likely, it will
> help lead us to the correct fix.
> 
> So, two things here. You say:
> 
> > I think that the phylink commit is just enabling by default the EEE support,
> 
> That needs confirming, because you are blaming the conversion to
> phylink, not that phylink now enabled EEE by default. Russell also
> tries to avoid behaviour change, which this clearly is. We want a
> better understanding what caused this behaviour change.
> 
> Also:
> 
> > - Enabling EEE manually using ethtool, triggers the problem too (and ethtool
> > -show-eee report eee status enabled):
> 
> This indicates EEE has always been broken. This brokenness has been
> somewhat hidden in the past, and it is the change in behaviour in
> phylink which exposed this brokenness. A commit message using these
> words would be much more factually correct, and it would also fit with
> the Fixes: tag you used.
> 
> So, please work with Russell. I see two things which would be good to
> understand before a new version of the patch is submitted:
> 
> What cause the behaviour change such that EEE is now enabled? Was it
> deliberate? Should something be change to revert that behaviour
> change?
> 
> Given that EEE has always been broken, do we understand it
> sufficiently to say it is not fixable? Is there an errata?

None of following TI Gbit PHYs claim EEE support:
dp83867cr/ir  https://www.ti.com/de/lit/gpn/dp83867cr
dp83867e/cs/is  https://www.ti.com/de/lit/gpn/dp83867cs
dp83869hm https://www.ti.com/lit/gpn/dp83869hm

For comparison, TI 100Mbit PHYs list EEE as supported:
dp83826a*  https://www.ti.com/de/lit/gpn/dp83826ae
dp83826i https://www.ti.com/de/lit/gpn/dp83826i

If vendor do not see it as selling point, or it is just broken beyond
repair, there is nothing we can do here. I guess it is ok to sync the
driver with vendors claim.

> Are we sure it is the PHY and not the MAC which is broken?

I personally still do not have suitable reference board for testing.
There are some with Realtek or TI PHYs. It will be good to find board
with iMX8MP + KSZ9131 on both MACs (FEC and STMMAC).
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

