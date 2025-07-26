Return-Path: <stable+bounces-164820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3350EB1288E
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 04:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D259560F42
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADB91D90AD;
	Sat, 26 Jul 2025 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="QWeE2t1Y"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8410F1;
	Sat, 26 Jul 2025 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753496528; cv=pass; b=qGkmJMF/Sfd60fVZrDIaJqmooMVOPuwVPY5R5mwuEWag5BUVVWWuZ0SlzqYZ81FIkJmsTnXyn4TXpjhGCkQ0T0QQzuRRStY1sqNHuHpG62eauXD4mkNY+4rvRdsFxqy6MlOYnSh+EcrMfcGlD4xMp5vqUNFq/JV8ZjKP3e0zFaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753496528; c=relaxed/simple;
	bh=w/exOykY09ODRkp6mSt/GqUYuJ92eI3HMcEygH9M7TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwTw4DI0PI4OJ5IRBk1YQZ7zRnv/FOrqrXo31JtZnkayODQ5bq8hFIOk4a1bycf5Zhg216dQsyk/jzz5CZBGKCioXdq4H9W+Sh4139PsXEZqHbQzFvnCYYq76Gh8rxoDwNbPe5Y133o0wDjd+TAVtWacdj3ld0pnZLKy/tXk/HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=QWeE2t1Y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753496491; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S/C1svp9Uz0DEHvX3wCb6sML2Wec87Y5tonvePk5HSeYAUTetDm12tKEczcJ87WhQo7v5zHkHpseBARkKrla8xWftEJcCv32Dh1uJkZgPUUzbkRUDIA/DmkPH8OoGabfKrueKmTxyvbF7T0R4hX5y/Op21MjLFXRtH+644m7mrA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753496491; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E5geGhLxilB8EImEDsG8WfJfVvx36ko5rAGuOaL3tE0=; 
	b=VSsUn+1NoELlC8hE6UbPquhCwxZBM0lJ9Ugm++KtiVOD6TOfsZLZxmBZfcCuY8KQmFvHx1Iya6OGIIHItnHC6PRDhaAm+QPzTVqoplAGaGoekF1v360bD8VtANldbVi2pe1O6oKXIk+tkClezqhz2qjf+2/4AfV1S4DEC9HJG/s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753496491;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=E5geGhLxilB8EImEDsG8WfJfVvx36ko5rAGuOaL3tE0=;
	b=QWeE2t1YPBQT/QZZKfYCUyiRzBea8M52U0b86SztmIZOQg8ZqBfRoq8VPyjRFvgw
	CkcfXKMlJdBYA0sCfIi38xOANfLkNTTFIxtC10BpV4rFdHEn+ShUqtG3fOjeM/jcJki
	m4Q4xU5UzfCOd8unCjFZkIRHBSbk1AzlZZgUOSIU=
Received: by mx.zohomail.com with SMTPS id 1753496487794534.9193994531219;
	Fri, 25 Jul 2025 19:21:27 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id AE9D4183CFD; Sat, 26 Jul 2025 04:21:22 +0200 (CEST)
Date: Sat, 26 Jul 2025 04:21:22 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Detlev Casanova <detlev.casanova@collabora.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: realtek: Reset after clock enable
Message-ID: <y3xhsgbcykfjmz6hjtjzfytb66bm2fomr7cesau45xcuxuin7n@jiryheq3qyvs>
References: <20250724-phy-realtek-clock-fix-v2-1-ae53e341afb7@kernel.org>
 <aIJkrh9_4o6flHPE@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x6c424pkvj3rxid4"
Content-Disposition: inline
In-Reply-To: <aIJkrh9_4o6flHPE@shell.armlinux.org.uk>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/253.489.26
X-ZohoMailClient: External


--x6c424pkvj3rxid4
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net v2] net: phy: realtek: Reset after clock enable
MIME-Version: 1.0

Hi,

On Thu, Jul 24, 2025 at 05:51:58PM +0100, Russell King (Oracle) wrote:
> On Thu, Jul 24, 2025 at 04:39:42PM +0200, Sebastian Reichel wrote:
> > On Radxa ROCK 4D boards we are seeing some issues with PHY detection and
> > stability (e.g. link loss or not capable of transceiving packages) after
> > new board revisions switched from a dedicated crystal to providing the
> > 25 MHz PHY input clock from the SoC instead.
> >=20
> > This board is using a RTL8211F PHY, which is connected to an always-on
> > regulator. Unfortunately the datasheet does not explicitly mention the
> > power-up sequence regarding the clock, but it seems to assume that the
> > clock is always-on (i.e. dedicated crystal).
> >=20
> > By doing an explicit reset after enabling the clock, the issue on the
> > boards could no longer be observed.
> >=20
> > Note, that the RK3576 SoC used by the ROCK 4D board does not yet
> > support system level PM, so the resume path has not been tested.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: 7300c9b574cc ("net: phy: realtek: Add optional external PHY cloc=
k")
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > Changes in v2:
> > - Switch to PHY_RST_AFTER_CLK_EN + phy_reset_after_clk_enable(); the
> >   API is so far only used by the freescale/NXP MAC driver and does
> >   not seem to be written for usage from within the PHY driver, but
> >   I also don't see a good reason not to use it.
> > - Also reset after re-enabling the clock in rtl821x_resume()
> > - Link to v1: https://lore.kernel.org/r/20250704-phy-realtek-clock-fix-=
v1-1-63b33d204537@kernel.org
> > ---
> >  drivers/net/phy/realtek/realtek_main.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/r=
ealtek/realtek_main.c
> > index c3dcb62574303374666b46a454cd4e10de455d24..cf128af0ec0c778262d70d6=
dc4524d06cbfccf1f 100644
> > --- a/drivers/net/phy/realtek/realtek_main.c
> > +++ b/drivers/net/phy/realtek/realtek_main.c
> > @@ -230,6 +230,7 @@ static int rtl821x_probe(struct phy_device *phydev)
> >  	if (IS_ERR(priv->clk))
> >  		return dev_err_probe(dev, PTR_ERR(priv->clk),
> >  				     "failed to get phy clock\n");
> > +	phy_reset_after_clk_enable(phydev);
>=20
> Should this depend on priv->clk existing?
>=20
> > =20
> >  	ret =3D phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1);
> >  	if (ret < 0)
> > @@ -627,8 +628,10 @@ static int rtl821x_resume(struct phy_device *phyde=
v)
> >  	struct rtl821x_priv *priv =3D phydev->priv;
> >  	int ret;
> > =20
> > -	if (!phydev->wol_enabled)
> > +	if (!phydev->wol_enabled) {
> >  		clk_prepare_enable(priv->clk);
> > +		phy_reset_after_clk_enable(phydev);
>=20
> Should this depend on priv->clk existing?
>=20
> I'm thinking about platforms such as Jetson Xavier NX, which I
> believe uses a crystal, and doesn't appear to suffer from any
> problems.

Doing the extra reset should not hurt, but I can add it to speed up
PHY initialization on systems with an always-on clock source. I will
send a PATCHv3.

Greetings,

-- Sebastian

--x6c424pkvj3rxid4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmiEO58ACgkQ2O7X88g7
+pr0zw//bcygYDebUo58zr5L5SQVv1EYn5BR4Fg6KwMB/afxOhi3SXYRb0YnmPoV
Bxdv8pfcJ4ZLAMc6VMnWr64iNWX6WhMQ5xQcKfM579MIQb4yVEjcPs6Dv9k/5qC1
ipctCGfrFVpj12DZhCDJFYzONQNC8VZxUmDWQbjFJPRezRB7DdKfTWI+PQDwriER
RyXRYus5YeHHTOjdallzdAl6hwRIxiPXuAfqiSDJ+e4XY2wRSnfeoYGA82cgKEX2
9wjOi32ewfGVLK5ZRxcepi8G5bgmuxWrjEIZKSpFxp1mTIDvp9/SDya0ioe7iVG1
53mdZPwYhcuE0pR5pYCoMaQ3sWzqJ4ZB5hx3SuYcT7LCiMI2bwuwjOnHPux4E22f
9RHAqreTMzezo6OqZ47cc9lBp8xJioQV6pmFBJNgldlN0A5Q2hg3ha11w7thbf+1
a1rOznelb2dx5semK8pU5Y/zMWA5tlE3ujNMjiP2yqBmaHAtYW5gfgqbIeuzYAML
BfykTY1wFzIhltgUHZH2bdNFhOD2VjlWuGHtfH0ZKnuTfyAatsKC6Kj8ndZGI2gi
XKTuawOSUH25BNaXERVtPZ1ESrxI4mJpD0kKihxb2Wr3OmfEx3oB3TR3+8ONCrT3
ti66dcRtJvLqOeETVHnrGU6Oz1+iGXva4SFs0GKnFL+B0ufG4UM=
=+BML
-----END PGP SIGNATURE-----

--x6c424pkvj3rxid4--

