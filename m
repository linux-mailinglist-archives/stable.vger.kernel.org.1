Return-Path: <stable+bounces-188990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F3BFC18C
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F7AC56325B
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1B348893;
	Wed, 22 Oct 2025 13:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="HG7mUdE0"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0E26ED5D;
	Wed, 22 Oct 2025 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138558; cv=none; b=B/zCRiHk3H5jghQoAxSrSdxaDxuLpWfAoVRJ/hG8xZGi/XPYqk1AUm16dNFFzGvZYqxFvclTaHX2Ie/c3BQIPjBF3Yfr8XcvmOSGA9RweRg6zF2eXBMGwmA4/S9LzZ9c0dwfWpAQdrNSWNX68r5O4Enu6y9WWwUJ5h9H0NtKDJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138558; c=relaxed/simple;
	bh=iCTviRihb3X0oAInsyVo5UH7WAmxGJ5YDx2HNR/5HrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSPoAcVuOvP/QBn22cwLWWFpJ5mYehhEGMNYxUyGHe1fesPZhjbK1l1LBcsahB1dky1HBmqaL1qWJkaL8/X0ICeQT/gdlTBqBu+Bv7gBKv8NwOkb1ctIhY74JqKYE2qqR5CM8a+taz3aOy/OkQ9J80WWjGRFlyNaaOorc1ZTCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=HG7mUdE0; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A18601038C10E;
	Wed, 22 Oct 2025 15:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1761138553; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Jt9Kl/lqzJC8nSHuHfA4BO2LnLTGxjgOVuymH0d/9d4=;
	b=HG7mUdE0S73Lc52tuf6oN3duKigVfmCq4gowBKB3wEZIzv90/SrmGwSrk+EWxsVuWGSSgI
	j9hBoKu6Nal61sV076hm2X1Hbm3rj1yDOtQXvXX44u4UArrgyjuQMjrCRqbMQv/0MJaZ77
	btpV4pi6WrDCtawN2T666YlQ3aIUtSAgoug9TulBShbc9SCzSzWEWhwHmp0TyyuNyh/r+k
	cfJwYpJEvKxxjrqwz2fHjAX2MmDkhiyhpIxulpg4zuXSgRVxoRRMNyeRlfKCPx9BlMo/rj
	U0w2NQfOm/2dHphbsB0d+woQhN+LTaJwQlQVsMxLM1Gbji5QaOf3gcDvTbDRPw==
Date: Wed, 22 Oct 2025 15:09:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
Message-ID: <aPjXdtlTDPJPEh2P@duo.ucw.cz>
References: <20251021195021.492915002@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H/TxGLwHiqvfg42r"
Content-Disposition: inline
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--H/TxGLwHiqvfg42r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.16.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--H/TxGLwHiqvfg42r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaPjXdgAKCRAw5/Bqldv6
8tbeAJ9Ln1tT0MkPOHVtRvK8DYuqyR/NtACgrarl24k3JPYKwT+YvgPpkCVpyuk=
=l8j1
-----END PGP SIGNATURE-----

--H/TxGLwHiqvfg42r--

