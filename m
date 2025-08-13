Return-Path: <stable+bounces-169386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4BB24A31
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 15:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 093A81A20BA7
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 13:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E272C0F93;
	Wed, 13 Aug 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl5AmeO1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB813C3CD
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090570; cv=none; b=dPFYv/AdzvOUBFzAVdWE1eLvaQZ8igDkktIkFazcEOlUOUc6ZDV0w/+3fnGaMyZdlW1MtTSpB9UdWMXq29IYhY+RinMt1xttEMzRWWgpdgu/V4kY5cJy6Qh4v1EmfWHqnypflIxZNNXx3E/0D0Tj7q+/s3GJCC71UFR2enyZo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090570; c=relaxed/simple;
	bh=uhABoiFzURMBdR3tQ+URjBdMInGGAc3A7v2fioIxllc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvxyuN+DLcCa1JY2Pyp5wbVpovr78fY6d55s30LBa3VgldPsR7f+Nm5p5C0n0tKtvAKY09Msz7H7wORg19UrxTAffCOit88dewzjE4C3K7ckevLpdCwHCVPw8rfHW99gd7yh3Z/SKEHWa22qYeo+ovvRc1gnjVWfmzzQyeGSkoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl5AmeO1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23ffa774f00so6716715ad.1
        for <stable@vger.kernel.org>; Wed, 13 Aug 2025 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090568; x=1755695368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuPKhstn/bjNwp0etjc4b5aGFH6uxoU5SzTyhORYv1Y=;
        b=Gl5AmeO1a1belWYIssdHWxkTcPCLqfDegzY4bB5B9SgJcen1qlfbE9hvl5aL374PuL
         0JcmiRk1yKNZVSdnv0K+lsoNJy8QtIwpimpC1THTlF3ivAxFyH0qjwIQze/eiUqfW7se
         neFlGLCkCHQkkufuaLzK8Nygc28bcxbgBldun6TwComQN5FGqxfLa4L3EdmGuyGxhbsU
         NZvrgKWC3Cw67FxRMUanhjewD+Pm7LTCIMawhiOZqVem5p/qBhSVVHDXhVRdy0ZNaj+P
         oa6BALD7o0hOvm7UZ27n58doJjYssO36o7dsfyQ2/TTcfuhfQUhLvk+ahZbXhBaBWIt/
         wBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090568; x=1755695368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuPKhstn/bjNwp0etjc4b5aGFH6uxoU5SzTyhORYv1Y=;
        b=lD68SoB8hP2kejKYL3dwcXewc1UcL07FqlBUPqC00+zNMbR3wMvi8RTVjT+exiFtDK
         Q6+viv9i2B6PlzmPMuQ3b+uUBn6a22rSLo98FLSOOiylU2RXvoH5HZQviQvGNCk4cqTw
         EC//AyO5xrP82JRoPw+zjSEaW98vyj9wt73Psyl/epk93ky0hjLdexO5pHfmm+RT6Lwz
         FVNAiNYBKwvkA8nyRorB45T49/ASgIvfkU3YzZtf+fIEz7oXl3cn5zp44DSjO5hAxjPs
         lecNXF1rcsCzgWHcpxMUWRXTgdRe7VKeol3IYu32/CJTSbnCmiDzLREzGc86qOK4GkGo
         aHqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTF/d3ZtRYSiwllluAsYSA/t1O2A2pJmEuKbgrB5nDx8SGZnUVkGzk2OUSIpXIWECRXS1he6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhg7jrAdV29CkFTHLffNfzZ5aGjqr6lg5ckeKmyIkpx4RcII3N
	awxv5Ta0/659oifg2sxnsHSLiHi9VAaJsWfL2D53s8sgdRjUf4hubOntjvsScbDOCp89v6g82dv
	I7C3bbOz311JXwiDU5QOOqbxyu3/fAso=
X-Gm-Gg: ASbGnctckbiD67D+bOzJZkyoshq9FByRWf7pEMq3EdsrKqArqo6d47JEzYz4ZAFgOYq
	Xhg68arDLFgaNDVNvtukzCGl8GiP5rcNPCbJDoaRrkd/JrC2vxCwx3fOZb7ceL6UUaGblYrEfke
	HZ/Dn2yJWQVklF7heFhgt2RRF/vXmaX3HOdgtlMyyNSQyqDxA3sZZnup3XmZQRqf+LeRaBmtNdR
	GnOMTA=
X-Google-Smtp-Source: AGHT+IHOEooZ2AOS8NtHgO/OzzoDvkw0oKvOMoX46wIcwfcdmsX+/s+TC1z8c5hTvbe4h9XggI7b87m1DgNnihswDJ8=
X-Received: by 2002:a17:902:c408:b0:240:3e72:ef98 with SMTP id
 d9443c01a7336-2430d2f5151mr22417675ad.10.1755090568031; Wed, 13 Aug 2025
 06:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808151517.1596616-1-alexander.deucher@amd.com>
In-Reply-To: <20250808151517.1596616-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Aug 2025 09:09:16 -0400
X-Gm-Features: Ac12FXyuqPURw1JAMGIy4NOxBc47f3CyqOjVyMxSUTMs7jMVtIWNRYFYsa1g1XM
Message-ID: <CADnq5_OozSsP_qXBPjgYR9-1cChsYTJtg-y8RPb2wA9Xn9dfoA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop hw access in non-DC audio fini
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
	oushixiong <oushixiong1025@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

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

