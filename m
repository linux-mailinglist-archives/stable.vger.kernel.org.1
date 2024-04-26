Return-Path: <stable+bounces-41499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339B68B3230
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 10:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F7F281F11
	for <lists+stable@lfdr.de>; Fri, 26 Apr 2024 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E33F13C9B0;
	Fri, 26 Apr 2024 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UAx6Ppw6"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF813C9A0
	for <stable@vger.kernel.org>; Fri, 26 Apr 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714119660; cv=none; b=MjVDNUlMsxcdxsr+IUU1aiF60LOQu6S+XtqSG4+mCpYskfPBJ3xnfiOlcqhcVNgzZ47dsDSH3UoH5nAP7YANvh52/ZDeYFk2STaPbh+uhjgN/oGgW/65g3tL3KlFC3M7c123W0UdEN5G7mLRiKD4vB3lkcqn/adFOqhleLVrcCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714119660; c=relaxed/simple;
	bh=2QwY/idrWWstb2VS57g5qy6TKTu8YrTelcs1NllY2gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N//KBj/5egqjgxB8EtatLHycyPB3C57u2XoS37AAZAsryvVn8Etz/xvc7OkesGCPUBwwsqdQbe/5HvlM/v9pkmpFlSfrSxWsUVsZoGhE0vB5HXRZVxhb9h8HnWRe5GscFMS3C8Yz8C08lXERtpPPbEdQKEKFBMPtUtgpFACnUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UAx6Ppw6; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7da68b46b0dso76666239f.1
        for <stable@vger.kernel.org>; Fri, 26 Apr 2024 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714119658; x=1714724458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOO+Oxe5RqdUN11iHoDt4ydzdK+8AI7NsGcbenw3d/A=;
        b=UAx6Ppw6A4wbEg9mFet1cI+rY5Tkj7+1UuOPcHdJWHNQR/sdpDoU0fy0F8Y24/QO6T
         siItHpR3P6Zt7A49GVrqLiJ1UorbTJNshGX86IGrwEKO5olBKed3/+vr6sm1KBLIgxZ+
         DFs4/V7An5HuM0NI75thEJSwWYnltF0liD+yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714119658; x=1714724458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOO+Oxe5RqdUN11iHoDt4ydzdK+8AI7NsGcbenw3d/A=;
        b=GUY9k98s+jcnDR5EDXBQuqhdT6W2HqH8ZmvbdvhAuwz9uiLXca8Hdc35UthlLYgexc
         yXCH6P22x6hso6NfJ2CLMybOtkLd2XHFrIYx2RxOw7cY1hlWXAMoRpDaG3j+c65PGHas
         /6aglYVxtdEn1AkzL5elHE2ZsBRmOm0AKYstngyiAnkwZhB6WF13Za2Ewtgra5h8m3tw
         CUHRt2RFj5hC8h8ugRgKjD5ifrirVaGDeO4HWT3kTxeIK0VTFcpAiWX9TcFEOW6RpF6H
         h6N9FXPJOmixmB99gKVarAqiRe2ekHP8GpyTtsj+6tZVSZehOX9ltKe2VLLWRCXKdazr
         5d6A==
X-Forwarded-Encrypted: i=1; AJvYcCV2AJ+p/3+AQ2a2pGzBYCKC8Bn7aMaiU6egz0uYkknZVkaYT5Zj6minb3QpxccVFgvYC3Nu9W8Vs+HxtQsvesYg4NeSrw6Z
X-Gm-Message-State: AOJu0Yw4bB3n9ll8r7P6MWD2B68XryTy3jvAv6xw3VRtdOQTwrTkPdwG
	Wg37zpEp8+NTm+twZPsfKTJeBUZNKyvqFivobq38VZQep52GIYspcmNd3Av6cvDK10Awp/Dg+2L
	Tl3eEl+ZsDdz1r3TX9LtrPCZA5ndazV0D7DMb
X-Google-Smtp-Source: AGHT+IGpFrMmIiUOGeU8GqDVHvij5e/EHFi3eql6VH19ZiFzL8S3bxOTPVDJXE8//vqh4sKVAKaAYPJDw3yidMK+gL8=
X-Received: by 2002:a05:6602:f11:b0:7de:9c6b:79de with SMTP id
 hl17-20020a0566020f1100b007de9c6b79demr2387497iob.14.1714119658470; Fri, 26
 Apr 2024 01:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425192748.1761522-1-zack.rusin@broadcom.com>
In-Reply-To: <20240425192748.1761522-1-zack.rusin@broadcom.com>
From: Martin Krastev <martin.krastev@broadcom.com>
Date: Fri, 26 Apr 2024 11:20:47 +0300
Message-ID: <CAKLwHdVZSRtnCe_=pTw0kUaTEvCRKqypcq-u2f50o=xRQCrASA@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: Fix invalid reads in fence signaled events
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, ian.forbes@broadcom.com, 
	maaz.mombasawala@broadcom.com, zdi-disclosures@trendmicro.com, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM!

Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>

Regards,
Martin

On Thu, Apr 25, 2024 at 10:27=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
>
> Correctly set the length of the drm_event to the size of the structure
> that's actually used.
>
> The length of the drm_event was set to the parent structure instead of
> to the drm_vmw_event_fence which is supposed to be read. drm_read
> uses the length parameter to copy the event to the user space thus
> resuling in oob reads.
>
> Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> Fixes: 8b7de6aa8468 ("vmwgfx: Rework fence event action")
> Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-23566
> Cc: David Airlie <airlied@gmail.com>
> CC: Daniel Vetter <daniel@ffwll.ch>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadc=
om.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> Cc: <stable@vger.kernel.org> # v3.4+
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_fence.c
> index 2a0cda324703..5efc6a766f64 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
> @@ -991,7 +991,7 @@ static int vmw_event_fence_action_create(struct drm_f=
ile *file_priv,
>         }
>
>         event->event.base.type =3D DRM_VMW_EVENT_FENCE_SIGNALED;
> -       event->event.base.length =3D sizeof(*event);
> +       event->event.base.length =3D sizeof(event->event);
>         event->event.user_data =3D user_data;
>
>         ret =3D drm_event_reserve_init(dev, file_priv, &event->base, &eve=
nt->event.base);
> --
> 2.40.1
>

