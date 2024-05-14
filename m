Return-Path: <stable+bounces-45102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E675B8C5BC2
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 21:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F417282B1A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 19:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AC9181319;
	Tue, 14 May 2024 19:43:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873F180A96;
	Tue, 14 May 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715715813; cv=none; b=qNZ8gAJLBFwW1UpZ3HruBgLuuRMXDFFJkvderuer+cHrx0+lcz6lTKYAvVvRx+LwMeGFV/fOgfeTQhJ7efhvNh/qYrqh3MZdWdezaGOKpqzEnAa/CWkzCBqokw4gGZybr/PIuvEjYl1KycwuPXSyeLCBIGrxmAYQc/wNmPhmkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715715813; c=relaxed/simple;
	bh=1wg/2ZozGrasmo94mjzhWbBnAVbDSr1SF3uiHltAr00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcVl3FjfQ6Lzvliahk4s2JTHikKROk3rGkptYOIl21y54ggNwz3jBbk6RouIpNlf0o9gQVkCZ9WkPwUL9CkAEIZrmJoQeChqpU0rnQ1b22SdBSYgkbw3G8wZ0dlGRc8EI4E1yFxLiWeKfMa7KiFYbwaE4n05m+EkDPhGn34OIkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 863B21C0081; Tue, 14 May 2024 21:43:30 +0200 (CEST)
Date: Tue, 14 May 2024 21:43:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/111] 5.10.217-rc1 review
Message-ID: <ZkO+4h+vOOXtyZI8@duo.ucw.cz>
References: <20240514100957.114746054@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q4LEZOLzqA80BGZX"
Content-Disposition: inline
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>


--q4LEZOLzqA80BGZX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.217 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

First to comment :-).

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--q4LEZOLzqA80BGZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkO+4gAKCRAw5/Bqldv6
8lkdAKC4YnqPYvoNikVqEVroEvymEv5oFACfQbRDp1nz6wz5UWT2xwb9sc+TWRE=
=gSB1
-----END PGP SIGNATURE-----

--q4LEZOLzqA80BGZX--

