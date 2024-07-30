Return-Path: <stable+bounces-64672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C969421FD
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 23:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890291C22F01
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 21:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037AC161320;
	Tue, 30 Jul 2024 21:02:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE96624;
	Tue, 30 Jul 2024 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373344; cv=none; b=nnJ+YWQpRwNR494coHN3+Q0bZDe2RzFSQ+n+NdotrF3whBLGm/Oi5nNbMzC3yuDTtMc6s0NbSEBwgCAFHWkAY9AHAve60mKcQSLmyO6+hSxLqkBIFP/zeG9P7XXuYHBMfNVmANrbMc33vYY9LvW8eHbncqnqygNCxAx2OiAafKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373344; c=relaxed/simple;
	bh=7/uf0OevkwywPkhARSogSiv4kSPEYbfvGA0Pcioqhj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpNtRGVXj1bYmIzgezHCQ3SUHKI+gJSyLUoy5O7nielA46mXPte7OheO9Y11FKEPt1xj+LCHFH4AeAwjGo1Z+hd8I0aIWezPpCDyC/GSs6GXiAtncrB46g0MsJH0XI1j4W/D11ATpu3jhfHcwvMGjUH3fX6v2kxyTdWmgydmfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7E7C71C0082; Tue, 30 Jul 2024 23:02:14 +0200 (CEST)
Date: Tue, 30 Jul 2024 23:02:13 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc1 review
Message-ID: <ZqlU1X8EVrdCLEY4@duo.ucw.cz>
References: <20240730151724.637682316@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nSoJ71Dp7WvavFwa"
Content-Disposition: inline
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>


--nSoJ71Dp7WvavFwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.10.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nSoJ71Dp7WvavFwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqlU1QAKCRAw5/Bqldv6
8lVxAJ9hRy3poXNWWDj8+CWwNr4Y55q7uwCfcYPEdg3iW3xUbVTajAqIKAyUB7k=
=Jx+p
-----END PGP SIGNATURE-----

--nSoJ71Dp7WvavFwa--

