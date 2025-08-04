Return-Path: <stable+bounces-166488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D50B1A44D
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 16:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16147AFA41
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 14:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27492701CC;
	Mon,  4 Aug 2025 14:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ0IbITs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042131DED4A
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 14:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754316985; cv=none; b=U+xhOUgtoK3RsoYRiUjCoL2prj7HKWibHUpTazHH+zi939AgwTzftAc7aLAw68uFKlbtVxOP7mtRZ2MTrAmlFEVx+HFyuR8+Slz3pIvCLzHwxSEirs6y2rWZytIpCEQqFUiU6GeifcGInegSU+HB3YnJGR6LGLq5P0uIXQ3oXaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754316985; c=relaxed/simple;
	bh=bofZFfKMz0IK9tlZKzv5le7rnJSvhGXYGjWsicjlkTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o9uXyT70VaNR0bAmFbZUM3CMQ6K7hoJbYq+gX1qa5/sKmtcrF2gDlyTHjpJ1Xk8dOnnOKLve7HkKpoO75YxAd3fzD+gU9AnVqyQClrFqyQT1wJgiXs7ZwejyxNkbE71C0yAl9CQA63kqAjEi/oda5lUriSIu7nzIDnlbwEQQ+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ0IbITs; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24050da1b9eso5218785ad.3
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 07:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754316983; x=1754921783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmvTMUm/ICs/ahFcRTrwKfKZlA+J5p75DnclZMp8JVE=;
        b=jZ0IbITsKtLyu81bmaM2IwE0hqHOlP9uHN8v6NIWo/D6/5cFKLjR5FUulJgkXLXQlq
         V9F6ujEuFN0y6gEWRhwNkc+j/4fRigQArglXXRvZLAuqToFemraLaCkdHPY9RHsiubq7
         mo3n917v60v6S68vgSZXRmlVwl+cukBPPYmCEzyJFn0Waqod5W0jIQ2JLZry6RUiNiT0
         uI7cNawQOjUGMFMQS8DsvY4ZTI4D6gYfNNRmHMlqf9orcCe1QHHPg8euzl5NYvCoB5a1
         v+Yg1kLaDT3U2t9099C7Biu1Jj8C5cFuIO6im+30A/wN61EfMF59cLQuwsG5mHK24+5l
         L3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754316983; x=1754921783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmvTMUm/ICs/ahFcRTrwKfKZlA+J5p75DnclZMp8JVE=;
        b=CjdWNcf/uT6dB/LZSLqw5ZBr7qIr3l3DgFNzpIf7GErn2e3NErRTrG7qXqJTiD6Ei/
         CvVP4gOEI0pT1NJVbzuzats0fk0k/JvjL6tdDAdsPPXYf4HyJaPmt9/B81iXu+dF+Arq
         sBt0yjrF42fXIuUliPDAcsgNBv+ZELIWhbAsx8e+g3zWAmYn6JjWn94BgG+wgZg6u7lQ
         k1o+gqVZ06/HOUR5eLaxhwln1m51kELITiFnDjh/0sRoFXYwPfgMlRt5gIkw90f8AAcH
         LjsCbOwnr8iX0UoiyuvSk3McMD1x8GCZS8PEmuqSOuU8HCbpGhzhHZSz7AuQr6cA49Cm
         u8Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWnWQrEMBNtMgoR1axT6ZcL+VP9933eIvOQ3mqANpZdNAMeUf4zl5M078i6chDIIPkpvpD8kNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS2pyCqBiKCqeL1Pjk7HiQbLS5fGeb4zDEQKaOhZ2R9nndeOhP
	6rkTUrLiQK4JA5Y0AFeIyU/k+KWhvDHVYg+RC+hxTcMmhjYvESbZhAmUG6x8ixqtnx9MjgQ8JaH
	ZwRTjC355qQCDhHLyC5b0NAhM900+U/Y=
X-Gm-Gg: ASbGnctrWLBCGs7UMawF4HNVhWd6GgU6tvJx8Ny7PHsWXgDhjbNenDmMbS6K7wCiaXo
	K4IuscbPDT8XX2vgMa+HVVpcLpSgxDRzojEt+FaYRi5yRh/3fjnh9ToaZcCW4QZdF0OfYVZTi2Z
	Ol+yXQpkfn5umJ5gjY39zaDopT1IToXfRz6yG+1S5oQJ9mSGdZZzL1D/x9zeANqOmxczuP6c332
	W0PMHgf
X-Google-Smtp-Source: AGHT+IEq9ico+45e/lWfZTSuRxPqOjzXQJMO2yAHWmdAa65USJLAotkgDCF+yqF+5AE4SZTACL6/e7N5WK72/jKfKNA=
X-Received: by 2002:a17:902:ef4e:b0:240:729c:a022 with SMTP id
 d9443c01a7336-24246fef45bmr57133095ad.11.1754316983052; Mon, 04 Aug 2025
 07:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730155900.22657-1-alexander.deucher@amd.com>
In-Reply-To: <20250730155900.22657-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 10:16:11 -0400
X-Gm-Features: Ac12FXwJy7sUb93YuMFGFJPMXM7DzaATuAsXfBApHodn4ZPc1FpuDIyjdvdjb4g
Message-ID: <CADnq5_NtBWyQozzv2wih6cp7Ado+nBf7hd_N+oGXsd0H_JadKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/discovery: fix fw based ip discovery
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping?

Alex

On Wed, Jul 30, 2025 at 12:18=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> We only need the fw based discovery table for sysfs.  No
> need to parse it.  Additionally parsing some of the board
> specific tables may result in incorrect data on some boards.
> just load the binary and don't parse it on those boards.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4441
> Fixes: 80a0e8282933 ("drm/amdgpu/discovery: optionally use fw based ip di=
scovery")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 72 ++++++++++---------
>  2 files changed, 41 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index efe98ffb679a4..b2538cff222ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2570,9 +2570,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct a=
mdgpu_device *adev)
>
>         adev->firmware.gpu_info_fw =3D NULL;
>
> -       if (adev->mman.discovery_bin)
> -               return 0;
> -
>         switch (adev->asic_type) {
>         default:
>                 return 0;
> @@ -2594,6 +2591,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct a=
mdgpu_device *adev)
>                 chip_name =3D "arcturus";
>                 break;
>         case CHIP_NAVI12:
> +               if (adev->mman.discovery_bin)
> +                       return 0;
>                 chip_name =3D "navi12";
>                 break;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 81b3443c8d7f4..27bd7659961e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2555,40 +2555,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_=
device *adev)
>
>         switch (adev->asic_type) {
>         case CHIP_VEGA10:
> -       case CHIP_VEGA12:
> -       case CHIP_RAVEN:
> -       case CHIP_VEGA20:
> -       case CHIP_ARCTURUS:
> -       case CHIP_ALDEBARAN:
> -               /* this is not fatal.  We have a fallback below
> -                * if the new firmwares are not present. some of
> -                * this will be overridden below to keep things
> -                * consistent with the current behavior.
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
>                  */
> -               r =3D amdgpu_discovery_reg_base_init(adev);
> -               if (!r) {
> -                       amdgpu_discovery_harvest_ip(adev);
> -                       amdgpu_discovery_get_gfx_info(adev);
> -                       amdgpu_discovery_get_mall_info(adev);
> -                       amdgpu_discovery_get_vcn_info(adev);
> -               }
> -               break;
> -       default:
> -               r =3D amdgpu_discovery_reg_base_init(adev);
> -               if (r) {
> -                       drm_err(&adev->ddev, "discovery failed: %d\n", r)=
;
> -                       return r;
> -               }
> -
> -               amdgpu_discovery_harvest_ip(adev);
> -               amdgpu_discovery_get_gfx_info(adev);
> -               amdgpu_discovery_get_mall_info(adev);
> -               amdgpu_discovery_get_vcn_info(adev);
> -               break;
> -       }
> -
> -       switch (adev->asic_type) {
> -       case CHIP_VEGA10:
> +               amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
>                 adev->gmc.num_umc =3D 4;
> @@ -2611,6 +2582,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 0, 0);
>                 break;
>         case CHIP_VEGA12:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
>                 adev->gmc.num_umc =3D 4;
> @@ -2633,6 +2609,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 0, 1);
>                 break;
>         case CHIP_RAVEN:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 vega10_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 1;
>                 adev->vcn.num_vcn_inst =3D 1;
> @@ -2674,6 +2655,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 }
>                 break;
>         case CHIP_VEGA20:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 vega20_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 2;
>                 adev->gmc.num_umc =3D 8;
> @@ -2697,6 +2683,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[DCI_HWIP][0] =3D IP_VERSION(12, 1, 0);
>                 break;
>         case CHIP_ARCTURUS:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 arct_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 8;
>                 adev->vcn.num_vcn_inst =3D 2;
> @@ -2725,6 +2716,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[UVD_HWIP][1] =3D IP_VERSION(2, 5, 0);
>                 break;
>         case CHIP_ALDEBARAN:
> +               /* This is not fatal.  We only need the discovery
> +                * binary for sysfs.  We don't need it for a
> +                * functional system.
> +                */
> +               amdgpu_discovery_init(adev);
>                 aldebaran_reg_base_init(adev);
>                 adev->sdma.num_instances =3D 5;
>                 adev->vcn.num_vcn_inst =3D 2;
> @@ -2751,6 +2747,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_d=
evice *adev)
>                 adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 1, 0);
>                 break;
>         default:
> +               r =3D amdgpu_discovery_reg_base_init(adev);
> +               if (r) {
> +                       drm_err(&adev->ddev, "discovery failed: %d\n", r)=
;
> +                       return r;
> +               }
> +
> +               amdgpu_discovery_harvest_ip(adev);
> +               amdgpu_discovery_get_gfx_info(adev);
> +               amdgpu_discovery_get_mall_info(adev);
> +               amdgpu_discovery_get_vcn_info(adev);
>                 break;
>         }
>
> --
> 2.50.1
>

