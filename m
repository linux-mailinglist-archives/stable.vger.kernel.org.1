Return-Path: <stable+bounces-81583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2613C994765
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E87A1C20EF2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2FF13D246;
	Tue,  8 Oct 2024 11:40:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC63A1CD
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387614; cv=none; b=lQnd7anTBNQci7lO9CMRoyl0BKhu/owRg7tSRY+gd7XtgRLKWgW0qVK119A/4qE4NVRadr+EKnqw1taMoFL+XUK9KJq81Qdm2ChCWJg3pFhaMZdKMMnHtSYDKwSh4d5J+ZjHC6rrqOgvUPKtx1ldySA7XFjEVVFNZGkqFm0ME24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387614; c=relaxed/simple;
	bh=02H+TSkwG7VmV1ZyCanULDQgTyzjB7Gqngsl92bH1Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGF0scVL6pp6sUQDtc4oOd967/R1it/xDt2QDcHuiYKf8pAr4md4JBaLVMAnfLwT5d1nOJmqlT36nnTAorJc4P1Ln6zGxkKLERSijxvCnAaRp+OR7Xi6ypxVKcoISP6d4Yu42V/P5JbKPOiUlkF9fYWLrwhKP+CBTa6l6DihAUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CD7F11C006B; Tue,  8 Oct 2024 13:40:10 +0200 (CEST)
Date: Tue, 8 Oct 2024 13:40:10 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@denx.de>, Vegard Nossum <vegard.nossum@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org,
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
Message-ID: <ZwUaGvyHBePPNQF/@duo.ucw.cz>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <69e265b4-fae2-4a60-9652-c8db07da89a1@oracle.com>
 <ZwUVPCre5BR6uPZj@duo.ucw.cz>
 <2024100823-barbed-flatness-631c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PI6/zF5QDGYHmGgy"
Content-Disposition: inline
In-Reply-To: <2024100823-barbed-flatness-631c@gregkh>


--PI6/zF5QDGYHmGgy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2024-10-08 13:24:31, Greg Kroah-Hartman wrote:
> On Tue, Oct 08, 2024 at 01:19:24PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > Unfortunately for distributions, there may be various customers or
> > > government agencies which expect or require all CVEs to be addressed
> > > (regardless of severity), which is why we're backporting these to sta=
ble
> > > and trying to close those gaps.
> >=20
> > Customers and government will need to understand that with CVEs
> > assigned the way they are, addressing all of them will be impossible
> > (or will lead to unstable kernel), unfortunately :-(.
>=20
> Citation needed please.

https://opensourcesecurity.io/category/securityblog/

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--PI6/zF5QDGYHmGgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwUaGgAKCRAw5/Bqldv6
8shSAJ9kMlJMvZkB9jhL/bhzmpN/HRc3GQCffHCNp/vMdZu1TI7VvqsMIfLS3cs=
=JPms
-----END PGP SIGNATURE-----

--PI6/zF5QDGYHmGgy--

