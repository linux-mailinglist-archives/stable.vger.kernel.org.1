Return-Path: <stable+bounces-2826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E97FAC83
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 22:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DBAB20FE6
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 21:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E046443;
	Mon, 27 Nov 2023 21:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F031A1;
	Mon, 27 Nov 2023 13:25:48 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 527621C0050; Mon, 27 Nov 2023 22:25:47 +0100 (CET)
Date: Mon, 27 Nov 2023 22:25:46 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, maz@kernel.org,
	andy.shevchenko@gmail.com, brgl@bgdev.pl, wangyouwan@126.com,
	jani.nikula@intel.com, rf@opensource.cirrus.com,
	ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
Message-ID: <ZWUJWhOkbHlwC2YB@duo.ucw.cz>
References: <20231126154335.643804657@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MlZhcRN/f5z9Ed9v"
Content-Disposition: inline
In-Reply-To: <20231126154335.643804657@linuxfoundation.org>


--MlZhcRN/f5z9Ed9v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.202 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Marc Zyngier <maz@kernel.org>
>     gpio: Don't fiddle with irqchips marked as immutable

This is attempt to move people to new API, which will cause warning
for existing users. "chip_warn(gc, "not an immutable chip, please
consider fixing it!\n");". It is marked as dependency of another
patch, but I'm not sure we should be doing this in stable.

> youwan Wang <wangyouwan@126.com>
>     Bluetooth: btusb: Add date->evt_skb is NULL check

Could someone double check this? If we hit the null check, we'll be
returning success, but it sounds like an error case.

> Jani Nikula <jani.nikula@intel.com>
>     drm/msm/dp: skip validity check for DP CTS EDID checksum

This is preparation for future cleanup, do we need it?

> Richard Fitzgerald <rf@opensource.cirrus.com>
>     ASoC: soc-card: Add storage for PCI SSID

This adds infrastructure for white/blacklisting, but I don't see an
user of that in 5.10 (or 6.1).

> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>     media: cobalt: Use FIELD_GET() to extract Link Width

Cleanup, but not a bugfix.

> Dan Carpenter <dan.carpenter@linaro.org>
>     SUNRPC: Add an IS_ERR() check back to where it was

According to changelog, this is only needed with commit 25cf32ad5dba
("SUNRPC: Handle allocation failure in rpc_new_task()") in tree, and
we don't have that in 5.10.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MlZhcRN/f5z9Ed9v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWUJWgAKCRAw5/Bqldv6
8ni0AJsG3BKGQDCyibkUdDgmaa+Dmzg2wQCgoo/JMYlIky7pfMEfwLJp+v8F6Sc=
=3dfj
-----END PGP SIGNATURE-----

--MlZhcRN/f5z9Ed9v--

