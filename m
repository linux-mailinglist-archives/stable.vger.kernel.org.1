Return-Path: <stable+bounces-160227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26BAF9BB8
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 22:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C5E3A47ED
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 20:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF83246BB4;
	Fri,  4 Jul 2025 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="UXyu7DUn"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511923E336;
	Fri,  4 Jul 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751661335; cv=pass; b=TqyxwNh37IdCLJ3A5K71eDdxcN6R9MbdWjAfdR6sqoRd/u2R/h6lqRIMDaEtKexDGD2Mu1w/ThyH2f6mLh2dg9VzIe1jOFFoVOoL1ftiNkGV/b1sQmoONbbk62S9UCnKuQSN0t3KJhjKigcDBqy4piNfH9WX9zOrKABPjzmsWuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751661335; c=relaxed/simple;
	bh=tGDhA6trtueapCTJZVqL3Ich/6m5S6c3emrgtXjYZfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cI3U65irvEGJWfq7Q2lSC6UKW0eUGybpxFMeiLY4wGSVeVTQYgQ2HIVPUg0LYIp/j5UQ6yby7zKC3S8lGOpYWqCFhbDsojBr8ueSE/DyaPHH4W6XsWWxC5xW17jTfrN/5o+x++nCqu+FhEc0487bUPhxEqIdKuIs2AOOS8TZvMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=UXyu7DUn; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751661307; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KJkC27XZSlJxaKuRavoNposgZnBJRG8I/1U+dz8MTzS0rg/awahbWC4zjYRksq6DZhS6t3TiO60dOnjrh/x1QoA2IDARCQx7oWHFsQrUM3krwPiBmMk+JT6TUkHiLCdc5zl2GEi91BSpV+rnnxNU1dRQC3f/bUco8EcIsVcIq6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751661307; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lWLh7zgOofOdzlksseZPXqSdJOoOzDwsXnYOSGf61Lw=; 
	b=gmgGLA1X3mHt3BnNjhMyJjxQ3dCY7mw9CUdacbXBTazw5OtE7h6Y4z+DKSwWGOMjnDNCjWgsZPIQv+V3+lo+d9HzMn8sFvjPGuKXKemzJBKHxHid3bWqq6QQc1ov2K9XTW8Rc8PSJ0KpA1bs3o63OTHKnJz/wP5T5KrUpNbUHBs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751661307;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=lWLh7zgOofOdzlksseZPXqSdJOoOzDwsXnYOSGf61Lw=;
	b=UXyu7DUn9+jB0s2NqIRNqOjLabqXjO4ZxvwxSU7m8+P0Rhbz8SCh3MWp+ehUNujq
	rlq0nsP/76jAa+s0dc6WtbtVyDzblAPY62wQHhYg3ZYNo0FGVd/up/FxeWv140UqvEe
	l9rxthRt8B9phhiFuLHAqslO6k4ysmNc0wG8XDUk=
Received: by mx.zohomail.com with SMTPS id 1751661305093761.4754666334662;
	Fri, 4 Jul 2025 13:35:05 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 189271803D0; Fri, 04 Jul 2025 22:35:00 +0200 (CEST)
Date: Fri, 4 Jul 2025 22:35:00 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH net] net: phy: realtek: Reset after clock enable
Message-ID: <5xjp2k3b4rggbmjgchg6vlusotoqoqmxi54zzer3ioxv274vtx@22tzjjcs7s3z>
References: <20250704-phy-realtek-clock-fix-v1-1-63b33d204537@kernel.org>
 <0310186d-dfc5-406f-8cd1-c393a7c620e8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rh6zjux5atjchmnj"
Content-Disposition: inline
In-Reply-To: <0310186d-dfc5-406f-8cd1-c393a7c620e8@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/251.649.55
X-ZohoMailClient: External


--rh6zjux5atjchmnj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net] net: phy: realtek: Reset after clock enable
MIME-Version: 1.0

Hi,

On Fri, Jul 04, 2025 at 10:18:29PM +0200, Heiner Kallweit wrote:
> On 04.07.2025 19:48, Sebastian Reichel wrote:
> > On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
> > stability (e.g. link loss, or not capable of transceiving packages)
> > after new board revisions switched from a dedicated crystal to providing
> > the 25 MHz PHY input clock from the SoC instead.
> >=20
> > This board is using a RTL8211F PHY, which is connected to an always-on
> > regulator. Unfortunately the datasheet does not explicitly mention the
> > power-up sequence regarding the clock, but it seems to assume that the
> > clock is always-on (i.e. dedicated crystal).
> >=20
> > By doing an explicit reset after enabling the clock, the issue on the
> > boards could no longer be observed.
> >=20
> Is the SoC clock always on after boot? Or may it be disabled e.g.
> during system suspend? Then you would have to do the PHY reset also
> on resume from suspend.

Upstream kernel does not yet support suspend/resume on Rockchip RK3576
(the SoC used by the ROCK 4D) and I missed, that the clock is disabled
in the PHY's suspend routine.

Detlev: You added the initial clock support to the driver. If I add
the reset in the resume routine, can you do regression testing on
the board you originally added the clock handling for?

Greetings,

-- Sebastian

> > Cc: stable@vger.kernel.org
> > Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY cloc=
k")
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  drivers/net/phy/realtek/realtek_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/r=
ealtek/realtek_main.c
> > index c3dcb62574303374666b46a454cd4e10de455d24..3a783f0c3b4f2a4f6aa63a1=
6ad309e3471b0932a 100644
> > --- a/drivers/net/phy/realtek/realtek_main.c
> > +++ b/drivers/net/phy/realtek/realtek_main.c
> > @@ -231,6 +231,10 @@ static int rtl821x_probe(struct phy_device *phydev)
> >  		return dev_err_probe(dev, PTR_ERR(priv->clk),
> >  				     "failed to get phy clock\n");
> > =20
> > +	/* enabling the clock might produce glitches, so hard-reset the PHY */
> > +	phy_device_reset(phydev, 1);
> > +	phy_device_reset(phydev, 0);
> > +
> >  	ret =3D phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
> >  	if (ret < 0)
> >  		return ret;
> >=20
> > ---
> > base-commit: 4c06e63b92038fadb566b652ec3ec04e228931e8
> > change-id: 20250704-phy-realtek-clock-fix-6cd393e8cb2a
> >=20
> > Best regards,
>=20

--rh6zjux5atjchmnj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmhoOvAACgkQ2O7X88g7
+posEA//SXz6ukkQ+k4ZKaQKCxpIXW1tYqCWcpKkffl6p0MR1HXt+n/V04xcAXlH
2CSZyrXg7n54anYOxhLQ8coMyTPGRe4sA01z0ggfj1ChmAF4DxmE+yDjyUHdL6wW
nUlSd9RWwrpfcDfDTab9mUfYUVq9b/FKG8REQa2RfA95/MXMmz7ZhtlmOca6xBq3
3Zdylq/jzm20XoV9vDHysI2jIArDMxk+wFN1Fxw0DBpWREhEG7Cb4ypi2qP7En9d
NnJ1oY29YEkMDXkrWal4gSgvALnI8QmiLNEyaSzuac025P5aS20mc7fc/48GUPFj
+diVY3m4lnG277cJ4by44AYIv8j3qmssFkAiKk+Mt6RohtPmtbMmmf1ayPRoXq38
rua/kR+ut//QS2wJoqqYQ0ng64MnkjW0aorhkcPQbkqeKWzdeyP7ZN/vPPsPLrqe
Dcr4dIA81KsjWLFikYT+r9E1eX4xZibYpRiaHtkX2fwcqF4v2lDKuGXvHlZ5xPnt
5MAEsgQ1g75DaDkttxiuybvVXcHyZp1W0fdKgo7tJss3+VA9oB/RJrBYFg/Yc9iW
lThjwpml4hRmU7rAF4XVu8rHKpxF0EnoMuT1kOSoIUKHhikJ7Tu8CcXWB5lVmQ9u
BYhzGseXFsQfpciDbXQ+1oW5yVOXFqA9Be0IOHQNI/QOAoFamyU=
=bDSD
-----END PGP SIGNATURE-----

--rh6zjux5atjchmnj--

