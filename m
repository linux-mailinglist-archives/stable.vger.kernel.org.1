Return-Path: <stable+bounces-3582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC38B7FFE72
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 23:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9302818E4
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368D461FA4;
	Thu, 30 Nov 2023 22:27:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF3610D9;
	Thu, 30 Nov 2023 14:27:37 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6DFE01C0050; Thu, 30 Nov 2023 23:27:35 +0100 (CET)
Date: Thu, 30 Nov 2023 23:27:34 +0100
From: Pavel Machek <pavel@denx.de>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 00/69] 5.15.141-rc1 review
Message-ID: <ZWkMVhLYlAzGw8pF@duo.ucw.cz>
References: <20231130162133.035359406@linuxfoundation.org>
 <CAEUSe7-yhmQkr1iK-82+Sc_YpVtWUQhuKoazoXHF_3oP9XTt4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJLdSMefMAxmPjsu"
Content-Disposition: inline
In-Reply-To: <CAEUSe7-yhmQkr1iK-82+Sc_YpVtWUQhuKoazoXHF_3oP9XTt4Q@mail.gmail.com>


--uJLdSMefMAxmPjsu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Lots of failures everywhere:
> * clang-17-lkftconfig                 arm64
> * clang-17-lkftconfig                 arm64
> * clang-17-lkftconfig                 arm64

Yes, we see the same failures:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
091365008

5.10 and 6.1 build ok.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--uJLdSMefMAxmPjsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWkMVgAKCRAw5/Bqldv6
8vaEAJ40F1ieid6fZMyclRciuniTWQgSMACgj9kMQB8gGT46fRiRKafLJ0I2ULU=
=jksS
-----END PGP SIGNATURE-----

--uJLdSMefMAxmPjsu--

