Return-Path: <stable+bounces-180576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73894B86A9E
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 21:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD7F5667F4
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A732D248F;
	Thu, 18 Sep 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="To/7T9mY"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C26288C35;
	Thu, 18 Sep 2025 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223324; cv=none; b=u7ZRWVe6EWBSZ1QdXb3HnVvs5jxuBopRiXApn/h9txn5i/5lJmXT4KOWkfm0aCCe3IcB9Ngc6QLOqgwDmSpqNXWn5zU2A2qpEI1XApzWsYx0iUDauCmfhpT8PW8jxU/wKtyps/2wybKplPpzHrmMuwD6NC0IqZEoRpv7lrB6qs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223324; c=relaxed/simple;
	bh=/se16em7MEbgp0NbbT5daWyrol6E2zVVrMfkjzkIapQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxQYvcrTAiIJ2lWylUpH3HJu3m56sv/Wd5JecwRNJ6mxyq8T4trzd/dOrGhZtXsnjXBcRfxJnvHcfySk6OZIC2a/NvJGdg08xZ4r0sRxrKAZny9PeO3VrZ67RzQmRmrYCsFMlIb6mmEOoxHPwpe0BIhAEiXbn4dQ1c25BpkgC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=To/7T9mY; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DA771038C109;
	Thu, 18 Sep 2025 21:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758223318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iJuBXPG2Bh9NERc9QDLFVrPeqpcwJx8dyCLyIq/kXC4=;
	b=To/7T9mYv3z8GFyc5I/EjBnhiyDjPVOVY8oA9NyOSh57ljRJ+A7vpte6epIya+6We3HKlx
	dVNPjmE+7i33CIuqFrOSOOHhhu20SiBFfgFWTXFR3bVxuYud7CZjji6gh/hQxDAcZNXRnx
	OZ8gJiA01Trrv2eHS+mf16JcZE/Exu/1U+IG1B1ns2IOoMAE+m0nfRGLxetXatCOf/p6x7
	BnJngAsBRLn1Pr58TmVWj0cs3EBYJ1ilzhEXjBSyudHWEa7Te6mYgZzaSpSTvqht1S9n9f
	7o/RGojeoLSwWSZyt3BBi9PPKqhrqwT6sESEXEQ4eWwJNIlBDDVErE9fPOhy3w==
Date: Thu, 18 Sep 2025 21:21:52 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
Message-ID: <aMxb0EbmbJ9tiZdX@duo.ucw.cz>
References: <20250917123351.839989757@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FjvO7hMn5uzHW2qG"
Content-Disposition: inline
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--FjvO7hMn5uzHW2qG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.16.y

6.6 passes our testing, too.

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel


--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--FjvO7hMn5uzHW2qG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMxb0AAKCRAw5/Bqldv6
8tZpAJ9+mjG+Ve1qZtPiw25GZvCRQ3UvRACgjCRf9BQyVHXpeVJA99VNuuVpxDw=
=/rUR
-----END PGP SIGNATURE-----

--FjvO7hMn5uzHW2qG--

