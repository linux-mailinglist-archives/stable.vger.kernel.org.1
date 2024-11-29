Return-Path: <stable+bounces-95837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B109DECB6
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F07216330B
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6715697B;
	Fri, 29 Nov 2024 20:35:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B1313AA35;
	Fri, 29 Nov 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912505; cv=none; b=Oe8Rh+j1ZOTUjMwjsuWf/7bLjpG7idtX4ScR/nxfv1ZPeZa1nQKeJ7lJMCfpUzV0BOgrX6v1qjYYiCTy0JuqhtlQVnIN5pMSf39xoQOgZnFCZuc+7FS4HtaI2fVYoW+gCQC4xnxkw81eVl05qf/KML5pciXNCMapQZXsDZlR/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912505; c=relaxed/simple;
	bh=YMFWazRWvhRQepmnWfacv5koAFIfgM6etwtnuQizzpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lywr0p3pfxHmd5/aeS8INExmzFv/xWMFvw1Kt5UqqmChUvhyqnXgGrmO8WxLOJqbAefcCOgRd23e9siGlLqvWXSJmo2vHhUwJzNlwhf672+13lzVbIRUGycmLvBZRGGEeD788MZ9Cfc11irrCcBEAWgDCBhHkjkzQ/afTW7Fj9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 1BC381C00A0; Fri, 29 Nov 2024 21:34:54 +0100 (CET)
Date: Fri, 29 Nov 2024 21:34:53 +0100
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: Pavel Machek <pavel@denx.de>, Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com,
	kim.phillips@amd.com, jmattson@google.com, babu.moger@amd.com,
	peterz@infradead.org, rick.p.edgecombe@intel.com, brgerst@gmail.com,
	ashok.raj@intel.com, mjguzik@gmail.com, jpoimboe@kernel.org,
	nik.borisov@suse.com, aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com,
	Erwan Velu <erwanaliasr1@gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <Z0olbd3OYQnlmW+D@duo.ucw.cz>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
 <Z0mNTEw2vK1nJpOo@duo.ucw.cz>
 <Z0nD6NZc3wmq8_v9@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E/ga9PEn1OI4TTxc"
Content-Disposition: inline
In-Reply-To: <Z0nD6NZc3wmq8_v9@sashalap>


--E/ga9PEn1OI4TTxc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2024-11-29 08:38:48, Sasha Levin wrote:
> On Fri, Nov 29, 2024 at 10:45:48AM +0100, Pavel Machek wrote:
> > Hi!
> >=20
> > > > You've missed the 5.10 mail :)
> > >=20
> > > You mean in the flood? ;-P
> > >=20
> > > > Pavel objected to it so I've dropped it: https://lore.kernel.org/al=
l/Zbli7QIGVFT8EtO4@sashalap/
> > >=20
> > > So we're not backporting those anymore? But everything else? :-P
> > >=20
> > > And 5.15 has it already...
> > >=20
> > > Frankly, with the amount of stuff going into stable, I see no problem=
 with
> > > backporting such patches. Especially if the people using stable kerne=
ls will
> > > end up backporting it themselves and thus multiply work. I.e., Erwan'=
s case.
> >=20
> > Well, some people would prefer -stable to only contain fixes for
> > critical things, as documented.
> >=20
> > stable-kernel-rules.rst:
> >=20
> > - It must fix a problem that causes a build error (but not for things
> >   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
> >   security issue, or some "oh, that's not good" issue.  In short, somet=
hing
> >   critical.
> >=20
> > Now, you are right that reality and documentation are not exactly
> > "aligned". I don't care much about which one is fixed, but I'd really
> > like them to match (because that's what our users expect).
>=20
> You should consider reading past the first bullet in that section :)
>=20
>   - Serious issues as reported by a user of a distribution kernel may also
>     be considered if they fix a notable performance or interactivity issu=
e.
>=20
> It sounds like what's going on here, no?

Is it? I'd not expect this to be visible in anything but
microbenchmarks. Do you have user reports hitting this?

It is not like this makes kernel build 10% slower, is it?
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--E/ga9PEn1OI4TTxc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ0olbQAKCRAw5/Bqldv6
8nqWAKCCRon2Yj6x3KIUKSIIIdoM+cRC2ACeN7Blhft5imjMVc0BI9j3TD6S7DE=
=OHlZ
-----END PGP SIGNATURE-----

--E/ga9PEn1OI4TTxc--

