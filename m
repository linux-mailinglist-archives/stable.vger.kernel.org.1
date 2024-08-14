Return-Path: <stable+bounces-67708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2F49522BA
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 21:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2271C21299
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 19:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4512D1BE864;
	Wed, 14 Aug 2024 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KZ77uaKK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B425B679
	for <stable@vger.kernel.org>; Wed, 14 Aug 2024 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723664152; cv=none; b=SZqSEPCN7fR86r4izh0xQnCW8KecDTpD6WACcheqsdJwyasCVp77Ax6Y4MnGO9BEjwL+aY/EVoKeLlV4lP2SFLyU6xmXCxQ7NN7wOElbHMMCSlkpkQiRXU2rfmdmmT//ttWFRuvdlzsZ0oDRoytqVXdShEltzZf6KLN+ltGeS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723664152; c=relaxed/simple;
	bh=hCK6Laa/742kBHO3hq7sPCrsBSdM2akuM5yTETvD0Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVaOH/YYjRAjFqEMahRlcx8NLtEHUCYvl5FmAMb43PLZa6XXvSk6IhTSdBqfCzwTBKLDv9iIFHtIwRTJ8qDiW7ju0egTGv/LbfS6B2XRdiMRenKwqOMpxBequdIiXmRwp+FwpcJPBP/1sqAIsmzRvCNredvXQaG+VC6+QE+iZg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KZ77uaKK; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-690b6cbce11so2920357b3.2
        for <stable@vger.kernel.org>; Wed, 14 Aug 2024 12:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723664146; x=1724268946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXKYkmuG/SU6rLkPPinW1g80glKtRtQVhMpRCtKKj8A=;
        b=KZ77uaKKz+rtvhhjfZCOmhxFmfCvTigitA0GlX3BxdVUf+HuAsRYvxAabNWDadNqDc
         iqnahKXQ4eRa+I2eGvfYtANjHvXjudR9U7O3MKKK3IKscoJr/BYuqZjwq50U23jaCzHZ
         NXMnJGKbXA4+ozeKjakB5CCrnUd2mXC5rffTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723664146; x=1724268946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXKYkmuG/SU6rLkPPinW1g80glKtRtQVhMpRCtKKj8A=;
        b=DqP0rUVdoe4gKjh08kBaymWNaxmeu2wmhkccxGfVrKHK4Ug3zDLZY/VjhvCkA6BDZS
         DZ7qFSjWWnL6ZhXXBXEjOadDOsjRRf2AoGTysVU2AjLxytM2V09ncPVdhw3tl44r/661
         un3NNg8n5zI3Sx3a7TOEo1TjtmPBpJ7f9vZ256kTejkGWYv8buN2kxmADYMXIkypMCkT
         mUOqidQHV8YIxoVtz+ZNPp1H2uNMR6aDkg0mg7QNCday5/kQGJRX1fLO4ocFOtg5NBRs
         k5kqYJ6qHPvlRh+xKR8k75FhFok0UgdAwiAGDhRPQibzFLXfUVOILsDvp1qr4I0Veu6e
         ffaA==
X-Forwarded-Encrypted: i=1; AJvYcCVuq20mdljlgVNB70vHXnepZ9VxZCQtrix1b0DoB3quz6FgUsWc683Cr2HBW/EawgcNy2fRaafL/KR/3yczlsgPV5v6q7li
X-Gm-Message-State: AOJu0Yw5dUWi11K0c0j8RBuyUvV3s+ZQxivsu9545+eclunXxF9N6Z4l
	flCc8pJPJ6eBq/pbbNmrc4phnndq4sHnTzJq7aVff/mDEUVo/hkZmsly3Lq9h5Q5MJrmlw71E+X
	ZpTVWhU7zlffuC9Mth4PY26hBcpg32+kbMFEX
X-Google-Smtp-Source: AGHT+IE7lpozbo57felRmsSQr4ai2rs4R3ER9HGxXfX32TS2VRfQKIj+17yMahwS4vWORjT4Ir13rVg9MI6jY42fexo=
X-Received: by 2002:a05:690c:578f:b0:6af:5295:6673 with SMTP id
 00721157ae682-6af5295692fmr3468097b3.28.1723664146311; Wed, 14 Aug 2024
 12:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814192824.56750-1-zack.rusin@broadcom.com>
In-Reply-To: <20240814192824.56750-1-zack.rusin@broadcom.com>
From: Ian Forbes <ian.forbes@broadcom.com>
Date: Wed, 14 Aug 2024 14:35:36 -0500
Message-ID: <CAO6MGti4NYG8-kqUb2+xmQkQc7eJGsGcxa+YJ6Xt5pUf1CgY7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/vmwgfx: Prevent unmapping active read buffers
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, martin.krastev@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks Good
Thanks,

Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>

On Wed, Aug 14, 2024 at 2:28=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.com=
> wrote:
>
> The kms paths keep a persistent map active to read and compare the cursor
> buffer. These maps can race with each other in simple scenario where:
> a) buffer "a" mapped for update
> b) buffer "a" mapped for compare
> c) do the compare
> d) unmap "a" for compare
> e) update the cursor
> f) unmap "a" for update
> At step "e" the buffer has been unmapped and the read contents is bogus.
>
> Prevent unmapping of active read buffers by simply keeping a count of
> how many paths have currently active maps and unmap only when the count
> reaches 0.
>
> v2: Update doc strings
>
> Fixes: 485d98d472d5 ("drm/vmwgfx: Add support for CursorMob and CursorByp=
ass 4")
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v5.19+
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c | 13 +++++++++++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.h |  3 +++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index f42ebc4a7c22..a0e433fbcba6 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -360,6 +360,8 @@ void *vmw_bo_map_and_cache_size(struct vmw_bo *vbo, s=
ize_t size)
>         void *virtual;
>         int ret;
>
> +       atomic_inc(&vbo->map_count);
> +
>         virtual =3D ttm_kmap_obj_virtual(&vbo->map, &not_used);
>         if (virtual)
>                 return virtual;
> @@ -383,11 +385,17 @@ void *vmw_bo_map_and_cache_size(struct vmw_bo *vbo,=
 size_t size)
>   */
>  void vmw_bo_unmap(struct vmw_bo *vbo)
>  {
> +       int map_count;
> +
>         if (vbo->map.bo =3D=3D NULL)
>                 return;
>
> -       ttm_bo_kunmap(&vbo->map);
> -       vbo->map.bo =3D NULL;
> +       map_count =3D atomic_dec_return(&vbo->map_count);
> +
> +       if (!map_count) {
> +               ttm_bo_kunmap(&vbo->map);
> +               vbo->map.bo =3D NULL;
> +       }
>  }
>
>
> @@ -421,6 +429,7 @@ static int vmw_bo_init(struct vmw_private *dev_priv,
>         vmw_bo->tbo.priority =3D 3;
>         vmw_bo->res_tree =3D RB_ROOT;
>         xa_init(&vmw_bo->detached_resources);
> +       atomic_set(&vmw_bo->map_count, 0);
>
>         params->size =3D ALIGN(params->size, PAGE_SIZE);
>         drm_gem_private_object_init(vdev, &vmw_bo->tbo.base, params->size=
);
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.h
> index 62b4342d5f7c..43b5439ec9f7 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
> @@ -71,6 +71,8 @@ struct vmw_bo_params {
>   * @map: Kmap object for semi-persistent mappings
>   * @res_tree: RB tree of resources using this buffer object as a backing=
 MOB
>   * @res_prios: Eviction priority counts for attached resources
> + * @map_count: The number of currently active maps. Will differ from the
> + * cpu_writers because it includes kernel maps.
>   * @cpu_writers: Number of synccpu write grabs. Protected by reservation=
 when
>   * increased. May be decreased without reservation.
>   * @dx_query_ctx: DX context if this buffer object is used as a DX query=
 MOB
> @@ -90,6 +92,7 @@ struct vmw_bo {
>         u32 res_prios[TTM_MAX_BO_PRIORITY];
>         struct xarray detached_resources;
>
> +       atomic_t map_count;
>         atomic_t cpu_writers;
>         /* Not ref-counted.  Protected by binding_mutex */
>         struct vmw_resource *dx_query_ctx;
> --
> 2.43.0
>

