Return-Path: <stable+bounces-94508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D843C9D4A08
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 10:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3EC282179
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2E01C1F26;
	Thu, 21 Nov 2024 09:33:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794A154BFF;
	Thu, 21 Nov 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732181581; cv=none; b=qjWtqgGdLBURyAYD0PZmlFN2CTIzSghGOr1YE4tfCidIsj3Efhaf62pgn+n82uDJjh6TW8vy06e/uxTz9DwQNevUwayuFA0uCW+mX/UCrlIx6JlBXj6AYPG/RQwbN2LO9odcjiDnyydDTxnCk4kTfapkS4c21gz/FSzDR1Ew8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732181581; c=relaxed/simple;
	bh=ju6w+OEV6RGqOl4StwYVV73mcfrYeHharZ90JPv9bV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCrrPuc5gRLxAVTe25UXZ0tf8EC8riKwi0a/5/Y/UUNQN0utGEsQtkinADZQkIoXi5Ao6dKsfu2Qb/hZDwK9e2hr1bCyCbX8bywF6T/u/elyg4mlIcnEQvO23O0/KHjU8Gjrb2Bv8ob8an78xLdtt/qPUqtMS7LjlfV9jTwevSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D36661C00A8; Thu, 21 Nov 2024 10:32:56 +0100 (CET)
Date: Thu, 21 Nov 2024 10:32:56 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
Message-ID: <Zz7+SIXT9ti+g/NT@duo.ucw.cz>
References: <20241120125629.681745345@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFNwiWPH6culmr1R"
Content-Disposition: inline
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>


--oFNwiWPH6culmr1R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.11.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oFNwiWPH6culmr1R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZz7+SAAKCRAw5/Bqldv6
8lABAJwOktlr/JOLohfFWb8BgoNmzyPtdQCeLpnEiFASEFBHMY92Z3FbPWXJijo=
=2mEz
-----END PGP SIGNATURE-----

--oFNwiWPH6culmr1R--

