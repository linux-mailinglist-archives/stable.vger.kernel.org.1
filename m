Return-Path: <stable+bounces-106751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D9A01632
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 18:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F64163725
	for <lists+stable@lfdr.de>; Sat,  4 Jan 2025 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42201B5EB5;
	Sat,  4 Jan 2025 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="YTU3cKwJ"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448781B6CE7
	for <stable@vger.kernel.org>; Sat,  4 Jan 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736013267; cv=none; b=YaIE8FRZjexqtN3pH1k8b+4avtgy5ZhKSER3q5dCPAfjfGhj3JjEis+H1o65ALGNPrp44Jz7B7SNKpsfVJ+/++QXCf121mRRnZpJlQ4eRrmj1EwCP0CwkX00Wt1OVOC74ObDMOU2MpFiMU9cBKmP53erXS2ZBMWQL7WLPkhjk5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736013267; c=relaxed/simple;
	bh=eVMTy25X82D+sFul37qFqmgRSl0AP3YVTvwSe3QCpr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIQ11CIxozR4OLXr1t6rU11t54A3LxaxYSCcQAFnfqdoW1x5RmvWs1M10ipMTn1HgtzC99zsfZ+Fn1DbOHDTX2ef7u7soxqkGNA84PrjuptsBw/mHMwjbrdASB3UOqUv7dcShI44KlQ7IdRdbw9sjdLm+Lj5PXi5ts+ioANo/1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=YTU3cKwJ; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 511321040DBC1;
	Sat,  4 Jan 2025 18:54:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1736013256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FAJFp/MTVi/s7m18b1gX03fYaSlPIBwDVFXRfwMci1w=;
	b=YTU3cKwJH0E4tU1vz4QJyeaPlMYfu7IduV/cBz9xTlgSghOQxAaGioHHX7+ZWbGsmuw5zS
	BE12qf/DmUVRBDHzm6HVC0WEgJYAQElAt1/5dPHnw3laRYDYfIjUYiCm0rHfZA4Qbsg5wN
	sRgP8i4jjZLgt7KgnWik3MgKwSXfG3LxIFTwKluKUK/TFCZhZMuTkkKy+JIRANgFpSYiXo
	W/UvrLUBLkuVPS6Ynp24SgQi3ltLIx7KbbX9iZJ4qEx7D6XjlmJD1ihHuR1N2Cwn2JQgw+
	h6u6S7aFSkZzln/Y1ybAIArEUKE7u889ZJovZYpgk0X/ojzix8cIl8GeLr50vg==
Date: Sat, 4 Jan 2025 18:54:13 +0100
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Pavel Machek <pavel@denx.de>
Subject: Buggy patch -- Re: [PATCH 6.1 00/60] 6.1.123-rc1 review
Message-ID: <Z3l1xYCf6nHkRwpt@duo.ucw.cz>
References: <20241230154207.276570972@linuxfoundation.org>
 <Z3ZtrwAGkr1XZZy7@duo.ucw.cz>
 <2025010357-laziness-shield-0ad0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4IVMg+vOZpm0OJh3"
Content-Disposition: inline
In-Reply-To: <2025010357-laziness-shield-0ad0@gregkh>
X-Last-TLS-Session-Version: TLSv1.3


--4IVMg+vOZpm0OJh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This is the start of the stable review cycle for the 6.1.123 release.
> > > There are 60 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> >=20
> > > Dan Carpenter <dan.carpenter@linaro.org>
> > >     mtd: rawnand: fix double free in atmel_pmecc_create_user()
> >=20
> > This is wrong for 6.1 and older -- we don't use devm_kzalloc there, so
> > it creates memory leak.
>=20
> Thanks for testing and letting me know,

This was not "all good" mail. Patch cited above is buggy. But you
still included it in 6.1.123. Please drop.

Best regards.

								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4IVMg+vOZpm0OJh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ3l1xQAKCRAw5/Bqldv6
8mMwAKCFEK/5JsDZm1vUEn/Qpd2aAwmuQgCdHRtr77MB8bDb6oi5dtFPZRv1/Tk=
=j/HU
-----END PGP SIGNATURE-----

--4IVMg+vOZpm0OJh3--

