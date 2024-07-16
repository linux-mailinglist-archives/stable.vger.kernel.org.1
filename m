Return-Path: <stable+bounces-60359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB45D9332B5
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 22:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690912835D2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929BB19E7CF;
	Tue, 16 Jul 2024 20:11:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266857323;
	Tue, 16 Jul 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160705; cv=none; b=eml4tyjH8WR6QafmFl7YTmHENnSFagYv2BHMlrmLthnE1xD/CZvkmcguzgcQe5w65k/EZjzP1MOgcTAenFSk8GaxIOC+cUIGjuAr7x51piCpyJKHPRB8EIRdf8dIBTpIgKjNvNXgeyC/La33qqX50Y8NLZDAk/oGIOOzlD4fpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160705; c=relaxed/simple;
	bh=8HSN7MlmJOklhIyTJDTjqmQnsv/lceoUg2a1fAPse+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dicSuz4bUePKR7yzgKen38akm+DGCDRbJIJCHedCRZb7ZLKS6vUJdTwPSCWklQ7ZHJ/EEUf0/y0UWJj0s9+9qsQdSr1+Vo4R/Akdlb+bjAxi/WEwnI3Dr53bFZ1VP1w28ajrY/LfMjpffsM8RCxU+Qgx0Zbp0ZaCu2h1iwwISyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 726D61C009C; Tue, 16 Jul 2024 22:11:41 +0200 (CEST)
Date: Tue, 16 Jul 2024 22:11:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 00/66] 4.19.318-rc1 review
Message-ID: <ZpbT/cu3seKyKyqO@duo.ucw.cz>
References: <20240716152738.161055634@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VlJuuHVad2cKKUt5"
Content-Disposition: inline
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>


--VlJuuHVad2cKKUt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.318 release.
> There are 66 patches in this series, all will be posted as a response
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

--VlJuuHVad2cKKUt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpbT/QAKCRAw5/Bqldv6
8pn7AJ46xrre4x+iqVC/e5ZbJFSRh63bDACgq7+398WiLxT1LBk/rsIkmAuw9gg=
=poJc
-----END PGP SIGNATURE-----

--VlJuuHVad2cKKUt5--

