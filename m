Return-Path: <stable+bounces-52652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F60E90C7C1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5C31F27271
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BEA15623B;
	Tue, 18 Jun 2024 09:15:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E418040;
	Tue, 18 Jun 2024 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702149; cv=none; b=erwdowP/zcSGrOzqSPULU5Xa+diEjMTiitGFt5rJ4BZscLE+rijPOnHyVSBME+PQbtCrkBpbcPcgciCZaC2Fc98i6Vl4E23e826mK+F0j7g7a4yEcHtSHoplPdXJo/U1V/gikHVINupVI6VlEXOrFrps9sUjVU08uI2CiWchsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702149; c=relaxed/simple;
	bh=VK2Wlb6lDMjzM8Zz61fmRi73Hu0Rvxc798K1at6fAXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geSHIymiUlxgupJFb+PJI9Qo7FTvkm04vb4gWun3P7uNPi7JtLwFqYEcYTL9HOqEdCCAdJqBixhlfm6D8aaJAxbLi6zuiN1nBcMjwl0oRyp6Q3WbhBC05rSPULzutQ6N1y/Nwh7IMe1NQZX83OQ9xpd0ueJd0ivmSWNWSkOvXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 60CED1C009A; Tue, 18 Jun 2024 11:15:45 +0200 (CEST)
Date: Tue, 18 Jun 2024 11:15:44 +0200
From: Pavel Machek <pavel@denx.de>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	hbathini@linux.ibm.com, bhe@redhat.com, akpm@linux-foundation.org,
	bhelgaas@google.com, aneesh.kumar@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH AUTOSEL 6.9 18/23] powerpc: make fadump resilient with
 memory add/remove events
Message-ID: <ZnFQQEBeFfO8vOnl@duo.ucw.cz>
References: <20240527155123.3863983-1-sashal@kernel.org>
 <20240527155123.3863983-18-sashal@kernel.org>
 <944f47df-96f0-40e8-a8e2-750fb9fa358e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TzzIxnkKCl22NOl6"
Content-Disposition: inline
In-Reply-To: <944f47df-96f0-40e8-a8e2-750fb9fa358e@linux.ibm.com>


--TzzIxnkKCl22NOl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Hello Sasha,
>=20
> Thank you for considering this patch for the stable tree 6.9, 6.8, 6.6, a=
nd
> 6.1.
>=20
> This patch does two things:
> 1. Fixes a potential memory corruption issue mentioned as the third point=
 in
> the commit message
> 2. Enables the kernel to avoid unnecessary fadump re-registration on memo=
ry
> add/remove events

Actually, I'd suggest dropping this one, as it fixes two things and is
over 200 lines long, as per stable kernel rules.

(If those are outdated, update them).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--TzzIxnkKCl22NOl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnFQQAAKCRAw5/Bqldv6
8iXnAKCSkZNG/q44rY4Pt+FmeDt77CBpPgCfeMR7jMzrKnZIcmrU7qCTdt0H+Us=
=WgYp
-----END PGP SIGNATURE-----

--TzzIxnkKCl22NOl6--

