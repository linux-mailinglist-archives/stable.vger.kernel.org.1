Return-Path: <stable+bounces-141833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D5AAAC902
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8673BFA67
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748C9281371;
	Tue,  6 May 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkMKdryy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BF198A08;
	Tue,  6 May 2025 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543769; cv=none; b=qff8TIyRzHBMGKk6uPHogbddKeC1a1Y2dgEDqTFk8aYuxg/aZSowUuPt2ZVPYeIaTLLcRnthvHe6K7l6UGTe+uSzSfmPFB0SLYo4pgW6iXx2L3gmv4VwYjzPsRdvg1aZz0hX8VSJIjjciNfSkff4ds9MDFI2FJr6gRdv4dM85Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543769; c=relaxed/simple;
	bh=7fFdtbhbZqq5N3nhzSrL0p7KfiHwtvJg7z8E5CUmoa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=splSFWsrwVevO7rDNEQgn0XsyOtdu1a2+1xfzWS/WNjUMUYYHbTWtoIUzBYtB6V94JpVWLQ9zavPNkXgXZE8wnrnSJwoVVICQ5AB5GNPlyfUj1ld4viGzlEFDsNZ0k+pnCSN94WGEGacFPzDyNrPnGePWVN3wQ91k2rELSWLa/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkMKdryy; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-30363975406so557827a91.0;
        Tue, 06 May 2025 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746543767; x=1747148567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vktEqjsuV79dKuAmz5AcIDcSZ1EaHWsuQpXRAcNjy50=;
        b=GkMKdryy0gEWqcijM9KNQ+BYiiJC0khiK6A/0W/UWsbCgNFYdxun0+3kcDetAIe2Oc
         zHHZ+KRHkBJz0yaccAWRNdTLBhHtgbBb5BEDKZxuvE3jeJcFUMpiE/YluZSO+ODp6seb
         C44zbABHOzea8icflxCEyG6/oiEgC60U1cbQCObvrN6QIQqEylO50tzZH2+hRlo9GSQs
         C5fJ/ybgxptUpc2gVxXqAQwo3BbYxqe+NCh5a2+a7aLcyxI4U8bOfAX9c3VmwW2AzslB
         WqJdndXqlfwdIUGOK17818FKuEanAwEBRGC251FP0cWxuN6r4CGlq8gE8AEFuffoTkdm
         FpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543767; x=1747148567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vktEqjsuV79dKuAmz5AcIDcSZ1EaHWsuQpXRAcNjy50=;
        b=R5xQVmo+hdpXnLaPjomCJRMdFZxUzXXqdwQO90P2JX+HwYumj9/38YH8CKuLYpGdsi
         gC+gSuB4qm+w7wlk0t73DxivbIXkBxQLkGizO1H+iSunu4ZkKj/YSfWE2UlIuSSmXv7o
         H/MAYCYzPhSk8IbSn6pg7p1rFJqRu4pMqHG3kWCksfLoGExyGOLimyPa+GIMYcQU6qJ1
         sryo9G29XtIQJfdzLPZcrgZl/jQpTUZeubDZ8x2iuzk1IQlg0a3EPTLGUu81baou9K2e
         26hwVBssx9WNeCZIGyTwVxp212g4YmP3a2XPP57H9xDfazz8DqPzzKG8QWoY66VH48sR
         6IcA==
X-Forwarded-Encrypted: i=1; AJvYcCU9YNXRnDTBf45CD6wixtntccho+U2k4vWI3PsUSyyWL8sMS/YotD87uNM1fwuqQnjVmzxl66w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn09ZnyLcjYCzp8XOZZJQj2N+O/PgQFWVxfD6Bky3I9va4HBQr
	bdYDTV+LvPoPcmHYH8nP1+QTZi5TdX2tJo52t3na9kbXF/JcF7FNfmsNy40JXYrnJhhKxmoMTgm
	beQgzFb6cpGHYRRa+ZwSTOjTdpYs=
X-Gm-Gg: ASbGnctVk0YnRUpnB0XsbswUQiUc8jKo+IjA2aFjYYp1+5B1MSAdWCpAwuFZ4fg0Q/r
	/AiXCHAuhWzEfo7tFg+JjVv7/brc1K+V8zbhTrjKmU4fjgyZzsmhL9Jd7lBD5NmGXFUhUjZqwtv
	72FLeHpKfb67iV/NTt81ZP8g==
X-Google-Smtp-Source: AGHT+IHZJQerd5lYSgmKXFBIMwEXybKqQi7T2CP9X5INnCGIYqT3c4QEYnsAvtwWrnxL4AncipR/8wXzDf9JUdFle5I=
X-Received: by 2002:a17:90b:4d07:b0:306:b6ae:4d7a with SMTP id
 98e67ed59e1d1-30a4e69f90dmr9231704a91.3.1746543766820; Tue, 06 May 2025
 08:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505225634.2688578-1-sashal@kernel.org> <20250505225634.2688578-229-sashal@kernel.org>
In-Reply-To: <20250505225634.2688578-229-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 11:02:34 -0400
X-Gm-Features: ATxdqUEpmmNKQiGhMbisn4FhardjqBOJI2VMqCRzuJwevOedc0cvX0fCONYxO10
Message-ID: <CADnq5_OGPGwbKfFSP6BpNAhtOXnZ+L3Vmga9TxLDAAub=bu9JA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 229/294] drm/amd/display/dc: enable oem i2c
 support for DCE 12.x
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 7:04=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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

This is a new feature not a bug fix and this change only makes sense
with the other changes in kernel 6.15.

Alex

> ---
>  .../drm/amd/display/dc/dce120/dce120_resource.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> index 18c5a86d2d614..21f10fd8e7025 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
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

