Return-Path: <stable+bounces-58932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39392C3F6
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 21:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD17B22140
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D1182A65;
	Tue,  9 Jul 2024 19:38:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9B41B86DE;
	Tue,  9 Jul 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720553932; cv=none; b=o58lZchxnN5qnecrJa45Bo1U3cgD90eEoT7jzyDNYL0SCDMe+KwsJV/XwqQyQ2KlqFgtBrPIyKTSQIY0lKeVmcYRwt4TI4dEyFMDxVKVXF+Cy5v5q5IMIB6O3T2I3T2v4ZnRc9c3poC52odSBZA9gD9dbEe37nVJhtkkCQ/crow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720553932; c=relaxed/simple;
	bh=lo7sEVE3TEhT1/nSP2gcFQtCHYoJVudZ/wqd5dP9yYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1wneHrEFYfJbVplb+IRGmdiSUhc465ZW5g2z9NhGMwcca5aVlQqxMDbBUvA0STZHqx2V9q3vf0SERmItI1ZDktEleeIhL8ZP1l3MGVjfPb2Wav/yWK/QC4nXtatMzwLQblCAUn38t1Rf/gj95y+3UM6k7uZHg5fs9PI3kX1MLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2F43F1C009D; Tue,  9 Jul 2024 21:38:42 +0200 (CEST)
Date: Tue, 9 Jul 2024 21:38:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
Message-ID: <Zo2RwT9eihvecoVM@duo.ucw.cz>
References: <20240709110651.353707001@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AXhY6W4bbqpr7N3i"
Content-Disposition: inline
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>


--AXhY6W4bbqpr7N3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.98 release.
> There are 102 patches in this series, all will be posted as a response
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

--AXhY6W4bbqpr7N3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZo2RwQAKCRAw5/Bqldv6
8oY5AKCh9V/1thNPsXVDBg21ygrLpdOaPgCgwhunc2ukVGmFzDxisE9Qq4NwjWg=
=y9Nj
-----END PGP SIGNATURE-----

--AXhY6W4bbqpr7N3i--

