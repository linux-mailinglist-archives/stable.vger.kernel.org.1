Return-Path: <stable+bounces-78234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28BE989D27
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF1F1C219F2
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1F17B433;
	Mon, 30 Sep 2024 08:46:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A1C84D02;
	Mon, 30 Sep 2024 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686006; cv=none; b=aywpedCiqSemdiroP9oLnUyuvGH81JWNj0FVpe3aXy9IlDI0TRvLYSMhM+TbpVDghEsTWtm6shtg5pN04t2BVUkizHPlz3Q+XkJWdJFM+nWv5N/Mz0vtyWTWqiqKJhNfIhosEHDLILOEzE2rf3wc8KLX4z3AyP2bz0069Tvw83s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686006; c=relaxed/simple;
	bh=sfhw3/7e4tY1piYiXmSX+tTjbvSXZTSpMQDlfjPKY6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpM41pVWtzY5M/Pcu0VAUt+VtAxC97bsWyI7i74ivsthCOLn+zZtQl3MocBlnSjj4C2EDa6Tl6mMDTsRMcgvqQKAWAJrNYzGja3NS7ZJ4lxK/mUPJg9G/xoJil7eFja/9KIqULLDr14EFwK08fjfBGlq00+59AinBVl4mtGjB+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EA6901C009E; Mon, 30 Sep 2024 10:46:41 +0200 (CEST)
Date: Mon, 30 Sep 2024 10:46:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 00/58] 6.10.12-rc1 review
Message-ID: <ZvplcRiVA0/j0xf/@duo.ucw.cz>
References: <20240927121718.789211866@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17EQGqeHyWbaDcrQ"
Content-Disposition: inline
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>


--17EQGqeHyWbaDcrQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.10.12 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.10.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--17EQGqeHyWbaDcrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZvplcQAKCRAw5/Bqldv6
8g2BAJ4vgkhZePHIynINbnKwlHg2N4afwgCeNb/ZuJPts17fAc7MLnH4VUW60Bg=
=ncq1
-----END PGP SIGNATURE-----

--17EQGqeHyWbaDcrQ--

