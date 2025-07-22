Return-Path: <stable+bounces-164293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B1B0E525
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 22:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1026B3BFA7E
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9646E284678;
	Tue, 22 Jul 2025 20:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="lTnQNjde"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C3D27FB3B;
	Tue, 22 Jul 2025 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217853; cv=none; b=SpaTJ44H01Bq8OHPFA2UZmurziN25XTRStIIlyVMH5nYNFV/284pjoKddSO/82nqxzdtK6ItNe3NmpgVYehiuOjKwUgZrpPE8snj/pgx/secWneV3whgisACRIFkDgLNe3w6/Dn5vnoVrQ2xCbsdfC2+4Bu4/QCZsn4MqtbxJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217853; c=relaxed/simple;
	bh=r4C21SkimRR08+NTBL+o805O4fZz3IMa1+Az8OJAWJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7/TBOt5tuBPPm0MCxeMFs8Mxgxx7HlNYkxIeN87fx0cbhLva462ggzHpKyyrEHyDuB20AO/2rx4TH1LvsJ9T07GamOpLA/EmcZQG6wdRlz3h0nCoikstN8Zp9c++JYJkpIqQxcIVIoO5IWSPteg67i2Bk//j5jZ43eJGLbGqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=lTnQNjde; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1753217829; x=1753822629; i=christian@heusel.eu;
	bh=xi0dLzoPvspJ0Thu656QhGnHYoK1rauDUKPcuEJO+pU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lTnQNjdeGDEkjBMOiq74kFi8ng/eHdlCC5emgKqZ9hi5oS30m6VzitUQvP9Vy34O
	 wrypAN8nIW6tottOhD4sSfaPYQzqP4Fh/WmcUtTy6BT5hMJWGDFAwefvmHGBSdKlx
	 pQTW35djiis1sDj7CJYbqyfHJRGzUbPee2PNwc27EJgMgvN9BG20fQ6Jw/+KshT6S
	 UnTiX/07Dbm0V4ufbipCam2a5g0um1D0GEqaLViCsvmA1OZZdS1JELqiBiIlvPkRE
	 MtZewti+4NJZ5DH5lRjQgqj0ghGP2sydtwN1sTZ4/j88Xgpv165JMO3rI04uE5Pry
	 QFpXsubzwGy8ZEzQzw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([89.244.90.40]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpD7H-1uw04I1HhP-00jFYm; Tue, 22 Jul 2025 22:57:09 +0200
Date: Tue, 22 Jul 2025 22:57:06 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
Message-ID: <b82800d6-0849-4b88-8026-6a8596ff4276@heusel.eu>
References: <20250722134345.761035548@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nssu6z7k4mv5iuds"
Content-Disposition: inline
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
X-Provags-ID: V03:K1:cUTCdnko56eAGlcXq0rMTE3VMELH5cEz6YWh/nlebymBc0yaR8S
 qkMxzV9k74diggYDMxJkWYgd4RGTKxw2FxRS4P+ig0J8QZu4h8cubKynbFBuK9XrLfXBWMX
 G5v4QPanUeHPjZ7DHvCU8noZP2hj/BuufVjmvBJsrlBuKhQTwKb9IO8z9gZOq6ysrrG3yVP
 KPOPyC1iUG8IVMcN9Orug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Ms0Xm8iVG0=;Ves26EMaJk72R5wXgSqGejbzLy0
 hhUz8vp9hnXG/OKJMGOKXUPTkSQYrdNuVN0gNYZ9/dG4H1kWeHTn7oSTuoGMYyByE/y5wJpmH
 djP08C5JhIkEHLW40SuKdIKDP8J1Bk44a4id7iQxiK6wc8VMM8MadMU0140bH6axOZcw/wTvQ
 V02c7a4XypmCRMZafdveJFN1jDwXSJC5XgtVIGHNKgqn3g8eF8X0ydpzsOHZsRzpX9/yOeWSq
 5OHNC2Vswd/uoBNlFy7e5pJa6tDt7FKjrnHQwY89WNzVSlqSBMgtUQF0GUvBn7q72zDbz18Vx
 hYfMZE7L64lyVYdOBkkDCYo5AyMKQdSwdTKRiQjoYaW2B3N31x4ABb3Sz3azKXKw5ZoOEPjLf
 EXUfLdQVe9YU3WWFTIfochhCo2ahxIqUVEy92V5hZ14XR/aZ1Xawv4OLnQ1Kdl3EYvd5qum6s
 /3pmabGS87+Xx5r5CuZpdhyjOcxNfA4YQEDtxsLiX5CoOL7phi1iOGPWJa7cJWMC9Vf9/LkM9
 rn8ajpOGP8j8Dp+lEZdFH7frDj1u0Gcn13T/3oeOF5FLvSSu07CLWZa9iVxs5jNLfoD8o/x9n
 UjHkv4Id/fuTZ7tHrblAFXVOW/tIgIiytf2SjQt1dc1AiKmI1gkOGNcDb9p1McwM93i9VTZKB
 SnKKD/T7D78Rgr53thx2SLmr+lYDtk0eDZQFerrBzh2g+n0NubvMHk/nasrT+VAkNyVjhdXMg
 MIlcCNLtPNZVm6tSUGFw4q1rI9QHfDFWtorLRosCeXZKJSMIKovtFxr630255NK3DBU3OOjK/
 mpW6yMuJ7utRMPQd+iWsFK3x3PtxBRwQm5b3cbwQdWLYA0VYhseqwLQHqilkKhVE2DpneuCdw
 8hgOBkOYYYzSPrbX46D7hqjv1mMI6Al1Ly0wSM+n0kO9n+BiiLM4si4BMrsKk5/JzvVvoeYzC
 PYFcUT5ihqVQ5oG40i0/jYXxmLh1rae7O0ZmgRp2MUikJ4BzH2YwMB9vRSviJdoY+X62h1J/8
 qNDhzAMJiV/VkxP8eKySuht9BHVNRS3HxVQuS/sbVmRhy1b4OoFokxh09zIAXjDpubpx4OZbO
 a0T94ATQ/xkPprJIhNRgn5XEV1A/BX++fBKqSjN2JMvrbtLu4x+4xXd8kWiyk8qmK02W/vSyy
 VLvW+pihj3Ppn/NNtI8oypcka4y277h3a4wb0gbBI4ZyjpI7tcCtfd//uaDrq2nvukGFxHowG
 njFyIUTdWjmwtqTgBigjX6Iijn5cu6+kHA5hxr1sE2PbyHc+1ZKqjyMQo1PYn3phZW1G0m52C
 iptOc3s6a8iIBVRLxhA54QMgY53ax258wLRwP2En1mcvK2jIogTAVfj2qGf0UasNnx0K3LZjR
 BmMosd8QwRo6ED9vcN4dw+ndPx/4r/7FUH4X/u7CGw3uQmRJixgNZL7LuolArXv5F8rPl+LwH
 UIyKkbSwWWFmtKNA0m+uryfzQyKyMfcEyz1vlHAXWN4jCaIyH24vVsAYvHWXULuo/hEgCmo04
 lHI1opY6SnoKJ7qGhuXUO9SJePbZ6svMhTpGeuja5z/717rsgKchdedHUdYNXQ==


--nssu6z7k4mv5iuds
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
MIME-Version: 1.0

On 25/07/22 03:42PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.

Tested-by: Christian Heusel <christian@heusel.eu>

Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and a
Framework Desktop.

--nssu6z7k4mv5iuds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmh/+yIACgkQwEfU8yi1
JYVD2w//SHeaSPH5JVhapqeMyaq7CZhnD4yWi2do1hgNshN0JSPiYUDb5Nc9FxaP
licsd1ulDwLVdRynevsqrsyKs+vrpmK1cKE6eYifcSovRknsCoN8lurmNtKMuYU6
250Fq8nkjPQeLZ/H5pAHYVNxI1LfBwfNHfM3ZD5XQegTsUM8cqe7EroDbHAhqUgm
uTKQLejWSKNw4Ln01qLRysSa5j6ie/Zd7v/yHAlJFJcERg9T2nTFjf6MKp+KSVGK
ewD+6dMElbUU4RKxm2upzkqGuArCWl2JO6Ozpe1pRr3sJ1qbjAtT7ToUvOGTq7BZ
sMjFODvNQ/nTOsi7msEVG+v7p8BGOBgqb/MqTqSy9ZYFGt+C3QIXjltAgxm/JmMq
xfoaXTdP94HnzZN/9gnDGpqlXAfHycP4Kw0DFGl9IFzXmWoc2uPawuRosBc3SxXd
MY2YNdQNVSg7qlTIrl/eZFC/d63TNCUD53ELNwrenfwZ8rgEtEgWpSex9zRKui4v
qO/nJNSk8C37SjfrrH5kswiSUhddkQMnzFGTw+iOjm74il9AGkcDOILu5hXdPp+D
j7gFoVlFt+u1srsT43A8xfqrVt/v3mVmOHYkrnIjXMymDfTLmaKTrIPHLTirAHqE
hd3OnzmX7BjGYJqvC2iI0xTttkXViT77pBlNMaxVUQQmprLVR9o=
=iD6y
-----END PGP SIGNATURE-----

--nssu6z7k4mv5iuds--

