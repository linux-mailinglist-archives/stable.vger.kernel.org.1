Return-Path: <stable+bounces-69908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747F495BDCE
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 19:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C873285A5D
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 17:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC01CF2B4;
	Thu, 22 Aug 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYHjqw8z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73911CF2A9;
	Thu, 22 Aug 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724349361; cv=none; b=Z2azlNki9Cgy924G4AtuKaFH/fStbaQwk/wej160Fl02Gq1Dza6jCTeB8sbNjpwJoILlOvmDsrVPf7BM/hGz/l1ffFfOgW29n3ks7xDK1fZsBUCYrENnbkrVbLalhAruRQfY5e9ZKSDejLWEh29eW3HLBDCP4NfLK0zoRBqwAOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724349361; c=relaxed/simple;
	bh=smVYnWuAmitIbB8+8SNe7l+nZkHzp1QzNF7x5k33bTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oG9eUUkyD0gMMn4oANVtyVzM3xW1gQGatSvS3O8vVt0arEr5Nut/4BHbxhQwI+PzkibyD6JdGHgzGYFu6SYGzpto2R0vCV2EkAlk48uxTfliemkNElNah/a3bJXAWM/gTccZ1PDXUOBHz0YEXSwAvvOQq9nBSdE3iFY1qQpHemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYHjqw8z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-201e2ebed48so727125ad.0;
        Thu, 22 Aug 2024 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724349358; x=1724954158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhXu1/y7UKtVxtPjaKnW4gHUfJYvKyvM1SAHsg1HIWY=;
        b=HYHjqw8zDU5Hijh/rtpWIt366YUxIGkm/p+HTtEMQPIJQk96WYsrAAqvqyvEf0VcI2
         w9TS9gnoVyy42W1EZc4gxqJkGH7AOIldRdz4wmxDoWpyJuMGZdzW9UaOQ732NUY2bocC
         oFzHE68MvBPkGrlEa3aRaFRdifPg706w2Kes70o3Yz2LrRHq3ikEMMFrptmETZjupdbH
         MvWg0b21RaPJY5+GsXe7UFopgLwEXMpPjVfInihSCpAQZ1oDT+5Lwton396BhkzZ6LCP
         wrTx6aI2yXI5I7HebiRDc7oNjAwKSRn2DiQSj+ywrBy1sNBBQyshirHmF4dT9MIPshyM
         oV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724349358; x=1724954158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhXu1/y7UKtVxtPjaKnW4gHUfJYvKyvM1SAHsg1HIWY=;
        b=d2PtxzyPEEkbukUvYklvh6PjiULQPAKvlAwjkW1gj1ufuj6W2tGAPUOQJzNJ56BZEk
         CMoexdy17OjMurrwSmd5wOZ0VrnHdenBE+ibtMQiAl+Naf+EzaBH85BqbquH324/1/Wg
         D11jj4rAjLWdYiHBJQdXEVn4iiwdeORBPQDVwNWjmMDviazqlmUXbQRUsaZCNoq3qRd2
         MmComP16aXKN3S29lvQS4fKgk7PPc3+D4BclRe0uMQWojLCnHxYeprtnTzEvvfAiKEsV
         THBcSI9QmKzB1b8EGWQpazsxGDre8weW2vOyBKYKKLt9/HzHWUFsvWdwjbh5nKZHwySy
         otog==
X-Forwarded-Encrypted: i=1; AJvYcCW/LDFct6cziZixym3Hcur+lKhTckUIlcEFz7d4Jm3y251nunf7B+2YYoHdxquvvf4An6DAC2LI@vger.kernel.org, AJvYcCX9WqpIaHCDGgRrXtGqZ/HQPm39RTpRu95PuDgyeLDAQVQ5Wh7wPzG/53v1OBHDBUagKtn+ShiYIoKEdfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBK4U03CqO1jL+tuEzvGF0Tl5ucxxu/CU88uaiF3Sx1o1XoTW
	JpGEIDW0s/3LlDADfkBWTcy5kIAJDDUPDZKAgDtleb6TH9xbLwTQkAFTQkYkwP7jJF2v9vktVUz
	ZlqS9yMZhO5v7mL4Vt4kmkhEzyZHk7w==
X-Google-Smtp-Source: AGHT+IETlDVRl8j8jbZqDqUvSIioAvhet305MNQITQRtCniCu61LWrGuZC6R67R9iHP+nA+QKCEStVE/J8zJyaAFQls=
X-Received: by 2002:a17:902:c406:b0:1fa:a9f5:64b1 with SMTP id
 d9443c01a7336-20367d0d354mr44078375ad.3.1724349357971; Thu, 22 Aug 2024
 10:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821042724.1391169-1-make24@iscas.ac.cn>
In-Reply-To: <20240821042724.1391169-1-make24@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Aug 2024 13:55:46 -0400
Message-ID: <CADnq5_Orq-RkKxOeG9UMnnJGodsB-9Tek0_NyYNP3EGaiEXpGQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/amd/display: avoid using null object of framebuffer
To: Ma Ke <make24@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, mwen@igalia.com, aurabindo.pillai@amd.com, 
	joshua@froggi.es, hamza.mahfooz@amd.com, marek.olsak@amd.com, 
	HaoPing.Liu@amd.com, akpm@linux-foundation.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Aug 21, 2024 at 3:45=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> Instead of using state->fb->obj[0] directly, get object from framebuffer
> by calling drm_gem_fb_get_obj() and return error code when object is
> null to avoid using null object of framebuffer.
>
> Cc: stable@vger.kernel.org
> Fixes: 5d945cbcd4b1 ("drm/amd/display: Create a file dedicated to planes"=
)
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index a83bd0331c3b..5cb11cc2d063 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -28,6 +28,7 @@
>  #include <drm/drm_blend.h>
>  #include <drm/drm_gem_atomic_helper.h>
>  #include <drm/drm_plane_helper.h>
> +#include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_fourcc.h>
>
>  #include "amdgpu.h"
> @@ -935,10 +936,14 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct=
 drm_plane *plane,
>         }
>
>         afb =3D to_amdgpu_framebuffer(new_state->fb);
> -       obj =3D new_state->fb->obj[0];
> +       obj =3D drm_gem_fb_get_obj(new_state->fb, 0);
> +       if (!obj) {
> +               DRM_ERROR("Failed to get obj from framebuffer\n");
> +               return -EINVAL;
> +       }
> +
>         rbo =3D gem_to_amdgpu_bo(obj);
>         adev =3D amdgpu_ttm_adev(rbo->tbo.bdev);
> -
>         r =3D amdgpu_bo_reserve(rbo, true);
>         if (r) {
>                 dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
> --
> 2.25.1
>

