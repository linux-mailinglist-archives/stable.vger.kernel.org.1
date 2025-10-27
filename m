Return-Path: <stable+bounces-190000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B114C0E7A4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7712188DE87
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C007830ACFB;
	Mon, 27 Oct 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="hSmKKWD5"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB1023E355;
	Mon, 27 Oct 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575739; cv=none; b=Fsfs8GHn++iNyjabgLVaCqb+7iU6tR3GsWeZXIp+bVPZNhT6nGWdQsFFtU4pQIKEbRYiddFmvb5kPnlNLS7OyG16OwdmOMS3+f9tb/CRSjIOhQtvLCSVqQX43rfc0EjDJn4bXf+yBWs3Ul3kg1HxfuIOJujywQ9thaZDmbervg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575739; c=relaxed/simple;
	bh=r5CubwPSgel9Kbfug9bRhlGBAU1MiZJ3lZEaLzdKfjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+/86Q0YGHTLPmv4k8HsjIwBwlRu7PIHkqpV63LuDOLL4PCwW8fAKSXc7naYGml/XkVR4MdMKWLKHtSkW0VR2IRwOx6eNDk6MIVCdiP+kqwTZXuDS1U51bk2KJ5TYg9vdkqMRMtoIv7VMz2TIS3qldNu8lMrKvt/vIOBz6kFHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=hSmKKWD5; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 5844321E50;
	Mon, 27 Oct 2025 15:35:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1761575726;
	bh=8GGEgENZ1Vbe/2oA2ExOI5P6StTcMkX9+lb/DIzzw+k=; h=From:To:Subject;
	b=hSmKKWD5RlUsXX84DlnGt9tQK3iinQHeJKVdKvorRGtoHbNNKnsxYszN0rIZeqHDm
	 59UDEeDMSQK9KFlAXGVwV/G2fTStj9zYorqDxRw7G4YRkCmP6jEm8smZB+Shs0jvOK
	 +T3wA10zIHWZiGFf3iFcT55QfkSFMNHLReAZFOyIcUSK1JAXLC9HNO8/frDxKfa3kB
	 NehBY0neZ/6gCc0wWZH0Ygf6aE8Wcold9fUk+VlvIJsX9woFLf5+OyUi1HrGmI/y2x
	 Rz8SzYnNctjv2T5Z9PPSbAeUh0ICNCPc4H/n2C/IeR+U5dxWUR3FcKAP1rk8GX/R4G
	 PK7bG/Wf8J/Vg==
Date: Mon, 27 Oct 2025 15:35:22 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
Message-ID: <20251027143522.GA57409@francesco-nb>
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

Hello Andrew and Russel,

On Mon, Oct 27, 2025 at 02:25:12PM +0100, Andrew Lunn wrote:
> On Mon, Oct 27, 2025 at 01:57:48PM +0100, Emanuele Ghidoli wrote:
> > On 27/10/2025 00:45, Andrew Lunn wrote:
> > >> Since the introduction of phylink-managed EEE support in the stmmac driver,
> > >> EEE is now enabled by default, leading to issues on systems using the
> > >> DP83867 PHY.
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
> sufficiently to say it is not fixable? Is there an errata? Are we sure
> it is the PHY and not the MAC which is broken?

I was talking together with Emanuele on this topic and we are confused
on how to proceed.

From the various comments and tests in this thread, to me the actual
code change is correct, the dp83867 does not support EEE and we have to
explicitly disable it in the dp83867 driver.

As of now we do not have a clear shared understanding on what is going
on in the stmmac driver. And the commit message is not correct on this
regard.

This patch is already merged [1] in netdev tree, should we send a series
reverting this commit and another commit with just the same change and a
different commit message? 

In parallel, unrelated to the dp83867 topic, Emanuele is trying to help
figuring out why the actual behavior of the stmmac changed after Russell
refactoring. And it's clear that this change in behavior is not expected.

[1] commit 84a905290cb4 ("net: phy: dp83867: Disable EEE support as not implemented")

Francesco


