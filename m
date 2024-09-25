Return-Path: <stable+bounces-77595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B7985EEF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AAC91F25201
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5CD219481;
	Wed, 25 Sep 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWsHTqa7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F1157468;
	Wed, 25 Sep 2024 12:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266406; cv=none; b=gEEX26zHwM+7V92mK0xgqYFOJiY+aJipoSy8Y7ZZKJctqXhgsDEPZtbykZvgQOjoK6SxMlbS671miZ5CS2iEbZM4vZMX68g1kxmuWHaIDB+pgcrjJzB82p6foI/8DJXpEYAdkwfslxO3UOTP2ycxX8g7rVX7PZaTqKoq+4DderQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266406; c=relaxed/simple;
	bh=+1y2qWX4I37sboGZ/CIyWvPaFcHrMk6++9l2cSkHugU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/UgjG/g7Ga2J+ixRMv8t5yD3W6znItLWGr0C3geAbqETZ+cZBRQtSjtWT7eA8e4LbaPo/Q5JZpZZZBPCKbVgI1COA2jjuFBL/tiB23ddKvY4M6nGJ3f/KYUaQk9XcQ+ryqPppHNXCe33kFfcW6dtnzF5Y2I+0Ei2fmFhU8nG9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWsHTqa7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9D2C4CECD;
	Wed, 25 Sep 2024 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266406;
	bh=+1y2qWX4I37sboGZ/CIyWvPaFcHrMk6++9l2cSkHugU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWsHTqa7uicmJR0AfRymwSTg8K2w/+Je+4e3h9kUvq8ikzJXPunzwftlbjAhqu04g
	 M8Y9b696C4OsSaErVnN+wsSkJw7IwKMkFGaLHYsCnKs4XsNj0k4i7rXOxmADFJk5qR
	 u/nv/JBmY2OpjGw+0KIIozcpzT1FLgVsNB8l/yhCXUZ3sXVNTZBPl/WnSb6qvfcrdp
	 6dDgrBMJuZCYKY4u4KpFenZu7UhK+KKIcKoh62pKncVdJgWJ2c9lfn+eN8HZsxIi+C
	 S9Gm6gPx7M5MOhIeYJR72/RZITfokdpy67vLvZtyU62f2/TuXbIz/zHI25hbJQ7ZzB
	 Dy6s1u3IMnZ6w==
Date: Wed, 25 Sep 2024 14:13:21 +0200
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Jerome Brunet <jbrunet@baylibre.com>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.11 109/244] ASoC: soc-pcm: Indicate warning if
 dpcm_playback/capture were used for availability limition
Message-ID: <ZvP-YQuXTyGDfb8x@finisterre.sirena.org.uk>
References: <20240925113641.1297102-1-sashal@kernel.org>
 <20240925113641.1297102-109-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qJJpRQInejXrpnv9"
Content-Disposition: inline
In-Reply-To: <20240925113641.1297102-109-sashal@kernel.org>
X-Cookie: Editing is a rewording activity.


--qJJpRQInejXrpnv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 07:25:30AM -0400, Sasha Levin wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> [ Upstream commit fd69dfe6789f4ed46d1fdb52e223cff83946d997 ]
>=20
> I have been wondering why DPCM needs special flag (=3D dpcm_playback/capt=
ure)
> to use it. Below is the history why it was added to ASoC.

=2E..

> Because of these history, this dpcm_xxx is unneeded flag today. But becau=
se
> we have been used it for 10 years since (B), it may have been used
> differently. For example some DAI available both playback/capture, but it
> set dpcm_playback flag only, in this case dpcm_xxx flag is used as
> availability limitation. We can use playback_only flag instead in this
> case, but it is very difficult to find such DAI today.
>=20
> Let's add grace time to remove dpcm_playback/capture flag.
>=20
> This patch don't use dpcm_xxx flag anymore, and indicates warning to use
> xxx_only flag if both playback/capture were available but using only
> one of dpcm_xxx flag, and not using xxx_only flag.

This is a cleanup/refactoring preparation patch, I can see no reason why
it would be considered for stable.

--qJJpRQInejXrpnv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbz/mAACgkQJNaLcl1U
h9AlKQf/actvaVQqut6lkvX9H4EC03wsHESIYk/mIlv1AY/S2Z8XAnnZJKgihREa
Rw7Gpz57S/gnBAOUzRLARFVuN/JfWnThVHpCnnhwdM/REUe/ilLuw2Vfqmj1ZEsd
0yOypEvwgKiy88ncpS+hic56KuzZ7DuX+AyVAf7OMQJui73oCaKKOFxQHj3BRrs3
cMqdY/G2JfHqbexQqw0jzg0kuhoLpUWYNMpga5IckBlrZBFgACZvn407nGEurpuu
yd0fusSRVRpb4hcAOb85sO+zNVyOyGSQQsGppT7pGQlqxbxpUUblk5OLL6qgvOBo
+oVk/YDapmFe9QfP2uOvmjVRhbk37g==
=IIv9
-----END PGP SIGNATURE-----

--qJJpRQInejXrpnv9--

