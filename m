Return-Path: <stable+bounces-165515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0804DB16147
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 15:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72FE57A7035
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB0A265CAB;
	Wed, 30 Jul 2025 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="RoiF4ITB"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDED221FCF;
	Wed, 30 Jul 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881518; cv=none; b=boMamI82qsFXKGYYtS5+9PlyXQynRiq2gBdkr6ro/I1zxdJzYt9z2EvTu4YmP1l5FgCqugbPDx0+6UtHlCJkkvAFuK3z6Td5ds2NSiBgU4cpamDbKZXzgp0wjjc8r3583o//i0ot6+3V5sJXXGRlcUCUy+KpTOlT8175ld1psNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881518; c=relaxed/simple;
	bh=2tWPlZqUNjXboscCW+30SBEbPLV3/+UL8oV3aqH1+dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4ksZpJ3NCu6fvUA8OVL4c4u8PBwCS2JTnLK/Bau3A5y7qTVkbWuC0qcjQemD7EqavlcYfQGSk5R19EGsu4RiawP3m0Kk4sd5j2Vwj6dK0nn56uA8D1sUNUdBG/99HsM3XvLh+hKTi0c19jmnYosw2CgTo1h7V9SFRafQnKYuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=RoiF4ITB; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58CCA1038C126;
	Wed, 30 Jul 2025 15:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1753881507; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ja/3htj9Ofe9vlKwnosXaCahdOAGWaeWtEl6sJ2Sk5w=;
	b=RoiF4ITBc5mDpl4a97nGglhAoDfzZxFdgoNcjcv3/ZyeUmakaB6UOlkIplBTWIYBW34yrA
	F6SbjhRCFBXWanzjMLAhxK9RPBlFEXvMAzMdihLIkxtfMcxhoIVOTFaD+4F/Hmr0wOdDah
	j6SuJHnA8qW956yZAzKxqAgBEMIIftccyobS8I/qJxI5Dr1iVBL8o17RcBCG7MoxJNXNcl
	lIKdaKj/h/N3g3vHT4bUv5p38PQ9lNvbqxb+XdlweOhFsImpSbJYEuH1Lnbd+/jab2vKbm
	BGVmhufmAq0cBDtBk+gKHY6WLDBsyKMfsaBfhgSNq/4qs65eBYEvc9ED6kISbg==
Date: Wed, 30 Jul 2025 15:18:19 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 000/117] 6.12.41-rc1 review
Message-ID: <aIobm0gF4y9Rz7NC@duo.ucw.cz>
References: <20250730093233.592541778@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gcSczekG9bIs4bGH"
Content-Disposition: inline
In-Reply-To: <20250730093233.592541778@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--gcSczekG9bIs4bGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.41 release.
> There are 117 patches in this series, all will be posted as a response
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

--gcSczekG9bIs4bGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaIobmwAKCRAw5/Bqldv6
8s71AJ4zrRHw5Qpko+26Yn3Y0YhItJtEgwCgtHtuoLisZylDthOuzaV+Fjji3Io=
=a+et
-----END PGP SIGNATURE-----

--gcSczekG9bIs4bGH--

