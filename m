Return-Path: <stable+bounces-150631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADDACBC63
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 22:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD31D3A507D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 20:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE253365;
	Mon,  2 Jun 2025 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="JYtNtCwV"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67486334;
	Mon,  2 Jun 2025 20:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748896784; cv=none; b=hrU8GqVKPMY14qyADdQQg3RLXkwuaUXrLuFxH0apxf6w167/EPNrkD6xAlg1lqsu4DtsPr/NtcUFtMu8zj1WqYpqxDYE10W8UJ62Hj60RoLwWm34E0HY1L5dSvOsgQ/CFmyU9neh5NVH1zArryj2AONo74xque3Y3g4csoG3k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748896784; c=relaxed/simple;
	bh=IoFu0RTwCoUK26UOKTLT7VxRfKv7nJyn4chLVoQaXUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMz0o39gHWTCik+TK1h5Qm6OSXAXsyAOU1x9EfhT0yzgDO2gPwLEghQjXvKoiN84bb1dJYHqKlgEJES2ErslzGEtYVcChM0fN5aIoeSqTK3hRDWwOIy2nTEZwdPHEraVXn4jxmAGcI1zTcS6GBclGxuB3UulsrA5HQZjrORyH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=JYtNtCwV; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 91D8A10397298;
	Mon,  2 Jun 2025 22:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748896779; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=iBMCeytR/KSUfgAMnsPI6g5SLfZDNIv0b1PwX5NtDac=;
	b=JYtNtCwVts9bsL20fmVK7bQFrtppi60+sTpmzFj0QdxZJUs8CpwDvIojlAhScHpaXvBNnH
	cI7+m9ue4mES4B14yM+ojvlxKCk5QBd01U4Ec32zSl4XTvTLVUztGA+dmEE/aZyycNjVQq
	LHEhXgXCr1334YSrCKKoHn/CLxEq9CM46bZSVt8YS+I+96HPklWwUIOZla1iG3gM6g55dW
	FX1uZSzxcnEC9oiX3XdYZqslOODR/My5j4SQPAhfI6CThONb4kz+1B5tsCBHJZfY6pV16b
	S+8HpxKXENGyfs+LisYf/eFlRWNE59ipzJS0oxbVU4gs8uH4Ukqelis1C9bPuA==
Date: Mon, 2 Jun 2025 22:39:33 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 5.15 000/207] 5.15.185-rc1 review
Message-ID: <aD4MBU5u2NnamcfC@duo.ucw.cz>
References: <20250602134258.769974467@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4/DYJgW/rGJcmtv"
Content-Disposition: inline
In-Reply-To: <20250602134258.769974467@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--k4/DYJgW/rGJcmtv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 5.15.185 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

I suspect same risc-v failure as with 5.10:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1=
849178218

Best regards,
										Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--k4/DYJgW/rGJcmtv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaD4MBQAKCRAw5/Bqldv6
8gmYAJ9/tbkC8kzofekiKMW/hcwRaaGQ5QCeIbAHGjKjjX+b7mP3dVMdymDBp6U=
=IyBw
-----END PGP SIGNATURE-----

--k4/DYJgW/rGJcmtv--

