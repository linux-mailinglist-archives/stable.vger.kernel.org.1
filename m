Return-Path: <stable+bounces-91700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537D9BF44A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 18:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49ED4284AEA
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAACB20721E;
	Wed,  6 Nov 2024 17:30:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97222071FD;
	Wed,  6 Nov 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730914210; cv=none; b=nJJzVR7uZFbxXxd+qpJEwfWQTGLSmR7wT1xQx3GZANRWTQjlOz15KjxoiYVTlBIUDf3UM2nFbYT02XS3GtFMJueiUz9TX2+jZ7BGPkdiqOjI3GTk4j8B64fDHojUxnYb21OfqmE6rhXXhbFOFxQwCICUkTQONCNAZCALfF5ldME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730914210; c=relaxed/simple;
	bh=7ED50qs/dwz/5BIJaayodwVGqZmunq9nk0KaYaeTWkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUe1YdBFlIWagPa4B89Cn24cXvJkgdXSsE+KP8b7/QAWPRb6u/wN5D/VFB5kLA7N1Dm6BotIMyMSgMFqDcfst0cantFlHzBcvnXkfG87rswcudpvYohjS9Td/4jeUs0DbrQ686DgduF8HjYLv+mEQWkCty7Pcw78rBKq550nodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2C5A21C00BD; Wed,  6 Nov 2024 18:30:07 +0100 (CET)
Date: Wed, 6 Nov 2024 18:30:06 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hagar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/126] 6.1.116-rc1 review
Message-ID: <ZyunnhDQz/SGly5A@duo.ucw.cz>
References: <20241106120306.038154857@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IvDv0KzJkbF3ZGLA"
Content-Disposition: inline
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>


--IvDv0KzJkbF3ZGLA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.116 release.
> There are 126 patches in this series, all will be posted as a response
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

--IvDv0KzJkbF3ZGLA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZyunngAKCRAw5/Bqldv6
8kX4AJ9kki3HaeaS81WQGawkRe3USaKiKwCfWmp5ZJtCFb7se1XSk9cg5dmwbIs=
=rRgm
-----END PGP SIGNATURE-----

--IvDv0KzJkbF3ZGLA--

