Return-Path: <stable+bounces-158729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C53DCAEAE3B
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 06:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5DF1BC62E1
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 04:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048E1DC9B5;
	Fri, 27 Jun 2025 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AizqWq9j"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E11D86FF;
	Fri, 27 Jun 2025 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751000205; cv=none; b=dU1uc9H32lj/uipZjB9smR8w0Nkq/fjJNJsXvolkkbJDqA/02Ic7ljGnXiw6RFKRft79nR0bhrqCdUg15lGpLTknE9ssXPY4KXIs2A7jVOhJQtlH+d4XknwyhsE48iLWm/XpSP3guS7ZxRdm4CUrf4bhSOfr0JCHPSFQ+LHBJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751000205; c=relaxed/simple;
	bh=83afpayJE6U1T0aoAEzP5u1PnMIk9sJYc8MFC9piAA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAQoupKIhsAXw+RGSdezRaPjnGVNL8q+V/HkHlr5LY5va6eBk/oqyaLIcRe/g5XlZKTSuCV6ojbSUFzk8caJD4kjo3kwSXpyF+Dxh4UqFgheiJScB7PG/h97jT2nHR8S16AY4s1Ob8OwSgwBzcIRj2p+7X5oncRru9mu8GL2Was=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AizqWq9j; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e7fb730078so522610137.1;
        Thu, 26 Jun 2025 21:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751000203; x=1751605003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2HGv8LGZ8DzKrZFUO2v+eei1l2wUynW3XD4JObL1Tw=;
        b=AizqWq9jmfpAVQ3p9F0+bryXy5gdrRLRTBjknoYuEcW+5TAXm0nu5Dxc8awZAXyePE
         4LxJCgk4r3GKkNcP1iV2fusXsg1De0dD2gJ2Z5uszU6d3Oe9jw6LmGUgbrwl+aghvRlw
         Mn0VFcCjRWD/Xr6caegQc0YIJjFQoQJKMzk2vl+/VlOrJWZk0NTKZ6zhU5dOAk2SNjpK
         VtiuLfdHkViJm0q+ciYlaYEfCW1KJxgJFbpOXu6/OPf4nqo/E57XQMz4QenaAibuUhn9
         osZ7Poig5rVqoukUsv9EvyS9rQjyYfS4y4gaY1c7yGrw5/1PMGIGN4UWyBeyiU88jiKo
         2vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751000203; x=1751605003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2HGv8LGZ8DzKrZFUO2v+eei1l2wUynW3XD4JObL1Tw=;
        b=jKDuGo/QMnPuI0ZObINmnWq5LnKwR4JVWRcehDxVjxZWAjGBSvgsq/+C7dG/rl8k2m
         LEwBV3qGGAbXDwP2OTR6gpeZACj2/7/OCZbHHHQqGyiNuP5LtuARsP32RM9RVJ2pD1hz
         PdjTUIc8V3HoFozoREzRbBVhLPdO3Fuqe4FO6mdlpgWJSbSCXhxNmZSHSaZMOdE5frSI
         rvhzN/o+jh02pB/fczVXhimTVwIUI1TQ3uVfzR+ciQ+UAZUPw/8qPCBJmIvHNHKq0EWA
         FN4DqV+6C73zOrHmt7OGKwKJD8D3bA3foCTSZLvKrmEZjPo6KCnzjemeaD2gatTzipir
         Ks7g==
X-Forwarded-Encrypted: i=1; AJvYcCUG8daHG8TPRwysqkCMShSwkAHlqF6c3RIb4E6G341gPsGQt/CMjhWzGIYH9DfoalLw3GxbbIQJUxgi@vger.kernel.org, AJvYcCVPPblp0g0PmdFB03nOqYaJ7UsYVERYTy1Q7e/GfsaVGT+x8QgAuVb3BrLgT9B95zUxgsZenuzj@vger.kernel.org, AJvYcCVi+znc5rg5zGZsBNJ4KGqy+yU1LyQfwyT2Ke5wTu4rygr3/wBd7YakMeMRJJGF1dsDOQv9pJFREyubkmhbaKr7B8s=@vger.kernel.org, AJvYcCX+aDL5K7ZC9rE32kn2aVSN48IHN+SMxtALDKDLQQJus2/LvX7ghrKV40br6qhN0IAJByQjUtek75EUs6G0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22Q52/M1oiU0SEeCre4vY/jUz6SFVShuj0jWKvNO0ArQJ3mld
	eJBlGvzmxAk7sh1HIYt1yLtmsPaFrFd1KQVAnzCjW3smY71w/xLz2f4dCs5cU8Ux3zvk/5VXXlV
	cXDz1Xznpf7GL6vPZHhyFU0j4hkZ5uvU=
X-Gm-Gg: ASbGnctEc/7me0VPEtAuSiGHoD96I5ZmoFj/PE/ZrX4aWBz0svbol4No2mLL8zRdpsF
	11mFyoy6MBUR0Qm7MSgYu7fqoY5/LSjYowP/U5FpQv9PLGRx6aUNC1JaY2kTgq7evT90++gkC8h
	jE4eHG6KIAjM89cm4eQSdRaR3RPCXk4/T1juFW1tHvfg==
X-Google-Smtp-Source: AGHT+IE+07qHBqPDCXthKdPHB/7LUX6RLsYmY1o5ORrW1h7tii2FCLcpiV2074k1N7ZSn36YN5VNYrTVJdSCyPltG5g=
X-Received: by 2002:a05:6102:442b:b0:4e7:b728:e34b with SMTP id
 ada2fe7eead31-4ee4f57ed09mr1865136137.3.1751000202837; Thu, 26 Jun 2025
 21:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-exynosdrm-decon-v3-0-5b456f88cfea@disroot.org> <20250627-exynosdrm-decon-v3-3-5b456f88cfea@disroot.org>
In-Reply-To: <20250627-exynosdrm-decon-v3-3-5b456f88cfea@disroot.org>
From: Inki Dae <daeinki@gmail.com>
Date: Fri, 27 Jun 2025 13:56:06 +0900
X-Gm-Features: Ac12FXyCRtmqlVxLH-ZQ8PS-fwNE9eVFG2Sf48qY_m8XFevvCiJLCVczBK1_h0o
Message-ID: <CAAQKjZNbEAiDC_2dUMKZHyPO4nS9TM7TrdjyNx0uLcjvh=PyZw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/exynos: exynos7_drm_decon: add vblank check in
 IRQ handling
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>, 
	Ajay Kumar <ajaykumar.rs@samsung.com>, Akshu Agrawal <akshua@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=EB=85=84 6=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 4:21, K=
austabh Chakraborty <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> If there's support for another console device (such as a TTY serial),
> the kernel occasionally panics during boot. The panic message and a
> relevant snippet of the call stack is as follows:
>
>   Unable to handle kernel NULL pointer dereference at virtual address 000=
000000000000
>   Call trace:
>     drm_crtc_handle_vblank+0x10/0x30 (P)
>     decon_irq_handler+0x88/0xb4
>     [...]
>

It seems that if the display is already enabled by the bootloader
during the boot process, a vblank interrupt may be triggered before
the initialization of drm_dev is complete. This could be the root
cause of the issue.

Applied.

Thanks,
Inki Dae

> Otherwise, the panics don't happen. This indicates that it's some sort
> of race condition.
>
> Add a check to validate if the drm device can handle vblanks before
> calling drm_crtc_handle_vblank() to avoid this.
>
> Cc: stable@vger.kernel.org
> Fixes: 96976c3d9aff ("drm/exynos: Add DECON driver")
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  drivers/gpu/drm/exynos/exynos7_drm_decon.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm=
/exynos/exynos7_drm_decon.c
> index 43bcbe2e2917df43d7c2d27a9771e892628dd682..c0c0f23169c993ac315fc8d7b=
cbd09ea6ec9966a 100644
> --- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> +++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
> @@ -636,6 +636,10 @@ static irqreturn_t decon_irq_handler(int irq, void *=
dev_id)
>         if (!ctx->drm_dev)
>                 goto out;
>
> +       /* check if crtc and vblank have been initialized properly */
> +       if (!drm_dev_has_vblank(ctx->drm_dev))
> +               goto out;
> +
>         if (!ctx->i80_if) {
>                 drm_crtc_handle_vblank(&ctx->crtc->base);
>
>
> --
> 2.49.0
>
>

