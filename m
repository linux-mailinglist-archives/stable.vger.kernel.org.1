Return-Path: <stable+bounces-183163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F900BB6214
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 09:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2447A344136
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 07:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0822A4DB;
	Fri,  3 Oct 2025 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="hekcm+Nd"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761321ABA4;
	Fri,  3 Oct 2025 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475090; cv=none; b=KuWh3TWFRs1PGVsbJOQoid7zY5+/AIJEpRE99y/J0EdevsmbPhZYdpyz/DK/vF+/cZZbDkPnZxSy78jsTNFeKT31Tv/l4Di7a0oj0k95gex/SD07tqA+bk7sYFjlC3wEzXZknZ8OWvPzvPElww50lclH1yxdzIiDX4AiJq6GzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475090; c=relaxed/simple;
	bh=3tIslANnWNayD90+jyp0Nty9jHvsc006JGvvbAQcfrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRlg+lXUi6GxA9B+czAhvV1RpYf1/Sz5CKbuqobdMiqkCJwEEAmlOlK3DBN9b6LDHFMhDd9i8/Ety5g7ppQ1KZXCMFBkxtuqb9YMZGQIRMHqsAp3ywW8PMk6inzRWjhh5KqEABTPA+CJLKJUkRIZTrdk95PQXW7uyPWvsLjdR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=hekcm+Nd; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DBD4101DBD76;
	Fri,  3 Oct 2025 08:56:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1759474614; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sG2UwrD9Ef3Q9/EHHbimv8ieJGOVacnbyOZSNg0QEJ0=;
	b=hekcm+NdFHhmrQOhunVTYlhIzK9pOiAYhFuT6rh7mIq+xcm6U3YvLF5LcIEs6CGi1PeQPE
	QfIYIslv6WVRDmoh1kIgpXvnBPFieRz7TwqOBCUb3fGFjFWMNtnNrkYEbzWXB1PfxMSJ+F
	fNcOIYudb2PcgyR3vJLNhIWhhvdY6J1K43WHDbmwgBO3AvDXT8zVmus3Wzj1BYl7vqPHbM
	SckhZWdQYv3OUGXLzQgPChq8qu4ktclmxhhHinQNvi/fmEphVr69Y19TH/yQ/3yBZ5e1VE
	ngSLZxG31Gyp64OHMmbSL5car73G43Fbifi47AZ/r7AAFaUNXX2n2oLqAcqieg==
Date: Fri, 3 Oct 2025 08:56:48 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
Message-ID: <aN9zsJblYLCQqRl6@duo.ucw.cz>
References: <20250930143821.852512002@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dLhoB2bpvRytRt1e"
Content-Disposition: inline
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--dLhoB2bpvRytRt1e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

CIP testing did not find any problems here:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
6.12.y

Tested-by: Pavel Machek (CIP) <pavel@denx.de>

Best regards,
                                                                Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dLhoB2bpvRytRt1e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaN9zsAAKCRAw5/Bqldv6
8rypAKC/zUFSc1UT4rUVaOtzV6oMArMEQgCeNzB9QV/1UVQsEa4BhuVqvoHKxkI=
=S9QT
-----END PGP SIGNATURE-----

--dLhoB2bpvRytRt1e--

