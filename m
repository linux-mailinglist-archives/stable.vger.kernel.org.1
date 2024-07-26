Return-Path: <stable+bounces-61919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB493D80B
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 20:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1001C232EB
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10317C236;
	Fri, 26 Jul 2024 18:12:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1912E633;
	Fri, 26 Jul 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017565; cv=none; b=ak9usFDqlP5MO4U3rr1nSMTOWpF35fum06vmNzR6gKuDmX58BLoKWv/X9t5hJjn+rPSIXmXPyetM5/fGXXImsUQtBd098/J8Xd/FtEbkb8RNLY0yXDF3ADuGR5srb0cB5hOSo/iuQ154mOj23TTKeaeMxtQj4nqHqNgklxb8aKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017565; c=relaxed/simple;
	bh=msXhPBFDvzZuVhoI1C0PLzJit0dqtfJ3wu/wvv66kkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBBm8kOhH0YbQrn2dB7yS+doRMTYFxucVZZeONLlJtJ8MuxXsaAbBK3XVmeZQWxzDNNv/VxtPypyvk5Qo4BsE5lMZksSvSItJM/lcy2HUVUOHaIKbxw8kJaQIJ0DbrPI7QyHbmlxOikfbIdREL9MYGDCNh+5MtlSW5gSSpj/fTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CD4E61C00AD; Fri, 26 Jul 2024 20:12:41 +0200 (CEST)
Date: Fri, 26 Jul 2024 20:12:41 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 4.19 00/32] 4.19.319-rc2 review
Message-ID: <ZqPnGVVBdpkNhCV3@duo.ucw.cz>
References: <20240726070533.519347705@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NMMmQsNv5h++zohk"
Content-Disposition: inline
In-Reply-To: <20240726070533.519347705@linuxfoundation.org>


--NMMmQsNv5h++zohk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 4.19.319 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NMMmQsNv5h++zohk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZqPnGQAKCRAw5/Bqldv6
8v2iAKCMDY9LUbO27hITN4+rATK123v/JwCfY3do+diwNwH1PkOXpQBFyg6Htyo=
=UWUC
-----END PGP SIGNATURE-----

--NMMmQsNv5h++zohk--

