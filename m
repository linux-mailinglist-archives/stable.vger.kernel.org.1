Return-Path: <stable+bounces-222650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNtsCarGpWnEFgAAu9opvQ
	(envelope-from <stable+bounces-222650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:19:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A201DDB61
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 18:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89C62304B4F3
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D2A426D06;
	Mon,  2 Mar 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCTIOQKn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647C305057;
	Mon,  2 Mar 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471625; cv=none; b=cskXGOwdY8aMnMaaOgzi4dckOgcuFD0DiGl42taTjJj0C4YAty8ahrrDqs0NFb9Nb7JDFjuXnYs7E3tdeN57thH2z6pft40iUDwmWuVIwgQ2jozESOsGLCy5ol/1IyHp0AhPP7dMdLO/RvljsRN0FYyBBhZDhqdrltfhb8cHMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471625; c=relaxed/simple;
	bh=QKdJaOSGIzBxcUx9X/A3nsrNbzD/gVBg/TDbhNKK6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lao4/t5doDDnfKbftEZVIcRkMarIcCbtGMFmYijiDgHxmqnBvZLKarirUvYfVPP3DtpeCuk0Q6/iTBvKWwWOnBOLH7M4gyIlStfFWV6DHcX5vKr4ujoHsTcmhBvA7j8ogF/o35oGlXVoAZ75/I06qdChg2c0KANEWjCijWFKoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCTIOQKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB3C19423;
	Mon,  2 Mar 2026 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772471624;
	bh=QKdJaOSGIzBxcUx9X/A3nsrNbzD/gVBg/TDbhNKK6o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KCTIOQKnzO2RfPySqjw6WycKiSw28+Ko+GcRT/ug82GCGeGiyZZqM4f4Dvj+7DcAW
	 SEbASDyrtCkczNgglbOuZkltfaV2WKOOn0XhRNV7Yku3ZExd3QQgzmF7h4LXNpD5iY
	 YOT+3picLmyKFjAxzeQTKILiXDaTlb83OiHhLzw7FkEc1AGBsd6Y/Wdml0z7A9c+1J
	 oh4TRM3nQHhbfDFGPKwNyIikBPSbVilJbR8xgXxa0Dtrc/+9mp0Ktb424lRfS3CveA
	 yPqLYnW+mduXMWIzgTF1awwAyMjPPeptYqpIuk2YjrkeuLCytRg2FsXUrIgCQLSpYU
	 4O7vQrQjhhU/g==
Date: Mon, 2 Mar 2026 17:13:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Brian Masney <bmasney@redhat.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-clk@vger.kernel.org,
	stable@vger.kernel.org,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] clk: microchip: mpfs-ccc: fix out of bounds access
 during output registration
Message-ID: <20260302-snort-unpicked-a15d25b4d52b@spud>
References: <20260224-briskly-scholar-294d13464721@wendy>
 <aZ9-NWiX4wMH3Ay6@redhat.com>
 <20260225-cache-nebulizer-2f3669074fa4@spud>
 <20260225-thrive-endless-3168e0b0f916@spud>
 <aaBpBYVtt_VhuJws@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BSpNHjmm58g1yjQa"
Content-Disposition: inline
In-Reply-To: <aaBpBYVtt_VhuJws@redhat.com>
X-Rspamd-Queue-Id: 25A201DDB61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-222650-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,tuxon.dev:email]
X-Rspamd-Action: no action


--BSpNHjmm58g1yjQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 10:38:45AM -0500, Brian Masney wrote:
> On Wed, Feb 25, 2026 at 11:24:59PM +0000, Conor Dooley wrote:
> > On Wed, Feb 25, 2026 at 11:14:47PM +0000, Conor Dooley wrote:
> > > On Wed, Feb 25, 2026 at 05:56:53PM -0500, Brian Masney wrote:
> > > > Hi Conor,
> > > >=20
> > > > On Tue, Feb 24, 2026 at 09:35:25AM +0000, Conor Dooley wrote:
> > > > > UBSAN reported an out of bounds access during registration of the=
 last
> > > > > two outputs. This out of bounds access occurs because space is on=
ly
> > > > > allocated in the hws array for two PLLs and the four output divid=
ers
> > > > > that each has, but the defined IDs contain two DLLS and their two
> > > > > outputs each, which are not supported by the driver. The ID order=
 is
> > > > > PLLs -> DLLs -> PLL outputs -> DLL outputs. Decrement the PLL out=
put IDs
> > > > > by two while adding them to the array to avoid the problem.
> > > > >=20
> > > > > Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric cl=
ock support")
> > > > > CC: stable@vger.kernel.org
> > > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > ---
> > > > > CC: Conor Dooley <conor.dooley@microchip.com>
> > > > > CC: Daire McNamara <daire.mcnamara@microchip.com>
> > > > > CC: Michael Turquette <mturquette@baylibre.com>
> > > > > CC: Stephen Boyd <sboyd@kernel.org>
> > > > > CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > > > > CC: linux-riscv@lists.infradead.org
> > > > > CC: linux-clk@vger.kernel.org
> > > > > CC: linux-kernel@vger.kernel.org
> > > > > ---
> > > > >  drivers/clk/microchip/clk-mpfs-ccc.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/m=
icrochip/clk-mpfs-ccc.c
> > > > > index 3a3ea2d142f8a..54cfbb8be8ab5 100644
> > > > > --- a/drivers/clk/microchip/clk-mpfs-ccc.c
> > > > > +++ b/drivers/clk/microchip/clk-mpfs-ccc.c
> > > > > @@ -178,7 +178,7 @@ static int mpfs_ccc_register_outputs(struct d=
evice *dev, struct mpfs_ccc_out_hw_
> > > > >  			return dev_err_probe(dev, ret, "failed to register clock id: =
%d\n",
> > > > >  					     out_hw->id);
> > > > > =20
> > > > > -		data->hw_data.hws[out_hw->id] =3D &out_hw->divider.hw;
> > > > > +		data->hw_data.hws[out_hw->id - 2] =3D &out_hw->divider.hw;
> > > >=20
> > > > What happens when / if the DLLs are supported by this driver in the
> > > > future? This seems like a trap for the future.
> > > >=20
> > > > According to include/dt-bindings/clock/microchip,mpfs-clock.h, ther=
e are
> > > > only 16 clock IDs. Could hws be initialized to have enough room for=
 all
> > > > 16 structures, and would it be ok if it was a sparse array?
> > > >=20
> > > > At the very least, I think it would be nice to include a comment he=
re.
> > >=20
> > > I think I'd rather add a comment, I know it's at most only 24 extra
> > > allocations, but just feels bad to do it.
> >=20
> > I'll add this, maybe on application.
> >=20
> > @@ -234,6 +234,10 @@ static int mpfs_ccc_probe(struct platform_device *=
pdev)
> >         unsigned int num_clks;
> >         int ret;
> > =20
> > +       /*
> > +        * If DLLs get added here, mpfs_ccc_register_outputs() currentl=
y packs
> > +        * sparse clock IDs in the hws array
> > +        */
> >         num_clks =3D ARRAY_SIZE(mpfs_ccc_pll_clks) + ARRAY_SIZE(mpfs_cc=
c_pll0out_clks) +
> >                    ARRAY_SIZE(mpfs_ccc_pll1out_clks);
>=20
> That makes sense.
>=20
> Reviewed-by: Brian Masney <bmasney@redhat.com>

I applied the patch with this comment added.

--BSpNHjmm58g1yjQa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaXFQQAKCRB4tDGHoIJi
0kzGAQDTiMAn/9pA3ovo9CSKkGSKQcbIO43P1mRGblWEqMoLqQEAp5LlMMg9HYIC
5SB4jiExbrG6ZtuwLfhWVE4Ax0vCTAg=
=Z7oQ
-----END PGP SIGNATURE-----

--BSpNHjmm58g1yjQa--

