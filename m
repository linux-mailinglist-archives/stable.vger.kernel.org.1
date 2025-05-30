Return-Path: <stable+bounces-148331-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813DAAC96F7
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 23:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE3A1755C6
	for <lists+stable@lfdr.de>; Fri, 30 May 2025 21:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F2C22AE5D;
	Fri, 30 May 2025 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoS3Hrls"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4241D7E42;
	Fri, 30 May 2025 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639851; cv=none; b=gVGG8Y+99Dkd3pmfOszNsrBbq6mniPVym5pj+ePFfImuxgAQthg/UfvkL/ixoWCQh2GBUwYOTJOxJdLG6oM2xVd5lhZWgMUt4jzVjIkfn52rGJvt00xJ7iKDtbUzMCx58eoptsjvt6Nh0PQuRlqrwT7ZZBsiJgtjdnUz8LuB8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639851; c=relaxed/simple;
	bh=Q7wWYppq7C90E4b18X8pKHy206dMcrlyeJ0E5h2Rjgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3A8CGjWEDdgpWfubw6JSM5rhvJ/gVYca5Gz0J9u+TkmYsN+FCXLgmYEedafNA8qa7VM6r3b2lJlzaWBk2nDqu9MGiv5Zxgc+POMnPTbUCwyvMUyDU1CtAcSMYyV+v5RdXgf3lfKsqqOKyV7N2DrtcqhfCjU4SXwFYCXItpwSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoS3Hrls; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31271ed809dso37081a91.1;
        Fri, 30 May 2025 14:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748639848; x=1749244648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaflX9LJXzWlm3lpCgATG+sa4+dMghEczWFwcXZldgU=;
        b=DoS3HrlsUdl7dokKIzoBLweOIYgQFngmKqXsUnZqceQuxDxqkLAB0Cazo93uv8WQ9q
         DJLoZpHsbbT1Uq23vAEwWIa0tD+eEE70lS0d1jHtIGgDlxcceTK/JYRGghOK6L8LjU3E
         e6YIfZz/CcPND9D5SMKxz0UuUyUcNT78eQg6MtfuT/E+vJ2r/YmjLC14zLzp5Iq4ZBCy
         AMY2Ccg6VlobJVtJOX2soNfqMWNhe2oh7KegmRNZI+WCokFiAGR0xsXQKEQCh7ebY78p
         A8vGsdyFbWXcObYqsFmwMVixR2MHxRUO+myj4pzBrDnSjWdR+PVgDQ+kt3buj5tyxPIK
         6ixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748639848; x=1749244648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DaflX9LJXzWlm3lpCgATG+sa4+dMghEczWFwcXZldgU=;
        b=YUKKAOj2D5Lvf2bMM0UZMuqZ54wVkqkUYyxFR+bWgPyT7hTSX5zwv/v6fnrpQglUfF
         iGqivJuChqgTohajbyEXPYJdMOrabtRuM3uT1zxxJW6n3hTmdik0LakqbJb3M0o3IN6M
         YqAqfcyVQg/AAW1RC6VBA9N0RKdy5LYNYXyLe4DQAZbCpv0NqAwJyCdEeS0CRN46YoNz
         Wx0Qu/daMivGYTyiDreChvrKi+/s/524ltso2DIcTJFVXpSaYIlkpzixUq519EHpHfeS
         opMm54TeWFS2X3ttuWt/7QMzxk+yMkQk+DidHUSgDSRH7CnO+/7Vw5vz+6ffOvJqNxAR
         wwUw==
X-Forwarded-Encrypted: i=1; AJvYcCVEuihrg2zG1up1+XUiK50jX13Z0k704pMh8PI7OvvVbdNuZoUr8cjv0E5WdAU0xZJnMxHgpv5gRJ2qkK8=@vger.kernel.org, AJvYcCWLYLA2ePdj9hWbIQY87/lO6sY4EplzTA5irEvHdNcMeyaX6GtSKQ8JIqwnF59aoLxx2gKqw/FL@vger.kernel.org
X-Gm-Message-State: AOJu0YzujraAEI4yeMeDT141+UtFZzvk3OxgbMMhQ10Ulaqradlur8eD
	SPL7OrPNpqOqD+HIBTOt9ltVvPck4ljeC+lPHTuNcYpdVGB1UOscyAZQdH3c+twEmzBzpTzkyNr
	JZts8sPX/+ObiTcn7Me6hcLn+2rMcELw=
X-Gm-Gg: ASbGncvFkZF9epcz5tKvPvU513kAPlxl/I1xtFv0RSKLVuKm5MDkRPsUUyzv5OgXE2A
	BKOnMvx7Z2aMxaQ2N76BXfIvAHBKBDY9b1MYIJjnvCT4kvjM1qHmTbsAOAgv/+Kvb/r1uXGL6uA
	9oBkn9gSxnhkp72q28KlG/lRWQW/kd0CK5/w==
X-Google-Smtp-Source: AGHT+IECt7Rhv1kBz/qhY52yGtnM/bwE3kNoe3ZrT2BLx0pNDo8VmJvvCSgdO27lsl/S1qo5VpuNwDSQ6ibXFmHiPW8=
X-Received: by 2002:a17:90b:1a8f:b0:312:1dc9:9f5c with SMTP id
 98e67ed59e1d1-3124db0a69dmr2048172a91.4.1748639847971; Fri, 30 May 2025
 14:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524055546.1001268-1-sdl@nppct.ru>
In-Reply-To: <20250524055546.1001268-1-sdl@nppct.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 17:17:16 -0400
X-Gm-Features: AX0GCFtMHSWMn3a0e0OChFwtmZR4ehBBbTKc_CIkgLIbeEVdaBFk4XUBXRAPGEY
Message-ID: <CADnq5_MyV_C-XJCQEiXKLQhhEGErq7SnvhqFE1AauQPJvt5aYw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL dereference in gfx_v9_0_kcq() and kiq_init_queue()
To: Alexey Nepomnyashih <sdl@nppct.ru>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>, 
	Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>, 
	Yang Wang <kevinyang.wang@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 24, 2025 at 2:14=E2=80=AFAM Alexey Nepomnyashih <sdl@nppct.ru> =
wrote:
>
> A potential NULL pointer dereference may occur when accessing
> tmp_mqd->cp_hqd_pq_control without verifying that tmp_mqd is non-NULL.
> This may happen if mqd_backup[mqd_idx] is unexpectedly NULL.
>
> Although a NULL check for mqd_backup[mqd_idx] existed previously, it was
> moved to a position after the dereference in a recent commit, which
> renders it ineffective.

I don't think it's possible for mqd_backup to be NULL at this point.
We would have failed earlier in init if the mqd backup allocation
failed.

Alex

>
> Add an explicit NULL check for tmp_mqd before dereferencing its members.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Cc: stable@vger.kernel.org # v5.13+
> Fixes: a330b52a9e59 ("drm/amdgpu: Init the cp MQD if it's not be initiali=
zed before")
> Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index d7db4cb907ae..134cab16a00d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -3817,10 +3817,9 @@ static int gfx_v9_0_kiq_init_queue(struct amdgpu_r=
ing *ring)
>          * check mqd->cp_hqd_pq_control since this value should not be 0
>          */
>         tmp_mqd =3D (struct v9_mqd *)adev->gfx.kiq[0].mqd_backup;
> -       if (amdgpu_in_reset(adev) && tmp_mqd->cp_hqd_pq_control){
> +       if (amdgpu_in_reset(adev) && tmp_mqd && tmp_mqd->cp_hqd_pq_contro=
l) {
>                 /* for GPU_RESET case , reset MQD to a clean status */
> -               if (adev->gfx.kiq[0].mqd_backup)
> -                       memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(s=
truct v9_mqd_allocation));
> +               memcpy(mqd, adev->gfx.kiq[0].mqd_backup, sizeof(struct v9=
_mqd_allocation));
>
>                 /* reset ring buffer */
>                 ring->wptr =3D 0;
> @@ -3863,7 +3862,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ri=
ng *ring, bool restore)
>          */
>         tmp_mqd =3D (struct v9_mqd *)adev->gfx.mec.mqd_backup[mqd_idx];
>
> -       if (!restore && (!tmp_mqd->cp_hqd_pq_control ||
> +       if (!restore && tmp_mqd && (!tmp_mqd->cp_hqd_pq_control ||
>             (!amdgpu_in_reset(adev) && !adev->in_suspend))) {
>                 memset((void *)mqd, 0, sizeof(struct v9_mqd_allocation));
>                 ((struct v9_mqd_allocation *)mqd)->dynamic_cu_mask =3D 0x=
FFFFFFFF;
> @@ -3874,8 +3873,7 @@ static int gfx_v9_0_kcq_init_queue(struct amdgpu_ri=
ng *ring, bool restore)
>                 soc15_grbm_select(adev, 0, 0, 0, 0, 0);
>                 mutex_unlock(&adev->srbm_mutex);
>
> -               if (adev->gfx.mec.mqd_backup[mqd_idx])
> -                       memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, si=
zeof(struct v9_mqd_allocation));
> +               memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(str=
uct v9_mqd_allocation));
>         } else {
>                 /* restore MQD to a clean status */
>                 if (adev->gfx.mec.mqd_backup[mqd_idx])
> --
> 2.43.0
>

