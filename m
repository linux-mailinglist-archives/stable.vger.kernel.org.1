Return-Path: <stable+bounces-60412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB31933A3C
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 11:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A0981C21161
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 09:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C7317C225;
	Wed, 17 Jul 2024 09:46:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67517C211;
	Wed, 17 Jul 2024 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209608; cv=none; b=Kd5Nr0I2DvpcTJwMDhlUviDpkzolTzRPu7BcXpTWxwAdhzokXmPAdn2PJlXAmuhh/NKigtS6nfGLuAgnv/8FaiVkbBtZ5iKdlfT1MzfM+kA6FranYG4hQqJy9ri3cegsPI+0Vm9IhL6Kkd/qRigZU2x/RdJ/VB9ygiKIRqNJO/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209608; c=relaxed/simple;
	bh=tX6udcistYtbSvcTiZAfsRDcNI0YYgXMD7ooFitslbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAerx5yEPLqlYWlD6NvdXVyMcmkzIiO+Val+4PI/020+I2FRCUNtj7JFvT6q7uiSYDj8XdDom+wYy7QgBHkIS4u2OFheg41Cnjd3CI1wAeOqvfm5XVna4gyMzw60vpb+WbAUFoNrXJgjjFDmZ+lBdYvHUV3NkKMLg2ALD6ngZAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 67B4D1C009C; Wed, 17 Jul 2024 11:46:45 +0200 (CEST)
Date: Wed, 17 Jul 2024 11:46:44 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 00/65] 4.19.318-rc2 review
Message-ID: <ZpeTBKXdu09hpB13@duo.ucw.cz>
References: <20240717063749.349549112@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5HcsdIB5slL4hqjX"
Content-Disposition: inline
In-Reply-To: <20240717063749.349549112@linuxfoundation.org>


--5HcsdIB5slL4hqjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.318 release.
> There are 65 patches in this series, all will be posted as a response
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

--5HcsdIB5slL4hqjX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpeTBAAKCRAw5/Bqldv6
8nl/AJ9Wi9rVccbTx7BAeGrCj8ms3ybxXACfW2a5BIJyzwAejZuQlqVbBHm8bFo=
=d9wR
-----END PGP SIGNATURE-----

--5HcsdIB5slL4hqjX--

