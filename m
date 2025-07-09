Return-Path: <stable+bounces-161390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D97AFE061
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 08:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65BBD17D4AA
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 06:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40826E71D;
	Wed,  9 Jul 2025 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="N8vGv8Dj"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC10D26E6F2;
	Wed,  9 Jul 2025 06:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043395; cv=none; b=JfE+bXBq82f/l6utq4CCWTfh031s6LGHxX9Y48zTyy/VGCcYz/KPEjyWWYC7uVk5y8F+ftl/upumlMZR1dMOISl8shovjuiELoZxpZuOTnh0KuNHByA0ypMsKFs55H6ycM4RJhKad92LbEW34sx9ap7rBEfx2P27FT1GJEEm+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043395; c=relaxed/simple;
	bh=D7VG++vovk29PlpoA6OSmW3juo/M5EYc5dzmKntEyc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0buo/aUVjzuC7sJt3FMfbmPQLkf6Zwtc7AschL93ErlnyGNT/ekWh78hExfBHxTili3g1CPJVEkLw/ES1k8D4n1wr3ug/KcA32bni+66muFUL0JOOI9Sa7/KQ247FTIiWKxArrhDYyz72K2bUr36voY/e2DfpxtkljtZL5EZx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=N8vGv8Dj; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1795103972A7;
	Wed,  9 Jul 2025 08:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752043384; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=xnldeWqn7FzNlYh7iLVO/hTQdF/UNNNUGLJs17uT81o=;
	b=N8vGv8Dj/vOqIYbL4PdFelEdLuWclESlKMu8xCVw9uyBz41QgSwU4LDvcW3HiwYT+aEkS5
	iN7DkUBV8jRL/kFrmHwM45EF27D0cWbOYhzV2XN6V1z5uSZE2DC8gyr+pYETJdJwS2aJ4V
	90r7+4O8FlSki+Lb/tOrEsltr9udC45WRy732AcGDNJKz6xy8YxI0/bKFegFCLv00Q6iPM
	eAg3XI3fGuPpkK1OJNL+Z4HzZIq4jgy8LDsN1nGxiqhLBmeXdnL3x4ll60QPrcI8wvEBaZ
	qRCb0iIdXQn/qJ2PI7RMFTWNfhW6ga0+PYETBxvszL+JJpP4HXjNKXliDn9KQA==
Date: Wed, 9 Jul 2025 08:42:55 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/232] 6.12.37-rc1 review
Message-ID: <aG4PbyBBGUFScDhu@duo.ucw.cz>
References: <20250708162241.426806072@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W5W5MkIesOglyqKt"
Content-Disposition: inline
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--W5W5MkIesOglyqKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.37 release.
> There are 232 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--W5W5MkIesOglyqKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaG4PbwAKCRAw5/Bqldv6
8vgPAJ0ZVFKQD+amVBCdZQn3A0Z2pYHT5QCguhSWtEugmgVBaZ+dJxru3HbR0DY=
=g0Wm
-----END PGP SIGNATURE-----

--W5W5MkIesOglyqKt--

