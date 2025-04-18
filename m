Return-Path: <stable+bounces-134630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E3A93B84
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8B18A7169
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4D21858D;
	Fri, 18 Apr 2025 16:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="P1RFJC1C"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE391DED51;
	Fri, 18 Apr 2025 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995564; cv=none; b=HcOqOdqeEoYojaxckLwl0dh4CHkqBt+TwS6+JTR4qyg2aT0vbY7UoDqTYikP0YhygN/ImW4z8r/lnbhWtx5JiivXM19A1yZrY1C42uzMLuC+rKAqOKsUsKJ64lhTKcnK+LGMvYp9xc2Q80a+Z8s3P8YhfckU7Hsrn2sy8gaHjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995564; c=relaxed/simple;
	bh=RKNC8LuEadBrzXxwi5W2L+472XmL48vNI/jIDqdaCQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhVRK6E5YNXXB+5TR5BBANtVQfkRGEpns/jGdQ06fL8rMfoTHSz/aXUsgzTiID5jOOcXI65QlMZD+E4IAkr+C0aZNt+6DGxNiJbKA4Tbm3WtmRKQC/KZh6EmjUWk06lF6S2Z/B647f1P05TZQs3c8mpsqc9BHTR85BSnnjfiYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=P1RFJC1C; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EF6C2102E6336;
	Fri, 18 Apr 2025 18:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744995560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=aSYTOYrhvq3xoKuHguEK0iR48SX9BrWOGc8iTYg7DdE=;
	b=P1RFJC1CKiZdbWyNLxS8wmpRGBCJfNwPaHTfS+UrXLAwjv7kF1KBCtu622uQPthc7zgDls
	z5bZbf0j+s/sZVuPU42o8fULO+bCG4o+0HC6h9fFkZFL4qqgThZ8qN/jL8nOc5o/KMVKM7
	IYfaMwIzwY6Kwl0f+5Z+Qb/cn8d/0FO9N2IEUEA6fQ7DRGLq3wILIFM/OaFh29cFsgeoWx
	auwEz43jwimW9cYfZzWY/Hw7zr2CNIJ9mGc7sghjf1lks0XxUQWcrQwSCBzl0lo0KcU+e5
	kmLBIqZtB8cIv9Uy4jVwpgXglL1In3PkNBUxhSr9ZWaf10IC8OvOIR+LQrNNvQ==
Date: Fri, 18 Apr 2025 18:59:14 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH AUTOSEL 6.1 6/9] ASoC: fsl_audmix: register card device
 depends on 'dais' property
Message-ID: <aAKE4kb6gImSpK5L@duo.ucw.cz>
References: <20250331145642.1706037-1-sashal@kernel.org>
 <20250331145642.1706037-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Tn6/BGpnTOBLo3b"
Content-Disposition: inline
In-Reply-To: <20250331145642.1706037-6-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--/Tn6/BGpnTOBLo3b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 294a60e5e9830045c161181286d44ce669f88833 ]
>=20
> In order to make the audmix device linked by audio graph card, make
> 'dais' property to be optional.
>=20
> If 'dais' property exists, then register the imx-audmix card driver.
> otherwise, it should be linked by audio graph card.

This is part of series, AFAICT; should we have it in -stable?

Best regards,
									Pavel

> +++ b/sound/soc/fsl/fsl_audmix.c
> @@ -492,11 +492,17 @@ static int fsl_audmix_probe(struct platform_device =
*pdev)
>  		goto err_disable_pm;
>  	}
> =20
> -	priv->pdev =3D platform_device_register_data(dev, "imx-audmix", 0, NULL=
, 0);
> -	if (IS_ERR(priv->pdev)) {
> -		ret =3D PTR_ERR(priv->pdev);
> -		dev_err(dev, "failed to register platform: %d\n", ret);
> -		goto err_disable_pm;
> +	/*
> +	 * If dais property exist, then register the imx-audmix card driver.
> +	 * otherwise, it should be linked by audio graph card.
> +	 */
> +	if (of_find_property(pdev->dev.of_node, "dais", NULL)) {
> +		priv->pdev =3D platform_device_register_data(dev, "imx-audmix", 0, NUL=
L, 0);
> +		if (IS_ERR(priv->pdev)) {
> +			ret =3D PTR_ERR(priv->pdev);
> +			dev_err(dev, "failed to register platform: %d\n", ret);
> +			goto err_disable_pm;
> +		}
>  	}
> =20
>  	return 0;

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--/Tn6/BGpnTOBLo3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAKE4gAKCRAw5/Bqldv6
8hsNAJ9H7kuYWcCsw1LeV5TOvp6rZ2J1rACghLqa+XYVc6jaUuETLw1RElPql14=
=wIoA
-----END PGP SIGNATURE-----

--/Tn6/BGpnTOBLo3b--

