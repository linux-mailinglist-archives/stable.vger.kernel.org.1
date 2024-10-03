Return-Path: <stable+bounces-80639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CAC98ED95
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 13:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEEBB22161
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 11:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136B1527B1;
	Thu,  3 Oct 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4NV7n4s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5714431B;
	Thu,  3 Oct 2024 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953621; cv=none; b=A7A/ZhLmyVV362DTCj/N8dXeIBenCGalfb3gziB1spFOjnvrW299GAZe/awYugVY1aPTriVXKKNCwYPcyek+esEtrZ1mY72ChjCE2PxcsZeTARatVgwHrOCLfpYnqm2b2kJYxGsP4e5qdO/OTh3c4k835K4vQbkqy5T4C1ARBRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953621; c=relaxed/simple;
	bh=hsuJOygwmFnFLxjXjU4VieEWta61yNgdjjZVOc4zkRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEkotT//D1Xul0cAYYvb/bUe6KDMJb/NRnhjqRFoCr08pKq7/f+gqWtAG4FXfJTABKSgMmOrPIjhMJVwV+txVWrDBvg3abn/gszcTkvpzRsqt+nwKgnRF2RFhxW78dz4a3NFHykKIG5cV8yeQ8/A5VW0xMQVGzurXUiHVCnpA9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4NV7n4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C11C4CEC5;
	Thu,  3 Oct 2024 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727953621;
	bh=hsuJOygwmFnFLxjXjU4VieEWta61yNgdjjZVOc4zkRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O4NV7n4sWc8Lz+cY9cyQbyS4Yy/nKSCtQaceqNvozqBZJYl7eM51WDKEwdjkCK4Gp
	 VNXy22xy7Swui79PunDRCb02JkT26xxgeDOQr/2HHft+MlqA0oM/iTjouxv1ZMPgFn
	 I7mhIdpCTx0y6iS9Md1pERBtwF/FA98NDrL68ztrVneCkXVuv2+sBXkm/alzlzS0NJ
	 HFPveX9pfYclF/CjU4AK9sD0YPgcbCl8FgDZLso/HqosuqwcUr7mNxP58agoDXEQGL
	 J0Rr0ZX2MP3pWfvkl2+Xaxn2yTRd8nyqs15avGhW0eY/+0RMxJVbS+1VjQK8ik0s9m
	 opTnGKeJV6YVA==
Date: Thu, 3 Oct 2024 12:06:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.10 000/634] 6.10.13-rc1 review
Message-ID: <45bb5fbc-4229-4698-9e2f-c8feb5e558ec@sirena.org.uk>
References: <20241002125811.070689334@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EHqIjz82IOmUFxCZ"
Content-Disposition: inline
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
X-Cookie: I'm into SOFTWARE!


--EHqIjz82IOmUFxCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2024 at 02:51:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.13 release.
> There are 634 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--EHqIjz82IOmUFxCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb+es4ACgkQJNaLcl1U
h9DKTwf/TCxupuP0TUseaO0gIOShvbsqRYF5KEEtPU5mYOixhK9wIcdIROldKR2v
tY5vvhUYkKcxBJn2zBaULfDIwHqPoj2CuLL653vcxwmHIZrGB3Udi18fV/b4b3wL
mrEt55kiQgw8DVETWQP/KuaiQ6CG/SGCCEqpzZ+LxIhA7BOZEW+cMF/7j5RtR8xM
r+vUWU1hXNrmVJfdFhr+p9YGy1hQ4VsrX1J1A0ROnoHjlWrJ2DhNLNvbyzv9ZpY5
JudiOOQ910qbpeQzUeEwY6+E4o9cG6zbnphq/z2Fl6vCItnubhgWNYXYkbD8lgvX
fQtVmcF6RhA0MfVTtBtUso6ooCFPUw==
=4Nx3
-----END PGP SIGNATURE-----

--EHqIjz82IOmUFxCZ--

