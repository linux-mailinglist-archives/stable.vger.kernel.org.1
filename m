Return-Path: <stable+bounces-60358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BDB9332A9
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 22:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA63B2193B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 20:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F061F1A08AD;
	Tue, 16 Jul 2024 20:11:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B061A08B0;
	Tue, 16 Jul 2024 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160666; cv=none; b=nV2w5U5saz8LYJzgXDuNeuTWK1FrVXcvrlRJuHJ8KtArELJbzQbhVh9AJVq1pP2TX0xnTHPXONoKhJYIJFvaseWjerpd4j7i82QCRanyBRBlVhpIrkNTnIFHYE45p2CQu9FNMh/q9n9QLT9BoTfSWTfohnQg3X/6g2tuRrHrS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160666; c=relaxed/simple;
	bh=9AJN4PgJDFD6rXPl8hdNI4KFCO6auql45+lt7HZHXiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgN83Brg7NMNPGTBM6udfP3VQG6eWbrtEgDQITvQmspGRFfFVXPv/XR6Y1eN5kVS9aJQC2AbvJNQOmLyKMwheOMQJV7EQMVndCdE+d1sAa2ALRzirbF5AHIXogoJ40XxOkDMz81qKjgOo6iimG5upox/Mt0g0KyNgiJd5+0snpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6D0511C009C; Tue, 16 Jul 2024 22:11:01 +0200 (CEST)
Date: Tue, 16 Jul 2024 22:11:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/108] 5.10.222-rc1 review
Message-ID: <ZpbT1OjS+E0G89b3@duo.ucw.cz>
References: <20240716152745.988603303@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QV+03voLkCmUNdnV"
Content-Disposition: inline
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>


--QV+03voLkCmUNdnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.222 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--QV+03voLkCmUNdnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iFwEABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZpbT1AAKCRAw5/Bqldv6
8qJMAJUZ1HCs7M9ltxBPM6NVBdudqa1yAKCoqQZlKZER5SA6h+c1cuY/DnRvwQ==
=tfuF
-----END PGP SIGNATURE-----

--QV+03voLkCmUNdnV--

