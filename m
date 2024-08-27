Return-Path: <stable+bounces-70337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28009960A1F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97EDB21592
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DA61B5314;
	Tue, 27 Aug 2024 12:26:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901A1B4C24;
	Tue, 27 Aug 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761573; cv=none; b=WsR+V7YHB0/QEj8PbizrZ3hIV9qu1C5AFCXwrc8BhQRLya0W0F5/3eWXu0nbRshScKrndvH3xQmpzubcfrpfhi3US9OhgPpvkhjYqHdQwnyW4y7rzh7Kq2zV9PSppEOH9Sq4dSENzAuakMp1rfYRqh6JLwwgRSD51gOkwjG7rgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761573; c=relaxed/simple;
	bh=zvVebIsWAlJ8QkELiQXoohTKQj4SJCXpgtbrW33XvsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgSP/UwCW82za0voI2UfLtc1JXhcQl85wu1bJZSLDVF5YRchFJuR9YG/LEniWm/MmqJWITduKysFAVEoVZu3F6g010eII3FNYns/PAVB1RZoKsWyc98yJnQLd2nv6TGLC3uobD+GdBi76NoEq+1YU86kRzqP0St7OPwBdIGtMY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 197D51C009E; Tue, 27 Aug 2024 14:26:10 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:26:09 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Paul Menzel <pmenzel@molgen.mpg.de>,
	Jaroslav Kysela <perex@perex.cz>, tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.10 26/38] ALSA: vmaster: Return error for
 invalid input values
Message-ID: <Zs3F4Xp/2WfTJjli@duo.ucw.cz>
References: <20240801003643.3938534-1-sashal@kernel.org>
 <20240801003643.3938534-26-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b3yops5eByklRyDt"
Content-Disposition: inline
In-Reply-To: <20240801003643.3938534-26-sashal@kernel.org>


--b3yops5eByklRyDt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Takashi Iwai <tiwai@suse.de>
>=20
> [ Upstream commit 10457f5042b4890a667e2f15a2e783490dda44d2 ]
>=20
> So far the vmaster code has been tolerant about the input values and
> accepts any values by correcting internally.  But now our own selftest
> starts complaining about this behavior, so let's be picky and change
> the behavior to return -EINVAL for invalid input values instead.

Does it fix a bug serious enough for -stable?

Best regards,
								Pavel

> +++ b/sound/core/vmaster.c
> @@ -204,6 +204,12 @@ static int follower_put(struct snd_kcontrol *kcontro=
l,
>  	err =3D follower_init(follower);
>  	if (err < 0)
>  		return err;
> +	for (ch =3D 0; ch < follower->info.count; ch++) {
> +		if (ucontrol->value.integer.value[ch] < follower->info.min_val ||
> +		    ucontrol->value.integer.value[ch] > follower->info.max_val)
> +			return -EINVAL;
> +	}
> +
>  	for (ch =3D 0; ch < follower->info.count; ch++) {
>  		if (follower->vals[ch] !=3D ucontrol->value.integer.value[ch]) {
>  			changed =3D 1;
> @@ -344,6 +350,8 @@ static int master_put(struct snd_kcontrol *kcontrol,
>  	new_val =3D ucontrol->value.integer.value[0];
>  	if (new_val =3D=3D old_val)
>  		return 0;
> +	if (new_val < master->info.min_val || new_val > master->info.max_val)
> +		return -EINVAL;
> =20
>  	err =3D sync_followers(master, old_val, new_val);
>  	if (err < 0)

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--b3yops5eByklRyDt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3F4QAKCRAw5/Bqldv6
8mnzAKC+I46IgPijebkMd8eNpfSGO5Fs1wCghMcYHOhWs3vZNlMEGfonq5vj8m0=
=d/8A
-----END PGP SIGNATURE-----

--b3yops5eByklRyDt--

