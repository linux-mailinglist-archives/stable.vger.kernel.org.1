Return-Path: <stable+bounces-2898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38787FBC25
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 15:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A441C20C91
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69959B7E;
	Tue, 28 Nov 2023 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB2Ss/sy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB25788D
	for <stable@vger.kernel.org>; Tue, 28 Nov 2023 14:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE82EC433C8;
	Tue, 28 Nov 2023 14:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701180330;
	bh=PWGD0Q+7jbU/hEhE2QDdSvpUB2FcPsMgtik10UeqFfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GB2Ss/syOaatgt0ijiEYYAdOHi6DQMOmGfbn5GB2udg59QWQ7oETGvh+H+woSOZP+
	 ftS3Yjk8X2DwVDg2xUpkjniIgWHOEJtIyZWn4rT3WXoL7rrSf4Ry1e3TsJekkuxOAr
	 nypBNSGUW4k4cCITq2KpHiuEUU5MxfMxPNGjGyw8IIW/c1UCuP876ta7a98sX5ODVh
	 OsEsqywYmXOiRjXc/k7GiLEYch20MOt/DM/takQdyVg1Dkg753FUvTnzxJhB7Vh3ao
	 ZoCgj4HtC1AFJE6ZxXfGNKwAGdfnjKnpMF8y+3ToIeoT24ErcgslNbz718R8UdThRD
	 /xiPUnrBk11Ng==
Date: Tue, 28 Nov 2023 14:05:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Malcolm Hart <malcolm@5harts.com>
Cc: Sven Frotscher <sven.frotscher@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS
 E1504FA
Message-ID: <a161321c-a2b9-44a6-bc7b-ab2096916108@sirena.org.uk>
References: <875y1nt1bx.fsf@5harts.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FFflOKuc5OBmUHnu"
Content-Disposition: inline
In-Reply-To: <875y1nt1bx.fsf@5harts.com>
X-Cookie: Must be over 21.


--FFflOKuc5OBmUHnu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 07:42:30PM +0000, Malcolm Hart wrote:
>=20
> This patch adds ASUSTeK COMPUTER INC  "E1504FA" to the quirks file acp6x-=
mach.c
> to enable microphone array on ASUS Vivobook GO 15.
> I have this laptop and can confirm that the patch succeeds in enabling the
> microphone array.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--FFflOKuc5OBmUHnu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVl86UACgkQJNaLcl1U
h9Cp0Af+N36G4l8WUklwNAG97NB3FEtabA1JGwkPGEiTJAhe+c4fEGwJ5KXznAMf
1Y1ViSm1vS03Vet3yTJ9W0LxX9paf3sqw3lduADaulVHzztJ8KGDDydeFUqGKnr/
WEAzukqd8omhr2it6KyvNDdCozGon2qvnFSwSrsEKrjA4o1ZmLs2QKGDkgg9pI3U
UiktthHN1ZAHMBKMkSb+fkBy7zTSgUGfF6/9/VWvlbtIKk7sMlYXVUDkXUcPMC2U
XR/W4qC2nwkcXgBbYws3O4U+hXIaXULGXmM7pZIMbS8QW6c5oGduONzTqddmmx+h
Mmjs18l+JbOlOp4ko9X5jXY0w3NYpQ==
=vkEH
-----END PGP SIGNATURE-----

--FFflOKuc5OBmUHnu--

