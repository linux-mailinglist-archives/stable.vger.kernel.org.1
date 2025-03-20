Return-Path: <stable+bounces-125689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8DDA6AE42
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 20:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851C67AE2A9
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B682288E3;
	Thu, 20 Mar 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="szANa/5a"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6D1C5F2C;
	Thu, 20 Mar 2025 19:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742497799; cv=none; b=WijRL1EH5GUUj1Lc91fTbc1bVc0hGLhk5284fLQXReiRG2wySgm9DyXqv93xV+IGqyAqMIG2F7f2Nr/P10AZ2OUfMZHnGGocsw/6Wnljdp43nDNTlwzLQojsbMkJy2YQB5CBYh0KxbfNoGtOeyIk5NOj2PbUHtAQ59iz7vyEWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742497799; c=relaxed/simple;
	bh=TJPs+6wmIiv7YBBthqS5uAj/EfP7DIgfa/FVnOx9cNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK2Irm6RplW1R7IoAnOQ+Rh4KEnH24H2hCKk6YqDkNeAuLKHiXgCY20SQ9K60BpF7iDB4CUTrqcD2PFwT8lh6cIzkdDF+Zb0lsGC3kItzPMumniNRdA5tcag9dDQkQBBXoV/rvnaZxphV81BKsE/nIjBOOqdvE/NFxnFiZ4mkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=szANa/5a; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1742497781; x=1743102581; i=christian@heusel.eu;
	bh=dN7Ji6DtQjkkoXTgLs8+LwmmvBuvr5b2CCS+MInyr4Y=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=szANa/5a4iwCELE7d7JBQQ+CAv+YgAtp0WSb1Sqy8g7vzScFAXT+GWhzOFExSuN0
	 /LpryzDxAM3H/drbOTPjHJTpjgivzSFfd1u/pAfdayYatovznivPq8AhsOV8NmtnN
	 fxuDziye6eTRQXuwvlb4Mdnc99C2r4u5Zba9b/bx9MdxijOWR2EzTviyG9KZ0i8Fh
	 l6wlvH1eDSm0ZWdkQreEHLrSxIO0hIM43vFNYKpEBgzD5KTqepggh29+NTBEUO+bc
	 Az++cktr78peXvwAbb5CWKfI04mo4WOekLj/7YjU1UMqBjuoIKmLn+d+/bYivJf5H
	 JtnvMYGxytUZ6O6XNg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([147.142.150.221]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5mWp-1t7d7S0mXz-016eyf; Thu, 20 Mar 2025 19:54:49 +0100
Date: Thu, 20 Mar 2025 19:54:46 +0100
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
Message-ID: <7ab191ab-448f-476a-a54e-31113996b110@heusel.eu>
References: <20250319143027.685727358@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xw3vwn7ep3f4np5v"
Content-Disposition: inline
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
X-Provags-ID: V03:K1:qS2mWgbyy4p+6ATI4UNi8W2UsUcEoRtG63M2FiZ4bB/p3WEqOkD
 MFXP4hUkttdmZW+Kt8ApPjcvr1F58NOr4B53AOby9TcTVQybuP1zK337lRpSz3jDh+1MeUs
 6YYKwFqi5E3lJh22eBhMkj5YmYKQVjUyDLZSCwQ9VR/wylgVev8k80Dxc0ay4fuVQpUaLth
 8aobssraWGqkAe/kkQjaw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lNB/bmmMXEs=;MLmfs0EPjz6VTOr6arRdkm2iOZf
 0u52w5A2WbnIGiIO/htPgAhtp34rBmeJBjRDCLR1GJ+GVDxs1EQgHS+gZxYW6EgfyJzwoToL9
 ZOAu1r4BBZURZgrPOitVAKLvdMxD34GBRpv8HovQuRh5dTPyVmb88tRQWXlB7CWBlMtMAfVvD
 e/Kjtfsjp++kKTF5dhQyyT1kOpoZtIfYjJmlXvm96tjipnVoysS+n10NfppeKJfNsD8BC7RqY
 37bL5cRxbUPl11sIYXrkYubH+0ELs1EriFTxBGANCOxvPloGHN0k0NMUKrX5iJz5+LWv7Ugb1
 uMpb5SE2LTt+QL3mwEy907yQlkMScLdB1YqU7l59An136Hz69BjW3gX9L5vSsWOCUAnZ08XwT
 Z/ZXYEnW7lW+0aR8y/LKdCpQuuf871w+Idhf0jAak2y9KqwN5QZ8oaM+2w0ZGn91lDMS0SfSX
 vYlRNsOwJR+BKuGHoZN7GK8NI2d8G4iO3R7ZLN6gM2RBFoFek6rZ4EHoLtrKynAY6SV+zgBwZ
 uQj1X2oNzG4POSI6/of5A+bwUDqOq9L1HqsZm0NvvWMV5aOg8RA1Uf17iHeehLPDNPag5NgCV
 YV2FJ08RSSMSnWO47C/cxlvgiX8RnMkTJ4FNMAh2iOt8403ViuW9JCyVJyNY8ZpXl/0QOT9kF
 cg3ywCTMZ2ykeUd4p6n0+ok5NILs98xM7Lufot4okT2eNyByogBXAG9RzIi1SLl9WZB+bHJrl
 3/f8jcdKLJPHzl4oLik4esSV7vVMiEFhAsDD+uTNSZmFuHzNs9m5K/q/kbNvjY17lOU0fawSz
 FeKnJfVtWkzm9G+FACFT0FyItwrhMxfVgzS+EQTYz3WsKf4gnnEKEKjV3YQvBonDP9obRUHxX
 1GFBQrMqxTXWemdQz3L6lg6qnE5lNn7Zneoq1k1pJLBR4xBUNUbGnX2iOv191hWqMdfStm3rY
 OSMkZ0ea1YSWkyOQKj09Iass8EdDCU+mTpJGoPUMytaJzYYfVaneXO+e3p4M+VjHDI2xqloOD
 6ATaFb3mDP6j0QIoF5I/rrBuHZwpNj+oF4vNSd9qEDx9HKAerHCh37KD/tBp1gziyf8Y4x+FX
 Ffk00z5iCpzc0ycfdSkw/tBFzbJmiZdDjjc07NZUwaoii+r9z2FhpWMd6YLabQp73SKkdEd2O
 TlKI7GBtaDPyQJ1ytcfxz9J2NzkCztMZmx5USP6DKqPjc4aAjTdwNp/zOOW1KERrxNPkw7yG0
 RdpZr2pwCSx1hm3S0J59Zhbs3EBMzL+q63tIGA2rY8hebJ3PtRDCHs8Tea2U1don3pWd3OtRl
 JZwuO3Tf85QGN9n8qquHAlDUDK1O1yWE03dqKKcalBk6UEK8InvVkocKJYoi7PbgWmmYefzgo
 L5hLx8Kq2hiS2gGt0cvaoEBRa8kRnMkS2cFY8=


--xw3vwn7ep3f4np5v
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
MIME-Version: 1.0

On 25/03/19 07:27AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU, on the
Steam Deck (LCD variant) aswell as the Framework Desktop.

--xw3vwn7ep3f4np5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmfcZHYACgkQwEfU8yi1
JYV7ExAAsTcCSYipslyJJfjqj46cseSWoEVf/H3DawpIPeCrTX0vp284cL2uRz7n
6KHXAWp0KP3hSxXo5i/NyPhQ5SZus8BNYkbKmkMSUciC/vrTY9b5PrnQ//mndhUa
luM5yE6SAShkbl69LuMIxr8Jg9+/Lzk6HYdLeiOE+dvy/tR6izcKEhrulDn08qCD
qrIGMYGlvTNtAKrrwQYnHqBOv3akXUtXv8xrdoa5e7XeyArFbIXwU1wTJllLaevn
UQdAOjRD7PKAQYLV0HA6iY0Uic1yICZ2kEueSgfn7iEuvkijeS2rXLjynoev5YSA
J9LNHY7UQTQVzVyvRr72TmodRUwLFsETRwpYqPbhj37p7tYVfSV+YCHoEfI65IgS
LkMlZe0QdH8ywSsGbBs3chPcrA+y/bKeJ4pzSnuLLBOcrZPwK6qcxm9nQGcFMqu+
LmC3BxekambG6f+B4rF15vtuiK0QU1VlkJeFy5IGGJKSEDeQmqHmpbz+6i8AJplq
M9SfI6nmNyI0NNDiG7QtHYvnmD8Hcyst3Oiip+1gwfkN2WVn9v8vXiw1l3H4AcOZ
qAzA78xhnjZhpTN+WKPZNJVhQB0tdrpC0E6H7LSbeGh+3vS1WH5LrAhgCiRz/Zhy
uVfvQL+BJFJPn1AyVSXa6CYOMYKGHdQHghY0qOy1to1SkqxwJpk=
=ejVD
-----END PGP SIGNATURE-----

--xw3vwn7ep3f4np5v--

