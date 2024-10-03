Return-Path: <stable+bounces-80682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1531398F678
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 20:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AFB2827C4
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 18:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648FE19F412;
	Thu,  3 Oct 2024 18:48:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8316EB4A;
	Thu,  3 Oct 2024 18:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981337; cv=none; b=g3QNVZWui6GVfEjvanRM4ANV2ZMVPx6HnSqK3ubGMUb9uOtrY+IW9OOsNP490V1lZoXqwl17tzizwe6qwOzoRx52yeUMDLtECjymMlz0XHZtv8Qmq68hr5mx0AOvyW3kN1sedf862xAEAxsEIBPD+QzRR6Bi5bhAv4TUe2L2OaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981337; c=relaxed/simple;
	bh=36sUp+K+roiAExIe/Kxwsav5Jk5xZDaouhZcDm7sGG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvZaB9pMKcus0XKAO3KYML9NADaurlsFt6RAMwd4bfwy3zT/dGOqZBBZr3LFO4+o5u+vtJJRV+d+IoRsJ11LfXKkMLf0SxHs+da5UH6IA43U5sX+ixAzM0GFKfjvfGGm+FTNspCslkK+/0JMbx2rYBha0K/qsIjYWTuln2wUUKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BA7851C00B3; Thu,  3 Oct 2024 20:48:51 +0200 (CEST)
Date: Thu, 3 Oct 2024 20:48:51 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
Message-ID: <Zv7nE2SUW4UB3Sx1@duo.ucw.cz>
References: <20241003103209.857606770@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0p0/OUsEJfXqelNI"
Content-Disposition: inline
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>


--0p0/OUsEJfXqelNI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0p0/OUsEJfXqelNI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZv7nEwAKCRAw5/Bqldv6
8mzmAJ9sIkzqGrAsXQD2XAuVyXs9zRcQ3gCgudC9JftpZjsuyeTosHSKI+TItEU=
=RGCw
-----END PGP SIGNATURE-----

--0p0/OUsEJfXqelNI--

