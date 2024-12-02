Return-Path: <stable+bounces-95999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507DC9E0130
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 13:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6091614D7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E65B1FE474;
	Mon,  2 Dec 2024 12:01:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28F1D95A9;
	Mon,  2 Dec 2024 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733140877; cv=none; b=PzxcUhcv+c7KTV2BEtzQ+PilyKMpioxQm5knVYiLFCifZvlXJgRn6Pujia52Lin248LrDSd4SzEc9djRb5RaoB9wxhgtpNVxECSWBhKeadFD26yz8d8Gf53u5oje1E2SEhTeDgWDHa3vPpbEngi2EYjsgvpdvu7QmPqVFqkI6U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733140877; c=relaxed/simple;
	bh=qN7zSp52L2v1SA9YKpv1TumbOqlVeIrH+RB98EjRP+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KirvsyIVzcLS3MEnA0Qg9+OP06q8TzMZQLA2Cb9E/LCw5nPCqOF8DSjVAEuMVJM1QlsOefdSE3iW/PzsjcVI23TCHhTGoAFbuWCX8geRPFFdeDogKfEFA3kTxI5F9iI3CXLcmCi6+BWu/oJmIEPUV2D4NqcniEh2Mmg9JCMvwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 18A7A1C00A0; Mon,  2 Dec 2024 13:01:12 +0100 (CET)
Date: Mon, 2 Dec 2024 13:01:11 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>, olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 4/6] ASoC: stm: Prevent potential division
 by zero in stm32_sai_mclk_round_rate()
Message-ID: <Z02hh/K7okT4fvOc@duo.ucw.cz>
References: <20241112103803.1654174-1-sashal@kernel.org>
 <20241112103803.1654174-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3fawmNHJI3c1oRFq"
Content-Disposition: inline
In-Reply-To: <20241112103803.1654174-4-sashal@kernel.org>


--3fawmNHJI3c1oRFq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 63c1c87993e0e5bb11bced3d8224446a2bc62338 ]
>=20
> This patch checks if div is less than or equal to zero (div <=3D 0). If
> div is zero or negative, the function returns -EINVAL, ensuring the
> division operation (*prate / div) is safe to perform.

Well, previous version propagated error code, now it is eaten. Is
stm32_sai_get_clk_div returning 0?

BR,
								Pavel

> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> Link: https://patch.msgid.link/20241106014654.206860-1-luoyifan@cmss.chin=
amobile.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/soc/stm/stm32_sai_sub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
> index 3aa1cf2624020..3a7f0102b4c5c 100644
> --- a/sound/soc/stm/stm32_sai_sub.c
> +++ b/sound/soc/stm/stm32_sai_sub.c
> @@ -380,8 +380,8 @@ static long stm32_sai_mclk_round_rate(struct clk_hw *=
hw, unsigned long rate,
>  	int div;
> =20
>  	div =3D stm32_sai_get_clk_div(sai, *prate, rate);
> -	if (div < 0)
> -		return div;
> +	if (div <=3D 0)
> +		return -EINVAL;
> =20
>  	mclk->freq =3D *prate / div;
> =20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3fawmNHJI3c1oRFq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ02hhwAKCRAw5/Bqldv6
8hAkAKC0b/Oh8ldKHa90Tlm10HU7ITeWowCgxMxATUX7/rKamYpZAx5Mk1HHjC8=
=I7ba
-----END PGP SIGNATURE-----

--3fawmNHJI3c1oRFq--

