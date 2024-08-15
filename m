Return-Path: <stable+bounces-69250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FA3953B7F
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 22:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7099B21069
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDA713D525;
	Thu, 15 Aug 2024 20:32:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C973F9FB;
	Thu, 15 Aug 2024 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753955; cv=none; b=RZip+eUtyur38zBqaFz84X0D5R7yWJl+EXIYtVfl9WwUnU8E6L3CG+A63MBikLeRHE+zV5w6XvxmopLIowpkNKRYKCIxWp7sd3gARRCUqyr5GQ8RGyCsffVmp+SBdNr0EJnzI49HiKJOD3FotBuNdGOQT4xMW0GGAbGmyAnVjx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753955; c=relaxed/simple;
	bh=vibj/4V33nbPNHml3MpuUHMM+NKK1B5C0WKKT2ETXxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+PBtCObX1X4xbeuENOEBl3bgJjzjrAZ1rMFk2D8nszxytrsaQngn+v2qsU6SefPh6M55hFSvEzQijBMSPT1TQyZrW5Q29su+zMEktpbMcHFuAfu/bJZBvXa5OCZneaCZ2+luJPuzMOaDXTZolwkBizusZANSpFkhmEi5hLlWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7236E1C009C; Thu, 15 Aug 2024 22:32:30 +0200 (CEST)
Date: Thu, 15 Aug 2024 22:32:29 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
Message-ID: <Zr5l3eldPD2ZMxmO@duo.ucw.cz>
References: <20240815131831.265729493@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdRNAz8YduhKP4H5"
Content-Disposition: inline
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>


--CdRNAz8YduhKP4H5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.10.6 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:                                =
            =20
                                                                           =
            =20
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.10.y      =20
                                                                           =
            =20
6.6, 5.15, 5.4 pass our testing, too:                                      =
            =20
                                                                           =
            =20
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.6.y       =20
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.15.y      =20
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.4.y       =20
                                                                           =
            =20
Tested-by: Pavel Machek (CIP) <pavel@denx.de>                              =
            =20
                                                                           =
            =20
Best regards,                                                              =
            =20
                                                                Pavel      =
            =20
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CdRNAz8YduhKP4H5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZr5l3QAKCRAw5/Bqldv6
8uG6AJ48SsqtSrzuyWWw9uSjZQzvvCWGDwCfXlmx1HbjUW0o+8205ExjZ2VHH8k=
=+sHw
-----END PGP SIGNATURE-----

--CdRNAz8YduhKP4H5--

