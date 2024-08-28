Return-Path: <stable+bounces-71397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64919962450
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 12:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E66282590
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 10:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C833167296;
	Wed, 28 Aug 2024 10:08:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC35A15D5CE;
	Wed, 28 Aug 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724839737; cv=none; b=VxLf1PH7ehUx8j40R42CnrU5J+oQuDTkWJxMbs7Sf0Hs9MVvnIf1T8V0MxQLJX9PvmovalquaQjVMyavZsmKc9bpofp7efa5kaJS6vlixWQxQmGjSCumb2S11LutkkkwKZ9PLteoY4rkEYnZfHQHFpL4/6xlVFC3Mq6fV7vDPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724839737; c=relaxed/simple;
	bh=xV0P7iLUWANRkYciL//YE3bYgFBMfa6/iFXlqc1lhNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfISIOz3BdG372eqzu2x7g6lJuIlaTvE/2pYDDHmPKy8kOp9jycC7VxGk9QdO/bj/5ae8ub2jw6vOVsMoJxpxBMakVAbAm1J71sZQAMTZhEHjZGdfvSfNwfvCljJMIjKjY6qQL1FnLo6HdDFe8SKolzjkGzygHTvTqbb1Sc1sQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A65601C0082; Wed, 28 Aug 2024 12:08:52 +0200 (CEST)
Date: Wed, 28 Aug 2024 12:08:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/321] 6.1.107-rc1 review
Message-ID: <Zs73NFq5UiZdVxJw@duo.ucw.cz>
References: <20240827143838.192435816@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRBFVEhV+Tsa0VY9"
Content-Disposition: inline
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>


--wRBFVEhV+Tsa0VY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.107 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.1.y

6.6 and 6.10 test ok too, for us.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wRBFVEhV+Tsa0VY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs73NAAKCRAw5/Bqldv6
8tkNAJ9bDNAQRJYjYeVTukM2uatqjsixYwCgkOR6JE9r3HH+iZdm/W3PqnGEZCQ=
=nJmW
-----END PGP SIGNATURE-----

--wRBFVEhV+Tsa0VY9--

