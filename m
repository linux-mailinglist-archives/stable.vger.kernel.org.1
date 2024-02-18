Return-Path: <stable+bounces-20476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81516859902
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 20:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F22B2125A
	for <lists+stable@lfdr.de>; Sun, 18 Feb 2024 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AA16F09B;
	Sun, 18 Feb 2024 19:14:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA431D696;
	Sun, 18 Feb 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708283654; cv=none; b=iSkk8Zbu8odH7VfQQ+vidaxsOVms3dWkUx+6EDjipL6grBhAH5t47f/pYtb3+G41jvELK6GcjCb2zwkz3KizmttVI6TQ/I9aYkxVGwTp7FwFsVBXpFu4AXVhZX8xdTRkn6VUiZ8UmJSDahunrfQTS8Ir295euTCeLsn8ZoAppBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708283654; c=relaxed/simple;
	bh=8nYxEVYOpHSgZqEBq4o9G6bvAg9LRRjvlhmmToZRGwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyohVaLQUdue/crAOO0A6qk4UZiLhIRG3c+bX7kF/V7JnRc68U/7kfwXtNfyARFHmlKTOsHx1SSEUy6L6Jebf/fmTS7FYnmaqt30BIdBz/MaauXxUxYZZ+QEJbT2uU6vh1mMUQWPH7npB40CkXWEKHlSzKThbjcgOTom1RXBRw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1E1DD1C0071; Sun, 18 Feb 2024 20:14:11 +0100 (CET)
Date: Sun, 18 Feb 2024 20:14:10 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH AUTOSEL 6.1 05/15] x86/cpu: Add model number for Intel
 Clearwater Forest processor
Message-ID: <ZdJXAs2j6UGcSBBN@duo.ucw.cz>
References: <20240202184057.541411-1-sashal@kernel.org>
 <20240202184057.541411-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nDhKZ61i0CdEd0V8"
Content-Disposition: inline
In-Reply-To: <20240202184057.541411-5-sashal@kernel.org>


--nDhKZ61i0CdEd0V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 090e3bec01763e415bccae445f5bfe3d0c61b629 ]
>=20
> Server product based on the Atom Darkmont core.

This adds unused include, I don't believe we need it in AUTOSEL.

Best regards,
								Pavel

> +++ b/arch/x86/include/asm/intel-family.h
> @@ -160,6 +160,8 @@
> =20
>  #define INTEL_FAM6_GRANDRIDGE		0xB6
> =20
> +#define INTEL_FAM6_ATOM_DARKMONT_X	0xDD /* Clearwater Forest */
> +
>  /* Xeon Phi */
> =20
>  #define INTEL_FAM6_XEON_PHI_KNL		0x57 /* Knights Landing */

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nDhKZ61i0CdEd0V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZdJXAgAKCRAw5/Bqldv6
8ramAKC6rEmCdDkVt4KimBtwmukiNRDC6gCghwDRJbH40byvZ1GCiHjUosWPucc=
=xPDx
-----END PGP SIGNATURE-----

--nDhKZ61i0CdEd0V8--

