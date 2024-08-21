Return-Path: <stable+bounces-69849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A395A5C5
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 22:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6778228467B
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64E816F830;
	Wed, 21 Aug 2024 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxaejHwS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BEA16F27F;
	Wed, 21 Aug 2024 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271744; cv=none; b=MlOQsEAKvVj5SAeIQ1u1sV3DAg/WG1pd+T0N74TEz5xsPdUvDw0Ni9o/rzZnf6uX5B5ekcTrCEQ3CaULWm9h9m7UpPPAxSwMEwIwI5MIDSlbKVdXx9vYth/9CsBjddQ1LjTMn8evkKZdf/P8Q4/5Q8lZDxbpG/nVHf/E5yhljmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271744; c=relaxed/simple;
	bh=TmkMF4BIKw0FSxRDCBPfYAw4QZSrEQuOOk+4ETbiN2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftwFcL6Kvso5NsYLR7ZVV8Kq1DRjDgGkK5ilS9w7xrErnvvw+kQapImCyuhlvueqGohlRFx2HGRoMATnMyUU3Ui0uS+57HGOYUWgjDM2mB/SO+pa7h9idT6Qh+BcUSTrz1DyyWsJceXnvaMEitgHCjpynBikp12PGRpxGgVDl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxaejHwS; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3d4862712so4577a91.2;
        Wed, 21 Aug 2024 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724271742; x=1724876542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4N/0smalG5TPn1izfalz/IyqY1wsey3JgqZf+z0B8E=;
        b=fxaejHwSO4D+TCHlheiCdpswEqY0EnERV0Gyib8K7uWG/0mojNXlT1BukVk0U/CAWG
         LRPkd1lS7SQKiH5n0qvBVVTLbtHVLALLuoUTclHA8rsDIVQ4TYLFDOZd+i7oMTYEeVB7
         7ize9uVsyL702SYa3YYM7sjpnZWts8JkLEHEM7k/keLQB9MrVwVZjUPo2wemhCcLhzRx
         izMjerTgIIFmLaAx0Qq9Us+8EaBRQLB6XO8lVSs/dl6ukcaZiNlR2Kcs8ZZ6UiRPyMP4
         234aMxH6yCrXusEg60iMarMREwL5rm18L5GWLh+SUeRC4Jq3mi67sQ/L3CrIvnHUMU8M
         jmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724271742; x=1724876542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4N/0smalG5TPn1izfalz/IyqY1wsey3JgqZf+z0B8E=;
        b=RxcRw3n5vp3lZfQj2QFJB9oY9poGFaH9BM3scZtxjVGr1yY3bpw0RQlX/C88x+YjWx
         HLUnBVUT4LGiyqL7Q121BuwSUoBUU/A2u9hgdPtMXq4/BHGmqSrcWyPI5cdbe6l6KV7y
         OJkWkCKxMmFJjjDpwsev7OasH9gOnMv1GdZXX5PWn641/PBru1hfjbyDql8H9pFklVE8
         GmGNH/Lto0kTfy/cMqgfx+BWvzEuBzPf9fUrSGSOp+zNYD9jcelgGBunJbICwTD3nM95
         NSQpWmgXNtIiuvFSeUhe5+BeiUsEU2WShldxkV6TCSsSq55IUBNG5gXf8+5u3QU1xAKH
         dGvg==
X-Forwarded-Encrypted: i=1; AJvYcCU4pUPsAvgyQQNRzuvKkDUQ9kWuDv2InhNbRYqSttGcsQsc0FVvPjQMoj1FT9Uq9qU/6WyJ6HhN@vger.kernel.org, AJvYcCUMFPxM0MMXCCN21MVPQ5UpG/bJgB5N4rRRoDXPn9OwZ5vHnJJ+TTNPK5JziZCwyeOHvqs0nS37bCsynEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6m8uNaJhwx4MuRXu3mi+hKhGI/agqL4XrEKVOUJsnzDheTrGn
	mzXr2x3QY9JL1ncJIC7SyyJAlQWVe9dgt98Ndx6v5CwlBckhZ4JVyHlW0eNvHjCI1xzJj5/j5Wu
	0pSJyfUzTbvlLuFiE1j8MKfaiVM8=
X-Google-Smtp-Source: AGHT+IGp6zlTSzpJYGatswz8fjy7/F9DjWBDw37uYGLUIWLeRFH6TaaSw5b4r+XPPtBbtx14A9e4Nji6NABBydevvmo=
X-Received: by 2002:a17:90b:50c8:b0:2c9:863c:604 with SMTP id
 98e67ed59e1d1-2d5e9ece4admr2241412a91.3.1724271742315; Wed, 21 Aug 2024
 13:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821042724.1391169-1-make24@iscas.ac.cn>
In-Reply-To: <20240821042724.1391169-1-make24@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Aug 2024 16:22:10 -0400
Message-ID: <CADnq5_OzY97etD0LW5Tw-xCnnTYonGkvxA875xdAfMgxAtu_DQ@mail.gmail.com>
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

Is it possible for obj to be NULL here?

Alex

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

