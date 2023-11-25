Return-Path: <stable+bounces-2579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B167F8A2C
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 12:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF505B21204
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 11:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D60D260;
	Sat, 25 Nov 2023 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542A10D2;
	Sat, 25 Nov 2023 03:20:54 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3582E1C0075; Sat, 25 Nov 2023 12:20:53 +0100 (CET)
Date: Sat, 25 Nov 2023 12:20:52 +0100
From: Pavel Machek <pavel@denx.de>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 00/97] 4.19.300-rc1 review
Message-ID: <ZWHYlErVfVq8ZoOu@duo.ucw.cz>
References: <20231124171934.122298957@linuxfoundation.org>
 <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FBNykcPuWLgRbkZS"
Content-Disposition: inline
In-Reply-To: <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>


--FBNykcPuWLgRbkZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is the start of the stable review cycle for the 4.19.300 release.
> > There are 97 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>=20
> We see this failure on Arm32:
> And this one on Arm64:

We see problems on arm, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
084460512

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FBNykcPuWLgRbkZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWHYlAAKCRAw5/Bqldv6
8orgAJ4qUVJtXMEBMIG/WjJVlO3VV9bJuQCgiL5jlGqybMvaoRkRL8vqKLQeuac=
=7NUb
-----END PGP SIGNATURE-----

--FBNykcPuWLgRbkZS--

