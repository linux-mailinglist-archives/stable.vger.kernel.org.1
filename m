Return-Path: <stable+bounces-52651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389A390C7B8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B801C22197
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4F1C0DCC;
	Tue, 18 Jun 2024 09:13:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1B213DB99;
	Tue, 18 Jun 2024 09:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718702015; cv=none; b=K3V8y/wLQLZ5jcdv001eYVnQjAX0bivwD1zv8z2/NCJYNBY4fCXg0pY1QpRyFLXk4x6B2hJ5CeO8gZW8kPWlHgURbi00zvzpLJfkHEbRvsWqGcwg/d4B9KCEElNb7pQPKWyG+12DVRlO5sg5oD4ce1oafFS/pWShrHSOOIcEM8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718702015; c=relaxed/simple;
	bh=HKKch01OgVkv0iOuEkhxsewbm4Q3UcCmBILsNIJvEM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h98ehYi6it8ijK+4U+qvSmybNCaWah1cFgZ9cUtoTBIzlla1QsEqGeYqpD+YkdFdCREGze9g2PdYRG3pg/RCm7Y3W0XVF9y3d4E9tqsNvwXD9x2If8YDAyuLQi+E3xhUVujtRotpYpgyEqDW892+N3qLNuC/4ScxV9v5SGGcGYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9BFAC1C0082; Tue, 18 Jun 2024 11:13:31 +0200 (CEST)
Date: Tue, 18 Jun 2024 11:13:30 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Charlene Liu <charlene.liu@amd.com>, Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>, harry.wentland@amd.com,
	sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
	daniel@ffwll.ch, martin.leung@amd.com, wayne.lin@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 5.10 1/7] drm/amd/display: Exit idle
 optimizations before HDCP execution
Message-ID: <ZnFPuimUl2QYzdzR@duo.ucw.cz>
References: <20240527155845.3866271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YGoPnplstVZpGpv1"
Content-Disposition: inline
In-Reply-To: <20240527155845.3866271-1-sashal@kernel.org>


--YGoPnplstVZpGpv1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [WHY]
> PSP can access DCN registers during command submission and we need
> to ensure that DCN is not in PG before doing so.
>=20
> [HOW]
> Add a callback to DM to lock and notify DC for idle optimization exit.
> It can't be DC directly because of a potential race condition with the
> link protection thread and the rest of DM operation.

Why is this picked for 5.10-stable?

It adds an callback, but noone is going to use it in 5.10.

Best regards,
								Pavel

> +++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
> @@ -143,6 +143,13 @@ struct mod_hdcp_ddc {
>  	} funcs;
>  };
> =20
> +struct mod_hdcp_dm {
> +	void *handle;
> +	struct {
> +		void (*exit_idle_optimizations)(void *handle);
> +	} funcs;
> +};
> +
>  struct mod_hdcp_psp {
>  	void *handle;
>  	void *funcs;
> @@ -252,6 +259,7 @@ struct mod_hdcp_display_query {
>  struct mod_hdcp_config {
>  	struct mod_hdcp_psp psp;
>  	struct mod_hdcp_ddc ddc;
> +	struct mod_hdcp_dm dm;
>  	uint8_t index;
>  };
> =20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--YGoPnplstVZpGpv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnFPugAKCRAw5/Bqldv6
8n/jAJ4vdLX0NDgd9EnqTJMgp289HWx28ACdG5FSE6Odu7KzIHv1ij/9v0enmII=
=5AhM
-----END PGP SIGNATURE-----

--YGoPnplstVZpGpv1--

