Return-Path: <stable+bounces-62371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6C593EE73
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F46281A30
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6A85931;
	Mon, 29 Jul 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="c6btUDAK"
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0F382495;
	Mon, 29 Jul 2024 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238231; cv=none; b=MJDlcuHkeQjERFoDRbyFRldzxFokd2+haEWNYNuLU1ftkjAUMFXXSvgIwXNlWxbKnN5STFrdfs55vbgqVR3yTryEskZjzMXiHkOPcH1GJNYeoNpxDCFxhkx966nEUSLNpGgGlMlZaJHALTfkFCvEPr9/Z8TVCeGMHZDckurmIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238231; c=relaxed/simple;
	bh=rzRnBMAhujuPKKOHrgTq3gIWFwMYpwLxxoLovIeXZQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmIRtBx8Y46a1yAcKKTj1ihzwyLNyUTTQPIV4nydonUYmjLe6CMuOtqbbxb2Nhq52ikcMLI1jWvI1xQdKKD/NVMQIzmcBywD8+VTH9PbAIyB9z1p9+tPhBVtqnRm5OcmBZf2j8xsTYmMYgvjok++25HCZ3BTzBwKaU6u+5nT77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=c6btUDAK; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 29E971C0099; Mon, 29 Jul 2024 09:30:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1722238220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zTd2KlVuLTT6I8hyqN4ws/kahOabpp6ySXuCYxyp4UE=;
	b=c6btUDAKxgnJ/3zWUO+AS/0e7p5fQlDuqBAebmmjiRJ7qXbmUtfGLS7ZXgUXnid6z9ZT29
	ilQ1vI9ylveQDXZggrse+QlAbskpQRjzt8xYkqw6IFpw6LM93YWVWd4S4acCoWec0HtaVS
	rsKIR2EZx6pZQ1QU3r2u4rypxHe7Q0c=
Date: Mon, 29 Jul 2024 09:30:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>, cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com, peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 02/11] ASoC: Intel: sof_sdw: Add quirks for
 some new Dell laptops
Message-ID: <ZqdFCzqqkEWFl8tA@duo.ucw.cz>
References: <20240728160954.2054068-1-sashal@kernel.org>
 <20240728160954.2054068-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QS4mOibUoRUapvlO"
Content-Disposition: inline
In-Reply-To: <20240728160954.2054068-2-sashal@kernel.org>


--QS4mOibUoRUapvlO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Charles Keepax <ckeepax@opensource.cirrus.com>
>=20
> [ Upstream commit 91cdecaba791c74df6da0650e797fe1192cf2700 ]
>=20
> Add quirks for some new Dell laptops using Cirrus amplifiers in a bridge
> configuration.

This is queued for 5.10, but not for 6.1. Mistake?

Best regards,
								Pavel

> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Link: https://msgid.link/r/20240527193552.165567-11-pierre-louis.bossart@=
linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/soc/intel/boards/sof_sdw.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/so=
f_sdw.c
> index 25bf73a7e7bfa..ad3694d36d969 100644
> --- a/sound/soc/intel/boards/sof_sdw.c
> +++ b/sound/soc/intel/boards/sof_sdw.c
> @@ -234,6 +234,22 @@ static const struct dmi_system_id sof_sdw_quirk_tabl=
e[] =3D {
>  		},
>  		.driver_data =3D (void *)(RT711_JD2_100K),
>  	},
> +	{
> +		.callback =3D sof_sdw_quirk_cb,
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0CE3")
> +		},
> +		.driver_data =3D (void *)(SOF_SIDECAR_AMPS),
> +	},
> +	{
> +		.callback =3D sof_sdw_quirk_cb,
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0CE4")
> +		},
> +		.driver_data =3D (void *)(SOF_SIDECAR_AMPS),
> +	},
>  	{}
>  };
> =20

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--QS4mOibUoRUapvlO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqdFCwAKCRAw5/Bqldv6
8jZSAKCFb+KQBMbfj8kZhJLkt4A7CAUFdwCeKq4szws9C2/4fnVjlejX07kGBqs=
=5VIV
-----END PGP SIGNATURE-----

--QS4mOibUoRUapvlO--

