Return-Path: <stable+bounces-141835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6A6AAC910
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DDC3AE675
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC392836B4;
	Tue,  6 May 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7GThirX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443F283159;
	Tue,  6 May 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543929; cv=none; b=cyML9uiZ7w8ezZfPLZsRVKMjgCYNv179BBTEVkUPBMVKa4mfYccMpYOIaKA/1PMza2lRNpn2pNZeLj+THaLcCCDq7ouKEIyOuaYEXSI7eq3kbOD9sQ+wTqdh+j5FfxbFna34IUvEFtNbW1tEtsuTwemVYN63EXzTXBOrp5XEBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543929; c=relaxed/simple;
	bh=G1yN7+TmYcBkLlBIx5pZRb5OPvqsoA6dTX5RPWwJXJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=in+VEsJH8ObySkwIpMwOkAqT14X7z/LlBalwp5FhLIVqoSWmtWDlgtJTfjnuuQzvLGWj2QOSUk0hX5Gl9UkfuprEJeITzNfmhLsW2778nt6678hEIIjgPyZUE44tiVpvz9g+q6EGT6rLZeElr/6Vj92SA3Kf29HhNI6mZ2VGAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7GThirX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e1782cbb2so4866435ad.0;
        Tue, 06 May 2025 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746543927; x=1747148727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeYlbEYEwavza4UvF1lXEEZ0JxcIrbgVsspOdX27P4g=;
        b=Z7GThirXPFER+IQo8q5CyK53oPDzFQ6ddu5cCR4feoi/yRWRrXP/cUBupWOu4Vi0yx
         vgp9gHH2+icpsXG1j/ThaXENBeTGkYEMePsQzGHJcurRV8X9hvrT+bbWGJwcsMqf8Wpo
         oDuqWNqt9FLiOOrF8ISBHgsIxAvUORNVSWvn3P13Ffa46VJluWYCacDFaOnTQb9SVBwT
         n9VtSwOsupySi7521w6FlUDm128cTn7HhzPpduN2OvLJPHQ+vV9uyafoQnlga47KhBKy
         emRkyzkFyowzlC8yAHoDWO5FgfOI66Lj1gbj78NxEtMVeGVSCtzSEgrWitsJMq6gUfoM
         gAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543927; x=1747148727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeYlbEYEwavza4UvF1lXEEZ0JxcIrbgVsspOdX27P4g=;
        b=gmjSIBIipdwG+DK6b6MeNusU28LSBvSXpQDyKxxhgxkGzUj2h3u2xyePzZrDxElT+v
         tRpifxOleSOKtNeEG+3+5sJ6Tn8ArPP08pE8W4Lc4i6P6nOXe/Rln7oFelWCo1+KI9c2
         5HsUziNmWK+0wIGykax5951TIP7fnyy9dk27khPkm58nFDFoUYthNt1xyuBC+RhuHonP
         jJoo0ZOkfvjarS7DvNy7xiItzyuMK0GXX1hRlfm1U4YVG9UHlh7Y2WvDVaqHjs87XHkh
         ilnPrefGE+hdu+bHGD7M1SEG3wZLc7JO6MvnQNom18+pksDrDG5ib9xUjHlfpRGZ6aO3
         dETg==
X-Forwarded-Encrypted: i=1; AJvYcCXpjtlWr5ylb1tNT49IXhecR6N/tJqCY+Az95oAV82Ksc9/Mv1jwaRZcswlb6krHBIP1DDRJVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEjTrVHconPndsOBaAI+0vqqKGwvv3RV/qyc6lzZFptZAzXW4
	i2BRHq6Ztio2xnWXYNedbA63ozy4YsXaeNNgdcnq1IX+bm3FBdkQtTRBy7KskOTSRbCPImI/sv5
	iqQj84Cf1S+HPUuGlpP3kyQsFhW0=
X-Gm-Gg: ASbGncvC2MTjQUqT4QJoEdiiFfUsazo8V34wZt8Kuw5aKMz1EHPNVEpnOCergv6ThHf
	v9/orKlyz2ZV4BAtwHZ1gmSRSVdK6W+FRqFfewItomaaiHcyLiQxfuJ3sMG+0dfh9rCpH3zGBMd
	6o1xg9JwfI27znnVpDSLzowA==
X-Google-Smtp-Source: AGHT+IGoR/1KNKu8t6FhcfkvG15adjneHBLuPet1jUD8RK6gXmMHJVwSbb0sxCBa3iS20c2BjnGa1dBq89e+BFUlqs0=
X-Received: by 2002:a17:902:e552:b0:223:5124:ee7f with SMTP id
 d9443c01a7336-22e103876aemr96861115ad.12.1746543927415; Tue, 06 May 2025
 08:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-248-sashal@kernel.org>
In-Reply-To: <20250505221419.2672473-248-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 11:05:15 -0400
X-Gm-Features: ATxdqUG9foOxWfXm1xZFyjnjBCiu9l7qR46nlmJ4liwGbAsOLlF1aF7W238Y4Mg
Message-ID: <CADnq5_MfAFmbLeg+PAtWaFvY1G29ApTmMKwFq7etT35NvQWXHw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 248/642] drm/amdgpu: add dce_v6_0_soft_reset()
 to DCE6
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alexandre Demers <alexandre.f.demers@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	sunil.khatri@amd.com, boyuan.zhang@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 6:24=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Alexandre Demers <alexandre.f.demers@gmail.com>
>
> [ Upstream commit ab23db6d08efdda5d13d01a66c593d0e57f8917f ]
>
> DCE6 was missing soft reset, but it was easily identifiable under radeon.
> This should be it, pretty much as it is done under DCE8 and DCE10.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is not stable material.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 53 ++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 915804a6a1d7d..ed5e06b677df1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -370,13 +370,41 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_=
device *adev)
>         return mmDC_GPIO_HPD_A;
>  }
>
> +static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
> +{
> +       u32 crtc_hung =3D 0;
> +       u32 crtc_status[6];
> +       u32 i, j, tmp;
> +
> +       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> +               if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTR=
OL__CRTC_MASTER_EN_MASK) {
> +                       crtc_status[i] =3D RREG32(mmCRTC_STATUS_HV_COUNT =
+ crtc_offsets[i]);
> +                       crtc_hung |=3D (1 << i);
> +               }
> +       }
> +
> +       for (j =3D 0; j < 10; j++) {
> +               for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> +                       if (crtc_hung & (1 << i)) {
> +                               tmp =3D RREG32(mmCRTC_STATUS_HV_COUNT + c=
rtc_offsets[i]);
> +                               if (tmp !=3D crtc_status[i])
> +                                       crtc_hung &=3D ~(1 << i);
> +                       }
> +               }
> +               if (crtc_hung =3D=3D 0)
> +                       return false;
> +               udelay(100);
> +       }
> +
> +       return true;
> +}
> +
>  static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
>                                           bool render)
>  {
>         if (!render)
>                 WREG32(mmVGA_RENDER_CONTROL,
>                         RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CNTL);
> -
>  }
>
>  static int dce_v6_0_get_num_crtc(struct amdgpu_device *adev)
> @@ -2872,7 +2900,28 @@ static bool dce_v6_0_is_idle(void *handle)
>
>  static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  {
> -       DRM_INFO("xxxx: dce_v6_0_soft_reset --- no impl!!\n");
> +       u32 srbm_soft_reset =3D 0, tmp;
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +
> +       if (dce_v6_0_is_display_hung(adev))
> +               srbm_soft_reset |=3D SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
> +
> +       if (srbm_soft_reset) {
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +               tmp |=3D srbm_soft_reset;
> +               dev_info(adev->dev, "SRBM_SOFT_RESET=3D0x%08X\n", tmp);
> +               WREG32(mmSRBM_SOFT_RESET, tmp);
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +
> +               udelay(50);
> +
> +               tmp &=3D ~srbm_soft_reset;
> +               WREG32(mmSRBM_SOFT_RESET, tmp);
> +               tmp =3D RREG32(mmSRBM_SOFT_RESET);
> +
> +               /* Wait a little for things to settle down */
> +               udelay(50);
> +       }
>         return 0;
>  }
>
> --
> 2.39.5
>

