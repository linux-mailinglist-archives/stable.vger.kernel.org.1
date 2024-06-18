Return-Path: <stable+bounces-52650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DF590C7B0
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2541F25FFA
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 10:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D4715572B;
	Tue, 18 Jun 2024 09:11:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB614C592;
	Tue, 18 Jun 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701876; cv=none; b=LqUXo0UDnO9fFba4vnJgLy9KpY0vMMy86hFORannqYJBslRoMefayLXqGyH5vtzoAPDQot3NpWbiHm8mz0LZ8ix+cAUW0koam+FbxQgTgB8ytm4/E1bMKZTpjsWhFIIJWNHYIDMieRHigiOCFdCRBp7aw2uImNjTC4AiIzdM0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701876; c=relaxed/simple;
	bh=dXtA+yJzngS0dOd+sS3hyjV7bUQaPNzb6qZLzt253d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNqQl6WITqanO+aiB0XOgWpTZAm80Bw1ZWfGoWXGp1ktLO8RYDwnR3Hj1M4OP1VQyItZ5NhmxFQJn2Z22OoORreCkrFurw44sBwDrdAcUNSoeloOXqWjbFTcqa5J1pDEz7XiQFDmk5nV5Yv+IHVijlRcZ+nDbBrvohP/3ssf8i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 23ADE1C00A1; Tue, 18 Jun 2024 11:11:12 +0200 (CEST)
Date: Tue, 18 Jun 2024 11:11:11 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jesse Zhang <jesse.zhang@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, Xinhui.Pan@amd.com,
	airlied@gmail.com, daniel@ffwll.ch, Felix.Kuehling@amd.com,
	shashank.sharma@amd.com, guchun.chen@amd.com, Philip.Yang@amd.com,
	mukul.joshi@amd.com, xiaogang.chen@amd.com,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.1 13/14] drm/amdgpu: fix dereference null
 return value for the function amdgpu_vm_pt_parent
Message-ID: <ZnFPL2BeQOEGPO6Q@duo.ucw.cz>
References: <20240605120455.2967445-1-sashal@kernel.org>
 <20240605120455.2967445-13-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qwPPwx+eAXd6Ui24"
Content-Disposition: inline
In-Reply-To: <20240605120455.2967445-13-sashal@kernel.org>


--qwPPwx+eAXd6Ui24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit a0cf36546cc24ae1c95d72253c7795d4d2fc77aa ]
>=20
> The pointer parent may be NULLed by the function amdgpu_vm_pt_parent.
> To make the code more robust, check the pointer parent.

If this can happen, it should not WARN().

If this can not happen, we don't need the patch in stable.

Best regards,
							Pavel
						=09
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qwPPwx+eAXd6Ui24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnFPLwAKCRAw5/Bqldv6
8sZ2AKDD6aIoYQ3yGufGiJLfSd+7EFemwwCgvQub4Gk5IihPZeUyKiGRl6v9BjM=
=Jpw4
-----END PGP SIGNATURE-----

--qwPPwx+eAXd6Ui24--

