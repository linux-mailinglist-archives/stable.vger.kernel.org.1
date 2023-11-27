Return-Path: <stable+bounces-2757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46527FA13A
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 14:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E6C1C20C76
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 13:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFD2FE0F;
	Mon, 27 Nov 2023 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpqEIMdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21C12E408;
	Mon, 27 Nov 2023 13:41:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B674C433C8;
	Mon, 27 Nov 2023 13:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701092501;
	bh=f3BQHuMYi7jlc3CvTz+C/tQdYT/Mcv85re4DWN0keTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PpqEIMdln6ZmmiZtmAWKq/siGwB3UxlsVq7rZTD+fWjb7rC97XFbYgpQrjb2krMIq
	 8Sy00hO4zsqDYcRRTVkw01jSdozpS2oSA2o/FPwRrEC4sBJH7FE1rqZnEqziJgFgVm
	 T99Gl31xIRII/AwJFUIWTZbRHnVWkuqgKyVF5mpeBGB/iQ2jgnHfIqsmbezzQz6E5c
	 lUrAMVx8nwxXypNLP0/hrW5VAvXKMXknPgH2eGsA7aj6pIuN7sEM3Rw4tVvOw2VoL1
	 Ib6v8nnM6Iuy2mguXAcMElJgwomBPccDetFEVnxxT490vHUfSaaCvPsXnuLseio6S3
	 W//aHq0/6gJYQ==
Date: Mon, 27 Nov 2023 13:41:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Malcolm Hart <malcolm@5harts.com>
Cc: Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
	alsa-devel@alsa-project.org, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA
Message-ID: <ZWSckMPyqJl4Ebib@finisterre.sirena.org.uk>
References: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g8U18o2ouH88KqKG"
Content-Disposition: inline
In-Reply-To: <b9dd23931ee8709a63d884e4bd012723c9563f39.camel@5harts.com>
X-Cookie: Slow day.  Practice crawling.


--g8U18o2ouH88KqKG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 12:24:59PM +0000, Malcolm Hart wrote:
> Like other ASUS models the Asus Vivobook E1504FA requires an entry in
> the quirk list to enable the internal microphone.
>=20
> Showing
> with 7 additions and 0 deletions.
> 7 changes: 7 additions & 0 deletions 7
> sound/soc/amd/yc/acp6x-mach.c
> @@ -283,6 +283,13 @@ static const struct dmi_system_id
> yc_acp_quirk_table[] =3D {

The patch appears to have been unusably corrupted by your e-mail
software and is also missing a Signed-off-by.  See email-cleints.rst for
some suggestions on configuring things, or it might be worth looking
into b4 and it's web submission endpoint:

   https://b4.docs.kernel.org/en/latest/

--g8U18o2ouH88KqKG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVknI8ACgkQJNaLcl1U
h9DEbQf/VOKtiPwxU5ySd49oW4bpnDNSU118nM6uQupgCYR/yaVImX1SSm0oLZjg
BKYm5jaj1zChar2emI33Jev2ffjqGLOn2XHM9eyn2APjiQtB8stIHZIi1qj5Pkeu
iApaUpc1g4Esia9606uptwLk/YDydl1P5qWs/0guseaJISnU76hIxQ4E96R4uB7z
HCMDac9KRvihvI9eD7GoJ4fNiOhAJZe+9BJfx3JBsR8ctnjHdeq8sjwOWeeg3lNZ
VxSzoyf8IjQLlJZ1wC0lB3MAUsmPEqvSD4t2yFGEuMULbaGeOtn2gcemHxLm9uKd
K9XEZ4NPqhBzUi8+qn9V1I0UxTDsqw==
=DBJx
-----END PGP SIGNATURE-----

--g8U18o2ouH88KqKG--

