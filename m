Return-Path: <stable+bounces-52171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AF8908799
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70421C21371
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5212F1922F5;
	Fri, 14 Jun 2024 09:35:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AEE18757D;
	Fri, 14 Jun 2024 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357750; cv=none; b=XzpVNhLUwA+RuR7aQIqRKfvnfFu2vS47sQ1lXXPej0meM5GBESP49KYmDfDwbeCQ2XTbZ3WpXsgtC/NmvEwKawrOsnCgPeVYk/7E5iT8ia1EAzOfs8il4wT3pJqagwNPrPZNl5tekdfxgigfeXsl27eHGYG8Qbi/dmXwpAoof5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357750; c=relaxed/simple;
	bh=vM3ly3iEVoO9SwOojKIHV8Zbza/sGBjIADdJoAXHBAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTlGj2HpOh+MfUe8GvbyQ1kX+o3j/V2ej4AJNKYQ/Ic0UGEecnfr0U820Qebp56Sd11NMEGgin3MbBxAq6bNlE7HwgVTw/5+0zao5k1z95EN4ggqSMBOyoVMNaULkE6UFOfbKZNseWu8QBuMMiId6SkQETBJBE6Lz+WCn/R6z2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2168E1C0082; Fri, 14 Jun 2024 11:35:47 +0200 (CEST)
Date: Fri, 14 Jun 2024 11:35:46 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/317] 5.10.219-rc1 review
Message-ID: <ZmwO8v4HHn4UKh5e@duo.ucw.cz>
References: <20240613113247.525431100@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E4qMwfEYDgqol+Bk"
Content-Disposition: inline
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>


--E4qMwfEYDgqol+Bk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.219 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--E4qMwfEYDgqol+Bk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmwO8gAKCRAw5/Bqldv6
8tFMAJ96O7+QPczLD9Y1IuqhHtAxIO9VLgCcDicHJg2uCe9Nt51N6rOA7mlqEbU=
=RjwL
-----END PGP SIGNATURE-----

--E4qMwfEYDgqol+Bk--

