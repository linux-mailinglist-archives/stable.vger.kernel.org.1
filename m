Return-Path: <stable+bounces-134625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2926A93B6D
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DAC172A27
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98B6215F4B;
	Fri, 18 Apr 2025 16:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Kb/7DIgt"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252AE215792;
	Fri, 18 Apr 2025 16:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995285; cv=none; b=SrbtII8PX2dm6R8SpSMPQFxWOqRrTDPiYMQdlzanII2MvVgULv9G1UN/EczaI2a6pRN/lULuAkBKA06/jHrqWIM5efyQDvoO5SQLZhjZchTashH8jbuGAmKcL5inkQ/texE5wBLhCHpasdEBcIRZdzqgZd8mfXLgLmy1mcUb7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995285; c=relaxed/simple;
	bh=j7fNl3tHVUdXIBqTvyHtLGQvCjLhT0OY1thb0ltxEyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLVBPc+MJfhMVnaQgkBZO96Oj27m44NxjOTD1IrMs+SttTYgmRueTTnvpXHwPbhjdOkZolLdOFDLtqpmVF4rcs2bWtbcMmMnozo8uDpv6CAAmC+be6c7Zqw7x0B3gafnLGsPdywSvdszDl3kpXH/VHYDLLcqSPvC+qjQ6uDaL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Kb/7DIgt; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71E451026E029;
	Fri, 18 Apr 2025 18:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744995280; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=TAqX++6Pz/ZYQQAXoqXwuM4rSIQviXyqdaPFZ7+tlKo=;
	b=Kb/7DIgtRcM41ZsxZkrECY9DLkPpFfYpIUGIo+o031MdcoVIPPj7zWKbmntUdnptQ4u78d
	ALl5SJSjmXnigieQ6oDUD8hCI13qjnKp83KLwag4xicWOZw11CD5ishAMs2Yc3aTV+zYs+
	xAWzZe5qJTReQ8rAe5IAZ/iVmoezsHDTlsDS1zy/B0nC2mtqWc9DIGnXHx6E+Z47KEGGzn
	oE8ZdoH6ro+Vlze+bCPwEysByjyMGXsOjzG72KCRHOSb1yZN0FGObsNPjFqgYVB+NW1CdH
	ah5EA2UcM463UfMXEay2ZIgBr2pxecWQxTjn9joG6NRi3qDzEl0KZD2mnXqGUQ==
Date: Fri, 18 Apr 2025 18:54:32 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Max Grobecker <max@grobecker.info>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	thomas.lendacky@amd.com, perry.yuan@amd.com,
	mario.limonciello@amd.com, riel@surriel.com, mjguzik@gmail.com,
	seanjc@google.com, darwi@linutronix.de
Subject: Re: [PATCH AUTOSEL 5.10 2/6] x86/cpu: Don't clear
 X86_FEATURE_LAHF_LM flag in init_amd_k8() on AMD when running in a virtual
 machine
Message-ID: <aAKDyGpzNOCdGmN2@duo.ucw.cz>
References: <20250331143710.1686600-1-sashal@kernel.org>
 <20250331143710.1686600-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+9WIDzG7gKAFMWwy"
Content-Disposition: inline
In-Reply-To: <20250331143710.1686600-2-sashal@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3


--+9WIDzG7gKAFMWwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Max Grobecker <max@grobecker.info>
>=20
> [ Upstream commit a4248ee16f411ac1ea7dfab228a6659b111e3d65 ]

> This can prevent some docker containers from starting or build scripts to=
 create
> unoptimized binaries.
>=20
> Admittably, this is more a small inconvenience than a severe bug in the k=
ernel
> and the shoddy scripts that rely on parsing /proc/cpuinfo
> should be fixed instead.

I'd say this is not good stable candidate.

Best regards,
								Pavel

> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -839,7 +839,7 @@ static void init_amd_k8(struct cpuinfo_x86 *c)
>  	 * (model =3D 0x14) and later actually support it.
>  	 * (AMD Erratum #110, docId: 25759).
>  	 */
> -	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM)) {
> +	if (c->x86_model < 0x14 && cpu_has(c, X86_FEATURE_LAHF_LM) && !cpu_has(=
c, X86_FEATURE_HYPERVISOR)) {
>  		clear_cpu_cap(c, X86_FEATURE_LAHF_LM);
>  		if (!rdmsrl_amd_safe(0xc001100d, &value)) {
>  			value &=3D ~BIT_64(32);

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+9WIDzG7gKAFMWwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAKDyAAKCRAw5/Bqldv6
8pngAJ903ri4tAqDyAQ87mK58oN4vwjsvACghbk/ai+TZYVEE7l+NIcp0w76jF4=
=N72X
-----END PGP SIGNATURE-----

--+9WIDzG7gKAFMWwy--

