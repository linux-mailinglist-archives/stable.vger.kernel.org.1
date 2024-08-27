Return-Path: <stable+bounces-70328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE6D9609F5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82FF282A10
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB31A073A;
	Tue, 27 Aug 2024 12:22:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A917279C;
	Tue, 27 Aug 2024 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761331; cv=none; b=i3Yq1WORBKBbGLhadkBmduXChOwiwA91cHV21W1h9UdZe7jxatwtQ7ZM8y1d8SZtj5CAQq3NQoZ28E9R69DI6t2mzVxBIEtC8HjayqUaPGMXo/vkkzE8CHyKStomxw1NirjjjHHT3uvVsLt5iAUKae0+g3ZfuoBj6tgUuAo3ASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761331; c=relaxed/simple;
	bh=Rh0k3l07tbKglLHLw1y4gsuovdwN5weoMX8vOP8pF5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBEr68ncAcuOrNADP/DuCljrY6LTTIkyzsrutH0hP/yMudUth/48yVWqaBsDfnMEHvFtqv9uADb3uoMHG1oQfEEHSV5tXFBiSIOl7zRh5e2JNtsvWeaWyFQghH1H+/jcYRC5lEAO25OxaMK34ucuYj1QPpmgh/dJpwN6Yfh9qew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id A0D701C0082; Tue, 27 Aug 2024 14:22:07 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:22:07 +0200
From: Pavel Machek <pavel@denx.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ma Jun <Jun.Ma2@amd.com>, Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
	Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.10 034/121] drm/amdgpu: Fix out-of-bounds read
 of df_v1_7_channel_number
Message-ID: <Zs3E7w1dSdxC7XoT@duo.ucw.cz>
References: <20240801000834.3930818-1-sashal@kernel.org>
 <20240801000834.3930818-34-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OqRI4MIqpBt9dQxF"
Content-Disposition: inline
In-Reply-To: <20240801000834.3930818-34-sashal@kernel.org>


--OqRI4MIqpBt9dQxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit d768394fa99467bcf2703bde74ddc96eeb0b71fa ]
>=20
> Check the fb_channel_number range to avoid the array out-of-bounds
> read error

We can still have array out-of-bounds, right? As soon as that function
returns 0x8000 0000.

drivers/gpu/drm/amd/amdgpu/amdgpu_df.h: u32 (*get_fb_channel_number)(struct=
 amdgpu_device *adev);

int fb_channel_number should really be u32.

Best regards,
								Pavel
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
> @@ -70,6 +70,8 @@ static u32 df_v1_7_get_hbm_channel_number(struct amdgpu=
_device *adev)
>  	int fb_channel_number;
> =20
>  	fb_channel_number =3D adev->df.funcs->get_fb_channel_number(adev);
> +	if (fb_channel_number >=3D ARRAY_SIZE(df_v1_7_channel_number))
> +		fb_channel_number =3D 0;
> =20
>  	return df_v1_7_channel_number[fb_channel_number];
>  }

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OqRI4MIqpBt9dQxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZs3E7wAKCRAw5/Bqldv6
8l6xAKCvBvtdsPWLS+2akXJN38ECL3P8nQCcCKMijsSiArutJxOsPYklJw/UZZg=
=fM5x
-----END PGP SIGNATURE-----

--OqRI4MIqpBt9dQxF--

