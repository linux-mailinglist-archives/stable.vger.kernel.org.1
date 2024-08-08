Return-Path: <stable+bounces-66077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0525C94C322
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 819AEB240E5
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E7619149D;
	Thu,  8 Aug 2024 16:58:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5C3190676;
	Thu,  8 Aug 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136304; cv=none; b=qT//z3jYR0+0aZHgUtPtUQ+ph8jOYMxT7OHQjp7zF9CJ8hbSJdiO85k2gsA2l0TvUsssjzjh51j0GYUYtneQMqrRpvtZZPbUTKYQLCtMR1CXZzzqu7b0MWmJbpJzPTFtROa8y2Cw+roIWp8aEfPRbLclGPfNLc1iGQewZRU3/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136304; c=relaxed/simple;
	bh=Mpy5IB/tQ+rRu38v6ifYh3PWH+mfPYLFlshMGkg5KWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drpl66nvuz89hIUhN8NN7sIM9wuo0Hsq7xGvuxa2bQ3iXrq6yAWmE1xlsZrBo7+nJADQbDrktQEmdOi5KfqWCALac1CH99ss17oKl1FEIEKMsspLG0Rr+JJHIDolSWWEEJ7dgK0gFSn8sW95Ly93J04cjn7vBQJOXmImdWuvLVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EB1BC1C0082; Thu,  8 Aug 2024 18:58:18 +0200 (CEST)
Date: Thu, 8 Aug 2024 18:58:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
Message-ID: <ZrT5J9qfccU0zGfg@duo.ucw.cz>
References: <20240808091131.014292134@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ybSA1hQRYJFfxdOk"
Content-Disposition: inline
In-Reply-To: <20240808091131.014292134@linuxfoundation.org>


--ybSA1hQRYJFfxdOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
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

--ybSA1hQRYJFfxdOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrT5JwAKCRAw5/Bqldv6
8j6dAJwO6D7iXe+7GkwaOM5XCSvkaqCmHwCggg3OXL2MgsrnFnJuF80tmi+YV5c=
=Ct8o
-----END PGP SIGNATURE-----

--ybSA1hQRYJFfxdOk--

