Return-Path: <stable+bounces-2940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9986B7FC5A2
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D6D1C20F1B
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3032C71;
	Tue, 28 Nov 2023 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A819A4;
	Tue, 28 Nov 2023 12:40:52 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 023071C006B; Tue, 28 Nov 2023 21:40:51 +0100 (CET)
Date: Tue, 28 Nov 2023 21:40:50 +0100
From: Pavel Machek <pavel@denx.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Pavel Machek <pavel@denx.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, maz@kernel.org,
	andy.shevchenko@gmail.com, brgl@bgdev.pl, wangyouwan@126.com,
	jani.nikula@intel.com, ilpo.jarvinen@linux.intel.com,
	dan.carpenter@linaro.org
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
Message-ID: <ZWZQUs+j7RufSr42@duo.ucw.cz>
References: <20231126154335.643804657@linuxfoundation.org>
 <ZWUJWhOkbHlwC2YB@duo.ucw.cz>
 <eb4fb7bc-93db-4868-8807-f97f5da59b23@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8xjeWcaMtup4EWMI"
Content-Disposition: inline
In-Reply-To: <eb4fb7bc-93db-4868-8807-f97f5da59b23@opensource.cirrus.com>


--8xjeWcaMtup4EWMI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2023-11-28 10:42:51, Richard Fitzgerald wrote:
> On 27/11/2023 21:25, Pavel Machek wrote:
> >=20
> > > Richard Fitzgerald <rf@opensource.cirrus.com>
> > >      ASoC: soc-card: Add storage for PCI SSID
> >=20
>=20
> The driver that depends on this only went into the kernel at v6.4.

Thanks. So it would be good to drop this from 5.10 and 6.1.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8xjeWcaMtup4EWMI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWZQUgAKCRAw5/Bqldv6
8tF1AJ9emR7+DzyJ1m8K3FjE7wbtHwhOPgCfdkSmE4wI//xzb5O5Y763bR48Hyk=
=HjWp
-----END PGP SIGNATURE-----

--8xjeWcaMtup4EWMI--

