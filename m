Return-Path: <stable+bounces-70339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5414960A42
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3F31F22F18
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C431D1B3B39;
	Tue, 27 Aug 2024 12:29:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF46E19FA8A;
	Tue, 27 Aug 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761759; cv=none; b=rm96XNvT2+OjIrTOZZ/TVJt6P8dk12qLJ29SkIB8o/wwKq3IzHPtIqWplbHsDN19WHVyuTbQR9a31urEneKNj+iQKnHzzCNplYID1xIUIRBOHDgIw4ynilwWvyhfNIS8/cZ2eJtcHnAF43y5y467KovoB53gTUvzaWFCXFWdxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761759; c=relaxed/simple;
	bh=/u+8IG85UE1UCSKu2EZgx1AAgvnYYY2Ik+dwBQe+Eno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNKW4FQByE8aziPIz4+Q7+dR3v++oTrcr4W3h8wXcyJB6ut593OxGy6xmJhGUEgbjphN28WBdwGyLWMneqkbJRn/gdw99KgVi3AchVz+ZNbQFhMjQLkT1qnGHG4yFfzLQ2AAwCwOpj7vjzPMcde6IFDEsrF3wmPMzV2Uq91iGus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2DAEB1C009E; Tue, 27 Aug 2024 14:29:16 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:29:15 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jesse Zhang <jesse.zhang@amd.com>, Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, kenneth.feng@amd.com,
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	daniel@ffwll.ch, Jun.Ma2@amd.com, mario.limonciello@amd.com,
	yifan1.zhang@amd.com, lijo.lazar@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.1 05/61] drm/amd/pm: Fix negative array index
 read
Message-ID: <Zs3Gm4KIIN6EMNYP@duo.ucw.cz>
References: <20240801002803.3935985-1-sashal@kernel.org>
 <20240801002803.3935985-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="scNabhc75NExd7rZ"
Content-Disposition: inline
In-Reply-To: <20240801002803.3935985-5-sashal@kernel.org>


--scNabhc75NExd7rZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Jesse Zhang <jesse.zhang@amd.com>
>=20
> [ Upstream commit c8c19ebf7c0b202a6a2d37a52ca112432723db5f ]
>=20
> Avoid using the negative values
> for clk_idex as an index into an array pptable->DpmDescriptor.
>=20
> V2: fix clk_index return check (Tim Huang)

>  	dpm_desc =3D &pptable->DpmDescriptor[clk_index];
> =20
>  	/* 0 - Fine grained DPM, 1 - Discrete DPM */
> -	return dpm_desc->SnapToDiscrete =3D=3D 0;
> +	return dpm_desc->SnapToDiscrete =3D=3D 0 ? 1 : 0;
>  }
>

Original code was already returning 0/1, no need for this. You could
use !!() to emphatise that, but really....

> +		if (ret) {
>  			soft_max_level =3D (soft_max_level >=3D 1 ? 1 : 0);
>  			soft_min_level =3D (soft_min_level >=3D 1 ? 1 : 0);

Same here.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--scNabhc75NExd7rZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3GmwAKCRAw5/Bqldv6
8lzgAJ9HRFMKO7ykdGp/Lv4c4NpdGaVW4ACgqKiVFPb39w9n2HaoIoNKdgJiFJk=
=aWwY
-----END PGP SIGNATURE-----

--scNabhc75NExd7rZ--

