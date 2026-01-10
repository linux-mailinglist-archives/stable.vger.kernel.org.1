Return-Path: <stable+bounces-207959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B2D0D545
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 12:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2783017663
	for <lists+stable@lfdr.de>; Sat, 10 Jan 2026 11:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5F733D4F5;
	Sat, 10 Jan 2026 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ9SuKZR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6A28AAEB;
	Sat, 10 Jan 2026 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768044461; cv=none; b=OY16jJBlFc+a/yhbJIeU7qniAXJDYJZYxkpPXW9tOAgeHY2o2FT9g1/YASGl6l756fGGfLdmnrbn1jhQPneW9jo+YxsJvJSCmyLjG/th5I/YvEwSMHE/N+QeCzbYIM47UEVHCbKX7K8zUXMzceWsFYEbjzgPsiYxg+kXJzpAUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768044461; c=relaxed/simple;
	bh=12v3XHUxwDd1mWoBLh3OFB0tXCEQM3AifWOiVC7yYp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIKQBhh56Szl7/QpPa+j2qVdop/xaPL76bw5MBWPIylJl13043WVcSSOrdDytd8RTyRVb623g2X4dai6woir9ER59vaM52e2+ncsqFZRbfnOLCpv7v7Z2Dj5mABFRClb8WhYcGfGaXYeYfrc7tu8YCQGc2zKq/OLIRTntFaR+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ9SuKZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC03C4CEF1;
	Sat, 10 Jan 2026 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768044461;
	bh=12v3XHUxwDd1mWoBLh3OFB0tXCEQM3AifWOiVC7yYp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJ9SuKZRrXydX1yU3co/+l5diSKk7tvJ2M9Ih6DXO7oHRn7PnPTQe8vMqsCbmeVXq
	 4LDbaaqGWv951Yykt5H2/49SD7dRvCuAkdFvMiTfiwnX+v4kMNQiIvKZI0RG9iUF1Y
	 NFDIbkNdUtewsfvhh4aMbtMrn9CasaSrkrHaHANprkg3XG4+bU6Zo0ANnEFGoEduxv
	 KvDUq3NVb7kgnHnmra7IBDPycGb8DvaiUGWeeUTuNQvOwYpjuPw5y1RqFE1hKgqNku
	 TFxHJePIPIdbjdQjnidI73vGbvYbUzO7MbdPT/QovjeZoBdESXR1ddKH4HnAOiUIL5
	 Rx/Q1y0icTKOw==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 4BB021AC5681; Sat, 10 Jan 2026 20:27:32 +0900 (JST)
Date: Sat, 10 Jan 2026 11:27:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/16] 6.12.65-rc1 review
Message-ID: <aWI3pOxpA594K96Y@sirena.co.uk>
References: <20260109111951.415522519@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qmdafxoDgxD9Q7SR"
Content-Disposition: inline
In-Reply-To: <20260109111951.415522519@linuxfoundation.org>
X-Cookie: Think big.  Pollute the Mississippi.


--qmdafxoDgxD9Q7SR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 09, 2026 at 12:43:41PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.65 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--qmdafxoDgxD9Q7SR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmliN6MACgkQJNaLcl1U
h9Cyiwf/Wd48lm3cjTNafT9BJpZRYdsRRJWVPMf5+uYnjO0EyN5Tkf7Dhk/NzkXk
ed1qHjYgkPeU987zJCosDRzy4Kue8rP5MrJNJXb9CxfH5hQo/0mN3lSxfJW9Hf+o
YV8iU1XPcebgkxrHGqNuLb4mi5qezZkIdLQc1Sm/g6I+vtRvmZ1BAyzIbcOaLxEC
pOtQ0dAqZ1O+DDfWziDxGmsf7I+Ty8z3aCl9i4iTQpuqHRzDreVI9fjrEOwMyeiA
1hHCgNPB2Q4wiR8snFqZ6UnmvCtjlgwhwrDMyaejYmBqNBtZwvFkd40n2GybSHIJ
65QOYRlXRfzjccG22QOkM0b7I/WX1A==
=FOZz
-----END PGP SIGNATURE-----

--qmdafxoDgxD9Q7SR--

