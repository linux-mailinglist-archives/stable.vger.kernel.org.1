Return-Path: <stable+bounces-91691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDFF9BF3CC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A803B21A11
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D019B205131;
	Wed,  6 Nov 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2TTy5Op"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBDE206506
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912348; cv=none; b=mZpoxmg42aiMlrWP5bDi2kIC66onn8FX2efvT750jpZjsqFZ6pkb08CaHtUS+kktJirx6yaO/92tqI9NzdPwowiX9Sy8OZ2+iClzecfl6XbFD9kc1+Ur21XXnleWaReziIEIEvKg6NMCYnkQ7sj6qjNP02ZUI6829vk31fy/awY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912348; c=relaxed/simple;
	bh=HZ17WqEILD7Kll+4ZeYXAHOwrO2QFpsk2DvYlmp301Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkhxPjigNir/EyrPDBh77PC+h0Hpvehu6t9t3NZ0/Z00YLasHaB9n0JPnbNHue0z2X+s3S9YU2GYu1Ejxw/LLT9t9sPTmozCJ77AgWwmAHUIdyJa2AakqG1ZpbWIxtC8QihoxQPPzMfk6Sva/L0ZbCM98q1MaLyZBJMD+2GWTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2TTy5Op; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6B1C4CEC6;
	Wed,  6 Nov 2024 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730912348;
	bh=HZ17WqEILD7Kll+4ZeYXAHOwrO2QFpsk2DvYlmp301Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2TTy5Opov7sh+rDv8kdwfeF+lVtZhDpschWVtHswEfyoHRo4ZmqDwQieaR8x2n4H
	 CzH0q4frq8yORjmM25Sh5btewKpYgRKwuEQ3B26t2NutXK2psJ+bQ7v+Kx2j11arOd
	 E/6vEmbwX0e8kKus0g5saDOtYZ3wEwpGq78eFPXI+Aa/CebWBsW7/cvshFHNA2mMh0
	 dq9+Bu+ADSXgFgxLMRP/zWSVs2bJmFDoRNEanbWumfFT/651Z1Qa4XaikcUe8JdNJ9
	 pDXtOD6XhOFtKGwkh91drgB+yOHe+9frlq5ezKii2HNDCJ8PuoHRtBX0GTGjaXsD91
	 4jvkUJeg2MXFw==
Date: Wed, 6 Nov 2024 16:59:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
	catalin.marinas@arm.com, maz@kernel.org, stable@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH] arm64: Kconfig: Make SME depend on BROKEN for now
Message-ID: <adafab34-b63e-47a5-bdb1-3c00aa4e191e@sirena.org.uk>
References: <20241106164220.2789279-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ozIHRFC2xGFdUTh8"
Content-Disposition: inline
In-Reply-To: <20241106164220.2789279-1-mark.rutland@arm.com>
X-Cookie: Include me out.


--ozIHRFC2xGFdUTh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 04:42:20PM +0000, Mark Rutland wrote:

> Although support for SME was merged in v5.19, we've since uncovered a
> number of issues with the implementation, including issues which might
> corrupt the FPSIMD/SVE/SME state of arbitrary tasks. While there are
> patches to address some of these issues, ongoing review has highlighted
> additional functional problems, and more time is necessary to analyse
> and fix these.

It would be good to start landing some of those as well (and more of the
test improvements that are pending as well).

> For now, mark SME as BROKEN in the hope that we can fix things properly
> in the near future. As SME is an OPTIONAL part of ARMv9.2+, and there is
> very little extant hardware, this should not adversely affect the vast
> majority of users.

It doesn't seem ideal to bounce on and off in stable, though as you say
there aren't really any practical systems at the minute and hopefully we
can revert this fairly soon.

--ozIHRFC2xGFdUTh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcroFcACgkQJNaLcl1U
h9D0gQf/aDpiO9OipacEeHevFDiPlRn8VswSIyhWS7wB6DmIXKG8c2kpuUjfAudz
at7bqcW1OIPNG28Ch51pyA9aFESqsXPI/m3cCJeba9k6CtwUFDJ/UPQk0DU4WQYD
H5GjsoKStlTJl4hjOr629IMWfR7ZGe6BjZh3S0iwwWRPu1IzUQdrDs9E+svsuN3s
2dJhzlKp29dZOCaSdZ9p2kOHlwmfTWDeB9o9dmSXV7yT1EaMIwpEe2ihQmwBqpAG
0ocAaSrH+KQuSUKeNxGU0m1s7fHxB0Hu39mavckaginH+Y0Qe0vJrgFi2N/NYrHs
ZKnwgCdaHHl07hQNcVLR1TDJkSj1/Q==
=7wit
-----END PGP SIGNATURE-----

--ozIHRFC2xGFdUTh8--

