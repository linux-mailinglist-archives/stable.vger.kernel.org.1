Return-Path: <stable+bounces-139166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBB8AA4C7A
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7511BA4574
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77558258CE6;
	Wed, 30 Apr 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaoKFpVg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38033086;
	Wed, 30 Apr 2025 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017940; cv=none; b=DMbCAPkd2bSVHtsOznIT5Ch//gXWImncFwi9fJ7rrfLx+xAdzYlmwZtuQbEs/HgyMAEiIVo+Lyd1fqhAXFgCNleQljN9aDq9ZTIaPYxMLu/THyLQUavgW1gMRMurEDUvIc9Sv+KZ/5bUTbfLZGcrA+DljGk1vVc+nJcMg+Q7Xlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017940; c=relaxed/simple;
	bh=zVgltmdq1wA/pgvM1Uq/QGAwIGV8nII32Z/sCy5d8aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdOpNx+RMWzP2m32jsNUXPew2kxgegVK0uHVilHO3o3KHjhogva8cHT78qJYmsMj5ZMLiYOgLMAbEvyoclHMXtkaYmTnkczmOaAR7Lx1fkyim/jqTQPfLklXmXN4tI81HJLkcHpgz7nqXi75sM78hFL5LNe8pqrqAHJ0GCKsdaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaoKFpVg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3032a9c7cfeso761385a91.1;
        Wed, 30 Apr 2025 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746017938; x=1746622738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dQgDsBrKKb7LUHfJaqvSu3D4gwYk1wUfztt+eVLekw=;
        b=RaoKFpVg0bvuCNVO6il67qQxIx/yvYc2eZNb+Ml+PC+T/NsfqMxoftVfRXvIs9Bw9C
         2k9rsBlvnKNrltALY7D/rwe1PqYpDXMRS/FGZiPCn0f3AfOwAkMzxB/ProNdXy1clqRC
         rabH4+8U96PPFihgXq8c2r5zh1PsrAkJlDPY5aQzXKPabkPK5T8lYKFdLG2qsEFOjopA
         TaWRiMW61QlZYld7mzAXTX4rZQCA1KcVd6oWRmwHWlwBFkwr/QkMQ0XFtvQQ5q1zo10t
         pQ2otjFo9TC1UPqzpB4INI68I+34JXIzbfJko95oz4sa7zwx9NvfNv7JCdgowPfiEMEK
         3yGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017938; x=1746622738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dQgDsBrKKb7LUHfJaqvSu3D4gwYk1wUfztt+eVLekw=;
        b=o1mwnIJCk9PDXexg7g2RLfuZtBxgMVfPEiYV7YBzB4ZXU63lbTHsqvCUzVaVUKaTMa
         qGODmR+p8BWxfHO8E3QF0iTCjbTorMPxwmSWmNKPbdfJMPFLwudeDC4yypKqqJAQpTbN
         bqMUQ5xKgR2s6b0SF+eCuyDviTHXLdfvGdQXdVw9hC+i14qZeh3LllhEoEyrgTq9npz8
         H+wS+hQVJV3xRoKJZCvNlIRwu/syuS9353hBnMaWr7sopiRCNyur7KvxOg6aF9ZY+A0S
         zYkbCPariEhlE6AW1f4Du5rERs7WqA8TkSCg1eeSSBf/Ggentm3x/1bYlBu6XLljSbAj
         1eYw==
X-Forwarded-Encrypted: i=1; AJvYcCXrsd63HIR/1usM24kA1ZsvE/aKKp/BciAViAhA4KCEK1Kc6NQzRywtYqC9UBiaYTvL5CHCstA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfHc0vib4X7gaHWZhpELkbIPWg1Yc30L5fWIGKER1aU8C4FoE
	P9Kpak2eVDiSK9YlB5T83HziXn2TNYSkH163xAJRsvPw49QxizPwmLW9zWsTMSOlyvAkFSnRXs7
	nYC9+HRMqWBE2lDl+8FY02LRNIis=
X-Gm-Gg: ASbGncsz3flcO6nj5HbTvb7g2f3avOJy5O3QmLf0uH4LoGHy3b09qxQD4ztaflgmzZj
	TT3O39z2tHp568YxCLC5EB8gtigUVejfC6ul9ma20pyRRlgyRAMUt8L0rVLpykkB2AjmWCvaZxo
	lUxVU88jB3jwrzdysgPRH+/nLSwqc2KNsy
X-Google-Smtp-Source: AGHT+IHPHDfrVZ0RLZ1bQoLDYi3iVYqbjTOtxBO8xR4L/VADlcQSd95Z8b6hZvsjpcRtLCg5EcVqWeVLl2E0ftk48Ew=
X-Received: by 2002:a17:90b:4d0a:b0:2fe:b2ea:30f0 with SMTP id
 98e67ed59e1d1-30a3bb65eb8mr270758a91.4.1746017937898; Wed, 30 Apr 2025
 05:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429235006.536648-1-sashal@kernel.org> <20250429235006.536648-33-sashal@kernel.org>
In-Reply-To: <20250429235006.536648-33-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 08:58:45 -0400
X-Gm-Features: ATxdqUFE2oLBHIj4SHrxk1wfj1ZCoBa2urs6nrnbqf5-qqwOEYtXEpH592CaLS8
Message-ID: <CADnq5_Neg_tkGf2JVT+QuAuU06EY=XwBXBH680JFXyfW4FwUMg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 33/39] drm/amdgpu: Allow P2P access through XGMI
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Felix Kuehling <felix.kuehling@amd.com>, Hao Zhou <hao.zhou@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com, simona@ffwll.ch, 
	Yunxiang.Li@amd.com, tvrtko.ursulin@igalia.com, matthew.auld@intel.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:51=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
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
> index c9842a0e2a1cd..cb043296f9aec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -43,6 +43,29 @@
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
> @@ -54,11 +77,13 @@
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
>         amdgpu_vm_bo_update_shared(bo);
> @@ -459,6 +484,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_d=
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

