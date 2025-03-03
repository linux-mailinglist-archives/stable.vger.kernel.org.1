Return-Path: <stable+bounces-120074-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D12D0A4C579
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C25D918875AA
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40C22144C3;
	Mon,  3 Mar 2025 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ6IM/I1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2512135BB;
	Mon,  3 Mar 2025 15:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016596; cv=none; b=H/bIGANSO2JYunReu6XyM85sBL4T032VOn6qRpy1ax3WBP4TRNUgAaDYBa+y2rc4WbcGBc/Xv0B0Csw4ZBMRj5XJqIoNz0hQQi+finKzpqKqtA58+T++ZNXOUSN6Y1kS0nsycNjUqBqw/hMtQ9fYfiBKmeGnp801lY+Iw8z17BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016596; c=relaxed/simple;
	bh=ghfaZbIiUJzse2shN7QuXoFlGxnLXRzYB7t3m0+2OGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/IIqP7OzibPeihqzt18eI8wLN6eFLKfGRO0czw+QzbuLU4u2LFaLwkgWVf8ebAcP1wtpghcSf+aKibghejdOGWJK/EpkAySmgk7hLQ33jUtAYpn5pda73PFz5Ij618dXA/2AYVeV2/f2w1z91HRwJ7lDb8kwQ5E9fg7g70oSw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZ6IM/I1; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bc31227ecso6916995e9.1;
        Mon, 03 Mar 2025 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741016591; x=1741621391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gX/3lsZgxbQ9Eu8icrnCZRTD736z7Ychh8myylxpAg0=;
        b=PZ6IM/I1LAAWOMENoC1M5umG/lqE5PyRxHSG2SgwFt8Q89EyPZ4TgKkOVYV5+ZF+Rh
         p1TxMldCjmCcVhDCLyUhgPgmPXn7aLCoNcQVWfbkwQn8Mka/hQUAMV8ZaHrRwr9nUcPd
         BkdbkZvP/Q07kCIFBzbZ5fhI0lO277k+UTmBIpqiI+y52OpKPEUbiN57kcGc/KZWxPX1
         M4mbaLTqhBt3kcR+JhLS24Kyb2PQ+mkLUK5kjTXgMr6E2M/rihYA2BTXF/rbzR7qnlVg
         ziPtSplNlM31bpsXo7BLTY6z2fo43LNn6qU4EtCmbIa3T7y2NTvxp4dkssPt+BmW8+7u
         dRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741016591; x=1741621391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gX/3lsZgxbQ9Eu8icrnCZRTD736z7Ychh8myylxpAg0=;
        b=KUvayw+yZf99wSoSSD4Xq3BnurFegHVNGyV+Ly3Fln+EnQXZtlJezcR8qpZR7gFzJl
         KoZwDl8jaohrWKt+WWWRfD7LhFCiz2rpgMNZu5kGso/Z8wSKTAPq1L6Ve8+y/voTHG4A
         Ouc1btrwksGqbKDul2+wmBnk423I5aYu2FxH0xmzAM75mifYn4nqjOm8PdMmv6603v14
         O6ciY1vl5aHZLtmjj8kHaTfwWS91FKduok7ldiBc45vQD2ynXIZNy9Xn4/1nofq/Y8B4
         8S9sFEnGKdIJopL1s7YOdE+B9RPjChaJjkb8zhZOHLqiVXWYRX125Xvh/WGx2dzc5QP/
         2ZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWrAJQHIbBIANX9LHSWSUUJj8RPWgk1TfSJ9+ah13SWZgtOJ/2TsyPolBKiN6gXsF13g1IEgLZS3P1BiA=@vger.kernel.org, AJvYcCWLF1OnsAWebbcYZ3PpJnprCIATEaMYTpJNdhaWFIn0X12+vJP5qtyBSVQk9pz+XTGvXITCCwugRZwKai8=@vger.kernel.org, AJvYcCWsdhoBqA0hFibD3eoPQhxBS6WzzIxfonQglIgyaD7gs+9lXbQOjp8HpgCbndO/fucQi/ZDh8roibnTpLE=@vger.kernel.org, AJvYcCWxEs2tCGf+gney1PU03wOMF5RE1wNZjnWtUDHkX4/k74ptI1SuSSCPf9fsQj9ozXhfEPbdZFdu@vger.kernel.org
X-Gm-Message-State: AOJu0YwDogHWLRFzrZZxCGCLwo+RF74RZ55kqdc5cbupfPZn0ApgKfnd
	lvpVL5gUE0rSOGmfmhUl4J02mIaHOIzQ0b9UE/BpNDySfDEmM2LEcQoRfw==
X-Gm-Gg: ASbGncs2y3bISiFRkYP01lcXxm27ujPE6xJnVDwnSMX6P4LzPdtJI+GzCFpQ/mrFSMv
	dvMrBva3f7ZdHQPxFenu7oY9JOjLY3xQYbRsEQAQzl+ElS/FGrmm7zzxnJz4diKZlJmiahtfVLA
	UAsVoEEHkF4s2JTQ98D5fKAvRSl3eiwb80Umi8Jjm3ZVipACelRCgpdl9qJts9FQxLeXGZz+QKo
	SVH5xYXbWvN/pJrZLyEDvSREXPqAY9aVMmis0Bt7R8qgBLtAXNuLRNmOWEMmULoTvRxMu/MFOnf
	O2YDsp0Kgj6Ua0GdJIAKi+I9UOZEQCkU07EJrhCcMZRi8wx4ep3xrnVeG2TqlLPsd332BFVvWEE
	4VgWf0WYP5nlQhBm2HJ9NMhstQXMKdX8=
X-Google-Smtp-Source: AGHT+IHMe/5gEMg5r0++v4ePAUtdrMnkeRZYRGazD6vR/8Czngk/4bbcLGPo6dtarHyEH+gQAJht3g==
X-Received: by 2002:a05:600c:3505:b0:439:8cbf:3e26 with SMTP id 5b1f17b1804b1-43ba66d5659mr108280575e9.4.1741016590931;
        Mon, 03 Mar 2025 07:43:10 -0800 (PST)
Received: from orome (p200300e41f187700f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f18:7700:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b792asm14768152f8f.53.2025.03.03.07.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:43:09 -0800 (PST)
Date: Mon, 3 Mar 2025 16:43:08 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Sheetal <sheetal@nvidia.com>, Ritu Chaudhary <rituc@nvidia.com>, 
	stable@vger.kernel.org, linux-sound@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ASoC: tegra: Fix ADX S24_LE audio format
Message-ID: <mhqpjehmhw57nljlq2e6ip3qisar7knxku5in3q4grnf3wfwj7@tj3ahtatgjv3>
References: <20250302225927.245457-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xjbbdfvz2jer6yos"
Content-Disposition: inline
In-Reply-To: <20250302225927.245457-2-thorsten.blum@linux.dev>


--xjbbdfvz2jer6yos
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND PATCH] ASoC: tegra: Fix ADX S24_LE audio format
MIME-Version: 1.0

On Sun, Mar 02, 2025 at 11:59:25PM +0100, Thorsten Blum wrote:
> Commit 4204eccc7b2a ("ASoC: tegra: Add support for S24_LE audio format")
> added support for the S24_LE audio format, but duplicated S16_LE in
> OUT_DAI() for ADX instead.
>=20
> Fix this by adding support for the S24_LE audio format.
>=20
> Compile-tested only.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 4204eccc7b2a ("ASoC: tegra: Add support for S24_LE audio format")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  sound/soc/tegra/tegra210_adx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Good catch!

Acked-by: Thierry Reding <treding@nvidia.com>

--xjbbdfvz2jer6yos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfFzgsACgkQ3SOs138+
s6FhkxAArQUlJi/PQPfUex/iHG7bwTxOAGpHP770c8QqjhekGFUQWErLQwNPqh3V
3Zv7+PUyqW2UlMuo7PyrUwPj+gl/uER8blYrm1JvDCHTFDU4d7L2EuxyFD6mHeCS
MYaAeCbmFtGV0BuGBDvUnLV1BXwNftTNaTXOwVuIdUFPlcJ0qpxC+yywv8giuO+q
Xm2wznbWHhBJXSBUtxvJ1AMOlIEqZdt3Lkb4fh57HCQ3KxgevTuyxy9V9gJLiRv0
L1pSleqGBNrCSmHEmiP0MGWebp1Q7zHueATkdZc6y9UvzoTjM2CEePq4xfaHvm63
IIsFXkTtTltzKjeLQDs2lWtG1V+ee+VH/oRYNgol37q/+gO05WhB8ZJmdRrBKjcI
rjj9WwLt2o4IPkNvR2scU6kWcjmvVwd52HtFU7wKd4C2HT49VyXn7rJenq8M11+l
ZV3a92+3X982h6vCbWNHcFk8RdOh7GDpJzYPqWXuHkzHfW0T32WqJhMbxhmBWcoU
eQ8nsz40ty3Hu5x/1ZH9q+6pSQSTD/UQM4lyOefMhc2+S3g5+eToTy8evwY2nbw3
oIFfZvoG5lIOloC+s/ZWlF8WSdN8itWMN9DvEC0sgcYHgYEImw8C+PR1zQz2uBRD
qDZXtvIMaFOepuc5z31E58rSx3s0HygoCGgslkqlOTkiR93ABdU=
=cRoZ
-----END PGP SIGNATURE-----

--xjbbdfvz2jer6yos--

