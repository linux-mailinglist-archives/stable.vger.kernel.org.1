Return-Path: <stable+bounces-94507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5307F9D4974
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 10:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC7DB241A0
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283651CB50B;
	Thu, 21 Nov 2024 09:03:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC51CB33D;
	Thu, 21 Nov 2024 09:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732179788; cv=none; b=gj8lXcw1ikLcohSuoVhXh0Lb4wcX6og5YOKZY0q2Rw6QCgASM/OJMk3eRdWyH/u4HlFt+JQfFKCQgt+2m4eh6ylLtGgh7KveWsI8jvYVIQ1sxVji1cveKzyneZsyCizC4sHYtKgbTNoy3pTF7n4aVHyRrK7VA2YNciKtwQzSg1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732179788; c=relaxed/simple;
	bh=dkWaQ47ElqK/IVAD/NkPs8IzwV9bOvbZlyOJXgqc/DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdYriTNsnbZv8jF2VtQEBbQo5+fB/aep33a7y6m0TSgVxdqb6/tukyo2IEexTrpKaYj9fAxr2MBrlFji4s7nd18RUqRX/OHyNgDUfV58cNZXKiw3r/5tfwTvaefAwQn3PwWXqAfs6epKTVsrhV9Rf6fR7XTz9dNf16to+rOwDB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id B22031C00A8; Thu, 21 Nov 2024 10:02:57 +0100 (CET)
Date: Thu, 21 Nov 2024 10:02:57 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
Message-ID: <Zz73QRGLDU8xreEa@duo.ucw.cz>
References: <20241120125809.623237564@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AtKEwY1kABgNV0nU"
Content-Disposition: inline
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>


--AtKEwY1kABgNV0nU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
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

--AtKEwY1kABgNV0nU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZz73QQAKCRAw5/Bqldv6
8q/UAKCqikcVHQSDaazAY35gv5DmUQFhwQCghXWes2GOgAjwSW1iFj1EiRAm6Q4=
=yCwM
-----END PGP SIGNATURE-----

--AtKEwY1kABgNV0nU--

