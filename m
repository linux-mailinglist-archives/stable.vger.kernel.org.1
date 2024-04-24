Return-Path: <stable+bounces-41331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A148B0334
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 09:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0201F21ECF
	for <lists+stable@lfdr.de>; Wed, 24 Apr 2024 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280F0157E6C;
	Wed, 24 Apr 2024 07:28:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4CA157A6B;
	Wed, 24 Apr 2024 07:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943694; cv=none; b=bRM/ZqGw0X79tYhzHm0ITa3OJVEfacooHOV1heawbmHkc7GmZC1XXdU1BiP4ry6HrRS+V8dB0auO2SPXXz3v/x58UfV43qGyw1or5bJYrc15EeAH7VJ/8W5DyUj5PDF1NUi1lTActQX7H/6unhUuRdCE5NbKpOy3CZPoLTb1kBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943694; c=relaxed/simple;
	bh=VblaPkz2M+x/B2o17KTSp7PJSPr89iTr0i3x/hNomCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRV2s/lXbGqtMfj6ws6oUGLpIUt1QfWfN2ql9qi7kSunkCWFv9emDYTy7zQnzD/cvieeOkCwk+H/1qnuvur6QdH5Qt3lQdMRNs6DWcrOg9ezppgvYw8hUzHBrInd8aABa5eMMXvFwGELDsWMjhCN38W73DJklGrJJJzKAjC7Hzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9A0E51C0080; Wed, 24 Apr 2024 09:28:10 +0200 (CEST)
Date: Wed, 24 Apr 2024 09:28:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
Message-ID: <Zii0igG0SBKoNfBn@duo.ucw.cz>
References: <20240423213855.824778126@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Det3Y2CjCsXIUhin"
Content-Disposition: inline
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>


--Det3Y2CjCsXIUhin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.8.y

6.6.x compiles ok, too.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Det3Y2CjCsXIUhin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZii0igAKCRAw5/Bqldv6
8rP3AJ9JxRp/y05xyEmTwqVrAySMEwhEZgCeOf1Mq4fbTg61/L7krZVRxVm1P4k=
=/0+P
-----END PGP SIGNATURE-----

--Det3Y2CjCsXIUhin--

