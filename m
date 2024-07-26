Return-Path: <stable+bounces-61920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D9C93D814
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 20:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A97CB1C2271D
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197502D611;
	Fri, 26 Jul 2024 18:15:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8207A4430;
	Fri, 26 Jul 2024 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017758; cv=none; b=n83RcwIcAOYKFvm143F5N23//7Wi0BJmD3qx3ut7i0kaQfVOORIhpOwkWWPYXM2yuyYI2j5mtp7eqSj1RG+bURtOj7vmjZgLMCnKi0t4G+vxsge2XqnyDrXtm/4z3enwtRepAz4JJ6yBRP5eAl3b+EYFKfy04B09vqvX39xOiyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017758; c=relaxed/simple;
	bh=S6mpg8rek3pnX8Buy2j2lUHHorbEBJ7uWlmp+RNgnvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6BsVfZfWaELIYNnfnmXiBSTJ/at1EhTOr3P9VB/hN5wPLuRkb7FcGDxnUgxl2Ict6J4ryXLSpXyVmCu3czFrDzcHXVTfs/6o2PogtWm2tgEK3PZWAe8XEpIvzFBOrZB7KxkxKcBXuFzk+iL3YAT4uJFaANnOwJnWUSb6eG3Lko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7E6541C009B; Fri, 26 Jul 2024 20:15:54 +0200 (CEST)
Date: Fri, 26 Jul 2024 20:15:54 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 00/90] 5.15.164-rc2 review
Message-ID: <ZqPn2mMguPnSRjAI@duo.ucw.cz>
References: <20240726070557.506802053@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Gk/BcIWScRv/fnK"
Content-Disposition: inline
In-Reply-To: <20240726070557.506802053@linuxfoundation.org>


--6Gk/BcIWScRv/fnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.15.164 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.15.y

Linux 5.4.281-rc2 (6b3558150cc1) -- no problems detected.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.4.y

Linux 6.6.43-rc1 -- no problems detected.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Linux 6.9.12-rc1 (692f6ed6607e) -- no problems detected.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.9.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--6Gk/BcIWScRv/fnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqPn2gAKCRAw5/Bqldv6
8tZ5AKCY+JhBZ5ZmvQEc7yt5gEIFltj/lwCguBJLlFZxbN929Tmw0UHP9X1rPyE=
=sP8p
-----END PGP SIGNATURE-----

--6Gk/BcIWScRv/fnK--

