Return-Path: <stable+bounces-139163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30945AA4C23
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1788D9C7F01
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A61219307;
	Wed, 30 Apr 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7KJ242K"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A40221F0E;
	Wed, 30 Apr 2025 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017865; cv=none; b=JFa46jyGQi0pE3gf659P0DC8Uhnn69w+ghrUaVUultoBcPZoLgNlOO8mU0JIBZXg8X/7ms+MAK0wcwzEUxaybmv//ryBMbtZKYVhG5dCwAcy2rOD4ng+QtvcpYaiyVZXdFQ3EzOXG4/qx2gvqOyogURkmJZS0TQAxX+iSS1DFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017865; c=relaxed/simple;
	bh=9qPP5PNftrah6ri/cztEnnoO4hLSYjKaxWmldomFwDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tptEvtqXTqUzS9aVkQeFS5Fy6yYRjS2S5p0yb0qb3IWqXGSmIiK5r2vr2I53H1aQUagzuWxtDH6Ty9XjKQuoJ2qusSBGbIbMwgNjGE6MYDnbB3gh2nFhWxTnoU1WtxCWSJthJJcto2WGFw2PsKbpXZYx1a2d79t0ecZ7jOlYFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7KJ242K; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso761257a91.1;
        Wed, 30 Apr 2025 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746017863; x=1746622663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rm05lpTkOVOHXu8eGRdE6kXYVUr0GQNtiOAVsh1nNCg=;
        b=C7KJ242KYQ15vgG/zWSJEVRrvGJ2RycOlfKvKoAGtJPrI3yk63Jp5kZyvQ2P/xrWGU
         LE8s3uf7ky2EsOv1EBXGXaAYQr9CMGlPzXu4E5gXdyWl9NqjHoTZpTIWwQYar7D6RCYL
         bHl0ALpneo6gbCKqhRuiRYDfdJYZ4ZBOGEUgIDTaDXhytqpnKPeyWJM+8a78RbnvnQZk
         LVuUllheXy/fjE3kCvnxVuscDAwfX4j5UVmZoVriMSCYxkn5CSFANHx3c4JthMZwy652
         aAWVku4pcrD/5terbTL+j9tNjEH1zoQy9GDotXoP7lT0RsTWveu1uTS3vXzAp2xzUTD8
         u3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017863; x=1746622663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rm05lpTkOVOHXu8eGRdE6kXYVUr0GQNtiOAVsh1nNCg=;
        b=ITKnpUPGH4eDAVPCS3OkhRXoNm7elshwLlZhWPH4oV3JO0b99h5JLo9lhV6wrMXPUw
         YTqpVbosBJ7+oafaEQ3W97Ok5ZiLqLz3n68v+QyWSFjhrAnGBWJfNtZ3Qt/OLmIGzBuz
         qy/EGtVtB4RxLA2YeaOUhV5Mp4Gbl2namswZtnzKjLIyUHSBspFlD1RuZAkFky1UIc1x
         BBKY8YfwS7wwyrkKgSKWB7F0s+IVRFb2ZpCjZY8Zt/GxZm40kCvEcooFco6FcxPKNeCE
         rmVkDT8BpYyBW4CCr5JnxMFh7LY1VwyROa6Ak8J3KaVfitzMx6HvYYcp8OC8LIdFABLC
         L+hA==
X-Forwarded-Encrypted: i=1; AJvYcCWq+7D3CQfUepLB0BheJ94Ty72PqnXHq37XhdcrLrNCpoma7XtnG90Q8b7YhmnPByfy8nRwRCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWaoAUqc9mCCFg9SG0okzdBf3S1cRws4FCXyGFZXJA/rRr8DsR
	5F76P4H4RXAkrPf43jvY3/XNesLcrW0tZHP9sXweyHDflVy40oYHm3O3+o7NjcdrJLZiMo4+iys
	cSmDn+DOmO9MEPFBXDboYJ3cPMkA=
X-Gm-Gg: ASbGncv+OgfrDlbQrFo0n+BLY3uI4fkClYqKfj/9vyCGFisA0LMfRb6wAW5ZrYIhCxJ
	iCueQk1rFgS0WGHHR0wvShArhEiJ6izSsQneDMbzqFoqM06lcswrTxAhCdmwVflccc21cG+TR+w
	iKqOVIatCKPy/ToOiC8DrRJnHkTMCPAOC2
X-Google-Smtp-Source: AGHT+IHsahqat7sRDVZbpn87HSfKCGqp+eBYCISXvsmpIZH8IyO4vathjjFMmGbSmuz1hqRFo78WfmBbT1d//7/DQAM=
X-Received: by 2002:a17:90b:1c07:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-30a3b959b2cmr271359a91.0.1746017863425; Wed, 30 Apr 2025
 05:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429235316.538129-1-sashal@kernel.org> <20250429235316.538129-7-sashal@kernel.org>
In-Reply-To: <20250429235316.538129-7-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 08:57:30 -0400
X-Gm-Features: ATxdqUGOAb33lS8ofFWUIrrEQktvjwc5jTIu1Jk9cnpJOqAND3CyqoIWsvrv9zE
Message-ID: <CADnq5_NacNmcKKQUdrbTtEGAn8UCvvJHki+JMUPMRA2AB6T8VA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.1 07/10] drm/amdgpu: Allow P2P access through XGMI
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Felix Kuehling <felix.kuehling@amd.com>, Hao Zhou <hao.zhou@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com, simona@ffwll.ch, 
	Yunxiang.Li@amd.com, matthew.auld@intel.com, tvrtko.ursulin@igalia.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:03=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Felix Kuehling <felix.kuehling@amd.com>
>
> [ Upstream commit a92741e72f91b904c1d8c3d409ed8dbe9c1f2b26 ]
>
> If peer memory is accessible through XGMI, allow leaving it in VRAM
> rather than forcing its migration to GTT on DMABuf attachment.
>
> Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
> Tested-by: Hao (Claire) Zhou <hao.zhou@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> (cherry picked from commit 372c8d72c3680fdea3fbb2d6b089f76b4a6d596a)
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This patch is only applicable to 6.15 and newer.  Please drop for stable.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 30 ++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index ab06cb4d7b358..4dcc7de961d08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -42,6 +42,29 @@
>  #include <linux/pci-p2pdma.h>
>  #include <linux/pm_runtime.h>
>
> +static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
> +
> +/**
> + * dma_buf_attach_adev - Helper to get adev of an attachment
> + *
> + * @attach: attachment
> + *
> + * Returns:
> + * A struct amdgpu_device * if the attaching device is an amdgpu device =
or
> + * partition, NULL otherwise.
> + */
> +static struct amdgpu_device *dma_buf_attach_adev(struct dma_buf_attachme=
nt *attach)
> +{
> +       if (attach->importer_ops =3D=3D &amdgpu_dma_buf_attach_ops) {
> +               struct drm_gem_object *obj =3D attach->importer_priv;
> +               struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> +
> +               return amdgpu_ttm_adev(bo->tbo.bdev);
> +       }
> +
> +       return NULL;
> +}
> +
>  /**
>   * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
>   *
> @@ -53,12 +76,14 @@
>  static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>                                  struct dma_buf_attachment *attach)
>  {
> +       struct amdgpu_device *attach_adev =3D dma_buf_attach_adev(attach)=
;
>         struct drm_gem_object *obj =3D dmabuf->priv;
>         struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>         int r;
>
> -       if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
> +       if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
> +           pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>                 attach->peer2peer =3D false;
>
>         r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -479,6 +504,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_d=
evice *adev,
>         struct drm_gem_object *obj =3D &bo->tbo.base;
>         struct drm_gem_object *gobj;
>
> +       if (!adev)
> +               return false;
> +
>         if (obj->import_attach) {
>                 struct dma_buf *dma_buf =3D obj->import_attach->dmabuf;
>
> --
> 2.39.5
>

