Return-Path: <stable+bounces-206127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D550CFD7F5
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 12:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C47513061166
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 11:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AAF22370A;
	Wed,  7 Jan 2026 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrduwfSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095FB312813;
	Wed,  7 Jan 2026 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786553; cv=none; b=iraaBxdH3rFzJsXgvk87nnDHnvbalYKmF3HdDGG0r0O72jRN4kAtLyaYhlBr+oeRMzQrgGL1wfVsguvKc1EWzPty846lNMtyPPyvFLrhZU3WHuWsKKRWY3pAYmc5KU38oIXA534D3+nSDuMxxW0NFb6QM5xYF5rLhlygUEuZIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786553; c=relaxed/simple;
	bh=kvpeqtawFEK/EuYBcNVEmXhrnGGkIfTmpwMaRq4TS7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tz2vhGwOtZI7Eak77PlReA3kfMMakzK41ogUxDwSCuCV39saBUoNazEM/hcslbka/4duLIAO5ccqMLqVUwTd3ieXhe1cwEBiyoK2phpx0hoVIrMS13kqLOpCKjQ1hLIh09RtC6abUPsfEkYZJIOisiN1tIQT2jNeGPrVNtn7wy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrduwfSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0CFC4CEF7;
	Wed,  7 Jan 2026 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767786552;
	bh=kvpeqtawFEK/EuYBcNVEmXhrnGGkIfTmpwMaRq4TS7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrduwfSpqYzatkhOauszyAK8CBtX85s6wARQ6yipuqpfl4m5oKOYLaPl1SD/tBR1u
	 csDMSmRabsyax1JvM0NK6eIgrbpWnIKoDOdlukpmvCL4TIZRAFPA+xHZs0r/JbVujZ
	 M7WFHyvKSds7dxzC9C8HnaMZmOHIvC4IcE4gplm2nRa4QW3qxbzLt9kX8PQqJ+SQnO
	 OGVMNxyWM8HdP7QEbB/V2t5D3iJ/SjZ0ML1mLN4ky8m6Y57Pnq7PyCmH/64mnVhT7S
	 vH8ika+egE3U+pyOrxX9n2P4819lF1Joe/rxcw9tzuOzsn6CAzMaRZBqteUe95AnFm
	 SHuoMQvCd3OMQ==
Date: Wed, 7 Jan 2026 11:49:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 6.18 000/312] 6.18.4-rc1 review
Message-ID: <72f8479a-13cd-406e-973c-b75e2557e4a4@sirena.org.uk>
References: <20260106170547.832845344@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fvtC6PS2P6l4ADwd"
Content-Disposition: inline
In-Reply-To: <20260106170547.832845344@linuxfoundation.org>
X-Cookie: Is there life before breakfast?


--fvtC6PS2P6l4ADwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2026 at 06:01:14PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.4 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--fvtC6PS2P6l4ADwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmleSDEACgkQJNaLcl1U
h9DWggf/fkeZPvRaTKlYqLJ1FG9av4s2g53sXVUHkJrNjTnqvTeq3Xt1Ry2A7aKD
G41GrlC8BvrPamyRak4jjAwQzFqvG309Xcu8oZnIMsd2jqyh42hitJ1Zz+wh8+wb
U/eMcAuucZbu8mf6du1DhPj08Iw1Ar65A/z0UfKCdkZwgsMpBic3wm729sRD1SOi
elfiSeIi7955tAq9fTuD7pOk4HIH7qy66lENlWfjp7enkACoh+zM7e9J4sw1tPO3
LGNuucddr7Z4N++JiPsSEHMzohOIVk/J2vQ1LphvTF8R1P9iwZatzogfK9kyTros
np42POPe92pbonGHja2bF3rzxCcrZQ==
=Knpa
-----END PGP SIGNATURE-----

--fvtC6PS2P6l4ADwd--

