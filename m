Return-Path: <stable+bounces-185604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5028BD8432
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE0D4244E9
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B84212568;
	Tue, 14 Oct 2025 08:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="DDBmGo6H"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B064B19E97F;
	Tue, 14 Oct 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760431622; cv=none; b=t8dHZjwTOoBuVt5KRVGb8PIOqza+FljyLZG9m67BEEOod5SCWP3GuMP7blMU0jSWJHd0wLSyP9gKbtxerLjv+m2SyOtAXCNibTfdWM2zXlpGdRIl08El6+Ojfu65bRuRLs+srKej3fD8cd/TJ6EA5Qo5Cj39pNm0dZwKYl/KGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760431622; c=relaxed/simple;
	bh=+4MKIbTPR2scSm5E8reMG7XAjsq+FjmMbvguoNvnxPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL/py0KjhtPNhyZYh6ZdP4yozi/9nJ1r6aKvupX+dG7twqBkoK00bqKk3bGKE7WaMIjrOkK4Ldf1MHxCB9xnDiJOoXJYCxqSUABFwpQEZ6tyKuL3SkvdW0IeXqZn38CXwXGV+bTGEozUGiMnW2CSP0y2OKMNDd2N8c/hCZmQ1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=DDBmGo6H; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3ED82101DB828;
	Tue, 14 Oct 2025 10:46:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1760431610; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zeY3ajeuYb09cum28ZVWKQfM0wiQrcSqASwJfdTaPIc=;
	b=DDBmGo6HM2PlXiLAHGxk1FFUsfEP6tvP202P8jTNByAzNjow60N2v2HB5oMpElDEifZ0BM
	x0xr2sbBLsiZIzLeDvZtJlfkNr01YYhonMblIfPHFXLIGo4uX7oEHNqAYhsMejjCfcHJCo
	TyTMMqGPwhC+e2CgubTH9pPuFLJ+R4wwKSsBPToj9nuYC+40ZexhIFUHfx1sAltmwqzNxd
	++S7TyZoBwwzLNZETTXTgUALAdQTQ2092tOOlbX9pnAOFWhroeKUBdqMqqASL8732ebfY9
	1xCVziqOjY9yksFYGSmvWgaFhK9J+SE7LWVa0QLzaaY6AkKBlciqGjWGTWbO7A==
Date: Tue, 14 Oct 2025 10:46:45 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.12 000/262] 6.12.53-rc1 review
Message-ID: <aO4N9euDqzzx2LSV@duo.ucw.cz>
References: <20251013144326.116493600@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kLa4Vhj+IWN/CboI"
Content-Disposition: inline
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--kLa4Vhj+IWN/CboI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.53 release.
> There are 262 patches in this series, all will be posted as a response
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

--kLa4Vhj+IWN/CboI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaO4N9QAKCRAw5/Bqldv6
8qVfAJ0T+6uWEnF0jVYZ2R1EUh3LT/vg+wCfSOGJ7T4PBUQtgUOwKbvvD4+nV/k=
=q5II
-----END PGP SIGNATURE-----

--kLa4Vhj+IWN/CboI--

