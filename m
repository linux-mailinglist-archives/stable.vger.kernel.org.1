Return-Path: <stable+bounces-181491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC3B95EC2
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E65E4E2E82
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DB2324B0F;
	Tue, 23 Sep 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNDmIaro"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96314A9B;
	Tue, 23 Sep 2025 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632520; cv=none; b=Le7ri3tWP1FTNCyX470JFNv/tLPgA22C5jbbSs7fx8h/M8xj2W7Inp9gCm8QRH5r2i5Ghi8zDl1Kzgw8D0YqzH1pLCcYBBflNhFNyOeq6rtrZOeRt6vc9KqqOTKlVBvJL1adKjPBGw+frKYJ0VTtaRVeicwftJLaDtrou5E3zjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632520; c=relaxed/simple;
	bh=uaL/Zkr5B9KzHJFTlE3bZdtoVBKfoyCTKWba5LR0c/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuVqtvf77MJjtSWENSr/YDF3LmIRxA0k59JnFYDrKu1hXwC87Jk0gFoSR7gGrE0HB5gnJQJs14k2mQuC8Di34mzMvKJLHxzN2RMt92LtdO1i2Tt5oMYBsTHNgDIyXWuy6+LJRo7KxQyNdHlQ5rHFPlaoYa5LvLbyA/yWEiAMNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNDmIaro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338F4C113CF;
	Tue, 23 Sep 2025 13:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632519;
	bh=uaL/Zkr5B9KzHJFTlE3bZdtoVBKfoyCTKWba5LR0c/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNDmIaropbOEZe125rvhnTim+k/Jvoxb6SJG2Jdn/BMRGTszhyLeAUponmx5vZ5FV
	 Ee9y09eQoMB15QmT84FpcGfy44n6mNWARm9LpNmGs0M/9g+QflQAm3Nwo1wXa01LCk
	 4K55khZqitFYfbDJgcUZATKoWWGwpJR7bV1rCvT3KPy8WWNNk/noXs6eV+eUNcza9c
	 BKsab5oxxncMWQIC8YxJBZoC4V6l/axP6Rz7V6d7uWKuavQ0EbZt/8f0C2GLwjDk2m
	 uWiBQTbo5x+xxxtDCRCoUCb0QGeBf7IX2Gbxs+/owKz0hBwLPIOgFFax/Lf4Wy4yMK
	 wBHgROY30Lokg==
Date: Tue, 23 Sep 2025 15:01:56 +0200
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, achill@achill.org
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
Message-ID: <aNKaRLu0avcXtvb6@finisterre.sirena.org.uk>
References: <20250922192408.913556629@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qN+DdBK45s5K4Vjw"
Content-Disposition: inline
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
X-Cookie: Filmed before a live audience.


--qN+DdBK45s5K4Vjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 22, 2025 at 09:28:43PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--qN+DdBK45s5K4Vjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjSmkMACgkQJNaLcl1U
h9DdGAf8CqZqrV2+8kL3LHqOymLCI1rLzzcmE24N031+36z/uzPsqjkWy1a1qpbf
juvFhO8bmedwuf+mhcWo4u6Q2pW4JScEehRnB2xVMdtgU5/m5O0mz2XLVI5HEUUP
q1X72TE3gqwWN0KoY/DwzfNopvFAbZA7y644vzFVQin3c3hglKJ4gqIxnB7lXL2Q
9HrY69JvScdVScB9pa0z9svhuWaTICHhKRXMFHU5gDHpldyuVQzJltXAyKvmxzuO
EyiNu4JAZIADIcPzogNntz4kayqxpNQ/BKiNvJcv703WPxuTf7q3kKs+raTZyUo1
nXf/CULbYK/37CGLBwFeKq54vmRpxw==
=9qoR
-----END PGP SIGNATURE-----

--qN+DdBK45s5K4Vjw--

