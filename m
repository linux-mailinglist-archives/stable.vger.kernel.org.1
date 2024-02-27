Return-Path: <stable+bounces-25283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA46869F21
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 19:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BAF28B23B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 18:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5202E64B;
	Tue, 27 Feb 2024 18:31:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71321D6BD;
	Tue, 27 Feb 2024 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058711; cv=none; b=jMAPw7kzdcsXqYwx3Z7pgyIKtBhU6simFtEjEJ+4YqNjSTZBMyCFSew1pQhTfGB4y7N9oGQHnAUDutqVf3H2NK/ZI/ABXh7t/XLccS8C8sVepFNDeNHK6ANd1hPSlbZ7M8I1XsAjURimph7j0Bc/VZH3J2WKPDXSBkHUhY9LDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058711; c=relaxed/simple;
	bh=Z8XhcB7OuJgbBQJu4/2Vzv0I/wM+4190zRkgaTUtx3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUQoKQViU8D1KTsUN7nPbgrM4U41D2FEUkcM/hOgpYxRbH1i/VifTIVRusC5TJKm8y/08X/yWF6NlKk3g+90FDT/ZcOHPYvG86XBagl/LH4tHSxfy0jTWCXkFZ6hHRlpGOi9m+wYW5auHbMLBfkgiEJGySqr3OBGas/NjLw43fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 26CEE1C0087; Tue, 27 Feb 2024 19:31:47 +0100 (CET)
Date: Tue, 27 Feb 2024 19:31:46 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 4.19 00/52] 4.19.308-rc1 review
Message-ID: <Zd4qkgueW1OnfuNh@duo.ucw.cz>
References: <20240227131548.514622258@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4pLTpJTU8o3nN5wW"
Content-Disposition: inline
In-Reply-To: <20240227131548.514622258@linuxfoundation.org>


--4pLTpJTU8o3nN5wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.308 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

6.6 and 6.7 seem to be ok, too.

Best regards,
                                                                Pavel


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4pLTpJTU8o3nN5wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZd4qkgAKCRAw5/Bqldv6
8iRdAKCXlSm77CRhPym+SRL0vtTdmMT7qwCgiejZYVtqsM8yfjJhc3MpXWUdI6g=
=Qjw6
-----END PGP SIGNATURE-----

--4pLTpJTU8o3nN5wW--

