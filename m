Return-Path: <stable+bounces-87582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F819A6DD8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75F91C20EC8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A43FB8B;
	Mon, 21 Oct 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="pSqL/hRg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0D26ACB
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729523708; cv=none; b=tewy0Lvcaot+CBfw1PPf2s1wczFUPQuK182EGH6vk0wUkdScnpCY3riT2KUuMW90IR/LK5IUT/zazgxC4KPmbPFNTFLOcMcMw25aj3sZEanpDsxwP/6pGWMYVPX4X9ERnIwCAW8FvuI0vAGMEmGAi978IdRkgfU+w8TV02gjJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729523708; c=relaxed/simple;
	bh=MbTjSVzv8f+NjyPLuVwedfGWGnFwOToxQBmyznK/2Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNHAqIyJrVGC9iZCClOzGQWvbmh9fXlktX7yMh+Z9PmHWJbyY88TCUL7WNptvrfmWfwJthgxrrnt0QZu5P42OjL3lAxPhZLPPQ+oxhjmACfx0czTKbRRKl57B1t/t/MygWCAaofYqxnFPrZPG39ruGbpmJznZcPTC12kUb5CbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=pSqL/hRg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e8607c2aso4915864e87.3
        for <stable@vger.kernel.org>; Mon, 21 Oct 2024 08:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1729523705; x=1730128505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvLvAGoaEs4cLCLummjUn/fSa2RxeVRTPvPMgQ05vWA=;
        b=pSqL/hRg9oKL7fZJw751VNEEq5iN9rV5NyK2crFIQbG2kPa0N9rU/C6LfReu/SMMP1
         GKOr654+LAPpmiI/QXO2Jb7h6g72OV8rbCOPSBodoxgYbtQ9hoiE6/5ai0MFim3IFeX9
         uwiC9Z2YCzwLXCtO1LzLGPG0faqXWoxMeacIcM8/gvu4bvZSMSa7t/CtuUItaDD9Dsiu
         hJI7/ZWbvEYRpt1ITLV/2IShWU7xQZrw2M5XrWxoeOXP5c4A5P7LAoC3G/WjAzgjM6St
         M00mbZ0GOsIW7jHvrxLQ3E4B22zRbEOj3UpAMqfi+XiB/xX5FtFux0qCvgUa/0k7wyx3
         tIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729523705; x=1730128505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvLvAGoaEs4cLCLummjUn/fSa2RxeVRTPvPMgQ05vWA=;
        b=kvueY/wSunsDVw3v7ndFumo9mn8GPuSFo9fYD24hciA1/McGFnpDrwAi9gqEixcXB2
         twVmuWe9h0an8YtkOWl8tmTIyTO+tee0S1Gy8pshPs062HxSfytfRA8Da36AcSqygCcl
         XqJnndMGoi8RBQaIDazGTBf4xc7WPIQhm1ChwDoRLSMQrVgP1MtFJ8GL/ZhFZYVUL5pC
         wJO+RIgzlMrTaFPt3me6XBoDOgulfxMI8GBeFGqD0KeXX+ff4vhzF7wkmMIhCrAm7ADB
         IbHeiaiUfAd51tCiuG9ZmBlF9NiKaEvCFpMpkueDHANZI2TTOcNzSAyQOhwwQP1sQeDm
         B2rw==
X-Forwarded-Encrypted: i=1; AJvYcCWMSaAdEblvSu4nCSG4dfEBaALZm8fYAjrrPl/bf6NHqjU8zR5oEybtaUM1h12QrVtp83NZ56c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDt4ZHbg25QR+r/P+w3Ts/Zwf/QxZ3DS6Y4KpG5u6Si+/4fUCw
	DMtQWAjtvLvxBvE8urJ9pSubaEYkEWlP6/Ky+IQOJMrvWpkMybQPjPuw3qG+wpZMwb6Nf75td7Z
	PXSx+jRPjfgynwjs/LTWIQsOcgF+eEPK8Hk+bTUsO5nXaoLaobg==
X-Google-Smtp-Source: AGHT+IH5PS65InXxWy7zQvIKXC5DV3lRT7k9uy1hS9BXMEO9QulVaI6d3S3/tVIqUPBmpDRG0ReoxzC3NqxZUA7H7xY=
X-Received: by 2002:a05:6512:2813:b0:533:44e7:1b2a with SMTP id
 2adb3069b0e04-53a154b2d95mr5431587e87.40.1729523704965; Mon, 21 Oct 2024
 08:15:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-tidss-irq-fix-v1-0-82ddaec94e4a@ideasonboard.com> <20241021-tidss-irq-fix-v1-6-82ddaec94e4a@ideasonboard.com>
In-Reply-To: <20241021-tidss-irq-fix-v1-6-82ddaec94e4a@ideasonboard.com>
From: Jon Cormier <jcormier@criticallink.com>
Date: Mon, 21 Oct 2024 11:14:53 -0400
Message-ID: <CADL8D3Ykxbz7W=Av774sk9HaEnvneLNZcxmGsGaL2XDEFgpzAw@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/tidss: Fix race condition while handling
 interrupt registers
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 10:08=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> From: Devarsh Thakkar <devarsht@ti.com>
>
> The driver has a spinlock for protecting the irq_masks field and irq
> enable registers. However, the driver misses protecting the irq status
> registers which can lead to races.
>
> Take the spinlock when accessing irqstatus too.
>
> Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Disp=
lay SubSystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> [Tomi: updated the desc]
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/tidss/tidss_dispc.c | 4 ++++
>  drivers/gpu/drm/tidss/tidss_irq.c   | 2 ++
>  2 files changed, 6 insertions(+)

Reviewed-by: Jonathan Cormier <jcormier@criticallink.com>
Tested an equivalent patch for several weeks.
Tested-by: Jonathan Cormier <jcormier@criticallink.com>

>
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/=
tidss_dispc.c
> index 515f82e8a0a5..07f5c26cfa26 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -2767,8 +2767,12 @@ static void dispc_init_errata(struct dispc_device =
*dispc)
>   */
>  static void dispc_softreset_k2g(struct dispc_device *dispc)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&dispc->tidss->wait_lock, flags);
>         dispc_set_irqenable(dispc, 0);
>         dispc_read_and_clear_irqstatus(dispc);
> +       spin_unlock_irqrestore(&dispc->tidss->wait_lock, flags);
>
>         for (unsigned int vp_idx =3D 0; vp_idx < dispc->feat->num_vps; ++=
vp_idx)
>                 VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0, 0, 0);
> diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/ti=
dss_irq.c
> index 3cc4024ec7ff..8af4682ba56b 100644
> --- a/drivers/gpu/drm/tidss/tidss_irq.c
> +++ b/drivers/gpu/drm/tidss/tidss_irq.c
> @@ -60,7 +60,9 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg=
)
>         unsigned int id;
>         dispc_irq_t irqstatus;
>
> +       spin_lock(&tidss->wait_lock);
>         irqstatus =3D dispc_read_and_clear_irqstatus(tidss->dispc);
> +       spin_unlock(&tidss->wait_lock);
>
>         for (id =3D 0; id < tidss->num_crtcs; id++) {
>                 struct drm_crtc *crtc =3D tidss->crtcs[id];
>
> --
> 2.43.0
>

