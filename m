Return-Path: <stable+bounces-176765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B978B3D4B2
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 20:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75FF51896F78
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4A26F467;
	Sun, 31 Aug 2025 18:25:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24890264617
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756664713; cv=none; b=gYyBq6NXqzNACg9X/lOqwCVC9Yw6KLXCYpIkzwjKXfkgUKZBKy4WGoicC11+26FrBvqVzDgOqa0r0kQliEFKvLPINFNc1n/umNE+M4f0Gzy9RpnjOJuUlx1FSaO8fPAGLiCYd4B3PspICOA6Au9wQFYD7df8NbCcMzmFsgc0hZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756664713; c=relaxed/simple;
	bh=a9pmT9+FAriYOqi/ZiGYDupoU5oK6dusFXBzP5Uyp98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lg6CJEldsx8XOH0yP0ndeNQbrpFUE9NGDZfs2NxNPHAU1+1LjXjOU+L2OWvweM3I5LkXnwp8tk8RqBf9TkaQ2DRQXHMG+8sON2GHaC3mts9sR2zlgiDAjp9v8UQnQYHp7mY6ZB+dN27dtzRjhxOl50Vlg/pq7Yn2Uyr2N0mN/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [192.168.0.1] (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id B5E12335D42;
	Sun, 31 Aug 2025 18:25:10 +0000 (UTC)
Message-ID: <32b1c5d75fbc391ac2e8ce9857adc907797f7d81.camel@gentoo.org>
Subject: Re: 5.10 backport request: ASoC: Intel: sof_rt5682: shrink
 platform_id names below 20 characters
From: =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org
Date: Sun, 31 Aug 2025 20:25:07 +0200
In-Reply-To: <2025082909-plutonium-freestyle-5283@gregkh>
References: <53696f9e03ff0aa2d8ef3903293e49723df967d1.camel@gentoo.org>
	 <55a3d4952c689938775a17df7eeec447e17e9f42.camel@gentoo.org>
	 <2025082909-plutonium-freestyle-5283@gregkh>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-O7RWrlhpw3gTeD3rW+mK"
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-O7RWrlhpw3gTeD3rW+mK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-08-29 at 15:55 +0200, Greg KH wrote:
> On Fri, Aug 29, 2025 at 09:09:33AM +0200, Micha=C5=82 G=C3=B3rny wrote:
> > Hello,
> >=20
> > On Fri, 2025-08-29 at 08:03 +0200, Micha=C5=82 G=C3=B3rny wrote:
> > > Hello,
> > >=20
> > > I would like to request backporting the following patch to 5.10 serie=
s:
> > >=20
> > >   590cfb082837cc6c0c595adf1711330197c86a58
> > >   ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characte=
rs
> > >=20
> > > The patch seems to be already present in 5.15 and newer branches, and
> > > its lack seems to be causing out-of-bounds read.  I've hit it in the
> > > wild while trying to install 5.10.241 on i686:
> > >=20
> > >   sh /var/tmp/portage/sys-kernel/gentoo-kernel-5.10.241/work/linux-5.=
10/scripts/depmod.sh depmod 5.10.241-gentoo-dist
> > > depmod: FATAL: Module index: bad character '=EF=BF=BD'=3D0x80 - only =
7-bit ASCII is supported:
> > > platform:jsl_rt5682_max98360ax=EF=BF=BD
> > >=20
> >=20
> > I'm sorry, I should've waited for my test results first.  Looks like
> > this patch alone is insufficient.  Looking at 5.15 stable branch, I see
> > that we probably need:
> >=20
> >     ASoC: Intel: bxt_da7219_max98357a: shrink platform_id below 20 char=
acters
> >     ASoC: Intel: sof_rt5682: shrink platform_id names below 20 characte=
rs
> >     ASoC: Intel: glk_rt5682_max98357a: shrink platform_id below 20 char=
acters
> >     ASoC: Intel: kbl_da7219_max98357a: shrink platform_id below 20 char=
acters
> >     ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 chara=
cters
> >     ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
> >     ASoC: Intel: Fix platform ID matching
> >=20
> > Unless I'm mistaken, the firt series are part of the merge commit
> > 98c69fcc9f5902b0c340acdbbfa365464efc52d2.  The followup fixes are:
> >=20
> >     0f32d9eb38c13c32895b5bf695eac639cee02d6c
> >     f4eeaed04e861b95f1f2c911263f2fcaa959c078
> >=20
> > I didn't find anything else that seemed obviously elevant, but I didn't
> > dug deep.  With these backports, I can build 5.10.241 fine -- but I
> > don't have any hardware to test these drivers.
>=20
> So what exact commits are needed and in what order?  Can you just send
> tested backports to us so that we know we got it right?

Would it be okay if I cherry-picked them from 5.15.y rather than from
master?

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-O7RWrlhpw3gTeD3rW+mK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQFGBAABCgAwFiEEx2qEUJQJjSjMiybFY5ra4jKeJA4FAmi0k4MSHG1nb3JueUBn
ZW50b28ub3JnAAoJEGOa2uIyniQOtoAH+wZR91abPOSW4LudVtym32a9meGN6KfU
9KeZOvxx0P91NtoLGGbNKyQt2WVBCKY634pf8fhyfAR73/twuG/mSOFQPXWqUzmU
y7MtHw1CCJ9hXEwdPYz1bMfkHnN5c2MVc3adn8T0uKcnrk5gMD/KQGe/iIFx7Ea3
PCliVwzTCi32i/Ys9gnoyuNhrZmDOZHULBN4jliktI8r8EepS9W0Zg4W0gGqyWlG
iSz1BRzyquCfFt+wMTcTbjFB9Wl4lZYGrHQJdC9x85rTVh6fUx82k7hiz8tkaESm
uar24zcqbdf+SYvkn44Wu63i1t2akE4gAiJWq2rK/0HPs3f75vhRDVk=
=B6J0
-----END PGP SIGNATURE-----

--=-O7RWrlhpw3gTeD3rW+mK--

