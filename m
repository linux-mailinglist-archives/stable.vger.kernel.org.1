Return-Path: <stable+bounces-93678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ABF9D03FE
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 14:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FC17B22070
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E771885AD;
	Sun, 17 Nov 2024 13:26:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863551714DF;
	Sun, 17 Nov 2024 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731849961; cv=none; b=fAbl6d04WA7mQ0tvacDKTfiIrS18tNRTzLQumOwgrI6FKg5vpqiNBHS0TeTF4L9ACwPw2TSsL+WtsjDIl0Xsq3jU3mChLmyXR+mZYPI6ywp1axEdVRpsEjGTiArHmNmTIbv95ONKczgo7gDQ0FVuWPOUmhSWEUvA6WWqeiW/PNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731849961; c=relaxed/simple;
	bh=QxOTOF2FtyQ7S0ZuMjwgMpxyZShWJGA7HXpTiTfYYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbsDjgYoHJ25AzdKvUJUU1yZZhEmgp73N2AX9q8nC+a2sx4X4l68vGA81+pXel3rFRAW79E6K1w9thCpI0EU0tbLDguCbiiFmq2qGINeiTHzOHYfmKw/6QlX84LtLFzamzm1+Q2GkM3whW3dhLdBKO3NRwqQSWIunmoldl6pdms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7BC8D1C006B; Sun, 17 Nov 2024 14:25:49 +0100 (CET)
Date: Sun, 17 Nov 2024 14:25:48 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 00/52] 4.19.324-rc1 review
Message-ID: <Zznu3EHZdQllB0Pt@duo.ucw.cz>
References: <20241115063722.845867306@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fG4Dz5v28flfgPG/"
Content-Disposition: inline
In-Reply-To: <20241115063722.845867306@linuxfoundation.org>


--fG4Dz5v28flfgPG/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.324 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fG4Dz5v28flfgPG/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZznu3AAKCRAw5/Bqldv6
8vNFAJ0SMScfzUUi12UJ+QzduSd0u36NoQCfX04+rhn+PY3TWRmJ+mKTZ/zi4Gc=
=PAH4
-----END PGP SIGNATURE-----

--fG4Dz5v28flfgPG/--

