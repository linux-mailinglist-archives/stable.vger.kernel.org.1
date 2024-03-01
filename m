Return-Path: <stable+bounces-25726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A9286DE40
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 10:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5402CB29784
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB486A33C;
	Fri,  1 Mar 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="o+pmB82b"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476192EB0E
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285283; cv=none; b=NTg4tOjEQSoGhy/E7/lS7pkJZ7pjxYfzKjQ5NVIXddaSA8DX3cHLCtAw8U0eCyL7Ft0a6tcKvudJfOcCCMT0Cgauw2Ap8fN3/FI8FLJExba/lZSm493tNxeIxkGGtTKG/xxOISgQX62gcUe1rSk2BmX88zqYjEb5rh6ZoA4wpsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285283; c=relaxed/simple;
	bh=9AkQylXRkiSkkl0eKy5Dctb2LpPSO6VxzJRxU+1riZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVuEtuusKjgoQ9Q9ivyk0KeU8aUohXEMjCMfSIoR+Xu8eQ1d5l5GtwYDP+AhTwTDxXYfewTt8vCWFUhqnmOM8VR441AdmWhGvV7J1saTleAh5E8ykcwh1qXnwBUhKU1XCf93xP/wuJfAmZWi7+Eqv9pf9xRq3f7SJcRKmQbLVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=o+pmB82b; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60925d20af0so20051577b3.2
        for <stable@vger.kernel.org>; Fri, 01 Mar 2024 01:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1709285280; x=1709890080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8qW88cphawb78fzlQE30+dz9GpFORGHSZEKQV6kMnE=;
        b=o+pmB82bEoVY+Jv8mvgXxjtmTFHSrDLDmnt6Xm9R5yXIyzw9agJ1MuWquDt3ZuUb+n
         lfrF/T/2jXpuaKQqqQBQ/ryyuRvI80AVJPIe8gfhLcSEl77MwIIFgUUxppDfJZK7n/sl
         4jUbgExAYCXzgTL1SZXRC8s1yiGiwcvfAeMITw8DbCe+vwFY4GM7sH/5rsJ322jh3RJT
         sgyV4a05a9yJkbk5AR1QzYC4K1Xq34OxuwPAJKj3foBIiN9kYklsa6i730maHGU2DQH6
         CTvbWBJzHkRewmHynBEQ09tIlive6K1KprWzE6mwAGnRUej7w1ASZsZXLeFRVO+jEXS4
         7mDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285280; x=1709890080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8qW88cphawb78fzlQE30+dz9GpFORGHSZEKQV6kMnE=;
        b=f/7lpWbxD/kk1uUw7u0PhfLgN12fmbH3Tzh2atjshl7xTqqMQSJtMiXVs/CNEA/Xnr
         N0DATuySYWncaf/4pVb7NzJkOJriLmbjLJrHUhsvQZVxQOh9FuCZGoZeE4wfJz8FF/OO
         E67rKCTocoqQMSALtkeWeaCcADYmbqW3voghQWhqpH5S0D1RH50t5iWo2Boi4lEbX29U
         NNOQDxoL1E2hM1mg/RnPAg/91JGAkvkrCoIEfG1UcTiOOn9Cnc39G2TC6Q/CsxQJXcPO
         FuZTwhCLBxp6n0SKfeWdbR4MPzIi0C2rXP4SpbpxSHaSSfjGGVZbbXrxxr542xBGMro5
         4Jkg==
X-Forwarded-Encrypted: i=1; AJvYcCVJMFJ01Sazq5xpDOMeMyv//VpUMnOep3/OpjJE0bnh/nrGkb6op6VVM4ZTxVbvYci091L3RBfOqKgL7iH0S2mAXXwz8J0C
X-Gm-Message-State: AOJu0Yxg1w5E/b5044JAdx2xt6LRdLnCpi/FiupYD46LUQG/y6Jo74DP
	wnna1DI1aKx1IBzrrY7jC4JTfIKIwqVWCoUvYfR09e+22iyr3dQ06TwfgKWxTc50xPQ344VB4Gg
	9H9xucw==
X-Google-Smtp-Source: AGHT+IF+twASYoNHN0ytXYlq3IDO2UXjbCq6ubq7fuj48qs4b6lfzMnsO5VbMXl08+F9O40kvtS6AA==
X-Received: by 2002:a0d:db91:0:b0:609:77f0:ff38 with SMTP id d139-20020a0ddb91000000b0060977f0ff38mr1055134ywe.42.1709285279978;
        Fri, 01 Mar 2024 01:27:59 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id r12-20020a81e40c000000b00607c3904416sm849427ywl.40.2024.03.01.01.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 01:27:59 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so1981420276.1;
        Fri, 01 Mar 2024 01:27:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4M302JhTMtONZwxKbYAJnYVkQHxCKSKXO1Y9C83iY54bEN8qwaU3mdbrWAieDEVD6xQ1uty1uDrmqjcYWIGC8dtm8C4d51m3Z3Ii7D2HdvCUAlONrTPNQscGS3QiE/+mpmjuZ
X-Received: by 2002:a05:6902:3:b0:dbd:5bfa:9681 with SMTP id
 l3-20020a056902000300b00dbd5bfa9681mr791205ybh.37.1709285279107; Fri, 01 Mar
 2024 01:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229195532.7815-1-christian.gmeiner@gmail.com>
In-Reply-To: <20240229195532.7815-1-christian.gmeiner@gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Fri, 1 Mar 2024 10:27:47 +0100
X-Gmail-Original-Message-ID: <CAAObsKBEV0q78CFmy1ezwKLQEY0hLDn4ct0UxedGKVZM7tCKeg@mail.gmail.com>
Message-ID: <CAAObsKBEV0q78CFmy1ezwKLQEY0hLDn4ct0UxedGKVZM7tCKeg@mail.gmail.com>
Subject: Re: [PATCH] etnaviv: Restore some id values
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Russell King <linux+etnaviv@armlinux.org.uk>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Christian Gmeiner <cgmeiner@igalia.com>, stable@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 8:55=E2=80=AFPM Christian Gmeiner
<christian.gmeiner@gmail.com> wrote:
>
> From: Christian Gmeiner <cgmeiner@igalia.com>
>
> The hwdb selection logic as a feature that allows it to mark some fields
> as 'don't care'. If we match with such a field we memcpy(..)
> the current etnaviv_chip_identity into ident.
>
> This step can overwrite some id values read from the GPU with the
> 'don't care' value.
>
> Fix this issue by restoring the affected values after the memcpy(..).
>
> As this is crucial for user space to know when this feature works as
> expected increment the minor version too.
>
> Fixes: 4078a1186dd3 ("drm/etnaviv: update hwdb selection logic")
> Cc: stable@vger.kernel.org

Oops.

Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>

Cheers,

Tomeu

> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c  |  2 +-
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6228ce603248..9a2965741dab 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -494,7 +494,7 @@ static const struct drm_driver etnaviv_drm_driver =3D=
 {
>         .desc               =3D "etnaviv DRM",
>         .date               =3D "20151214",
>         .major              =3D 1,
> -       .minor              =3D 3,
> +       .minor              =3D 4,
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etn=
aviv/etnaviv_hwdb.c
> index 67201242438b..1e38d66702f1 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
> @@ -265,6 +265,9 @@ static const struct etnaviv_chip_identity etnaviv_chi=
p_identities[] =3D {
>  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
>  {
>         struct etnaviv_chip_identity *ident =3D &gpu->identity;
> +       const u32 product_id =3D ident->product_id;
> +       const u32 customer_id =3D ident->customer_id;
> +       const u32 eco_id =3D ident->eco_id;
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
> @@ -278,6 +281,17 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_=
gpu *gpu)
>                          etnaviv_chip_identities[i].eco_id =3D=3D ~0U)) {
>                         memcpy(ident, &etnaviv_chip_identities[i],
>                                sizeof(*ident));
> +
> +                       /* Restore some id values if ~0U aka 'don't care'=
 is used. */
> +                       if (etnaviv_chip_identities[i].product_id =3D=3D =
~0U)
> +                               ident->product_id =3D product_id;
> +
> +                       if (etnaviv_chip_identities[i].customer_id =3D=3D=
 ~0U)
> +                               ident->customer_id =3D customer_id;
> +
> +                       if (etnaviv_chip_identities[i].eco_id =3D=3D ~0U)
> +                               ident->eco_id =3D eco_id;
> +
>                         return true;
>                 }
>         }
> --
> 2.44.0
>

