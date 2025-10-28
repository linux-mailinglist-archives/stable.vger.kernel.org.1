Return-Path: <stable+bounces-191503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281A7C157B7
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0CB4655A3
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 15:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D57340A67;
	Tue, 28 Oct 2025 15:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EOca+8P6"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1783333C523;
	Tue, 28 Oct 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665472; cv=none; b=UOpf9j8bgkzf9iDNbM8jrIHNmxQ0gIGc0/XgGBY1pxJ+g3tFodyS22o+50/hJLkjYQk6k1Ghuxpi+OHn6HlZj01oRsoD9pyd85ZTb7ct3RnSF+IBILQkF0oikWwpJqB0+XznJZnxWjbJCB5KB6O9wQi98IHAolk+3TBY2zubbDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665472; c=relaxed/simple;
	bh=BscJQaQKXssg/JBKUDrSJc2ynCsUPDAqmXhamiPRdWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kl/06w9wae7Jdy/Dv/8jiPWzsFfQz54O9g5JvigHatPZzGJXgwOf7LiNpBo0rGDFdqjhR+NKSkHKnYqF6QrzKzSubuzP84xe4cz6XfUddAR5pG1E1YYAXchkiQx3RykfPYpAG91u0GrAuLucVKz74wzV89oxGIXRfMtYC4joWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EOca+8P6; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3808B1038C10C;
	Tue, 28 Oct 2025 16:30:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1761665459; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=J+F9vjuMT9/ypXwAVsZImyHaZRjRZh4kFpYxW7n7apg=;
	b=EOca+8P6SOWsKiDdKnt1JeXPg4bMinLnLYfgLDN0YNUTuk9tSyJCQGOr1ThpgCiKwJjql7
	FV+KyyuANTEfPwpCSOJBOAZxeykByX8o7QStJH5LdJ0vVLaTQdaKLstKxY/fhBogrKebqv
	GfERKEpziTrs2W5RF2CwSlQqQ1CnHSAMBNgw10NVtq4+CQbGysaV55gn3hsh1bVu6sIc/U
	8g1oXun4qWuitutCL3Ernem2n84GOoC7QCrrVWVcPYxdhNGFHWa05sEgmWrzU9SfFlMWgx
	/IW6wuVXqJQJ/q0ba/JAn6nC7ZwgWxMTodWVQDdV+CJH7/OoIwzql8rQa3bLaQ==
Date: Tue, 28 Oct 2025 16:30:54 +0100
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
Subject: Re: [PATCH 5.15 000/117] 5.15.196-rc2 review
Message-ID: <aQDhrtRto7AQVVSg@duo.ucw.cz>
References: <20251028092823.507383588@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dCp2ev7JzsPOZL0B"
Content-Disposition: inline
In-Reply-To: <20251028092823.507383588@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--dCp2ev7JzsPOZL0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.15.196 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Risc-v build problem seems to be fixed.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.15.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dCp2ev7JzsPOZL0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaQDhrgAKCRAw5/Bqldv6
8q8TAKC85rpyMHeTYbjzCxRgR2z8Kt9SCwCdFjyqzsZ9Xa9sazIQxK8CxE3GMXA=
=KDFW
-----END PGP SIGNATURE-----

--dCp2ev7JzsPOZL0B--

