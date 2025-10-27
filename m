Return-Path: <stable+bounces-189982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764CDC0E003
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258D21887896
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022D287511;
	Mon, 27 Oct 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZU8Krlld"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4023EAA7;
	Mon, 27 Oct 2025 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571525; cv=none; b=nUfya5vyR+4y/L/QrZhCsGM/N3gK1LypPcWzHrDqLBpi3a0JetAWk2N7/XdNyQJE7vXLpyV+vo734ajUJGF9sl8nEf6hCUpHeq5cgw7uOGnBenk1KqT0RO/UxvD/oLe+sHvZfI+eOHN+uTrsFwKT4ZaVdRxOc4glct124BQZkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571525; c=relaxed/simple;
	bh=dFkgoufaNMPNcNu22JUe9K6hYmvZv9p3G2j09geRwu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usLj1YNp2LlEjAqq+qQZYJHu9sTXe8UY0ZbpP0fNSky4DGuaedO0Kex5yGOkNyjKu1u02wJ5B6u3XNuzP1SRPeEH6z4VRbi3B4Tr0ZQDB1kgTTOOCmzq060mGwcwLqRbuZexMHH3ZycO5VSb6y2kfEvPHKyHjOBemM7YJCLi3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZU8Krlld; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=6yAaSpVe7rlneuNUMCQd/n4cqFTVCZP+SQLMX8bewCo=; b=ZU
	8KrlldZNgql/8qkwAb9uhuNxVsd5I1H7INbVtNN/MzB1LIReTVz+0ZlxgBninTWx9NT36V/aLO4U3
	WG1xe+i6zNumIz/YFU5KxbMOXwo2Jdkt+qYxAxgXo5jVaFy8IujCr3MAmfCmZieSlG4YGEQFnm88/
	im47h56njpZ39sw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vDNDk-00CCDQ-R4; Mon, 27 Oct 2025 14:25:12 +0100
Date: Mon, 27 Oct 2025 14:25:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
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
Message-ID: <df3aac25-e8e9-46cb-bd92-637822665080@lunn.ch>
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
 <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>

On Mon, Oct 27, 2025 at 01:57:48PM +0100, Emanuele Ghidoli wrote:
> 
> 
> On 27/10/2025 00:45, Andrew Lunn wrote:
> >> Since the introduction of phylink-managed EEE support in the stmmac driver,
> >> EEE is now enabled by default, leading to issues on systems using the
> >> DP83867 PHY.
> > 
> > Did you do a bisect to prove this?
> Yes, I have done a bisect and the commit that introduced the behavior on our
> board is 4218647d4556 ("net: stmmac: convert to phylink managed EEE support").
> 
> > 
> >> Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
> > 
> > What has this Fixes: tag got to do with phylink?
> I think that the phylink commit is just enabling by default the EEE support,
> and my commit is not really fixing that. It is why I didn't put a Fixes: tag
> pointing to that.
> 
> I’ve tried to trace the behavior, but it’s quite complex. From my testing, I
> can summarize the situation as follows:
> 
> - ethtool, after that patch, returns:
> ethtool --show-eee end0
> EEE settings for end0:
>         EEE status: enabled - active
>         Tx LPI: 1000000 (us)
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
> - before that patch returns, after boot:
> EEE settings for end0:
>         EEE status: disabled
>         Tx LPI: disabled
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  Not reported
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
> - Enabling EEE manually using ethtool, triggers the problem too (and ethtool
> -show-eee report eee status enabled):
> ethtool --set-eee end0 eee on tx-lpi on
> ethtool --show-eee end0
> EEE settings for end0:
>         EEE status: enabled - active
>         Tx LPI: 1000000 (us)
>         Supported EEE link modes:  100baseT/Full
>                                    1000baseT/Full
>         Advertised EEE link modes:  100baseT/Full
>                                     1000baseT/Full
>         Link partner advertised EEE link modes:  100baseT/Full
>                                                  1000baseT/Full
> 
> I understand Russell point of view but from my point of view EEE is now
> enabled by default, and before it wasn't, at least on my setup.

We like to try to understand what is going on, and give accurate
descriptions. You have given us important information here, which at
minimum should go into the commit message, but more likely, it will
help lead us to the correct fix.

So, two things here. You say:

> I think that the phylink commit is just enabling by default the EEE support,

That needs confirming, because you are blaming the conversion to
phylink, not that phylink now enabled EEE by default. Russell also
tries to avoid behaviour change, which this clearly is. We want a
better understanding what caused this behaviour change.

Also:

> - Enabling EEE manually using ethtool, triggers the problem too (and ethtool
> -show-eee report eee status enabled):

This indicates EEE has always been broken. This brokenness has been
somewhat hidden in the past, and it is the change in behaviour in
phylink which exposed this brokenness. A commit message using these
words would be much more factually correct, and it would also fit with
the Fixes: tag you used.

So, please work with Russell. I see two things which would be good to
understand before a new version of the patch is submitted:

What cause the behaviour change such that EEE is now enabled? Was it
deliberate? Should something be change to revert that behaviour
change?

Given that EEE has always been broken, do we understand it
sufficiently to say it is not fixable? Is there an errata? Are we sure
it is the PHY and not the MAC which is broken?

	Andrew

