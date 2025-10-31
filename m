Return-Path: <stable+bounces-191962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B834BC26EB1
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 21:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8EC407C28
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533B328B44;
	Fri, 31 Oct 2025 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VI6ofPWt"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CA22173D;
	Fri, 31 Oct 2025 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761943158; cv=none; b=urI0Iop2vHaYVfoHm7FtXka0f21dblYvj/Sd4YjF+5VMUhb33v3p/dILz0l5z5UaVvPU4lYen/IpWSiJg7nC0SrWSRiKz3Nb82HHjHAUQ3Q97gl3ucI6HAjG8AfrkGlDiOeNDVAOGq5iJ+tbSNqYD441VZdxa8Cf8AoZZkU2VQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761943158; c=relaxed/simple;
	bh=ptmIrf/ickaTEt8Cr1Wp6wOrWD+FMuputVpxh1GuSbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYCTIpnlva+6nHrFBYLN8yMCqbyj1b2AQRxHhSPBsGHzU5ObwQPcC/7uTvD1o1vS4YlAGmndtVjCm9m8QN70zmbskhSwKXKoEAz48cauGYuNrk9tqaA+Gdr0UDRQFKMQd460cuGWJMnCJ119Ar1A7AMMGk45guDNpl6Wixcs74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VI6ofPWt; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8840411866451;
	Fri, 31 Oct 2025 21:39:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1761943152; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vJsyv3wyvly78tOTDhC16Mgw0yq4JcHggWTNoDEklkU=;
	b=VI6ofPWtmdOQADWGBEzv3XUrlWOZGf21uOW/eAU+6ev7jS2nNA5xgo8eRd9tqB1Zk3liub
	IGvDDs051S8J9AYEpkL3pcvAv28+N3NO47+/8y8CrDMocRtHlN9Api6B7ROe847aY4tzlw
	3XCFT0H0nzA34dBOgo1OhUq3GYz7CQpcMwx1EAYUP5mcByDAThGjyhSlRQZqMjIAzW12ct
	V179AO65Yt+66pwxnnBn0LhVmJlELJ5EY7XZidCCc3mbSNnmElGG5s92HM2X/G6C8OvF//
	I5dmVAMsxdZazgz+uJEaZE/tilcFya0rps3tWyNv0cwmtYrx0xS9Ciscy7zq3g==
Date: Fri, 31 Oct 2025 21:39:06 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
Message-ID: <aQUeankW3WBvgDdb@duo.ucw.cz>
References: <20251031140043.939381518@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FA1OVxOVPb6/wLyz"
Content-Disposition: inline
In-Reply-To: <20251031140043.939381518@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--FA1OVxOVPb6/wLyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
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

--FA1OVxOVPb6/wLyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQUeagAKCRAw5/Bqldv6
8vbaAKCQixX4xRCKBar8YxOtOdKtghdTnwCfUCfJnOHfr865nWhwVniLv/u8Ums=
=Kk8q
-----END PGP SIGNATURE-----

--FA1OVxOVPb6/wLyz--

