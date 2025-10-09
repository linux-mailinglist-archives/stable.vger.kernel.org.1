Return-Path: <stable+bounces-183705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F81BC97CD
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 16:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DD7420CE1
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE02EA48E;
	Thu,  9 Oct 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ad+sySV3"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598672EA474;
	Thu,  9 Oct 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019819; cv=none; b=opaWMqZwFOTiotGIdobjis3mV/JEu5Yh5+U9QcD/2R5bBQCnwGMnpj/ZNYzA7XYwMtoM7YxB1mft1VFkHZN0teyvC837WkH7TEml3tFX/7HezHkvxADTeJNRE++1O1Ea+01xxS3AgQq/W+OvTIxNDj0eX2IiywTP5a8uS36m1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019819; c=relaxed/simple;
	bh=tKsf4rNNLhAUy8cx/s+Zj+MAaKVikS0yGc2U8lMqRPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6BjFKnFe0q3bSRUcoktDNCdOiF4VEE7t4pR/8GoaTY8PKpMtgXXM1tmUqm6U+1ZSBt4iHsHBkfPuL6JSJFk0pENyGQJ7poki1A2t69PaIltf1eQacjGtM1nsK6wdybbBCpZF0PmDqYhT9wTcfT00w1aU1C9lfOHnoY865e+rVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ad+sySV3; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8AAA101DB814;
	Thu,  9 Oct 2025 16:23:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1760019813; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=0A5K/PIrYFfczp2p7aBd8MOP+eifTgY270bvBsYk9ws=;
	b=ad+sySV3WNJRwtSW7u2Zn0uLB+SSMg4Zh+KL6VJ8fPKYLhm0CABTN3K/dOTG4k+ZHrB4F7
	ZBJYeoZRyh1LBFnneelIJHWrbpsP/p8jdgoavwEn4ux1OTx8CLsrCgSTQgiNH8mf8C8cGH
	Tz3tACg8aSPInLyXJD8GI24dPLdsVtTksQ4/MFhZS9f7AapfVASxVJXJJrPcYYmD3p/FFU
	htoV/P1+/uJleBe8Ue88S+c8NicjxUT6luGlugkX/Rg933olcImIRi1b+8LiaPddYSHW/U
	vl0nS3L/Nfw14Ptt9CqyDFdj2mZtFwUmRAr++F3+m7Em5agceOu6jqcjrPCBPw==
Date: Thu, 9 Oct 2025 16:23:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.12 00/10] 6.12.51-rc1 review
Message-ID: <aOfFYDUuTPkgEqQp@duo.ucw.cz>
References: <20251003160338.463688162@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8dWd9aYyb2y9MZlB"
Content-Disposition: inline
In-Reply-To: <20251003160338.463688162@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--8dWd9aYyb2y9MZlB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is the start of the stable review cycle for the 6.12.51 release.
> There are 10 patches in this series, all will be posted as a response
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

--8dWd9aYyb2y9MZlB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaOfFYAAKCRAw5/Bqldv6
8pCxAJ42fMNsmC9JjCmiJtNjG84lVoY2sgCgnH0MwALItQyJ3oYlt+cMtue1vjw=
=hvkj
-----END PGP SIGNATURE-----

--8dWd9aYyb2y9MZlB--

