Return-Path: <stable+bounces-49921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC048FF575
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 21:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A98FB21CC5
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 19:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E035339B;
	Thu,  6 Jun 2024 19:48:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3761FDD;
	Thu,  6 Jun 2024 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703326; cv=none; b=in5JsqH8+xmXJf/B8y1HLvGOTeHKUzf5aCKy6HoC9RLOHHbDkHX2rNjTVlTJcGEZytLhm1WeYOtsX68Ut+ZkBbfLIXydJhV8+OFJJz+2+CAYW0i6nA7dA2GKx8ZsEQi1krksWI0mYenyEQxmkGjhk84lAOZs8Eu4/gjzQaxrz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703326; c=relaxed/simple;
	bh=LebS/2fw8s2Lxg9BC4+yJBaWgY3uUUSnjUqqokjqy4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dm9A5lUHi1Lh/L0QAy26z71wFMQKsLXO6Ul5KnrRtyocOzQxWcKJ6PYrL+KOGF+Trlymc/PV9qcq4TwzQGKIAMnoafi+Ur/ozVRAyfx7BN39CSRc7C0OdLfmoHUOjq5Hyxic8aQuaMh2pLCYo3MaXp0GI91D/sTXo4Xg5cI9NXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 84ADE1C0082; Thu,  6 Jun 2024 21:42:59 +0200 (CEST)
Date: Thu, 6 Jun 2024 21:42:58 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/473] 6.1.93-rc1 review
Message-ID: <ZmIRQizxFNmy+Y/m@duo.ucw.cz>
References: <20240606131659.786180261@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HmC9bVVotOoa1DWC"
Content-Disposition: inline
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>


--HmC9bVVotOoa1DWC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.93 release.
> There are 473 patches in this series, all will be posted as a response
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

--HmC9bVVotOoa1DWC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmIRQgAKCRAw5/Bqldv6
8h3WAJ0dYJ6eR2CIyzkkTAahqJVYP8DSTwCfYJAXqvLrjXZrGXT1i0cH4dSjBoY=
=J4N4
-----END PGP SIGNATURE-----

--HmC9bVVotOoa1DWC--

