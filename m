Return-Path: <stable+bounces-142099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56AAAE62C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750D43A821D
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853DC28B50A;
	Wed,  7 May 2025 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWcrBPop"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159013AF2;
	Wed,  7 May 2025 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634106; cv=none; b=kI9825tbbcL8CbmKEUHqIBLd3S4u6IFNgjdeRWUN5sG90QS78madTVMZVktyWIKhXrWg6Cxy90iyAO/Zr8C7VOcLQYMUoSNsiSX1wmnixzwvhyH8u2ZG94fpoI3MSIvWbC+qk477k438Fw5Fh9lr83PjmBEAyUGDiJllFw76rX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634106; c=relaxed/simple;
	bh=o/fYLG1pGTm0NaN5Zv62FesMJ4GK1rgfHNA2TYwwdFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8L364by1QjfXh6JW7ZNOuO8ioNUiO/2VosuxUo4gd18N6WggeCinFY3wdHZTzLtUcsVjWeQBntqNuGLdTVfICWRcKf24cgJ2OyngEZNd4L2qTwxHnXpQ53dC0c8euGdaq99fINQSEAzwfhVGXbC7jTC5HqFlF17erD7ljxI0KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWcrBPop; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so526435e9.1;
        Wed, 07 May 2025 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746634103; x=1747238903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o68V7zCdyeLD/zo96i9/6hmSeJ0InCcEwQEaKU1RQ2M=;
        b=XWcrBPoplFFQojYBNsVw6gjREpigTXTTI5s8v4xf66J29Uvl3BRg5WGMiAX8RiSiCo
         qyv9PB9SYcvbmJjwNo123axKseJ/LNYcqPmp4fRe1lY1ctQooTb0+dGTedZoRQ8QrVGH
         x4FxDOkuiCpEbpf3JK7+QtdTC9Aaat6x2J/FTacRsNneUZJ/KnSbBVqU/mW+8oYSawe3
         /eruT+b3S81VcefuvWEPJyVA7nUoLk7zBMVaCr/fZxa8LsgmeKUgqYqRkJ2/5NrcZsr9
         jcB4H+NLrKFUYH2aRUzhFEqGegOSvs1Nta2cdyKoabfdUk3QcRuSfCPKLElhMEm1Q7Z1
         niZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746634103; x=1747238903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o68V7zCdyeLD/zo96i9/6hmSeJ0InCcEwQEaKU1RQ2M=;
        b=ZZMFvxhB6z9N66uL/SM0oaCTJi4051y0IQPvmY7yA9XZqQ+1svDFHf1PwMz6am8Ajr
         tEwhvZicdqdc5IseLFUMz98mZHGtXtp3Xdj1vSI1ubaXmk0LVxVH+xAEMG3i0aq8If79
         4qvfDpRp3HqU6JS9MDbqyFsRPM8D52ncT/oK391oCGs2NBy2G0wPQJF7dNxT8+6OJJhH
         zo2MJVloFxa4J3YiQB16vZYwJwmQ+79f4UQhVgNKaE99VtHS4kuYMJDuqcahFSx2T6ls
         tSMXrFzlQKMVnOc597wnvmve5KyqRalG3rmRi4R70qxHyhrQb4dRT7+I5LiuRj5yQ92q
         tPsA==
X-Forwarded-Encrypted: i=1; AJvYcCV+E/SVKhXWgRWM1Crly19L0+ExIzU6TSPasD8HvS4uvP2wfLzUGXLJXXz1hxXS3XP29R7WdJsiu0NObHQ=@vger.kernel.org, AJvYcCWVlZSSxZ3zsZzpOc2wagUmjVzEi9EXr6rtu0+6A1P4Z9Q+8OO0cYBma2lQEnMRVCBnusGxW7sNzofDYi4=@vger.kernel.org, AJvYcCX4g2+beh2rQmcSkVB9U5/outpwa6Y0hRiZ7su03TeP2M7mo/KF8kTykWmew55uVWNgjkyy/anx@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYZ37V0EOCzcjt50NztodHzUyC0QfJN9GpG8hJkt14wv52gLA
	rvj3K/1Ez4ij2sw//pSMVeEWB2Qbm/8Bo5F69GdrGovV+3Udvbxj
X-Gm-Gg: ASbGncuM9Zbg87t92CY5aes4FwK/fqlCwjaukVjsBlEmzdtX2MHEj6rQLxhFvVU+1aB
	5Rm1SsAhQTtjhI/44SnOTI90erzdscYMAYJHEKdlG92tto+CtN4WaFcf/FmueyThZYekQmcFUM4
	noG/p6PjRS0OnMLVO3BT62wjb+1p9XiU6OdOrjhY+QQ5gVYPsbz2xNKDddh7fh06nVBbpx3s0kr
	XxILrR3kQ7UijiDzZACjd/PLszKCaAhuUVzoj83NRFlMZFh6GdstAL9dHudio5byKL8Qv4WurU6
	/p4CCsGkJvtoUCTSHEOs92SbYuJ+URzO78xD93kGLYS6iLF2YB4rmzSJtCf8LyEP+je8DTak/lz
	5wuYQq9MKDF2dE6HB6hxJneXrgaM=
X-Google-Smtp-Source: AGHT+IEWtaaQHN90f9Ar75XF26861r4Smh2BGN0stetXtqgZ7jk2EzFouCKgXFVI8SFpwZcRQXNK+w==
X-Received: by 2002:a05:600c:331a:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-442d02ca75fmr836535e9.6.1746634102644;
        Wed, 07 May 2025 09:08:22 -0700 (PDT)
Received: from orome (p200300e41f281b00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f28:1b00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b6d0e1ebsm1645388f8f.80.2025.05.07.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:08:21 -0700 (PDT)
Date: Wed, 7 May 2025 18:08:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: mperttunen@nvidia.com, airlied@gmail.com, simona@ffwll.ch, 
	jonathanh@nvidia.com, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] drm/tegra: fix a possible null pointer dereference
Message-ID: <qicxj23zxidfh4zqvrm5r2udcy57xo2dezvcaxuinannfhodxy@vueedaqco4t6>
References: <20250212014245.908-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rt7pesreydbeihse"
Content-Disposition: inline
In-Reply-To: <20250212014245.908-1-chenqiuji666@gmail.com>


--rt7pesreydbeihse
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND] drm/tegra: fix a possible null pointer dereference
MIME-Version: 1.0

On Wed, Feb 12, 2025 at 09:42:45AM +0800, Qiu-ji Chen wrote:
> In tegra_crtc_reset(), new memory is allocated with kzalloc(), but
> no check is performed. Before calling __drm_atomic_helper_crtc_reset,
> state should be checked to prevent possible null pointer dereference.
>=20
> Fixes: b7e0b04ae450 ("drm/tegra: Convert to using __drm_atomic_helper_crt=
c_reset() for reset.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--rt7pesreydbeihse
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmgbhXMACgkQ3SOs138+
s6F7Ww/7BQUPPBt1SDPOYhWqQqpw/rRx5SjGlwoNShTy9KEjJtgmQhabWwyme5gZ
MZzdooSU+WBEk4emzsZNx+Qf2CjNya9whrweB959fN5Ip/kvCyF274Lop2qs+LKe
uMn7/bXUaXb1e1F5XvYP6ywuBNJAfylOnU6d73E3cwMJjk8Hm92r9q2q/NR264UP
hBLQsMDHzlsp11lTu18SrdMHWOpT9MoTUDEiZd4gVjCf5azw+STKrE7kNXZaU3S8
K0Nkh0Zy8vD/9+wvRDygroOlFNW/dRVAa/4gM3kgsC9MIiVU4C1k6eYfPEkBhJHG
quDxbPdHDENKo+mfSvO2JOpE8S5XNG/JEe2ecZXbSvpUMq/keEhVMgP66rKQBLhY
7JmcIsHzBiT6mkwnL7QLk5YHticRfES39SoXp7wCgIbw5UfNvpg0fFs+M1Yu9zIT
w6hwaodfHOLSgV3UpT5uLHD5ng3/08IspUc8Z2urY6PCIYkimzp+YwvjA+TTOg9e
f3biI7A4lKFPQ37jN/oyMJ0Wr2lBdianS3cdofevQpkfc1ZIWZLz4YqMduAPlhm/
+nWEN4Pc5F8dkCuoIL310J+rYQJHPLitXbk6SAXvM2OWyVVusmggyFkvaBdXWT7w
fDnQcazFbBvDyVjl3NLtgy1HqzXZehGPMNvzZoQS0I4NdPqMGuE=
=KGRG
-----END PGP SIGNATURE-----

--rt7pesreydbeihse--

