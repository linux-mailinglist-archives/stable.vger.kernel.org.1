Return-Path: <stable+bounces-134728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B593A94616
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 02:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3592E7ABBDE
	for <lists+stable@lfdr.de>; Sun, 20 Apr 2025 00:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60863B9;
	Sun, 20 Apr 2025 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd10DXpg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F504C7D;
	Sun, 20 Apr 2025 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745109288; cv=none; b=ktIPIGxWUtTC6ZP15Aecj0RkFH9+G9lLik7u7LUCRBc20A0U61CWBPzQMgIsEDUHwtxLeq7dyZztS5KyLsEHfpUBiWBqObglGmwh6Is4D/c7XekkXvFGxsXxfHVHg/D52VJF2s/K8r+nr9aObf2t3QxYrjm1HaP3Y7o0sy5XJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745109288; c=relaxed/simple;
	bh=CFylASbB8x1qwvmS81FU9E0X/hvT3rRGccqv9ZghGok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFZhUmK3+4JZoHzOrwNnOwpcvyeWRDEhep2wa13pTrBLcQ4hU6Be/MxDk6U87/85BRcSBV2v9r2vaHh5TCC+jjA/zUQezVaj6azu4Ek/2t947Ngstbgj3gBuYVwNjnGhB1D1JW/WyqSy6LuJq+327qLP3uxGD5t7nLX5I4jmSs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd10DXpg; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso27478081fa.2;
        Sat, 19 Apr 2025 17:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745109284; x=1745714084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCVfNP1UFzhQHU+UziS/1aMy/BtD5fPkaaRh6L2J8Tk=;
        b=Zd10DXpgjq71buAQ3kVuCnjhoAaPIVooeQGkTZYipcwwozSLgniBah2aML7UgHXJ/e
         X3nDTZVEnKxuWtl8uxvVEDp4iRO+Z1Lmgy8ozlLYuAwILnPgAkQzL/Y2UilRBMIonigh
         dC9z/Lv4+LA8vRFnnH5oqbjozobZCkc04iKUWuwhsFsbfLEw4VeuKblIEQ/tmjPgwk28
         y8bfFLPYLmZXv7QdW/qZ+PW+WgqRLtoFMNI8DkoxaeBpHTw0y4M9HpRz11ncuC006LMk
         +Io1HfL1/+OudMkfkb1sUiL0Ftgf2GLHqcHPGzrHMdYxOTQzeOvTHWkpWP1pKhLJwA6i
         CTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745109284; x=1745714084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCVfNP1UFzhQHU+UziS/1aMy/BtD5fPkaaRh6L2J8Tk=;
        b=pxuXyfbxlwjfswhXf1aRkojUPAIS6arqHym2TRiLt8rZq1yqdpAkKNZhV/GPRGq9Nv
         QezODVHE69reqW+VLeE5pz95fpnRyjtfrPe2TPhxt4x+5YTtsAQZCnVYK5Ng8tdz+92t
         hec4TtQda3IryU5uJLr6n4RMVQ3DrA9f8F821HyGzjfJyY41mL8SIOFqrtuvWaLrU+Tp
         OYDu5ThJKB/j3G57rDfy32HDzh5CSkCAmDatMNX/WT07Tbc/tKRUiyQLkw74mfz06a5u
         mgy+xZbJ6jT25t2ccMV2JvwXtJ0mRrx53aBJ/3giHy18oTpUBaUiSvXY8QatoH2OEpF3
         kC/A==
X-Forwarded-Encrypted: i=1; AJvYcCVNCE7nF1MzouGp99FIrsGp94btRHiTvsg8IFvtnRwVxAFRXhSMyyiv85fHibv9AgOBdyIREbciv75ek4s=@vger.kernel.org, AJvYcCXT8uBCbx1jTYDKPr2ubnW1XzvkuuI3LfcKsmfKqK2f0xiU3X674lwutYWXn+I7NHoxLNshzCz0RFkRgRc=@vger.kernel.org, AJvYcCXVVuTGBcvXKo/mPb5Cw4nRwR0Chw21ZanGp9uJdoCkJDzHbh6jBQJY96URRbhxFTsCavNu96TW@vger.kernel.org
X-Gm-Message-State: AOJu0YxzgEGlFA9nKkxxqvt6CZxpAxxy/gXsvSmaSQnhD0dQ28L1jzkW
	sMt3g7a7BnnRF1oEe5OEtMIiyujneG7jSiu+xW9fPubIbrTVuxFWSi3nHzi2cyJ5DClio5dg3q5
	d+CX4p5JSY+oApyJpS3XtKPsurnA=
X-Gm-Gg: ASbGncsfsnCCdXnR4greFpgMIsBlPA2iMUF+v/Isr2CL5PcLsyEWg1onxuW/WzR4Gzj
	ObtonaRZZ4UfVDnfxVRb62+IUWpMy/02FHIuEHelpBQCA8CI7ycvo2ywyWAkU2Gwy2sqBzAU/eb
	8b53qE5IryC0vtnZnxTBPSvQ==
X-Google-Smtp-Source: AGHT+IGnBT9PQ5jEYh6DumXMG4qyl8frndd6pk/C2KijCK3Ra++k3C4hOaeGs7Q5Y+TzsQlcujBhFcQSpRKFZqunwH8=
X-Received: by 2002:a2e:a90c:0:b0:30b:c5e7:6e61 with SMTP id
 38308e7fff4ca-31090502c67mr21744281fa.20.1745109284149; Sat, 19 Apr 2025
 17:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419-tegra-drm-primary-v1-1-b91054fb413f@gmail.com>
In-Reply-To: <20250419-tegra-drm-primary-v1-1-b91054fb413f@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sat, 19 Apr 2025 19:34:31 -0500
X-Gm-Features: ATxdqUElBbV3bALOk2EQDcBsKfIDN7TbdtaDRssMJYfP5UjTo9xKypEXMgLxsUY
Message-ID: <CALHNRZ83pcXT_7r4B-ZB-m9rP9vM0n+HzeCJkXvAFsdLch5-pg@mail.gmail.com>
Subject: Re: [PATCH] drm/tegra: Assign plane type before registration
To: webgeek1234@gmail.com
Cc: Thierry Reding <thierry.reding@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thierry Reding <treding@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 7:30=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Changes to a plane's type after it has been registered aren't propagated
> to userspace automatically. This could possibly be achieved by updating
> the property, but since we can already determine which type this should
> be before the registration, passing in the right type from the start is
> a much better solution.
>
> Suggested-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Cc: stable@vger.kernel.org
> ---
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c  | 12 ++++++++----
>  drivers/gpu/drm/tegra/hub.c |  4 ++--
>  drivers/gpu/drm/tegra/hub.h |  3 ++-
>  3 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 798507a8ae56d6789feb95dccdd23b2e63d9c148..56f12dbcee3e93ff5e4804e5f=
e9b23f160073ebf 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -1321,10 +1321,16 @@ static struct drm_plane *tegra_dc_add_shared_plan=
es(struct drm_device *drm,
>                 if (wgrp->dc =3D=3D dc->pipe) {
>                         for (j =3D 0; j < wgrp->num_windows; j++) {
>                                 unsigned int index =3D wgrp->windows[j];
> +                               enum drm_plane_type type;
> +
> +                               if (primary)
> +                                       type =3D DRM_PLANE_TYPE_OVERLAY;
> +                               else
> +                                       type =3D DRM_PLANE_TYPE_PRIMARY;
>
>                                 plane =3D tegra_shared_plane_create(drm, =
dc,
>                                                                   wgrp->i=
ndex,
> -                                                                 index);
> +                                                                 index, =
type);
>                                 if (IS_ERR(plane))
>                                         return plane;
>
> @@ -1332,10 +1338,8 @@ static struct drm_plane *tegra_dc_add_shared_plane=
s(struct drm_device *drm,
>                                  * Choose the first shared plane owned by=
 this
>                                  * head as the primary plane.
>                                  */
> -                               if (!primary) {
> -                                       plane->type =3D DRM_PLANE_TYPE_PR=
IMARY;
> +                               if (!primary)
>                                         primary =3D plane;
> -                               }
>                         }
>                 }
>         }
> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index fa6140fc37fb16df4b150e5ae9d8148f8f446cd7..8f779f23dc0904d38b14d3f3a=
928a07fc9e601ad 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -755,9 +755,9 @@ static const struct drm_plane_helper_funcs tegra_shar=
ed_plane_helper_funcs =3D {
>  struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
>                                             struct tegra_dc *dc,
>                                             unsigned int wgrp,
> -                                           unsigned int index)
> +                                           unsigned int index,
> +                                           enum drm_plane_type type)
>  {
> -       enum drm_plane_type type =3D DRM_PLANE_TYPE_OVERLAY;
>         struct tegra_drm *tegra =3D drm->dev_private;
>         struct tegra_display_hub *hub =3D tegra->hub;
>         struct tegra_shared_plane *plane;
> diff --git a/drivers/gpu/drm/tegra/hub.h b/drivers/gpu/drm/tegra/hub.h
> index 23c4b2115ed1e36e8d2d6ed614a6ead97eb4c441..a66f18c4facc9df96ea8b9f54=
239b52f06536d12 100644
> --- a/drivers/gpu/drm/tegra/hub.h
> +++ b/drivers/gpu/drm/tegra/hub.h
> @@ -80,7 +80,8 @@ void tegra_display_hub_cleanup(struct tegra_display_hub=
 *hub);
>  struct drm_plane *tegra_shared_plane_create(struct drm_device *drm,
>                                             struct tegra_dc *dc,
>                                             unsigned int wgrp,
> -                                           unsigned int index);
> +                                           unsigned int index,
> +                                           enum drm_plane_type type);
>
>  int tegra_display_hub_atomic_check(struct drm_device *drm,
>                                    struct drm_atomic_state *state);
>
> ---
> base-commit: 119009db267415049182774196e3cce9e13b52ef
> change-id: 20250419-tegra-drm-primary-ce47febefdaf
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>
>
>

This patch was being discussed on the tegra-drm freedesktop issue
tracker [0], but movement there has stopped. I'm submitting the change
here in hopes of getting it moving again.

The stable cc is intended to get this picked back to 6.12 at least.
But as far as I know, this bug has existed as long as Tegra186 support
in tegra-drm has.

Sincerely,
Aaron Kling

[0] https://gitlab.freedesktop.org/drm/tegra/-/issues/3

