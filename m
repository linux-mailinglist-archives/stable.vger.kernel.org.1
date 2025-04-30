Return-Path: <stable+bounces-139165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9AFAA4C77
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44DA1C226B2
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D125B669;
	Wed, 30 Apr 2025 12:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJcgR5yZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEEB21773F;
	Wed, 30 Apr 2025 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017906; cv=none; b=lepZgBd94r1cTUqlaL04LnTY8ZOdsMFiLQPiubxwm8oADeCZkyqbpZazTBURsLB7KFYtJA6IuFVj5x7aodA+Tso/0tzP8lnGpSGQ19YdzCF70AFUjPNGxzHeNTL+fNJ6LTzKLyImJ7kBlPa1RBjLvmceeCxqACVxBFj4HrzWyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017906; c=relaxed/simple;
	bh=c+SQAgPs6sCPKdDf1TLFyBilf9sLkp04X2NHSMOYbr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l50lqqXjWTClp72azEjfPcrpFuRNTvDPXLl5k5RxvizWS+Eki8PhfBqCPuAhXM9/VlkJxD80N5WWW5DwZ0mM/2Y+VJk1Z+NuDJwo0fhL05fB3ArEbzl/GiyY43dn/gR3luizi3a4sqfDNn8cGjb8GEexOgzIU35+7SjZs/EtasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJcgR5yZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so871510a91.0;
        Wed, 30 Apr 2025 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746017904; x=1746622704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPXUIsE4ReVkZMwLEkZi0ELhyjfyphpwVsdpjPiS8oA=;
        b=SJcgR5yZnW33mz1BhlT3+JoEIICnavgiIYvBac7l46P0wdJ2Z7xnZwyFnnUC/AZKAb
         HHliOg5dfQDA0bS2fG5/B6rTQZ8Jyv6A32IBYdrvgIip3zfYocgNmIjUNUR/IheZIkaq
         /mAK2uKPniMk4DBibg/8OpxRJ1V/JNsE7zOAEZOTylfQPLVb04oQ0jIPuKOcDAhvh+5Y
         XVNjziHBLim+pmwtKUxiihR0HPl5uft9I9D0wPm2+pc7Btd7aETcqzcVOQnsYW0sQTOz
         9KN3wPSZf/mBo+AbiP3YQkOUD5v40T1WGx3JDQxJsPJJMEOmRrhSCIdEqo4oDqB58wMG
         0MqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017904; x=1746622704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPXUIsE4ReVkZMwLEkZi0ELhyjfyphpwVsdpjPiS8oA=;
        b=Wb6mB8278iWaV87J/tfELyafaP3q5BIHql4q/4wku+xkyaTmSyvST4kYJUVvBvWpuX
         sRdLDq7xOIVGLB8enroMI/80SmDdhorxcdWOH5opMXfcDnvK4LgnZaP6o7QSKC7QPk/d
         fv45737L6NiTooi2gicQCGScp8gs6xISKRSG3V1C2vuPmB2ThvF5MSwIL5gBKPVImOwM
         ROB+zaKFqbT+WjMyDOJyDLg1jyAizqJkPniPhmRX/u8bFL0/wEg3hofoCfGANnDWOBsn
         /9jCxChSW81RUc+UEBfny3LrjPoKaybDVlpnrK9mQmxBBFDh4LULQ6kT5AdQj/VGVosi
         wbOw==
X-Forwarded-Encrypted: i=1; AJvYcCWAMhcYH2SHEny3GfHotJ5y9+T0AwCxPaf4kfoIdD2IEHmrJOehE6Mjm45QXIEcEdhjZrLxdMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKUX+X1afNnH42B5VLJ7n7M9UITv7xf+rywQrF0JUdRgALrePN
	S0iggCoi67rbzwX7s7t66TgO9jcX3IHDaeFbqVPthmDjprvxu2KE5GS+buVF0VbRnFrnfXQIfZC
	iE/G9/DkudokKRjjyZ3KPfjndmBI=
X-Gm-Gg: ASbGncvfBjlRsWVjNEMzM4QMLh1gihmrxiX39mFSPjJY0xIfQeoO5i+UFvGK99q5YRo
	+MUW/d4VaEphm3RBVA4pQGajVWd0+KF06j/smuVORKDVIz5oXVS/ELpoLEmfTWnCWGgOELcBmE/
	Esyjc+xrhSZ8n/WXl3mp4sTg==
X-Google-Smtp-Source: AGHT+IHne2NVKYJwscRaLJsR6gKOyn7FqLSafssyaWrQrJGysCVrW+PztelMHMNGWGSZ04yVwAV9giBDJp8jUNh6Xvw=
X-Received: by 2002:a17:90b:4a07:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-30a349d709fmr1419994a91.2.1746017903888; Wed, 30 Apr 2025
 05:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429235122.537321-1-sashal@kernel.org> <20250429235122.537321-32-sashal@kernel.org>
In-Reply-To: <20250429235122.537321-32-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 08:58:12 -0400
X-Gm-Features: ATxdqUHHvbOgz8ETiF5ngfd_6ddDF71hTJ4TeMgxDWq22BPGXjcwbXxwcH0Btow
Message-ID: <CADnq5_M4=NSxAc+N3hSoTX9hwJcpvogy1hkg3Sx29zqsSpGkZQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 32/37] drm/amdgpu: Allow P2P access through XGMI
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Felix Kuehling <felix.kuehling@amd.com>, Hao Zhou <hao.zhou@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com, simona@ffwll.ch, 
	Yunxiang.Li@amd.com, tvrtko.ursulin@igalia.com, matthew.auld@intel.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:58=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
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
> index 2f90fff1b9ddc..e63a32c214475 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -42,6 +42,29 @@
>  #include <linux/dma-fence-array.h>
>  #include <linux/pci-p2pdma.h>
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
> @@ -53,11 +76,13 @@
>  static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
>                                  struct dma_buf_attachment *attach)
>  {
> +       struct amdgpu_device *attach_adev =3D dma_buf_attach_adev(attach)=
;
>         struct drm_gem_object *obj =3D dmabuf->priv;
>         struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
>         struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
>
> -       if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
> +       if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
> +           pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
>                 attach->peer2peer =3D false;
>
>         return 0;
> @@ -456,6 +481,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_d=
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

