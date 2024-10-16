Return-Path: <stable+bounces-86449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA79A0545
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645D9B228D1
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF90205E10;
	Wed, 16 Oct 2024 09:21:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81325205E0D;
	Wed, 16 Oct 2024 09:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070500; cv=none; b=RbHa75l8eVhhC3DSEo0zSMvaXynSLjZAk72P88nHXNV+8znrgjnc32UQ8kxWtAu2vAWybKwr5LrKOjmK68q3YVFQrXCvKd1+rI9dv4MIvPCqED6KCty07cMScvxiv1CpP2BQEtbRkhXbY9Mn8Tlpb5qWP9kpIYv6qRp61SaJ4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070500; c=relaxed/simple;
	bh=Zmk0DMCi8BdU6gy+8tuTz5PJW3hPVFEifUbqgSaCYnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5zoP498Xd1y6/t5yRfhxlSFHRGwmzco0LDsjhsd/1dbtJUpFM+UiQXihw0AjrPCuYhDOCIJ4jOk3w4vo7odchdxPq1KHANjFFbihi9Eq2kYZfJUXCs3RaaoNxWXK/1YT8dq29W2PMOPeXd5fxGzMaFlDW5pnJjsJqg02eY3V+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DFE9E1C00A2; Wed, 16 Oct 2024 11:21:29 +0200 (CEST)
Date: Wed, 16 Oct 2024 11:21:29 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/791] 6.1.113-rc2 review
Message-ID: <Zw+FmcvPJraq4EPz@duo.ucw.cz>
References: <20241015112501.498328041@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Twvg5mkRtqF6fXoc"
Content-Disposition: inline
In-Reply-To: <20241015112501.498328041@linuxfoundation.org>


--Twvg5mkRtqF6fXoc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.113 release.
> There are 791 patches in this series, all will be posted as a response
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

--Twvg5mkRtqF6fXoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZw+FmQAKCRAw5/Bqldv6
8gY8AKCzYppavq0a7IHZTWHjFMrAoFhx4QCgsTVS8+LQWlppxDTo6UuzyNpmSyE=
=Tthn
-----END PGP SIGNATURE-----

--Twvg5mkRtqF6fXoc--

