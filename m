Return-Path: <stable+bounces-164838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB16B12BC2
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 20:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4941C23D30
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 18:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2761DE2D8;
	Sat, 26 Jul 2025 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WBEZXfIX"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AF780B;
	Sat, 26 Jul 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753552888; cv=none; b=VySS6TDbHXrasCjxHili+sqg+y3f9u9BymX2xEsF+rqAkOCWuXN6zoD378bcGJuCpQYTHGc/NjW1ajhdyAbDs6pP9Jol/HLlTrOSe3ajcRZih+R7XDpkk7XjGKCvmhf4TeSWdNW0aOD3HqYt5WLbZHVsqN1b5/FhW6NAaBDCBHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753552888; c=relaxed/simple;
	bh=bK/4+BOUfjSaUzNPQthKGhmlAPejq9cArTmLa5EK/Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esVZMqXixi+WBljL+p5G2rpVGBTSA/wQId3+VrKJV1sz3Q+jQSx/jVjf+x/L7AId6s8tOggo/RFRscQ3w5qWEUQwFFcxeTmw0r3ygb76ZbbOhZCn5S1J43g75/oOaIv93gAPE5OfFOHavJtawul3LGLGkOJSKUFJVwTNcO+70Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WBEZXfIX; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AD1510391E80;
	Sat, 26 Jul 2025 20:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753552876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=GbCS+qKmwWsRrYueHQaiMXEPEM4YXRW6RvE3W1Utmlg=;
	b=WBEZXfIXQGjkm3TK6x5/aG8/BRSIJ8tYyrLs9gYeBetm3hpsiwKw8wShbaUFFTNAmaXbj6
	5fuUmbm7SF47lKKBYq5er6ZuOGxLE4qr5ECneClh56oPUYmaAfcBS3xE/yjQpsI0M1ogeO
	TwZqzCjo0WuT9S6jyeWXvIAXobE0NHasDh+2qKNEhOTXbr1Z0/bYmlKxhUPpQF2+c/L1NA
	NE2YuHBkVGNoc0uDuvAH6yYt39hZQI1FXk0J36UkLS3cctsyNfCn+4wLcD8kuUJlI7H502
	0K7y7wy7GwAnXoKT+HlYIKcy9Cufn54hZuy9rwM/A20OYs9HtD37O4RTQJb2cA==
Date: Sat, 26 Jul 2025 20:01:08 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
Message-ID: <aIUX5LUpBks6LuST@duo.ucw.cz>
References: <20250722134328.384139905@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PPVOXvBudexj/D5i"
Content-Disposition: inline
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--PPVOXvBudexj/D5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PPVOXvBudexj/D5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIUX5AAKCRAw5/Bqldv6
8tynAJ9HQpYl5Ej6u0LYhplDm9cIqgPwMQCePlL9buIOX2UzTbcycgecvKLUOIE=
=6yRt
-----END PGP SIGNATURE-----

--PPVOXvBudexj/D5i--

