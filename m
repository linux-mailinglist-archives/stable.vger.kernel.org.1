Return-Path: <stable+bounces-45190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0358C6A7C
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC863B23278
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A93156971;
	Wed, 15 May 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f34eXXiN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52C156880;
	Wed, 15 May 2024 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790155; cv=none; b=KJP8Zci+a3h8WeDhRBw5mUBdxWnWEYcgcZ/JB5rJnQETDr097/goXJ4LFnOVAjOEvaYpz839C5g+NFAIoC5mllSMQ/NJul4Ck5bus8wRFN7wD/0LUO9BhYcLwwPFtIR4i4f/FFgaEq/yfR8vsaiu9hAzCx+JZ33Hr2Xr0BaK4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790155; c=relaxed/simple;
	bh=n64Xp4xZKAvzHRMnd014SI320O3Qsco4wVV/s4MHOX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgmOYB/+mUYtTuxQ/M25KpuNP7GSsACH6NYrGUpl7qw2xS2mkOykFt7pO4Awcc37yQFJOlEre1aNc/o1yqsyQvXoBuGWD/9g53tMJHLmswFsGIJinsdN88gdME8NSzOd9x88ENWAoIXh48Fbpuz2i8SidNetUO8YmvvygWFY9zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f34eXXiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21FCC116B1;
	Wed, 15 May 2024 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790155;
	bh=n64Xp4xZKAvzHRMnd014SI320O3Qsco4wVV/s4MHOX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f34eXXiN5G13LwsNXOFVoeyHJ+vmt05ir/C1wcBVLncQM3JDEac6HgkSGIZqmZQw+
	 IyQ0T+4oK2F5lEUjn37EHevXpuhcHFtwAx5J9ojXhIthNdQBKAtd2PhLv6/WHZr6l7
	 t8kFFWK6AeMrzETb+qpOjrtyHTc86Suag8bwY2gcJL8FP8DXv/Ipfb2xVjIfgrGBWF
	 sv8WBy25wbftzJeQdzHloBFXacDGhg4R8hGcdDGQr+gx4D/9vfHdqYGyaPv/3oawbM
	 z0OF7WwOaiwOLROfsiuPgaHfzOYhy6PhcIdudh+xdQIlIt4vL5wDgZbAwot0LsPYIQ
	 hp5EYv+qJ9AQw==
Date: Wed, 15 May 2024 17:22:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/309] 6.6.31-rc2 review
Message-ID: <10ed5c80-c2e4-4b8f-996b-0ebce499a094@sirena.org.uk>
References: <20240515082510.431870507@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cL9hAooNExvMNH/8"
Content-Disposition: inline
In-Reply-To: <20240515082510.431870507@linuxfoundation.org>
X-Cookie: When in doubt, lead trump.


--cL9hAooNExvMNH/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 10:27:02AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.31 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--cL9hAooNExvMNH/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZE4UQACgkQJNaLcl1U
h9BpJgf/bLk94GOQaQV1unXDIQE2s4/D9/dEcSiIGg6Klyya5AEfr4374hve06Um
7t1OYnKyTaM3Ol/3bt0+5ZdKr2JmYVHVWxX0PFWLlvbB2G+qFZiCNvI112SDfxWu
i8SrfRXXORTuGsufgSl0pXDodxl5a08CFd018X4LhTBr4a0cMZSC4m1aQI7+7A1T
T3XtQmD8+aVgMz5nKBXDNk9JjhpDsAkxi4VWEJUykmUYwwXgFOdh91npDjk+HFdG
6r3doitJPMHPuifmq77Cy19iBmUnr6MvRc8UM3XY2nhPXHgW/aUQiLZLDIY7FCms
WpJ/k3d8kmER2SFqlQ8yq5naYtAltQ==
=36DF
-----END PGP SIGNATURE-----

--cL9hAooNExvMNH/8--

