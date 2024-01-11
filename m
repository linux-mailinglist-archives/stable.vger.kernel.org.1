Return-Path: <stable+bounces-10471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3782A93C
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 09:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8D91F2324C
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619CBEAF1;
	Thu, 11 Jan 2024 08:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GiBau2Io"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430EF9F7
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3606ad581a5so23037135ab.1
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 00:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704962507; x=1705567307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=550c1yrOQXN+Snhrh37Aq0GIF7q37Rcv4r6FEQ4eDRQ=;
        b=GiBau2IogFr2Q8QnTKwqteeB+iPFX5LXITCOebKJyrR2PCe9ZUAMvs0FmASzUa/eMK
         ZBgiR7Cz9OOCHoKCGrGDCQLiqVTP5Yzc2RCmXTLpRHkJAPjFgtJh/2fTwE3OB9SI61v7
         3X4wu2QZQo1LNGsj9TjoAaLUpiKU4zVz8b9iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704962507; x=1705567307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=550c1yrOQXN+Snhrh37Aq0GIF7q37Rcv4r6FEQ4eDRQ=;
        b=vus9a4IMbEbdsWZ+JIuWPtA1ZDr9S0F4FYRz2Mpd0axDQyJeRIdC8hVP/e1WS4RbLx
         m9bDnm5nZJfKulW35Lna+8Fb7h/tJxGq1YVsxutb1aE8IRb+iuL9Ik6Hsch6MwxuOV/U
         Yxh3ojf9oshcEdvgEU5zosZ0WXgtJRBIOL2Uz2/C6EKEBom+s3wVIsfsD94bj/cE0pth
         RL9iTrRHsGs6N4XOpzGJEnFvcRI7Rjk2Q8O84FKvLnRzl/iDwtILYgtyeSoU+XOjWlSW
         M28F1dhBfpmDsb3N1px62xC1aVmaYRHWafNLLONG416WwOq9Wwc4iyF9dpY5FNsb/gBK
         3TZQ==
X-Gm-Message-State: AOJu0YyYeo8cIDSXCxWZxnORKiflBG0bdMC5jL1pQ0Sjls5PpiqQNEm7
	5IMHZuCO8P5sOKnyjNN3ftEXRLLWKj39SzfQsCRvIJiLb66O
X-Google-Smtp-Source: AGHT+IGoQDk4Xq5HD8MNABwxXliiZ1oGRGwXzZh+kmQ1BlUspFy1LeHGjfH3tAoFUsSps6DNVMKizyc70ZZ28P9N6E8=
X-Received: by 2002:a05:6e02:1bce:b0:360:6262:e31c with SMTP id
 x14-20020a056e021bce00b003606262e31cmr1174882ilv.14.1704962507445; Thu, 11
 Jan 2024 00:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110200305.94086-1-zack.rusin@broadcom.com>
In-Reply-To: <20240110200305.94086-1-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Thu, 11 Jan 2024 10:41:36 +0200
Message-ID: <CAKLwHdXBdeftC4CxGdOqZ8yE=s5yUPemX8i0my-hjfqbNvkn=A@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix possible null pointer derefence with
 invalid contexts
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org, 
	Niels De Graef <ndegraef@redhat.com>, Maaz Mombasawala <maaz.mombasawala@broadcom.com>, 
	Ian Forbes <ian.forbes@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:03=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> vmw_context_cotable can return either an error or a null pointer and its
> usage sometimes went unchecked. Subsequent code would then try to access
> either a null pointer or an error value.
>
> The invalid dereferences were only possible with malformed userspace
> apps which never properly initialized the rendering contexts.
>
> Check the results of vmw_context_cotable to fix the invalid derefs.
>
> Thanks:
> ziming zhang(@ezrak1e) from Ant Group Light-Year Security Lab
> who was the first person to discover it.
> Niels De Graef who reported it and helped to track down the poc.
>
> Fixes: 9c079b8ce8bf ("drm/vmwgfx: Adapt execbuf to the new validation api=
")
> Cc: <stable@vger.kernel.org> # v4.20+
> Reported-by: Niels De Graef  <ndegraef@redhat.com>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Martin Krastev <martin.krastev@broadcom.com>
> Cc: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
> Cc: Ian Forbes <ian.forbes@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_execbuf.c
> index 272141b6164c..4f09959d27ba 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
> @@ -447,7 +447,7 @@ static int vmw_resource_context_res_add(struct vmw_pr=
ivate *dev_priv,
>             vmw_res_type(ctx) =3D=3D vmw_res_dx_context) {
>                 for (i =3D 0; i < cotable_max; ++i) {
>                         res =3D vmw_context_cotable(ctx, i);
> -                       if (IS_ERR(res))
> +                       if (IS_ERR_OR_NULL(res))
>                                 continue;
>
>                         ret =3D vmw_execbuf_res_val_add(sw_context, res,
> @@ -1266,6 +1266,8 @@ static int vmw_cmd_dx_define_query(struct vmw_priva=
te *dev_priv,
>                 return -EINVAL;
>
>         cotable_res =3D vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_D=
XQUERY);
> +       if (IS_ERR_OR_NULL(cotable_res))
> +               return cotable_res ? PTR_ERR(cotable_res) : -EINVAL;
>         ret =3D vmw_cotable_notify(cotable_res, cmd->body.queryId);
>
>         return ret;
> @@ -2484,6 +2486,8 @@ static int vmw_cmd_dx_view_define(struct vmw_privat=
e *dev_priv,
>                 return ret;
>
>         res =3D vmw_context_cotable(ctx_node->ctx, vmw_view_cotables[view=
_type]);
> +       if (IS_ERR_OR_NULL(res))
> +               return res ? PTR_ERR(res) : -EINVAL;
>         ret =3D vmw_cotable_notify(res, cmd->defined_id);
>         if (unlikely(ret !=3D 0))
>                 return ret;
> @@ -2569,8 +2573,8 @@ static int vmw_cmd_dx_so_define(struct vmw_private =
*dev_priv,
>
>         so_type =3D vmw_so_cmd_to_type(header->id);
>         res =3D vmw_context_cotable(ctx_node->ctx, vmw_so_cotables[so_typ=
e]);
> -       if (IS_ERR(res))
> -               return PTR_ERR(res);
> +       if (IS_ERR_OR_NULL(res))
> +               return res ? PTR_ERR(res) : -EINVAL;
>         cmd =3D container_of(header, typeof(*cmd), header);
>         ret =3D vmw_cotable_notify(res, cmd->defined_id);
>
> @@ -2689,6 +2693,8 @@ static int vmw_cmd_dx_define_shader(struct vmw_priv=
ate *dev_priv,
>                 return -EINVAL;
>
>         res =3D vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_DXSHADER)=
;
> +       if (IS_ERR_OR_NULL(res))
> +               return res ? PTR_ERR(res) : -EINVAL;
>         ret =3D vmw_cotable_notify(res, cmd->body.shaderId);
>         if (ret)
>                 return ret;
> @@ -3010,6 +3016,8 @@ static int vmw_cmd_dx_define_streamoutput(struct vm=
w_private *dev_priv,
>         }
>
>         res =3D vmw_context_cotable(ctx_node->ctx, SVGA_COTABLE_STREAMOUT=
PUT);
> +       if (IS_ERR_OR_NULL(res))
> +               return res ? PTR_ERR(res) : -EINVAL;
>         ret =3D vmw_cotable_notify(res, cmd->body.soid);
>         if (ret)
>                 return ret;
> --
> 2.40.1
>

LGTM

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

