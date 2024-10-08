Return-Path: <stable+bounces-81575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867199466B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2208CB20E2B
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89618CC13;
	Tue,  8 Oct 2024 11:19:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F093017CA02
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728386369; cv=none; b=B/mB2/PuIUeyqKg3rNrOKGg5fJ9RMUFz8KDhwgCmR6Ju0R940Dnbr+Ktn7/mHwkJ6sFv48tgOO/2TyGNPFzWILS3J3Z0v2KlnYvJK1cRkqxiaItbFUa0STcD3NoY3Tdj9xRKFlSCQnvGFEOWx/Y4wGuGiUpSCWkko9nI+JHR+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728386369; c=relaxed/simple;
	bh=9m08bLW4xFm/kA8ANVeOOyE8q9u5BXxekUei9WAW1As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4OEa27W+aSZ2vN/bNaTaWrupkVDSUFyoSZAed6Ek7eiOQVuJeAwuWMTSpuepHK6MsFT25m9HpvGEy0F9L/upQNI6E3g82gdrPzYW4hY48FEKkK7pIsqq6qYk+vEEllhnAVmtKHMmDn1uX5Rswgotr7P5p7zIP9M1iVKGF1Vx1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 8352F1C007B; Tue,  8 Oct 2024 13:19:25 +0200 (CEST)
Date: Tue, 8 Oct 2024 13:19:24 +0200
From: Pavel Machek <pavel@denx.de>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Message-ID: <ZwUVPCre5BR6uPZj@duo.ucw.cz>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <612f0415-96c2-4d52-bd3d-46ffa8afbeef@kernel.dk>
 <69e265b4-fae2-4a60-9652-c8db07da89a1@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tf81yv/B5bm7tgJu"
Content-Disposition: inline
In-Reply-To: <69e265b4-fae2-4a60-9652-c8db07da89a1@oracle.com>


--tf81yv/B5bm7tgJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Unfortunately for distributions, there may be various customers or
> government agencies which expect or require all CVEs to be addressed
> (regardless of severity), which is why we're backporting these to stable
> and trying to close those gaps.

Customers and government will need to understand that with CVEs
assigned the way they are, addressing all of them will be impossible
(or will lead to unstable kernel), unfortunately :-(.

								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tf81yv/B5bm7tgJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZwUVPAAKCRAw5/Bqldv6
8lBsAKCuUbQfnNr5guIbfPNhCjX+cetdmgCeI97b5WpFAoq2/lWP5YiO5EENdl0=
=2E5D
-----END PGP SIGNATURE-----

--tf81yv/B5bm7tgJu--

