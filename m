Return-Path: <stable+bounces-53809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD4490E743
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBE4B210AE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 09:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72A577106;
	Wed, 19 Jun 2024 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GbFg9FVJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7378276
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790557; cv=none; b=eS7v7Jl2LAIgXwJslZMJShDv3JNs5wuik2Bo+lgC/TgofwJBdlXVMureQy1Cx7lVr9jD3YjD9VasLhEIhGBn+Ie/m9GA/JZ1nNC3qGQ04tTNyNnHAXAiZc6tHTm2s7+9s24ONL98KrAApjtaKjj98g2DLAwG0VHdWB3S8IxgSLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790557; c=relaxed/simple;
	bh=o+UJRfE09hTcQ5Iiu78psIkeK0cYbOqEo5nDKRV+PYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBQGtqeANr+AuK7nGh4pw0iSyBV0Yg32n93DF+WzTiB+fKdQCe5Vix66lu/QfKwVkTSRm3C1ik7AKPhYztwt1Mj4Wr3NCMCuTVvSaXE6baiXD0FR6NQg3rVFv9gqjYfHUCUz4F24h977qf0RwoAYW/YW0aj1fWKwRDNikcqXMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GbFg9FVJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4218008c613so48874805e9.2
        for <stable@vger.kernel.org>; Wed, 19 Jun 2024 02:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718790554; x=1719395354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8TSslaBW9swbYHR/R7X2K6LeF5Zl/TzLPzcnhcrOxsA=;
        b=GbFg9FVJe7priQ2vlrXOQUgpdCVj+J80k/N9atdxiDvJPdGoRzuFY2oakG8xh4RBEc
         G65lAvPivDdVd7NiPG/PRk51YQss20PMutJSERFO754DMwdt1o0ZRXLDAYs2PFe5/48U
         uMeDRGIrBOgXJylBcgaRyFGUT4PCc29cnk3kDN43CsX9ouPSwQnRfE6gTwnlo/5H+hiZ
         OSJBOZ0aycbXlAAILaP0Ydv5LV1z/6P12GtrxZzCa4w97xP8sdeGGpyRMUI1sNyg1Cli
         PWEfRZUgGTe1E34wHErSewEqUFAUNFMwmWXKattjwDNkmfkImMgp8qPCUr8OlYkcQ75n
         sYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718790554; x=1719395354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TSslaBW9swbYHR/R7X2K6LeF5Zl/TzLPzcnhcrOxsA=;
        b=Oy5kCgZZOb6vKFF83ldD6QcQohULzj6FbVf3Ws4HlDRZ0ncvAlbqwP5be8/f9ZgeO2
         /W01XpN6pAIf4Y6+0PoorEVzRkf2ogePmPGgVQi+dps+m07pj3wVx6Drys0ikM0Lnj+H
         Kx3mTOyrdrTD3fJyH1JwTf7dvhIPJ3Tr6h6fjRIoUx3IofCWflVvcEsNAA2/t+q/RcHV
         N5aWes3p4x5ImP4CBhnxA7kZcMJNTHk1AbXHsGibbj4Tf8foh5vCWlY5nP7sFYNQPOuP
         6/dqQo2pXHd5ZEIf38GL+piMTvY4xJgTInNTtChwlrVmRRYefw3SolgkA6aImJrokV6O
         V/+w==
X-Forwarded-Encrypted: i=1; AJvYcCVeL9JonQMOVgZIy6yKoo28117/PfzpMecHy0tkx4oC3c4XVxO5ClCcFiGFWNHeGel3tu8zS0l7C+gvV3cFrf+dyAyutfd2
X-Gm-Message-State: AOJu0YyrKTW+k4MewYcVQ9333g38pIBX7jnZmn455f6Fk2rS9QpeZdcm
	ofvsMAlwXc3D2SCPk6o27vedowF899dfZGDKc5OWeLxOUhwoX3eVK3dflMMPN3c=
X-Google-Smtp-Source: AGHT+IEdWvf9kIMjYeDjsKaVTkueLP/zcQiKA6cIoiZff9FxDP8/MBI48uP1QLBTcO2jDuCAaZqN3Q==
X-Received: by 2002:a05:600c:434a:b0:421:7407:d778 with SMTP id 5b1f17b1804b1-424751765c8mr13663175e9.14.1718790553957;
        Wed, 19 Jun 2024 02:49:13 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73c7sm255639985e9.42.2024.06.19.02.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:49:13 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:49:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lee Jones <lee@kernel.org>, Thierry Reding <treding@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: stm32: Fix calculation of prescaler
Message-ID: <5phr5jpquz4f6yomuytsj3kfqavvg4auqk3np5nrjmauleenyj@hc6stosribdt>
References: <cover.1718788826.git.u.kleine-koenig@baylibre.com>
 <e6a1aa8343971c0b8f77d9e4d88c08b26279bf09.1718788826.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j2azgwpn276d45sa"
Content-Disposition: inline
In-Reply-To: <e6a1aa8343971c0b8f77d9e4d88c08b26279bf09.1718788826.git.u.kleine-koenig@baylibre.com>


--j2azgwpn276d45sa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:26:25AM +0200, Uwe Kleine-K=F6nig wrote:
> A small prescaler is beneficial, as this improves the resolution of the
> duty_cycle configuration. However if the prescaler is too small, the
> maximal possible period becomes considerably smaller than the requested
> value.
>=20
> One situation where this goes wrong is the following: With a parent
> clock rate of 208877930 Hz and max_arr =3D 0xffff =3D 65535, a request for
> period =3D 941243 ns currently results in PSC =3D 1. The value for ARR is
> then calculated to
>=20
> 	PSC =3D 941243 * 208877930 / (1000000000 * 2) - 1 =3D 98301
         ^
This ----' must be ARR of course.
=20
> This value is bigger than 65535 however and so doesn't fit into the
> respective register. In this particular case the PWM was configured for

While improving the commit log, I'll do s/register/register field/, too.

> a period of 313733.4806027616 ns (with ARR =3D 98301 & 0xffff). Even if
> ARR was configured to its maximal value, only period =3D 627495.6861167669
> ns would be achievable.

Best regards
Uwe

--j2azgwpn276d45sa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZyqZQACgkQj4D7WH0S
/k5Qcgf/XEWmvg4Z36NEvcSG5pJZFFDlOS9COPMZoXclFGt758vYqb9EKsxAWIB8
p253UcidAQcM0lEE/oPWxGGg4zFTGhupsULnus5V0w2iYTupnXDeiWxCpW4SkjZ6
n2pdxIUZJQ+LsDy+1lsCMuA4d1WKy/BXk3bkSYF4ssN96+wsES87q+UqU3t8h3iK
3+OkznlkR6IfZNJ/fTLybLeQByLH+nXKQV2Ifb67EL+A3uIk/vH+YpyqJxftEFv4
F18ZU/zl0FltTabYT2qXoXJE9jH0ZhHfynlNXtP5Q2g5NZd2qCCNQ3Vb0cQP9hI8
PxlwWBVzSsJL5EMqjQcKVllQ7EQrCg==
=fLP+
-----END PGP SIGNATURE-----

--j2azgwpn276d45sa--

