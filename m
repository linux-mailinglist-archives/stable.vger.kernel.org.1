Return-Path: <stable+bounces-72672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5A3968027
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 09:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551631F21C03
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00795156C7B;
	Mon,  2 Sep 2024 07:10:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4AB42AB9;
	Mon,  2 Sep 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261017; cv=none; b=Gwu882hMij/+BgI71P7G83Exii6E1LoiSJKc6uO8iwu8ys+o1QqTR3s3YFtKYa4Hpznc0ADdQxgu/l8R2TKbH8MvN88HCHUIXQOk7m31PIwY1XRpK6xIKVFJQ54xepmgfUKUBwIUgs4TS4kmmZT1m11hDYCZ6/uBvHl07v4yQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261017; c=relaxed/simple;
	bh=YPC3VoqsD87Sp65DLyc9F9bwPyq/jD4yZxZdXmDVhQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b54bLupScj0NKpRjP4nH2aZ5SypdfUAuj4+OgayDJciTRn1J0b1r6t6TPONrXvvsZbO2IvR/jf0EmDunkDS0Md73uFrWIRtBtex3F0rg0Fw90UR23U8wXON2rO2k6cdqX7t/ANFg+NqXFpgee+yt+kdwfyzRgUnHLIrpWd8g3Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9AD681C0082; Mon,  2 Sep 2024 09:10:06 +0200 (CEST)
Date: Mon, 2 Sep 2024 09:10:06 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/71] 6.1.108-rc1 review
Message-ID: <ZtVkzoOn+V733ARk@duo.ucw.cz>
References: <20240901160801.879647959@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WK/NPMud4oG8IuvU"
Content-Disposition: inline
In-Reply-To: <20240901160801.879647959@linuxfoundation.org>


--WK/NPMud4oG8IuvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.108 release.
> There are 71 patches in this series, all will be posted as a response
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

--WK/NPMud4oG8IuvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZtVkzgAKCRAw5/Bqldv6
8u/2AKDDRSTD7UgM+CrsppyGHKbPCqWcRgCfT81t4ywhysaeJaILeIcJ6l6XIco=
=oMLD
-----END PGP SIGNATURE-----

--WK/NPMud4oG8IuvU--

