Return-Path: <stable+bounces-158617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF92AE8CFC
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 20:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0532D17174B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF152D5415;
	Wed, 25 Jun 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="foezECFv"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3828C87D;
	Wed, 25 Jun 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877447; cv=none; b=lYETOzQ2If158xTwRecd7pzC8HB3ZTpzi0CyUdx4dodm4L3frqBvQa4K9AKzEc0aYmjdUke91jrcBruv8Mdg0YClZBZw/ju60N+i5yK5/XreziVjHvAduToS1Q/RWzYCMXTKDlveKrSie76MRakQUQVzfoAZocco9Mt/XSEvqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877447; c=relaxed/simple;
	bh=QtpcTY5tK/RAN1SAX8ZAQU4CDZ55UNox/Cr2H+YB4yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpjLF30mDkebiu7fNlzpc9CV7b9dgsufxwtn+i1gMOUwTRh2JDZWxLe8rtiuS9+PcThVq8qjxNUVV3vSuBUeaxpYuwbPPxeZl/OdHyBHIMCrwLhfZzq8t3G4HeFKmDZhrSKI1qgKFwn8l8O7EPiKn5Rc36fFF3cG9AZ0qM8+uhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=foezECFv; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5842C1039BD02;
	Wed, 25 Jun 2025 20:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750877436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=/lu6lvj/NDfIA8VXi0OFHDRyFpCkeftjpwcptJ9KIwA=;
	b=foezECFv3Eytw0ulRdzayv9DX8q/0tTj5wFmWvtm2YOXpy00Hm+c3+Wh79xGPGmK3vIWKx
	5JIBGnkY50XfMWCllI+gBil+mC1zDM/YXu0lUGx0fdiNL/UoAThhkmpbJy1uu6jLpjkrNk
	HlV+GxsFhvoDY81BXgEklpL7e+Ls8FV7gB7/AH9eST4WTm23ZrRt1B8SucGsKBDjLbgcDI
	LgNKzfVFtLY0w4xDEx/SeHgbWVFymjxed2+BNYnRShQ3ivgR1ytGJP9h37KDTsSqOD8L0Y
	9SmQIL81bF8mzaQ/GTtT8g7P1T+klIbeMVF5xMOjz71iJSx0vlnP/+cUVZuDxw==
Date: Wed, 25 Jun 2025 20:50:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.10 000/352] 5.10.239-rc2 review
Message-ID: <aFxE9KMnj0K1angs@duo.ucw.cz>
References: <20250624121412.352317604@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3dki5SjjNFchw+xw"
Content-Disposition: inline
In-Reply-To: <20250624121412.352317604@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--3dki5SjjNFchw+xw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.10.239 release.
> There are 352 patches in this series, all will be posted as a response
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

--3dki5SjjNFchw+xw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFxE9AAKCRAw5/Bqldv6
8i8qAJ4iaY1XcSML9m2teq1mPQ2fbWYf/QCgwD3JjTmeIFTBddxc1arweUl6G9k=
=3ZH/
-----END PGP SIGNATURE-----

--3dki5SjjNFchw+xw--

