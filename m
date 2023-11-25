Return-Path: <stable+bounces-2607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD177F8C84
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 17:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B5728150E
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 16:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B4B23750;
	Sat, 25 Nov 2023 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41D13A;
	Sat, 25 Nov 2023 08:44:28 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 429C91C0071; Sat, 25 Nov 2023 17:44:26 +0100 (CET)
Date: Sat, 25 Nov 2023 17:44:25 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@denx.de>,
	Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org
Subject: Re: [PATCH 4.19 00/97] 4.19.300-rc1 review
Message-ID: <ZWIkab2PnalL4ZmF@duo.ucw.cz>
References: <20231124171934.122298957@linuxfoundation.org>
 <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>
 <ZWHYlErVfVq8ZoOu@duo.ucw.cz>
 <2023112518-traverse-unsecured-daa2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p9lJ+2E6bbm/ygVf"
Content-Disposition: inline
In-Reply-To: <2023112518-traverse-unsecured-daa2@gregkh>


--p9lJ+2E6bbm/ygVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > This is the start of the stable review cycle for the 4.19.300 relea=
se.
> > > > There are 97 patches in this series, all will be posted as a respon=
se
> > > > to this one.  If anyone has any issues with these being applied, pl=
ease
> > > > let me know.
> > >=20
> > > We see this failure on Arm32:
> > > And this one on Arm64:
> >=20
> > We see problems on arm, too:
> >=20
> > https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelin=
es/1084460512
>=20
> Note, posting odd links isn't going to really help much, I don't have
> the cycle, and sometimes the connectivity (last few stable releases were
> done on trains and planes), to check stuff like this.
>=20
> Info in an email is key, raw links is not going to help, sorry.

Resources are limited on this side, too, but I'll try to keep it in
mind.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--p9lJ+2E6bbm/ygVf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWIkaQAKCRAw5/Bqldv6
8ipoAJ46UKxBTpiIYGQrYRakF9KCHkzNRgCgprqo2Zt1ep2pO7ha5S2jLNoPq84=
=1inI
-----END PGP SIGNATURE-----

--p9lJ+2E6bbm/ygVf--

