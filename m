Return-Path: <stable+bounces-47511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8A88D0F5F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 23:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE99F1C21088
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E9481C4;
	Mon, 27 May 2024 21:23:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1BCDDC1;
	Mon, 27 May 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845023; cv=none; b=nSkxMAlXo8Jos/bu2JYytjl4fhh4lF+sbSRy4WQEHgo/prX/kVPPH5IL8nrkX28jRI7pb+7xvOrIMVvJ+fRJURyTb2BKswrG0oGkDHxyoBXZ5eRWWrlPw1Ak/mgoaerdSmt7JiJZsnsfMIWm8r0gt8fSFQcnumdvnGn8qKKx+3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845023; c=relaxed/simple;
	bh=EuG0n7WjdidwMNkKKCkD66ipaMdifKkclzGEPwS4AWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1+B5Q9abgutNt57ZA41drLoOvQmamrSD7YbmPZ3X+LjKV+XHxtH+s/oimcsQ8g8lM5TLKcYlTFtykPRjhhEV9C/2lKGGbrglSTQSzCi2XBkoq5nYSdJ9fhXHSgvRl2Kd8mIcx9mx7NZ9l2I4CtgTJ/h3eqp5ucUVl43ogWRV2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 80E861C0096; Mon, 27 May 2024 23:23:32 +0200 (CEST)
Date: Mon, 27 May 2024 23:23:31 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/427] 6.9.3-rc1 review
Message-ID: <ZlT506xwTYWg72Jj@duo.ucw.cz>
References: <20240527185601.713589927@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="15VYIY5feoL7t89D"
Content-Disposition: inline
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>


--15VYIY5feoL7t89D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.9.3 release.
> There are 427 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.9.y

6.8 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.8.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--15VYIY5feoL7t89D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZlT50wAKCRAw5/Bqldv6
8m84AKCwNIbOu2dtCTmq4emwR03HGhNdbgCgttMkKHVcTqgMZa0ibekr1ZEe77c=
=2atT
-----END PGP SIGNATURE-----

--15VYIY5feoL7t89D--

