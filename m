Return-Path: <stable+bounces-77729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA82198676E
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 22:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C7C6B2135C
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 20:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E354146593;
	Wed, 25 Sep 2024 20:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AA3TO+Hg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00DE1F94C;
	Wed, 25 Sep 2024 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295039; cv=none; b=BNqqceNVY5TT7Z+smQbZhfT+Gw5v/8YB1s5N37hYGcc3pHIecQg4eE6oT81DzGwLJHs62ZGXQqQMmSnqDHQOg/tyVlrNDdvU56YNy994QH5d703bv/hHiZENllNuQAAxYLm5ri+OOqhe1o3vFqHv7pO4nzeVgFeX5oRawzlZ06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295039; c=relaxed/simple;
	bh=hLxdskNRRdNZtRPuTHsLy1cHsopxxozgAUxq3VyXRqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnPlNw1Ni0hcBDBW+hvn2xDKTNjai/GFfTw75A01SQqcNwnLLCGmIV14Wo2Ds7cr4CZgaqYSPbREla+cQr4O7ZYaYnEkE1SUiKsy65cBvESY8ODZ4jlmmbcWngJcIlW/GKM2/FXWccmlQ+hjXfWHBYG2uHqjGiIOXKTblzOrIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AA3TO+Hg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-206bd1c6ccdso1473725ad.3;
        Wed, 25 Sep 2024 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727295037; x=1727899837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0Q4FugCe7sn8SMQy2y1X+wwncOJwqePtQZMDheIXf4=;
        b=AA3TO+HgVpBFoGc16m7cUBmXzktCQJzaBepvc+29itgW5iiLUNDdi7yF3hJ9qGBhmZ
         n4cozAuXmaNAADrrqWCeuZQBUY9qm16F6UEqBLkONAGJMm4AhH5hXiHDnYPCX8TDGAs2
         Pk9BqZQIKuwqI7e2/ubYSuVuejI13DVlIvT28t0e9gJxVremaxno5uDLy5MosXUtS9ic
         yIiip5VUSg479j7eyCwiN82N7nAkxzypSQbo2i+XHbs+uqYfjeEQWv9knp1NHjQKTyea
         bcEDZnxVDIMpmoYuyKBAkFKl8zP8MumIGcRmelrUD2NxbmR3kIox4IWp59cbBOEx5yEd
         EgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727295037; x=1727899837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0Q4FugCe7sn8SMQy2y1X+wwncOJwqePtQZMDheIXf4=;
        b=imVkHjgpLBwAhrpCQTJAdKsFc0wsSXHyQ3F2M3x0c55LqmRKzZbdlKXDas1TpdpdO9
         WxEGdJyqXbaihLwSGhf9ij7FUnrxDbZXeVm38B8Dln8rr8LiHx50di/uGDTAyWi2uocl
         QUI4F4/gp+11UcVE4UqEHM+CQCoV3NhGWjhXEzMjdFSo5NLORQNYxuyR+t6KX5nkNliM
         nF6lj6tWcMKE0eeDtbrqw7cgAjwniyzE+3dL9tlC44zO83H/iF9a9Jgmd+wPDJ1nX47a
         VMclnGTIEeWSPqTM7CpwEYeg3CfqnG3069Q+DjXL75a/xX4H3l5wUNEcNKIjkro/PMJe
         wHBw==
X-Forwarded-Encrypted: i=1; AJvYcCUTB6K7pO5mfot167cSzvbDtTGLTiF8/SeKPBRK/ecWGeRLZ888boe8kdSC3JBbjSI+KgaE8wW+@vger.kernel.org, AJvYcCUjfzqp9OJrOCmxjHiN8k5pE0JnqTVP7DDk18VXI8NISndbFQjlR8ypSVXVYbTI9C0CPoUsWK7RJU9vCpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJlxhjKcOWdg4Cj2qdPVGLb4DT1ScK3AqvDYrZ0ocgzMYQxXrz
	g6pWeMF8fONX8a1vysmN3BIbRHXMdCIkWK3I+knJ+TXoLqc+oERMnZGROoJ6PsRpwo3MEQ3Arzw
	+fIFa1t7ZxmYp0mzZwWIiV7KnuZw=
X-Google-Smtp-Source: AGHT+IGCOWvHWEUBxGxHoNzs8SQWmesgz6UsMD49z3Jmcc4GwM6UD45zyniAE253U3751P7pVRLYxBPXbonaOjby/mw=
X-Received: by 2002:a17:902:d4c6:b0:205:7e3f:9e31 with SMTP id
 d9443c01a7336-20afc6429a0mr39006245ad.60.1727295036833; Wed, 25 Sep 2024
 13:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bd0b8d63-f543-480e-85b4-2b8cec178c38@linaro.org> <20240910151600.18659-1-abelova@astralinux.ru>
In-Reply-To: <20240910151600.18659-1-abelova@astralinux.ru>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 22:10:25 +0200
Message-ID: <CAFBinCCVL5idjip8NtDTimid+H0xmoMT1807SBj0-dFaH+hbkQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/meson: switch to a managed drm device
To: Anastasia Belova <abelova@astralinux.ru>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Anastasia,

thank you for picking this up and apologies for my late reply.

On Tue, Sep 10, 2024 at 5:17=E2=80=AFPM Anastasia Belova <abelova@astralinu=
x.ru> wrote:
[...]
> @@ -215,7 +210,7 @@ static int meson_drv_bind_master(struct device *dev, =
bool has_components)
>         regs =3D devm_platform_ioremap_resource_byname(pdev, "vpu");
>         if (IS_ERR(regs)) {
>                 ret =3D PTR_ERR(regs);
> -               goto free_drm;
> +               goto remove_encoders;
can't we just return PTR_ERR(regs) here since all resources above are
now automatically free (as they are devm_* managed)?

>         }
>
>         priv->io_base =3D regs;
> @@ -223,13 +218,13 @@ static int meson_drv_bind_master(struct device *dev=
, bool has_components)
>         res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi")=
;
>         if (!res) {
>                 ret =3D -EINVAL;
> -               goto free_drm;
> +               goto remove_encoders;
same here, can't we just return -EINVAL directly?

>         }
>         /* Simply ioremap since it may be a shared register zone */
>         regs =3D devm_ioremap(dev, res->start, resource_size(res));
>         if (!regs) {
>                 ret =3D -EADDRNOTAVAIL;
> -               goto free_drm;
> +               goto remove_encoders;
also just return -EADDRNOTAVAIL directly

>         }
>
>         priv->hhi =3D devm_regmap_init_mmio(dev, regs,
> @@ -237,18 +232,18 @@ static int meson_drv_bind_master(struct device *dev=
, bool has_components)
>         if (IS_ERR(priv->hhi)) {
>                 dev_err(&pdev->dev, "Couldn't create the HHI regmap\n");
>                 ret =3D PTR_ERR(priv->hhi);
either return PTR_ERR(priv->hhi) here or convert the dev_err to
dev_err_probe and return it's value

> -               goto free_drm;
> +               goto remove_encoders;
>         }
>
>         priv->canvas =3D meson_canvas_get(dev);
>         if (IS_ERR(priv->canvas)) {
>                 ret =3D PTR_ERR(priv->canvas);
> -               goto free_drm;
> +               goto remove_encoders;
return PTR_ERR(priv->canvas);

>         }
>
>         ret =3D meson_canvas_alloc(priv->canvas, &priv->canvas_id_osd1);
>         if (ret)
> -               goto free_drm;
> +               goto remove_encoders;
meson_canvas_alloc() is the first non devm_* managed allocation.
so this is the last time we can simply "return ret;", starting with
the next error case we need goto for cleaning up resources.

>         ret =3D meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_0);
>         if (ret)
>                 goto free_canvas_osd1;
(starting from here the goto free_... is needed and this one is
actually already correct)

> @@ -261,7 +256,7 @@ static int meson_drv_bind_master(struct device *dev, =
bool has_components)
>
>         priv->vsync_irq =3D platform_get_irq(pdev, 0);
>
> -       ret =3D drm_vblank_init(drm, 1);
> +       ret =3D drm_vblank_init(&priv->drm, 1);
>         if (ret)
>                 goto free_canvas_vd1_2;
>
> @@ -284,10 +279,10 @@ static int meson_drv_bind_master(struct device *dev=
, bool has_components)
>         ret =3D drmm_mode_config_init(drm);
>         if (ret)
>                 goto free_canvas_vd1_2;
> -       drm->mode_config.max_width =3D 3840;
> -       drm->mode_config.max_height =3D 2160;
> -       drm->mode_config.funcs =3D &meson_mode_config_funcs;
> -       drm->mode_config.helper_private =3D &meson_mode_config_helpers;
> +       priv->drm.mode_config.max_width =3D 3840;
> +       priv->drm.mode_config.max_height =3D 2160;
> +       priv->drm.mode_config.funcs =3D &meson_mode_config_funcs;
> +       priv->drm.mode_config.helper_private =3D &meson_mode_config_helpe=
rs;
>
>         /* Hardware Initialization */
>
> @@ -308,9 +303,9 @@ static int meson_drv_bind_master(struct device *dev, =
bool has_components)
>                 goto exit_afbcd;
>
>         if (has_components) {
> -               ret =3D component_bind_all(dev, drm);
> +               ret =3D component_bind_all(dev, &priv->drm);
>                 if (ret) {
> -                       dev_err(drm->dev, "Couldn't bind all components\n=
");
> +                       dev_err(priv->drm.dev, "Couldn't bind all compone=
nts\n");
>                         /* Do not try to unbind */
>                         has_components =3D false;
>                         goto exit_afbcd;
just below this we have:
    ret =3D meson_encoder_hdmi_probe(priv);
    if (ret)
        goto exit_afbcd;
I think this is the place where we need to call component_unbind_all,
so we need some kind of "goto unbind_components;" here.
All other "goto exit_afbcd;" below will need to be converted to "goto
unbind_components;" (or whichever name you choose) as well.

Also the ordering where component_unbind_all() is incorrect. It's been
incorrect even before your patch - but maybe now is the right time to
clean it up?

I had to double check because I was surprised about the calls to
meson_encoder_{cvbs,dsi,hdmi}_remove(priv);
It turns out that it's safe to call these three functions at any time
because they only ever do something if their _probe() counterpart has
been called.



Best regards,
Martin

