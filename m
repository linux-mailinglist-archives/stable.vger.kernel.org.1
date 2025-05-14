Return-Path: <stable+bounces-144336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B82AB6539
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5938218900F4
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36DB219A90;
	Wed, 14 May 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="rcbke93f"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86C2153C1;
	Wed, 14 May 2025 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209918; cv=none; b=foXzIus6XCPD4IBNVwmD6iZq1+Eu8RxL/PDDAJBC34Q4x71+4igl/PQuHY6A/z3gCXOZGC1VlPxNZNiaJ7OSxjhZKNWpMRYtquaT7ETM1uxvl2EIDw0QxZdOiE+A8ZTkHVF9QzOPFacIdQgkHwv4gG8PDihqJIS5r9qfJzJm2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209918; c=relaxed/simple;
	bh=D8OQaUiF9ozJCoauKAS5nZUGADoLflOKv0y58rOk+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9yIvhW8jeYQTfoFHL41j/Slt319fs640Up+TWh1hAZ0KLP3ZH0woswxr7/i7T2RUt72RvL6jWlcXjwAqsxdDijfBFDoEY2sw6vrcmBRsuigu9eZMKtq/wN07c/c3V+cKPag941S3vbiEjMCOHa9Hr5McGRX6yvR+EX23bILl+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=rcbke93f; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1747209908; x=1747814708; i=christian@heusel.eu;
	bh=haYVFLZs9fBtTp6OIgr3UBDWUsGQCSa/8Q+bRYFMm/A=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rcbke93f93yJ9spk7Hu5gzEVXH41q/TVL+D5v8J9PFGiLIHGmRsMrkQ7OGx8PZWT
	 YZ9m1lFrGkKaHKCoZqglIJ6WGu30OyngVyoaA9mhADOAWDpWOz0h7JSx0/Pba6EHh
	 eTrwC5iF5kYYL1o91ycbdDHQ20TQA/mJDkDdKtKpuXi9Yx4aW0PCiM6ARorrwJgn5
	 1EwcehH/p49TNZuG589ntsnKEpja4MFMQkoznvdHhVs7xIMndUfiJpXMbjmzrUTUJ
	 iSv7ndasdog+AUMm9wQ1qwISUtJmPSCkSb8DybyGRe84RK4Z36Xejp5ix+Dlf+0yc
	 WY5RphMvYssUmUDrcQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([129.206.223.183]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mduym-1untjN3pBe-00iwMd; Wed, 14 May 2025 09:50:16 +0200
Date: Wed, 14 May 2025 09:50:11 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
Message-ID: <e15c1189-ca41-4fff-a5e2-1faf3f5cd737@heusel.eu>
References: <20250512172044.326436266@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eoa2746jorp77t5c"
Content-Disposition: inline
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>
X-Provags-ID: V03:K1:gbXT6haEMcQAe/Lfo1+KLm1ogB12H+n9UXmN+ULdOH/2kRFYhW5
 n1oBn7xZxRSTxpmQzmCBX9hFEcs/945/RmYsNUyCsDh+rRJoM3cgkX/dJT3+4xYgCA5WJEN
 WFOYEInNLHXWAJmsIckqaPzDwVn0bjHQPISCrii92+mUrh7cm7ENRqeKjnRMX0eVBU61gEe
 ARyvDf3+cG1Y65Ux1Uj9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+A8uhVPbaCA=;x6zyvJkm7XE3ZmYPx7D3MEEBBLJ
 DeJPn92dvjhPW+ACPGyD91LS/YZ81/M/rm+GgPqRDiERfAu/s/OKg8Fohs8Dlfzs9ZDMZbmMe
 fvOKRX+gkJ8zSfBsNpw+lCqEHLE9Wsg0eGb6to2Sj7c2jNqbOlRCU5/rBNUobZ130a/I+7kKh
 UVkmZm0icV3VN2VUR99G65Erm9IVNVRtxOWb9zkxkZ5r46ZZ9HwR4axQ2itFHpX8g43MYW7Mj
 p0r4dcjL2XtJHUPTzRwvpoiXDGiUfP5T4MFXCfXn0DiyXqy1s8dvNGEhMGytdwjBBQYKoP4sI
 Pm7CPkVto+/SXiSJP6nDSyGxaM+NkYKDHs2nVsLBsBXKtAwFq3wK1f7DKsO+bFT02cocNGf7C
 6Kx/K0LruSowmhsjf1TS8syXoSEn3VG/tvzDL0NFy8ZuQbMNGblqBrs3gevQ7H/ZkkB/WPXQd
 qSDpbo95DaVfWRzhuzMtvVp68vHSDG8hJRQXpgFyXM23PkVjUoTJVIhuuH4XTdrbiri84/0Q9
 nsGlwuFX+xe6S+BZFCJgdIkSt+kcXVXwQWfTaTm8jW64AxIHzTlnKXeV1heSXMYijD27Q+7M3
 w5xyfSQ0NJImzIdgUi2MCVww2GKaiAHYN3cD9sfzp30MamLF7Qg7GdpjoTaEcijw4GK5jS7Pm
 7pOUMrGnbsOH/Vr4iCYs+Roby03eiYh0OttnBFSm8g+64Ej1vSooAN+7/aBCA2CGVZKOxtN9D
 wnpzQ59BIrYzYqhCI9Yo2/7MbiVuGcL/V32pbZlwxZ0m3QnkmOA2oVMDuFcXyxfbaFtGymKET
 BULId3FTzdK1bY8/lKJCGUtKdDEDafrf/krBYAij4tDidZr4sXLXMC8vGp5G47bjb/N6W+Qfw
 rQgAw8wy38WfReSx6a8MPuNBLxEmK/fCS9yU+bByuT416pJXfOv7/eafgjFGzrZFIerPqJH3Q
 YlWvkcFLutqXMOwXcH+BT/Ll648ZfqJDu6kURsl2L8tb3m1T2R9o2oBZ+UxAUo4h6t6ixSZ7q
 JzQylnGsgLtSLpRhzRSvvJHbYXHMGQY99KKZMDEcpZ8K7UGONQqvRBnqzhGYcR14ck33bwn8z
 xPnq1S9duNLrVSKGk/AL0ZDjgnD6zwEkYxFWgP8AS6Y+dDGis0H2RSeaew1opay8g7KcwRQ7o
 bwr4RFi0p0qY6G2bS+ei2FPan5UAebHP6Zw+bxkjyCb6ZzI3hbEjWSg8xpC83sSTVQyighmL8
 i2xq5z0X3jRHytOyxFrM3fZaHN3QzakD2uorJge1gRqepoPntJPNf0RS8PPEaLmTgKlfuq0Ap
 CAQPqV5h11leWlHrkSikhW1R6UzibfsRCnV977xuWeuKHGt14sm/QXrV31ac0WQ2QCOTdGXmV
 FMHkISGVLiULOj0rVd2/lNlXCLhNKmNVBGofj7c63yiRQmlK4yrscPyWFdyg0FPDV2Lqn8lEa
 xR3I4uw==


--eoa2746jorp77t5c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
MIME-Version: 1.0

On 25/05/12 07:37PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.

As it turns out my [previous concern][0] was just about a bit too noisy
logging facility you can add my

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

[0]: https://lore.kernel.org/all/32c592ea-0afd-4753-a81d-73021b8e193c@heuse=
l.eu

--eoa2746jorp77t5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmgkSzMACgkQwEfU8yi1
JYUNOg//WRqjquS5bV7IYbM6vdnKVi7bESIe2ce4jguJp17CZQ3+FxOvQW0jYsi3
cgMojZOmhWh8xby1gm4tEondsgw3SNdRY1fE8ciGUIKrJVfh3PCdRzxJFSLiXky8
E/5gP4cNFasaa4gHrc46Z3/4VwcMfnCzCvPrS4O+tS78ubpV9GrY3znM+nsKNGPP
qOeTv91Jgo6akiS8m6PbdwvfJkBvAOOm2fzC4mLuqe1QJPuEoF5UHP207H+2hQa5
bpVvc3Jelxrwfc/D55dd8PGoPua26IdeF46l7GHB9CBWTYjz7IdI25xnfLYo1ZC/
W9T9G1IXj51KP0iv67J8tdmopy8Kc/5UzggQi+4np3nEBXjotO1gyzJqLck/QbY9
fBuagLNdrBxtgK7vPAXCrJ+HsV/Cb2hP9bUKlZa2Ft6bArIfiewCH8quNIKOlIAk
frLpfB9nAm1U3YaKXCgCV8ZpUiZnTr+mzsZUePc7qoaIaPbXb6IvMzjmsWOGfFud
ksoGdlkmYVlYCj5G/uHYEq5K52mgNDSu9SMiG4ltpGpFy2meDWkqRpu9U/5fasJr
LCmCRPgIzy29vL7Ap+Ey9io/wY6st+im8XngqWAn2x5EMBXsgA9RAtrDHtdh2Qre
0q4G6An0AeqhMfp0jOxlj6BPiOiS8RfYsZzpznk35TMe+Qo7tRU=
=kIOH
-----END PGP SIGNATURE-----

--eoa2746jorp77t5c--

