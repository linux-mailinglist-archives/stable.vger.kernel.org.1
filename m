Return-Path: <stable+bounces-105157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF39F661D
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620217A00F4
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584BC1A7249;
	Wed, 18 Dec 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBZnrts4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D96199FC5;
	Wed, 18 Dec 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525621; cv=none; b=WOTxmRN6MMt9xRApEa15Qm1ANY/basqSx76eWnOEWOTT5DvKBpTw0GtWLpBKe7Bmm44UvFuZ5xCFPCx/9uaku4YPXMIR9ZXdJ5WJrEDn9c/ywG4TVfiWkE+XKhuuwqnclenqQD0Mk74ATud6mlZfYhYpLFMzGVr3h5UwOnZGZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525621; c=relaxed/simple;
	bh=lavz5sj7dPlT+rL1UYuBE5n6QYIXbK854mvciX66vks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DasUaO9iQvGqQezUlXAA9/P6dlAsFOhx7E2lQNykXpEnHxigEk0qDgBeLgt/ZBZzW1cAkkN2ckvguP4qW2LD2Smzcc8Pr4kvgO4wNemfrn9eJXonUfazowmkdqsI0uUjWE9jI6KtlgNPMuNkrOf7FQLiVx01v392N8IkSIW5SxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBZnrts4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027D8C4CECE;
	Wed, 18 Dec 2024 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734525620;
	bh=lavz5sj7dPlT+rL1UYuBE5n6QYIXbK854mvciX66vks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBZnrts4amw21O9EI04Bz/bORYJH32jQ9UxoDJaWgRrGhXdzhqqUgtc5XFYbDJuI+
	 f+xw1FXPnsJOYm1e9CXjbDwX47GgROZ69ftg4xLYwbF2lzkw8HjQBXJO3GjIeesji9
	 v50HuzD8L7aaucRaTos/ax6CcNTWzibp7mSt8lFyRUHBV6Gsj845WoWptzqq2lLOH4
	 0izPfMLbLTuKS4ippkjT4RUb4GwJCHQWTVFlNRm9abwpGxaU8d4TylkovJfnxPmv2W
	 ElqGb8uAXWG+61UnKaGBDwomCsBrJN5hbSvJG2xG+CaTP3/K1JysjiWcx3+LEDwvtW
	 3EW79JPHL6KAQ==
Date: Wed, 18 Dec 2024 12:40:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 5.4 00/24] 5.4.288-rc1 review
Message-ID: <c72aa17d-7724-4bd1-bc0e-897910b83632@sirena.org.uk>
References: <20241217170519.006786596@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r3/ErDchEyYbB+MM"
Content-Disposition: inline
In-Reply-To: <20241217170519.006786596@linuxfoundation.org>
X-Cookie: The heart is wiser than the intellect.


--r3/ErDchEyYbB+MM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2024 at 06:06:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.288 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I'm still seeing the arm64 build breakages with this one.  Otherwise

Tested-by: Mark Brown <broonie@kernel.org>

--r3/ErDchEyYbB+MM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdiwq0ACgkQJNaLcl1U
h9D82Af/ZYW/X4hhMZ58HLM6igXh0+qEJ/hekv+aJyJe8CzofTdQnTzn5BIHh68/
iNMFdOW7qsLZn4x0Udd5DLLiwF2GN1SagcEM8w3jgOXaPr0rs7Si0keOnPnK/sx0
XVTTjaqEuhw+/7cfSXVAI5ZR9Z62wZzQ8XtYQ6WUwgCapDoLEwdMGD/6QjdElY2+
VXKn3nlmuvVkIxw7fZIQtqH4ZD4Vppt1q32Hs/BKq2MkPpvF4ZIxOC0j8Q4BpSd+
aUuNsKkwxfM1Mg8oGXHNAlJTARBAVDBfQLhuQ0LQuasz4LxhRWvRDt5hkSOUzvI6
xF5Rbm7WdAMZHXu7yjC3iisM7thjWQ==
=/a2A
-----END PGP SIGNATURE-----

--r3/ErDchEyYbB+MM--

