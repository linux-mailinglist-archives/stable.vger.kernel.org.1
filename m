Return-Path: <stable+bounces-54668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8939490F7DF
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 22:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D462860EA
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 20:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4215B131;
	Wed, 19 Jun 2024 20:53:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1615A875;
	Wed, 19 Jun 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830421; cv=none; b=kdh7eoqYIXT23E5jdzt1GY+mJ3wqZFqg3jvmGbGfr0e69w0x8YdVIpTh1yKooM9IefYjtVzIutgHGQaKRS3r3SCiS0b+M7jWDjI29kctl/gWCAQ36HtrS/hxG1/pvpfdVxQ0j5b2BGomAMTIew4VdI990Py0zDyFdTY/RBa5DJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830421; c=relaxed/simple;
	bh=GNFCgL0eo3F/Upeqaudb5LNHEm1jLtMNrmv0qv2nLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8O2NgQ6O9gujCAVdwQIGuXNC/JjeWpkywTNiIforFI5cjbSw+WkI0BpX8Uy7IcUp8CBztXYR2mQHS5nLEjo3hVYd2388/uckgvnSgo8nsHzYKj4s9KYT3obu3IB8jaOm/iAuI+XFVHE4CmQLz13Oi9ZO1BHy4av3YQnv9qKg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8C91C1C009C; Wed, 19 Jun 2024 22:53:37 +0200 (CEST)
Date: Wed, 19 Jun 2024 22:53:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
Message-ID: <ZnNFUSCvPI/7KG1R@duo.ucw.cz>
References: <20240619125556.491243678@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDOuMhcyTfEL1C/f"
Content-Disposition: inline
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>


--gDOuMhcyTfEL1C/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
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

--gDOuMhcyTfEL1C/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnNFUQAKCRAw5/Bqldv6
8sBOAKCAFl46L0o6ySgncfy84IlpeLdEkwCgk6lw7qY/Lifqoq2waYQgt2OqisM=
=6ulv
-----END PGP SIGNATURE-----

--gDOuMhcyTfEL1C/f--

