Return-Path: <stable+bounces-58918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0A392C1A0
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 19:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD82728CE5D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 17:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6601B29D9;
	Tue,  9 Jul 2024 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1Beb+5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6C1B1518;
	Tue,  9 Jul 2024 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542897; cv=none; b=RDd292aOGdu6h1NgtFv3ln+HABhYps7GWnElqBlMD3NKkwVqh63/OPI8h2VaEJVMb6sa9sgXinNcYzpP0Xfu744UGGnJkivr02wrs97qjtilZM5Dxb40bl1gsxsee+m4rveI0ew5HBslxeed/pqBi2QftVfensx7rldaPJf6sSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542897; c=relaxed/simple;
	bh=rLoCW9UW+pVKvh/FxQb3TU3zxLD4iIDyq3ZdnBMYhWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTwmJQzym8dQVgi1xXDGhb5P1elUr4lDKMnP64Dv6eW9XRKwNlXEwcR1pFaCCuZo3NiOz4x4ZFNYZISZbFz+kK3Vs6hREjVYTV+T5ikvODLa/3SSgDn1zT8F0pFlG2tKCGmI/QIvxYjOOauOpeVwQOKDmXmoHIWOsrAG+hLB4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1Beb+5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1E6C3277B;
	Tue,  9 Jul 2024 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542896;
	bh=rLoCW9UW+pVKvh/FxQb3TU3zxLD4iIDyq3ZdnBMYhWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H1Beb+5zJulO5KcNsoR5w/TT/pHoWE/LVijCO8LX7o+0tTAYqoBYPlY0RVM2xkS+i
	 fgkyGVRet28bfLtMzviT7eoqQIuer/NLh/h/Ktbc7C/y5AxD7AgH/ABj0Ma9EOQR6d
	 6iRbv8rzBY/ros6ne3f6JTDtlassE1/kjip28ldkE5vI66XgXAIGXscJv4jIbX/WXx
	 xhBmWpOrdb8wxdxHcNEfNkLVhDt19iiEtPklyq2Ab1y5aFfkD5l64xC+/s0XEjcqWo
	 uhv0qVAQYLnmur/fCaoro03x4JArgi3BBkdldDIO1mewSS1rtL/SkiiwqzhEaWJQa7
	 HBllU07iXB99w==
Date: Tue, 9 Jul 2024 17:34:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 10/40] ASoC: topology: Clean up route loading
Message-ID: <844e0213-33ea-48b6-ad55-145c9dab584a@sirena.org.uk>
References: <20240709162007.30160-1-sashal@kernel.org>
 <20240709162007.30160-10-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lQeTSMDVykzEXHWH"
Content-Disposition: inline
In-Reply-To: <20240709162007.30160-10-sashal@kernel.org>
X-Cookie: Most of your faults are not your fault.


--lQeTSMDVykzEXHWH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 12:18:50PM -0400, Sasha Levin wrote:
> From: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.intel.com>
>=20
> [ Upstream commit e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7 ]
>=20
> Instead of using very long macro name, assign it to shorter variable
> and use it instead. While doing that, we can reduce multiple if checks
> using this define to one.
>=20
> Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
> Signed-off-by: Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.in=
tel.com>
> Link: https://lore.kernel.org/r/20240603102818.36165-5-amadeuszx.slawinsk=
i@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

This is clearly a code cleanup, there is nothing here that looks in the
slightest bit like stable material.

--lQeTSMDVykzEXHWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaNZqsACgkQJNaLcl1U
h9Dcjgf+OdnqqoG1R0sjuvRbByGkWtJDgHlUn3LVA35rz7LUERl9vZEq308lw2I5
MEIbo8aUZzmnrv5s0VeCzqij4t8eyv173ZjQdo4ce139D0m/Jictl63D7ayAtIsR
DSqpAaWGAVkzAWqLZdxHYKr7NW1pANJNBQo2HNndMiK3MHTyIvlXPLmubq4kENqp
Jcq0gA+17pNavPttp67tbvrzpm5EVARXmE314jgE7Tm1SEfuFeUYK972kYXJvh3R
nm4NGTqGFkjP01Xx0+/GUdy69biiTrwfo3N2mvdMXcZnEHq1YN4ttAzVVt+aaUPQ
CL1ncDEx7/RzrdviAZH7mZkcS5lYxA==
=V+n/
-----END PGP SIGNATURE-----

--lQeTSMDVykzEXHWH--

