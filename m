Return-Path: <stable+bounces-105067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE49C9F57E1
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 21:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD72165647
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46F91F9A81;
	Tue, 17 Dec 2024 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="XpcTgMZN"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93C15DBBA;
	Tue, 17 Dec 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467873; cv=none; b=kvYg8IUMgwjx3romaZEI5s8KEEmm9s7pPSrF7fuySEPPvAiy4XTxqEh6y5XYSOmK0nmWGYVbAleJSU1c9Hpjw+C3txHUCTTNIxC28sj3f2dOESB7U64sBBXRaockC69Gkw+hMWuJrA71Lx6zdMMlXxJozLHhN/lZBmQR56MozWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467873; c=relaxed/simple;
	bh=5dwmYoI1ksowilAAFiYhcrL+N1EqqDZxMYb0oMrBjjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcVeNOhk51wYbszua6Oo+3SU2WHEtbsj2X2ehQoujLc6KeDxuBqFqQn2NjCXzGodKdDlEszEPYxmjf+nlXY2y4/WaIRaLZBh66Bmt66i/bEYoZixHmPHC2pAcg2JYJWDDAoYy+wUHeD6O+brFJDahfF1rUYmCyCcf4ujt5VHchU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=XpcTgMZN; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A7DB1047DC0C;
	Tue, 17 Dec 2024 21:37:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734467862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kSDlZnHY/aVlvWPRiGV0ECJ7U4fPHV0GIBM5MTGF+7E=;
	b=XpcTgMZNrp8+WnuTe1ZIH9tsQik1kM8A2AP5Rd1FGWVtS138Ls2bv4xeG9W2f6g6DvYgGa
	/pZtggXgEqQdgWP4DAkTVRgaNwHoy+kpQTaU4W14PlHKa+rqCclbeyM76MtHEa+P3ZxQSb
	OkAKZu7t16jHO5JdeI+xMEDfV6IGJMiag+zyuOyCPMG0xbObSnONBGgL8qfZCVXY5y2MR8
	U32M2Vun0AVLguR7vuKgXwEuqRgkg+g1M10TxEZX2s1Hp4vmG7K/pEyX0QYMCmNFNejtoY
	54JPPxwpVkRiaoRDO5m5kXmSHfO+FepL4KeB4lxtWiNhSKr4m3owEnIn6nms/Q==
Date: Tue, 17 Dec 2024 21:37:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 00/43] 5.10.232-rc1 review
Message-ID: <Z2HhEXJ8D2P8aJQ6@duo.ucw.cz>
References: <20241217170520.459491270@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p21Tvcdg6sb3RhWd"
Content-Disposition: inline
In-Reply-To: <20241217170520.459491270@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--p21Tvcdg6sb3RhWd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.232 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--p21Tvcdg6sb3RhWd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2HhEAAKCRAw5/Bqldv6
8uTdAKDCv5+sNld68enYYO2zxw4E/GXfPgCgnflAkxud6+/AjeuiTlwGRyk4nQQ=
=gaQq
-----END PGP SIGNATURE-----

--p21Tvcdg6sb3RhWd--

