Return-Path: <stable+bounces-69597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCCE956CC0
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 16:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1817AB21B9C
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 14:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41016C879;
	Mon, 19 Aug 2024 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jh+TKgCX"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3987A166F21
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076588; cv=none; b=bC9S+YBGo3x13ZTVK4zEMHN8nDXTE9TEXfneKoP8Px/+SI1S8vgNvZ919PhYO69QBRmryPu3xOM3JqMd51yaLNCZYo58+Yi7rogIYq8L/vySUP6LGAPsWaQ/jysc/AXbRNcuqF/bE+K9a4XZXe1WxRoM5yvHH8qzQ6u7BBjx+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076588; c=relaxed/simple;
	bh=l0vDxhzXBJ6Os7mUDwQCgrVtRR9Wk7ySQt9N0eOq0dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4OO+tEnbbFCaNUb7tKm0mCCeqN7mQz+YNDnOA0iXx87LZFTIlSx8JVutwx4PqGlXg62dl5Pq1PN5rmZ8Vq+JKfRi91dnqveFVdk0afKOjyXwmdCwyEadIS+UJp/zLw7zElIBubbjTsFucnDYcwbE2rSlzLFVIqrBXcuOuJmH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jh+TKgCX; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f9339e534so159556239f.3
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724076586; x=1724681386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swVfMfyxOr5BO79YIGcnKk6lTV20lDYKD6a7JRV6Zqk=;
        b=Jh+TKgCXY7tzcDun1DR5m5bqeTRCbwmS42E3eVFTPuXT0pk+yvGAfz6khBkGhKnQO6
         f2FUTjrqGolBe/kY3hhr9NQMVgxQ9SrhlsoS7p4Z7pt/DBkO62z33qA0r34aCYwOs2zw
         xiyowSwIxcL0/0uv1hC93Crq4nCwO9GtJ11iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724076586; x=1724681386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swVfMfyxOr5BO79YIGcnKk6lTV20lDYKD6a7JRV6Zqk=;
        b=K51zp3XoqjFsgefCQPPsaTwZ+q+qAh5cvzaXGXVL9L4EUZNP6Z1k5GdwG10k2wQfcy
         TqrM268pj4fatPvfOz3mrGsPIG782s9dert17l98FXwuT93+2ozuvX3n8/x/bTuJSW6i
         NxLhr7DgbpTYqstvQfeWjpmhtPM6GwPtgdE38EiM/mpLivd34XEchb2nRcnuNtvEMjpD
         Iez7AaVKoxLCuLukJJqzJRCeaOB7rqW3E/A/sBQsWxfjUwTgWMw1rFXH4ZpMNDUv+yUD
         Z73mH66QyFkZ+bDspHydgAMlUgAVsQyx4gW8QjRJoQmaSbA4X5H4uMAXXVq7IoeVNUVW
         +IVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHYBtEcQjrxX0cinajcE0r9IhjG2qdzws9WCowYk9vUakakW/ZqrdgPKNvF6TRY2R30juAp9U1VUcUJbRtOAn1lEfEsxUL
X-Gm-Message-State: AOJu0YwI33lvll3x6XbBJNGj5Crve+zqBbVnwEnARYv5RLsMIbxaFldR
	dCWAOeW26wv1DSuTU8YuAG1cqPHYnn9PsgsoccK+HVCLsEXwNat2LWbAUJMFAAeRA5n2YKdW6WA
	f3gd9wYHKAg51wEPzCuh23lxCowVHky3Im8jF
X-Google-Smtp-Source: AGHT+IF6F9x5DMW8ub4NKkAEYOfJWjZ7TcVM6VSK7bhktOE29lZYxUahzZgSlMmo6cSvAarIAawkJsxO1rOMFrEBfDg=
X-Received: by 2002:a05:6602:15d5:b0:803:c955:eda8 with SMTP id
 ca18e2360f4ac-824fe1b254amr978450439f.6.1724076586170; Mon, 19 Aug 2024
 07:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815153404.630214-1-zack.rusin@broadcom.com>
In-Reply-To: <20240815153404.630214-1-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Mon, 19 Aug 2024 17:09:35 +0300
Message-ID: <CAKLwHdVK=tkrWum2q46y9HETSCD+2tOafz19dz2Xee+ZHvLzYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] drm/vmwgfx: Prevent unmapping active read buffers
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 6:34=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.com=
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

LGTM.

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

