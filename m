Return-Path: <stable+bounces-180651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B0B8938E
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 13:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C11C1C86808
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 11:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1418C2EA74D;
	Fri, 19 Sep 2025 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="Bdd/AOvh"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A692727EB;
	Fri, 19 Sep 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758280737; cv=none; b=rBqIcs/JKMPh2Kjl0mBkhjTL3EkxQjfYHZ5ma1qsqU5503Y7Q8+SP9U0feIatLYNbahTjq12vrKlfIv+xeKEECHza+VAbagBKtHS9Ahhse9gUtjKcC+l/kFeR0Dv/tM/9KeIKzGw1rta3wR6p+TCJMGDVZCUIG5aEE9d+IA/pbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758280737; c=relaxed/simple;
	bh=pafYvqVlCfEqCJSsMEMvjxwX3zW2nds5SuS2t75SE84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdScQYQ+S6Q3KjpNVF01qb+UQeN5vYiyYxYGA88nlg3HReP+Tzv8H3AQeocTioLA0PRcVp8nU9oRJhERB4EjK6A7yr0nUXpmIDdIRRlgxlnloUMC+8B34Q73QoXrK95l8yZG+J88PTWcA+UnntYvR/7zJv9JSrpvF7a+Mao4l7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=Bdd/AOvh; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1758280718; x=1758885518; i=christian@heusel.eu;
	bh=NmY7tGL7hQWgxTyAFWu6qYyoysLYJEMm14YjuSWpKOw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Bdd/AOvhZ+XoDQMJUHhKPtAX6d/ThptiwI/9EWx7Sb8TyTFPbi883hU7nX7qaq+6
	 1r61zgbyOS413MZBLhA33r1iUMz8eK0ryIP41yWZs/08IOQjMsXdFD/vw2slW8641
	 WB4YbKNc/A36mpz2/4kuq6Pnk9VlNJa6N+R4fwVN0ANA/FkC9OSj8gdofT4PMXUdf
	 cfmaA4jHmMNat9DWb1DOLty0TcgpiMzQi3BtoXmmOb0ZB4WyGlR3X5+Q9I+tMMs+t
	 DnMrdEyMabysELQLHC4WVOxRIuQYH5UFuptVVXgEBJZc46W0hLJeOHulFxESwzM6Y
	 EaRvdGhL0KhBN6jpJw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9W78-1v2qpB11PA-00H5Gx; Fri, 19 Sep 2025 13:12:02 +0200
Date: Fri, 19 Sep 2025 13:11:59 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
Message-ID: <5df3745f-5e2c-4a54-ba2c-5b52f5bd61ef@heusel.eu>
References: <20250917123351.839989757@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fekihvo4oufv72u2"
Content-Disposition: inline
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
X-Provags-ID: V03:K1:egLBHGBO8osJymiBrNOe9DAAlH9TKDZJBD5iyAAGsCSXcgzsJ+U
 V4nCd2Mwh6himHtTGUMw9k4nrGTRscaJWS7vtbd2uJTt6znRQ9jBg8UTscfBSZvZzIjZUHc
 rXiPmoYlQ6zjrGE4SwvrPlvprEZLr4La/trvwOOnBRXLg97gbXXZ5ZYFPn/7C/doyEF6nV+
 BrG/n3eDfzx+59BZnQFGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yDfxOUlq+uA=;aYEPfbldcYi1cmoV1nPV0MECgMg
 QcGwc0UvpuclINrdb77cAXckcMYG4AvlhSiGNDRFXRP78RPgi5ZGdl5LQjDl16RNNefBFGUBX
 CBMburUvy9G6fzNqiDPiF6uNoORpFNE2ou4bAhqdB2HCqNW/2UEIdyd664R+QFndtmiF/dLvq
 pPuuaImDSnQipbRlHXoD6XGbiE75Ba8vJMkeQauPdSKmoAQyqt4vndHGFUk8xDIm88jvVcgvf
 TnOco52cKubFx+U+HVdL1KTFeHahryqmpJH99Sq0OS+WEDgNboqH2xRUvdKBfp9x08EeY83Jb
 zJzv9pcT+6s0i7mLtMGPPqGnsfOe7Vmov3F7sJSZsUI7PHx/p/lk4lZghMUi0h/d1/vyAfVnE
 jQd2TMHD0HMhhSgDz9vGKXR1dYhjHRBeb9K45qQWoEomlzI0t9BGErnASpxh0+G1QOfj3vvhp
 pjOnhJxu7MjgT6Jq9i6M3ucZMyCfnZ5/0cxo4inMMTN8n4KiuuZgZzWVaoyW72Xpdwfhj5LoP
 uux3jbMKQUpW8A7eim6eegnrNFvyyRhg8W6nHG0yXD2vFS+6juGfEoDYZqbndsQICYAgEu/kk
 GpWKmZ1DHSWgqLq1q4ej2L87ySkTPFebQh4I/MOhXP7Y1ofQlLtxZ2C0S0FjU2483ZsJr89cT
 MFMoTQIIdxAgr315Lm8YT2p4vwpZG7CcaEP1SpsKSbk/HL67O17SYXjUSezfw8EkDgHcJDYB/
 Zcc+r9TO4hdUOoFHBY5zS+6Jrp+T9MrOaodKcJr3kgt98mZB5DPiCT9AIjvIixGzw7sCkjEdb
 Oslh53xk6H2erD0LjX1wo9UWiKvEe8l0iEex0YcGZhc7OKjT9hJgsf46DC3qxWoLP2A5KHCU3
 TCKQA0mGuklVs9E+nJeTm6oGV6MmNVlJi/puAMM50T2ou7ZJs7LX8t9Ly9cNOhAMkEf+DaVvv
 9LOnK3eIh935Oyk0R4oY9g4aFRBhopfSSNvikeN1mLfxp2T5HIu0+nmn4i20RjqBize/HAEcf
 10B4YStuIWyxyDRi5VnscI4TVE9MkemB5xnZANhHU4W554br6j4v+d+CIwk5XvvYI56vjKJP/
 YaW90hzngn0TUBoKO4lvzpofMoF6+yi6WoliEr/eOFvGUxbSkuPN5Q8ZiVsvV0FFwNGcb0FYX
 RNL/F18srCdDYosPQFn7onJRVfCc8r/tAOCxnqMOJm4tNTyTsaUjc/LOd/lZpql3faWKkBxrx
 RYkX4N45wFl/MYrqldYl7v2lO120AOGoQ5uwuBjevLW/cyvXam1dYXnkO1pjcFRrSR6BayIT3
 Tgijrl17MLP0T8aVOhjH5d+U+JyVUVNqwYZVea80ghr9TKTTOCdb2e9pTxCAewyH+1DciY6kh
 jH9nNIl6TiS2b/PQGIC8vEVrSEc9hoQuBs/duTMBtzgWlKlPkacipubT/wNzJaui33D+QSO8v
 2R1SGtoMdN1rJ6YFDc3OHfSgSEuHpihzoCcbCzyUEycjq6MT5ggmaxXxhUf1EMWytw/ZTtFvW
 4oUWTfpxdSmC163TIdC2+uRc8deVDVuMDTf/QGEFA8o+sUj1UJBnV+YMKFXQsz9NO7FS1zCea
 exKPGePuooU0qUL8vie23H0k8etoJk7Lwpm0I2+hHxyLdX6wAYbd8icB7QXvOjvofKGAnA9/n
 nWYQ+cMEsdmnwEXT/2b3koIod+wNnPfnAH4x6E78A7SRXFh8VHgIjL1pbHdeemxFH8/XSJOAH
 gjBSJDgS7FaQR


--fekihvo4oufv72u2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
MIME-Version: 1.0

On 25/09/17 02:31PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>=20

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on the following hardware:

* a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU
* a Framework Laptop with a Ryzen AI 5 340
* a Framework Desktop
* a Steam Deck (LCD Edition)

--fekihvo4oufv72u2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmjNOn8ACgkQwEfU8yi1
JYUv9BAA0JCJCkpSWQVyl75uCgL/e3DemtMcAVNYHc0FJEbB/DHyRaX1O+RsYk5n
cL/2KCvkAPRz6PRgc6h6CieKFDOZceTtIPj/ObLk848gyGCa7BRib5xURHWDueLX
dw5b7FX5jqhV9utDOoHBkvM8R/jsrN1I0fub2aaBZf+kzLxbZIDGvakGgdQdKD0n
76q7MNX/lsuczLFGPjm97Nw3I3lwbgh34y4xAg5a2TxRazWcDxuJVHCSgVL1a7Zv
N2kgnl1ssomWPXcm7phruuBIPHZ4I+aUIbYo6wdRjKpFJkLXBBvRRdEVoVACetUV
aOCnl5HGjvicnDkh1vPJjsw3UKGZ/JvWFRqV7gD5AOMaYt1NCbHqeVuvFVp8UFp6
WMvIDdDT/EzF/0pZlczA3tqjbwP61OY2/KYOTEALdVJzZY7VoL/YyfbK6UM3M/66
n0yEQZ30ELrG6hrewU3+gyhR+2pd7qbNVKKdNx+jew+MHaAWxPJZU2nDU8j8leqR
9PrBOXbZXxmdkrIchWQaVfjh5b5FYmc0zrOYVMPX9JKNDxl5te3hSFiKqjeZHO7X
gQxP/roZ7nXCuGsJFJavlTBO1Dn+X5MFi7i+uS4BF7qp4BHevLWtmqpv1cyVQinU
qZIw0LOKqL6h0XrrYHGWcywRsdCUigaxHAf5P56uYZwc+gwoFCc=
=z5te
-----END PGP SIGNATURE-----

--fekihvo4oufv72u2--

