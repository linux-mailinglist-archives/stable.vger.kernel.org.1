Return-Path: <stable+bounces-181864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73D6BA86F4
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E8B7B211A
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F70F23D7E3;
	Mon, 29 Sep 2025 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6D64DMF"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80C14E2E2
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135369; cv=none; b=Uz9qay3hUjH1/bLK6mngTDGWwJtJltr7t0bAF4ZnuyqFDAY0Tx+H6J2zGguqgb8XtGsCMyLrTI9UtMrSTjfqmA8vrz+Pyl7I/FiWZew/AT7S4GTpU4j6qSznY5okpXHib7YT5g3x+avptvUiB3sFmRuCBScZ9emlPTxWDspyMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135369; c=relaxed/simple;
	bh=mMsx8DAQvF3lMZwUF4Zura65uPBz0YmPVnIofI/Zj68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4WAXGF2GKB8U8qmNQztjOXGLtYaSQf1e5/gxuCMeSc5E8FDQX8rCgE4ooPEwzPyYUpHSHFMxJUDuTssNQyx6bVeNbXA6Lrd1Pzfv9Vufa40CSq5HR3rTMxVK/3aFmAtK7aRI34ayg+xXJb06hlhITUcO4SF0xCVep2cWJzukPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6D64DMF; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-30cce50dfb4so3755818fac.0
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759135367; x=1759740167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0zDmiuAjQnd3YFVdPRcO8sxmuNMlpTgQ5OfVuUe4lk=;
        b=P6D64DMF+gR/0Q48v9tXyH9DxG7hb7gK01C/PfVhkmHRwrZ3rb2yZOsHNJGReDbjWY
         5FcTUGHRBXTivtO/14CXtlVpy/2zrl1RSsv3i+k+CSR/stXRFCOK6s61S0qseOmubzut
         u8lrZ7KYh/5oJxdsOFimBCmPXMHhMGcnKnAjPHmNxcX6zZWWL1J9tV0roizLXCD7nqMK
         kqo3IVeUhtp4mxAxirSg5xDw5378gd53zBEyR8TPFRX0UvJr8R74VtLzvC0GRSYcn14j
         5JxSyjKX48yNgJWWlkMPgIrOo+xpvqKbHQayZks0tKMur6lbgO/Zz6iAVeO0GUbayGsJ
         oo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135367; x=1759740167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0zDmiuAjQnd3YFVdPRcO8sxmuNMlpTgQ5OfVuUe4lk=;
        b=vrDJpKhvk+48k/UXTxbrzfKAi5nU6Vq77IcZhq+XlX5tsw93fRRgF+gBhUj8rrPimA
         UhYASrIov5EQ2liy9qpRd4uCooR39f1wuOAYq/2dHeYT87ZxWL1XNoPU2gl3c8W/GW8S
         yLcK5kC5ZTOu02yxYyOlpvBnw93sEQZiV1mgTXpFACJ2dkFapIImRYyBM6SXGa1dlaAV
         6TmXM2wCOtjB1L3+24prhJSav1VdNM7+lwlx32Q32GgIn0HgVXyEMJ8UFd/Cl95zGw5S
         wYqpM2S5gUw9SLbkdaTZbn6aajiMvi4xTkOFR7zB/k5MyKSud1nuuf9scw9J5pu2qvye
         +3dg==
X-Forwarded-Encrypted: i=1; AJvYcCV4SPqkmpaPCtvhGKf4OEewx6qlic0tAEIAG+zaHcGNRP6AA74Pp+6wDImpxJu2ithDu5aZRnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKF1Xl9mVdf019ArFnNp79X6YqzPN029JwN5rqpclW3ECwVjmY
	q7zPo2Uwuj3THm7wLySfWhhAKWy6DxWTOuwhsbdC25pqiLjRoTQBH+SLj+M9HJuKN66ossFRgmv
	kXLa3w0erYxIzpEan0+mrubOErpJtPEcqnA==
X-Gm-Gg: ASbGnctLK5daN+iGDUtlIc+aRHP3P/Sg7HCC1Ihe/+Yn0d1tj3+ptUEm2VhySmIx7P8
	3tkb400JrNSnAcvcP9e9jr3fyiCjP1MVoaO/p7hZbLs2ojOen1WIf9NszXvG/fnC00VyruuiELQ
	DHBnqAA+nKBGUZnQkRn8Bn1YziAtEefsOnTbjjUWTUM8pI0tgpmtg0E6cOx9HOPB0HiEvWkwMxQ
	1bzIA==
X-Google-Smtp-Source: AGHT+IHU48TVMbZZ06BaX2FHhCjQJf/jbyynsWhPW3xkS0ZMHJ1S9oJLl04cYsCwruSXc+40zt/vYmmKqUSj/dJQZIs=
X-Received: by 2002:a05:6870:f62a:b0:34b:f75a:7d74 with SMTP id
 586e51a60fabf-35eeaa48c43mr7103886fac.42.1759135366721; Mon, 29 Sep 2025
 01:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929082338.18845-1-tzimmermann@suse.de>
In-Reply-To: <20250929082338.18845-1-tzimmermann@suse.de>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 29 Sep 2025 10:42:35 +0200
X-Gm-Features: AS18NWDvrzOYI2jOMxfCt8yOHbOV5vo3frPYW5dz6_9F-IIi9v5mUjFhty28Tfc
Message-ID: <CAMeQTsYCoTY9Hmh_Ww-sBFvgQKnbDzLDSgF_yzmOXiyVuKG3BQ@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Remove unused helper psb_fbdev_fb_setcolreg()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
	simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	Stefan Christ <contact@stefanchrist.eu>, Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:26=E2=80=AFAM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Remove psb_fbdev_fb_setcolreg(), which hasn't been called in almost
> a decade.
>
> Gma500 commit 4d8d096e9ae8 ("gma500: introduce the framebuffer support
> code") added the helper psb_fbdev_fb_setcolreg() for setting the fbdev
> palette via fbdev's fb_setcolreg callback. Later
> commit 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for
> fb_ops") set several default helpers for fbdev emulation, including
> fb_setcmap.
>
> The fbdev subsystem always prefers fb_setcmap over fb_setcolreg. [1]
> Hence, the gma500 code is no longer in use and gma500 has been using
> drm_fb_helper_setcmap() for several years without issues.
>
> Fixes: 3da6c2f3b730 ("drm/gma500: use DRM_FB_HELPER_DEFAULT_OPS for fb_op=
s")
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Stefan Christ <contact@stefanchrist.eu>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v4.10+
> Link: https://elixir.bootlin.com/linux/v6.16.9/source/drivers/video/fbdev=
/core/fbcmap.c#L246 # [1]
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Acked-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

> ---
>  drivers/gpu/drm/gma500/fbdev.c | 43 ----------------------------------
>  1 file changed, 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/fbdev.c b/drivers/gpu/drm/gma500/fbde=
v.c
> index 32d31e5f5f1a..a6af21514cff 100644
> --- a/drivers/gpu/drm/gma500/fbdev.c
> +++ b/drivers/gpu/drm/gma500/fbdev.c
> @@ -50,48 +50,6 @@ static const struct vm_operations_struct psb_fbdev_vm_=
ops =3D {
>   * struct fb_ops
>   */
>
> -#define CMAP_TOHW(_val, _width) ((((_val) << (_width)) + 0x7FFF - (_val)=
) >> 16)
> -
> -static int psb_fbdev_fb_setcolreg(unsigned int regno,
> -                                 unsigned int red, unsigned int green,
> -                                 unsigned int blue, unsigned int transp,
> -                                 struct fb_info *info)
> -{
> -       struct drm_fb_helper *fb_helper =3D info->par;
> -       struct drm_framebuffer *fb =3D fb_helper->fb;
> -       uint32_t v;
> -
> -       if (!fb)
> -               return -ENOMEM;
> -
> -       if (regno > 255)
> -               return 1;
> -
> -       red =3D CMAP_TOHW(red, info->var.red.length);
> -       blue =3D CMAP_TOHW(blue, info->var.blue.length);
> -       green =3D CMAP_TOHW(green, info->var.green.length);
> -       transp =3D CMAP_TOHW(transp, info->var.transp.length);
> -
> -       v =3D (red << info->var.red.offset) |
> -           (green << info->var.green.offset) |
> -           (blue << info->var.blue.offset) |
> -           (transp << info->var.transp.offset);
> -
> -       if (regno < 16) {
> -               switch (fb->format->cpp[0] * 8) {
> -               case 16:
> -                       ((uint32_t *) info->pseudo_palette)[regno] =3D v;
> -                       break;
> -               case 24:
> -               case 32:
> -                       ((uint32_t *) info->pseudo_palette)[regno] =3D v;
> -                       break;
> -               }
> -       }
> -
> -       return 0;
> -}
> -
>  static int psb_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct=
 *vma)
>  {
>         if (vma->vm_pgoff !=3D 0)
> @@ -135,7 +93,6 @@ static const struct fb_ops psb_fbdev_fb_ops =3D {
>         .owner =3D THIS_MODULE,
>         __FB_DEFAULT_IOMEM_OPS_RDWR,
>         DRM_FB_HELPER_DEFAULT_OPS,
> -       .fb_setcolreg =3D psb_fbdev_fb_setcolreg,
>         __FB_DEFAULT_IOMEM_OPS_DRAW,
>         .fb_mmap =3D psb_fbdev_fb_mmap,
>         .fb_destroy =3D psb_fbdev_fb_destroy,
> --
> 2.51.0
>

