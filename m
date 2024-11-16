Return-Path: <stable+bounces-93648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7FC9CFF45
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 15:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540D01F23575
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 14:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB31426C;
	Sat, 16 Nov 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hq1A5km0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41377D53F;
	Sat, 16 Nov 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768055; cv=none; b=a8laaFQMgfEO3dVZMHAFiN19UuJUCZA0KdvTspYlCxuU8VEFLmY4zwEQkPLI9QsCLRZosFD8UFEGbyZbZsh4xhSDmXIE9/nEIsJAPvtwpC9Y6E2W0XomlUN4aPn7jQPRAZPU9Y5EUIGkiX4xlB4uRZAwk1Qopm2l514bprycTVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768055; c=relaxed/simple;
	bh=Se0zsW/usXljJvHlpBaI9SHdckktBbemfrUJ82FXdzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFpruj1ijF1QgPB0VsXwwTKfwP/Qq0wcgUYPcS3TBkti8K3COZrdptfzLGAFE+0nNOHEbqp3Dxz+a0PzCFhBEmFkRsKxWYSsKfuGxjGkZGDhTMEeikYy2D0zFlUHeSqocoIFkVDD+rpHg2Z/cL6CHFzAK4tB7VQsIN9zoFdVco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hq1A5km0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8BBC4CEC3;
	Sat, 16 Nov 2024 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731768054;
	bh=Se0zsW/usXljJvHlpBaI9SHdckktBbemfrUJ82FXdzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hq1A5km0xLPZQO/PLflwYyOs9xWaaVX06PWRYmePV/49K09gQkGonmhk1tly8lUi/
	 8vJ0VK078coD5o3Mp5wk/QLBkX4l0H6GWFX4RNZCKxt4Y03lIW7AabGDnJLEM381yX
	 Ejcpl5aMeVrZ4YxNClwqa+C8mbc03LvgTf7nGmg0O824vtL2pgfjQi3dB9NIZmUo75
	 4Mq8I4c6UUlX99ZVd7n5sWq/izaSgd+3YjQs/QAsiY2pF6aom/aqI8EsJUyxmue3ld
	 7bESEilxw6PoltewOBIL8s2KkdZTszmAVnWB0JJTFijGq+W30UXjfXA162i/We2rGs
	 lfxjXkvokWxBQ==
Date: Sat, 16 Nov 2024 15:40:50 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@airoha.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: en7523: Fix wrong BUS clock for EN7581
Message-ID: <Zziu8tMZfWpqAur9@lore-rh-laptop>
References: <20241116105710.19748-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+v0muwa3YkHZap3q"
Content-Disposition: inline
In-Reply-To: <20241116105710.19748-1-ansuelsmth@gmail.com>


--+v0muwa3YkHZap3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The Documentation for EN7581 had a typo and still referenced the EN7523
> BUS base source frequency. This was in conflict with a different page in
> the Documentration that state that the BUS runs at 300MHz (600MHz source
> with divisor set to 2) and the actual watchdog that tick at half the BUS
> clock (150MHz). This was verified with the watchdog by timing the
> seconds that the system takes to reboot (due too watchdog) and by
> operating on different values of the BUS divisor.
>=20
> The correct values for source of BUS clock are 600MHz and 540MHz.
>=20
> This was also confirmed by Airoha.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Cc: stable@vger.kernel.org
> Fixes: 66bc47326ce2 ("clk: en7523: Add EN7581 support")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/clk/clk-en7523.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
> index e52c5460e927..239cb04d9ae3 100644
> --- a/drivers/clk/clk-en7523.c
> +++ b/drivers/clk/clk-en7523.c
> @@ -87,6 +87,7 @@ static const u32 slic_base[] =3D { 100000000, 3125000 };
>  static const u32 npu_base[] =3D { 333000000, 400000000, 500000000 };
>  /* EN7581 */
>  static const u32 emi7581_base[] =3D { 540000000, 480000000, 400000000, 3=
00000000 };
> +static const u32 bus7581_base[] =3D { 600000000, 540000000 };
>  static const u32 npu7581_base[] =3D { 800000000, 750000000, 720000000, 6=
00000000 };
>  static const u32 crypto_base[] =3D { 540000000, 480000000 };
> =20
> @@ -222,8 +223,8 @@ static const struct en_clk_desc en7581_base_clks[] =
=3D {
>  		.base_reg =3D REG_BUS_CLK_DIV_SEL,
>  		.base_bits =3D 1,
>  		.base_shift =3D 8,
> -		.base_values =3D bus_base,
> -		.n_base_values =3D ARRAY_SIZE(bus_base),
> +		.base_values =3D bus7581_base,
> +		.n_base_values =3D ARRAY_SIZE(bus7581_base),
> =20
>  		.div_bits =3D 3,
>  		.div_shift =3D 0,
> --=20
> 2.45.2
>=20

--+v0muwa3YkHZap3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZziu7wAKCRA6cBh0uS2t
rKV1AQD0Q9RpHuuc7sc2j0MuAC1hRCBopXAnEBOJc/X5oEL5rQEA7g2TWZep/44C
bbAj1Pe7IwRKXVCT56QAPBWW/fuwFws=
=4Y3g
-----END PGP SIGNATURE-----

--+v0muwa3YkHZap3q--

