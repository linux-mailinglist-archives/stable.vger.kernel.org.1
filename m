Return-Path: <stable+bounces-145906-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C0ABF9EB
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9850917BFEC
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9B1220F5C;
	Wed, 21 May 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GRMrsJRa"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830B2185B8;
	Wed, 21 May 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841925; cv=none; b=Jp5IWXt90OAwok41eB8YuIeQ0Pryo77eavbL1vltqh8DcrjEy3MiUYSZPDu/yxxrS6sI/vAdAT2nLePc9/RgDVWuQcd3HE7onbOer6tG9kIChbi2A8m+vMCFQ35yy2n02HXfVx0f46cPmvuc9HBBXcpwnSkYmzHN6UvF3rwoYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841925; c=relaxed/simple;
	bh=PTX025higgfiVJV/H2ZoQOmewRxlFy3bJrnMoGbZ6OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqktZgGAL4RoXF71bDu2yhdG6A/x6tOfaVPmmEa9HndNkl2xKCguzp+qBcRqBy6iBBs1P+gtMQk+lpao5crJw0d/HO4oDdrITngUtYM/YT1YmM9W/GCbtvUio6HhY5sRo9R/yiZ0jLfgl7yuMevebhbolrxWK8gc4pQpxevg6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GRMrsJRa; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A2941039728C;
	Wed, 21 May 2025 17:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747841922; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7rLP30jivhSXxGxmK0/4iDagKg0IOY91vTVP7E2pscU=;
	b=GRMrsJRaALKKXzx9osgt9vXWhW6cIl7qLkqvlq0idkwi8lLTEtycP6niRktt3MzEnzAaGH
	/f7JJdnwwzglAo8ANrA6dqWh2+mazICODBmG42udjCguTXjrikD0beLlAQ6MKLx0JMjmOd
	4gJUSfSNsNnBkaXustEa1cfNRYPD0yBoYNzwhpXd1tuv/FiNK99uMh6PcptFC0dmg4iQQW
	BRDgHl+mx94vVSuz8DMpSYyKpkKgkvKFqoMOuqy7N6JOD9bjPCTVaIA/cd0DbafhM308e4
	sGrvPXXBgfzQHTcUaciurWV8hm2VZrHg9D/7Y0nXijqT4+2q4IDNMpSH4VIgLA==
Date: Wed, 21 May 2025 17:38:36 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/97] 6.1.140-rc1 review
Message-ID: <aC3zfDn0nylOsK51@duo.ucw.cz>
References: <20250520125800.653047540@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YIHR8/QkgoVUOGnE"
Content-Disposition: inline
In-Reply-To: <20250520125800.653047540@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--YIHR8/QkgoVUOGnE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.140 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YIHR8/QkgoVUOGnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaC3zfAAKCRAw5/Bqldv6
8kptAJ9fISqWJXe7UrOT6WWYNALSgm8K1gCgmVnSyqX/UVU1X4fFfs53lqQ0sBs=
=stm8
-----END PGP SIGNATURE-----

--YIHR8/QkgoVUOGnE--

