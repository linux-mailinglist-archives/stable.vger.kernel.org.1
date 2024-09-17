Return-Path: <stable+bounces-76604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632CD97B43F
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 21:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C5A1F23556
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 19:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2927F189B8A;
	Tue, 17 Sep 2024 19:06:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6117C99B;
	Tue, 17 Sep 2024 19:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726599992; cv=none; b=lKsmzxsmgWAC9eODuxQBxFt6zSIiW1B/GN053XuFdlLKd+mRyWzgxm70apniOg93avwCjslGZWlO7Scvp16gzp5M4iho3ByIJ0x/JVHJsspp5aUiCOLqmCxPghbdeqmPThfvaGRuVorpEvpqAIiS9cEzeOvR2+z4gUFxCRtIewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726599992; c=relaxed/simple;
	bh=8wFtswZWFh91W7FGJxw4QcrzDtccGGJvKTDHEorF5es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iypiDZNtIImi9kmY1apKCK4MUIvY7xopfeSP9KFZr8xm8e/soWTboibPGNQrL9aZ4doyGJ9gEyJ0dqvtOrgZspPXmSpj4clnPum7i9P7O09BydibmvtW+FAImrXMQWGja7MPMeQs1cz7W+ysomPqnyPXC4qwSqdQJsdMasC/FpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9195A1C0082; Tue, 17 Sep 2024 21:06:27 +0200 (CEST)
Date: Tue, 17 Sep 2024 21:06:26 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/63] 6.1.111-rc1 review
Message-ID: <ZunTMkoReHwXLx6l@duo.ucw.cz>
References: <20240916114221.021192667@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="neNGhF22YAbEdb2K"
Content-Disposition: inline
In-Reply-To: <20240916114221.021192667@linuxfoundation.org>


--neNGhF22YAbEdb2K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.111 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.

Could we get more time due to all the conferences/travel?

Best regards,
								Pavel
								=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--neNGhF22YAbEdb2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZunTMgAKCRAw5/Bqldv6
8gh5AKCZ71OMuyJEDxznZP3+vsXVG1xuFwCfaNA8kDgtOW8gJ4N9CZil51UCi9U=
=wozB
-----END PGP SIGNATURE-----

--neNGhF22YAbEdb2K--

