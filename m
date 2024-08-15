Return-Path: <stable+bounces-69236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE78953A65
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6601F254B8
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 18:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C8856B72;
	Thu, 15 Aug 2024 18:54:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F98433D6;
	Thu, 15 Aug 2024 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723748065; cv=none; b=RyE+Iq0TnepZFzOYqm6AXUyCE8MHcx8KPrfLTr50I5NfLPqE5NBK2Hts3Hoo14xe2jYAnhUgBX5WlxDysTmtysKebHE9n1jpma12teSBnrnBgtj+zaMVuUy97CHM0wkDYK4NNHPmEbCw2bFnKW6Ub9SBxfcs8jwn1ghVOHgWFmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723748065; c=relaxed/simple;
	bh=t6SAs6r2/QC1fFdaxcvL4jVkqAGg7qkfNxjw5Celk/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f++LNj77eKueiRyZ/DwPLrZbv195XNuABIhNJQ8wSISPjmbwqHMr7O6+aawl4bLypVIdJA8FSbE/vTMylXTK/W3Z4U+xg9OoWr5M0G/sVsg6CRGjF8ZJO+dKbHNdIY2t7h8auvD63cPoKOkJHt1eUjLAG/4VKXKEN73YYIsc0EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id AD9211C009C; Thu, 15 Aug 2024 20:54:14 +0200 (CEST)
Date: Thu, 15 Aug 2024 20:54:14 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/38] 6.1.106-rc1 review
Message-ID: <Zr5O1kh1GpItTgiY@duo.ucw.cz>
References: <20240815131832.944273699@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ol5gAA6YV1QE8G+R"
Content-Disposition: inline
In-Reply-To: <20240815131832.944273699@linuxfoundation.org>


--ol5gAA6YV1QE8G+R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.106 release.
> There are 38 patches in this series, all will be posted as a response
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

--ol5gAA6YV1QE8G+R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZr5O1gAKCRAw5/Bqldv6
8sL9AJ9KkJfJPbHXXUWu1Li9Ym73pFMX8wCfRjwubEllBRrxjw2x0vYDjfurG5A=
=hC9L
-----END PGP SIGNATURE-----

--ol5gAA6YV1QE8G+R--

