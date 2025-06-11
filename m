Return-Path: <stable+bounces-152446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C977AD5C81
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 18:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6033A896D
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 16:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138362063D2;
	Wed, 11 Jun 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mQEtm9mN"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D25202981
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660058; cv=none; b=W4EanD+cJhTwwfpT2GEmXan5tzkzIGpJkloacdNR2juIscdDoSLi5CzIiFD18Kv2nSIZQ9GcV7ntsdnXjt/E3Wv/snLZ3ZXLh6ipNfD+Hb4Q4GImwP5ufDdHLXSgRLFHJ8qzYcmWidGGJMkt5Sf44aL07FzYVlprfXNDgXctR+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660058; c=relaxed/simple;
	bh=/6eyRRANtwCdEcAc81Ue2N4a43wLrgsSwCP2Bx5UkAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMxbjAFZvOLvfI1Ell/dgxnB1tMd2wbPwFJ6YejRh6ccD6Qt1P02EAaF9FXR9RwdUh9RpvfoNnVlV7pQ8BwFwisa7y5V0JJ5j0iGCzBJGfboPw2eQoIMIZdi6r8xNfbWkTXhL+RHEoRa5xRQr1+uaa3owhXBRUl1QQAx83b8pRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mQEtm9mN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so66068f8f.1
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749660051; x=1750264851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jz3zcDTTQk1I6bLW6bPLRoyLpYGLTqEdEcVzh4gsi0g=;
        b=mQEtm9mNtDofDE+excWoSCCbOPiYHF4r7yPJnR8onjDAld4YGBmqhCKdYbeAdiIVyw
         ObRMmx7a+iPcqg45x1/xigB4xbmX8AQ8pTHQlxZWx9n3zTx7K+6w6pHECK37jK9q4wVh
         kh6E0yHqJXDqLKB0mokCeWS7yxMuNBSddfG4SMqC2WXyP7jJLgNePKQFvNmnBEpbMa6p
         UAegF6DiPeidNTPNENmedHmpwViIMB0L2Y2DTkL0OpuoUW2diHrWaxmgmvn+W0GDlYfJ
         TAFZLiEplnFi/Dy6A0ma4vSPN2Q1acvIQ+1MtG8SQ6xUOuYrGKpThhOLHI3SQ3JnJ4aW
         E+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660051; x=1750264851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz3zcDTTQk1I6bLW6bPLRoyLpYGLTqEdEcVzh4gsi0g=;
        b=cFFwDPma/RUtJOq7+oNc4B9L3bSXLIrAnVIsibCMypvqccKLixJr3rj+DIb74DoS2D
         ITW9zCbMUoYbQUxhn48YOANH5GzbHPTE3XhPXljmcKvwbJzRv7RI7mEyXVzz00aqgttz
         xIxw4hEFWN7Gfm1OaVzlu4Fopeag7Bh3dRJ/9893wHK7YqQU7wOVBNN1gTVvbdco0nWh
         UsnfiNyxr92Bsyu8Vv93jwMD++G+SI4AZvvOJJ64yDzJ3SNE/xuGGG+qUooDylGyVXP/
         dDBrfxVieRRY5nwOhg8TXD24ZygXHMSY2IPUVmtft/221sQWMVvw6Ts5qJbmWoVeW9Ah
         vG/g==
X-Forwarded-Encrypted: i=1; AJvYcCW7VpSJbji49mGo4FV9Szx6UDAC6Z7z8H1DRyWSAZfwjH5Uv+XZtnfPAXwqBWYimv7qpl/EbtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0CM7zu2zcy/FPjQ4LtstDI0klaJ51TYDjl/n/VXEek7wD77hj
	uK48Fl6ai6P7N3jB6BiKabmUKMNVmxoCgU0ZMoOyo0j33EE/L/2eQCklNGzkr6IPW4t1uKTe2XN
	L9g1s
X-Gm-Gg: ASbGnctP1vPmYFwDg32Ail1c8F8oOlKvwI3o8JXrLMSwurJLVbtS0YKw3zEgiVh0iy9
	QuG1T2P+qZtzoyHOhkp2RSweBipGtq75AUu/JjuHMtOkgDyMoEmisj4k2GyiemlL5dF3WfbRn/u
	FdWjhNPomB33byJlDBM5LZOUDQyyQzRqDqlZ4OhQY6wwcClfyyraNlx64Gb0VbvGZUWGtCkkU+i
	244p8nsLuZGXrcVwI2RTDyrWGiepwTvLoYAcNPbdfjB7giSn4PxlDCKdQdnTM6YgW8sCzkAAqlY
	HiBlW5WG7DrRyrmeXFujT4FjLReUurMYa82Jo7LR+Fa8BgbococGEKuHQCye0Bybp2TeZLPrbbw
	YzPdX/6IUiH+yKpxty2ppZq+5Q+wf
X-Google-Smtp-Source: AGHT+IFI+EBnQlswVejgehxAiVf5xKnGx4c0e+6Dst82gz+K4BCYFpQbPA3/jk2LywLWEGxTCZnveQ==
X-Received: by 2002:a05:6000:2282:b0:3a4:d53d:be22 with SMTP id ffacd0b85a97d-3a558800edcmr2945559f8f.58.1749660050935;
        Wed, 11 Jun 2025 09:40:50 -0700 (PDT)
Received: from localhost (p200300f65f13c80400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f13:c804::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45325226682sm25886195e9.36.2025.06.11.09.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:40:50 -0700 (PDT)
Date: Wed, 11 Jun 2025 18:40:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg KH <gregkh@linuxfoundation.org>, 
	Ingo Saitz <ingo@hannover.ccc.de>
Cc: 1104745@bugs.debian.org, stable@vger.kernel.org
Subject: Re: Bug#1104745: gcc-15 ICE compiling linux kernel 6.14.5 with
 CONFIG_RANDSTRUCT
Message-ID: <snq7vjlketwasar4jdufnoostk7xm7umdm6y2xao4tmi4653pd@d6uemvag32nj>
References: <174645965734.16657.5032027654487191240.reportbug@spatz.zoo>
 <hix7rqnglwxgmhamcu5sjkbaeexsogb5it4dyuu7f5bzovygnj@3sn4an7qgd6g>
 <aEVJDjS6_po-kMj-@spatz.zoo>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wmft4jswazlqcapc"
Content-Disposition: inline
In-Reply-To: <aEVJDjS6_po-kMj-@spatz.zoo>


--wmft4jswazlqcapc
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1104745: gcc-15 ICE compiling linux kernel 6.14.5 with
 CONFIG_RANDSTRUCT
MIME-Version: 1.0

Hello Greg, hello Ingo,

On Sun, Jun 08, 2025 at 10:25:50AM +0200, Ingo Saitz wrote:
> On Wed, Jun 04, 2025 at 10:43:11PM +0200, Uwe Kleine-K=F6nig wrote:
> > Control: tag -1 + fixed-upstream
> > Control: forwarded -1 https://lore.kernel.org/r/20250530221824.work.623=
-kees@kernel.org
> >=20
> > Hello,
> >=20
> > On Mon, May 05, 2025 at 05:40:57PM +0200, Ingo Saitz wrote:
> > > When compiling the linux kernel (tested on 6.15-rc5 and 6.14.5 from
> > > kernel.org) with CONFIG_RANDSTRUCT enabled, gcc-15 throws an ICE:
> > >=20
> > > arch/x86/kernel/cpu/proc.c:174:14: internal compiler error: in compty=
pes_check_enum_int, at c/c-typeck.cc:1516
> > >   174 | const struct seq_operations cpuinfo_op =3D {
> > >       |              ^~~~~~~~~~~~~~
> >=20
> > This is claimed to be fixed in upstream by commit
> > https://git.kernel.org/linus/f39f18f3c3531aa802b58a20d39d96e82eb96c14
> > that is scheduled to be included in 6.16-rc1.
>=20
> I can confirm applying the patches
>=20
>     e136a4062174a9a8d1c1447ca040ea81accfa6a8: randstruct: gcc-plugin: Rem=
ove bogus void member
>     f39f18f3c3531aa802b58a20d39d96e82eb96c14: randstruct: gcc-plugin: Fix=
 attribute addition
>=20
> fixes the compile issue (on vanilla 6.12, 6.14 and 6.15 kernel trees;
> the kernels seem to run fine, too, so far). The first patch was needed
> for the second to apply cleanly. But I can try to backport only
> f39f18f3c3531aa802b58a20d39d96e82eb96c14 and see if it still compiles.

@Ingo: Thanks for testing and confirming the backport works.

@gregkh: I think it's reasonable to backport both
e136a4062174a9a8d1c1447ca040ea81accfa6a8 and
f39f18f3c3531aa802b58a20d39d96e82eb96c14. Do you already have these on
your radar?

Best regards
Uwe

--wmft4jswazlqcapc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhJsYwACgkQj4D7WH0S
/k7p4QgAs2IyNUlagvq6dYvu+FazwrwDo9aeaeBfmDKQQcyM4NxtK8XJrv0OTe7r
GGDZXYMsHOIghFmoOUFhg9JdmrJy9a+HKsAX4a6R370VR4Fth71sL3FowmFGfZ4P
1Kvm0Ac4nZLEuKsyXl9LAkNsFJDBY1B9X91F0FukHs3/A3DQVdzASutPNt2LHQfw
YPPRnA7lNGtfIgppvWLkGz3647vPBIFpG0362PI+syRtXte29CvlYKigP26snOCm
jzTs8jXM3T/q/R7qMJLigfxVO+hxOcBk8znYIANQwQZBc7+eKAWbgN5EXoIULoQd
CGi/0n/2TkmS20zGUI1BK9//ntD6Iw==
=+a3R
-----END PGP SIGNATURE-----

--wmft4jswazlqcapc--

