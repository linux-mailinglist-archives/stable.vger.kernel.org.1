Return-Path: <stable+bounces-70317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CB960557
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 11:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFD11F21B7E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 09:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11E676056;
	Tue, 27 Aug 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BIUoBI5u"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C54DA1F
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750231; cv=none; b=rUWkPgitRYxyMokaCGGBhy+zf8Z7UiIx6mGMGt6KyNvP06M23I/PTP8HBvrZlo2C1P3yU2byTp1subN+jskanhe+q3BAk4v9PdbF3/0RVg3cH8+x1zMfE0oFteL+V83CHe+qGRvam02R8sLMQh5TUVBcSB+2BgAh9WP+C+A45+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750231; c=relaxed/simple;
	bh=Oud4iNFW62t2JL4wPQWu8C1R6PlF+gJoG20fr0NSNUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocs5Sv/fWPqNdNOznWRd3/bLVfg6fOH5A/1rMHVYVu5pvm7Ax/8GMLmDRDYOLurbxsJDgpXHnfzR3wSXkjhQrjMo3XdiV+NjqM5EAqD7XfYLNY3zxGtRWkY3gTnXBOuBUcXOsEzntTbN4dqzeU+S8KWnW9IOU7PhNacv1kIgJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BIUoBI5u; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8252bc7b00bso193975939f.1
        for <stable@vger.kernel.org>; Tue, 27 Aug 2024 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724750229; x=1725355029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdMODqh85uSFZ7j3d6O0gNItgJn+faeygZ7qlxL9/8E=;
        b=BIUoBI5ujsZDwnWgjEBNCt8m22QHL2kF/lKGrroJwy36BNbTjnayeMbhwr78fEZSQT
         Ofr9PwMSEk5K0/gUCEDGFnNQ2lj1/vpOZc8ceulWw+z4Me5lirIpXQY7lJzsBuouWtWp
         HD9H4eM/tKkNCx3lbDeymbE5/xUTpl0emeT/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724750229; x=1725355029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdMODqh85uSFZ7j3d6O0gNItgJn+faeygZ7qlxL9/8E=;
        b=LaWPWkyLxJGtOdamb/RPAyfHLLmcxsz5sxL11f1ecM0rRCxwDMu3+kS7F8DADXu8L/
         U3QVBtA6l/+veLwIhG46KjeQJAPgrWGs3LiUC67WyGPhP8w6hWRdMFjJNnZ1oLhnWNUY
         MbA+/oybtDMRqochdp8S5m00tG+0mTAAHUad7QXNeP0KcbNecJNN238OwGHAXuN7Gsak
         7q+sEJT8FyPPyDMWHDAKlk2yegiJU+s8MoN1CGFcH2OxjkOZkX7pu6t29jMj1IVmfDwf
         jt9l4jQg0vFrv+YODWPpTJ4nsNP1esyMQxMmcLdkV+753yikhZ/h4PrxaDmFh+XJMnHC
         jH1g==
X-Forwarded-Encrypted: i=1; AJvYcCV0kcfQgeZO5IN3Wj5ZN/Ydlz19iYSfuY24p7VJnVRERG01/T3+UOaLweKqA0gm2AHIHLS3T+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeO0lCK3iUUAJxBOSQL5nyTT4OYqQz0YxtgNm6quiae5VAcQa
	FAgBT5Upi2/RCh5u8RW03E/sOWuGsFRD9APQmbKuOFpkKZT/D2IT1JVgVYkfeeRjx1JRJA+H7+L
	7FRBbPUzExwpNz3zJjoReMSty0yNUrsDmZVu7
X-Google-Smtp-Source: AGHT+IEF2B0KcCm8AcUmPhOOOimTQQOhUbMObYq1rz+SR4njavyaogDQUT2qrp8CiwU8zfuzCXWIZDvdom9e8SKDWKM=
X-Received: by 2002:a05:6602:1652:b0:81f:a54e:f1eb with SMTP id
 ca18e2360f4ac-827881c318emr1532937639f.17.1724750228971; Tue, 27 Aug 2024
 02:17:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827043905.472825-1-zack.rusin@broadcom.com>
In-Reply-To: <20240827043905.472825-1-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Tue, 27 Aug 2024 12:16:58 +0300
Message-ID: <CAKLwHdVTFELspB7oqEBu+ZUbap=1QJLqNR=RLvmN1=gdN3FGAQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/vmwgfx: Cleanup kms setup without 3d
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:39=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com=
> wrote:
>
> Do not validate format equality for the non 3d cases to allow xrgb to
> argb copies and make sure the dx binding flags are only used
> on dx compatible surfaces.
>
> Fixes basic 2d kms setup on configurations without 3d. There's little
> practical benefit to it because kms framebuffer coherence is disabled
> on configurations without 3d but with those changes the code actually
> makes sense.
>
> v2: Remove the now unused format variable
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: d6667f0ddf46 ("drm/vmwgfx: Fix handling of dumb buffers")
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.9+
> Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> Cc: Martin Krastev <martin.krastev@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_kms.c     | 29 -------------------------
>  drivers/gpu/drm/vmwgfx/vmwgfx_surface.c |  9 +++++---
>  2 files changed, 6 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_kms.c
> index 288ed0bb75cb..282b6153bcdd 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
> @@ -1283,7 +1283,6 @@ static int vmw_kms_new_framebuffer_surface(struct v=
mw_private *dev_priv,
>  {
>         struct drm_device *dev =3D &dev_priv->drm;
>         struct vmw_framebuffer_surface *vfbs;
> -       enum SVGA3dSurfaceFormat format;
>         struct vmw_surface *surface;
>         int ret;
>
> @@ -1320,34 +1319,6 @@ static int vmw_kms_new_framebuffer_surface(struct =
vmw_private *dev_priv,
>                 return -EINVAL;
>         }
>
> -       switch (mode_cmd->pixel_format) {
> -       case DRM_FORMAT_ARGB8888:
> -               format =3D SVGA3D_A8R8G8B8;
> -               break;
> -       case DRM_FORMAT_XRGB8888:
> -               format =3D SVGA3D_X8R8G8B8;
> -               break;
> -       case DRM_FORMAT_RGB565:
> -               format =3D SVGA3D_R5G6B5;
> -               break;
> -       case DRM_FORMAT_XRGB1555:
> -               format =3D SVGA3D_A1R5G5B5;
> -               break;
> -       default:
> -               DRM_ERROR("Invalid pixel format: %p4cc\n",
> -                         &mode_cmd->pixel_format);
> -               return -EINVAL;
> -       }
> -
> -       /*
> -        * For DX, surface format validation is done when surface->scanou=
t
> -        * is set.
> -        */
> -       if (!has_sm4_context(dev_priv) && format !=3D surface->metadata.f=
ormat) {
> -               DRM_ERROR("Invalid surface format for requested mode.\n")=
;
> -               return -EINVAL;
> -       }
> -
>         vfbs =3D kzalloc(sizeof(*vfbs), GFP_KERNEL);
>         if (!vfbs) {
>                 ret =3D -ENOMEM;
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index 1625b30d9970..5721c74da3e0 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -2276,9 +2276,12 @@ int vmw_dumb_create(struct drm_file *file_priv,
>         const struct SVGA3dSurfaceDesc *desc =3D vmw_surface_get_desc(for=
mat);
>         SVGA3dSurfaceAllFlags flags =3D SVGA3D_SURFACE_HINT_TEXTURE |
>                                       SVGA3D_SURFACE_HINT_RENDERTARGET |
> -                                     SVGA3D_SURFACE_SCREENTARGET |
> -                                     SVGA3D_SURFACE_BIND_SHADER_RESOURCE=
 |
> -                                     SVGA3D_SURFACE_BIND_RENDER_TARGET;
> +                                     SVGA3D_SURFACE_SCREENTARGET;
> +
> +       if (vmw_surface_is_dx_screen_target_format(format)) {
> +               flags |=3D SVGA3D_SURFACE_BIND_SHADER_RESOURCE |
> +                        SVGA3D_SURFACE_BIND_RENDER_TARGET;
> +       }
>
>         /*
>          * Without mob support we're just going to use raw memory buffer
> --
> 2.43.0
>

LGTM.

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

