Return-Path: <stable+bounces-135132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AE3A96D4D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BA33ACF7E
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408428152C;
	Tue, 22 Apr 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbfQi0Ty"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866F28368B;
	Tue, 22 Apr 2025 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745329575; cv=none; b=tdAKx26Vd540yz1pSyKkoVCRRNdI8/Y0WEdpA7GF0jnBknbsXdx7GTbCUEeibNHCHcqvu6as6c4reidxisB4ptDxQzHu1X1gKTOm74bX2yXllQCvrnp86Z3G+TW79tASk09EPExABLupbIsqy35wenR+X+rP5i6lUlPXzGLaQp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745329575; c=relaxed/simple;
	bh=gV6qsAJ1S6JKoBepICJyfGolkQc+4oYM8bEBJtZZCxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hga7ZiKA9Mj/Rksd8r3Pg4NUG1op+bLpVEAVqKvtGenfHRnZ3foYICmbPcYnSbBHG/AkuENN4e2ZPWjvieVt4w2Cm6gR6+4clUh/Cw/K49IF8FZqLME5yZQmngUJCWAwa0ZGPhOLkWFc0WnTUFVqUgB92m/tHiGovt1eDXsMcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbfQi0Ty; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so620912a91.1;
        Tue, 22 Apr 2025 06:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745329572; x=1745934372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKAXYEa6/VLh0NZkKTBiPYID8+vaPzcEPkeHsNwXQDg=;
        b=lbfQi0Ty03KFr3Osi3QHgqvQsJFtWRDBLwVhK0VfR3JNP4x0/VXb7FUfBtH0BuyfDF
         yo6rSX5t3qN6JPU8z94bUiERq1C7nQX6w1NtMu7nZlxGQ5OdETQerF0czlevA7f140ZV
         vdPBvbHUH0kKI0VDQslJSEKp6sc8Vb0yxVHhf+tZXklYKV0n9XrSSzc2wgKzPmGK2nQu
         ZJjSHgYxiiLB0itx+SI7ISWowFvQtrYEucjpM6gD37pksH7VZOPWH9Pkvj4bLycOIhKx
         eU0Z6P9Yn4CuB3npybfwfrnRqr3+DCy9V+lgwl4aygpIV56C/TA3jHuu5Tho0CqM9Lua
         gytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745329572; x=1745934372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKAXYEa6/VLh0NZkKTBiPYID8+vaPzcEPkeHsNwXQDg=;
        b=CiMntXR4hnWRgUx3+7Y4nQ/h4ylbFk8wALLI2sy6ezdmj+bfb5MjafknBZM0kCkc2x
         0jTk2ynG+EksiaPo+qQImCIMDP3y2GyUi63rvKX0AV3Hq9RByY/gucmdZSMPALlPvLuP
         pAGc8B0IDWAHyofq4cUtYwz4+EHUQG4xBKVeauIwsEopQYQX20S7YWQPyPAGOGo97zpM
         1fX18+t62fr7nhFVFRIbDxOOnk9VtXaUb7W9C6rA+xdhpPcSyAy3GjUkXECBYBrCkVWh
         gQ/wfPNXsBpsPcjcRmQCa2geu6ZjtuwSF1W5QNgcvel3cfpfWtd9mGtWvLLRwWGxBmO2
         Aipw==
X-Forwarded-Encrypted: i=1; AJvYcCUgDZlLh/EM3gqwTmMv6kBomfOfFvFpv6Y/qZXVtkuOx0VA8BkA7A9bGM2JvLZzkYsx9aTqHlU7SBo/gQw=@vger.kernel.org, AJvYcCX4jDOAEVHkH8BjqPoqDibPNDcnsHPhtyug6ZXtzV35bUyTyn3pBNxlCo0XXnTMca7TbbpU3fKx@vger.kernel.org
X-Gm-Message-State: AOJu0YxANgDNX2RjBYKLtkG740kVp/S25o1a2B+2lMeplLpbfetWwLSm
	+WH6TIdIlRDgdzhSVmYK3qGp/e82437DPqrF3uzICMEcQqkTTDhwHLEl5FYypOwN1c+hWl7SfjS
	JzheqItP27W/7+hmDCZCTCxqKJOY=
X-Gm-Gg: ASbGncvDfrudz6h7Bmdz2I9GTl/PgK92uRsIQ+In+vx2SIjLVDxGXX8nODMUdeMYIM0
	L/zr8yc/aAOr2PBVACYZN+P/EEN8Ko+Axft4gxwI4UsUdV7XCHOh9+CI+KmrHFZtWl14FlNQq15
	OR+2CdLmKXOFKuUvoMOafS0DsWl7WWQeA6
X-Google-Smtp-Source: AGHT+IECnr/zJ2E6MF2usCsrGfyxjTBBW7hk5J/2Up1103fbS/c9RJz2TNwlZsPntlffsfti9rw7Z0c8MEnIm+0fhCM=
X-Received: by 2002:a17:90b:1c83:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-3087bbc70efmr8381367a91.4.1745329572515; Tue, 22 Apr 2025
 06:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418083129.9739-1-arefev@swemel.ru> <PH7PR12MB56852EECD78C11BD15157AF383BB2@PH7PR12MB5685.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB56852EECD78C11BD15157AF383BB2@PH7PR12MB5685.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Apr 2025 09:46:00 -0400
X-Gm-Features: ATxdqUGU-CCMs4qZcsvRTip94orySY_8TgzWOPynOQ5mL61RjWPeZ4592c9uXKo
Message-ID: <CADnq5_NLEUZget2naQm9bYH1EsrvbhJCGd7yPN+=9Z_kKmUOCw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: check a user-provided number of BOs in list
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Denis Arefev <arefev@swemel.ru>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Chunming Zhou <david1.zhou@amd.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Tue, Apr 22, 2025 at 5:13=E2=80=AFAM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> ________________________________________
> Von: Denis Arefev <arefev@swemel.ru>
> Gesendet: Freitag, 18. April 2025 10:31
> An: Deucher, Alexander
> Cc: Koenig, Christian; David Airlie; Simona Vetter; Andrey Grodzovsky; Ch=
unming Zhou; amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org=
; linux-kernel@vger.kernel.org; lvc-project@linuxtesting.org; stable@vger.k=
ernel.org
> Betreff: [PATCH v2] drm/amdgpu: check a user-provided number of BOs in li=
st
>
> The user can set any value to the variable =E2=80=98bo_number=E2=80=99, v=
ia the ioctl
> command DRM_IOCTL_AMDGPU_BO_LIST. This will affect the arithmetic
> expression =E2=80=98in->bo_number * in->bo_info_size=E2=80=99, which is p=
rone to
> overflow. Add a valid value check.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 964d0fbf6301 ("drm/amdgpu: Allow to create BO lists in CS ioctl v3=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
> V1 -> V2:
> Set a reasonable limit 'USHRT_MAX' for 'bo_number' it as Christian K=C3=
=B6nig <christian.koenig@amd.com> suggested
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_bo_list.c
> index 702f6610d024..85f7ee1e085d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -189,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdg=
pu_bo_list_in *in,
>         struct drm_amdgpu_bo_list_entry *info;
>         int r;
>
> +       if (!in->bo_number || in->bo_number > USHRT_MAX)
> +               return -EINVAL;
> +
>         info =3D kvmalloc_array(in->bo_number, info_size, GFP_KERNEL);
>         if (!info)
>                 return -ENOMEM;
> --
> 2.43.0
>

