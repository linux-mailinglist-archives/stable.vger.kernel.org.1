Return-Path: <stable+bounces-121285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B129A552B6
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A09162A6C
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F9B211476;
	Thu,  6 Mar 2025 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="eEP4cWko"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54002144BF;
	Thu,  6 Mar 2025 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281418; cv=none; b=RVaa/ywrnog5iZ1sxKd5ljinOJgp57nBm9Q2m0nlbVis1yn94PKuhy1zKa9OrNvZV/ZDcPABSv0awSnN5vX5a1zsWY5aiTq3gSVy5BnvTYStFC5lAupCzNzC/4StReEm5oDGaTKEINt7qVbcp7kmq03gj3PdtWsmUX7pLld/FwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281418; c=relaxed/simple;
	bh=T3CeNpmxeBukp3RAzBVcpHTzWqORc+ZZgVzatEtPYYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG+7hWW7j5KlygtUOvlrHyaRop4yUgXUw5LbKhC7tPCF/zwyaAAEkZRppmY4XeS7BYP3G7T3tCi0n2+E0uf283EHPcscal0TwDIP0p93NU8bSI+akKT5uPSih/RjOGA9DDTujJXTgdMLqvyI+tBVqI/pljEjMnhwTDNDEOSAgbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=eEP4cWko; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15A6B10381917;
	Thu,  6 Mar 2025 18:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741281413; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=N3OHVsB0U8K5tQARNAc05MOkxZPI6Uii1+T1VS7QOHc=;
	b=eEP4cWko9X8oHU7rJ1tNEk8jnb1LbO5iGl7Iq/gRUaiVNtC5qo7vzCCtFF1mqMFbib9g9h
	TEdxA4vC3vNSdfbh/TTFRUIROFcQUmwx0CdAGfXgAfliolS04Y2Yct8hQNLGifIFPbUlxY
	7kdn+HKM5xE04diRh90at/iGRTRTy/7/Euuao9IFQC8mlSA5MwrgrPGvPM3A+oaOc/xLah
	/IQ6o9qEbpCHJ9Gwk3i7LbP0hZ1+jjd4iR7lr/8ChPrsvSmstPGFPgsTGUmHilns6Vu34c
	9BSt/HGhtoV/ufpWQY4XRyoI+F8I1YxxMEtZIvqh2wzD2ifCKwyvGpq6TiihKA==
Date: Thu, 6 Mar 2025 18:16:46 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.6 000/147] 6.6.81-rc2 review
Message-ID: <Z8nYfp7VmFOg6J0Z@duo.ucw.cz>
References: <20250306151412.957725234@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+is5TnlxGyAtvNhy"
Content-Disposition: inline
In-Reply-To: <20250306151412.957725234@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--+is5TnlxGyAtvNhy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.6.81 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here, or on 6.12 and 6.13.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.13.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+is5TnlxGyAtvNhy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ8nYfgAKCRAw5/Bqldv6
8k8qAJ4p5qebsVHoFLPzf1RtQBYgKdEHngCggChioFvqAyM+5a+xse1pbnFwFuc=
=Cpra
-----END PGP SIGNATURE-----

--+is5TnlxGyAtvNhy--

