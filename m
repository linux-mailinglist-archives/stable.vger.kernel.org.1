Return-Path: <stable+bounces-6505-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C6F80F784
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 21:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A721C20D9D
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B35277B;
	Tue, 12 Dec 2023 20:08:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E4AF;
	Tue, 12 Dec 2023 12:08:37 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DB4A41C006F; Tue, 12 Dec 2023 21:08:35 +0100 (CET)
Date: Tue, 12 Dec 2023 21:08:35 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dianders@chromium.org,
	grundler@chromium.org, davem@davemloft.net
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: RTL8152_INACCESSIBLE was Re: [PATCH 6.1 000/194] 6.1.68-rc1 review
Message-ID: <ZXi9wyS7vjGyUWU8@duo.ucw.cz>
References: <20231211182036.606660304@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cht0fa0K+yEvwRhe"
Content-Disposition: inline
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>


--Cht0fa0K+yEvwRhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.68 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.


> Douglas Anderson <dianders@chromium.org>
>     r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()
>=20
> Douglas Anderson <dianders@chromium.org>
>     r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
>=20
> Douglas Anderson <dianders@chromium.org>
>     r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
>=20
> Douglas Anderson <dianders@chromium.org>
>     r8152: Add RTL8152_INACCESSIBLE checks to more loops
>=20
> Douglas Anderson <dianders@chromium.org>
>     r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE

Central patch that actually fixes something is:

commit d9962b0d42029bcb40fe3c38bce06d1870fa4df4
Author: Douglas Anderson <dianders@chromium.org>
Date:   Fri Oct 20 14:06:59 2023 -0700

    r8152: Block future register access if register access fails

=2E..but we don't have that in 6.1. So we should not need the rest,
either.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Cht0fa0K+yEvwRhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZXi9wwAKCRAw5/Bqldv6
8gLyAJ9CN1BgY6YKRrS9hreIKteDrNFAvQCgvFASIZ1oTi6gWDPCm9Pg8E1n0MY=
=Y/i8
-----END PGP SIGNATURE-----

--Cht0fa0K+yEvwRhe--

