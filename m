Return-Path: <stable+bounces-219727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGNVF3OCn2lrcgQAu9opvQ
	(envelope-from <stable+bounces-219727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:14:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B94C619EA1C
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 650743047E77
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 23:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034F379978;
	Wed, 25 Feb 2026 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlgQFgt5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B314A378D8F;
	Wed, 25 Feb 2026 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061291; cv=none; b=Zk36xzt5J6RzL50U93uNlEZWvfILXP4r73siGPM/Ux9wps9+FCECJX429iZH3bKJpe4Nv61Nab3Bh4yqkneRhRjR+M6prkMDJ8ue13MSpCnZ+Zh+EfTGPvpsWZDMS0UO5awX47rgVlUYT1GoW2j3P79dz+6KO6dRybBNTyB02O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061291; c=relaxed/simple;
	bh=VK2YcBiNDigjs2o+L49r0/gexv5vFZDj1q5df5aAjCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ui7whgR8swA7w5Y12j9xzS/nVxpr+fccsm3ObgPPKxHrCkY0kXFcIWn8FlcikZDcxeF/UwddCuXfc7kRHY9mW8J+UBwAR7ki+r6VrYlOA94uEYz94xTA8EwNKqKvvmB3e5BuyNlpzDRyEvaid6O/fhW2zlDIAPYeYOpu/rhhkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlgQFgt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D116C116D0;
	Wed, 25 Feb 2026 23:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772061291;
	bh=VK2YcBiNDigjs2o+L49r0/gexv5vFZDj1q5df5aAjCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlgQFgt5Q++FEAIjW9nuShR0bn2j4iU1a5G4D9nbJS5Jx688UXluHwF1fTrxdbX3I
	 W391wquZ2GN2l1IRM/9E+McOIRtXr5I7AKsbHD7J8/q1PD8xK3lATt3JEdFcGBANnn
	 j/+agO7ejsgWTZWUw0Nbmy+lB5YTdTvsl0ypFPUrXYg1voHDW9Biu5qO3A6vHNujLB
	 rDl09SbVhf7gpfKSDDar4GKi9so68AJHBJk1IPoo5ptTVRGLKQ8jGyeXUAqt+8/Han
	 n8kAjawzc5oV9VJXFfCwV6jL+FfifN0Kut34Egdolq9KWudlFeQcH3NKSM0kmcP9Oq
	 HneetbwLA5h3A==
Date: Wed, 25 Feb 2026 23:14:47 +0000
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
Message-ID: <20260225-cache-nebulizer-2f3669074fa4@spud>
References: <20260224-briskly-scholar-294d13464721@wendy>
 <aZ9-NWiX4wMH3Ay6@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvpItN8tSslGWDOf"
Content-Disposition: inline
In-Reply-To: <aZ9-NWiX4wMH3Ay6@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219727-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:email,microchip.com:email,infradead.org:email,baylibre.com:email]
X-Rspamd-Queue-Id: B94C619EA1C
X-Rspamd-Action: no action


--GvpItN8tSslGWDOf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 05:56:53PM -0500, Brian Masney wrote:
> Hi Conor,
>=20
> On Tue, Feb 24, 2026 at 09:35:25AM +0000, Conor Dooley wrote:
> > UBSAN reported an out of bounds access during registration of the last
> > two outputs. This out of bounds access occurs because space is only
> > allocated in the hws array for two PLLs and the four output dividers
> > that each has, but the defined IDs contain two DLLS and their two
> > outputs each, which are not supported by the driver. The ID order is
> > PLLs -> DLLs -> PLL outputs -> DLL outputs. Decrement the PLL output IDs
> > by two while adding them to the array to avoid the problem.
> >=20
> > Fixes: d39fb172760e ("clk: microchip: add PolarFire SoC fabric clock su=
pport")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > CC: Conor Dooley <conor.dooley@microchip.com>
> > CC: Daire McNamara <daire.mcnamara@microchip.com>
> > CC: Michael Turquette <mturquette@baylibre.com>
> > CC: Stephen Boyd <sboyd@kernel.org>
> > CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > CC: linux-riscv@lists.infradead.org
> > CC: linux-clk@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  drivers/clk/microchip/clk-mpfs-ccc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/clk/microchip/clk-mpfs-ccc.c b/drivers/clk/microch=
ip/clk-mpfs-ccc.c
> > index 3a3ea2d142f8a..54cfbb8be8ab5 100644
> > --- a/drivers/clk/microchip/clk-mpfs-ccc.c
> > +++ b/drivers/clk/microchip/clk-mpfs-ccc.c
> > @@ -178,7 +178,7 @@ static int mpfs_ccc_register_outputs(struct device =
*dev, struct mpfs_ccc_out_hw_
> >  			return dev_err_probe(dev, ret, "failed to register clock id: %d\n",
> >  					     out_hw->id);
> > =20
> > -		data->hw_data.hws[out_hw->id] =3D &out_hw->divider.hw;
> > +		data->hw_data.hws[out_hw->id - 2] =3D &out_hw->divider.hw;
>=20
> What happens when / if the DLLs are supported by this driver in the
> future? This seems like a trap for the future.
>=20
> According to include/dt-bindings/clock/microchip,mpfs-clock.h, there are
> only 16 clock IDs. Could hws be initialized to have enough room for all
> 16 structures, and would it be ok if it was a sparse array?
>=20
> At the very least, I think it would be nice to include a comment here.

I think I'd rather add a comment, I know it's at most only 24 extra
allocations, but just feels bad to do it.

--GvpItN8tSslGWDOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ+CZwAKCRB4tDGHoIJi
0oQkAQDqspQZXpWi73qrClv6oQlSbiI4pkaCAQHne1fsgZzU1wEA9uJG7+fpSyAC
PVCJYXDmlCFMeWmVkDtn0nYEdKXJRAQ=
=fJQw
-----END PGP SIGNATURE-----

--GvpItN8tSslGWDOf--

