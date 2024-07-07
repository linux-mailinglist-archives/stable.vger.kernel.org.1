Return-Path: <stable+bounces-58178-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63627929777
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 12:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ED72815A0
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 10:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDC1182C9;
	Sun,  7 Jul 2024 10:43:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FA1B948;
	Sun,  7 Jul 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720349030; cv=none; b=iHwzBJK/fEduHi69rQBCKAMqYDy5n8X+dKPrxwvohxKOXLG7Wu3TRTw/Kd8EaSL62JAnpOOwtG6pkYY7QLB2hpw96P82pq31qZHni7AULl8dLAjaTp6jB9D16B8s0EgWuXQJithy/UNOmBfXds3S8tIfiYZBGoWkdrz2xwF9qBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720349030; c=relaxed/simple;
	bh=gQlWRk3EBY6Wjjj/SEcCdYnBUlKaI5FVlZIyvLNcidk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkfSyAylFpYYMeyGOOeUQwIJcBGfRQqxjAKHXnHUFkUHF8nLatHykAd4NC5lwdZJt9H066i4qDLFG9LcOOWr83esY4o0AM3pndc1FbBhhu04h4Ya6tzvy3OWIMWTKD3Ay3ShlC1+88V3V0nVHLwNiTdqaSF3bcn1kVPOCxPjZtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 259571C0099; Sun,  7 Jul 2024 12:35:03 +0200 (CEST)
Date: Sun, 7 Jul 2024 12:35:02 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/284] 5.10.221-rc2 review
Message-ID: <ZopvVtp/+w/bhEEm@duo.ucw.cz>
References: <20240704094505.095988824@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rHnuE5AZSvg7teSi"
Content-Disposition: inline
In-Reply-To: <20240704094505.095988824@linuxfoundation.org>


--rHnuE5AZSvg7teSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.221 release.
> There are 284 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

5.4.279 seems to test ok, too.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--rHnuE5AZSvg7teSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZopvVgAKCRAw5/Bqldv6
8nSSAJ9UbrxiYXpSFwDAmAbvbbyFfmd+uACgqUxD5LjYZf0hgQ66XcXs5DOiPUU=
=cyc8
-----END PGP SIGNATURE-----

--rHnuE5AZSvg7teSi--

