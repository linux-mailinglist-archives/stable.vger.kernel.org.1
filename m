Return-Path: <stable+bounces-81589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7819947D5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B52283F5A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ED9185B58;
	Tue,  8 Oct 2024 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="LZLNWEKF"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CD7603F
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388694; cv=none; b=ho4uzDC+qpWeQGbfG4gNC/Yum+VuEWl33NS3sBJRF61F2RqT7qoG/v9a6Hi983ViMfd2ZYNEH+natdwnhrR4gaHUEXP9/V3FGFyeF5/t4kbgN5FGfiWhHls9Fo03SPm1NH9bGAGDtfVsrQWuLV5qhynK28gTzP13d+ufl1rRhfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388694; c=relaxed/simple;
	bh=hmahsoucGzMh1tHdXUPDIkRPcvyb2W7mr7A14d2rqIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2foYMfndpG8thQmmfJx61IP3BpyULnTNzgiJaeuzbgP/lWrXDvSF1XuDGmDy8aZtzPn17VcppQujCWTIj7LEK+TCkGc9rlzKCAkH1lqFdr8xep38nq1XctUpm9dJVuBrYb/9pmMOQeVIpemX3vi6Nnva+Bz92y1/AK2gIkhgoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=LZLNWEKF; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1728388613; x=1728993413; i=christian@heusel.eu;
	bh=lzsAkNRugxRO7kxUa28q6iyvYpkT9473fTQTrk4JJ2w=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LZLNWEKF5DsIKzb36/2071XvroSUIsqIRjaB8IPNDeFFQGl6Yj8dwWkE19W6go2K
	 IA4JRmWVAy1NrdXNMcxX03f6+aotaAXXU5RvVsXa+eqwGA940ZqGKD+FTcIKdojhO
	 CVQOAbcrS2Xr+IpDvws1Uz0i/WbSYN08EPEbq8hibWqdfNxugjtVifiXG3hljFpjk
	 QsGRBCexmZzdgzbtQXMBuFJePikm4N4ciMFz7/sb5lkdCgLIe7WsHF2Fxx/e+ge/+
	 qKhR1+0rMWecir3mH794NI0lIDDGNkWYXfVJch3T+Bz/jcW6OeNvwjags7/GkAebf
	 5wgYXDdrh70BP4ScjQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M9Ib1-1t1h4d49fb-003gea; Tue, 08
 Oct 2024 13:56:53 +0200
Date: Tue, 8 Oct 2024 13:56:47 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Machek <pavel@denx.de>, Jens Axboe <axboe@kernel.dk>, 
	Vegard Nossum <vegard.nossum@oracle.com>, stable@vger.kernel.org, cengiz.can@canonical.com, 
	mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com, 
	ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org, 
	shivani.agarwal@broadcom.com, ahalaney@redhat.com, alsi@bang-olufsen.dk, ardb@kernel.org, 
	benjamin.gaignard@collabora.com, bli@bang-olufsen.dk, chengzhihao1@huawei.com, 
	christophe.jaillet@wanadoo.fr, ebiggers@kernel.org, edumazet@google.com, 
	fancer.lancer@gmail.com, florian.fainelli@broadcom.com, harshit.m.mogalapalli@oracle.com, 
	hdegoede@redhat.com, horms@kernel.org, hverkuil-cisco@xs4all.nl, 
	ilpo.jarvinen@linux.intel.com, jgg@nvidia.com, kevin.tian@intel.com, 
	kirill.shutemov@linux.intel.com, kuba@kernel.org, luiz.von.dentz@intel.com, 
	md.iqbal.hossain@intel.com, mpearson-lenovo@squebb.ca, nicolinc@nvidia.com, 
	pablo@netfilter.org, rfoss@kernel.org, richard@nod.at, tfiga@chromium.org, 
	vladimir.oltean@nxp.com, xiaolei.wang@windriver.com, yanjun.zhu@linux.dev, 
	yi.zhang@redhat.com, yu.c.chen@intel.com, yukuai3@huawei.com
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
Message-ID: <69ba6a36-361d-4d32-8a0e-e541c6718e25@heusel.eu>
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
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="brxs56cklinyic2d"
Content-Disposition: inline
In-Reply-To: <2024100828-scuff-tyke-f03f@gregkh>
X-Provags-ID: V03:K1:HQcuvmCHGYPalpq4fACmv9F7p0YtYzY0YR1ogqlXncLbWSTVyyn
 7z22du74kUqHaiAf37KBOpUv7JKbS1eet5ss1EzCgH7Z79WGA0u+SGapMiG07/Yh3uKd8LC
 jUj4tHfpVdHq4BDUGXdab6a1OE4+e6DgXFnpSIwQh8hIQh1/T/4kQaL6LpLy58WLxWN1Ex7
 yOFG89+Vrr1poMvV6tBaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:br4b291E18k=;SqCCasCf5bXEnyjoa15UjvHbTGM
 lzjBEtgdd5iT9Bw9/RKxz9BZX/eq2l5Ui4oVhEPkpgLjqE39cnnmr8UdvSvucC95mCUOsxkiD
 iX1mxHS2itWcSYRThvX1lB/4SlbfdjjqbygvQTxMB8YYsOpH2P5AH08mSDNeAE0SqGVK5VjFt
 C4u8a3V8vE4klYVi/gINerWsx55looHpmKHlet1WpHHnfhgB2ZGEFEvdwtK1AcekFKfyQ9vIE
 PYVa4g/CxAc1SAFAdSh99PRXadLXVxT80P39aacPhSYh29i1cvKgIY3DxQlBGQBisf09qwk6s
 kUIEk6gSCgTPoqPezbUOx2TdX6DEDNTUVxBCbEwvVy8O5dxjquw5WEuFNvUEh4JUET/+AAq62
 4qDZWlrxrHCWvb/AXlzNu1mJJawCTPhKa7ipUxmRLI9gqbchi/RpY+oV4qjsDq7VftlNf4CF+
 LtSBqtrOHls/tjNGtLF4GBi4TF95mS67Yqs76qKy+BDD/JKUeS+tu+TG4FM7pKUIfnFIixTOr
 GnjAjdgN6UYDT6tdmyKaqZrW50dhcjHiKfd1e90fD3Mwk+NLKzD19EAvl2UtHDchIs0ffyJuW
 nl4F1S+U1AdF36OnfxnESaioMOQiRu0Sr1gzv1lQ5EoV85WR+4nNuKBaUFeLDDpElERW7JDU3
 Mc/LAsXCW5dwkXN0CiAfp1W4gH1eeqKRmsgftVB5Ut3VP0AT2uPmHsKRqYRDvniLrngOoPrrt
 2kFAbaDcUdJbOlU7FdxpwNWGJrH3iYoqw==


--brxs56cklinyic2d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 6.6.y 00/15] Some missing CVE fixes
MIME-Version: 1.0

On 24/10/08 01:44PM, Greg Kroah-Hartman wrote:
> On Tue, Oct 08, 2024 at 01:35:24PM +0200, Pavel Machek wrote:
> > On Tue 2024-10-08 13:24:05, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 08, 2024 at 01:16:28PM +0200, Pavel Machek wrote:
> > > > On Wed 2024-10-02 09:26:46, Jens Axboe wrote:
> > > > > On 10/2/24 9:05 AM, Vegard Nossum wrote:
> > > > > > Christophe JAILLET (1):
> > > > > >   null_blk: Remove usage of the deprecated ida_simple_xx() API
> > > > > >=20
> > > > > > Yu Kuai (1):
> > > > > >   null_blk: fix null-ptr-dereference while configuring 'power' =
and
> > > > > >     'submit_queues'
> > > > >=20
> > > > > I don't see how either of these are CVEs? Obviously not a problem=
 to
> > > > > backport either of them to stable, but I wonder what the reasonin=
g for
> > > > > that is. IOW, feels like those CVEs are bogus, which I guess is h=
ardly
> > > > > surprising :-)
> > > >=20
> > > > "CVE" has become meaningless for kernel. Greg simply assigns CVE to
> > > > anything that remotely resembles a bug.
> > >=20
> > > Stop spreading nonsense.  We are following the cve.org rules with
> > > regards to assigning vulnerabilities to their definition.
> >=20
> > Stop attacking me.
>=20
> I am doing no such thing.
>=20
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
>=20
> > (And yes, some people are trying to mitigate damage you are doing by
> > disputing worst offenders, and process shows that quite often CVEs get
> > assigned when they should not have been.)
>=20
> Mistakes happen, we revoke them when asked, that's all we can do and
> it's worlds better than before when you could not revoke anything and
> anyone could, and would, assign random CVEs for the kernel with no way
> to change that.
>=20
> > And yes, I have problem with that.
>=20
> What exactly do you have a problem with?  The number if CVEs can't be
> the issue as to make that smaller would mean that we would not document
> bugfixes that are going into our tree.  Surely you don't want us to
> ignore them.
>=20
> > Just because you are not breaking cve.org rules does not mean you are
> > doing good thing. (And yes, probably cve.org rules should be fixed.)
>=20
> Again, we are following the rules as required by cve.org.  If you feel
> we are not doing this properly, please let us know.  If you feel that
> the rules that cve.org works with are incorrect, wonderful, please work
> with them to fix that up as you are not alone.
>=20
> Here's a talk I just gave, with slides, that explain all of this:
> 	https://kernel-recipes.org/en/2024/cves-are-alive-but-no-not-panic/
>=20
> There was also a great BoF at the Plumbers conference a few weeks ago
> that went over all of this, and had actionable things for those that are
> working on the "downstream" side of the CVE firehose to do to help make
> things easier for those groups.  Please work with the people running
> that if you wish to make things easier for anyone consuming the cve.org
> feed.

Here is the timestamped link to the BoF session at the plumbers
conference: https://www.youtube.com/live/SWj-0FcyDWk?si=3Djx6Vv8Xdzm_qKekj&=
t=3D11410

> greg k-h

Cheers,
Chris

--brxs56cklinyic2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmcFHf8ACgkQwEfU8yi1
JYU2GBAAjsU4KR49zGGSYU2OEsyLb0sdjv+la0f2U5f8RHEYBqhrJgsDL4tk2ZPy
AXYMLf1QIIrzWR97+rFhUxR1gaNCZLOnZ+T2+4fCgKjlN0JYxCKZVCGXDOOFMXgP
cnh1RSgAQI5aIgKfc/22XVavGNHXcQU/7ZkiiyG7cvnHnoMKlPfAbBaKrKSaTj3O
e8Q5cjiVgSTfJGv9A1J40RIcZWRtutRaYZJJohuMEXTeFVyKaHW0uBv9OeWC9u6d
fPAfCqu12tOkQfF7jzW2CRymezcn6h224Gx6yhuUveL3UE6zYD95+YWkjmpBQ74A
ZrQkK6C+JJjj/woQCWJ6Fy+oQaxopM19YOmKjaLoY3okkg7xJJeAvbAWqpK6SC2z
P1MCjZ/whrQtBkhCe+O3ztD2HpQp6bq+kccRyTQiEdwCvOZ4/sz81QctBVbiu+tz
onIqFRYRtK3NqRgootyb7guUstJXExBvqJZcgTe8Ttxdcs9hBSGivbW4fQWsaa3o
bRYxSXD8K41PRT7uFZDz5JK/2bEQKd+W9vL4UASYuXcWBkyHbTPwrJjoRH8sb/ia
YOAsKYiE1P3GEeFMkrv4kQqcGGTrbdXJbvoZZIgUowUWWBYr+1Dq09kuxn4GXY7s
Ycg7XeXN5Onw7NBW8MHmWeGWRCQvHJ8N2PNFq3J6zSmS9JPQ/Xc=
=L3ds
-----END PGP SIGNATURE-----

--brxs56cklinyic2d--

