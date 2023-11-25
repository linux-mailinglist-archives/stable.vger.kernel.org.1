Return-Path: <stable+bounces-2578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB37F8A2A
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 12:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A6B1C20C1B
	for <lists+stable@lfdr.de>; Sat, 25 Nov 2023 11:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720BD260;
	Sat, 25 Nov 2023 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DF2D41;
	Sat, 25 Nov 2023 03:19:47 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2C3471C0072; Sat, 25 Nov 2023 12:19:45 +0100 (CET)
Date: Sat, 25 Nov 2023 12:19:44 +0100
From: Pavel Machek <pavel@denx.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/372] 6.1.64-rc1 review
Message-ID: <ZWHYUP+i7G63YKwl@duo.ucw.cz>
References: <20231124172010.413667921@linuxfoundation.org>
 <20231124222543.qaM-plhi@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HE6FFvPMiZOVfFmC"
Content-Disposition: inline
In-Reply-To: <20231124222543.qaM-plhi@linutronix.de>


--HE6FFvPMiZOVfFmC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This is the start of the stable review cycle for the 6.1.64 release.
> > There are 372 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>=20
> I got the following build error with riscv64 defconfig:

We got build failure on riscv, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
084460710

Best regards,
										Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HE6FFvPMiZOVfFmC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWHYUAAKCRAw5/Bqldv6
8tzBAKC3g1GNjymD4OWMrQZGQhk50RiBZgCfb4/N1KUceaBC6oNvkSNBxDm0Uew=
=KxxZ
-----END PGP SIGNATURE-----

--HE6FFvPMiZOVfFmC--

