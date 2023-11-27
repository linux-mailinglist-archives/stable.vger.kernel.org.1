Return-Path: <stable+bounces-2820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E25C7FAC09
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 21:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696DFB20D8D
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094331735;
	Mon, 27 Nov 2023 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A719E187;
	Mon, 27 Nov 2023 12:51:56 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F2F241C006B; Mon, 27 Nov 2023 21:51:53 +0100 (CET)
Date: Mon, 27 Nov 2023 21:51:53 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, alexander.deucher@amd.com,
	mario.limonciello@amd.com, zhujun2@cmss.chinamobile.com,
	sashal@kernel.org, ilpo.jarvinen@linux.intel.com,
	skhan@linuxfoundation.org, bhelgaas@google.com
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Message-ID: <ZWUBaYipygLMkfjz@duo.ucw.cz>
References: <20231125163059.878143365@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aS+HeFcddLzqPNO3"
Content-Disposition: inline
In-Reply-To: <20231125163059.878143365@linuxfoundation.org>


--aS+HeFcddLzqPNO3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.14.331 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Fix UBSAN array-index-out-of-bounds for Polaris and Tonga
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Fix UBSAN array-index-out-of-bounds for SMU7

I believed that the agreement with maintarner was that these are not
suitable for stable? There's no actual bug, but UBSAN warns anyway...

> zhujun2 <zhujun2@cmss.chinamobile.com>
>     selftests/efivarfs: create-read: fix a resource leak

This is wrong. It is patching userland code, there's no memory leak,
kernel closes file descriptors upon task exit.

> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>     RDMA/hfi1: Use FIELD_GET() to extract Link Width

This is a good cleanup, but not a bugfix.

> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>     atm: iphase: Do PCI error checks on own line

Just a cleanup, not sure why it was picked for stable.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aS+HeFcddLzqPNO3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWUBaQAKCRAw5/Bqldv6
8vVIAJoC6MEZhGVojWBDPnGrhj3/RVltlACglWuJJascQwpTP3+74/MnPTWwmGw=
=LkKs
-----END PGP SIGNATURE-----

--aS+HeFcddLzqPNO3--

