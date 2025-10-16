Return-Path: <stable+bounces-186182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD35BE5150
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 20:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06E764EC21B
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D88B23815C;
	Thu, 16 Oct 2025 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb4DVjr4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F96235BEE
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 18:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640039; cv=none; b=YD32AuT7rpMEZFBYGgjaEMWnGV0MD3fJbR0RMFbpmfSW9GnFcEydFmFSRcmNxmDfRC2zXPhMAFmSkJq/r6tTXgp9XafVzFEWxDC4S53VzCvfmcA4x6ZhXBFZipSce2mc/QLrOE3YBwo9xdcQh8MMqC+eKUJVKAtKLF/tue99HYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640039; c=relaxed/simple;
	bh=5QysmaokXLn3WO6Gp92GJ+wwsN+FNCg2fB1fyWLq7Tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YP3k6Z6RtBowRKvDM4+d3yhPZocs2UZBHWv/ekG0HxayA0nfPq0NxhttUncn3McKj8SYCif8DIFX3SoRMityI9do7kRXB1UDLrFVHwX1Xy3JArjAOSSZ8lZGbXFeOQzjzsAS6ILGUz6oJHng7H0RF0CV8sZjWlagrsQcbgE9kKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb4DVjr4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-427060bc0f5so31595f8f.3
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640035; x=1761244835; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gVrVN0cURT8XxOWEND/toDNC6BEXYqhiqrr2ZmhC6Wg=;
        b=Kb4DVjr4P8bzQkdC6frJlmNGatQhd6iQxGC7D7VWMo1gddZHd8qoiB5WW9eAzT1A4N
         KjDaMdaWQt2diQJURY3BrxTJSVrIoG0lrlFu0Lg4/nfuIny800GFeOWoe6/0Ys/KxNRW
         RJTSKJwXMkmTOXBYqnn5BzLWomDqmOPdrwHUQoVS3n1FsScRSHRlxsrgCKjp/NARDV/P
         ozot9zUmZMMU7SwN5sQdej3O1YkcIKM9XAlC5mOs+22Rb8RZJDQd8NMC1hRxY6eqVsvC
         jwrwWRRMt1OgJoaHxvFN7sdL7pGPMfJCSwqcpdlAQyRQ6i9mG3ojDllxSUsEaUMJJY1R
         8MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640035; x=1761244835;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gVrVN0cURT8XxOWEND/toDNC6BEXYqhiqrr2ZmhC6Wg=;
        b=SLC+oVptBftYYW5Wvtw2cTrcuu2Mb/CG0lXv2/tbnu6hy7Lmv4V3v4y6LmzOQjeBfn
         L55FVIPDJ/7ZVXy5fgWVrhkQVlcThikJt3PZpplWV7KeQECKvL3mXKT7EKVHW3XnFWx/
         xYF4UZtOPa8esMyBFZEPlwvi/5horSSFWoD2lmwRQkObO/YXn1pOOwc1w77+1YCMh0Qq
         I03HrefazwubOK2Ih7QbCMF0B7VsxUlwUJErGQnMFPKYrGOcK3TWxZDY53z9c8m1flMW
         v67S7+v+OpUxBd2zHK18uvAVkZocvzBD89N+eDOqzVA3lleUbHXfM7eQTZ1KxwaDgEQN
         wSCA==
X-Forwarded-Encrypted: i=1; AJvYcCWuqmbObZQWyDA0tJmNAPaMzXo7KcAQWPrxqBC9aoNxrmFaLJ1LhVTGsOd16DfqjPK4lKMG8pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEZTiEVJsIxgP4u2cp+N26qMHaoAq+mlAQuwyo/wCvwzm+tC1
	y5K3Kaq2FdCBoZGuChFrmc2GbwTNH+aJdInzKnsGHzH/lyf8hMm1qGun
X-Gm-Gg: ASbGnctgvBvvU9gg6ubh036Xt1Pdv9p4TtaAADx1/lVYW8ZM3j9IUSZGNf5uxImTbvC
	jwEcOgayFUwbihIDccdsvsZ5FZps9qxAFV+CnFGUlZ7pzWu5uAPCOCJ7sUCWqocGs4tG3yQL79t
	dHhbU+92n1DkDB4TTm6qjG1E/8zIKAY2sVZ/kmtTbIlGbbD9KyAbLazSReusNy7wOPqyCiEYrtW
	0WwjlYUyPKZx/26aeYRwRUhqF1FL9qvsIPjYackC2hnZ9Hv9ZOTm4MnRrZCa5m1235rV4npiu5/
	DqyKffFdglN/HxDtiun6szJYh3iRfz+wW2Gol1vZ/u8JeN/oEhtFVkr4XGqQ6tFStdjj1NTl1B+
	dJ4VdWniJ9867D64u/pYLL0LnWPBK1dRWSBqYbkWiq15U85+3JSaHoeKT4rqEOqi4B7ycwR0aRm
	9oqdzn8/txB0MAoOVxzRViIknLhyrlgUU5j2IaCix8Gs3YilqYGLRrHLk/
X-Google-Smtp-Source: AGHT+IFtecOfZqgKKUQdQobTvSoWGjsWAXnz5FwPdqEhfoodXPkAZsFTaly51YsTEiMSfFcc5ooSyw==
X-Received: by 2002:a05:6000:4301:b0:3e5:47a9:1c7f with SMTP id ffacd0b85a97d-42704e043c1mr799792f8f.47.1760640035343;
        Thu, 16 Oct 2025 11:40:35 -0700 (PDT)
Received: from 0.1.2.1.2.0.a.2.dynamic.cust.swisscom.net ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm35643266f8f.40.2025.10.16.11.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:40:34 -0700 (PDT)
Message-ID: <60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>, David Rhodes	
 <david.rhodes@cirrus.com>, Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela	 <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Nikita Shubin	 <nikita.shubin@maquefel.me>,
 Axel Lin <axel.lin@ingics.com>, Brian Austin	 <brian.austin@cirrus.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
	 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Date: Thu, 16 Oct 2025 20:40:34 +0200
In-Reply-To: <20251016130340.1442090-2-herve.codina@bootlin.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
	 <20251016130340.1442090-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Herve,

On Thu, 2025-10-16 at 15:03 +0200, Herve Codina wrote:
> In commit c973b8a7dc50 ("ASoC: cs4271: Split SPI and I2C code into
> different modules") the driver was slit into a core, an SPI and an I2C
> part.
>=20
> However, the MODULE_DEVICE_TABLE(of, cs4271_dt_ids) was in the core part
> and so, module loading based on module.alias (based on DT compatible
> string matching) loads the core part but not the SPI or I2C parts.
>=20
> In order to have the I2C or the SPI module loaded automatically, move
> the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
> Also move cs4271_dt_ids itself from the core part to I2C and SPI parts
> as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_dt_ids
> table itself need to be in the same file.

I'm a bit confused by this change.
What do you have in SYSFS "uevent" entry for the real device?

If you consider spi_uevent() and i2c_device_uevent(), "MODALIAS=3D" in the
"uevent" should be prefixed with either "spi:" or "i2c:".
And this isn't what you adress in your patch.

You provide [identical] "of:" prefixed modalias to two different modules
(not sure, how this should work), but cs4271 is not an MMIO device,
so it should not generate an "of:" prefixed uevent.

Could you please show the relevant DT snippet for the affected HW?

> Fixes: c973b8a7dc50 ("ASoC: cs4271: Split SPI and I2C code into different=
 modules")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0sound/soc/codecs/cs4271-i2c.c | 6 ++++++
> =C2=A0sound/soc/codecs/cs4271-spi.c | 6 ++++++
> =C2=A0sound/soc/codecs/cs4271.c=C2=A0=C2=A0=C2=A0=C2=A0 | 9 ---------
> =C2=A0sound/soc/codecs/cs4271.h=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A04 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/sound/soc/codecs/cs4271-i2c.c b/sound/soc/codecs/cs4271-i2c.=
c
> index 1d210b969173..cefb8733fc61 100644
> --- a/sound/soc/codecs/cs4271-i2c.c
> +++ b/sound/soc/codecs/cs4271-i2c.c
> @@ -28,6 +28,12 @@ static const struct i2c_device_id cs4271_i2c_id[] =3D =
{
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
> =C2=A0
> +static const struct of_device_id cs4271_dt_ids[] =3D {
> +	{ .compatible =3D "cirrus,cs4271", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
> +
> =C2=A0static struct i2c_driver cs4271_i2c_driver =3D {
> =C2=A0	.driver =3D {
> =C2=A0		.name =3D "cs4271",
> diff --git a/sound/soc/codecs/cs4271-spi.c b/sound/soc/codecs/cs4271-spi.=
c
> index 4feb80436bd9..82abc654293c 100644
> --- a/sound/soc/codecs/cs4271-spi.c
> +++ b/sound/soc/codecs/cs4271-spi.c
> @@ -23,6 +23,12 @@ static int cs4271_spi_probe(struct spi_device *spi)
> =C2=A0	return cs4271_probe(&spi->dev, devm_regmap_init_spi(spi, &config))=
;
> =C2=A0}
> =C2=A0
> +static const struct of_device_id cs4271_dt_ids[] =3D {
> +	{ .compatible =3D "cirrus,cs4271", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
> +
> =C2=A0static struct spi_driver cs4271_spi_driver =3D {
> =C2=A0	.driver =3D {
> =C2=A0		.name	=3D "cs4271",
> diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
> index 6a3cca3d26c7..ff9c6628224c 100644
> --- a/sound/soc/codecs/cs4271.c
> +++ b/sound/soc/codecs/cs4271.c
> @@ -543,15 +543,6 @@ static int cs4271_soc_resume(struct snd_soc_componen=
t *component)
> =C2=A0#define cs4271_soc_resume	NULL
> =C2=A0#endif /* CONFIG_PM */
> =C2=A0
> -#ifdef CONFIG_OF
> -const struct of_device_id cs4271_dt_ids[] =3D {
> -	{ .compatible =3D "cirrus,cs4271", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
> -EXPORT_SYMBOL_GPL(cs4271_dt_ids);
> -#endif
> -
> =C2=A0static int cs4271_component_probe(struct snd_soc_component *compone=
nt)
> =C2=A0{
> =C2=A0	struct cs4271_private *cs4271 =3D snd_soc_component_get_drvdata(co=
mponent);
> diff --git a/sound/soc/codecs/cs4271.h b/sound/soc/codecs/cs4271.h
> index 290283a9149e..4965ce085875 100644
> --- a/sound/soc/codecs/cs4271.h
> +++ b/sound/soc/codecs/cs4271.h
> @@ -4,7 +4,6 @@
> =C2=A0
> =C2=A0#include <linux/regmap.h>
> =C2=A0
> -extern const struct of_device_id cs4271_dt_ids[];
> =C2=A0extern const struct regmap_config cs4271_regmap_config;
> =C2=A0
> =C2=A0int cs4271_probe(struct device *dev, struct regmap *regmap);

--=20
Alexander Sverdlin.

