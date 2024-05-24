Return-Path: <stable+bounces-46055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4523C8CE4CA
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC12823CE
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 11:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC384FDB;
	Fri, 24 May 2024 11:22:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8C53E31;
	Fri, 24 May 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716549766; cv=none; b=TrqWyIFZ/L9+nW817suR1u18bx1Ypydqa6FilB4tpDrm5fXBQXBNLsnXgxM1iLZ0a9o7wrd+V3oJO8K9q1znfPfDUD4D2Wq17Q68lXM4iF5x7GMpC6YcQrQY2eSucXOVn6y9xpRCAOLeZ2afgow2n6m0Bp/9RgtV+CrMHXVr6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716549766; c=relaxed/simple;
	bh=tljcuBWBNfnHPZfm/AAfMN1xh00NcpjiVYCJbDr/GMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syBu9tYnKM5Q22sgKcZ+ef/O+IgOIwBS43LfyoVPDxa1MkrC2cIsQZmSsKamVucJwtL0Bnta2UD3ZcqLnqO1LbH0kMXyTO3drbqUWFFi9IfR78SikqPoSdV/354O31OMhki8X4a+g9Yguz2eSB0qyPc4EUaIYh07/jjIwIX3XEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id F03C81C0094; Fri, 24 May 2024 13:22:41 +0200 (CEST)
Date: Fri, 24 May 2024 13:22:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 00/15] 5.10.218-rc1 review
Message-ID: <ZlB4gZZcFvO00YtH@duo.ucw.cz>
References: <20240523130326.451548488@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YdOovd4uAiHUG4qe"
Content-Disposition: inline
In-Reply-To: <20240523130326.451548488@linuxfoundation.org>


--YdOovd4uAiHUG4qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.218 release.
> There are 15 patches in this series, all will be posted as a response
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

--YdOovd4uAiHUG4qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZlB4gQAKCRAw5/Bqldv6
8pMuAJ4vycyO0orD3n5qWXBVmbLG9dDFvQCfSWl4HC3hgRlkwqu7lvsR7ijMG/U=
=e754
-----END PGP SIGNATURE-----

--YdOovd4uAiHUG4qe--

