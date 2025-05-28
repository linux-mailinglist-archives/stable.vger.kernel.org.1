Return-Path: <stable+bounces-147929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DEDAC6559
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F326F188612D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBFB274FE7;
	Wed, 28 May 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="KvVJehz0"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7F274FCE;
	Wed, 28 May 2025 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423554; cv=none; b=jCxGY+SauUHrFSWyRFIMBzCsuXEWljSd29jLewuxxyljz0LS5UxdAEbl2TnB70Qmy8uE6COhRRSSauQIHFHdRGeJFrftOsKfA1yL7sL8AIXUUjmHIsHC9ZhKQMaPPE2RPVzAoG6Kc7BqxWE+fg/ChWfprQalTBWIs9b4N9vcrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423554; c=relaxed/simple;
	bh=k/lWW+XJEE/jO3BFYNSnb6x47MyZmdSiljCfPatqm+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv5BL9OfSL6iWZuIaS8UtAtOWJKzS/aSCRNLBbVxHPOUipcu2basFp6ScHFowwXWIlTxdR7DlXXzrwMPocFj/2m0K5oFLi4c3xmILOFn6NrPlPiaBrjU4Q3SHKjf2bxsbEklfoxlLRJ2IHG4FnjHesGdyFhBNyf4kbQOwHepe1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=KvVJehz0; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1748423543; x=1749028343; i=christian@heusel.eu;
	bh=/uji3PF8im9HzGIV2pshAadjNtC4PtjN0qjn4T/Dtek=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KvVJehz0Bl3nk3lvziw6OZAMaS6ft2I5oEX1ipFoiGL1ltRuSIvHfqAlW5D2jyLF
	 L8JB0hkeVN+Td2/beUg5gsZrWB/notk3RyKjrwzF6dUDSuiv2kae17/WwOD1eQe4O
	 TqXLWGkm4PZgjTqMOoc/CInzA1NtbOhJth6R9+d6dToYtFamJ6+DfMeBNiZCdiqPO
	 Shg8eoUrn/EV5mOp2J7ZlppX+aStE/zM35SNxDB5ehTfiq0XvZd5veWO+g70gyeAj
	 Qdez65WKn1hjfi7C2NDs4EfPkl0LVviidPoYwdeh92MbgTSoggSOEsikO2KcCvX4o
	 5T8wF4XuL8FPaMlv2g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpUQm-1uhC8R3Mxo-00gTEb; Wed, 28 May 2025 11:06:07 +0200
Date: Wed, 28 May 2025 11:06:05 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
Message-ID: <28384a64-65e0-4284-9052-9ff49f673020@heusel.eu>
References: <20250527162513.035720581@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dakoe2gwzt3ggdmk"
Content-Disposition: inline
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
X-Provags-ID: V03:K1:GQyY309Bmv+M0uYNfJlV5QP3YjtuAhSCLjJU/WCVqRv21ZqnOK7
 eVCS/Z1OJ0lwyZ25tdVUkalYrF+oGIf5teQGZnYbXF2DdodvVmzf44gc6Yty37+n+pfkgoO
 2aVRNAC8Cfw/oA0KlHjv/BQhT5UVm/bL3185vODu16No4u6GpnzEf0np+e2V98DFD/VQiXS
 EvDr482pMPuR4v2DBCx3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x5kj2DqpXPE=;5z8Xccqxo/dgc5dSDPiFsPLTCmA
 Pwn8IBvYjv6wBTPOU9GQCoS2qBAuaEx+z4pEVgHnTW5Te2rEIRduBUjFgfb6sJ1wc3LoSrVoJ
 6Lw83NSDU9lhf0U/gL0Xa+wg1Sw9vE+E1yo4JcadNT5QXJGb8neIunnZFF/UEeVJPB0Y4PEm7
 i1JrzX183wZYivzt3Y+HmZLeCBrHCFXHMxIdCGB7iDgqGJTIC9uBWJEQuf432b/USvAI7ptjY
 S4yaYQUdvDHaPjS2SeYHvHYj72wawvXMfa9OXvr9x3FbSM5OjonZZDTSfOhZtQMWIBsgicyrt
 KNYji/vTHka3b0SRDO3f55Wi11ZwaWimZ3NnFxAJW8q/koiLQezIPFgoTMLbavPMZCibbrdn7
 ZrQkEt0D/A89G+hhgVGMJKRO1FVlgFwnSdmlJxESCuAaTt4jAuIHCX5oIP+HmYjn9induWcc4
 Mt9o/9TYtBfQq23aUQmaYniY0BWzscCgz7KYtrTyLK7c2+SlZenznmGFB7Fi66b3osrFjPCyH
 G/1/LIqcVeWIF4Z8Rrnlh1Hy6HkZi1PkSFQPFmeDCJ2mzzniQuFK7/zDLV/0MxmrazExQpnUf
 8XQgPTSiFZS7Ra52f5JKrAPbnsP9lD/jzJrhmTn6vHQN1JMawXPQQ0v8NOibxnJ9tKnSSmSo+
 1ODucaEoVmpW9nd48xMMH+o7lFnOb2SaqAdVxH96MZETTPsmpLmdG42eN14/gxURmpWYJ4QtU
 G0OCYQmKk51WqaaK92EfB8PXi293zxfIpEbBDONmYDULG5gGlxbF310LpKmswwkaS3cUSEGpB
 xwGXuKpL2gBiQRUwdd4SO6vfUJbJ0UZqiePNs5RctUt3E2Pb0UtrhhLO45RLDRWZBzNNGKvuj
 j6hPReiMarDL/aPxrc+nSXoHuG0Ykler1AMr/NxMxRfeLp2/d9Me4mBFVZM9pnM+HjwByGsbs
 q0729ohSywyoj6hvQitJY+lmh87n7tEDMV9DRHTFTI141xCgThWITgS7gpSMxt03FBkdbFYQ0
 sDpm29Ycervag0tNmFkvPVxqY02efk6+RQ7cP/FSj1bRI4gh1QTsZd+wLTHgx49m3ZDZIBo5H
 PNGgcyxyyZgDWZjBBdSgqmvmToDuULy2Dbq03hnZhdUqfhEULPdQAScSoasM7EPB2/QH+tXBX
 4Re24TY23drDX9D2IFyktEF6zf7YTMj2yecCErb/V5yV5HeXq/s3QHxvSaZuOGLw8rEVsy+Pw
 gDdqx01f/iy3x4Dz+LErOpZWDnRDgAAUm9II6hpKOms/8hOApDk1Wv4EA1RPfJOuneN2sb2nh
 nPs4Qz4YkxrrAwo0CnJbe5hLYnUGZqFGMCeHZ6NvvS0FRQumNuiokoUcNalwjA1w2n2oRvPzk
 U+X7jWEZZMWY1BsYk+y4Ed2T5M09/1Af2dYj3xUHSTX0YiXUQEXuI93LHm7zPg5GWDvnXcf36
 KOh2shm2XyNCoyPk89WpBe5QSF7w=


--dakoe2gwzt3ggdmk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.14 000/783] 6.14.9-rc1 review
MIME-Version: 1.0

On 25/05/27 06:16PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.9 release.
> There are 783 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 29 May 2025 16:22:51 +0000.
> Anything received after that time might be too late.
>=20

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.=20

--dakoe2gwzt3ggdmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmg20f0ACgkQwEfU8yi1
JYXQaRAA2ynCtTKO6jxFUHncW496AAGx51nXBx1suUYUAL5+rIa0L0TnqZevkh1+
uxXqiIfF+houSMgtQcnCudy0MuQ64WQ9MdQPcuywYZyfs2Un89eAnsRiDcRNOy6o
1rIvq0TtRyCyFiwRSKvZoxGh32/mPbD4KDHTGx+UClxEpyXDfHv8q8RaVdgc0T2C
XOBOIaZAVIH4tln6TzSxKqPMHx6zb8Y4YmOEGCzDks9FKameLvk7GbNhIL99b3xf
0YODRY5d0Se7jGNXlvST6dzj0IuZuQlmE7vs2ThNa1orLcR3Qi7qpDXugKjlo/Xp
dvdljtx66urL0mQNABMcdePZYEeyqA1KCx8Fbc9Vjd560/u3cO7Ag4QcwM924QLN
H+ifA+l7Ey3IbE1qjUQ++JRV2kW0qylA/5dS1Wd+6A8t7KGsg8moZPIgb8Ifc4eL
LZBXfyoelMVCeH1f6oPz7raCU5pEyQo1w8wncoOa1hi24ZE+n2QKjPfRZT3WEk4z
77P1Tx6Lqf+BV7XUhsqPiSi5uuU95LKuEX8g7EBfQrNhCAHPT7Pdxr50iokVr/UD
CVN/lcX1xVguW0lpa/EFrRUAczxUFO3YceO2cYRWQOSG/4nET9VsvHxOSZipR/wY
iSogXIgVAN46R2wlV1btv2FH1r68XYTMh05K0oYHTygwWkiRdUA=
=2OuG
-----END PGP SIGNATURE-----

--dakoe2gwzt3ggdmk--

