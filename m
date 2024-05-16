Return-Path: <stable+bounces-45267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026488C74CB
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBFF1F24D90
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84779145339;
	Thu, 16 May 2024 10:44:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE80145343;
	Thu, 16 May 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856280; cv=none; b=XbqsFow/JzhhNw5TF8314n/JcfsCYKPKsiNQA8bBJ3+tVRVIczIrL3JdTlClZl0vm19h5414fvoQVwnFQ5Xt2E6lXxRZ2aHAInTKt1iSgq/1LNL9zV2H4/d2LSpDOCX4vViXOg3K4HswnBJShaT38g994MKVy8GfN+QLxDrtzWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856280; c=relaxed/simple;
	bh=A5AfgmEwsR5pOmCAWl/+5gLI7szoIUlGE45AaXulp3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXXEWuFfzSGHNgr6Sn5UGvEDTm8kwmPdg/Vw3VkTiqGB2C6ubJMp9pvurac+OxUvJVteEnygQu9SDiIgjh0IfpozMo0GOqT1Yy0piHPflLy+kVgh/IulU2R8158PRs6ERLC6NYzw2Ybqp4jHzHu39t4CXwF326y6NynDu2lVnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 28B451C0081; Thu, 16 May 2024 12:44:31 +0200 (CEST)
Date: Thu, 16 May 2024 12:44:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 000/244] 6.1.91-rc3 review
Message-ID: <ZkXjjjBEjn6bt2wB@duo.ucw.cz>
References: <20240516091232.619851361@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4dnc35YGozj3ZmnB"
Content-Disposition: inline
In-Reply-To: <20240516091232.619851361@linuxfoundation.org>


--4dnc35YGozj3ZmnB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.91 release.
> There are 244 patches in this series, all will be posted as a response
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

--4dnc35YGozj3ZmnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZkXjjgAKCRAw5/Bqldv6
8jabAJ4+RXLU8B01r2SCh571DRUnmnMbpACgmKhmZIOWE+Lu4vV+KmWcmSqR9Ns=
=rcPn
-----END PGP SIGNATURE-----

--4dnc35YGozj3ZmnB--

