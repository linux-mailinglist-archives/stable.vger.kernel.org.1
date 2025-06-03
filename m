Return-Path: <stable+bounces-150687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2755ACC488
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3083A45D5
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3C1228CB5;
	Tue,  3 Jun 2025 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="mS97GP74"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CB2C3263;
	Tue,  3 Jun 2025 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947143; cv=none; b=cDEOzIQDJo3ul0Q1v77/LTrSJuHZgkR+oS0wXp5Jx6HL1nSUE2xVZu/iWZ+k43lAV5zdDJbnsEMeyKHBI5K6Up4yWykdPFQ54uTkKubp+DOdt2zuKirSdYHk5vRpF7K3iB5ZtmeD7oVrOAAQmOWGsaMl13r2ahM8NJ0mSV4tVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947143; c=relaxed/simple;
	bh=2WTULSlq4y83DGKPC7AHKb6p28e6UuN8McyZnKYnsz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVpMcGYsOaOdYpHfAas71W/nBwLNqE8rsSIyFU3EgK5BtlPmsvx9GHC/MBwWbjW1pRQwFvxUhG78wwn/DOttPur9ELRgWK6HAyf/wkA/iwJRiA7SLesIgXC9RmjQjn1cpJGyeU1u6Rx1tTSyLZ0SjS6xwDLg3l1E06lKqCh4++w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=mS97GP74; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1748947129; x=1749551929; i=christian@heusel.eu;
	bh=7DExoq4IcRMFVLKImoAzDlLPIEUfwpnpFpqkcpxpLOU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mS97GP74Jr+KJ8w0U2jPwUfkEQ7vk5FiXk/9tXYaLO8Oc7gUp+e18HG2bVa02/mI
	 h6zeffMvwAoWNMGD+mtR8LNmz/LoraUew/EWRHbOGMdsENmmOKJdaTxzraPylrMGP
	 xfFtaoyzXIZ8GQrxRSfRE0BB7JupaObFPMWRh2jjuiftFrn2Zb0Lv4/uK+Zpe1+F7
	 SxFF6DUp+wq5sv6hB2/n8x3bY4kITp/cR0tquZ1plQXWO8RpwoR6wuQMmEEi13tOP
	 SOIXg/Rmvx2lmV4LbrLGgPGqjbko4jCA6kwTWOuY0/nEopNifRfP8yQl6FgvRIQ4a
	 PEk/3D39lTMUd5/xfw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MZl1l-1uPPHf1QGt-00RktS; Tue, 03 Jun 2025 12:11:00 +0200
Date: Tue, 3 Jun 2025 12:10:58 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 00/49] 6.15.1-rc1 review
Message-ID: <c3c34e50-016e-47f3-b5fa-29ee8cb146cd@heusel.eu>
References: <20250602134237.940995114@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aldxyrjtrikulwfd"
Content-Disposition: inline
In-Reply-To: <20250602134237.940995114@linuxfoundation.org>
X-Provags-ID: V03:K1:VfXiSb9Ab4pbnBqt2pfBFfKbt3nmXeMkpST9Tk2NkdfkOjMrcnD
 eIxKTfoa1DRqZzpqSZAQywhs9dHwi6zCVzQxci5+qjkk1IMvb4JmLHUJ8t6TrVbNeZnAOkj
 O1M/M057zzHVTB6yWNqTGkIjROVjsml9FH2omvqSF/Z4LAftZ3ejjWrMkmLZw3RsKqRmn2/
 jPBgd3E8BjpL2kBJSEMNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pEC5FJEajmo=;kzkiThh53T8kRtYL9KaZzOKkG+h
 jNTxiZNidJRCUXSjDPLR2+ju1aCkgqAsdp2HDepwEKO2Td8LVcB+t1KBsaZW9X+6rgAEbsYOq
 VkavV16E55l7ZhJnzRSIMzs5MilWOxkl20s5I+OdZNZQoyGlgCnEW+MrdE+C/RZh8NCIsr7zZ
 c3MoMfBUezSXaDGKQkYdm5eL6upf9qWGPUX/7mFvK2tcsY3WqbfaspL86EgKer6G34zT+L1Uw
 7kCgv0Sx9Jq1gxEGw50StoZhiz7iSZZQhS1CMp4vSP0kOUb2QO7B+aDcyxIf0Zz9wDc0PLu5v
 LSijJj/cPFt62xsXbmFRqBViQnFYuT68ccuUMRRzB6v9g+C6Rz5T9LYQ73TQ4J3kCx/vQDNNo
 KeaZq/DOKOOinw8wINg9hCIBhNjC0+Ej/USaQTz4zZ1IQsHogBYTswmY6hh5j+GV11IrI2Esl
 Ov0dVY+mXW0HU+Lev19dp+yz2w/6qDabU67Pw6/tX3tHAOY/QNErPvwP0o98a8/LIrOpv/uSc
 zt6hcl589tuQTlD04vq9wXDo8sSbogdO0tb469oHR7jcXWM/DRiA+aTVuywDENA7cAwneQSxp
 4oB8TY2MOQivT3p0J0YYJvxU0ytBbRYzJG+VZdX8nvGpRQp6r5RwxNpWgJyqS9a3wo7t7wRof
 Udp87a0DdG/CQhqAIr3v+T87hq5xfKtPGIWfmxgyTWr7GisEJfDjKqgdVfE7IcIah3Rb/5dcG
 Tgn6e8X8T/zEgTfNTYj6pibZIVV9N9PWy3FVJDzVP7Kq2YhY7PUj+CM2lO3sdOxf65ztnVJJs
 IYAzbqBlldpmvJ7G5ns5K+hPX+FYlHEtJhvndkeonGqzcIl3YlUdOZtMT6hxhUiu1iVVO4MTW
 7s/xmXwu59GD7F4aMNIE5jtqORrghOpb/78FjyvQp2C5/Y4G4uUmh3BL3Gh2qdNhWe6yRbZ+d
 lrQNAi3xtXYcoatK/OfUzRHnWhNnClN0GW7wqoohFCBANGxFyB4pFUg2+zBtWbXuWZGSjPMoW
 xlz69iWslGJOAAAjqFguaW+qnY/zXe1jKpQrgl5ZmzCDg59XBiVhpingH4nulM3lcT1lWOAVL
 lX7hBFgjMmSk1723hloLztcUUzhUrfitQ0YNVo3jO6VJgl3lpc1dGBpyVi3VqTdrEi2wJt/R/
 KbFkQtilGwlUc70iDaPDOZSToa1fEY0qGuKJbynvdBB6IZ8wtU8YX+8pJWTt88qdslpKmAKC9
 5woozMXpOM3/um5d9uFEHccXtPS0EE1dEEhNBqJQNdvSNND3A2YgqiGsqj7aVuK6Omw7oAKkW
 OmBhGXdVn7i6PjLY7Ph1HvKyPXKAwo0Wg+rkIHMBFuoHliLiv7BKWehb4cbv83/Y2rsgMlKjR
 KzxIdjxqZ21xvm9uh4ZCN704+8HxtLToUmiUx80xHp2W6kXTco8HFu/d5TLt+6x+TxA0dy3nj
 UR7ws+YPG4F3jYmaOPXyYAEJ61FI=


--aldxyrjtrikulwfd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 00/49] 6.15.1-rc1 review
MIME-Version: 1.0

On 25/06/02 03:46PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
Steam Deck (LCD variant) aswell as a Framework Desktop.

--aldxyrjtrikulwfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmg+yjIACgkQwEfU8yi1
JYX7/w//TuYcN0nRos46KY4o1NWdqp2E3GfzTh4eMe0+4M6525aDb5rdmH9aSNjp
7gQJK4J/NIA+QTxJqfrGX4ObSSjUwoqyaJQdN5FrL+D+Xev3Am6j08Ts8c8EMt2x
jrUBFdzDyyTRyc9NS5ct1b6X0n017SHGng5KffmoRfAsk7lewAKdS5uIUbLTe6Du
viuJsZBMKrGwiTUIYh+AzGJVjyglIPI16wRmHktmTO+eRjAek5s6uSS3ZUwU+ajW
O2AFRT9kMQTUlwIxZGJGcIcJYY/AauYR8xD7jBY8hh/eUptY0Bpl+S+EV6GIC+5+
E+2GVyfDR0sH6aixeiwglA0LX7HiGrUkiGZmJw3kgp5ziXEeo96pp9dcO8VyZBXz
co2XY0KBvi/+wY+5FJQxVDuzPXasT5GKGAUFVGp5KHOxk+LIwpupJ9qNx3Bz+Dj1
/FB2vw7HirNbqrQ4E6Q9zyiJJVi4pY3GhbrZL2hrNEMKCmGvzjJ/diK6Lsbnrh25
ZQ6oNb8a2A/hz8stnknY+vpXPja4nnTzK4cJ+no515xbrzKIznTzSzs2Jqov03U8
1QQh0970vwS1cBcLFgVBzf7H2Jcm/qTnoGjj3E6He432Q1mUFZVSb0Y4UzhBoVGJ
sbEn6jm2BYN+gCs1JlfkGCd//nEckf6rmpBt+MV9+Nxr9iXt/wo=
=G92W
-----END PGP SIGNATURE-----

--aldxyrjtrikulwfd--

