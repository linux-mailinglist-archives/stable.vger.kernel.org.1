Return-Path: <stable+bounces-96008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293279E0374
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B37CB35843
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790B51D935F;
	Mon,  2 Dec 2024 12:09:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C461D95A9;
	Mon,  2 Dec 2024 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141394; cv=none; b=eh8oP6ifmoT8Tl/R2zsDiBCR+Ak6zfae3w6o1BBcNo7t8/nj0E0tddX1V8ZqwcoTRf1UptkW8CbKDhdaHDeuV0yH1aQBictW9bVL260qM2pNwikp2SPzf+A+OA0RYpoKfEjxO+EjYMhjZCBsI0urgAEFlWa65IemnQ/5nrAWgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141394; c=relaxed/simple;
	bh=3Sc5eXzDyt1d4OyLgnJStrFaZiHTTEIaJrTni5XYFjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8276xQrvoIgmVevhH80b1Bblb1hd0SQVeQicnjRUHPRe2fv5PM0WbJ6AgearVoUVcu4QZYLkwEJME+dSq7Tu86ZDmln7jCFBoh/HiYss2PwP1Do3U9jqj+vL+/b9waaIV5tSHd2t/+502nn8dShfHvcPPxZmoue8YbxgOHA0/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6460F1C00C4; Mon,  2 Dec 2024 13:09:51 +0100 (CET)
Date: Mon, 2 Dec 2024 13:09:50 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
	linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 6/6] USB: gadget: pxa27x_udc: Avoid using
 GPIOF_ACTIVE_LOW
Message-ID: <Z02jjnoqlvRw8YV0@duo.ucw.cz>
References: <20241124125742.3341086-1-sashal@kernel.org>
 <20241124125742.3341086-6-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CahKicY9gksnAilV"
Content-Disposition: inline
In-Reply-To: <20241124125742.3341086-6-sashal@kernel.org>


--CahKicY9gksnAilV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> [ Upstream commit 62d2a940f29e6aa5a1d844a90820ca6240a99b34 ]
>=20
> Avoid using GPIOF_ACTIVE_LOW as it's deprecated and subject to remove.

Well, we won't be removing it in -stable, so we don't need this.

Best regards,
								Pavel
							=09
> +++ b/drivers/usb/gadget/udc/pxa27x_udc.c
> @@ -2356,18 +2356,19 @@ static int pxa_udc_probe(struct platform_device *=
pdev)
>  	struct pxa_udc *udc =3D &memory;
>  	int retval =3D 0, gpio;
>  	struct pxa2xx_udc_mach_info *mach =3D dev_get_platdata(&pdev->dev);
> -	unsigned long gpio_flags;
> =20
>  	if (mach) {
> -		gpio_flags =3D mach->gpio_pullup_inverted ? GPIOF_ACTIVE_LOW : 0;
>  		gpio =3D mach->gpio_pullup;
>  		if (gpio_is_valid(gpio)) {
>  			retval =3D devm_gpio_request_one(&pdev->dev, gpio,
> -						       gpio_flags,
> +						       GPIOF_OUT_INIT_LOW,
>  						       "USB D+ pullup");
>  			if (retval)
>  				return retval;
>  			udc->gpiod =3D gpio_to_desc(mach->gpio_pullup);
> +
> +			if (mach->gpio_pullup_inverted ^ gpiod_is_active_low(udc->gpiod))
> +				gpiod_toggle_active_low(udc->gpiod);
>  		}
>  		udc->udc_command =3D mach->udc_command;
>  	} else {

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CahKicY9gksnAilV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02jjgAKCRAw5/Bqldv6
8uBpAKCEIhs4qSybrSo2Osfg6mGdAgaRpQCfQwkrTwJnuhR5kifD55c/wiNXd0s=
=8Pn9
-----END PGP SIGNATURE-----

--CahKicY9gksnAilV--

