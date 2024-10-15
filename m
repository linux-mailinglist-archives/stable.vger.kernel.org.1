Return-Path: <stable+bounces-85094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A622F99DE5D
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 08:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 362E2B21F3E
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E518A6CC;
	Tue, 15 Oct 2024 06:29:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18123173320;
	Tue, 15 Oct 2024 06:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728973792; cv=none; b=FlwZ0lI+J0FR8d1A1ysKkqMCnNsdS6BVlL3pUOvOqIggUFm3pZ+T4jdbtISNJR7HMj36sMMs4qZJq2Mb6gNEDIytMCQr8jIxjl3X+z9nIifJpdkC5TrTGOm/lcOn77yovOJ/l1dUGItl/d8d1+P7TQLWF2Unptzhw3SWB0ECG4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728973792; c=relaxed/simple;
	bh=J8RkUhuHWNVGsBrqmHNDANwqRPCWU4gWwViHGogZ1U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLEQlMOl/XhdHDw2CrFJTGppNDiumZYuGxr7zf9mchEkHF3Mm6sJZflATBHwWAeztt9wHX9kT8JOE/PHEcYxlsrnQJLAUFNb9lqGcVcqMi4NbieFOJvkwhH8qdyyu9mHXu3Q+eLkfYzB0veMRveK8HRpAwmdwpQ92dJPnd+pYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 73F441C0086; Tue, 15 Oct 2024 08:29:41 +0200 (CEST)
Date: Tue, 15 Oct 2024 08:29:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
Message-ID: <Zw4L1ZR1pBNksjwV@duo.ucw.cz>
References: <20241014141217.941104064@linuxfoundation.org>
 <3ab1938a-6f6a-4664-9991-d196e684974d@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5suPJ6AZaEeQGZnT"
Content-Disposition: inline
In-Reply-To: <3ab1938a-6f6a-4664-9991-d196e684974d@nvidia.com>


--5suPJ6AZaEeQGZnT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > -------------
> > Pseudo-Shortlog of commits:
>=20
> ...
> > Oleksij Rempel <linux@rempel-privat.de>
> >      clk: imx6ul: add ethernet refclock mux support
>=20
>=20
> I am seeing the following build issue for ARM multi_v7_defconfig and
> bisect is point to the commit ...
>=20
> drivers/clk/imx/clk-imx6ul.c: In function =E2=80=98imx6ul_clocks_init=E2=
=80=99:
> drivers/clk/imx/clk-imx6ul.c:487:34: error: implicit declaration of funct=
ion =E2=80=98imx_obtain_fixed_of_clock=E2=80=99; did you mean =E2=80=98imx_=
obtain_fixed_clock=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>   hws[IMX6UL_CLK_ENET1_REF_PAD] =3D imx_obtain_fixed_of_clock(ccm_node, "=
enet1_ref_pad", 0);
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>                                   imx_obtain_fixed_clock

CIP testing sees same problem:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/808399=
1401

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--5suPJ6AZaEeQGZnT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZw4L1QAKCRAw5/Bqldv6
8qaiAKCoKkfZIrhqcOQZiCornDy3vgT1gQCfUfjHlNlJXzZHVsFgcIQGytPkZr4=
=J50w
-----END PGP SIGNATURE-----

--5suPJ6AZaEeQGZnT--

