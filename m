Return-Path: <stable+bounces-141829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC39AAC8B8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 16:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1644981360
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAAD2836A0;
	Tue,  6 May 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps6v2G2y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABFF283C94;
	Tue,  6 May 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543120; cv=none; b=Q5EPnU2txge/QWPSwRC3QeNcnGb4Dv74ttvRt8KPxToofaNIZc0ewDbDB3oPV1l491/rJdY0dr5b+IEwshLRLfTLW8tJK1U19xccA24pyBzW8pEe3ViOi+xiTfNDg3DXAP/Eweatbli0un84juElxs/Cg7IAy+cor3l8LaCRXrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543120; c=relaxed/simple;
	bh=Hb4Vesw8ac4tapJfkHAXpZUAAz58TBZuC75dUD0W7ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEdB/CMZdavYQCm/TyOiowR6uPThw6fdnZZ6elIpgb6sethHfEfjXwYcobTS3YuntlbbHCRmO+MPWQsT6gYixV82yg0fqgqDE1slrmVKLr11HsaMdcqYt23JigCRfd8KBwLkrdGWjBkDtHuMF0FG91wB2DiLGFFRYarTGhEfZss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps6v2G2y; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3054e2d13a7so414175a91.2;
        Tue, 06 May 2025 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746543117; x=1747147917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrvQLl0wy1XN7F1KXa2GtXnCc3OPj79LA4bOD8IjDg4=;
        b=Ps6v2G2yBtsq4OrlJ3Brw2haaiS0trd8PNe+/3JuFAuBI9gIF7Qq/YKuYLgiJk6dlX
         6CCNj5dAZa28ltHXaP04wCDVhbCi8CK48LiDTvItsYE8wWyitx1vMsfhWY+VoUeWbK4R
         TJ80/EHqDcjLdO9Sa5RS3XetL5EBFU0eCHpaM4PK92Uf9Rg6/QkOWR79zO1h0boEJt8H
         SsD70XH42xCufP5uHX0XGp8J0jVt5B5KJ7vscyhT/LmKe57shELudfXxSIX2gMeYfjWe
         C76o/NcbopKNEzJO2rY5l1cJPBSESSPaBBtKY6A5+EQSe9BFIGDRaFYqvpZkRVtSGyDw
         DmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543117; x=1747147917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrvQLl0wy1XN7F1KXa2GtXnCc3OPj79LA4bOD8IjDg4=;
        b=IJfPKl7OfZkb3fc4mfc9etA+jBKUDK9PDbvbRQ5tyMco8pbKdyJOKA47KUOca1ZmE7
         UTidOb/kMLJYS/wh5pAcuzkVxnU5QG5d7Uy5HlZw3GiRTnCdmhVfdh9y9HP80SVcWPKm
         kHTVbICTYnfLHusvHzoi8mDmpEyuCTnWAKz7kkgQ/Myxpd81k6YdyEadAFHgdEAaQpRd
         sNMZKRMUwpBIQOdoxT5LVZkpMhcEgT9nwptrxD0AAV0kfSQq7Vl8U2TWuJrUx3q0M33h
         p0fTUGYtKAEfTBQI0b34DZfMeb/k/Bnb220sm15TLhwwEmyqxKdpDV18UPjeWprQOGGB
         WUsw==
X-Forwarded-Encrypted: i=1; AJvYcCVXe66hEnNT7BuIKsQ9M35LbCoUZA7t+8OSBKiPNOYIKDd7Sws265xeeVXDKfobmk77Uv4E1Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhnKy6b9qVpI+Yaka+DQzrX5xUrzvRuSLfnVLFvaQsAJadB6/K
	is8UQqGZNifsXXlZ98jgo4kOBSi7wz6wEyp7jbboqgjVez9KQuI0ed04+S/W7kUVRSLsWghAUkc
	xq78Asr8xyABUKUDIb4mQ+zn/NWo=
X-Gm-Gg: ASbGncsjqw78wtw5vgIISdF53DfAB+FReDZ51xw6Kac3WE1dLNnA98pSJ+fe/8bYddN
	zpbDTmzWZ78xWem03YYgIE9iwup6OpOjPpat2+dbtF6oD+CUeqBui9NHbZUzX9VovS7BLmPkIrG
	ucHroYhhFx65fCmIKNra5NyQ==
X-Google-Smtp-Source: AGHT+IEXSCTDToZhh1jFM95PCZ0I/E206Rg+MKBboqgunyBsE/pFYw40iBWN2ZEpR0s0+75jhOyYC81tR+CvcVK4+P8=
X-Received: by 2002:a17:90b:1d8b:b0:2ff:7970:d2bd with SMTP id
 98e67ed59e1d1-30a4e6913e8mr9498552a91.5.1746543116650; Tue, 06 May 2025
 07:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505221419.2672473-1-sashal@kernel.org> <20250505221419.2672473-483-sashal@kernel.org>
In-Reply-To: <20250505221419.2672473-483-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 May 2025 10:51:44 -0400
X-Gm-Features: ATxdqUHNIz2XY7_fK65CkP4RU9ZYclbCYI52nxG7JH7RRQaFM7OP72dHJwqOZKo
Message-ID: <CADnq5_MHZSO6aRTKuZ_NJUiDCDfxkUCGQzg9fRwEhcMo5goQww@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.14 483/642] drm/amd/display/dc: enable oem i2c
 support for DCE 12.x
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, sunpeng.li@amd.com, 
	christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
	roman.li@amd.com, srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 6:34=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
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

This isn't a bug fix.  This is a new feature and depends on other
changes to actually utilize.

Alex

> ---
>  .../dc/resource/dce120/dce120_resource.c        | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dce120/dce120_resource.c
> index c63c596234333..eb1e158d34361 100644
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

