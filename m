Return-Path: <stable+bounces-2946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E457FC69E
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7533A283139
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129924438D;
	Tue, 28 Nov 2023 21:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE2A9D;
	Tue, 28 Nov 2023 13:01:51 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EC1771C0050; Tue, 28 Nov 2023 22:01:49 +0100 (CET)
Date: Tue, 28 Nov 2023 22:01:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, stanley_chang@realtek.com
Subject: Re: [PATCH 6.1 000/366] 6.1.64-rc4 review
Message-ID: <ZWZVPaIt3EGsDLj7@duo.ucw.cz>
References: <20231126154359.953633996@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RzAbNghvS/rgMX0P"
Content-Disposition: inline
In-Reply-To: <20231126154359.953633996@linuxfoundation.org>


--RzAbNghvS/rgMX0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.1.64 release.
> There are 366 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

> Stanley Chang <stanley_chang@realtek.com>
>     usb: dwc3: core: configure TX/RX threshold for DWC3_IP

This adds properties such as "snps,rx-thr-num-pkt",
"snps,tx-thr-num-pkt". They are not documented anywhere, and they are
not used in 6.1 tree. DTS checkers may eventually find the
inconsistencies, and this will cause warnings, so it may be good to
revert this.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--RzAbNghvS/rgMX0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZWZVPQAKCRAw5/Bqldv6
8o4QAKClYXQc2EPmalB52hJlRmqzIOGuLQCeJxy9LQgQImFvh2NPluUrHvt+20Y=
=vavJ
-----END PGP SIGNATURE-----

--RzAbNghvS/rgMX0P--

