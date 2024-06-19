Return-Path: <stable+bounces-54669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E590F7E5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 22:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8331C22AD4
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 20:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1EA15A845;
	Wed, 19 Jun 2024 20:57:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4F31369AA;
	Wed, 19 Jun 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718830648; cv=none; b=dq1mFbJSPAHRD2r/jzKKjZhl961xHozJ+2x7h8fxlJI1RtTVed0HXron+y7l53vAZ+sIQhK0Z0P4nXL/lkl1iLM+aMTtIGInA3XUmYgHYFxrw0tCF2cKiILhCr5RV0TGN5fMUDBzCMs1dAF1YNHL66sYktDFvnch6YqarKK3OK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718830648; c=relaxed/simple;
	bh=xTOfRL2tz0b6WCyjulJs0fsikM1YI2zQBzusjCT8LoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2J53GCfuc30ZjFx/dMP08W4sKRv3OKs0GJ6q2cctW3t2PTEXwJ/o6CWLKK0WItU3Y2IE5KhTFx2V7l9eLLbh7cZaIVorFMu0NpSFQZK6lNB8SJvkXGxR4gmHzRYrDEzLEuumGzlmPZzEY0fynBVKj2PU4HouUCPZLITlRbVBCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 48D9B1C00A4; Wed, 19 Jun 2024 22:57:24 +0200 (CEST)
Date: Wed, 19 Jun 2024 22:57:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
Message-ID: <ZnNGM44Fku37xgU+@duo.ucw.cz>
References: <20240619125609.836313103@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/zVKw+AUyu6qPTk"
Content-Disposition: inline
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>


--J/zVKw+AUyu6qPTk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.9.6 release.
> There are 281 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.9.y

6.6 passes our testing, too:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/zVKw+AUyu6qPTk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnNGMwAKCRAw5/Bqldv6
8jd/AKDAkPehBOnwYhyyqmA0qKbjIoW8VgCgmb+VPusYh8bVxqM9MDYzdpZZDTM=
=AKDl
-----END PGP SIGNATURE-----

--J/zVKw+AUyu6qPTk--

