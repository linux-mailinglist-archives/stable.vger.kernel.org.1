Return-Path: <stable+bounces-52172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EBB90879B
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18A371C2118F
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315AB1922F7;
	Fri, 14 Jun 2024 09:36:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E377186282;
	Fri, 14 Jun 2024 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357795; cv=none; b=JaouO4jrYkhjbdEyVK4n4az40GeekP/Wcy36Hy2Cc1DVdLga+Y0mftQ7IvwBi3KrIBNEarQta6uF/b5m69EmHrluWNhtfo5RRC5JkVJ/iAqxbwkPqARpS0EBFkQqkWFcYUiGqtW2Z1NYq7tyh9zOhlP3q/hfdbdpxBQ9ZwKJyIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357795; c=relaxed/simple;
	bh=iy+3p201t7O0SGPBzTa45QUuSpDXc5cs9aoiVifuhxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhDNOvB1H/kWq+8th1l8+pvAXDY2UX+b8MawZzgWv6jr7qil8Jz90BflrOXepLjU2/0hLtHODD9uQgwRabzNQ3zw9pnXS+iHSbX/IpSs3DgGY100MMq/qGCWOKdjR6FEbyLLpWfwgCiou9rSJqMKsZyDXV+KCb2TUVtKGz7ik9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EAFF61C0082; Fri, 14 Jun 2024 11:36:31 +0200 (CEST)
Date: Fri, 14 Jun 2024 11:36:31 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 000/213] 4.19.316-rc1 review
Message-ID: <ZmwPHy0XIndXjwYt@duo.ucw.cz>
References: <20240613113227.969123070@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYVwTws6yiBpPitg"
Content-Disposition: inline
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>


--cYVwTws6yiBpPitg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.316 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cYVwTws6yiBpPitg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmwPHwAKCRAw5/Bqldv6
8rUqAJ91I3fRxiXEBM8r910lBshmCXQsYgCgu5GsyLxKtEhQHu5dlDqtD3pbAJs=
=04g7
-----END PGP SIGNATURE-----

--cYVwTws6yiBpPitg--

