Return-Path: <stable+bounces-177603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E11B41C41
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 12:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE684483845
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 10:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A22F3C1C;
	Wed,  3 Sep 2025 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0Gv17oD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C712F2906;
	Wed,  3 Sep 2025 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896719; cv=none; b=eaU0DPQl8tKzsj9WHxdUepvOr0cYlxcAtvjn3YyZ6JIcBl6BxOCraiX0bkaWkX9N0guc4jyqrU6z8wg23jgcvBPG9uPxGdgAaLaXf5NjvnVs8hOB9SBEHoWNmhpO/fCxxarkIhOhR50/ANyFfN3HdVImT8W9rWi65eOrg4zqkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896719; c=relaxed/simple;
	bh=AyEB0fnmECu9ROQmq/bjt8/vCyxaGfFoTTzNP2vVnFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fej17VK2nMH1c+xzLgiUN7Je63vhOvliEusxmA0HxNVESFkaSw9l0JISWjyUSO9ujHOyJRhG1ZnMy2+FL/sgrcrTdLIPoilBje6DtohPpy6SHn+Kx/mXYTXirdH8A+jL5GbDaVsOEExM7Rr3xfOw8abvg0/VNGGGRNDbYu18vC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0Gv17oD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4938DC4CEF5;
	Wed,  3 Sep 2025 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756896718;
	bh=AyEB0fnmECu9ROQmq/bjt8/vCyxaGfFoTTzNP2vVnFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0Gv17oDNB4jkyBnxfZRqjU5xQk/BXo4JLTTSk1MNzZ0VnmuXslbq8ENlR3rD6b5j
	 HQYIwPJEQhpgejX3dvnHrtmaJ+UBjf/FkJ9mfxtYdfm0KWw0JObQ2GMQ4cQMmZN5us
	 NO9Jpi132+M7uQnJ93UZb2xmi2rZ2HYPwsWM7QGMBC/3H6oqX2MMpBMPw/UYo0noDf
	 BBGgG8TIS2GxR/B2dM2jyY7hsLM8n0r6LB6H/tiSiBNXrJyoxNxXN3TPIAqFi+nUtm
	 WREYBojX9cD/xpnassGXEU3mN1TP47NP0Uj3WScmT6qNbgF6Pw2G+yHYOZKj5sgFu7
	 Wsmka+O7Wo7BQ==
Date: Wed, 3 Sep 2025 11:51:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, achill@achill.org
Subject: Re: [PATCH 5.15 00/33] 5.15.191-rc1 review
Message-ID: <c032e0ca-221c-4adb-8875-b04c60e11e39@sirena.org.uk>
References: <20250902131927.045875971@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NTjdQTcjf7neRqT/"
Content-Disposition: inline
In-Reply-To: <20250902131927.045875971@linuxfoundation.org>
X-Cookie: You were s'posed to laugh!


--NTjdQTcjf7neRqT/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 03:21:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.191 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--NTjdQTcjf7neRqT/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi4HccACgkQJNaLcl1U
h9CE/Af8DLzjOO7Rr6nBmn+v9s9p6cggWs7Vy5fGDG40lCZ+G4ctBJuhg6GBtkFr
D8mJ2ddoDFmSF8xmYiPuf8t/rsFTJpZgFlLg3CfJ9ymn533yqjTRPZUfvTUAEScG
3sWjsYffPUN8ctQtBcrAy4CEI+WkZueIkC+vmS5uOQATEPzNH5gALeDXNMOMV9pk
lzGZgsvXrjMv/ghpa1C3hVtjpxRXtNaDG9KPH0DWZ9Fqnsp6+/FY6028ejIUzjQ3
TR9zUOHFTxr5LP5Q68m6UBLOnMb5S1lGqgbTdwwauiqq4F8oq8mmVLg3DdeGven9
ZW6qHQof7FB+JlZYMppInEGHf9xI2g==
=OULG
-----END PGP SIGNATURE-----

--NTjdQTcjf7neRqT/--

