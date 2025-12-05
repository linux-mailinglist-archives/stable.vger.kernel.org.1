Return-Path: <stable+bounces-200133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 119ACCA6DEF
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 10:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A87A731923F7
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F60313282;
	Fri,  5 Dec 2025 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qE6foBF7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAB2F9DAB;
	Fri,  5 Dec 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925628; cv=none; b=GByRQcIfUlbGliayuXrDeVdMIPOdMlYk6nKH+AcikKGvO1C9VsoGzdMsJ8hRE4dwlyaSzvqkwA8TA6cCj7T3UE3AcBgKansRgk1lj4uPt0ZtTYwcWAfsDhN8mRIP1aOPEaQzBenVBbeQwkI4Q68rhExcd3CpEg3kapU268n/JGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925628; c=relaxed/simple;
	bh=Up+JpXnF6bqnElM5UaXR1PHTj+UdVqX+sMq7pwyZg+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhH/3Kzyg4tvcNMj8hJsIIrXUCOZNKWCqcgGAGNrXsbmW5eE9ywaFOka2Q3EKV+hCQRoJx/+7xStA5lvmaP4Nxg2TjDHl7PpSz9coPLP6JAxm2/tNHglqAZvp7Y/3lfCnA3Vmr9cAHZx0qj/JYi3iR8cpql2vOrI/QpkiqbxbZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qE6foBF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B303C4CEF1;
	Fri,  5 Dec 2025 09:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764925623;
	bh=Up+JpXnF6bqnElM5UaXR1PHTj+UdVqX+sMq7pwyZg+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qE6foBF7gguZ4ppJs+3tn1QfSJpLUh8tqNXrC6zLLhjiy1vAVnhlDrpS5qM6s5kWV
	 d6shksSWPrp8ASPrS8VqXoHEOCvJbewldS/zKkkACqt27saME8NzaRKIZe/5Ro8H/s
	 FNn4f61qKMgDVpj+CbCgv2bUP/32Zpm1HQKU2cNr/Gcd8gf6D1kFxjAu/Y5IDz0PgM
	 vgWfP1BP8u+if++SufznESMpSz59A9ZZ2liYvePn4tndu1GmXNhUHHIvOPd7DT9JGU
	 ENK1tTxhgSGaa7g1jOPHYvdk+8+WiBuhrCurcW5ncytpGZqTloopb0X5RtuHkbT/WG
	 cQ0iEmKMZAZKw==
Date: Fri, 5 Dec 2025 10:07:00 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, Francesco Dolcini <francesco@dolcini.it>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Philippe Schenker <philippe.schenker@impulsing.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, =?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: ignore PLL_UNLOCK errors
Message-ID: <20251205-courageous-tortoise-of-abracadabra-2efeee@houat>
References: <20251127-drm-ti-sn65dsi83-ignore-pll-unlock-v1-1-8a03fdf562e9@bootlin.com>
 <cd607656-90d3-4821-98ea-4dad48288fc9@gmail.com>
 <DEORF6XCJEOG.3BGTKVL2QFQKN@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="v662r6mq73hc7gsk"
Content-Disposition: inline
In-Reply-To: <DEORF6XCJEOG.3BGTKVL2QFQKN@bootlin.com>


--v662r6mq73hc7gsk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi83: ignore PLL_UNLOCK errors
MIME-Version: 1.0

On Wed, Dec 03, 2025 at 06:32:47PM +0100, Luca Ceresoli wrote:
> On Tue Dec 2, 2025 at 12:19 PM CET, Emanuele Ghidoli wrote:
> >
> >
> > On 27/11/2025 09:42, Luca Ceresoli wrote:
> >> On hardware based on Toradex Verdin AM62 the recovery mechanism added =
by
> >> commit ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery
> >> mechanism") has been reported [0] to make the display turn on and off =
and
> >> and the kernel logging "Unexpected link status 0x01".
> >>
> >> According to the report, the error recovery mechanism is triggered by =
the
> >> PLL_UNLOCK error going active. Analysis suggested the board is unable =
to
> >> provide the correct DSI clock neede by the SN65DSI84, to which the TI
> >> SN65DSI84 reacts by raising the PLL_UNLOCK, while the display still wo=
rks
> >> apparently without issues.
> >>
> >> On other hardware, where all the clocks are within the components
> >> specifications, the PLL_UNLOCK bit does not trigger while the display =
is in
> >> normal use. It can trigger for e.g. electromagnetic interference, whic=
h is
> >> a transient event and exactly the reason why the error recovery mechan=
ism
> >> has been implemented.
> >>
> >> Idelly the PLL_UNLOCK bit could be ignored when working out of
> >> specification, but this requires to detect in software whether it trig=
gers
> >> because the device is working out of specification but visually correc=
tly
> >> for the user or for good reasons (e.g. EMI, or even because working ou=
t of
> >> specifications but compromising the visual output).
> >>
> >> The ongoing analysis as of this writing [1][2] has not yet found a way=
 for
> >> the driver to discriminate among the two cases. So as a temporary meas=
ure
> >> mask the PLL_UNLOCK error bit unconditionally.
> >>
> >> [0] https://lore.kernel.org/r/bhkn6hley4xrol5o3ytn343h4unkwsr26p6s6ltc=
wexnrsjsdx@mgkdf6ztow42
> >> [1] https://lore.kernel.org/all/b71e941c-fc8a-4ac1-9407-0fe7df73b412@g=
mail.com/
> >> [2] https://lore.kernel.org/all/20251125103900.31750-1-francesco@dolci=
ni.it/
> >>
> >> Closes: https://lore.kernel.org/r/bhkn6hley4xrol5o3ytn343h4unkwsr26p6s=
6ltcwexnrsjsdx@mgkdf6ztow42
> >> Cc: stable@vger.kernel.org # 6.15+
> >> Co-developed-by: Herv=E9 Codina <herve.codina@bootlin.com>
> >> Signed-off-by: Herv=E9 Codina <herve.codina@bootlin.com>
> >> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> >> ---
> >> Francesco, Emanuele, Jo=E3o: can you please apply this patch and report
> >> whether the display on the affected boards gets back to working as bef=
ore?
> >>
> >> Cc: Jo=E3o Paulo Gon=E7alves <jpaulo.silvagoncalves@gmail.com>
> >> Cc: Francesco Dolcini <francesco@dolcini.it>
> >> Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
> >> ---
> >>  drivers/gpu/drm/bridge/ti-sn65dsi83.c | 11 +++++++++--
> >>  1 file changed, 9 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/b=
ridge/ti-sn65dsi83.c
> >> index 033c44326552..fffb47b62f43 100644
> >> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> >> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> >> @@ -429,7 +429,14 @@ static void sn65dsi83_handle_errors(struct sn65ds=
i83 *ctx)
> >>  	 */
> >>
> >>  	ret =3D regmap_read(ctx->regmap, REG_IRQ_STAT, &irq_stat);
> >> -	if (ret || irq_stat) {
> >> +
> >> +	/*
> >> +	 * Some hardware (Toradex Verdin AM62) is known to report the
> >> +	 * PLL_UNLOCK error interrupt while working without visible
> >> +	 * problems. In lack of a reliable way to discriminate such cases
> >> +	 * from user-visible PLL_UNLOCK cases, ignore that bit entirely.
> >> +	 */
> >> +	if (ret || irq_stat & ~REG_IRQ_STAT_CHA_PLL_UNLOCK) {
> >>  		/*
> >>  		 * IRQ acknowledged is not always possible (the bridge can be in
> >>  		 * a state where it doesn't answer anymore). To prevent an
> >> @@ -654,7 +661,7 @@ static void sn65dsi83_atomic_enable(struct drm_bri=
dge *bridge,
> >>  	if (ctx->irq) {
> >>  		/* Enable irq to detect errors */
> >>  		regmap_write(ctx->regmap, REG_IRQ_GLOBAL, REG_IRQ_GLOBAL_IRQ_EN);
> >> -		regmap_write(ctx->regmap, REG_IRQ_EN, 0xff);
> >> +		regmap_write(ctx->regmap, REG_IRQ_EN, 0xff & ~REG_IRQ_EN_CHA_PLL_UN=
LOCK_EN);
> >>  	} else {
> >>  		/* Use the polling task */
> >>  		sn65dsi83_monitor_start(ctx);
> >>
> >> ---
> >> base-commit: c884ee70b15a8d63184d7c1e02eba99676a6fcf7
> >> change-id: 20251126-drm-ti-sn65dsi83-ignore-pll-unlock-4a28aa29eb5c
> >>
> >> Best regards,
>=20
> Thanks for testing!
>=20
> We'll still need a R-by from a maintainer, after that this patch can be a=
pplied.
>=20
> > I would suggest a couple of tags, thanks.
> > Emanuele
> >
> > Fixes: ad5c6ecef27e ("drm: bridge: ti-sn65dsi83: Add error recovery mec=
hanism")
>=20
> I'm not sure about this one. There is no known bug in that commit, right?
> It's rather exposing a pre-existing issue. I thought about adding it for
> stable branches pickup, but the 'Cc: stable...v6.15+' line is for that.

Sigh. We had that discussion already. Wouldn't you consider "the display
doesn't work" a bug on any platform? A real world device wasn't behaving
the way the driver expected it to be. The root cause of it doesn't
really matter: it was a bug.

And whether it's technically correct or not isn't relevant: we only care
about what actually happens, not what the datasheet is saying.
>=20
> So apart from blaming someone I don't see much point.
>=20
> That said, if there is a valid reason I'm not seeing for the Fixes: line,
> I'll be OK in adding it while applying.

It's not about blaming someone, it's about tracking that there was a
regression, and it got fixed. Who's to blame is not relevant either, and
I don't think anyone blamed anyone in that thread.

Anyway, patch applied.

Maxime

--v662r6mq73hc7gsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaTKgswAKCRAnX84Zoj2+
diSkAYCmmn/2I4sqcz/3/bVyNEbC/4O+JjBqXWlokK1+dcdI36gwxH5h1C4iKzWh
Ui+6ElcBfi8I3cEvML0Qsq8PLiCMjIjk7qOHVwwr5NHAvMO/yPEtNRgAU+SBEEOK
FVafVBLVRg==
=eFIm
-----END PGP SIGNATURE-----

--v662r6mq73hc7gsk--

