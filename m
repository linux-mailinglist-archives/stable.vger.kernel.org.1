Return-Path: <stable+bounces-155117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD3BAE198F
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 13:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9CF4168F2A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A286280A35;
	Fri, 20 Jun 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iLzmd9R1"
X-Original-To: stable@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA061FFC55
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417583; cv=none; b=pt+CD3BS+3C6qOycbrkDuD6p1ViTt5s7Q5BFpLy59qBwuxdbXUNGG0Pih4T2s5VqyHSoio4aFV/SIw0iVrgkd2fQeuzcNrz7+31zV4OdgaJ236TAyb92SD8GB9/mb+P0fqltoU2bPhH0xLJqRpeu5XR1gWTclwvL2tHPL4Y1K78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417583; c=relaxed/simple;
	bh=PXhVFeNeBWcWwc1mnUHGmnfFgu1/V4wJFUnPWhoZE9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IvTODkxmq5tnoROjXasdHxPA1jb4UB4NSP5HBynKZF151q+3c++rWBV89E8vZLrl6fsVtxzuO1SJD8WZ2tJCwvuqcXN0EAWyMC3IDNpbXoXh7pZ0otvTgvV0EemOG2Ih3lSiVS+fSIGELWyf+g1SymPi+CTGa0lG2glzgb35XEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iLzmd9R1; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 62F2210240F5E;
	Fri, 20 Jun 2025 13:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750417579; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=x8atEYnVKddwtd2f7AIDBEcAudGwFOQuDJTh06OJv6E=;
	b=iLzmd9R15LsdoX3hJLHn86GfdSaiutQpa2Vd607CqAz5JPpCJKUHgB2u6oWk2/2Wq+JH9b
	UIrKlKniXmRBoxS/ffvPd5E0qmDE0v9c4TtzrdB/zYXeCPthOJ+7to1gynyuC37vy5eFOt
	vU3YdBXaC3F6sUvM2OyYe2RtMy7wbaoznpyxDyE9bnaXgTKH8R9MpMsoUI6YxN39o9zYm7
	Qv7d7CdvC1a0+WatVGbLfxR5wBvjqfvkr+CcfuIi4qA0OruijFg/gZ0ZZqxC8mcVBWfds9
	K1BZh32AMkN0pzZMi8SsaFVFcrAA9pDFCeM6GIP/ojjTvEgNkgLR4LU/lDGBjQ==
Date: Fri, 20 Jun 2025 13:06:16 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 141/512] f2fs: clean up w/ fscrypt_is_bounce_page()
Message-ID: <aFVAqNLI0gWPUnBS@duo.ucw.cz>
References: <20250617152419.512865572@linuxfoundation.org>
 <20250617152425.314816903@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MJrcFxeAHPXe0rds"
Content-Disposition: inline
In-Reply-To: <20250617152425.314816903@linuxfoundation.org>
X-Last-TLS-Session-Version: TLSv1.3


--MJrcFxeAHPXe0rds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Chao Yu <chao@kernel.org>
>=20
> [ Upstream commit 0c708e35cf26449ca317fcbfc274704660b6d269 ]
>=20
> Just cleanup, no logic changes.

Not needed in stable. Bad bot.

BR,
								Pavel
							=09
> +++ b/fs/f2fs/data.c
> @@ -53,7 +53,7 @@ bool f2fs_is_cp_guaranteed(struct page *page)
>  	struct inode *inode;
>  	struct f2fs_sb_info *sbi;
> =20
> -	if (!mapping)
> +	if (fscrypt_is_bounce_page(page))
>  		return false;
> =20
>  	inode =3D mapping->host;

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MJrcFxeAHPXe0rds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaFVAqAAKCRAw5/Bqldv6
8oTHAKC8yglCIFKDV54uJpjWmDLwwXZMiACffB/Y0xmwBGLR+WD6vheBkB30z3o=
=PYt4
-----END PGP SIGNATURE-----

--MJrcFxeAHPXe0rds--

