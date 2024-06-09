Return-Path: <stable+bounces-50058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBF901806
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 21:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E199EB20C03
	for <lists+stable@lfdr.de>; Sun,  9 Jun 2024 19:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331371DA53;
	Sun,  9 Jun 2024 19:37:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8FD18B1A;
	Sun,  9 Jun 2024 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717961847; cv=none; b=WwYfw7nIDiU03vNl7aCkhDzzWWkqxqcVgHBcw2XCoXI4ZzFLyp+h5gpb0Um5vroKpzIc4l7gWx4voWSciBIbpwoadBLfItRlYIxYzwUuo/kWzghwgNrmAX1/8EKmA6outtRjdqBYyZZOd4ErXZ6Rn+kdOIFoTTCuE11Qux7lRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717961847; c=relaxed/simple;
	bh=1AIckhDvZLb5jyJYq2SNkWavWw8DLi/8FE60TtLlIY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMxdR2iml8SbwKW1pvcsSCG2ZMhATz6LuSJsMxWb+lbkhkkiHElpo0A3qwHQ7a8YOO0bfZIdhshSMa6PmV2vTxSO+UeiSlyyn61xsh4o/H66UorwPpXx7z4vNPLhTWRvogB6hBXvA8Unxc3IqCtPsl5Yz95s6embomeOA0n+u6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4B89A1C0098; Sun,  9 Jun 2024 21:37:23 +0200 (CEST)
Date: Sun, 9 Jun 2024 21:37:22 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/470] 6.1.93-rc2 review
Message-ID: <ZmYEcrV3+nS89qrL@duo.ucw.cz>
References: <20240609113816.092461948@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ph2aN2YeD/bHqfqa"
Content-Disposition: inline
In-Reply-To: <20240609113816.092461948@linuxfoundation.org>


--Ph2aN2YeD/bHqfqa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.93 release.
> There are 470 patches in this series, all will be posted as a response
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

--Ph2aN2YeD/bHqfqa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmYEcgAKCRAw5/Bqldv6
8qtRAJ0Y4lGYHFV2lnziR+OgV2q6a36a8gCfRejzhEwLwGKozEFY9sbWg9CrGDY=
=NvmZ
-----END PGP SIGNATURE-----

--Ph2aN2YeD/bHqfqa--

