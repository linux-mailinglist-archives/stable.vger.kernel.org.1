Return-Path: <stable+bounces-158728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC51AEADB7
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 06:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32BC1BC841E
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 04:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6491C5D44;
	Fri, 27 Jun 2025 04:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKoIQOsX"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5689433CB;
	Fri, 27 Jun 2025 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750997245; cv=none; b=eJVwJDAVcHEoNvK/x9LoudQjSvuB+7LWe+SSJtComyebvS7AjOZGD1t2BI1LLrc0Xhz/gh8m/H2A5tOBFQZCY/U25mrabL+cyVub9LRceX4LPohPEj0uW7GTXKJgu2JrsLI1mSSqE0YvWrUnaiY/gYSYWe/ztRmv3BU94ga3Pqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750997245; c=relaxed/simple;
	bh=8x/RnL4RpBnojU9GPPjHBfPR2BngZztTcH3VjNa1ezs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4ZxcOGbxB3cATUcd9bw2kxUHw6q7NvekWN9gnz1O80sqUKotpiMX3Xb1z7KGLD7+ebopXovSuecTHLl45z5grdksjAueFBwffw0Gxb15GFCpVtr6tQM9GzbrFB1exbbQmVyi3imPDTHR4Po0kQt2ON8kqw3sWRa51Ikyuvg1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKoIQOsX; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5308b451df0so547151e0c.2;
        Thu, 26 Jun 2025 21:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750997242; x=1751602042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xHMK6PQ4DMklkCsGbrG44WpM/VPBrCs6nWRyWKBBsU=;
        b=FKoIQOsXzh+YHIGqvfiNHB7Ba/zpqT5DBTs7HlHipoHW17CsyR05zGIRmzglxS7RkT
         x1+mj6HZ688u1EXbuLiRi5D7ASa66wQqQdh3MfhQot9f2avU5U3Z8E36W+nqtI9LbC4s
         c+TimZo3j0PVHdRoqoNznzwjLRLbFy17t7h+5XW5tk1iJe04qiw/jne9MRtvpztfqK55
         fF+/ukvAjqOK0zcmzeru24wZxvzp7ySDwdcf+vIrO5lEBMsI4GupXNTqpdYGyBL40Tlw
         h/QXtAaOlZR6NxFlwlm3Voj+TennIMCFL7tx5K2QDc/Y/dIS45pH5sUCIW/3wY3gCmfl
         OLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750997242; x=1751602042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xHMK6PQ4DMklkCsGbrG44WpM/VPBrCs6nWRyWKBBsU=;
        b=OOokBtyEzExbHsKYg0o1E2txHYQqjY0ixlTCF2V1KIgKJAHvvT6OeKt3NtlXO1gWC0
         tzN05WfrrD37JLYVfLgqNQ0QAxHHpShdP/64Zv/Jzhk5EAbKACzsq8Na2801trGxn67j
         Z/Y1e3T1qtUmjWK5nHWYL1lf3jo0tzKEFgXXXDdyN3HxOwyJOCyVNDSI5IzzYsILyuZ5
         DwiWLIcd7BDBrmWY5RBsvzA/e2LYK5689Oq4eHvBNLcuzckf8+j6uaX/r2pDFc6zH4zx
         293oQNWKhNLpK6y16NWPqbaBB5cziwpRzQHfxAnkhOAHYEh07MPmt9wv4MJ4t6acqeXN
         8FsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKpD4W+Xv026BUtZTpeSwA3SXswrgp/YMpP6tQkGhIYArhxlKiYmbFkEVs0ygKsDssjOgYGmQmjGFfgJsx@vger.kernel.org, AJvYcCW+N/S2pFOQi3f84+B+kQ33PgDoWgZQTw+dvwWUcK3IWUnua9OI8xXBOOx5cl9aYdGocY0Qyqt7@vger.kernel.org, AJvYcCWc3YZM7nWHQSWxtwah5vAAW1LqHuUXiXGsXlrxvA5B2rX7J6ts5Osckl/+gy4MMoWXhAm1x9p5mf1e@vger.kernel.org, AJvYcCX1+ZYnca1GjlbGJuTU/0NOpM7s3UzS/jiwTLvb7t4xZcJ00KzOb3bvKOGzpUq9ZXfJAQbOKOev4tXxBi4Ko6lfn0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywye6L6YmeVKO1mILhhv+A5A/CmDyD/8Lng7dfCnlChsrAH7l9J
	1B0fM6wtI9yMGFV7y9Vfp9tOBjD5JsjexWl7j7McXBhdnVjGwIzlAa2qdvQO4KbM1a7VGqS4Lnt
	3NviDtVxnU1FBZi2m3hNEf/FUkzZsJclLEfsd19QzFA==
X-Gm-Gg: ASbGncsClaZP27Rr8S3SkX1qAFjI3Vg7CSrp1d9drM+iS75g7hQw2UaoOrT+tOa8/a4
	QxHHUjOuw6cBWnJwehqJcqEIdjOxn6ohVvUytCD1iu5vjt2ImosRgWRba3JARmvJllMsRl815m/
	WmAZMs3SGCyz/Ya2X010wJLpmggHEf9x0h3JdtT//AbA==
X-Google-Smtp-Source: AGHT+IHlxMc86ufSZtcL3j8P2poeXg8qzyvnAbUw4dy1htBYX9hCb5oAZgsY7er9NHUMK/7ApR5+KQERvropag7FPFQ=
X-Received: by 2002:a05:6122:2526:b0:530:720b:abe9 with SMTP id
 71dfb90a1353d-5330bfbe262mr1496367e0c.7.1750997242580; Thu, 26 Jun 2025
 21:07:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-exynosdrm-decon-v3-0-5b456f88cfea@disroot.org> <20250627-exynosdrm-decon-v3-2-5b456f88cfea@disroot.org>
In-Reply-To: <20250627-exynosdrm-decon-v3-2-5b456f88cfea@disroot.org>
From: Inki Dae <daeinki@gmail.com>
Date: Fri, 27 Jun 2025 13:06:46 +0900
X-Gm-Features: Ac12FXwIXNh96XjcbS4nbV5KnzWbsp93XPto9lDaR0yFPoINZtMFfYL62VbDpSI
Message-ID: <CAAQKjZM+++P3ozLZZYEusYepamF0qdeuOe+thDb2BevLCsab_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/exynos: exynos7_drm_decon: fix call of decon_commit()
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Ajay Kumar <ajaykumar.rs@samsung.com>, Akshu Agrawal <akshua@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

2025=EB=85=84 6=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 4:21, K=
austabh Chakraborty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> decon_commit() has a condition guard at the beginning:
>
>         if (ctx->suspended)
>                 return;
>
> But, when it is being called from decon_atomic_enable(), ctx->suspended
> is still set to true, which prevents its execution. decon_commit() is
> vital for setting up display timing values, without which the display
> pipeline fails to function properly. Call the function after
> ctx->suspended is set to false as a fix.

Good observation. However, I think a more generic solution is needed.

>
> Cc: stable@vger.kernel.org
> Fixes: 96976c3d9aff ("drm/exynos: Add DECON driver")
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm=
/exynos/exynos7_drm_decon.c
> index f91daefa9d2bc5e314c279822047e60ee0d7ca99..43bcbe2e2917df43d7c2d27a9=
771e892628dd682 100644
> --- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> +++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> @@ -583,9 +583,9 @@ static void decon_atomic_enable(struct exynos_drm_crt=
c *crtc)
>         if (test_and_clear_bit(0, &ctx->irq_flags))
>                 decon_enable_vblank(ctx->crtc);
>
> -       decon_commit(ctx->crtc);
> -
>         ctx->suspended =3D false;
> +
> +       decon_commit(ctx->crtc);

There seem to be three possible solutions:

1. Remove all code related to ctx->suspended. If the pipeline flow is
properly managed as in the exynos5433_drm_decon.c module, checking the
ctx->suspended state may no longer be necessary.
2. Remove the ctx->suspended check from decon_commit(). Since the
runtime PM resume is already called before decon_commit() in
decon_atomic_enable(), the DECON controller should already be enabled
at the hardware level, and decon_commit() should work correctly.
3. Move the code that updates ctx->suspended from
decon_atomic_enable() and decon_atomic_disable() to
exynos7_decon_resume() and exynos7_decon_suspend(), respectively. The
decon_atomic_enable() function calls pm_runtime_resume_and_get(),
which ultimately triggers exynos7_decon_resume(). It would be more
appropriate to set ctx->suspended =3D false in the
exynos7_decon_resume() function, as this is the standard place to
handle hardware state changes and resume actions.
decon_atomic_enable() is responsible for requesting enablement of the
DECON controller, but actual hardware state transitions will be
handled within exynos7_decon_resume() and exynos7_decon_suspend().


Unfortunately, I do not have hardware to test this patch myself. Would
it be possible for you to try one of these approaches and verify the
behavior?
Option 1 would be the best solution if feasible.

Thanks,
Inki Dae

>  }
>
>  static void decon_atomic_disable(struct exynos_drm_crtc *crtc)
>
> --
> 2.49.0
>
>

