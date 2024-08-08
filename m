Return-Path: <stable+bounces-65992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D3A94B682
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 08:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EDE286739
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 06:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE49185E6A;
	Thu,  8 Aug 2024 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="adbLYiLi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FB41850A4
	for <stable@vger.kernel.org>; Thu,  8 Aug 2024 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723097473; cv=none; b=kKhD8Z17IAwaTEYgA9aiR+q5mxqqppo/0+aFTZz5v9742FbapqHOKRCVN2eE9Q8MJe/E1XfPtJOlxml6F/axECxrcgItoWV17et/kful0YyJ7vkDgXrMp2VkRMgUc8rHDMmFWBV9cVTuLPu4I3dUOMcEux+/iAyYphg36+iUoXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723097473; c=relaxed/simple;
	bh=XpiyGpASuB9p4qJtFJGNcBl87mmkpyvDcEh3HXDYk+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG2RHdUEEnZnT2tKvOdM0AmRZLFZgHliRj0GZNguIRnkPl2EQvC8zb5tVlIojcbEx6kxvjcGEdK4kbBpACZt4jl0AO2yhzUxKr6GuzCwn0/uMdZQlZ8sDcLbeRMHnxyX8l8pssXdHD7Bv9hNxnNyLm4goSGsvLP0u7z89QcH0dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=adbLYiLi; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so504760a12.0
        for <stable@vger.kernel.org>; Wed, 07 Aug 2024 23:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723097467; x=1723702267; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hMVSvloPi67e6nc4nTBS6kTKkfveRbd6X3Yp5Y8htg0=;
        b=adbLYiLiUIkdnFvlV4k2NYAMKPRW23EP1nIvIcooewmTFXSuXrTMB7nuEn1qBTwzvy
         BouG7NdRobKDU8HNCuvzBO+QDtczDL3X4S7dMQQTvPpHd35iR+lqAxewibkKDP1O+Nqu
         4hgKg/QM6Mrt1SwUHyet7EqxO8mV3Ejf0HFjxXsVFVYwKnocE2YRhiffvRwSeVqURDt3
         to6KxRnbYKP4D5BOKjfORILUEUgss7mCTs/UcWGI57G3NWJYcHEiAPIONb8d7CWsWKsu
         v482h3CZ1fyY5tmeAzF45tvi2XhACBcKxdI1S0KMZUXhXjreygcJ2G/5UiVBWWCL/2+t
         fU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723097467; x=1723702267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hMVSvloPi67e6nc4nTBS6kTKkfveRbd6X3Yp5Y8htg0=;
        b=eQvqas9dxNbTvgB9rgcvtq3usGqfNsPJgS7EqTmFU88KKwRkr4kVPm8tZZ9lXv1tWZ
         6InrKNTT8XbAvWDfgI9jjKSaNDs/T8KEk/c5Fm+VCRfx7ZEBM86yPuw3obvylrTgAvmf
         NiricowBHC3MA4tk6YPTI1cM/y1ZRfy88pK/D2ppa0yIM1gplNB6RU/Aq35S0a4qJW5F
         fcT7eclhR0JqrsFMICzwERAt9Y6OWdcQm4aerhRu/Q76f66Gvu+TnYEXNaJy0vKjuwJf
         4L1neSB4GfMnA3LjzS2RTjtOCGdHG5VaKRzqyelaP+OjvcDGiNO/OLT2WV5XXiLFDter
         CbkA==
X-Gm-Message-State: AOJu0YybIltO7BgkHEq/Xv6BTs5IxIzlvkosBfdcUne+WTvGCR32PdYD
	+G7FT7NGLF6xoKveHPwo2Bf8Gu2+k+cCu+7CJriYLLGiEhVux0vlO/26JsUCL5kTABd7COB16GX
	h
X-Google-Smtp-Source: AGHT+IGz9VSBO4l/jHWUsfOwrk3jSQZxLMnd1cZyratztKlyg3GbC09/QsLWOC1/0PO3hfCOEG9kSQ==
X-Received: by 2002:a17:907:944c:b0:a7a:c083:8575 with SMTP id a640c23a62f3a-a80907c97e5mr48767366b.0.1723097466693;
        Wed, 07 Aug 2024 23:11:06 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d43065sm705042766b.98.2024.08.07.23.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 23:11:06 -0700 (PDT)
Date: Thu, 8 Aug 2024 08:11:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 011/121] thermal: bcm2835: Convert to platform remove
 callback returning void
Message-ID: <fqozvio6zhj3vow2h6zayfmtbi3c5ups6vkihymzabhk6cfuf3@gu4b4j7cyltj>
References: <20240807150019.412911622@linuxfoundation.org>
 <20240807150019.742020612@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7lw3mfobaywl5gkm"
Content-Disposition: inline
In-Reply-To: <20240807150019.742020612@linuxfoundation.org>


--7lw3mfobaywl5gkm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Wed, Aug 07, 2024 at 04:59:03PM +0200, Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me kno=
w.
>=20
> ------------------
>=20
> From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> [ Upstream commit f29ecd3748a28d0b52512afc81b3c13fd4a00c9b ]
>=20
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Stable-dep-of: e90c369cc2ff ("thermal/drivers/broadcom: Fix race between =
removal and clock disable")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/thermal/broadcom/bcm2835_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal=
/broadcom/bcm2835_thermal.c
> index 3acc9288b3105..5c1cebe075801 100644
> --- a/drivers/thermal/broadcom/bcm2835_thermal.c
> +++ b/drivers/thermal/broadcom/bcm2835_thermal.c
> @@ -282,19 +282,17 @@ static int bcm2835_thermal_probe(struct platform_de=
vice *pdev)
>  	return err;
>  }
> =20
> -static int bcm2835_thermal_remove(struct platform_device *pdev)
> +static void bcm2835_thermal_remove(struct platform_device *pdev)
>  {
>  	struct bcm2835_thermal_data *data =3D platform_get_drvdata(pdev);
> =20
>  	debugfs_remove_recursive(data->debugfsdir);
>  	clk_disable_unprepare(data->clk);
> -
> -	return 0;
>  }
> =20
>  static struct platform_driver bcm2835_thermal_driver =3D {
>  	.probe =3D bcm2835_thermal_probe,
> -	.remove =3D bcm2835_thermal_remove,
> +	.remove_new =3D bcm2835_thermal_remove,
>  	.driver =3D {
>  		.name =3D "bcm2835_thermal",
>  		.of_match_table =3D bcm2835_thermal_of_match_table,

While I'm confident this patch not to break anything (there are so many
of this type in mainline now and none regressed), it should be also easy
to port the follow up patches onto 6.6.x without this change.

No strong opinion and maybe being able to cleanly cherry pick later
changes is important enough to keep this conversion? Otherwise I'd tend
to drop this patch.

Best regards
Uwe


--7lw3mfobaywl5gkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAma0YXUACgkQj4D7WH0S
/k6keAf/RZ69SP8bf6iDGb02MY6e2zUchD5jb2McKvIlulYCHlWcRXJUOAK9I7Pg
fStCTd27skWhvPZL2uMiMqFeHV/4QoZdg2exCYRYxS/WKE9zxNUWuT2FhUXyZPOe
+FBKWs/G8FfmX8J/SqiTld7Z+j8xNm3kGzferQDVvHlPQLzGAH9nxUxgNBZbraXp
ec37DlXflaR2zEsNnkaiIOJUI7csrmm4g1efaLTTgdsbG9AG6lrQeXNkWmUWCjof
oviLiYawX6ru96ixGznJUCl6XHyTsENYCeqge9aTJhZC5njvV4Ub50idzT7h9LG0
DI+uTwShFWI4U929ynF7l814UIj0RA==
=CYnj
-----END PGP SIGNATURE-----

--7lw3mfobaywl5gkm--

