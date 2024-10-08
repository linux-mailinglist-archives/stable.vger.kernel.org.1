Return-Path: <stable+bounces-81991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508D994A80
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA4A28ABA8
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAB11DE4FA;
	Tue,  8 Oct 2024 12:33:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F871E493
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390811; cv=none; b=vA6B2LnIt4CRgHImJXPbAS1rVctxoxo/D90QdHsNS7n9YvYJWjCwHN9saE3QqBuCs1FKTOQMjN1JgGgZB3/BEthjDSNq0lP9KRXabezxq16E8MMdu0UAiykn5y9KW5UqKpNVRfKLV4WVIjasfzObFyKdI4EfwjYt9CeH3x8RXio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390811; c=relaxed/simple;
	bh=+sUUOR68jKR14arxgh3IpJrXa5dm0+KQfbTLw7fd0DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYWm1r2yDG7iexRq9JX472mJE1Ag1DGk4OdhT+xPq9x9sy0FRJdyTo9WD9qhI2hXNhJV0J64FHjdqPcKOfEmiDr8PtIraIn193+zr0SWAh1bzUxpsdS16S5WBSL9ZCyvgwmrVqw7b0KzO1S7flpt4Jloke2QBOIX7SsUKUctnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BB44E1C006B; Tue,  8 Oct 2024 14:33:27 +0200 (CEST)
Date: Tue, 8 Oct 2024 14:33:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@denx.de>, Jens Axboe <axboe@kernel.dk>,
	Vegard Nossum <vegard.nossum@oracle.com>, stable@vger.kernel.org,
	cengiz.can@canonical.com, mheyne@amazon.de, mngyadam@amazon.com,
	kuntal.nayak@broadcom.com, ajay.kaher@broadcom.com,
	zsm@chromium.org, dan.carpenter@linaro.org,
	shivani.agarwal@broadcom.com, ahalaney@redhat.com,
	alsi@bang-olufsen.dk, ardb@kernel.org,
	benjamin.gaignard@collabora.com, bli@bang-olufsen.dk,
	chengzhihao1@huawei.com, christophe.jaillet@wanadoo.fr,
	ebiggers@kernel.org, edumazet@google.com, fancer.lancer@gmail.com,
	florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com,
	hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl,
	ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com,
	kirill.shutemov@linux.intel.com, kuba@kernel.org,
	luiz.von.dentz@intel.com, md.iqbal.hossain@intel.com,
	mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, pablo@netfilter.org,
	rfoss@kernel.org, richard@nod.at, tfiga@chromium.org,
	vladimir.oltean@nxp.com, xiaolei.wang@windriver.com,
	yanjun.zhu@linux.dev, yi.zhang@redhat.com, yu.c.chen@intel.com,
	yukuai3@huawei.com
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
Message-ID: <ZwUml+OpEzrZNTRZ@duo.ucw.cz>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <ZwUUjKD7peMgODGB@duo.ucw.cz>
 <2024100820-endnote-seldom-127c@gregkh>
 <ZwUY/BMXwxq0Y9+F@duo.ucw.cz>
 <2024100828-scuff-tyke-f03f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wDAyIo9EMxXVwJqU"
Content-Disposition: inline
In-Reply-To: <2024100828-scuff-tyke-f03f@gregkh>


--wDAyIo9EMxXVwJqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > And yes, many bugs at this level (turns out about 25% of all stable
> > > commits) match that definition, which is fine.  If you have a problem
> > > with this, please take it up with cve.org and their rules, but don't =
go
> > > making stuff up please.
> >=20
> > You are assigning CVE for any bug. No, it is not fine, and while CVE
> > rules may permit you to do that, it is unhelpful, because the CVE feed
> > became useless.
>=20
> Their rules _REQUIRE_ us to do this.  Please realize this.

If you said that limited manpower makes you do this, that would be
something to consider. Can you quote those rules?

I'd expect vulnerability description to be in english, not part of
english text and part copy/paste from changelog. I'd also expect
vulnerability description ... to ... well, describe the
vulnerability. While changelogs describe fix being made, not the
vulnerability.

Some even explain why the bug being fixed is not vulnerability at all,
like this one. (Not even bug, to be exact. It is workaround for static
checker).

I don't believe the rules are solely responsible for this.

> > (And yes, some people are trying to mitigate damage you are doing by
> > disputing worst offenders, and process shows that quite often CVEs get
> > assigned when they should not have been.)
>=20
> Mistakes happen, we revoke them when asked, that's all we can do and
> it's worlds better than before when you could not revoke anything and
> anyone could, and would, assign random CVEs for the kernel with no way
> to change that.

Yes, way too many mistakes happen. And no, it is not an improvement
over previous situation.=20

Best regards,
								Pavel

https://www.cve.org/CVERecord?id=3DCVE-2023-52472

Published: 2024-02-25
Updated: 2024-05-29
Title: Crypto: Rsa - Add A Check For Allocation Failure

Description
In the Linux kernel, the following vulnerability has been resolved: crypto:=
 rsa - add a check for allocation failure Static checkers insist that the m=
pi_alloc() allocation can fail so add a check to prevent a NULL dereference=
=2E Small allocations like this can't actually fail in current kernels, but=
 adding a check is very simple and makes the static checkers happy.


--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wDAyIo9EMxXVwJqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwUmlwAKCRAw5/Bqldv6
8tCbAKCokBj+11pzOtH/ro1herHiHL7prgCfeuUXiluNsUrHPSLwytcU4lhUcu4=
=yXtu
-----END PGP SIGNATURE-----

--wDAyIo9EMxXVwJqU--

