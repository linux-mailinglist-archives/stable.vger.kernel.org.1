Return-Path: <stable+bounces-126795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E44A71F25
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C8D189850E
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 19:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88360253347;
	Wed, 26 Mar 2025 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="MonWK9k/"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0661253340;
	Wed, 26 Mar 2025 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743017293; cv=none; b=Vyv+yj/tXgTqihm4S8U+qplUwl891VWQiXR7XYk+z8um9vKwnCpYN/vjj83RltFrOaGJhO6P9JIfU3Q7DTQPiJkJAwRwK3xYVy78ftr980yAby/SHg48pOx3YhHBngNIP58SP816bAmA7XgyzkSTNM/j1kaKupfAN25FzZCOKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743017293; c=relaxed/simple;
	bh=qPuud6hQtUOpq0TI0kySy61SAsgR3IbvzwnPgGwUfOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT0FCIuvbuhmPZeuKmps9O8xr47fpIR0eTPJW2BrXCYsXXaQ+/3+iHjTRa6TlLvvELslE5uPMeGqaW70535n8W3hS/ki8sf5Pq1S7VSQ6ihK1jGNDhdgBY4IRcfjkujDH61r7VOVaPegcdhD6ANHLSO7izTM6Me8QFh2Yvka3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=MonWK9k/; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1743017282; x=1743622082; i=christian@heusel.eu;
	bh=cC0SZP7Q4aEIS3+NUzVkYwY2u4HQnTUh3X+v+jKFAgQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MonWK9k/1PAumiE9Z2jZeDQa10q4Am54K5UXjqinvtCWYGuo1Vzx2fCMKGIwitoS
	 HWCPM2oS1xpeVSpyBUElzSuH76oEVXdCgka0YdrHfYBkZTfRrK9uyFM4XD7w4xTFY
	 qg2Sqn/mZ0bYETN5TnUYmacl3eUPrxEUQPiDOVQmM/EGOGeejWe00Q99E1jt9BjGL
	 FFgqG0vnez/0BwCpTqYqXlCwDi9rgar3SPvB1RP2RelFn1l/RzpFLefjo6Kz/fVjl
	 aZK6DI8gnX+ZFx0Uk1+hhnecJBTlET4f9qViblTKfjDBJEpZbXr2lZ8xeFTfUFyWP
	 w0PKFl3rgfgI1q67Fg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.64.202]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8xsm-1u1M4k3Nqw-00Fyj0; Wed, 26 Mar 2025 20:21:36 +0100
Date: Wed, 26 Mar 2025 20:21:34 +0100
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/119] 6.13.9-rc1 review
Message-ID: <f2b079f7-d666-48c1-bfc9-0155dcc9b4a5@heusel.eu>
References: <20250325122149.058346343@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qrugcju3lf3vwyjc"
Content-Disposition: inline
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
X-Provags-ID: V03:K1:HpQe7Dut4b0aICmrtZlF2dG1x9jQ8/S/5haSr79leaLIkettg+9
 eI2bfciN7c2GW7ds+YwYouBbaS/4jGgagQSwKGuTCyBtF1+AwGxQDNW36oIlWDcA70uJwI9
 WFypvTi22lwsD9heSsYU01BRQfOE1e5MxVFrSwSK4hh0RbJCQIiMIuWt6t/SalEWdLOq56O
 Q5+3RdYZI+4VOvPuRNRXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W9n4chH9dQc=;Bn0KuvoPImKhPVdunsFnOE9+VmO
 UdaXA3sqHyXooaKge5snmAF6QxJaM4WuKYhWMBfI8HSHnphghQSttiY8Szh6n+KWabMPQMGt5
 7MjdbAztV8N2fWGuCSI/EOHpdpO/NThekqcHT1jlb5Ks95/iI+td8wKoOgTk/eOukVVpL4UCy
 PgsHpKz9ShYl23A17lVpsDO8+E9D1Yngg1r3bXiPXhrsNFTWSXBNYAgrzyYVqaMsA93A9uTyP
 ElcBbvmMDXgHwQF0usb3Qhq18nKUyNsAiiPDIiZOyg3lQ6CBhRDlZ2hyZBTy/sgmhQjUFGuPT
 z9z9gSc6JSDcKFmNv/R7Kuj/+3wvssw3K8gnSDYfWpLtBcHE14JOebHRSBP2XUP5posKKIS+T
 Yza5qnmnaQM96o9QWLZJAT/UWUqnG8D/M3MztPQg3EEYa4Y4ZVDXtRiIkTlHtvCN6VxZ5wiS4
 apdNh/5yBeQCoUPyzs4E/r+14HR+0OZpMsYsTPdRFuCPHxWSTSI1P3IPqILyU9aYzCHEcuu6N
 gGWrdLIbqmo7v/SSW7mRKIEGXmMBH0VuUY5aSSX5c5X6EgirXlj8ySnDw2lOz7dUyxoiFLqoy
 3PHPOyz+HEFfTO4RSD3v/NOgYOGxzzi80WXb/2bTUnu6CQ/JwxdkNjG9J+0mxU5wtLTqOmWqu
 MJBaQoKz3ZQnN7P3clsAux2VEuujzdpEV2LoUYORu3mKx3H3KoY2WghWThiaYNS1b4SScqMGW
 QY2T79uZVCquNgcMkxFFfj8RQWDz126XniYDxNJpW+4WmU5ADaJoC+LmhiDHiD1TfnlGEBeDR
 t1Dk7QX/a7mtcS7FeulHEhn8IFr5ZNSFUIWvqCr3135bUCvA0BRN9wCffakQfmW3n6g5kSm+v
 WlvGmkKjuOj3V2fTpO6Tqi1oCu1z3YbGta51ttxEwG0z6p0vJxvd8UzsLcvQiTW1XtO2QCkHi
 4yQ3HVoMf8bN9oXRwS17KtpKbBjM6sfVRYhEBUJirtosQ79AXpTMyAN+gZEUHATufcJQ5LYn+
 ao4u/bsR2ZGUuZVvESgPEXXTKJcZjib9vw/M5ez8cUCcq5gpZFYqs5tFLAZBUCwndxZWoSsoQ
 2pXpvOeNcIYWrSO2Fx9kJS7b3b+gICv4s4jEja+ldNuTmOiDghCo5wo3Qfc4NWA6FDMtqvtnY
 MYCA/Dt+wyj203z+/gwXeFYfy4ccawX7dYiK4wxF9gcPG7jDN1UXNhFR77tADO5OAkhK53lro
 oXEjc+u74lUBZ3KPGVMy7EsvT5/ciOAIfbfTZrT+OLObdqQ1h1pJitCyk8JBBGN26Tlo5PNVB
 wuirkJ5Zy3vKGeDHcAiFBa711XfGlJzhTakTTiDybUx7DhKm0hPqlV/LFbcAOWWxpP1L7ZLUz
 H52ttxLXR8zb1vv0qkrXdk4QUryP0RjarxEKg=


--qrugcju3lf3vwyjc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.13 000/119] 6.13.9-rc1 review
MIME-Version: 1.0

On 25/03/25 08:20AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.9 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--qrugcju3lf3vwyjc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmfkU74ACgkQwEfU8yi1
JYXu9g//R27iUOFq4JnHuIVIxt0JYN/uwQZwLB+hUTkCU00fal/OOKai9pRfG1HM
mZRj2nC+e5spYiQ4104WsLP1ZvwRqPTNZ6nzzGTW65F3ejZADNoJbBUA1C2yr9r0
R7nwQ3Cz0Vfi15JeSHnj5rSo2+OPf1hV6U6uJgk+7cF/vKiVkBw3VIWqEyPO5o1W
/zBQCTrmnIp8ksqWaR1wevSYuaC781d64RCaBHyfoRw/wuKdw/qCwmFut6knqx49
Rlr+5NSjz3eeWlK77zD5KBMTIzBdJLhlmylZn2IJoPx5lSPpIxVRfZdbXBodECSB
iRBaDqnQ83Kw9+U3sRae1zRwTHcDYAygSw9R3Ghjrbl9oLQ8Plc91RdMv5qsGGe8
4Ne+hdybWh9HvT2eeU0JP8UF1q24JqaDzQzJYWx0QSgItnG3Hrt9gv3AoyHzvCJg
sWvz3VSNnQ5HeYfjs7dppozgGFuGVpbitqIS4TPnIrm+jpGyOqt/LGM8FG1p3qKL
cqyFnv/LStdhtUrSFNLeeKlkHseIcgMzLmOHQ4LSog+TCMTR1PPghjc4G6Bu5/06
9HigW7KXcc4aQiQamKhR7HXlFTWHXmFytjCrZm6k78c/MyapvBqiAt4F3/3bEkC/
29Aimt0mPaFiNSKx6nmYE06urulqztt7J638Ja8h17WioT/uB4k=
=Fnl+
-----END PGP SIGNATURE-----

--qrugcju3lf3vwyjc--

