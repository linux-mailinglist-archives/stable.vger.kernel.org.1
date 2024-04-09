Return-Path: <stable+bounces-37886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B310489DF43
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 17:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54F81C213C3
	for <lists+stable@lfdr.de>; Tue,  9 Apr 2024 15:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B474B1350EA;
	Tue,  9 Apr 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PspTf+FO"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C513D60F
	for <stable@vger.kernel.org>; Tue,  9 Apr 2024 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676638; cv=none; b=BXnNsiywrVVOkHZ1l3MgemDIIloztLQTOrlFHoZWRmN+dTYbPy+d4+II37+HGW1qKSPy9IBbw+lPxy+ADKmb3/eOnn2+IsuuTq+3WlB4YnWWVe7dl1NJy75Qzju7pEekLgl7Gv9ZQiCryTPb3TQRq1kwslP3gNi69zPUu7XB7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676638; c=relaxed/simple;
	bh=oKmSWVpp2gP91klpmbpCYnTdhMXF63MbZEzH64TMZa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixY0/wZ9IT5dT+5ukzm67EOR7Dl2dLsw1AOglhaoHXqfF9LSeeq3Ser33z4mvXDIMBz6Id6Q3RQl6kylvPVugNSPQRTYBOl39EzMh3QpLbo/315L6N/eFKYDKFuc19na9YMTno1oL0Mcz9VRm8Wkw7e+0/+blyjuQ3R6B2K86SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PspTf+FO; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c8bd9837fdso166510539f.1
        for <stable@vger.kernel.org>; Tue, 09 Apr 2024 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1712676635; x=1713281435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7pkM9X3L8i+5l2WmNZjwSJL8yHaurOwht5xAgN/gL0=;
        b=PspTf+FOJ8vX83PpRfwdIMchS09sMJBHPdu8X4KPmTFtJHvxe0zphmCZtBGUx852pS
         zzkkmikPi97RY0ERQkdfEyR1mKuW/DNMa0RfLfVL4Yvc1dl29Ld6XymOrgfA4FIs4H6K
         nA7idGeK2t6c808TB7NisZ1HWx/v9qBPt1k5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676635; x=1713281435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7pkM9X3L8i+5l2WmNZjwSJL8yHaurOwht5xAgN/gL0=;
        b=VbsOEC4mMJJQA6Ahxe5gQ/MdCtB3J1DIzzxqRtpHhHTLTKB5i5NGXDxzU0GQfQdbcs
         WmGp4l6bePAJ9smB17A0Vit/Dh9GweHcftQTDWZxrm13u0rRAej5wAFXURCLRNMqok80
         Swpif8GW27CTh7LGaBfXX7PgyIaKR2uHLGZwWv9XcvkV02YUkK6iYF7wQ0H/mZjpm4IJ
         fEVpcjhB8ZMEkn+9nPWds0efIZo5gvEEhqY7kTv2JuQCckGotvGMzZQVajQq/+pkKnVR
         Ikd2RZ0PYbl+Tu4grCWDTG7F5E9iCaRlnUPw8c7hgcxEa7D4q+6PFK9qgjaamHsMNgwJ
         De8A==
X-Forwarded-Encrypted: i=1; AJvYcCUlkpuDRc90Isf5Mn2T6XUF7Rw6uWkc90sYOh107CrHteoK0zCWkQEmu2ZoiWyqJUzgj1K0CrAOCKxyaFNrjodQPVV7MekW
X-Gm-Message-State: AOJu0Yw1mp7x/h5y6Km0aKDLTMw1VCvl7Sh+GNGdhpl46XcdekOiM3Cs
	cdHlqJA8tfO5TJYH0KtHOhaD+vo8oCz1BPIQuZT3HPk5BziNpBcTEyHUGf4aFPu0QKBA2C2JKG5
	C8R50HG5YEx1Idun52bzkpfSCvPEucUvTvq+q
X-Google-Smtp-Source: AGHT+IFckpVCK3eC57FBtAzs7OITwELUEHs0HsWMmVkd/n3t6mcAdzZWtQB3ZK2Q8e/6vAv1EL10YH/ijceaz6+Dsj0=
X-Received: by 2002:a05:6602:3f07:b0:7d5:df1d:2562 with SMTP id
 em7-20020a0566023f0700b007d5df1d2562mr110467iob.14.1712676635277; Tue, 09 Apr
 2024 08:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402232813.2670131-1-zack.rusin@broadcom.com> <20240402232813.2670131-4-zack.rusin@broadcom.com>
In-Reply-To: <20240402232813.2670131-4-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Tue, 9 Apr 2024 18:30:24 +0300
Message-ID: <CAKLwHdW+3zP5s7dAb2fkbWjrRvx9EhPTODtdMRfoFYFb+qUvQw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/vmwgfx: Fix prime import/export
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Great to have this!

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

On Wed, Apr 3, 2024 at 2:28=E2=80=AFAM Zack Rusin <zack.rusin@broadcom.com>=
 wrote:
>
> vmwgfx never supported prime import of external buffers. Furthermore the
> driver exposes two different objects to userspace: vmw_surface's and
> gem buffers but prime import/export only worked with vmw_surfaces.
>
> Because gem buffers are used through the dumb_buffer interface this meant
> that the driver created buffers couldn't have been prime exported or
> imported.
>
> Fix prime import/export. Makes IGT's kms_prime pass.
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 8afa13a0583f ("drm/vmwgfx: Implement DRIVER_GEM")
> Cc: <stable@vger.kernel.org> # v6.6+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_blit.c       | 35 +++++++++++++++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.c         |  7 ++--
>  drivers/gpu/drm/vmwgfx/vmwgfx_bo.h         |  2 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  1 +
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.h        |  3 ++
>  drivers/gpu/drm/vmwgfx/vmwgfx_gem.c        | 32 ++++++++++++++++
>  drivers/gpu/drm/vmwgfx/vmwgfx_prime.c      | 15 +++++++-
>  drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 44 +++++++++++++++-------
>  8 files changed, 117 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c b/drivers/gpu/drm/vmwgf=
x/vmwgfx_blit.c
> index c52c7bf1485b..717d624e9a05 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_blit.c
> @@ -456,8 +456,10 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
>                 .no_wait_gpu =3D false
>         };
>         u32 j, initial_line =3D dst_offset / dst_stride;
> -       struct vmw_bo_blit_line_data d;
> +       struct vmw_bo_blit_line_data d =3D {0};
>         int ret =3D 0;
> +       struct page **dst_pages =3D NULL;
> +       struct page **src_pages =3D NULL;
>
>         /* Buffer objects need to be either pinned or reserved: */
>         if (!(dst->pin_count))
> @@ -477,12 +479,35 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
>                         return ret;
>         }
>
> +       if (!src->ttm->pages && src->ttm->sg) {
> +               src_pages =3D kvmalloc_array(src->ttm->num_pages,
> +                                          sizeof(struct page *), GFP_KER=
NEL);
> +               if (!src_pages)
> +                       return -ENOMEM;
> +               ret =3D drm_prime_sg_to_page_array(src->ttm->sg, src_page=
s,
> +                                                src->ttm->num_pages);
> +               if (ret)
> +                       goto out;
> +       }
> +       if (!dst->ttm->pages && dst->ttm->sg) {
> +               dst_pages =3D kvmalloc_array(dst->ttm->num_pages,
> +                                          sizeof(struct page *), GFP_KER=
NEL);
> +               if (!dst_pages) {
> +                       ret =3D -ENOMEM;
> +                       goto out;
> +               }
> +               ret =3D drm_prime_sg_to_page_array(dst->ttm->sg, dst_page=
s,
> +                                                dst->ttm->num_pages);
> +               if (ret)
> +                       goto out;
> +       }
> +
>         d.mapped_dst =3D 0;
>         d.mapped_src =3D 0;
>         d.dst_addr =3D NULL;
>         d.src_addr =3D NULL;
> -       d.dst_pages =3D dst->ttm->pages;
> -       d.src_pages =3D src->ttm->pages;
> +       d.dst_pages =3D dst->ttm->pages ? dst->ttm->pages : dst_pages;
> +       d.src_pages =3D src->ttm->pages ? src->ttm->pages : src_pages;
>         d.dst_num_pages =3D PFN_UP(dst->resource->size);
>         d.src_num_pages =3D PFN_UP(src->resource->size);
>         d.dst_prot =3D ttm_io_prot(dst, dst->resource, PAGE_KERNEL);
> @@ -504,6 +529,10 @@ int vmw_bo_cpu_blit(struct ttm_buffer_object *dst,
>                 kunmap_atomic(d.src_addr);
>         if (d.dst_addr)
>                 kunmap_atomic(d.dst_addr);
> +       if (src_pages)
> +               kvfree(src_pages);
> +       if (dst_pages)
> +               kvfree(dst_pages);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index bfd41ce3c8f4..e5eb21a471a6 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -377,7 +377,8 @@ static int vmw_bo_init(struct vmw_private *dev_priv,
>  {
>         struct ttm_operation_ctx ctx =3D {
>                 .interruptible =3D params->bo_type !=3D ttm_bo_type_kerne=
l,
> -               .no_wait_gpu =3D false
> +               .no_wait_gpu =3D false,
> +               .resv =3D params->resv,
>         };
>         struct ttm_device *bdev =3D &dev_priv->bdev;
>         struct drm_device *vdev =3D &dev_priv->drm;
> @@ -394,8 +395,8 @@ static int vmw_bo_init(struct vmw_private *dev_priv,
>
>         vmw_bo_placement_set(vmw_bo, params->domain, params->busy_domain)=
;
>         ret =3D ttm_bo_init_reserved(bdev, &vmw_bo->tbo, params->bo_type,
> -                                  &vmw_bo->placement, 0, &ctx, NULL,
> -                                  NULL, destroy);
> +                                  &vmw_bo->placement, 0, &ctx,
> +                                  params->sg, params->resv, destroy);
>         if (unlikely(ret))
>                 return ret;
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.h
> index 0d496dc9c6af..f349642e6190 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
> @@ -55,6 +55,8 @@ struct vmw_bo_params {
>         enum ttm_bo_type bo_type;
>         size_t size;
>         bool pin;
> +       struct dma_resv *resv;
> +       struct sg_table *sg;
>  };
>
>  /**
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.c
> index 89d3679d2608..41ad13e45554 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -1631,6 +1631,7 @@ static const struct drm_driver driver =3D {
>
>         .prime_fd_to_handle =3D vmw_prime_fd_to_handle,
>         .prime_handle_to_fd =3D vmw_prime_handle_to_fd,
> +       .gem_prime_import_sg_table =3D vmw_prime_import_sg_table,
>
>         .fops =3D &vmwgfx_driver_fops,
>         .name =3D VMWGFX_DRIVER_NAME,
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx=
/vmwgfx_drv.h
> index ddbceaa31b59..4ecaea0026fc 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
> @@ -1107,6 +1107,9 @@ extern int vmw_prime_handle_to_fd(struct drm_device=
 *dev,
>                                   struct drm_file *file_priv,
>                                   uint32_t handle, uint32_t flags,
>                                   int *prime_fd);
> +struct drm_gem_object *vmw_prime_import_sg_table(struct drm_device *dev,
> +                                                struct dma_buf_attachmen=
t *attach,
> +                                                struct sg_table *table);
>
>  /*
>   * MemoryOBject management -  vmwgfx_mob.c
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_gem.c
> index 186150f41fbc..2132a8ad8c0c 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
> @@ -136,6 +136,38 @@ int vmw_gem_object_create_with_handle(struct vmw_pri=
vate *dev_priv,
>         return ret;
>  }
>
> +struct drm_gem_object *vmw_prime_import_sg_table(struct drm_device *dev,
> +                                                struct dma_buf_attachmen=
t *attach,
> +                                                struct sg_table *table)
> +{
> +       int ret;
> +       struct vmw_private *dev_priv =3D vmw_priv(dev);
> +       struct drm_gem_object *gem =3D NULL;
> +       struct vmw_bo *vbo;
> +       struct vmw_bo_params params =3D {
> +               .domain =3D (dev_priv->has_mob) ? VMW_BO_DOMAIN_SYS : VMW=
_BO_DOMAIN_VRAM,
> +               .busy_domain =3D VMW_BO_DOMAIN_SYS,
> +               .bo_type =3D ttm_bo_type_sg,
> +               .size =3D attach->dmabuf->size,
> +               .pin =3D false,
> +               .resv =3D attach->dmabuf->resv,
> +               .sg =3D table,
> +
> +       };
> +
> +       dma_resv_lock(params.resv, NULL);
> +
> +       ret =3D vmw_bo_create(dev_priv, &params, &vbo);
> +       if (ret !=3D 0)
> +               goto out_no_bo;
> +
> +       vbo->tbo.base.funcs =3D &vmw_gem_object_funcs;
> +
> +       gem =3D &vbo->tbo.base;
> +out_no_bo:
> +       dma_resv_unlock(params.resv);
> +       return gem;
> +}
>
>  int vmw_gem_object_create_ioctl(struct drm_device *dev, void *data,
>                                 struct drm_file *filp)
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_prime.c
> index 2d72a5ee7c0c..c99cad444991 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
> @@ -75,8 +75,12 @@ int vmw_prime_fd_to_handle(struct drm_device *dev,
>                            int fd, u32 *handle)
>  {
>         struct ttm_object_file *tfile =3D vmw_fpriv(file_priv)->tfile;
> +       int ret =3D ttm_prime_fd_to_handle(tfile, fd, handle);
>
> -       return ttm_prime_fd_to_handle(tfile, fd, handle);
> +       if (ret)
> +               ret =3D drm_gem_prime_fd_to_handle(dev, file_priv, fd, ha=
ndle);
> +
> +       return ret;
>  }
>
>  int vmw_prime_handle_to_fd(struct drm_device *dev,
> @@ -85,5 +89,12 @@ int vmw_prime_handle_to_fd(struct drm_device *dev,
>                            int *prime_fd)
>  {
>         struct ttm_object_file *tfile =3D vmw_fpriv(file_priv)->tfile;
> -       return ttm_prime_handle_to_fd(tfile, handle, flags, prime_fd);
> +       int ret;
> +
> +       if (handle > VMWGFX_NUM_MOB)
> +               ret =3D ttm_prime_handle_to_fd(tfile, handle, flags, prim=
e_fd);
> +       else
> +               ret =3D drm_gem_prime_handle_to_fd(dev, file_priv, handle=
, flags, prime_fd);
> +
> +       return ret;
>  }
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm=
/vmwgfx/vmwgfx_ttm_buffer.c
> index 4d23d0a70bcb..621d98b376bb 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
> @@ -188,13 +188,18 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_t=
t)
>         switch (dev_priv->map_mode) {
>         case vmw_dma_map_bind:
>         case vmw_dma_map_populate:
> -               vsgt->sgt =3D &vmw_tt->sgt;
> -               ret =3D sg_alloc_table_from_pages_segment(
> -                       &vmw_tt->sgt, vsgt->pages, vsgt->num_pages, 0,
> -                       (unsigned long)vsgt->num_pages << PAGE_SHIFT,
> -                       dma_get_max_seg_size(dev_priv->drm.dev), GFP_KERN=
EL);
> -               if (ret)
> -                       goto out_sg_alloc_fail;
> +               if (vmw_tt->dma_ttm.page_flags  & TTM_TT_FLAG_EXTERNAL) {
> +                       vsgt->sgt =3D vmw_tt->dma_ttm.sg;
> +               } else {
> +                       vsgt->sgt =3D &vmw_tt->sgt;
> +                       ret =3D sg_alloc_table_from_pages_segment(&vmw_tt=
->sgt,
> +                               vsgt->pages, vsgt->num_pages, 0,
> +                               (unsigned long)vsgt->num_pages << PAGE_SH=
IFT,
> +                               dma_get_max_seg_size(dev_priv->drm.dev),
> +                               GFP_KERNEL);
> +                       if (ret)
> +                               goto out_sg_alloc_fail;
> +               }
>
>                 ret =3D vmw_ttm_map_for_dma(vmw_tt);
>                 if (unlikely(ret !=3D 0))
> @@ -209,8 +214,9 @@ static int vmw_ttm_map_dma(struct vmw_ttm_tt *vmw_tt)
>         return 0;
>
>  out_map_fail:
> -       sg_free_table(vmw_tt->vsgt.sgt);
> -       vmw_tt->vsgt.sgt =3D NULL;
> +       drm_warn(&dev_priv->drm, "VSG table map failed!");
> +       sg_free_table(vsgt->sgt);
> +       vsgt->sgt =3D NULL;
>  out_sg_alloc_fail:
>         return ret;
>  }
> @@ -356,15 +362,17 @@ static void vmw_ttm_destroy(struct ttm_device *bdev=
, struct ttm_tt *ttm)
>  static int vmw_ttm_populate(struct ttm_device *bdev,
>                             struct ttm_tt *ttm, struct ttm_operation_ctx =
*ctx)
>  {
> -       int ret;
> +       bool external =3D (ttm->page_flags & TTM_TT_FLAG_EXTERNAL) !=3D 0=
;
>
> -       /* TODO: maybe completely drop this ? */
>         if (ttm_tt_is_populated(ttm))
>                 return 0;
>
> -       ret =3D ttm_pool_alloc(&bdev->pool, ttm, ctx);
> +       if (external && ttm->sg)
> +               return  drm_prime_sg_to_dma_addr_array(ttm->sg,
> +                                                      ttm->dma_address,
> +                                                      ttm->num_pages);
>
> -       return ret;
> +       return ttm_pool_alloc(&bdev->pool, ttm, ctx);
>  }
>
>  static void vmw_ttm_unpopulate(struct ttm_device *bdev,
> @@ -372,6 +380,10 @@ static void vmw_ttm_unpopulate(struct ttm_device *bd=
ev,
>  {
>         struct vmw_ttm_tt *vmw_tt =3D container_of(ttm, struct vmw_ttm_tt=
,
>                                                  dma_ttm);
> +       bool external =3D (ttm->page_flags & TTM_TT_FLAG_EXTERNAL) !=3D 0=
;
> +
> +       if (external)
> +               return;
>
>         vmw_ttm_unbind(bdev, ttm);
>
> @@ -390,6 +402,7 @@ static struct ttm_tt *vmw_ttm_tt_create(struct ttm_bu=
ffer_object *bo,
>  {
>         struct vmw_ttm_tt *vmw_be;
>         int ret;
> +       bool external =3D bo->type =3D=3D ttm_bo_type_sg;
>
>         vmw_be =3D kzalloc(sizeof(*vmw_be), GFP_KERNEL);
>         if (!vmw_be)
> @@ -398,7 +411,10 @@ static struct ttm_tt *vmw_ttm_tt_create(struct ttm_b=
uffer_object *bo,
>         vmw_be->dev_priv =3D vmw_priv_from_ttm(bo->bdev);
>         vmw_be->mob =3D NULL;
>
> -       if (vmw_be->dev_priv->map_mode =3D=3D vmw_dma_alloc_coherent)
> +       if (external)
> +               page_flags |=3D TTM_TT_FLAG_EXTERNAL | TTM_TT_FLAG_EXTERN=
AL_MAPPABLE;
> +
> +       if (vmw_be->dev_priv->map_mode =3D=3D vmw_dma_alloc_coherent || e=
xternal)
>                 ret =3D ttm_sg_tt_init(&vmw_be->dma_ttm, bo, page_flags,
>                                      ttm_cached);
>         else
> --
> 2.40.1
>

