Return-Path: <stable+bounces-81581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E013E994751
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096AF1C25233
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA431D460F;
	Tue,  8 Oct 2024 11:35:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A454B1D4342
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387329; cv=none; b=q/0VLl+qgXqLqvfyT+pUYSNRdsip5tVyi8A0f6LuooMcMTUThH31Jw+5ujHn2gALf+EKzyu/BBMQbA+bifzbUQ/N3DbQ7BM3QlWkS0fjUDLlk2YCdDgMRMwXamDWNp654fSeG0cape+6vsE23/Unl6H074VixboQ2kHdqKz3hwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387329; c=relaxed/simple;
	bh=s+h0DDSyCHiqN3H6W/w/6Fr1FaeU/MGaGG5TaLBF/8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgF3bMdq15pTFKNm/5+Y/vHE0w0iWJQreZy1WqzqEjycne6iapfVQLc3/ZGt7/3WhypH/T3QkJRg1b/GCPWIuKxGojU4rqz+n/kWR8QPqLG5zAYEZ1zAKQo3r88Eef370ZJigbN9vFcp8pLVdYprp09qL/TQK0BuU3bQmx13qtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 704C91C006B; Tue,  8 Oct 2024 13:35:25 +0200 (CEST)
Date: Tue, 8 Oct 2024 13:35:24 +0200
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
Message-ID: <ZwUY/BMXwxq0Y9+F@duo.ucw.cz>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <ZwUUjKD7peMgODGB@duo.ucw.cz>
 <2024100820-endnote-seldom-127c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ucz3kCwoKIM+ygt"
Content-Disposition: inline
In-Reply-To: <2024100820-endnote-seldom-127c@gregkh>


--0ucz3kCwoKIM+ygt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2024-10-08 13:24:05, Greg Kroah-Hartman wrote:
> On Tue, Oct 08, 2024 at 01:16:28PM +0200, Pavel Machek wrote:
> > On Wed 2024-10-02 09:26:46, Jens Axboe wrote:
> > > On 10/2/24 9:05 AM, Vegard Nossum wrote:
> > > > Christophe JAILLET (1):
> > > >   null_blk: Remove usage of the deprecated ida_simple_xx() API
> > > >=20
> > > > Yu Kuai (1):
> > > >   null_blk: fix null-ptr-dereference while configuring 'power' and
> > > >     'submit_queues'
> > >=20
> > > I don't see how either of these are CVEs? Obviously not a problem to
> > > backport either of them to stable, but I wonder what the reasoning for
> > > that is. IOW, feels like those CVEs are bogus, which I guess is hardly
> > > surprising :-)
> >=20
> > "CVE" has become meaningless for kernel. Greg simply assigns CVE to
> > anything that remotely resembles a bug.
>=20
> Stop spreading nonsense.  We are following the cve.org rules with
> regards to assigning vulnerabilities to their definition.

Stop attacking me.

> And yes, many bugs at this level (turns out about 25% of all stable
> commits) match that definition, which is fine.  If you have a problem
> with this, please take it up with cve.org and their rules, but don't go
> making stuff up please.

You are assigning CVE for any bug. No, it is not fine, and while CVE
rules may permit you to do that, it is unhelpful, because the CVE feed
became useless.

(And yes, some people are trying to mitigate damage you are doing by
disputing worst offenders, and process shows that quite often CVEs get
assigned when they should not have been.)

And yes, I have problem with that.

Just because you are not breaking cve.org rules does not mean you are
doing good thing. (And yes, probably cve.org rules should be fixed.)

								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0ucz3kCwoKIM+ygt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwUY/AAKCRAw5/Bqldv6
8oPsAKC7ACotpjIvVl8gQ0OJhzV+G7AM5ACeNXXpXeMBUUdckHcO9e+zpSRfTnk=
=uPkd
-----END PGP SIGNATURE-----

--0ucz3kCwoKIM+ygt--

