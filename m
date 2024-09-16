Return-Path: <stable+bounces-76535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F079D97A8A0
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 23:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EEF1F2623C
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 21:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEB915E5DC;
	Mon, 16 Sep 2024 21:14:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9B1311A7;
	Mon, 16 Sep 2024 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521256; cv=none; b=c3wmq0Wsj5xdSCL+8zassxaHRAZuCgeRL4LKDd8f4o2oSl4upTRSKoglSpjHuixmLkN2N8R3elwpItWXajaKSYdesIaxqLkSrHWigSUH4M00XQpC0rVYmNbW4RZ0xPjkvbqI3X+LrMRiDMxz/bGxdlC39F6M6YN4XUVhXLXDhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521256; c=relaxed/simple;
	bh=5IpUJ+P9FLCecTIxh8N96RSfCvX1rwd5L8hBRG35KPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dewicRK9D1LHqV6i+zAmrOPYCsQD4RIIN6G/AnAQdUuY6+BiooANuNMtgCoxxaJ1nCWgS/yd8V1fX94WrDnddAF2Gviir/WUjzL95Kh+mig+Nn/PjjBMDFx0UsLL6eM6vJ8ussNjFS/Z7CaEM4Gc+Rjc5VJDId6XgRDncTwDTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 53ADC1C009B; Mon, 16 Sep 2024 23:14:06 +0200 (CEST)
Date: Mon, 16 Sep 2024 23:13:38 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/121] 6.10.11-rc1 review
Message-ID: <Zuifgl+Zs84Mt7nd@duo.ucw.cz>
References: <20240916114228.914815055@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jdx0XYfleK5lv4lu"
Content-Disposition: inline
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>


--Jdx0XYfleK5lv4lu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.10.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.10.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Jdx0XYfleK5lv4lu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZuifggAKCRAw5/Bqldv6
8sjAAKC4vLLVpztmbHeKinnoRlN7i1b8sACeOe7+LU7DCebu1KwuOo5fWelPPXI=
=n0Hb
-----END PGP SIGNATURE-----

--Jdx0XYfleK5lv4lu--

