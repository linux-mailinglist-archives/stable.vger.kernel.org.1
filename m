Return-Path: <stable+bounces-56099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9751D91C68B
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 21:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C871F24FAD
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F976F31D;
	Fri, 28 Jun 2024 19:26:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2D46F30A;
	Fri, 28 Jun 2024 19:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602794; cv=none; b=fSaLiPvikOG6iXKxhZKNE7+6TkrsSYqaT1eqfJuNL9vhzqI2UYQ+SzPIvTNT6zsCOYm9qyFf52QH38ZP6Gg9DGtgBI2wGR2vGfqoQdCZlYVHYMJd5RXwFnP4LSi04iQfTJYGB6NpFLrtNx5fHUFYpTOlWR6kWz/91zNpXyTfJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602794; c=relaxed/simple;
	bh=eqO7Ki95NF/BQYKdUKvbuFsOVwpI1DEUVyudC1vvO4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClCAuSAbhqH1Fo9q2cCEZbJ6dkVyXZmNCRSXgHGmuItflgEN6MDp9Y0+SEjVni4RjOQv1Pk9ofvqMnoH3eCxpw2hIP/dUGreliQjZCBkeot3pMadYEQyXaKZKr3X/FnK1s4UYxOIIkMuomczI/z3bBphZGVLGTxxMp3HKgInBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=ucw.cz; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AA2E11C0098; Fri, 28 Jun 2024 21:26:29 +0200 (CEST)
Date: Fri, 28 Jun 2024 21:26:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/131] 6.1.96-rc1 review
Message-ID: <Zn7mPrqkeztjS30d@duo.ucw.cz>
References: <20240625085525.931079317@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XR9LtlHv+hRnaETr"
Content-Disposition: inline
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>


--XR9LtlHv+hRnaETr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.96 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XR9LtlHv+hRnaETr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZn8OVwAKCRAw5/Bqldv6
8lcyAKCXlB7kNp2gH8Qz4A1lFKvDnLSW8wCfS+OEU3BLDs6TJgvzoy25imcGqXg=
=bGHm
-----END PGP SIGNATURE-----

--XR9LtlHv+hRnaETr--

