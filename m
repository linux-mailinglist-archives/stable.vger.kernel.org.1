Return-Path: <stable+bounces-177574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD3EB4171B
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 09:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082C518885F3
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 07:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371CE2D8387;
	Wed,  3 Sep 2025 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="PCVtINom"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB522D4818;
	Wed,  3 Sep 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885646; cv=none; b=QTCfK9w+jUdH4WGniJK2HnUkZonPBhG6bjnbcAMvbHDt+bo/nOdoEqXf9WElHqhk5oaLQXAAEkjQKBkwEOHY60NjtYWWCrXyoRuyarzd50tACMNO7moZmx2KBDiVgjMhmC9NhY5yAELyJMJhUwYJWRUpGMl/HmxbEqfn4r/XALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885646; c=relaxed/simple;
	bh=WB5oFhV6TPfVy/dZQzGsAR9s2F36ZuHdy490NdByYFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBcjYwzO5XeU4wB5fJtDvUikA0Mtlxn+IIrhNOM24A0lI3/Naj7YtPPTgePF0v2q+CAYzkNRRc8L2voqad6vruGUL1KXJrBU/VU8oCYTsYlF2DS4VrlsS0BppKZSz8dVeLnz6jZtzhMsyS1a9vIPGsUuxR0OGHYUAY873c+4r8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=PCVtINom; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 442191038C103;
	Wed,  3 Sep 2025 09:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1756885641; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ZH2CuePyC+wEVG/F7e4kduUNkZgVizA9FIDuQHsGJ38=;
	b=PCVtINomO9jg+j/dhNL7C5piN4tkqzSl2kEbyosQinSCCw7WsaomDX7MhzD1LT9LE658FU
	iWt8T3DKxU9Mic68D7ZJvTbCKVGscQjks2gYYErtZY0bA1MWoNnIsAqympSgw8lBw/EsQO
	by5/K5X80XLqCz6uvekwbdmOIBawrPlglJkBn+Buo/DdTfxaR11m3HzXc1iO6PPh+SiR+L
	udFnO82ZrnUqTT9L2CMXZ9QmjApaL1+G35MubV+cZI+JUj0JeO70TUWGiMOldYTZHoZTMp
	1kQNU7y4g9ITJXQy83zYfgyNTQZyrb5g8ZzMy175TX1fhFAhib2zYotYTTmELg==
Date: Wed, 3 Sep 2025 09:47:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/142] 6.16.5-rc1 review
Message-ID: <aLfygzKOMI2ALBJG@duo.ucw.cz>
References: <20250902131948.154194162@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1KYsNb01aP8n7w8a"
Content-Disposition: inline
In-Reply-To: <20250902131948.154194162@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--1KYsNb01aP8n7w8a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.16.5 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.16.y

5.15, 5.4, 6.6, 6.15, pass our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.15.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.15.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.4.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--1KYsNb01aP8n7w8a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaLfygwAKCRAw5/Bqldv6
8hG+AKCxCOjSsbF6RvvJ3x5L1/fLwPYPMwCdGDjpcPHhkaZbJbh46DaJZHvagsI=
=wzb5
-----END PGP SIGNATURE-----

--1KYsNb01aP8n7w8a--

