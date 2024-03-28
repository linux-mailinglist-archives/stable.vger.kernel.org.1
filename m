Return-Path: <stable+bounces-26769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A5871D7F
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 12:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8126A1C23111
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1630A5EE96;
	Tue,  5 Mar 2024 11:19:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485025EE94;
	Tue,  5 Mar 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637585; cv=none; b=BvRgxvZsRcQkuHv2cf5ar3CjQEgZj7n/yNX6X6rFBWzgCxgepyUbT9CIAd9RFFVM3fZJylhMS4SntbAuPG87a34n/rbNGU7gxg8Ga5ksac6tDOkpTT/4OcOYjZQth853EkRnQQZGdoUNjMC3c7qQ9/3XCI6BxlJQKChbeOWCbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637585; c=relaxed/simple;
	bh=TXwKsjRIw4Rdlth6z0m2VwUY45M3zkg3gPA5C9DK3m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn5C8s35y3r8KtDSJU5S95DO23rLFj+/AsCKAYgSlp7kgE9i6HGDLnA3uYTEOIVPSHld+aYSWBORqNF5FKTqbUbqc9zMKEoTWgeVVrvgMGvX6IpvfpPtTRIlOABFP92AQPGMQ7HSWXWKKCJLzwu9MYBtnizLvDf7ZlqFlQlDgQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C91AA1C006B; Tue,  5 Mar 2024 12:19:36 +0100 (CET)
Date: Tue, 5 Mar 2024 12:19:36 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
Message-ID: <Zeb/yLdhDLVy8hob@duo.ucw.cz>
References: <20240305074649.580820283@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dyv6ruP320k0RKr9"
Content-Disposition: inline
In-Reply-To: <20240305074649.580820283@linuxfoundation.org>


--Dyv6ruP320k0RKr9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.7.9 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

This break build on riscv:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
201117170

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Dyv6ruP320k0RKr9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZeb/yAAKCRAw5/Bqldv6
8m8/AJ4uW2MW1g98CRFOVBQUr2inzbZqNgCfcrj7hJc4eNhB3Mr90Mhsj1ABSBU=
=Tfpj
-----END PGP SIGNATURE-----

--Dyv6ruP320k0RKr9--

