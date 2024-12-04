Return-Path: <stable+bounces-98298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126DD9E3C63
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 15:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181A0B28AAD
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D476D207A07;
	Wed,  4 Dec 2024 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwuYM/XL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED311F7594;
	Wed,  4 Dec 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321408; cv=none; b=oStbf8LP91tX7nUcFloeOc+RE5gx035Z1j4BvWqH6kHul9kHn7coxqkvgXhAEwbSdBFvnDGblnl/NqvEwQaqx00yieHC+U1tLMyQS2oC0lz6NunX2HG8tq5u2FpWkg/8xqPHSxLZFLTJf+G2KocJv3gs1z4hITqnwN3A9k9D6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321408; c=relaxed/simple;
	bh=uxvU4fSRyWue5vxc3QNX7F/+NrrOhVfNfqhWAGT2lK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/JcVs9gVAklyrtNiyA76Rz7L40cfgRnsdoC+Q0UcX9TAmts1fH9/c2lCOeAMYK3hsx724OEXrBz/5qi/lmBjBx2zayiq6aDrwWCo+08hcpc5DtksnxiwM6IRr9Czjmt27LSMTVPrGI5UzEgGcBXfJY3BmIBYNQVzOlR7MH3lWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwuYM/XL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so3019560f8f.1;
        Wed, 04 Dec 2024 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733321405; x=1733926205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrFMLc/jdh5p8JybRnIahA1b8Q2rxGK6wJh2KFAKrwU=;
        b=SwuYM/XLZJIZU0rHEYclS7RcaRbdK2lv2ECAWsRjPpLUeEnHfhlLeEgy2eosfIxr8i
         JVM8ssUdobf8t8wk05U1hNQOxIByn3fnBVY5pRQCkX1+qKzOfVf+2ib3YAxzJPE4xSbX
         7PkDnuaKF8RdAxsiLFg5MaD8lEaDcaMky8G5n6MOdcrHdiyy9Wx8JcMSyGR14kuyHGbi
         ilXQA47vgWK0Q+f+Yn+8MWKxghRMZeTM2LcAJcuiOsEFUR6MviraK5ba4F2EzTAjDsRy
         Lgwmz2PGJqZ9VuJZei9CL2smz89Jp7TocGYjHXQc1h3Vu7G2lGB6DFfE0YZXOvlygC+9
         9EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321405; x=1733926205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrFMLc/jdh5p8JybRnIahA1b8Q2rxGK6wJh2KFAKrwU=;
        b=Ryvnq7nuk9tVsKpfkESgJXQIoyWf0hIcS44oZ4VTatCG5EM5VC63R9Ny86xcUewhzs
         N8P5QNSuOznngRWszdEyOGGbKavMJrkm7gvfXGutGXj1RFcW4tOH5Xzi/6JopC0jS8/6
         GdCIADmUsSc0ckn0wy+nczBPnW2cgOT84iQyoCla2bzXi8Wgfm/vLOiDn/+LJZSuUNM1
         GvFwO3DgHnPsJBFgBO+64yMJpLCICbJkYEcxrdhhO2Pd4NRshkMT5fVzj8O4hbDSpoVs
         6SqckPdoIuj+C5me9wm17kQxTINw9hS68ok6z8obKJIGGbt3IM19XrLQMF7OW7tE5Ex1
         m/fw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7bYWGnUKSgLVHVLVt7tPAhdV7RofeSwxkK9l5hE+9gCw2QNGLwKuDRSXSbfff1J+hAgaDdmq@vger.kernel.org, AJvYcCUomkoiWO9W0e+/XnOXHuffHTFJO4RzFMz9S9VaCoPlD7oTjSrMaS9XYFaP+Ac3b/7OX9bSWsluji/Z3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4O3KTA0RMXNTNWZnnIwg+cR0eFKX1FBNrQrQ08EwrA2zKXR3O
	80UIxL2XT3GmNDA5Y1Bluund7psEJMqDoXgMZFVx603e3f9VeXDa
X-Gm-Gg: ASbGncvYP7GBOBYyNWD5k3Fj18gHmeiYVnukrAQgAKvrHr0/Ym0cNgHa4jNiHMLLJ4J
	nS5/73YVTrGq9Zq8fB/eN+23mptzlNFDAOTNBdmOo1dBEF25/rSvqHEkCj2mtrrS6UlS4TimB7O
	f5IzJJxZS0AIFHM30paiY9Lv1tebXhlMDKEdczGVIRsfty+gu2LQ7Ktxb8vhxnDEu9r7VjyM5v+
	mSfebURS6wFj1moOP1xLPJ1ObSJwn12v31tTyIVv8q3J8IfEOX1GgVOi+3j5dxwR85otRBr9Cuv
	v0MvKQ/FgthYSsQG64oTBCIR5LXRwkc592Ho
X-Google-Smtp-Source: AGHT+IG17qKjHP7hajsb1NqDKGf26pPgtY+u2y2Irx0Mpfq+Bk5d1g+9CG/Zi2mBLwUCzK6vQKtkSA==
X-Received: by 2002:a5d:598c:0:b0:385:ea2b:12cc with SMTP id ffacd0b85a97d-385fd3e779bmr6188036f8f.13.1733321404995;
        Wed, 04 Dec 2024 06:10:04 -0800 (PST)
Received: from orome (p200300e41f281900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527257dsm26885385e9.1.2024.12.04.06.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:10:04 -0800 (PST)
Date: Wed, 4 Dec 2024 15:10:02 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Gax-c <zichenxie0106@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, mperttunen@nvidia.com, 
	jonathanh@nvidia.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	mst@redhat.com, airlied@redhat.com, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm: cast calculation to __u64 to fix potential integer
 overflow
Message-ID: <xlmfl2rhjgczu6oycgogchqi2gc65w7s3qy33yxzsrf6mbri3q@7onulkroaa7z>
References: <20241203160159.8129-1-zichenxie0106@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="magv3qwbnz55o6h7"
Content-Disposition: inline
In-Reply-To: <20241203160159.8129-1-zichenxie0106@gmail.com>


--magv3qwbnz55o6h7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm: cast calculation to __u64 to fix potential integer
 overflow
MIME-Version: 1.0

On Tue, Dec 03, 2024 at 10:02:00AM -0600, Gax-c wrote:
> From: Zichen Xie <zichenxie0106@gmail.com>
>=20
> Like commit b0b0d811eac6 ("drm/mediatek: Fix coverity issue with
> unintentional integer overflow"), directly multiply pitch and
> height may lead to integer overflow. Add a cast to avoid it.
>=20
> Fixes: 6d1782919dc9 ("drm/cma: Introduce drm_gem_cma_dumb_create_internal=
()")
> Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
> Fixes: dc6057ecb39e ("drm/tegra: gem: dumb: pitch and size are outputs")
> Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/drm_gem_dma_helper.c | 6 +++---
>  drivers/gpu/drm/tegra/gem.c          | 2 +-
>  drivers/gpu/drm/virtio/virtgpu_gem.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

I don't think this can ever happen. All of these functions should only
ever be called via drm_mode_create_dumb(), which already ensures that
these won't overflow.

Thierry

--magv3qwbnz55o6h7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmdQYrcACgkQ3SOs138+
s6HXsxAAtQJlAEOMdgNNQBcnlKziuLGEV6eDn2I2ZMbyfdflAwfxU1IZem8HHolu
Uf8rl4/XAETFBzeMup8SZ+DvspOCUSQY6kf8Dh+25/5NDTEf50vjBA/TXcws/ced
6pRImbXzulFvz7kEm/fOaTXdk9w7mKnNDpFj86FUBcuz5kIQm1Qo4uhEYZRR9BSs
C5c6m77m/4N3Iw7mkJoKW1U0jDJpfgw/iCdUpZrNh2buoKaRhe3WasizYdpXcbIn
ImHPVPKV7MUgLrlYjdqOlxninIKhRMB9n5hcbvHD2YQcv9Y3pj1XA9YzXu3+4pir
Sq6HLJFoHy+vmeLdTJZsMEljM25tBtkXkIUVEiWUb4BTbjJHLikCT4IYvfm9wByx
OKCLKtdAiKyC1mh3aswnmeHb9tHBTt2Zj++nl2u/oUJyUncmBeboX7Wh+C9aCWF3
cjT8OzvzTFX0bTLWyO9n0hwM9n84di0kuVmN8Bm7erXZcFAQyJfQpVB8lqiXokYA
iw+IZX7DQQ8oKnxYpXy+V+gxSD19e4fed6jzgGpn7s+JYRuH1SiBSA4iaIQ8OCze
7FPuGM5WT1d92OgNUU+jC3gjM58QHwLiEFhJgV2Oj6/sOi5fs1JY9uGKlMbxynlF
PQm2NJU7k9lZXI2hxYRY6AmtikgF4NSYiz5zgglZvHpLoeLItpo=
=dkp1
-----END PGP SIGNATURE-----

--magv3qwbnz55o6h7--

