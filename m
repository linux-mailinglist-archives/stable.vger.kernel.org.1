Return-Path: <stable+bounces-139164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B941AA4C74
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 15:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A794A08AE
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7162609FA;
	Wed, 30 Apr 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIobZn35"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAA2627E9;
	Wed, 30 Apr 2025 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017889; cv=none; b=D4Zh/6RvWkomQLh3sP3h+EhGwDtkH4Dei4gPdJxxmAGvZqdjSmzkTkiF133PHMY7AyCfPjz1WdUpb3VPhN0eeArSW4+46KOuMcSqDiQImJE2v1Kfc0LMLeQS1UawQtSTTj1fnSlA7oZtOEq5pxG6oCdVpmK/ZQtnyhyNPkoVxlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017889; c=relaxed/simple;
	bh=0TyqcB1u9URkai5dPVAfsRJpXMRdRlmtQXoSxVCnQ6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1fMVN08RHmsTnfVJSkcs9cSWnwItDPInkqm0rdvOsUMSfnRpterIKqPgTdGZAJZYunUFoB7MrVBxupfTh6+lwPta+bO+3Dqq30eJOJAioZ4xdqdriq8GJa4sRfZ6IvK0RLwnHTEO0AzGZ4kt14E7yz6wHnfWBBxUTjaB6pXf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIobZn35; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so623259a91.0;
        Wed, 30 Apr 2025 05:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746017887; x=1746622687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1akON1o4PR3e5D1TI8Ndz51nWQooVFDodiAjMxjF6A=;
        b=FIobZn35HWM7VIT9Rr2fyRzxpUBUJ15zyonX/NqYXDwdQXOxWVU3pl3y6gCB8sDuPE
         WfLIWInog6fjgjZzzF1qmelMVd2SQMhy/A2MBtCny8eCt/v8xU95XK3RNVkRRKBTXRer
         wAS7v5xUtSLcI3jTuWG7pXe7EA45fdQG9RBJxk2uukmmLZnvUDfXZAu0KN10ady4lkaL
         ZZcTj1eKLSbVvLP4wfffp5Jo7kD7N6JOZKYSO0oWWLMrdXaVNKeSxEX7oodsR2kVsqcS
         3TKQVldS8jTSMUEGLJwlVx2I1LL8qF2G1dGL3RVScImvfoiLIFiX5poepZC8Dz5r1RGd
         R0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017887; x=1746622687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w1akON1o4PR3e5D1TI8Ndz51nWQooVFDodiAjMxjF6A=;
        b=FGNPWr1fZIctsM0OTpPv4IaNP0Q1xziJKHG+4R/yXICTjvG41ciNNR8j9ttYBT8+li
         JeZS+gJY9purL6zsTvP9OM7PTI32De5yKglqo4Fgv2/zKsimGa3fn1IdJi77u80LJwis
         wHs5YowD8pNVq0TWgAZRIhnmP8t5yhAL5sACpNU7Ew1aV1P74aBPcvi+MjbxvYXnjG5K
         QUISWF83dp31e964Z3MSChHQ6K+oS1tOeADUWbyEYc0r7yuddqcD8Fq4szg2awWOkkdg
         yZnJZInycQkN9z3ofubjjJ9nCcaiQ5byRfkLUZDEv74k+XW+v8yHyjiWelLMnhMh3kZW
         FNAg==
X-Forwarded-Encrypted: i=1; AJvYcCVSjXOtUFIFT5atGL1vVCwOolqjBBB1HeQhc6auo2YqzyPADk0ubmShcmn0ksZUqTH1GD3x2Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaly1on2kf9zpPDeiuaMF0KwpVn5fWYVBIZSV+mM2LmBtjj/yV
	ZNmhf0Q3J5m6F7Dt6kj9kktHCfOezNJEhYbFHWUMkL588GzmwmeIcE1wu1xxjCpPzXar4xk61zO
	0ypNd+Gd02Q5ICGE0u30HkgRnoq0=
X-Gm-Gg: ASbGncuSOXR2Eg0aDkllU7HJj6K/D860uurh+lrsBCJC2j4zBTbV+vxxR4moClJUQzc
	Lfx54/hsPYNt/I7XTGRfQA+k5vI7TQmaWJoZvqzAyYgi+nXV7QOvft+toSTPR/eax9ka3ZP6UYB
	WExliEfv28JTydqrpvmNqwUQ==
X-Google-Smtp-Source: AGHT+IFkgBWA5Qz+38wX3ie0e4pxXoHem2tefzFM+zdcot5D0U/XdRjt4IzjaRXDLGP924qPLiNa3sAqw5Z1l8JSrRs=
X-Received: by 2002:a17:90b:4d90:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-30a34ab3ffamr1322221a91.7.1746017886792; Wed, 30 Apr 2025
 05:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429235233.537828-1-sashal@kernel.org> <20250429235233.537828-18-sashal@kernel.org>
In-Reply-To: <20250429235233.537828-18-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 08:57:55 -0400
X-Gm-Features: ATxdqUG2QivkrM09P4CiwCQRObyzJMJYNyE22wZ8sy_0nnVPZuHIF6dm-UUbAH8
Message-ID: <CADnq5_MMNrRSkwAPHU4n2jpHyZ_Lr28wVguZ8yducpQeLZJP_w@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 18/21] drm/amdgpu: Allow P2P access through XGMI
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Felix Kuehling <felix.kuehling@amd.com>, Hao Zhou <hao.zhou@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com, simona@ffwll.ch, 
	Yunxiang.Li@amd.com, tvrtko.ursulin@igalia.com, matthew.auld@intel.com, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 8:04=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
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
> index be4cc4868a748..493e18bcea069 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -43,6 +43,29 @@
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
> @@ -54,12 +77,14 @@
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
> @@ -482,6 +507,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_d=
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

