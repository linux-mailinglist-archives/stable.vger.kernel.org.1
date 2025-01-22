Return-Path: <stable+bounces-110208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4671FA1971C
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 18:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21131880A51
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34465215075;
	Wed, 22 Jan 2025 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDnFTvyZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B11E526;
	Wed, 22 Jan 2025 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565530; cv=none; b=Zl8zrahHKmtTDAisGMGlD73/SgMAV/wB8FZ4haR7pMYXqUlS98TpV5+UlYp6JV2Tbz3F5oN7n8Dawbw2ittgfyxRFa8SIQy+EOZn07FeGLrDdPHDOEJFtpYf5IP7WSruFKrf672a9D0A8Ak+VwwVmLdLi568AF7lgX/peDOcCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565530; c=relaxed/simple;
	bh=jdlpxv7VmLBnVK7wPxtmKrF5zBP047/PAtxD5hn+vWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZ/Yh0D/d+vSIfpuwF117aCH/H3uTN78PBWAYV+hkvI1ehXZE7+faysPLABbHtNH4WEVcSnSXQKWXuoihGt/tl/AW7Sbarufi1uFeBFr/FeBNIWCOgX1ddqA5pL5RAi53xAcuhcdEuyVPMcE8g7z97misWsCLvSJ7Wv6WL+uNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDnFTvyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA85C4CED2;
	Wed, 22 Jan 2025 17:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565529;
	bh=jdlpxv7VmLBnVK7wPxtmKrF5zBP047/PAtxD5hn+vWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CDnFTvyZN1K96hZX5UUbZUFj66+ZUntNIrvi1U6M0rPihWFPgjSfQwEcu/Z6suJH/
	 xQRlIxL18/CO2zGUU1Lntn6SnWS1bQqwfbPZlr1sXxSgdn1PG9BttxZpxIDGChIVcp
	 46l8FLa8HUdgY44gBt0NA8R9FLTU6+U+2JbR1BV5G40QoTtv0RK6vIxyBgf4U0TWQ7
	 oHHA6FAWFeFDO3y0oAOfhgoBj/QCZAPeo/ts9vOkqvwnEqsdbQEWJK7sof/2t5ZIJj
	 ufTjYpLXBLtLcSW5fv/za0HS/3uCzKIqh0GYgCrafeQGTmT2emARc2JfKPUSyoc9le
	 zmzNCp1QhCEjA==
Date: Wed, 22 Jan 2025 17:05:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.1 00/64] 6.1.127-rc2 review
Message-ID: <992a7ac4-cd37-472e-9e9f-7fa7d3605949@sirena.org.uk>
References: <20250122073827.056636718@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0WsjTF9G7a9oaFFy"
Content-Disposition: inline
In-Reply-To: <20250122073827.056636718@linuxfoundation.org>
X-Cookie: Star Trek Lives!


--0WsjTF9G7a9oaFFy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 22, 2025 at 09:04:01AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.127 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--0WsjTF9G7a9oaFFy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeRJVIACgkQJNaLcl1U
h9BBuwf+PQ+Q13Eb19+5M8vikI8tFtQxMhOAv2fTB1WzwCDLYieXgBFVwoIHRYl+
w2bzaSjvUqSbiDPePJIGfBV5GeO27/ikKNFexIEDI9J5T6nkutZFwG+y8ZGNyhoq
9Ms7Y5/HVDKCWUNCbGP0WPlDop6yPbNHbQf0PLQDC+SDcE7dGvHXYJyY3a3hEdFZ
bAzZzzNl48yI+vRvAve0aL0DPJkfkcTjn0zQrLS/kzEurdFrCOfXI93k0oeJMWxU
e7rxscPKI/DmkOkZUhJ7ybybOM1XN6c+g5EglWU3tIZ/MvxkxlfeHjgJ6uKpnIqO
pJMdwXvPkfH7rAnZwypyHklamq0pGg==
=Nfki
-----END PGP SIGNATURE-----

--0WsjTF9G7a9oaFFy--

