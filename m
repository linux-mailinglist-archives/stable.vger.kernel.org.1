Return-Path: <stable+bounces-176684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C3B3B3E3
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 09:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48031B20E93
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DED326561D;
	Fri, 29 Aug 2025 07:09:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE328262FE7
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756451380; cv=none; b=OJopX+VEu8gHrZlb+ZHfVGk2caKEst1Vt2IilAXHFmR3lMpea1xs+0riHKPRLN5ZAGXPyVCWuu2cV7ScEl/njOnC/6xOf107cVbM41ayQjinbfbJftGdgg9um0ZuKXq3Mep+1ex6oNKQ1c7LXEgUR0xfboPEI9TRWD0UmMKEoCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756451380; c=relaxed/simple;
	bh=UyaBQImhbmqm78BChDaYVwWEyppNidecrBiit2kQOCM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ChXW0jtv94nxMFudguFnsB9MaktP1D+QWRJDaqJLaxWYImFVN20spMqtewmVehy8cpJsxT+b+IylzfbwonheDm4TS1x7ToVEaEofaKD3prP0Lale1LpzGCaqs3Of2VihBitbZXwWBMRMwx1dLeJRBt7d1jZ6fN3zAp/mCAwT/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [192.168.0.1] (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id A913F340D4C;
	Fri, 29 Aug 2025 07:09:36 +0000 (UTC)
Message-ID: <55a3d4952c689938775a17df7eeec447e17e9f42.camel@gentoo.org>
Subject: Re: 5.10 backport request: ASoC: Intel: sof_rt5682: shrink
 platform_id names below 20 characters
From: =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To: stable@vger.kernel.org
Date: Fri, 29 Aug 2025 09:09:33 +0200
In-Reply-To: <53696f9e03ff0aa2d8ef3903293e49723df967d1.camel@gentoo.org>
References: <53696f9e03ff0aa2d8ef3903293e49723df967d1.camel@gentoo.org>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-azcm1xC0lmIUjVcOl7zz"
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-azcm1xC0lmIUjVcOl7zz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, 2025-08-29 at 08:03 +0200, Micha=C5=82 G=C3=B3rny wrote:
> Hello,
>=20
> I would like to request backporting the following patch to 5.10 series:
>=20
>   590cfb082837cc6c0c595adf1711330197c86a58
>   ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
>=20
> The patch seems to be already present in 5.15 and newer branches, and
> its lack seems to be causing out-of-bounds read.  I've hit it in the
> wild while trying to install 5.10.241 on i686:
>=20
>   sh /var/tmp/portage/sys-kernel/gentoo-kernel-5.10.241/work/linux-5.10/s=
cripts/depmod.sh depmod 5.10.241-gentoo-dist
> depmod: FATAL: Module index: bad character '=EF=BF=BD'=3D0x80 - only 7-bi=
t ASCII is supported:
> platform:jsl_rt5682_max98360ax=EF=BF=BD
>=20

I'm sorry, I should've waited for my test results first.  Looks like
this patch alone is insufficient.  Looking at 5.15 stable branch, I see
that we probably need:

    ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 characte=
rs
    ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characters
    ASoC: Intel: glk_rt5682_max98357a: shrink platform_id below 20 characte=
rs
    ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20 characte=
rs
    ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 character=
s
    ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
    ASoC: Intel: Fix platform ID matching

Unless I'm mistaken, the firt series are part of the merge commit
98c69fcc9f5902b0c340acdbbfa365464efc52d2.  The followup fixes are:

    0f32d9eb38c13c32895b5bf695eac639cee02d6c
    f4eeaed04e861b95f1f2c911263f2fcaa959c078

I didn't find anything else that seemed obviously elevant, but I didn't
dug deep.  With these backports, I can build 5.10.241 fine -- but I
don't have any hardware to test these drivers.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-azcm1xC0lmIUjVcOl7zz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQFGBAABCgAwFiEEx2qEUJQJjSjMiybFY5ra4jKeJA4FAmixUi0SHG1nb3JueUBn
ZW50b28ub3JnAAoJEGOa2uIyniQO9iIH/0JZJqnvejIUGs/46d1MzkcEO35jsSuk
7C52bzggS2qSYfhqgV7RNIerEUdBw0+JKXcDQaDAxuk135pVyhqqeOEet0zreXlE
8UTQGbvXQ403mrzgAAJ1kYLXsY9s5C1ldR1o5Fm+1QR30iO3u/m59vDZg9ESXeUo
UYhgUhq8qc90u/BvCyEb6wrzMOuNGzs4lMDCOfpsllzfb3MBNrDfJnsGdc5OeplY
pnbKHD12yKVuKy9z0S/brUyXSKXCAe7U3LaZ7RxxTu2ff3qIHAxzmTcSIljsUTPy
P1yMaBX5KgaodjYncLIOQQH6yTMLveINjD7FsrFMqDhl8sIo+xR9RGA=
=MAuK
-----END PGP SIGNATURE-----

--=-azcm1xC0lmIUjVcOl7zz--

