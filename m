Return-Path: <stable+bounces-57951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C706926655
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 18:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A532814F4
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E51181D04;
	Wed,  3 Jul 2024 16:48:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326D1822FB;
	Wed,  3 Jul 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720025300; cv=none; b=T/RZoqI9OXk/5Yd7xERbx40Sqjy6zsPF5ppWA9lKuff8ZLpOOeSS1rbzrZ/+98C3cTZaez85lR4P3SZ2cVmc2tlit5s7PUAoNqJzC06s2n28oBJpzCoskqsF9U0MKyva3lGvxy30OAdANls7BXeMF3sav7LO3lkl7NonGQc1B4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720025300; c=relaxed/simple;
	bh=0NnYJYBiYH40PHELNM9/s0Cs00ExwYrO8uFwkfgxKtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sckURtiAOHnlHhsP/SgTFjfFS1VEtpgRXRnp+3YNFQZ/R+zOlRnxVa6mzXQVGTue4b2Uu9kaAk81AHLJjIGvHsvOoH2K9NFbEJSaBgWmh57vqNpPGjQLlzmEQHdeOYd7/4gh9u7Ssc8l9TiGlITEcnoWjsqZpdAFAC7zO6sTMj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1AEC11C009A; Wed,  3 Jul 2024 18:48:11 +0200 (CEST)
Date: Wed, 3 Jul 2024 18:48:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/128] 6.1.97-rc1 review
Message-ID: <ZoWAyPmPDPenYzeH@duo.ucw.cz>
References: <20240702170226.231899085@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pX1+IVbrIs3YEyDr"
Content-Disposition: inline
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>


--pX1+IVbrIs3YEyDr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.97 release.
> There are 128 patches in this series, all will be posted as a response
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

--pX1+IVbrIs3YEyDr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZoWAyAAKCRAw5/Bqldv6
8v+hAJ0ZJNZYhn29SPeiwFbEDz//4QlKVACggZYu7TuHt5pEBXBkN09A3SSsZX8=
=tVDJ
-----END PGP SIGNATURE-----

--pX1+IVbrIs3YEyDr--

