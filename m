Return-Path: <stable+bounces-72824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB50969C62
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 13:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85B1BB22F57
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEDD1B9832;
	Tue,  3 Sep 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2tkk/iW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E001AD252;
	Tue,  3 Sep 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364118; cv=none; b=OvJb0mwHwehXRXEkA/0RhodMsJZcXVzBA+zvIXxICDHCM/Dk7RBiLexf2jet+OjTqzxCg4z3dqXtEfeMzoqZLdx2aIKZI7mXfgT6BB1+jwj+3ZafHZB4VadGa8Y5uVkEbAiIvtrqbZtqMpUbQ8jesr6ZnlKjL3s5HigrZ1nLdIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364118; c=relaxed/simple;
	bh=ITbecf1TeZ5MstWgr9uNGbB/k+1b8pt1ZcT2MT+fbFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFjdrWixdQyo0Dwh0fXn34lw4hX30JQc2MItSg1dgLU7xjHQnLaFkw6QBCU3pn08sOdcJ9nTF8dwx3rxzPwNI4gnRMvVoapuHJPQSkPemTWCHw3dZ/Uv1DM3RHyTRF0mqRx2Dzcclp8x4L/AfnollgbswNnhr9Zvzpr1WNjdd5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2tkk/iW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A853CC4CEC4;
	Tue,  3 Sep 2024 11:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725364118;
	bh=ITbecf1TeZ5MstWgr9uNGbB/k+1b8pt1ZcT2MT+fbFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2tkk/iWBh+GQS/rOO80Ox5p3KECZOam9KzjLOYFKkA6yK9ZlBZP7iP8ru9+NmBXR
	 WHZvrKHlDlb3AxJov3g9EEJeB+CC58slaNJWoCgcr7OylCQkOtuJMmfFhLpiE5smZo
	 uv4q8wUmzwpVpIDSUQ6EuPJCRfEWMhY85+ipGi52i6kznNRv+XaGnfEwkdCeFKH/5p
	 5rSBp5vRPN+1xaZa3W+Ay/Fzku46HpBH3c3GwyThpORDhSbSBHAW2S4/TjSdBW7J4E
	 ANlwQzcIaTj4eP1mhZ7mQB1mXkWYI2RayXWNRnZvzxXVfJAp4s6UroyCGdiSKFL4+n
	 WPIZTIWd/QW8A==
Date: Tue, 3 Sep 2024 12:48:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 00/71] 6.1.108-rc1 review
Message-ID: <bf2a4535-454c-44fd-b551-1e4b9625ce32@sirena.org.uk>
References: <20240901160801.879647959@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L9b7IWw/ZoJYKAe9"
Content-Disposition: inline
In-Reply-To: <20240901160801.879647959@linuxfoundation.org>
X-Cookie: Words must be weighed, not counted.


--L9b7IWw/ZoJYKAe9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 01, 2024 at 06:17:05PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.108 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--L9b7IWw/ZoJYKAe9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbW948ACgkQJNaLcl1U
h9CBUgf/cYT07ziDih8w4H56o2zJDCdsws/U1fMhbGSttP7ChBo7sSVwX/Do5Bd0
4PpEFW/eZ/ew5NzDH1BXlAK48MRSEHaKm91oSFNdBUNIBB/6l+bONhUhcBj9O46I
SL6e5eqWD/1Ir3wbeUior4NI8xv8zCDxpTeUKugL1vynnpo/5XdQhywQe5gsle3R
8o3E2cpJ4P7yF2R4aPRHWNOUkR2pBFDksfbYtqdR65XT2zkoRrSFamv5ItdX6AUt
sQ/m/+0aFjO/qz4dJpV8yOb/GvuLpVJ81mIfOlG047/NYKdK7nS5QK0cLb0Ff6it
npEfPl0wpEY5Pbzhg5MyUlpFdPwLVg==
=pU0Z
-----END PGP SIGNATURE-----

--L9b7IWw/ZoJYKAe9--

