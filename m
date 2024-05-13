Return-Path: <stable+bounces-43602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657FF8C3D0A
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 10:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938DFB21A31
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 08:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3CB1474AB;
	Mon, 13 May 2024 08:19:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182C5146D74;
	Mon, 13 May 2024 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588377; cv=none; b=Qq9Ra3BmkfI/AWa2jgwiXplaIDpyfhFnbSaPDYaKX2P3XNeLlWLpzVS99WGccNm3q5VNR5AVLvqVN3wjBSr3iGckLlKwFAKoMCbpRCX8Ua0TsWHq4oTHy65DftyfEjd4LrcLD3EG99odvB8WwseM7tbTv97BbA1VedOxXE05sqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588377; c=relaxed/simple;
	bh=5I/14X8DRduvcN15vw4oASrVR8IZsXPZHQGI0hwn4Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOvx/u6oqTFh4VmU2FjBPQaHmrTju+GjTSKvLQACs47z1ZX2ns4PntTwHPAMFFalqZ9k66F1lcPn9ZSb4/brZcY9DRYzoABYNyZSMfuRT/rhlZPbSMB9hvnVgX7Nu2xd8zVQbhFJIxxvRJGFOxgcMLGWORruv/BWO8jPQY4iuuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 58C371C0084; Mon, 13 May 2024 10:19:34 +0200 (CEST)
Date: Mon, 13 May 2024 10:19:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH AUTOSEL 6.1 02/25] regulator: irq_helpers: duplicate IRQ
 name
Message-ID: <ZkHNFQwvzjNJbYt4@duo.ucw.cz>
References: <20240507231231.394219-1-sashal@kernel.org>
 <20240507231231.394219-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pngi36OMD6etkkKN"
Content-Disposition: inline
In-Reply-To: <20240507231231.394219-2-sashal@kernel.org>


--Pngi36OMD6etkkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The regulator IRQ helper requires caller to provide pointer to IRQ name
> which is kept in memory by caller. All other data passed to the helper
> in the regulator_irq_desc structure is copied. This can cause some
> confusion and unnecessary complexity.
>=20
> Make the regulator_irq_helper() to copy also the provided IRQ name
> information so caller can discard the name after the call to
> regulator_irq_helper() completes.

Does this fix a bug in 6.1? It looks like preparation...

Best regards,
							Pavel

> +++ b/drivers/regulator/irq_helpers.c
> @@ -352,6 +352,9 @@ void *regulator_irq_helper(struct device *dev,
> =20
>  	h->irq =3D irq;
>  	h->desc =3D *d;
> +	h->desc.name =3D devm_kstrdup(dev, d->name, GFP_KERNEL);
> +	if (!h->desc.name)
> +		return ERR_PTR(-ENOMEM);
> =20
>  	ret =3D init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
>  			      rdev_amount);

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Pngi36OMD6etkkKN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkHNFQAKCRAw5/Bqldv6
8o5JAKCCJNW14FaI7QbNsLT2VGfLpxAXFwCgk3a2Dpxc5/rJXJSnY66H3P0wCfk=
=UwWD
-----END PGP SIGNATURE-----

--Pngi36OMD6etkkKN--

