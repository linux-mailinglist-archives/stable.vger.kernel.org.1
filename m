Return-Path: <stable+bounces-45103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD08C5BC6
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 21:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06C1FB21600
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 19:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E0181302;
	Tue, 14 May 2024 19:45:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57932AF09;
	Tue, 14 May 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715910; cv=none; b=NwaMUZIPl9z3I3TLT38s+c4i0vcMt34TTG0x2NlDH23wFbsafsbHa4TF08qGN8j0gGUG4zbOAzgnX8O7nFCHyA46dt7DuajwQngmjUb4+C1jvhpulqB51nPiJPQ/rc1audMEr2MI1AANMrfSvgZTD/F4SNA/r4ew1raX34grs/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715910; c=relaxed/simple;
	bh=GiW6yZHj4ecT5LUe7DkvIJac8Ho4lr1EHobx6bCggQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ip+HlWwxVECnweNGbJsPSzh7VI9RrnHKpn6EpUxwwn/D8IN5OPKbyb7Uh8kn9h9wDjECNlnZvgSAkmWICki1HLhZ69D1pJzenb66hhh37ZiW681fNIejzz1IwHjHo1GgAO3qjFmlJqGehNQL4P1mrTNabEWbf528LTO8LqE8T+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4C12D1C0081; Tue, 14 May 2024 21:45:07 +0200 (CEST)
Date: Tue, 14 May 2024 21:45:06 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/236] 6.1.91-rc1 review
Message-ID: <ZkO/QhooGZ6RommF@duo.ucw.cz>
References: <20240514101020.320785513@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YM1fTCVQCWcG5FpS"
Content-Disposition: inline
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>


--YM1fTCVQCWcG5FpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.91 release.
> There are 236 patches in this series, all will be posted as a response
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

--YM1fTCVQCWcG5FpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkO/QgAKCRAw5/Bqldv6
8jLpAJ9t6J6t+Q1spoWuYcCOT5Oe1yjkDQCeMTgAzeHxhEM5l/fz3eSOV7vZBo0=
=lmSX
-----END PGP SIGNATURE-----

--YM1fTCVQCWcG5FpS--

