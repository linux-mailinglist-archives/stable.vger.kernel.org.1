Return-Path: <stable+bounces-141834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32984AAC90B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC36468C52
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823BC281371;
	Tue,  6 May 2025 15:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dG5wQ8c/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B9198A08;
	Tue,  6 May 2025 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543870; cv=none; b=p44dAW5U45RDVOCKjqwbLLdCQ/yKCqAoQpErVyIodMQo+1nmqzov4ire34kCtITn8h12hhpZz392kPB86umMibq7YKPbDxGxWgILfCw+0NN5Q6f7uxy32x0Dl1l4jcfKXwKAt1Qd0zlSfaYAx9QGTseosvDhPE9B8w8i57fDrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543870; c=relaxed/simple;
	bh=ybjMWZBXLO90PK7pN8yjtr5+qIPMuXs9hipLkKd1VqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9WaUoyHSIgoNUqWLr8jdRb04PTd/2UNTgDdocy3JFFKRqyJx0q83qqBN0ASVC59P3g9kLhkylPze4zXbjlLX98ZRnQf91u1oabYr1+V2zgLUWuerFl8nfI9Ib1NDekExPWKyoVps2wyXbhH6iaQJIAZm0WqeN9z+ImvseIvHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dG5wQ8c/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3087a70557bso665097a91.2;
        Tue, 06 May 2025 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746543868; x=1747148668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4N5L0OBe3ScafzL36/5ps8MdmhuELISisHME8PJ2jE=;
        b=dG5wQ8c/eCKgAtnfQNv6cmDo2RfnYzZw6vvR8+ESGDZ4Q0dIYh1/2sUvAsfuuVOKgZ
         3nHslAzEwf5d90RbwBDEDFIM6TFHloGq2c4h91577lGZ6bUlO0GKgL8hEhcpOUdAuyM7
         h/ppM0u3f1uKFRoFIIUo6WSS38trd5+PPqhR+phpmwsA6WjJKG3HvY+zAStBls/sEl6I
         1bKqRoXnigKfp5WFZZjhHQ2vYoK64Oqt/iEMoEfB2T+b+lZxv70SvqKIKlSZM/L+hcJo
         SLgOn3jCywhVVLCDnAOAzt7noRYZ4lgkSQmL4K3rnri6Um0GD6cZeBHztErygpH8ii0x
         gj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543868; x=1747148668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4N5L0OBe3ScafzL36/5ps8MdmhuELISisHME8PJ2jE=;
        b=h6mZ8O1ZGieQ59l+iYqor0UYwSFTD7gw0bENE0XrVVS5EgRhOFM/8z6tRB4y7OZ0ww
         MFK6kK1XaNPeBp0AQGi9Xk11c1kY5ji3bCe/Gu6nLdP2a1vEqvNmnCWLvX1Jjt1uLjlI
         vaZLS450DR+cTFN1YgZrAk2JtvRocHUPJkHIw+xHaBDff0dL4Uv9j27u4Yh9KCBQ6QOH
         jMkPYSfqeC213H9lOqtvnJmk8iHvk5UU+t3nHYqQxR8s6x1PrLvUpTOLiktYXVkzbxtc
         Fu3ZfYC8XVCWBaAF/nZHnGw7XRRsAsx3hGnokSi9nICDYC3pCfkwoSjBjmGf5NvCCUky
         OVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhLkwW367iCp0zWXMzrvAQD45ZH8/KxHYORaiJ2rVJPTqH7H3iZjYzTOPG1rNm6Gqgf21liX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZfP6QziYPGFhfdxkYnEmcLi0Uuu66Vn5QZHXRco4Hbbu1+wl
	sZ2ERF/r4EDnbfRY0tR/tdJJ7VZ27n+fIkdyGphoCo3VNqJ73BC+LAPfbG6E1xwxKCZyTIhnYuh
	f0ZF8HBJ0Uy6sZxg/fVPpiuv1UfgOMw==
X-Gm-Gg: ASbGnctj+PrWjC5ZvZehdQym92v7kPf43AC1DoJeIL9HuC8Uk3DAMjdMCiQenWh55gY
	Q0XS6929yR4Z0dZNqMgv4W7bZ909dgWJxW7JHUXt5npBXcW5FNhU0iktH9Y6k98/zrvo3BuyDNd
	ZdsDI1L9S/qsuYaUFkI3UpqA==
X-Google-Smtp-Source: AGHT+IEwhGFD8IpYiUNhIRLVGumkHh+0GyHsr9sLU3ivDsfBTh2hkFmQUsf7kNoEKGjP7WIXJpifuA65WP3UfME/oGg=
X-Received: by 2002:a17:90a:2c83:b0:30a:9935:bea8 with SMTP id
 98e67ed59e1d1-30a9935c11fmr469594a91.8.1746543867772; Tue, 06 May 2025
 08:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505223922.2682012-1-sashal@kernel.org> <20250505223922.2682012-376-sashal@kernel.org>
In-Reply-To: <20250505223922.2682012-376-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 11:04:16 -0400
X-Gm-Features: ATxdqUH3rURebALiwxQAtHGTZB9JcLWKbXWjGIu3U-Z3H9ymj5qHKILAnoy8wd0
Message-ID: <CADnq5_PTVy-gTr=xWnTULQfUsBYY9WbyL1yZ45ew+OPHpO8xdA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.12 376/486] drm/amd/display/dc: enable oem i2c
 support for DCE 12.x
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	roman.li@amd.com, srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 6:53=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> [ Upstream commit 2ed83f2cc41e8f7ced1c0610ec2b0821c5522ed5 ]
>
> Use the value pulled from the vbios just like newer chips.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is not a bug fix.  It's only applicable as part of a new feature
that was added in 6.15.

Alex

> ---
>  .../dc/resource/dce120/dce120_resource.c        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> index 621825a51f46e..a2ab6776b8855 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> @@ -67,6 +67,7 @@
>  #include "reg_helper.h"
>
>  #include "dce100/dce100_resource.h"
> +#include "link.h"
>
>  #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
>         #define mmDP0_DP_DPHY_INTERNAL_CTRL             0x210f
> @@ -659,6 +660,12 @@ static void dce120_resource_destruct(struct dce110_r=
esource_pool *pool)
>
>         if (pool->base.dmcu !=3D NULL)
>                 dce_dmcu_destroy(&pool->base.dmcu);
> +
> +       if (pool->base.oem_device !=3D NULL) {
> +               struct dc *dc =3D pool->base.oem_device->ctx->dc;
> +
> +               dc->link_srv->destroy_ddc_service(&pool->base.oem_device)=
;
> +       }
>  }
>
>  static void read_dce_straps(
> @@ -1054,6 +1061,7 @@ static bool dce120_resource_construct(
>         struct dc *dc,
>         struct dce110_resource_pool *pool)
>  {
> +       struct ddc_service_init_data ddc_init_data =3D {0};
>         unsigned int i;
>         int j;
>         struct dc_context *ctx =3D dc->ctx;
> @@ -1257,6 +1265,15 @@ static bool dce120_resource_construct(
>
>         bw_calcs_data_update_from_pplib(dc);
>
> +       if (dc->ctx->dc_bios->fw_info.oem_i2c_present) {
> +               ddc_init_data.ctx =3D dc->ctx;
> +               ddc_init_data.link =3D NULL;
> +               ddc_init_data.id.id =3D dc->ctx->dc_bios->fw_info.oem_i2c=
_obj_id;
> +               ddc_init_data.id.enum_id =3D 0;
> +               ddc_init_data.id.type =3D OBJECT_TYPE_GENERIC;
> +               pool->base.oem_device =3D dc->link_srv->create_ddc_servic=
e(&ddc_init_data);
> +       }
> +
>         return true;
>
>  irqs_create_fail:
> --
> 2.39.5
>

