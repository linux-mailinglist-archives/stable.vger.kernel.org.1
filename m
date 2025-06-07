Return-Path: <stable+bounces-151834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C166AD0D26
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA071895702
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 11:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD3E221F00;
	Sat,  7 Jun 2025 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="AmN7JHt+"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C999D22127C;
	Sat,  7 Jun 2025 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749296569; cv=none; b=JgGye++lZ+s+Hss7aUGmM0c2BxpfLOOz+r//T84V6rhOH8hAaLwFWh6hScF+170TcYH4UsYbbEMPMO7/SIf0Aa7R5FinVRizemrQCHgDeKiEcwTobso1DznDSZ/JlENHz7+tZpwceyDitNziWSIvD7e8Z1rXR9E9gKQZEV5Hjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749296569; c=relaxed/simple;
	bh=A5VFj1e+xpbR6SHxeq2NDLvtJFEJtEFEkt742n8/blA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qqc6+Jao4gyEynBCl0jGsaxn/PfcwDQLD0hNeCRfnanNXPgXhMgV8BzVQmuUSTsm0IgmtfW8kgZ58O9lkpo9zU55LwWy/43RxKjCwVDwm0KG+V2Ei3fq6Cdxt8Ri+/1eXkOrbk1BSf7MKio9ot2aZ1x8+X+KZWUDlxHxTvd0Jzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=AmN7JHt+; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1749296556; x=1749901356; i=christian@heusel.eu;
	bh=gIYlZ50mxQXGvz6F133XjL9sWrBBVbI6DqKQT9SVqnQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AmN7JHt+lD9gR+HbnxcvzEEPnmvqzYThb64z7YFQ7dvCdQfv/yHK1qpyFBLFf3ee
	 O5moNS22r1z6viKbzYvu1X9heiB6fCbQ/ILHoeigq7SYBd51ZQWJHrMLr5c1YRB77
	 klj/cB0nOndqQXlQcqNsVqsCw70iK5pRlk+rIQXMxO2phMAzy7oK1AoO1OLveOF/t
	 9jjrHnBDtfpAC0P5fENE2Xkmqxp8OCodYL5ojD5hbn5ltJ/s5kv52VWoaXm2DAoQF
	 bxuSpCU0xRk9e55o4OaU1KFa/Vve0i8199HVZokUfQed6zcFShY0kCuBNYMFMPGQ3
	 AWk7E5xWVh/SaAUnFA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.37]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McGxG-1uyJ9j41yW-00hj8d; Sat, 07 Jun 2025 13:42:36 +0200
Date: Sat, 7 Jun 2025 13:42:32 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
Message-ID: <d8e69fb7-fd1f-46b4-8031-13ab23ed8226@heusel.eu>
References: <20250607100719.711372213@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jj753swazz7l7vzc"
Content-Disposition: inline
In-Reply-To: <20250607100719.711372213@linuxfoundation.org>
X-Provags-ID: V03:K1:yI7xnS0BEN970P6M2FWovJNt5Pig2NzeKXfDXnoS3GKC7ItLPaX
 QJfvdk8lbsrZAJ0mb4ZKFT7G0F2fDkBuwSKl8aTO8pO3UIkC+X9PkKbTanHZT6QrEi0P+TM
 u5e/ccnbxAjHRHP4IKXlc4ORbNQaq69yTDHvfZYZikwuvUH71r5eat5virwC2fzgFBOZY/X
 ixH276Q4UfU6ROFWPW5Lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/R9EqnYZTZE=;iNdiJhF9PNlT/qwNpY2FcgxQbze
 SHk9SaopC14c4gsChEJ4BrgUkx1eHaY9jho4k46GtUr7yF+zAauDwSIShYG9pyDZ9zxbgf9Mg
 2XWjeuiJfelpGIAAVIbEXRL/d1YGVJTFNISWi/sw7Ctl5dWd5RW45aLcxIEyU6kxqQ6GjRwsc
 LNuqmkKYOf4qgp9gcW3FxIhbAErbMJE55FVgxefY9HwzKKuVOSdnEHSmEp5cgK5dllC5lrF+4
 j5SlF3p5NFLwmPOvp2XeB8KmrVv3RoTaFdNKi2wCAzCcEPnRxE4lE/VAk4dodMknlCsJf0pzy
 SSDYn7J/cqnhwOCgx4SS00o9DkFP1lROLBm0TVtj0ejzAhyvqj/UVvx8sF7FsEzl6hScP7cW/
 fXX7ZDSPTRPapyPI1ZUl7KGJZezjSzSGGLgoFgqWzqqlh1FVKcvhiTxrgzr1zpyUe8ouRKrpM
 lEyWctR6TzD0K1n2SoMpZaB25K6mT0paJ5GiicDnmDr7hT81Rtx3YTY1AlVRGlqdFMD+1f5H1
 lmuYlPXKO0Tx1RxxPFHa8o9cfEY/hCLkb4qzBWiemlzASK7vkOdnv8BbYXTJ14LQDxayjyuHb
 XNtfZuPbxJQaPhuFAZtiLhG2svqjNxq/ofURcUCyVkD2tJYC5l6UHvSQgXNas0/9sZnJrsX7C
 oIdLOJNDubH4kMp7dnxcrd+v3yk8bShkZAM5XDuceYvd0nlqrx79I0rgnJhT+O/ScpoLHZQqx
 gNh0sFHbg7QhTFsbnWQ5xl/+jS0TWy71UsqMa0PJrAn/MlrBrdgXjThpf73mh5vBn7skSt2pC
 f1qnIMX5AB+SRmJA+b5aDj0LuWWlqHzT4Fa3Tn60dJpe/HtgdgYKuPy1VAd8uoiSjIE1lr7sC
 nsfFBdcA5wSFe/Yo34GgESf4tVRANIBe6dFh/rLfmrbkMXMNggvSLvMWeGmXP3u6+GL+2rpDP
 55o262zb23kjPNBEZudHuFN/bSKvkQ2/t3olmAsm3TIBrvRZ7veqvCxeczHXhzDooQ0H5jZdz
 QgiOR3nMF4Qz/FW+CI+Bk2b88X6yOwbwDgqVCZoX3haa4QScMKnYBe7dlphKNB49p4LWdnAlv
 /1vWNGmDSe8qGefenkqg5GThN+7dsXtqt92S2PQBsQdGyn9rpfWoT9Y+6ZVmesJYpQbmcsY6j
 O8T6af8FLgKRo7NyPNdWo2jZo5LdajBlXLC8dmK5kATCvVko+KZGf+drPqqvpbq00vYcABxKS
 tR4adA1UVAws6XxgJu5rdbv1EN3SUjWJyifiIEOTMsxTkt/2As5MCdpF3uj5+xgouooiEboDt
 UATcw8A3u150+iiTl3ReJzV6GTzrEJd9NvT3zqb9WHUOUQdB0GC5VdXDOLSeaj3MpVHyMHkmi
 eOAp7PJhUyZg30/OxByzlgPYaAUdbRLmCW9+SR/JNF614v+GoZsO/zpLmv


--jj753swazz7l7vzc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 00/34] 6.15.2-rc1 review
MIME-Version: 1.0

On 25/06/07 12:07PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Mon, 09 Jun 2025 10:07:05 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--jj753swazz7l7vzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmhEJagACgkQwEfU8yi1
JYVRIhAA0CHQq5ZUUCu6jIrBj6sVfnhYzkuiFjknop83PudJOunnfoxJOE2sw/Yj
LbbFLGSaaKp1v2ZHLVL2pQ+rZgUeE4oUPmk4PUGuopir+PTpQkucmCuj/kvt4oiv
JS0/wU5I20MAQ0/5BWto7MJPcaaLv+b8DJTyiQviGK6HGm9E+mEHaal/z9ID1ush
ksFcjHzx52dbF/CZdM+tPy/9BAtNfxUWHb72KHbpnibJN+711thoLXWi6LMEQRyt
QJB57RglQj4mTLouffN3TVS1DW9dNE8LHswpwv0RodBuAKv9vmA4TrK8zusw2fvg
YDKvOPm9Lfwm6RaX8IzzxlLcbzmw87D1PepPFzPOI7Gta206KwU9Geak7Y3bm4RR
UgTVPhkAX+ufeHPRyDrw+XwzG3SgxUnhg12G7BR+Q90ZWdM081/7jZvc8KJxXrAS
+vKto2PlUCUoDxtM8KhkD6fkEVwNaLWY2Y69G1MK6weDn/m1VXoJTIX2kgHxtE/K
Prec1aIOqh1Cm7AGv4vdcyCvAJn3viHRmHCCskS5vSLDqdWZFnhTmFeqFMGKZcdQ
rp154zC6sTu7hhnLzrIVUxmZrWw9tOtx1X+r9IIcxtkO4jbzjVIBiXBHKL0kMlgp
IWWtC5lo4Jb3nqjSfzpSeH0Ulel3AUoYXnHz2jdtz1LYKH4D/OM=
=ubGG
-----END PGP SIGNATURE-----

--jj753swazz7l7vzc--

