Return-Path: <stable+bounces-43187-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B768BE63A
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 16:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828CA1C2145C
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 14:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11015FA9C;
	Tue,  7 May 2024 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNvK29rO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079071DFEF;
	Tue,  7 May 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092801; cv=none; b=FdBvY0jYyRB/c3ACT9ami40cyUXBnu7Y69JdALiwaVLi6GFAbEjy1YclmwqhKM3rXy+Txt8yXHfJsKzV3TPOhKmDdm3gxxdoBTkwRPYBpNBMCfjWfvb/4IH/7Gf2DZoy+hcZ34pxD5qJLANY8wHxyvB38xZMbNLIOKaoe2jh0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092801; c=relaxed/simple;
	bh=aJ5ZX+YAsMzeoYeU4xwDAg4IAEC5yGBpkTuDhZrR08s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cIh/uLXXJboGgvhyN9buW1sVS1ajik1zPsLlaAyT5z1TUkeyMJX9/f8cOrx9gzVPEV/UzB8e7ItiKA43iGb1fuiuo8aclXRO9R20ykv8jL5T5ltt2Iryt7aMMfWm9sr5RQQ+TEtkRkqBx07zsAPfZ5Z93JuGxjxzflVP53sH/+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNvK29rO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFCFC2BBFC;
	Tue,  7 May 2024 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715092800;
	bh=aJ5ZX+YAsMzeoYeU4xwDAg4IAEC5yGBpkTuDhZrR08s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNvK29rOLYz+E2ieY5XgtWioPzu32o7e3d3SQTkg9VHwE0m5OSzJ9kXMjUMQbnLTO
	 Rmuao8i4LxwHUB3zeUrLpK+0bcZGJK7xuqxNZWjdCmcA6O8Rudu3C8/rUWuaxtNIVl
	 vDaVQHn7ivFH01XaL17hSknAc6KK/TkKpJ+GS6J2WjfMbqD/IDjJQMHyUbCSgb62As
	 maNIt6TjWgG0/ltF4mNwps6DDK2VC6XRK7DXYkXkBVTFXyve1m4WAAfQNSKxjsSMo8
	 t0ekX097hHPxOm/FEfdKXTGaGDHDdmxmSKowH2epwVIfPlp1yQvkqluqHGd5duYaCl
	 iQ390ZgT53xSQ==
Date: Tue, 7 May 2024 23:39:58 +0900
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: Patch "spi: axi-spi-engine: Convert to platform remove callback
 returning void" has been added to the 6.1-stable tree
Message-ID: <Zjo9PrCgSm0Jn3KU@finisterre.sirena.org.uk>
References: <20240506193007.271745-1-sashal@kernel.org>
 <668fcb3c-d00c-4082-b55d-c8584f1b3f7a@baylibre.com>
 <xoadzhyfsjcmvrolb7smsjsvvhfb67m6rcata7sox54yeqm54n@neow3nvsxcti>
 <0ba14e0f-6808-45ae-a6cd-9b9610d119db@baylibre.com>
 <xm5ghowrandbwib2osgihglhwief6buepdcht42uljj65apnya@qgshrnbi2s5r>
 <d2857f45-caa6-4d69-989d-bb95dfcbc7ff@baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wEKiu3WOMBQIU6FO"
Content-Disposition: inline
In-Reply-To: <d2857f45-caa6-4d69-989d-bb95dfcbc7ff@baylibre.com>
X-Cookie: Accuracy, n.:


--wEKiu3WOMBQIU6FO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2024 at 09:22:48AM -0500, David Lechner wrote:

> It's just fixing a theoretical problem, not one that has actually
> caused problems for people. The stable guidelines I read [1] said we
> shouldn't include fixes like that.

> [1]: https://docs.kernel.org/process/stable-kernel-rules.html

> So, sure it would probably be harmless to include it without the
> other dependencies. But not sure it is worth the effort for only
> a theoretical problem.

The written stable guidelines don't really reflect what's going on with
stable these days at all, these days it's very aggressive with what it
backports.  Personally I tend to be a lot more conservative than this
and would tend to agree that this isn't a great candidate for
backporting but people seem OK with this sort of stuff.

--wEKiu3WOMBQIU6FO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY6PT0ACgkQJNaLcl1U
h9DHfAf+K7sy2nQq+5Qa2RQ5HQD5RO80rtZXloTy5a6wPEEQskrX4u/dlyuGT+kp
iDZi8QYf2i3KHTsoDbBKXgbUvYtMbq7O49yhGWoZlPP/kZaKN2zElTZ0oXN/2QVt
J0eCgSWSHaOGZUpCwnVyMAKo63jqeF9EDwYV9Do3liLxQM3kAb8FUlNgVsFiyEGX
xzXnhfGU3G+UJnrEWLZGiTOHOzTj7y6GC4a0KYocltFfJGgY5WHFUIcowo7kTj2m
FIm0q4GHnqjLWbLHwKRxkyq3wDlTt26C8M+H03fmBF2bMs2GJyHRYZyCDBLPK/A0
yrqR02yiCH8PkkR4lVkhFJa9Hbpibw==
=m069
-----END PGP SIGNATURE-----

--wEKiu3WOMBQIU6FO--

