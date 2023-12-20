Return-Path: <stable+bounces-7972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE7819E9D
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 13:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428961C225FE
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41521A17;
	Wed, 20 Dec 2023 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LRWtDitc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B8C249EC
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703073845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOIBv5aCgCzFx82SAqfImjdfdj7hcvw8IGRj+pX8Llk=;
	b=LRWtDitc/lX6vKx1b6VHBPISlwW9ZMVLRoROUFfBFKWi2SLmP2buBBKhBMexETQStaevf2
	6xu8PkAdVyOmBkm6RWYssqW7fId0OVAT5Tor8O2ecIJVA2bzE0kPsJNnbFuagCpZ6X7I0+
	dkFa15sjpre1h2TgVecMIyWrx7WQXQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-fHW-9mC-OnyFEX8EbF8M7g-1; Wed, 20 Dec 2023 07:04:04 -0500
X-MC-Unique: fHW-9mC-OnyFEX8EbF8M7g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d2a286757so3312575e9.1
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 04:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073843; x=1703678643;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOIBv5aCgCzFx82SAqfImjdfdj7hcvw8IGRj+pX8Llk=;
        b=IOmYu7u/Rpynnjno26PIr1mwTwJsLDwnz9KlvH+6E2yZurt1RfhmhgvWHjfFnM3CCR
         iCVOtmrnhpCG+w2hOSaZjYFs3E9u8CKuk0F32Ru8wxzWXbfjJtQTUeXvx7WECNsbgBS4
         7OBSrjxyVOHRZbR801sdZV3ip19n/290jj7Xkmxy1Y3wl8aTVL2weeiOOY5nGsnSCHZY
         ZYdtk7egwp9n1OlsKVBTm+AM1LZwfXncVj7Y4tf6sM47PMApfto9T3bdzIB+2rayAdR4
         9HJDwK2HWql3VO0jkhtJfbfgxXROY3b9PpdPAokHxprUcqZbctv2ngtQApPeEaBD1sxU
         Ys4g==
X-Gm-Message-State: AOJu0Yz3gWhX6/kAtLMEGgYGmtjtEEA9GWvMKFBcqLjmmAo3fYR4d+wC
	B1L53mQNobLOlGeQsLXF8zjbtOc3fMd/sc4V1s5NquruLfFV5Bo2QcottqTho69xTXZjiDN4Q7C
	8CW0WGOFNnrwRM06i
X-Received: by 2002:a05:600c:4e4f:b0:40d:3773:36f0 with SMTP id e15-20020a05600c4e4f00b0040d377336f0mr475080wmq.87.1703073843111;
        Wed, 20 Dec 2023 04:04:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbZC41p9v3kAdf252seL2X9D2BEjOUjveeox/+jZ4LdlgSM8+7oshKXYQu/k1Umxzj3KQqVA==
X-Received: by 2002:a05:600c:4e4f:b0:40d:3773:36f0 with SMTP id e15-20020a05600c4e4f00b0040d377336f0mr475069wmq.87.1703073842683;
        Wed, 20 Dec 2023 04:04:02 -0800 (PST)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c6dd9e7aesm7122634wmo.34.2023.12.20.04.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 04:04:02 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: Don't unref the same fb many times by mistake
 due to deadlock handling
In-Reply-To: <20231211081625.25704-1-ville.syrjala@linux.intel.com>
References: <20231211081625.25704-1-ville.syrjala@linux.intel.com>
Date: Wed, 20 Dec 2023 13:04:01 +0100
Message-ID: <87cyv15bda.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ville Syrjala <ville.syrjala@linux.intel.com> writes:

Hello Ville,

> From: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>
> If we get a deadlock after the fb lookup in drm_mode_page_flip_ioctl()
> we proceed to unref the fb and then retry the whole thing from the top.
> But we forget to reset the fb pointer back to NULL, and so if we then
> get another error during the retry, before the fb lookup, we proceed
> the unref the same fb again without having gotten another reference.
> The end result is that the fb will (eventually) end up being freed
> while it's still in use.
>
> Reset fb to NULL once we've unreffed it to avoid doing it again
> until we've done another fb lookup.
>
> This turned out to be pretty easy to hit on a DG2 when doing async
> flips (and CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy). The first symptom I
> saw that drm_closefb() simply got stuck in a busy loop while walking
> the framebuffer list. Fortunately I was able to convince it to oops
> instead, and from there it was easier to track down the culprit.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

>  drivers/gpu/drm/drm_plane.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> index 9e8e4c60983d..672c655c7a8e 100644
> --- a/drivers/gpu/drm/drm_plane.c
> +++ b/drivers/gpu/drm/drm_plane.c
> @@ -1503,6 +1503,7 @@ int drm_mode_page_flip_ioctl(struct drm_device *dev,
>  out:
>  	if (fb)
>  		drm_framebuffer_put(fb);
> +	fb =3D NULL;
>  	if (plane->old_fb)
>  		drm_framebuffer_put(plane->old_fb);
>  	plane->old_fb =3D NULL;

Interesting that it was done correctly for old_fb.

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


