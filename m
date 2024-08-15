Return-Path: <stable+bounces-69238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52154953A69
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037E2286D8D
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 18:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6B64A8F;
	Thu, 15 Aug 2024 18:55:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6741C65;
	Thu, 15 Aug 2024 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748105; cv=none; b=KnkDM1HGfww3PcCwCSBW43/xOxQgbvXyRHYlgWs3jTXUHx15ROXUKEE25I6y5HH+GHKvasdFEGBMKaKJE6ujSVShx/mBaeDxTW8MKrRQVOK7QI5IQcDLe5pRSq4SZTtKWcSpM9X+PyU71y/YXC5vBs3cjhY1VYFBKVHCT21WwVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748105; c=relaxed/simple;
	bh=dOXlAK1kX/dzcJc1qzbt7eDgW+p9TuZwqEwvesn1MME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmrJA5YK9oW1viw77/krDUJHK3lNuvgdaqMVK8seD5KgC5ZV6chOSvdLg942M8kE1g5j9l5A1esRlUxS74trBeerjt91v5H7rpRYvRwKNsoTtKr3b5tJD2Wf5GVrpLUNeVGQXYB71Jwk6pg2IRxUu9wACYp3JeM5FnIdC1m4ugM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3C43E1C009C; Thu, 15 Aug 2024 20:55:02 +0200 (CEST)
Date: Thu, 15 Aug 2024 20:55:01 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 000/196] 4.19.320-rc1 review
Message-ID: <Zr5PBbYi4ZW/m1U1@duo.ucw.cz>
References: <20240815131852.063866671@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wSGw9hiZACN5E0bj"
Content-Disposition: inline
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>


--wSGw9hiZACN5E0bj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.320 release.
> There are 196 patches in this series, all will be posted as a response
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

--wSGw9hiZACN5E0bj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZr5PBQAKCRAw5/Bqldv6
8pMfAJ0bXfiA6yDF/LOeB5+07n9c+V7M+wCgprZz3s4dqhcbOAb24EY4o5mr9Ik=
=NQZF
-----END PGP SIGNATURE-----

--wSGw9hiZACN5E0bj--

