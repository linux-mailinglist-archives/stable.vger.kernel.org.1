Return-Path: <stable+bounces-91682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5719BF2C1
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 17:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0001C2680F
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472421DCB06;
	Wed,  6 Nov 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVkglhNx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BA9203707
	for <stable@vger.kernel.org>; Wed,  6 Nov 2024 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909221; cv=none; b=l+lFwc4oNzT4cvmgv96WIO4fW09IRlg9I5gxZOqyGAYOpzG4t18aOhIsnk8TEfLZyAdEvFBkYOmNaTdqsngqkOOV8ukzqZDPph9ZCL5DegbwxWTZC6ZcLTlkWnmSKFmadxw7y3nJw8dAU1bLDMuWc/l/QZgXsKgKM2zHiksB2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909221; c=relaxed/simple;
	bh=pu0Wia3hlf/LB7O+kFXEPDBndKHemByXqXEUjPGYIYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwgsjKUZKFWj2c3tkgjiWrKeoVnsZPo7MFdKP5hMO6JxJeRlWkqWyryIXjkibsZ5DLbh33uDApapYMK2OEwJvZF3PqakZJliwXcFVdrVBb2jr9QCqBFoK1RRriNG0QOv04qlwoFUL0ER64FNlcMw3Zdz4mrB4thUlMyokop4uqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVkglhNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA84C4CEC6;
	Wed,  6 Nov 2024 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730909220;
	bh=pu0Wia3hlf/LB7O+kFXEPDBndKHemByXqXEUjPGYIYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVkglhNxPwWrrGeFU4VfNT+N0/Fmws0dpjk4ycr9Mq6G78ioY1aIW24tNqbnn3k7g
	 ZqOY6kyG1qsAXiVt0zd/6lBzOvO+fQ/YpdV71+Yv3MVA7F3ACuNH8euLTQTttlk+v9
	 GDuxdlR7EHAVK1dYNZFD92hTGXB5Q+nJB5n3IvEMzW8oD3njFDej1V6HvBFKDBN2S2
	 4f0YKkEaYSoHsX/j+FIYMmHf3WFBHfXlzANK5e3r99QxyQbdNrscxxnbsVFDcEm0C6
	 gpreuk6DBqv2LY86M2eg+L7qOtJJiqSKQTjBBr89+jig7kTsavD686oQmTpWun13+R
	 dZ8KDWyHrwi/w==
Date: Wed, 6 Nov 2024 16:06:56 +0000
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
	catalin.marinas@arm.com, maz@kernel.org, stable@vger.kernel.org,
	will@kernel.org
Subject: Re: [PATCH] arm64: smccc: Remove broken support for SMCCCv1.3 SVE
 discard hint
Message-ID: <81419669-73e4-45ac-bf41-34d6ba486f7b@sirena.org.uk>
References: <20241106160448.2712997-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3zLnHeDXX/K5rPDI"
Content-Disposition: inline
In-Reply-To: <20241106160448.2712997-1-mark.rutland@arm.com>
X-Cookie: Include me out.


--3zLnHeDXX/K5rPDI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2024 at 04:04:48PM +0000, Mark Rutland wrote:
> SMCCCv1.3 added a hint bit which callers can set in an SMCCC function ID
> (AKA "FID") to indicate that it is acceptable for the SMCCC
> implementation to discard SVE and/or SME state over a specific SMCCC
> call. The kernel support for using this hint is broken and SMCCC calls
> may clobber the SVE and/or SME state of arbitrary tasks, though FPSIMD
> state is unaffected.

Reviewed-by: Mark Brown <broonie@kernel.org>

--3zLnHeDXX/K5rPDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcrlB8ACgkQJNaLcl1U
h9BqxAf9FJQETr3FKwFyRVvi66Y62WIGIGeFzckg32dx2UxLO8Yg1eRcUp7nB3jo
qJ4pAmTrvh77Fddq0pv2C5CehTTI+Y3NmpkWTmcuejupSO7lOsH+Ysf8/b0aBE1Z
r12WSzdvqj3t60quOmQ8h92vNwY6J9tuv9Iuwrj43tTrgB3C5EFXYQKx8ioCpyeA
i4Z2kaFpJdTcAGtAumAfyUosK/FVE7DTmGTvKJtHvuuVjhNKS6GkW/9o/Mn6bbuB
RElkfET7HuzX3oaWv5fAttzZXAIkQvD3tOMBy56pq0inUNxFNmynNxwBLraoe57k
iX62RIodw2Kj2mDfAew15cQG6+Renw==
=8QHA
-----END PGP SIGNATURE-----

--3zLnHeDXX/K5rPDI--

