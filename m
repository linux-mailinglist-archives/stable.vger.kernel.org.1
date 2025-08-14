Return-Path: <stable+bounces-169525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE2AB262D6
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 12:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDE35E1528
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 10:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61427306D31;
	Thu, 14 Aug 2025 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="k3qygb7n"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5E305E3C;
	Thu, 14 Aug 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167162; cv=none; b=IqXCdERFPVwzjq/rPkV0xLlLSooMTziIEPn616nz0iDjHGlPl4nOeGBdOwIdbNcWfZF5e2UmQdbqLxWlbdfSoTxY0NzAEEForxup1kYO03MlMjNhEjdCuzuSA5Wf3OQfD66bRGYJ9N3S4u/HyZKA8IQvJ8bwj+3lhkTG6cZQh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167162; c=relaxed/simple;
	bh=a8nJWGrKgjaDQrULPZIHosDNKPSDFC4N/Axl41KsowY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+hSEk7oiftYU4wFCeEX+xAUIVr5ldhn3lkBUNkDyeeQ4Tr4bxT04ifPP53WjLsHR9FqeAWRikJpZmlAOnojJ62wklhiKvlO/RJ7SbK5atk2UiSjT1cEBeeUTvXJIOPHOPmASkarDa+vCKxSkB0yHm2YzyKdMoWtNYRFzLoVKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=k3qygb7n; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1755167119; x=1755771919; i=christian@heusel.eu;
	bh=GoIHizLFJF6SJrp0Z0/G61o1a6vfrBG25gjN1/LQrZw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=k3qygb7nkAB1bLqqiURFlvapBcCeAHoe6T9OGT3HO5fHQkqGsv6/F+QWWgqj5b28
	 re64wp5XZUVd1WYpLOZ38D28qIIaLVUeSfvsgxUf6HLcBLNhXaN5rW19yIxeqpF/w
	 QvWW3zoHKR5y0c0IF1NlXas7pr1q4K8eVfx+RK/ChN2M+bsEvbkHBUegoxojPpmMu
	 2HNkk9PhwAqXjhPWZCTWBWvU2v4YrmhXhMDpHjNq/gJIa7CljcqU6g8IkgbDw8gdu
	 9dxkxYlE8vfr6I1h0IcnuHX4F3kFs/Ns8ZIqhOsFlJyw5Y0psKzkDWzx2S1uay4aO
	 6Ei7Q+Sbv89ArbBjHg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([147.142.166.140]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MryCb-1uG8sd3WU9-00gQio; Thu, 14 Aug 2025 12:25:18 +0200
Date: Thu, 14 Aug 2025 12:25:16 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <3641f985-9a0f-4cd2-8c0a-62c81f372b33@heusel.eu>
References: <20250812173419.303046420@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="psqisqcmbrlofjwt"
Content-Disposition: inline
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
X-Provags-ID: V03:K1:5FKFck/tbvqqUq06Xdda52whjUXiDXIPAKvgy8Jlhs9lUtyF7dL
 sGEHMawhdOGnbvepSsSFX7zSsndP+GVTX4GjupmKnTT26q9e7uBufUq9DXu6wTGO+GGF7Y1
 BD1mDhZoj5Qw5z76/a4LIpD4CQuACxbKRlUptBxSQ3M7XgP1xOH556Ap7iq2L4nxTxaffT5
 pYXRfwAGL4Dm5OWBU0syg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zhjXs2MPWws=;eu+QXNauRJ06V9+zb1CMbEfGC3t
 2+gxURnl8ybBsc+gYBv3kfXdYUAsDgv3dlEIQAx26TBHoR6WTUwK9UwE90zD+s/wevPoYYdvL
 RMYUKxEg+MRK+qv7pECEsrcj+KmU6wNq2ORUhg5o4lc/m1KRW9dQJgmQV+M+cxcLBGpL8mtkL
 SlgLmcmLSItk9EynCB/PJkGznq8EOsr0/T7/orJ49xl6wL1h7X9+tvxH4Tguh7Q6nculcGgjv
 8d8EDST1eTrMKcBwkYxn3gWaZj3xjNFZG8WezmSpQ2+X7qlDa++++eEmI2hqQns/MNudT2Vle
 KYnvy95A2fFCexty9J/4Wkt/WzwVWfoCXbpitbBS58fxhJLaRqSJSK3RL7XlG2pwdm8jWybxw
 TJljozncxyqM1MlT1HyyTqj7tU5wJ+1fiu6T8ux+pInVPmQ+eniAdkByvrzYcZoj1uCrp5A5d
 oa/Y12k8qHjpBtNQ6uKUDn+FEnRagUa+0hVZbe9N9DleEXU5aF1XFEJIMl01udxaX/L3Dol9R
 +wlHXDb5OWQxpTwcu7Np+Q7ZZCN24kiwYk+Did/8qh7xEWnwc2tzVC/gwpg1WsvKdwNiHRMZV
 JrVP9q9wJdKV0FYjffYMp/lQPAIDKgQ1+2LwEvM1h531NapVDhQClJ9psSqKxM3HNma0jB3ff
 2OsjEULt9Q1svIjQ7SD9K8lpyyu0ISayBz0eADI2ahWNwGpyZ6nKDG1KUOndfunR8Oo5Q9W/7
 HjMchKFgz6eWl52E1xtIMf/NvunLe3cgffIhqm+RYQ2oe0ZgYVznaOrQRbiTfonOklMfcDrXP
 pc7vlQtDZkaqN49kiDdG65i8kVinlLmfWab5R7tjlGfOENGFd9bb1Z/jUUvE6h5eaW2jUNDhO
 tOAfK3YhUkpci5F0YcARIrUf77jtpnVL6fxKmPkF6OdyovanH7fFsglaajW6CrNFz/qwUcXMx
 rhPP1MPSg9mUY5fwfqG/ZlQL8ROovmc3VGf2rRXwDpLT7rVRUgEvIDgQAIg8Z6jwfCQ6J5u8o
 DnElxgr2t+8cJFyO+jdm3YxLNiWiTOiVY8XSXi1VtZlpgOREmQnhChT9Jg9ImN6lRst+pWJ6t
 JDKPYu1IoL6OGKXfnGd1DJxu4TLytli30wJzjlOyupNi+42Gos+LjYEgybiLJ8d9STF/Rgy+k
 eQ9d2gtQ0LPsPWn6rxAem0gMkqnvfhikc/JReqWEKC1FQcOGyLXZ3fFPZkeFfPcDYwlRpXWVS
 dxLjn8w+oPAIz+LGTJqt6xtnkSb5V1FHUmFyoY4Jv/2Ajdblk/00gVAotSkHdFUJpdycTX2Xb
 yBUkDFvbViMtIBAZPCfvtyFjPY70whFs3jn6PlQ5Ot4a7l3nRcLZxMdbKsQXpRUFicDaRvG6I
 bPlDjuSH26AnSLMMeWF4uMv/Vjq699sUScbiFcvQgKPfGahEKvl8XgbZH3zDMy3oZlEK2t8CG
 eap1YUh/1Ho5ZkqpGAcRNNmqVzJj6ejKqXkuym3LfV5/FuXXkjLoFBqVBORpTkfG7NKX3gobw
 mrfLQRV4nSzxxzo1e+YVN6Zwolxgae40x0+8hweMY/p8X5yFP4UwDwpdxy1w/LfIZaTV8TXTJ
 K8yfVd3uS6x+jcq6v9/Y5BsjbrBL6KY1Tiyq///Ag8t6GFsvRobOWB4WgDexDCHJ1CI9PBE/e
 32YoUxZoGLM07Xo4GObX0Y


--psqisqcmbrlofjwt
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
MIME-Version: 1.0

On 25/08/12 07:24PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.
>=20

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on the following hardware:

* a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU
* a Framework Laptop with a Ryzen AI 5 340=20
* a Framework Desktop

--psqisqcmbrlofjwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmiduYwACgkQwEfU8yi1
JYVL+BAA5WZ9NSOEFQSxZIxrV+iRxPDiRDZlg9xGG1KdVjm9sr+8yLcWwkjLv5m+
Xh+/7Mi1pFA7TXpuwhRTqBRHwp00JJLPb9reA6objvItikrPud0N/NxF9zbbutvv
6UuoUF1/jtVQ3aZH5bhvTfjj8GUrhvJtiT0zevrznM2WDoLGMxdNm6AAxqmYPsr7
1e0UdW3/dKrPU1kn3NdKWp08phJEtlyzNuIpBAsoTfJDe8eEpQbKgfFF/8Kix7Ep
sFMnjoA4FcS+EfA1rNhuFGWSuxUSVDRoJCBkjtBZDrwJwrTiTyKWIZxyhBJG3GF9
Ec46wASsgep9voFreOZPmsn4WT2CmcAQtXJ5TBufcJOXP8JL0gcovLew3O1YRKAI
+iEiuyqZSsq4ORVK/P3giqacKFy+bewZWkwuMWLxoTQkaOi6C1NzJrnj6EzdBbgx
u7CJMb3VokIb6r4IXB0gBTxKTrqPIle+ENr5YDbC7CBmG9hCYkMNAPyNSWW3EXo/
Dd4SqENXi8rtC9gDf4pTeuLJxFH15O+jqZEfp/C92Z1X6AThRFTCnD+jIYYO2WEY
AwGTl07CuE+x6qyy+MEEEOq7c3t5v+IHqSzCW+Xi0ivvblakXwD3pDTKphS3q4jx
cBcjc5R3f3VaGFjPeLcLaC/3HaXZJcG9CvL9W14HQ3f2cXi7CG4=
=tthR
-----END PGP SIGNATURE-----

--psqisqcmbrlofjwt--

