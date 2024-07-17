Return-Path: <stable+bounces-60411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E7933A37
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 11:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7661F2262B
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79117A584;
	Wed, 17 Jul 2024 09:46:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED59179658;
	Wed, 17 Jul 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209585; cv=none; b=pdvRLEWX8BchB/du2IFw4hDCsFzbLBFA9VTVMwWjmm1+IQwNyZqwIX2sriCVCjvEV7b+aqzOmuyu4DxefvWROGLYXSSD4I8aZjNMsGWnAdX7OxHvDeeFEopBZGqmzPen4yN8GsCsuRgIv+ZFz4Aww21ktJwzwmHPZP2UheqxXsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209585; c=relaxed/simple;
	bh=6g9crQ0KXyA1SsCd0HlaFajm5PoUBnt4eolBjn3ssAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kq2agNxE6CzlJegc0WA+R0+LI5zUEgcHTQcjAwc2CGVgjuBDIcQh+sDDsoEIVsIAJ4C8uIMc04P+xIrk6ZwRIu2oDQd8TluHKWh3t3W308+RKMhVaxmZt3vwtk4GejxAOjM2Woa20K4TTeqOtxNBCB5ymmQQt6gu+lV5VTAoKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 941D21C009C; Wed, 17 Jul 2024 11:46:22 +0200 (CEST)
Date: Wed, 17 Jul 2024 11:46:22 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/109] 5.10.222-rc2 review
Message-ID: <ZpeS7pk1XsRgA4Vf@duo.ucw.cz>
References: <20240717063758.061781150@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="93tOQc+Zea+1MTnR"
Content-Disposition: inline
In-Reply-To: <20240717063758.061781150@linuxfoundation.org>


--93tOQc+Zea+1MTnR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.222 release.
> There are 109 patches in this series, all will be posted as a response
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

--93tOQc+Zea+1MTnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpeS7gAKCRAw5/Bqldv6
8n0zAJ9sS7W8spn8lm6IzezrSy1Nx23VXgCglAO7gEGuMd55BZac+7EMCHGaYfw=
=MzCP
-----END PGP SIGNATURE-----

--93tOQc+Zea+1MTnR--

