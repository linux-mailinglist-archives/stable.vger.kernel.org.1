Return-Path: <stable+bounces-118605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A689A3F833
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 16:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D8189F9F1
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9374A20FABA;
	Fri, 21 Feb 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLpfHGNO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D534820A5C3;
	Fri, 21 Feb 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150863; cv=none; b=Q9JlR6o+GgGTVAe96j0mlbO0HIIcQpMzdaZFeHRsFqa1Iv8jNJ82LBjEQyHwYHsWZLOR1VThMsTVcA2gTBv66j/BMR3NN9SvtAH1z+BaRuCoM5GhYodMTY7metHcw4V3z18VFZaxO3AUxy2i4S0OiWnV5b2KeXUEusXTeTqypmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150863; c=relaxed/simple;
	bh=W+YTeidu3y3Uj7i3nnpU2J4V4dfndNYZv9cMbFSe5sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SDFC7XwvqiFuI9Y0w3bUWeeUBLMRegc5faOiSQMr7YrueGTP6UrQkvgJjqPjTzqh//iYCuOePBDAL/eOFxfrotYQZ4Uo88n/VkpmF7vD2EJokodoqNTxrRe+Kk60J+/m2U/jeZbCjGsbFj2/cSBqYgE5o7JSFE7v8wMr0yBO2hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLpfHGNO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc317ea4b3so560720a91.3;
        Fri, 21 Feb 2025 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740150861; x=1740755661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfuxV1/a1iOlBYIh1qZOG17fTs3BvOvrUMe6IW7OLwg=;
        b=XLpfHGNOWKQAZZlpF2x9IuBHR9D5gBL/J6bEHWVToqXkMPC8j1evKmVvrD/MlzLD+l
         Vv39YjLEbr6KcJjHg8lm/esWgru6ug1ka6c+H1yGK3c8m2jIE9WHvj6aT6MexnLDsV87
         9Bi+mvziE7Tf3wA7B9l4PDNsYn/S05aulFpnJSxcSNoHQy2fouB9A74DplDrU5i5Vcgy
         +f1DGcq2KZr/nX0mLaTfrjdjl58wtzbb/rV0QauqpK8NVUBTaDXabuyTt5bJrZ/GKety
         qeFhLrtqCXTj4lHWqnRGayZlPmvft3aK0AnSui70pNSQTuogQgnES3AQhu4tFjyVns/v
         YkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740150861; x=1740755661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfuxV1/a1iOlBYIh1qZOG17fTs3BvOvrUMe6IW7OLwg=;
        b=M18DZUF4CyhSz4Ga+OzYrZIJkLvlgGKDBunI02BCNM5iXbj/kmI5YQtTu0po+YbG3p
         a4AlsTUS1+JJJVO3lqNDtWxLQ+FJoYjAVHp730SW8ZqwhcvB9G+h3w1WhEM6SHOt3hAA
         fm2jGv3ysbUiDVgzPjwNb9F23KJ+avLHMVF4p+jTLqUAw5PgGqFkhIFfMfQ2XwDPDoMG
         bv7NGZk/94381IQlISFum1j3KpNNNi3Wuas1iEU7wreQeMOpsarSLIVBa1Xkfmy9tLiD
         hR2j/AMwhcnJu6B6Ux1cwhWlDW57P8RvUil61tfXltAw0DhVDdx4Uz1QMrji+wqB3wVX
         71JQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0Wb1R47VEDdyIFOJ8tSy5kfIX7WShFca3CzR7OWXO3hrHEl6BsJZCn7vEUXc2Vuy7ae3mYNI+Qq0jNAM=@vger.kernel.org, AJvYcCVuWB2N/xtVAYaw178MYyuptB+q2KdtiekUtHIKdLi9PQ7jsmbMrFj5JVQRfK0Q8FQDp68TvAzQ@vger.kernel.org
X-Gm-Message-State: AOJu0YypbPcUasHPWgQ0/EM38zonF7MVWqZ5MQiy/5Ps17gXJKtl/Mpf
	EPLOkp449J1dXZWcGjgD9xDi/SjzKm/E7ZYHT9l0yK6zwUxwz/FBtAWZSIOu+LASavfymmsEJas
	KicPkz8t+di/DTMOgCzANL1U2978=
X-Gm-Gg: ASbGncsI335tGXKPlexrlTw61zDe7095W5Z4EjwxEPa/RlPdpDCIF94D2l93t/Q+8kt
	E9AVHZvaMpTo8VHpPmweUyBfmpck35PiTF4y/9t3gvyej30jKUXl2Q7hkXgR+CGKidBVbLLMi2v
	JrjXkR0tk=
X-Google-Smtp-Source: AGHT+IEibl4fc95czZrJ4RgjP2PVjpAMh5E+9z87AN8A6HGQUPD765UBJ1i70Y4tZ/mfnjgzkJ/UPsVt1W+kY8JBFCA=
X-Received: by 2002:a17:90b:3907:b0:2fc:f63:4b6a with SMTP id
 98e67ed59e1d1-2fce75f086bmr2217993a91.0.1740150861088; Fri, 21 Feb 2025
 07:14:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220064050.686-1-vulab@iscas.ac.cn>
In-Reply-To: <20250220064050.686-1-vulab@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 10:14:08 -0500
X-Gm-Features: AWEUYZlIX0qqP3tQtVUCU2K3fHzr-Gp8foCznDfOxPvXltvgscdn0oDEaXfnBjE
Message-ID: <CADnq5_PLNRJarsrJ9i9Q166Yj50CN2sJZSR5uOfokjNUhYDx1g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Add error handlings for r420 cp errata initiation
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 1:41=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> In r420_cp_errata_init(), the RESYNC information is stored even
> when the Scratch register is not correctly allocated.
>
> Change the return type of r420_cp_errata_init() from void to int
> to propagate errors to the caller. Add error checking after
> radeon_scratch_get() to ensure RESYNC information is stored
> to an allocated address. Log an error message and return the
> error code immediately when radeon_scratch_get() fails.
> Additionally, handle the return value of r420_cp_errata_init() in
> r420_startup() to log an appropriate error message and propagate
> the error if initialization fails.
>
> Fixes: 62cdc0c20663 ("drm/radeon/kms: Workaround RV410/R420 CP errata (V3=
)")
> Cc: stable@vger.kernel.org # 2.6.33+
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/radeon/r420.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r420.c b/drivers/gpu/drm/radeon/r420.=
c
> index 9a31cdec6415..67c55153cba8 100644
> --- a/drivers/gpu/drm/radeon/r420.c
> +++ b/drivers/gpu/drm/radeon/r420.c
> @@ -204,7 +204,7 @@ static void r420_clock_resume(struct radeon_device *r=
dev)
>         WREG32_PLL(R_00000D_SCLK_CNTL, sclk_cntl);
>  }
>
> -static void r420_cp_errata_init(struct radeon_device *rdev)
> +static int r420_cp_errata_init(struct radeon_device *rdev)

You changed the function signature, but you didn't adjust the function
behavior to match.

Alex

>  {
>         int r;
>         struct radeon_ring *ring =3D &rdev->ring[RADEON_RING_TYPE_GFX_IND=
EX];
> @@ -215,7 +215,11 @@ static void r420_cp_errata_init(struct radeon_device=
 *rdev)
>          * The proper workaround is to queue a RESYNC at the beginning
>          * of the CP init, apparently.
>          */
> -       radeon_scratch_get(rdev, &rdev->config.r300.resync_scratch);
> +       r =3D radeon_scratch_get(rdev, &rdev->config.r300.resync_scratch)=
;
> +       if (r) {
> +               DRM_ERROR("failed to get scratch reg (%d).\n", r);
> +               return r;
> +       }
>         r =3D radeon_ring_lock(rdev, ring, 8);
>         WARN_ON(r);
>         radeon_ring_write(ring, PACKET0(R300_CP_RESYNC_ADDR, 1));
> @@ -290,8 +294,11 @@ static int r420_startup(struct radeon_device *rdev)
>                 dev_err(rdev->dev, "failed initializing CP (%d).\n", r);
>                 return r;
>         }
> -       r420_cp_errata_init(rdev);
> -
> +       r =3D r420_cp_errata_init(rdev);
> +       if (r) {
> +               dev_err(rdev->dev, "failed initializing CP errata workaro=
und (%d).\n", r);
> +               return r;
> +       }
>         r =3D radeon_ib_pool_init(rdev);
>         if (r) {
>                 dev_err(rdev->dev, "IB initialization failed (%d).\n", r)=
;
> --
> 2.42.0.windows.2
>

