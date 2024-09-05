Return-Path: <stable+bounces-73606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B896DAD7
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C061C20B6C
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 13:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235D19D8A3;
	Thu,  5 Sep 2024 13:51:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12201EA85;
	Thu,  5 Sep 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544306; cv=none; b=Li5UpZMxZXISdGeCYVPMJFCOi4aOVAbM2aUugmeYa5Vu8v4damvoaKAsV643ewjpuLiJnFIBQEQQQ6VGVGtG2jB3feCd8DqjxoGlCqXyZjQJOmvdNK7pVMKFgC89XW87AI8Ndqmng2CD7jD/0IYwnkcfq0WZjaUv6tKYstVBdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544306; c=relaxed/simple;
	bh=6RY5hefA3MRNHNn3jbgZBDzDkG9OUuZ/6SvoUBITUSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq/sLC1G3JsjkR84SVs3hzybJ1L70GBvTySDZO5hzUQihODpu/os78uZagT2/e8/DF5WyfOC5bMO1U1+vCZaauocD1KpXPNFiAOmvyo5d8yWe43tqwCNHY1k//KJgZO9Vgtxn3po7BU5NKdDYxcLcaSmzSApmsAr7xOCNPt86Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 117451C009D; Thu,  5 Sep 2024 15:51:43 +0200 (CEST)
Date: Thu, 5 Sep 2024 15:51:42 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/101] 6.1.109-rc1 review
Message-ID: <Ztm3bvcqag+Mf8ID@duo.ucw.cz>
References: <20240905093716.075835938@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rW670pfDm1CkCj6w"
Content-Disposition: inline
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>


--rW670pfDm1CkCj6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.109 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--rW670pfDm1CkCj6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZtm3bgAKCRAw5/Bqldv6
8rfKAKCX96R70U9okhXPsOUOIIwq9/hP9QCgo3A8pqKqwlvxxOjkqfpvxr3CSnk=
=iZMd
-----END PGP SIGNATURE-----

--rW670pfDm1CkCj6w--

