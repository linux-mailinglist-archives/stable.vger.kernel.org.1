Return-Path: <stable+bounces-176396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF5B37067
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 18:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9277C83CC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFB34DCFE;
	Tue, 26 Aug 2025 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZUmUidr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9FE3164DB
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225928; cv=none; b=nMyjXmIu6TowGBfLVlT8xsPEPX3b7qA4p1Ns/WawPjPq7QzpUXvPFBO8NNVIY66PEbFjdvat2lRSgqmmcuuf3e0bsaXOUk97Xzy0SkudePmgyjvj5nUhxUCHW5lTMVTtchAfIQ+uxIzs22iPGfoebn8VMNWYbAGhtV1FBI51KeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225928; c=relaxed/simple;
	bh=FUpSUFw6fO2ITfybdwjfny+I+SBlOz8l7RVSe6xNbXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QKtRVsywIiiOzNEKs6EnpthDT723jLBxWwMtr2KSvS6iUr8b669sDE45hiZu6TuDoUm9BiGAbxHXuaeBdtOVZW/28xZTi83j9LNRd01gIfMJwIfe8ubENUGXsUaUqHiRDFcAdRxG2L4yu62pIILG8XFuflcDiT10y2+AZi6WuCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZUmUidr; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b49d7a11c0aso539707a12.0
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756225926; x=1756830726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHSDypqHOOk6osgXzA+8WxKPxKWGxAytI2s6DahvMQ0=;
        b=HZUmUidrxmQtTks8209gOmompW1ODn0oqa4IiN3qmGRrOuyRRr80N5UuTShqXjjLE3
         p33FDg7/Our5AWJQMJK2v/hJx99lYzj5WXYofauL9w75JWN/iV7nZkJO8Dpls2TLerMx
         ZrngUBSwSPdZd/3YuhsoGL4WmGPBoWPlcuW2ZkmOrehaGQ2Panfz4H/AVyHD1XVo9kVq
         uS2ZbQx3rS3oX2h1Ydd9G8gceox/empIhW86pe715sVnGveWklVncw8QEw0iHwuPfDlK
         in6/Jd9SD2aNA3tGl2+NvNZE5mgeJ0uzmCvMv7LsJqad6ULj7DNXuVeOS5IM0EUuufYS
         YTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756225926; x=1756830726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHSDypqHOOk6osgXzA+8WxKPxKWGxAytI2s6DahvMQ0=;
        b=BC7ml+4imU+bAzNot4y4mXbq+O62+2uIUszTpM14GBZJIsiXkk08ekNSCPom7r/65d
         XLZiHxfEl2hfirGHwNmGSX1wbEYTygYM+BD846d1P/Q7mVQtw8KeAFIkTkfnExE+p1N2
         dqhUJmco+Y7h1K3GRNLcaiHYyGZsUwq1nVI1USVjgdEiGilauf84VTuB8S73BC+et8xL
         moFJZPGCTv2XPbZCz/xEvr0Ab/31KxZD/dNOLaBFKDe44//dM9Lhb+IrpVaEe+yS5Qjp
         m5PPqKaTQFsl0PJF1M9LUo2Ti/PmTavFv8WyubUjAxjeTyKFwGDN/63S2GlDJGjKiPpA
         KfJg==
X-Forwarded-Encrypted: i=1; AJvYcCWvbgw6tlnt3CLOYYGIu35vpM6mDghmNU9ejuDhZexcUvnXuaCg1CUhIssK5qOGM5YPi5Sk7Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY968XEwimD5nzDXzswwCAHzl4R7FDRzfdGZRUcVFkx+vc82qK
	6xf0tg6DBEpBeB0UyUukDkk2yWbcLVv1l2AA6keCWZjoL03AMKEYJ1DbYtY5gAkvu8N1wB20jGe
	4jBozDc6l5Es8mOSmmeMnov87uoySClgVow==
X-Gm-Gg: ASbGncuPcvcC+hTnVSb7KtxxJO0vTmAndCYa78E/adccdOT4pL1WQP4sRR2j465jfAh
	eOZlOqC+RTXZlywlmM+eT+JXjLfM5WRVH0AXrzuMTjg/MD8UYhmRy3pSUN5sTVLgM7PtjzYe7uX
	bpCjjokNzB3alowN+ZgQvuttDrFzjN+IfLzLPV/dCXXkI6QPvjFMruQy1PP+FX4LmT6spH4u3ex
	qlCPGo=
X-Google-Smtp-Source: AGHT+IEwIVXL4cP/21KjY3fa8n5tTQJGioOD3i1gbfi5T/iCcbNNr8lbNqtY5nd3xDUD9XzpX0EFInpr6SiO90xMbGs=
X-Received: by 2002:a17:90b:4b0f:b0:325:8f8c:4e13 with SMTP id
 98e67ed59e1d1-3258f8c503cmr6203380a91.2.1756225926186; Tue, 26 Aug 2025
 09:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808151517.1596616-1-alexander.deucher@amd.com>
In-Reply-To: <20250808151517.1596616-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 12:31:54 -0400
X-Gm-Features: Ac12FXzaPTqWyhS_lK7IZdRsLFg3Tx236cSDKlNP6zTb32rf63B565jLFoSGzyc
Message-ID: <CADnq5_Mx8uEPttTvpuMhDQNMysR1+zi2P+LnRbrmESakFG1Bqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop hw access in non-DC audio fini
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
	oushixiong <oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping?

On Fri, Aug 8, 2025 at 11:23=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> We already disable the audio pins in hw_fini so
> there is no need to do it again in sw_fini.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4481
> Cc: stable@vger.kernel.org
> Cc: oushixiong <oushixiong1025@163.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 5 -----
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 5 -----
>  4 files changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index bf7c22f81cda3..ba73518f5cdf3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -1462,17 +1462,12 @@ static int dce_v10_0_audio_init(struct amdgpu_dev=
ice *adev)
>
>  static void dce_v10_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v10_0_audio_enable(adev, &adev->mode_info.audio.pin[i=
], false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v11_0.c
> index 47e05783c4a0e..b01d88d078fa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -1511,17 +1511,12 @@ static int dce_v11_0_audio_init(struct amdgpu_dev=
ice *adev)
>
>  static void dce_v11_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v11_0_audio_enable(adev, &adev->mode_info.audio.pin[i=
], false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 276c025c4c03d..81760a26f2ffc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1451,17 +1451,12 @@ static int dce_v6_0_audio_init(struct amdgpu_devi=
ce *adev)
>
>  static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i]=
, false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index e62ccf9eb73de..19a265bd4d196 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -1443,17 +1443,12 @@ static int dce_v8_0_audio_init(struct amdgpu_devi=
ce *adev)
>
>  static void dce_v8_0_audio_fini(struct amdgpu_device *adev)
>  {
> -       int i;
> -
>         if (!amdgpu_audio)
>                 return;
>
>         if (!adev->mode_info.audio.enabled)
>                 return;
>
> -       for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> -               dce_v8_0_audio_enable(adev, &adev->mode_info.audio.pin[i]=
, false);
> -
>         adev->mode_info.audio.enabled =3D false;
>  }
>
> --
> 2.50.1
>

