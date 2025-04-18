Return-Path: <stable+bounces-134626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEA1A93B6F
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4CB3AF990
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1729215792;
	Fri, 18 Apr 2025 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="c3/dltMH"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08011DED51;
	Fri, 18 Apr 2025 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995335; cv=none; b=nnguBOw9H/izxSzGUbicS1SIOJeE/eerMEI1S7BA3moq2qevARFwKE//tLkZoMKlYrS5c8f9mFVGk6E6V5s1jRgkFZCsoLiPC8elhFru9UsiWHd3gjdQ1agpO5xO3btMEtmGm4/ad0ZoDsfQ6GltxpY2av7H3qHb3D+MP0xR8tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995335; c=relaxed/simple;
	bh=Bz91niipmiBlTkoafNa7+Vp4SEyf9zzNcrQJW7WWs70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chYglwZO/WcRk8r1JPIZju6JTuloxPq/g0ayRLvSQEydYZXpX/7krKV5uSBe8hTSmJPAYKGhSFzajZ0WLNywVEW9fWnvsL3ZXBHr+tiXSLhE3M9I5a3ZFXng95Sa17GY9wtQOCvzICbY7JB8KMqjBqop5AFiicguX4wQgdY3Rr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=c3/dltMH; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B7952101BF2CB;
	Fri, 18 Apr 2025 18:55:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744995331; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OafISoZhUhaEdsm2ZGrUseT8G1TVaT2AMpMVzxR8MWo=;
	b=c3/dltMH4hlPIX+EfxsFOfBkPLfU7ngh6Cln6oMIOPzvexs+YdePGXkMNBFe53ZtN4K2Up
	XoK9kcLw6S0HrCHjwbE1gYP10KoAZGnnrIIi4NeACtYZ9Z3VRxO0IFK6Ra1hRTITPqVsVr
	whZFwNRzMgk5rI5PlkWU8YxGsWVeMWLPbeQu1fQp8fWulsROIawbUafxSt03KOc0MuA/eD
	uEhKjT7qt21Z4Ob5oaon6w8uigPJby+gDOejE2nGTv6Ljqtl/cnk867fxx1CtUZZPXLleq
	VZD44fCa0wkaub5JLrhxLec6WMI23OgAox/tKi2eR9CwxVjMWPZjURGBFhvraQ==
Date: Fri, 18 Apr 2025 18:55:23 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	mark.rutland@arm.com, oliver.upton@linux.dev,
	shameerali.kolothum.thodi@huawei.com, maz@kernel.org,
	bwicaksono@nvidia.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 4/6] arm64: cputype: Add
 QCOM_CPU_PART_KRYO_3XX_GOLD
Message-ID: <aAKD+zsLwx8pBSOE@duo.ucw.cz>
References: <20250331143710.1686600-1-sashal@kernel.org>
 <20250331143710.1686600-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uRtdoxvThh96Le0+"
Content-Disposition: inline
In-Reply-To: <20250331143710.1686600-4-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--uRtdoxvThh96Le0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Douglas Anderson <dianders@chromium.org>
>=20
> [ Upstream commit 401c3333bb2396aa52e4121887a6f6a6e2f040bc ]
>=20
> Add a definition for the Qualcomm Kryo 300-series Gold cores.

Why are we adding unused defines to stable?

Best regards,
							Pavel
						=09
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -110,6 +110,7 @@
>  #define QCOM_CPU_PART_KRYO		0x200
>  #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
>  #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
> +#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
>  #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
>  #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
>  #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
> @@ -167,6 +168,7 @@
>  #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KR=
YO)
>  #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CP=
U_PART_KRYO_2XX_GOLD)
>  #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_=
CPU_PART_KRYO_2XX_SILVER)
> +#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CP=
U_PART_KRYO_3XX_GOLD)
>  #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_=
CPU_PART_KRYO_3XX_SILVER)
>  #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CP=
U_PART_KRYO_4XX_GOLD)
>  #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_=
CPU_PART_KRYO_4XX_SILVER)

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--uRtdoxvThh96Le0+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAKD+wAKCRAw5/Bqldv6
8vZoAJ48zepYUTrWWvdYAtCXSQLoJtQE6ACfaD0JqwHWYDyjSqLDbgMAk6ef6+w=
=QQCx
-----END PGP SIGNATURE-----

--uRtdoxvThh96Le0+--

