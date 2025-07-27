Return-Path: <stable+bounces-164858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63371B12FC3
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 15:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DCEB17344F
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 13:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B9B1FDE22;
	Sun, 27 Jul 2025 13:58:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1F18FC97
	for <stable@vger.kernel.org>; Sun, 27 Jul 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753624722; cv=none; b=H2O90/SRDK3gJA1EOLU8O6Wa8Ud7aEPopHSE9XyzOkTnYzMmPd389fi9gVbhIEYpR4G5jtHRoe285/uQRTmR3s3JdaB2q21drbYYJjOvOGrlgfi57yAcmMs+nouoQXwJwM//CF1RwZT45OIL5OyZXFZbCE81JfSOP/huiD8tO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753624722; c=relaxed/simple;
	bh=45ij0HfNU10sABB9D6rZh6FWZy6vTA2o4PePUhNkf/g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rbB4VZnYvEHetvg7qMLCnIYBFJFRiLUNr1/xmG8+xdYNaobife3eGG49/WjmS+tetM7PsuQOp8Qnr3BZHhfPhD7u5i3H+QIMesgC4erN/cPIyWkkdVYOkgpmGIr4n9u2hjU0Nb+3SP+X/FNyMEhHcGSZQZAUBGw0Kfxq86A5msY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1ug1tV-007PjV-2c;
	Sun, 27 Jul 2025 13:58:29 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1ug1tU-00000003rA0-1VRq;
	Sun, 27 Jul 2025 15:58:28 +0200
Message-ID: <dbea560d4fa64d8217aadc541d4b47b61f2c6766.camel@decadent.org.uk>
Subject: Re: [PATCH 2/5] x86/bugs: Add a Transient Scheduler Attacks
 mitigation
From: Ben Hutchings <ben@decadent.org.uk>
To: Borislav Petkov <bp@kernel.org>, stable@vger.kernel.org
Date: Sun, 27 Jul 2025 15:58:23 +0200
In-Reply-To: <20250715123749.4610-3-bp@kernel.org>
References: <20250715123749.4610-1-bp@kernel.org>
	 <20250715123749.4610-3-bp@kernel.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8cwgnj0OrVXzspWy3efK"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-8cwgnj0OrVXzspWy3efK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-07-15 at 14:37 +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
>=20
> Commit d8010d4ba43e9f790925375a7de100604a5e2dba upstream.
>=20
> Add the required features detection glue to bugs.c et all in order to
> support the TSA mitigation.
[...]
> +static bool amd_check_tsa_microcode(void)
> +{
> +	struct cpuinfo_x86 *c =3D &boot_cpu_data;
> +	union zen_patch_rev p;
> +	u32 min_rev =3D 0;
> +
> +	p.ext_fam	=3D c->x86 - 0xf;
> +	p.model		=3D c->x86_model;
> +	p.ext_model	=3D c->x86_model >> 4;
> +	p.stepping	=3D c->x86_stepping;
[...]

p is not fully initialised, so this only works with
CONFIG_INIT_STACK_ALL_ZERO enabled.

We need to either do:

	memset(&p, 0, sizeof(p));

before assigning to individual fields, or get rid of the union and just
do:

	u32 ucode_rev;

	ucode_rev =3D (c->x86 - 0xf) << 24 |
		(c->x86_model & 0xf) << 12 |
		(c->x86_model >> 4) << 20 |
		((c->x86_stepping & 0xf) << 8);

Ben.

--=20
Ben Hutchings
The Peter principle: In a hierarchy, every employee tends to rise to
their level of incompetence.

--=-8cwgnj0OrVXzspWy3efK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmiGMH8ACgkQ57/I7JWG
EQkcPA/+PL7hcG6Waefp0JZK7NEmU/O3muhR30078x0TLN2b9Wyw3J/CtcZQj6Hw
lcoxQ2ne80SFhFXonz2m9J0HfdW+9jvTyMkRCdBTKnM977ZeUZ0MW4/IhorXMsFf
8M/DOiNGiEj+oPA5GUJJNYYFlSXxNVtYey1DJfRpbyJ6+YdhRYo19mvg0ze8IGss
zJIEikZni7NnlKY6oOQUQF7D5sOcFkwW8gMzobt2EczY7AAuEQnOCXQBB82lMo1e
6A4RDUWC4gQlo1yvZNkQx5x+5UwuHuTPjK9b8CR/23kZ5Fb/5V6RC13UfxC0EPkY
T5KWGn6c4PWAxAK50YHroei/ujntPPqdaBXjlfUSz4Ya2HU/3qnxBEZX8VpqV9op
vbiTGfnpgh1PydW2JPHDxbZ4AJH/RRxHcCMh3AVWUDxAdbLlzVWm8bek5c0YVzgP
Pkf4ZUTq9CCbCku1OtDAheNM/wREvkfrlXsL+oHnD8P5Qj5xJYx5fweWoZhFl4j0
EwZEVKWh45sgV8BmsyU4ypHl+1O+KQI7vjDoSqgRg418UrO2Q92JBAsHmcGc9idr
teFaZXapT6UzD/rBxiCi6k0k69fnLOSPE3dipXSM7XxvchDaivuzL8Is+zuA42kq
Mvfsx52GYk5nAcxJuRmtdyYbfrf//b2iwXI6vEP7wUdnCeHAegQ=
=0SBs
-----END PGP SIGNATURE-----

--=-8cwgnj0OrVXzspWy3efK--

