Return-Path: <stable+bounces-57953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069CC92665A
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379A81C2130B
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7352718307B;
	Wed,  3 Jul 2024 16:49:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D765317E907;
	Wed,  3 Jul 2024 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025384; cv=none; b=Cx3g9hoBHJFG1vd/CmbRtulgrVTv+Jl9yG5j37ogBYDixSiZe5Sj2891D5PyGBQb/g8ggYpiCyUuuCuwIK1lJlsm2sCWkk6T1N8EZMmEjWgfM+4sjkvk5HgMGw8dBTfEZhie9zWCoXkRdc6V+82f/pUG6/523xkZ8vZFdCPhjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025384; c=relaxed/simple;
	bh=nrVODcNzD8wxaPNSRGwJ9axuIOml1977V7j1DKfje5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SU0X+zrV9eLbzWiNHiVfi7L5DpaWQgPCCsNtikURJ9hM0dDbVxiV+qjaoJQFJQTGd5aavyZKNunCmJY8zDOAEyjRXNS/wlYP2w3kpoFl+aen6GQBe2/xRD44Kbsic/uLGnrtMb9FnnOwix8t0lBa4kOoWvC2vH9CrswEXufyIt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5BD631C009A; Wed,  3 Jul 2024 18:49:40 +0200 (CEST)
Date: Wed, 3 Jul 2024 18:49:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
Message-ID: <ZoWBIY0E+Ss5epFk@duo.ucw.cz>
References: <20240702170243.963426416@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3btCymvODrthq4A"
Content-Disposition: inline
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>


--l3btCymvODrthq4A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.9.y

6.6, 5.15, 5.4 pass our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.15.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.4.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--l3btCymvODrthq4A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZoWBIQAKCRAw5/Bqldv6
8s1mAJ4x8gDL430z+wbjz2y/eRUcUbJJGwCbBsKy1U12KPnVxbZjBah40eIzpqs=
=2H6K
-----END PGP SIGNATURE-----

--l3btCymvODrthq4A--

