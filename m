Return-Path: <stable+bounces-61271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BAC93B03A
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 13:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0046028226B
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ADD156F41;
	Wed, 24 Jul 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wsvdh1pq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54A156F40;
	Wed, 24 Jul 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819779; cv=none; b=bZYzXmCmPod9yekpttRfvnspzwM9vHbugAeIC8w/Z577e9/ULcRdjvu8pLZntOZpLg2gDwS5GMnGrR/dDtxWBgJjwTUMWRSy5LOWL3rdPTA/Bk9QNM6ZNshK3G/TEy8UhOE8LnD/PeKJ6vwPp15uiuxfSK3H5ZOXUM80Cs408iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819779; c=relaxed/simple;
	bh=F5UYTMmpoWi1BePqtvKA1Oqx2ozV1pAFWk0k0oEBzkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRoZCxxeQVO0qMCd5dtJ/LbutzXWAWC+kRxvdTlSxup7NfJAQiCua/qxoYD9QKGtKbGAwUCbMCAukO0Tm62W1xmU38LzB5ZdHep57KtgwE/RLkkr/2EONL2fuFeAHvbtZf7hhsKRWEM+LL79dDaZv212HB7bJWnN5V1LPESrBvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wsvdh1pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E41C32782;
	Wed, 24 Jul 2024 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721819778;
	bh=F5UYTMmpoWi1BePqtvKA1Oqx2ozV1pAFWk0k0oEBzkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wsvdh1pqFKCFKm86L3ZzTCny9JnbCZr0eCkLhudxHj3+eWp+gkXksuPTJoZhqJ5KM
	 VwIfkIHamVBjbuXGiUkYuieXR8+lqgWfzWNSCexuCYLQetC/GJwEzfa/gQtWwDerCn
	 aUmEwGZeWCPvcxC2BblQJK4xxkfI6wv3hSkBPkptTfJ5yjkadbsAVUJqgK3w8Qmr85
	 Jyvkh2x5Zv9HmvUz3o2EcmKK2JA9wnvU4G5TU/R6rYyI+aBNkqtLIT1f1xRG9WAYnU
	 5RC0oEA5i2DHrHoyHju7hVpKFdwUVZ/CBTI9rrMyc7ITwZb9aLoYl+rZhrpLpEpU1C
	 /KETuE+64QFQg==
Date: Wed, 24 Jul 2024 12:16:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/129] 6.6.42-rc1 review
Message-ID: <8f1bda43-0710-4319-bedd-86d80bde7ae4@sirena.org.uk>
References: <20240723180404.759900207@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4p9Pb12RmPh8pfV/"
Content-Disposition: inline
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
X-Cookie: Editing is a rewording activity.


--4p9Pb12RmPh8pfV/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2024 at 08:22:28PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.42 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Tested-by: Mark Brown <broonie@kernel.org>

--4p9Pb12RmPh8pfV/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmag4nsACgkQJNaLcl1U
h9BxVQf/dNXkyId0n9J0YZUfWvq8l22omq5z0g3Bm+Xf1dVW+QroE8AUl86oSNgb
1GFp1WZ0xRSNsPFBz95lLfTNc6DghEFF7WU4VrR5ULKB3awC7Fvfb8BwK8PWhmPV
ifk5Vuq6r+jlSgfmLJr39VYclqQiqiaUvKdRl6hIw0deQ6o7fUH+AYyj6nbhZQzu
XSSROJpHZkw4bov5kFuWLVGtYiQvKg46yIs6ox6ifk1yFFxVexAWnwYMFd/Rk03y
2Pa+CHScicFhzld9R9Uk9ILzJxs2jU/WYxtFRH3zQ14u5vIcK/tqDKtv+nrJZPfi
oBj+VqPZGEWSSwgnwqMbmChzQKr30Q==
=Pb8x
-----END PGP SIGNATURE-----

--4p9Pb12RmPh8pfV/--

