Return-Path: <stable+bounces-104507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8009F4D6D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7A91881DE0
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47FA1F543E;
	Tue, 17 Dec 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh0EmHxW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC921DFE00;
	Tue, 17 Dec 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445023; cv=none; b=tMl0X9+6gTHEuWAFoagE3Z0Fe1cTcDNVk1W92j7ewj8RJoXrSnFdcCOPFy4E0zDK+Wfzh9BeSbZFUTnrH51os/uA/+CoLnyM34KYvR8CaVPbhgi3Uo8W6PJKQ0LqPzK12hMWngjMccFlXYGndGkesqqAt/2fALFF88yWe9PL5OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445023; c=relaxed/simple;
	bh=7EaWDQiz3ku1864YMwkASvsrUlcSGQ3K/iV69ef1jLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRg5PuGFhlcHrzLlPV6zKOgGO3akxCGVTkWtUh6nUhxaMUjX7UBJE3Jn/bsyY9CYhW0I5IZBcscZoQuO1qf6tgqXMXdH/WoaoG8feEz3pvmu9bTbfGkw59MOzltwSkUK4GJI4CDn3vBFpvxubqn1BNwruDQc6rTrSXZDEahhnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nh0EmHxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB08C4CED4;
	Tue, 17 Dec 2024 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734445023;
	bh=7EaWDQiz3ku1864YMwkASvsrUlcSGQ3K/iV69ef1jLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nh0EmHxWnox1JJH8zFpSsJJNRKHE/nB45aTVMkteifPzmTqIaPTVIlIcbQSX/oTHc
	 scuBBRx45bg/Ieugb8hSHrpUKeRAWphROtCMz9/Tz+z3Jv1fLV7NPTptlpLbWqToEr
	 qdJKnL9lASYjAOLqvM+n7Ho/5HRokjuhYsteglNYLoMBsCoCTeqqBUgKN+tuJLC1E9
	 zuhH2163YUO2tIJiZnMzxM23FTxxpyztVuTOZvxpo+aywzANYnYaFlQHUQhSa6Kp6h
	 gDN7m4C9RhWT0PQ2X8M+Zgy8Ji8qtM5TmJ93VMFprDfSBRPu3EjoInfSr7i+oNP3MU
	 icjUP72IXmK4Q==
Date: Tue, 17 Dec 2024 14:16:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Peter Collingbourne <pcc@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64/sme: Move storage of reg_smidr to
 __cpuinfo_store_cpu()
Message-ID: <7bd307fb-9add-41a8-975a-a0ecfec1a933@sirena.org.uk>
References: <20241216-arm64-fix-boot-cpu-smidr-v2-1-a99ffba2c37f@kernel.org>
 <877c7ysois.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2cJnMtFpxG7edgI"
Content-Disposition: inline
In-Reply-To: <877c7ysois.wl-maz@kernel.org>
X-Cookie: The sum of the Universe is zero.


--d2cJnMtFpxG7edgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2024 at 08:27:07AM +0000, Marc Zyngier wrote:

> My reading of the thread was that we don't need to kill the
> arm64.nosme option as SMIDR_EL1 wouldn't UNDEF, which is guaranteed if
> SME is implemented at all.

My read had been the other way around, I'll drop the change to the
override.

> What was needed in 6.0 is not there anymore, for all the reasons that
> Mark outlined and that you have pasted in the above commit message.

That's a rewrite of roughly the same stuff!  I pasted the commit IDs but
the rest was a rewrite.

--d2cJnMtFpxG7edgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdhh9kACgkQJNaLcl1U
h9CYyQf/Wvw3RKu1eUbog9QV/00EOo70CEQSxMcNrdCNvvJqVzAzzIFapUar8CR2
GQqcyJ1YyUWAS45ktwGfH0rNS6+ukfAx9t3muRFjtO+JjLoY0WUU0WrZHqGK2MX4
iYULrzXLqR/FpbWNgeDf85aRXURG+pyxNM6wbna+wl3C/DXLENZB/HQn+0IRWsfc
F7AJvXLnkSJnCoZXb0KgJGNq8vJBfIIv6/pTmdaHjfF89xVqgbdROhIWqnAQFN9v
0GRsBI2CYs132fhseGAK7kOff+b/uhhc816mWHS01pFQ+F231vsP81CoIbzlurmX
XeGMjA0u5HyGXJE/uW2a0eutjHKz/g==
=Fvq5
-----END PGP SIGNATURE-----

--d2cJnMtFpxG7edgI--

