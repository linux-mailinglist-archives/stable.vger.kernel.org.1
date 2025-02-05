Return-Path: <stable+bounces-113999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F3A29C67
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 23:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD41B1885A19
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4EC21505F;
	Wed,  5 Feb 2025 22:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcuWW+32"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB971FECB9;
	Wed,  5 Feb 2025 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738793570; cv=none; b=dYxs12xKZU06MELixnwuYoUkjWZ4MUufNLZalfDbwzYx/86SMQc01p8M9rXfzERmtsHACFBg6qGujy37MZIDQMtqgl1BfCuCyx5emE6x1UfLlRYjxm/aAtzBv9UelR6yMmV3l1Og4wbxCzzBp6sy4aTAVDMFIjtYPwmIEBoT4gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738793570; c=relaxed/simple;
	bh=1WkefC2yv85jVisk5RIWmSwYE3LbXg153chgdvSouHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoYh5FEhbcSec3+Kpj8mg5hJotp7NGOdGHNnaVBQBg1Fkxi4nmgzWbiR0U9lmYKU6RRIdtGspqtb+Ea+KYQZvUiuPr5Jjmi/QtJsTpm/XMY4ZlvjEuKhg6tiG/pKt1Xm8JSRvQuF/1ZqVgIX0V58Ewq0raF593zpF+zUKqMHBd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcuWW+32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8CBC4CED1;
	Wed,  5 Feb 2025 22:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738793569;
	bh=1WkefC2yv85jVisk5RIWmSwYE3LbXg153chgdvSouHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcuWW+32dmR5xIxrcMjDMgergx/wzjb/IQ0zR1e3EFfLxAxCQfO9QvEliY7hK7Lgm
	 NCx8DNw66fQveKgW3XOF7kt6r1MU2YYWXHHOSGweim9kKb7TvWG0JxBiitDb4hyouF
	 DtkvAXXCiF17wqrRFtKlKENRaYoXMRDDbftA3nnz2um/J3I08zP6n0NhaU01IJNfJO
	 K+zxNxgUbjeVks9DoO88U7PPKFinb6G7oNxHQQ0kzVtL96HK/HM5VQ47F0p2od46o1
	 MZWgkBxzv03u+3KD7u7s4b8Y2kDfiu8XUY/Qwl1VkzUfq7Marcrgp/y7TGQp38XN1g
	 3H8xI44RVbxnQ==
Date: Wed, 5 Feb 2025 22:12:43 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com
Subject: Re: [PATCH 6.12 000/590] 6.12.13-rc1 review
Message-ID: <3fc823f4-212e-49b0-85b0-0ec7c80dce43@sirena.org.uk>
References: <20250205134455.220373560@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OC7QCB1qtBh4BTE3"
Content-Disposition: inline
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
X-Cookie: Earth is a beta site.


--OC7QCB1qtBh4BTE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2025 at 02:35:55PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.13 release.
> There are 590 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--OC7QCB1qtBh4BTE3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmej4loACgkQJNaLcl1U
h9BtaAf+NtR7n/T8jLej0kr7UiK3Gt2jdfUHYqR6XW6+S5V65olZC6yb+rvr2wiD
NFUvEu1COAr4NFgIz+/Pi7DbV7a8bIGXVhjrvG2SHniimLe8tPvfj/2kCZ1TwuzD
JsZlnBVv2u1AgpHzocq59zvTUgah1EvBePKmyTqfonSJFFIJuVFx8Gs7WpLom/NK
i25oGxH/CUTc1EBCZsBQgTn/PqUE/72W8HGL5caqY5fSiSC+kswUl3VH3WOY/MQd
QMVZdPJQvH9rKpuYai57aUkxyRZLSbU91jvEUYQzY/94mk3fZxwCk6cOV1JzE/uX
HlprOrnw61sXiAqiX7RRP7q5ReVvWg==
=S5YC
-----END PGP SIGNATURE-----

--OC7QCB1qtBh4BTE3--

