Return-Path: <stable+bounces-81574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADD699465B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413022890CE
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81818C900;
	Tue,  8 Oct 2024 11:16:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044691C9B77
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386193; cv=none; b=n0F1snogVVBRUYbdj4ZfOZgsRtlKZ+HbcS2ucUAbjrlmy/3YSSy7pqEMo3oM7tMkL3tGKl7SU00F1X5ysEqvpvsBbs4VzhdwQYVqexxTA9gsJjwp4jyBsbF0aYz5m7GPhrG4koH3HjYlLDUnQ6dkJvbjJkUV432eK3DrKsbPyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386193; c=relaxed/simple;
	bh=7/nof0OYOkAawK4sncOfsbpHvx4k8RWg4bR/7gmkEIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6uEvfxFck+bNXfMygIXrnnPRoLk9I1+uBsAlw48WpJdMiJaDHRITRh5QsovUtOc34AJx57lolcehdVaiFsxiAodddV9zvJf9uqKGN8LuimRFhAuxMP4469wJfGIBrUW2mSgv3qU+s4OoXMRGheSOKTDdAKfOnfTuh31eWfUZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8DB111C006B; Tue,  8 Oct 2024 13:16:28 +0200 (CEST)
Date: Tue, 8 Oct 2024 13:16:28 +0200
From: Pavel Machek <pavel@denx.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Vegard Nossum <vegard.nossum@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, pavel@denx.de, cengiz.can@canonical.com,
	mheyne@amazon.de, mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org, dan.carpenter@linaro.org,
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
Message-ID: <ZwUUjKD7peMgODGB@duo.ucw.cz>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VIKk3bzu6fvkprDV"
Content-Disposition: inline
In-Reply-To: <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>


--VIKk3bzu6fvkprDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2024-10-02 09:26:46, Jens Axboe wrote:
> On 10/2/24 9:05 AM, Vegard Nossum wrote:
> > Christophe JAILLET (1):
> >   null_blk: Remove usage of the deprecated ida_simple_xx() API
> >=20
> > Yu Kuai (1):
> >   null_blk: fix null-ptr-dereference while configuring 'power' and
> >     'submit_queues'
>=20
> I don't see how either of these are CVEs? Obviously not a problem to
> backport either of them to stable, but I wonder what the reasoning for
> that is. IOW, feels like those CVEs are bogus, which I guess is hardly
> surprising :-)

"CVE" has become meaningless for kernel. Greg simply assigns CVE to
anything that remotely resembles a bug.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VIKk3bzu6fvkprDV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwUUjAAKCRAw5/Bqldv6
8rcZAKCCb+2s3G3aSmE9vfUJbanrCKuYPQCfQzMpCwjg9AQ+2un52Gx7GcFEJ10=
=T3RB
-----END PGP SIGNATURE-----

--VIKk3bzu6fvkprDV--

