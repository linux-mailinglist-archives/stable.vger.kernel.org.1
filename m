Return-Path: <stable+bounces-95843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD58D9DECE6
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 22:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C7F281E98
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941BE1A08AB;
	Fri, 29 Nov 2024 21:27:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC189155300;
	Fri, 29 Nov 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915647; cv=none; b=X2UDa639qHUy8b7owrEAsM8RaBSwYr9MrjWtzA3uIq6/JKkMZV1ZDFePW1dKiXzymsspEKc+Wkd/e0zgWA4+WReWUhBbuNxRxQPumTN5Qq8+qSEpvbE2hMOVB2M+1YXXj5WFgMfGnzp/RlF832TnCUUZ5ztB1MEVhak4ehknkjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915647; c=relaxed/simple;
	bh=76sfWPPa1/SV8pCOjiE3xLXocvoPaWYuIf/151AEDKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccPu6NWhsmX1jGnt7oI6GnoH4WxB4tU9rU+KQA4+EsTUo7Y7m3xRWz3u0F6o1GcAWbKvlYXuZqZO2sUQCAtsqQJOvYIhcSRC++4R/ENU+5t02f7t4QyCPMjJ+phDR0bosZdmHkJXzNf10eKYf6OvxR5RYQ+BGalG9CpsvDQvwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0064A1C00A0; Fri, 29 Nov 2024 22:27:22 +0100 (CET)
Date: Fri, 29 Nov 2024 22:27:22 +0100
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
Message-ID: <Z0oxuu/AASgIOkTa@duo.ucw.cz>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
 <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
 <Z0mNTEw2vK1nJpOo@duo.ucw.cz>
 <Z0nD6NZc3wmq8_v9@sashalap>
 <Z0olbd3OYQnlmW+D@duo.ucw.cz>
 <Z0opMka39d0mV3DZ@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PGrglMEykJLBTiqn"
Content-Disposition: inline
In-Reply-To: <Z0opMka39d0mV3DZ@sashalap>


--PGrglMEykJLBTiqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > >   - Serious issues as reported by a user of a distribution kernel may=
 also
> > >     be considered if they fix a notable performance or interactivity =
issue.
> > >=20
> > > It sounds like what's going on here, no?
> >=20
> > Is it? I'd not expect this to be visible in anything but
> > microbenchmarks. Do you have user reports hitting this?
> >=20
> > It is not like this makes kernel build 10% slower, is it?
>=20
> On Fri, Nov 29, 2024 at 10:30:11AM +0100, Erwan Velu wrote:
> > This patch greatly impacts servers on production with AMD systems that
> > have lasted since 5.11, having it backported really improves systems
> > performance.
> > Since this patch, I can share that our database team is no longer
> > paged during the night, that's a real noticeable impact.

Ok, looks like I misjudged the performance impact, sorry for the
noise.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PGrglMEykJLBTiqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ0oxugAKCRAw5/Bqldv6
8tkRAKCDcLBQwYzUDwLQIFV1f/3wtwtYJgCggPRpP6HEjgSWs2/FjPCzRtOnb7M=
=20C0
-----END PGP SIGNATURE-----

--PGrglMEykJLBTiqn--

