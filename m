Return-Path: <stable+bounces-2821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B7D7FAC2A
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 22:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2751C20F93
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 21:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316803FB04;
	Mon, 27 Nov 2023 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo/rt8mF"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAEEC0;
	Mon, 27 Nov 2023 13:02:57 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso2423592fac.0;
        Mon, 27 Nov 2023 13:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701118976; x=1701723776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/URjZ8nADYYERle5yEbSZ8yEpn5y/9V4VSzkBZxEyA=;
        b=jo/rt8mF4Sw3TRIhVkmCJMAWddfMgDhq6Lx9VSW+V9K+0NN/NUYALYVGSHq2gz6rJ5
         x9Dz5mBl6X91WFdEfekQEZEzmm3NKbs3CAMfrT6eWgXQvuzLoQraZ8aOGBjUXlV02ch6
         DwtBHj9Ql4MEDGWTtQ1iOvcgzaQE9KZ7MVs0sia3DLIeHywwXE0UDzq0lfl4zo5NWGA5
         7K8cbhbbh26E73NIKZo/O7t2vbIXvUYZx1VQ08OVgNcsjAoz3ZInGCuAkqmui3t3ITQ3
         c04UWqwhBCLm2xRr+6xwO7BGtw4WGYC7lIHaCBMADMbmWEedAfzJ3zsKgAmnjf+84Vhh
         jAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701118976; x=1701723776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/URjZ8nADYYERle5yEbSZ8yEpn5y/9V4VSzkBZxEyA=;
        b=E3GduKk+mSNo6TsQjqJVpT/Fmhh0syTSEmhQdwOfQclWCaMtWg0c4eNNzMeR7nn8Cw
         sPnExJHMP46HoVouVefKH1m0svbmXOOggloLXJslGzy6OXbB7iXy+pPH0DVkwRbPTfvz
         hW2SbA0QXu7v3eb+L5PqzaqmRjffiNr0u7lLu9U8Xy/TQcqo2coftdOf5maYvTUKtPRB
         9qCxd0Zv5jN0+lvGs+62YKvRxYOZAWSwyHJngaJm1q/v9ZnR+82EDkghbybfwaK9RAFW
         xDkEC0h/01BOfE2W5Ix3eCWZVywsXLe0l3eCxSa9+zRU2H5F4N5RMpbRbn2FllYPYNqu
         /JLw==
X-Gm-Message-State: AOJu0Yx3REbTuBRVKYfLlEnSPYNiUGGQDXJzrMXRKL+Zpcb/ktZACvav
	O6fLnYksQdT6HToYQA5tl1ylesMUsinDf3P0QS9sdySy
X-Google-Smtp-Source: AGHT+IHQhapSzKaJWN9AXlYSZ1KiLZ6SHYBMuIwFWgsyRpoLqjNDWWg/Ayr1LN6eJbSc36wevU+by4X07E5yovjRXf8=
X-Received: by 2002:a05:6871:d217:b0:1fa:cdd:c0fb with SMTP id
 pk23-20020a056871d21700b001fa0cddc0fbmr14400149oac.7.1701118976475; Mon, 27
 Nov 2023 13:02:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122122449.11588-1-tzimmermann@suse.de> <20231122122449.11588-3-tzimmermann@suse.de>
In-Reply-To: <20231122122449.11588-3-tzimmermann@suse.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Nov 2023 16:02:45 -0500
Message-ID: <CADnq5_PwgV=SpuzdD==R-3nxz+Em4AiVmriODxyxZgoeZu7Yrw@mail.gmail.com>
Subject: Re: [PATCH 02/14] drm: Fix TODO list mentioning non-KMS drivers
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, cai.huoqing@linux.dev, Jonathan Corbet <corbet@lwn.net>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, linux-doc@vger.kernel.org, stable@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 7:25=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Non-KMS drivers have been removed from DRM. Update the TODO list
> accordingly.
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
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.3+
> Cc: linux-doc@vger.kernel.org

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/todo.rst | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
> index b62c7fa0c2bcc..3bdb8787960be 100644
> --- a/Documentation/gpu/todo.rst
> +++ b/Documentation/gpu/todo.rst
> @@ -337,8 +337,8 @@ connector register/unregister fixes
>
>  Level: Intermediate
>
> -Remove load/unload callbacks from all non-DRIVER_LEGACY drivers
> ----------------------------------------------------------------
> +Remove load/unload callbacks
> +----------------------------
>
>  The load/unload callbacks in struct &drm_driver are very much midlayers,=
 plus
>  for historical reasons they get the ordering wrong (and we can't fix tha=
t)
> @@ -347,8 +347,7 @@ between setting up the &drm_driver structure and call=
ing drm_dev_register().
>  - Rework drivers to no longer use the load/unload callbacks, directly co=
ding the
>    load/unload sequence into the driver's probe function.
>
> -- Once all non-DRIVER_LEGACY drivers are converted, disallow the load/un=
load
> -  callbacks for all modern drivers.
> +- Once all drivers are converted, remove the load/unload callbacks.
>
>  Contact: Daniel Vetter
>
> --
> 2.42.1
>

