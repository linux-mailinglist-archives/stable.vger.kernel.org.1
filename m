Return-Path: <stable+bounces-121284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5DA552AF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 18:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB4DA3A5CB7
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC8F214805;
	Thu,  6 Mar 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Anu++IdA"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774F946C;
	Thu,  6 Mar 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281366; cv=none; b=nuu8F1SfxgZ/j+lFM0jAdqqZJY7xhrl6yKCrVrUuA5AdvVMpr+8soOjSIdD/2de/CNpKIJFshX4JI/b/z9t2uKghEEdpb3Z6vm3MOoS8AWuq/ZIFOTHxrzyHbZLvCOK+8jpXKffMf4nkWQ661MXc04naDTAsZc1a4MC71oKt6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281366; c=relaxed/simple;
	bh=6yUS0gZqXlr5oXmQWOr2M4/WGsw428RVR3v78Umd2VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i057KAm9sZqhXPBTyhETIFGpABk0tfAn0QjpRlCSvrpgvL2pUoYCKzGwqD7QgC8gaoYy/pXqZgpDGdIr2telCAzOCJY3doIOH+fDvjeJEfk8EipaO+BkV1RW0KxprtbVFCiBwWtG2tkHxUXhDEfn+/M6vma/cp6zB7Eswd1KixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Anu++IdA; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EEDD10381917;
	Thu,  6 Mar 2025 18:15:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741281351; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=R9aP1jHlPPht+zv5TUTXYAZBlZqQGAGJO0vabeZpWFY=;
	b=Anu++IdARFpzsSERi714neoRcgEucGBiXUumxqW8plTtvomn4H/TKviQU5oyEMQM8+WCO/
	inSdsvuVBeSdTBXq2ajTbMa0YAsoCAH8tOrK6zmXFyNSb1KZfliyLNV53pzwgnJQexC0Pb
	GSbekj+K9182IL4yQU9Ax0T/zESpG9WgTTZJo330sCz0x6ZMwLokEl7dkWeZ58HsPLK8l7
	nFUc09EjSFVIm6Upq5VRxSxMM2q9BOCiic7SLuOSycAhNkZ0wY+QBNaXfOVcafU2IDI8YZ
	ifYcnBdz+Cf/95Yd5A0p59JdDORVJKt9CMLGlNbycrwk0S5K1EGMTNb0F3Mpjg==
Date: Thu, 6 Mar 2025 18:15:43 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/161] 6.1.130-rc2 review
Message-ID: <Z8nYPwPNhfTmMVTi@duo.ucw.cz>
References: <20250306151414.484343862@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lca3f2Y+x3EMTsjg"
Content-Disposition: inline
In-Reply-To: <20250306151414.484343862@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--Lca3f2Y+x3EMTsjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.130 release.
> There are 161 patches in this series, all will be posted as a response
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

--Lca3f2Y+x3EMTsjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ8nYPwAKCRAw5/Bqldv6
8k5FAKCB1uJENiBD8JrkFDHCf6JFg1RT0gCgk8hqExw36exOjr3algQKxyTGdGo=
=Hngc
-----END PGP SIGNATURE-----

--Lca3f2Y+x3EMTsjg--

