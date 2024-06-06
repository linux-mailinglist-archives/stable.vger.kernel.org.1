Return-Path: <stable+bounces-49922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF1D8FF57E
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732E91C21F1B
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 19:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A6D61FDE;
	Thu,  6 Jun 2024 19:54:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A961FCE;
	Thu,  6 Jun 2024 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703657; cv=none; b=VM/Ekx8eXpDStj91niq9k9QK/zMfgN3MjG74AZf61hsNwWuM5LwNz+YVcAfDZ2Ct7ddyvbLhVYo6YLcKYOVTE7ABHWOClAHze6X06hDtGMFZ7cyfPsEnx87mWa7CsyJLIiMVQRWhQe1yJ7X2/xlQB4SzD+Yl0yhYoc95IiQlFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703657; c=relaxed/simple;
	bh=dbh5Ypd0ZmyH3xAejcwiN+t0FzYu/qtkowO/qqVSdG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uc8yaQzbZuthiTJzBVuDPE3+RfNWFBNGyA9ylXnmQcdpXrr7vBZh73FhZD3evu7y+IHfaMN4og8VTlMJKsWxu24NLXIgeF+Ns0ZNTE6oT3QzKrcpKX0URI9Pd/JaC3vS0Vj9KDVqifc6SVGUWLE307YfMv/yAk4NgoR7uI1/KqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 090DC1C0082; Thu,  6 Jun 2024 21:54:12 +0200 (CEST)
Date: Thu, 6 Jun 2024 21:54:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
Message-ID: <ZmIT495hBOhvuAja@duo.ucw.cz>
References: <20240606131651.683718371@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oxkWft30KxAt57A/"
Content-Disposition: inline
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>


--oxkWft30KxAt57A/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.9.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oxkWft30KxAt57A/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmIT4wAKCRAw5/Bqldv6
8tURAJ4q1GbGu7Yxo89RhSKzNnZddNz9OwCfSxZ+zqlyIuTC9hmn09LYF7vgZoI=
=a4/9
-----END PGP SIGNATURE-----

--oxkWft30KxAt57A/--

