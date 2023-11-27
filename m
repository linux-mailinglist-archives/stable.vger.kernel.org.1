Return-Path: <stable+bounces-2822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E80D7FAC2C
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 22:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 713361C20F63
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 21:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992423EA70;
	Mon, 27 Nov 2023 21:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxKHkUiq"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EE191
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 13:03:11 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1fa235f8026so1575558fac.3
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 13:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701118991; x=1701723791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6Ju5m6wUuBuxgz9DC/CfBuuqTJXG8hedvZDwOP6OJ0=;
        b=kxKHkUiqkaQwNHSykqxlmlZgZUb8mbUW0HhW4ymRoP/NoSXNdYcPsIAVz1rRdbRhp8
         RkDmXRlFXsyhlhjFoqI8ccMRsg/DBGInQBTkV+guzF0U/gtr1EPgrCsGpb9tYhPk7JF+
         xrArYaXWg5vs/Gl4zoefQQ5j5pUMAE44uxgsMIbUYJFjHEQLOH8QCo/V+oCCYRBaHlwX
         KezooXbX48sjNvgiNiKyjxjC4wH5MITWzuoXUQHxSeAqj8luBUEW/PP00Gur7oC/ynFM
         kFhnh2UxARUoq4UKor1Hh0Fh6jWg/sk46MgHx/LCcVok9EjUdTYb8KTRE1Nacqe6yTpJ
         qb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701118991; x=1701723791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6Ju5m6wUuBuxgz9DC/CfBuuqTJXG8hedvZDwOP6OJ0=;
        b=c6yNrzn6VskoWDPEZO2K6J/mlUaJl9orcf1n5V/LnLmivNckHe/AjPJ/GHRYGIsF7p
         grm3jsawargS0vWOFypvrwbVy1v4enEX1LLK56jlMNQ+fLZGzhdSr/nu3YDSNJy6uJx0
         KmiS4qLQY1GTVj0a/t77SZlL4dRZ35gW+xIsJb4OQqUS4Zhqf4XQAe1BsGpmGNscQMao
         9+uini+DokJTq11ifB+plW9qP1wdkF8MynMYr23W3aEmbhP2uD6R4vYBZUEXw3/qt6KV
         ewMDTb9eFK+LTrRTuEF8GysX8kefQ/gNHJvffQuNfGW1K6hMC4HRKaThxHr6JwcvlN6M
         fTOQ==
X-Gm-Message-State: AOJu0Yy6b2UPpDd7bzsReaP9Q9r6q0zBh+uGmJFPhpetTkVB7hnKJdPN
	UHo9A2DZyVmy5sfRSXPAej9/bxbrUhZd2mNJYeE=
X-Google-Smtp-Source: AGHT+IEZOqgZXfteqD1wp78SWIX8v0VHSZLtwlSQslAATW1fONsKWrheYfgoNWM6d/FD9qUrmvV7w126AcR1l6FZO20=
X-Received: by 2002:a05:6870:3c8b:b0:1f9:dc5a:b8fc with SMTP id
 gl11-20020a0568703c8b00b001f9dc5ab8fcmr17797992oab.56.1701118991101; Mon, 27
 Nov 2023 13:03:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122449.11588-1-tzimmermann@suse.de> <20231122122449.11588-2-tzimmermann@suse.de>
In-Reply-To: <20231122122449.11588-2-tzimmermann@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Nov 2023 16:03:00 -0500
Message-ID: <CADnq5_NmFZxD2=EOaLSt2UYeRtBUFhh++Du-M=Sg8ey4N7M3EQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] arch/powerpc: Remove legacy DRM drivers from
 default configs
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, cai.huoqing@linux.dev, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 7:25=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> DRM drivers for user-space modesetting have been removed. Do not
> select the respective options in the default configs.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: a276afc19eec ("drm: Remove some obsolete drm pciids(tdfx, mga, i81=
0, savage, r128, sis, via)")
> Cc: Cai Huoqing <cai.huoqing@linux.dev>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.3+

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  arch/powerpc/configs/pmac32_defconfig | 2 --
>  arch/powerpc/configs/ppc6xx_defconfig | 7 -------
>  2 files changed, 9 deletions(-)
>
> diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs=
/pmac32_defconfig
> index 57ded82c28409..e41e7affd2482 100644
> --- a/arch/powerpc/configs/pmac32_defconfig
> +++ b/arch/powerpc/configs/pmac32_defconfig
> @@ -188,8 +188,6 @@ CONFIG_AGP=3Dm
>  CONFIG_AGP_UNINORTH=3Dm
>  CONFIG_DRM=3Dm
>  CONFIG_DRM_RADEON=3Dm
> -CONFIG_DRM_LEGACY=3Dy
> -CONFIG_DRM_R128=3Dm
>  CONFIG_FB=3Dy
>  CONFIG_FB_OF=3Dy
>  CONFIG_FB_CONTROL=3Dy
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs=
/ppc6xx_defconfig
> index f279703425d45..e680cd086f0e8 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -678,13 +678,6 @@ CONFIG_AGP=3Dy
>  CONFIG_AGP_UNINORTH=3Dy
>  CONFIG_DRM=3Dm
>  CONFIG_DRM_RADEON=3Dm
> -CONFIG_DRM_LEGACY=3Dy
> -CONFIG_DRM_TDFX=3Dm
> -CONFIG_DRM_R128=3Dm
> -CONFIG_DRM_MGA=3Dm
> -CONFIG_DRM_SIS=3Dm
> -CONFIG_DRM_VIA=3Dm
> -CONFIG_DRM_SAVAGE=3Dm
>  CONFIG_FB=3Dy
>  CONFIG_FB_CIRRUS=3Dm
>  CONFIG_FB_OF=3Dy
> --
> 2.42.1
>

