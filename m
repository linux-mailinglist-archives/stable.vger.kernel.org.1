Return-Path: <stable+bounces-65943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEFE94AF02
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 19:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11123283835
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9613D291;
	Wed,  7 Aug 2024 17:38:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C1013BACC;
	Wed,  7 Aug 2024 17:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723052329; cv=none; b=jui5YjiXb0LVyeGGEgrfSAQz+XOz2grLeAWPaIMQNTY7PLHoTYDjAFvI74SVepi/GCnQG28rr4A59DVSSZ/MKLn3A67O1WMcTW6OGN8F55bV3nOJPaCsX6TTNtoMEHIgfkxvgaCn7qWgKb6ksGmI4VbKjvEOiLNDw7sHYyxYUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723052329; c=relaxed/simple;
	bh=G34MLcZek6ZJZmuPIY647FHUQkHgp9qvo38MQTEokPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADQENME5QZ4UE6cqJ46dctCm2pLbt+vwrKK6uXdazIMS1Unn8lYNAl2UtfHOFoIqeSZiKohRh03eBaD0jVowlg4WFsr6H3uwTejq08QYAEwSbcR2lW2Lz0w5X7u0ywe3IWXQ2W5oh8MzuCYlFtD1wz2DqfCimGX6eUlIwxToba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 4F6161C0082; Wed,  7 Aug 2024 19:33:29 +0200 (CEST)
Date: Wed, 7 Aug 2024 19:32:50 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc1 review
Message-ID: <ZrOvwlaMUY7+KvZs@duo.ucw.cz>
References: <20240807150039.247123516@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YO9CkmFFup0qxjMs"
Content-Disposition: inline
In-Reply-To: <20240807150039.247123516@linuxfoundation.org>


--YO9CkmFFup0qxjMs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.104 release.
> There are 86 patches in this series, all will be posted as a response
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

--YO9CkmFFup0qxjMs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZrOvwgAKCRAw5/Bqldv6
8iUSAJinslmJCrfhZq6IulbXHydHv7rAAKCEL1OeNkbaE1dkP0bI1v3fRuWcYA==
=sThu
-----END PGP SIGNATURE-----

--YO9CkmFFup0qxjMs--

