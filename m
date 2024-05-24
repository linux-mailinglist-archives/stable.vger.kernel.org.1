Return-Path: <stable+bounces-46054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C288CE4C8
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C95A2823C7
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 11:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DD18529D;
	Fri, 24 May 2024 11:21:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EBB53E31;
	Fri, 24 May 2024 11:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716549708; cv=none; b=S4PV7Zfu7LG8XkBSfi0kd4X8CtEzJqWJrLq1mTXHMvgPZmChane2DewdHzFecdnZvbT10wmX1hq+U411Fns7DJqoufDCev0/nCVpiicQdBFJkwZ36rkgIA08hkpyY4f1D0y6uL83rOJ4P7Hbz3Km0De9RgXyKmX48UY1z0nRoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716549708; c=relaxed/simple;
	bh=iNaLU3x3F9DnZTL/G2EVoXtFqgEqnENgimI7Dtu8GWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZE40jNzuub6g4IvHRcWw7R6y9h5VmLaL5h8R/oaxuGRsWAqXNuu6NIeqEUgomEYa4Sdk6TM5+MhUTxVsCbMsEwPlbi+pix9zKhkmUIUAXt4D0N87rnJhv78Gwb49QHx4dXv/c2D8xr6bs14qTYjBn26o6fV5oI0QDz4aP4aPpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9F3A61C0094; Fri, 24 May 2024 13:21:37 +0200 (CEST)
Date: Fri, 24 May 2024 13:21:37 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.1 00/45] 6.1.92-rc1 review
Message-ID: <ZlB4Qcryqo6YNWPh@duo.ucw.cz>
References: <20240523130332.496202557@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+7R2Yu/myQgOF7UR"
Content-Disposition: inline
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>


--+7R2Yu/myQgOF7UR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.92 release.
> There are 45 patches in this series, all will be posted as a response
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

--+7R2Yu/myQgOF7UR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZlB4QQAKCRAw5/Bqldv6
8qldAKC5ifYgfrZheQqCFYE2JH1FgjRl9gCfRM0TRwKmzBg+6UCu8hv02q0Dtxs=
=iYhs
-----END PGP SIGNATURE-----

--+7R2Yu/myQgOF7UR--

