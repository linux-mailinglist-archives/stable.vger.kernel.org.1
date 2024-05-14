Return-Path: <stable+bounces-45101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AECC8C5BC0
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 21:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259A91F22540
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B8C180A9C;
	Tue, 14 May 2024 19:42:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D70B1E4B3;
	Tue, 14 May 2024 19:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715723; cv=none; b=A5+2zW1bmXUClDkfJcTqD7X2cDqZjDAMY0+puCt1E+PcL6OK4ToQ6XP+1C2yROlMie5j/sJGplx8XPcuR3KgFuO0aa71hD5+c1eyeudTDQ8HvC5HQA+7EQ84XB7donNuoeid7LghE935o1waxLwdQnMf0ByTmSX5mPQACjz4o5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715723; c=relaxed/simple;
	bh=H9809BmAfI5QVtMFoQcj6jm6Ihj168kLsoBh+E/ZgPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFoFLPmZC/SbqxQUKVDL/QX6bfrh4o3/TNv2cLz9wyuZg8Tf7Dt6B+eFbVSRjbMiCw2xpzAqrWWAmArYHiE1Pu3y6enSK+f0g+8qy7tqTzFXjKEXzCIz7WevUhcoTgvUoVkY5wGyCOOefpqTXHxoQSBC9z8kpT+Y6xxsHFdUrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D23AD1C0081; Tue, 14 May 2024 21:41:52 +0200 (CEST)
Date: Tue, 14 May 2024 21:41:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 00/63] 4.19.314-rc1 review
Message-ID: <ZkO+gHl+dPwXQ/1i@duo.ucw.cz>
References: <20240514100948.010148088@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zgt/JtGQEFvrF5Pk"
Content-Disposition: inline
In-Reply-To: <20240514100948.010148088@linuxfoundation.org>


--zgt/JtGQEFvrF5Pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi1

> This is the start of the stable review cycle for the 4.19.314 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zgt/JtGQEFvrF5Pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkO+gAAKCRAw5/Bqldv6
8rSQAKCkxPSj6S8jHz55utuGfbHJIK6/ZACgqS4YUggMOYDAdD/0B+Eley8xqJg=
=tj6h
-----END PGP SIGNATURE-----

--zgt/JtGQEFvrF5Pk--

