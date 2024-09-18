Return-Path: <stable+bounces-76653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E91297BA72
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 11:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934D11C222B1
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 09:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09017ADF9;
	Wed, 18 Sep 2024 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="pWjsrlsV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E844175D2E
	for <stable@vger.kernel.org>; Wed, 18 Sep 2024 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726653437; cv=none; b=GJhnEUL/zbm4UZXgC1Mg/E7QetUF7AxS6s4t3GPtJ730NZ6QtOKpR1qDWYvcSByM5LMTUp40pbyxvTp9bj+d7jGVGeRj055tmv1VEtbzByRyu8QHkxsffiSAbCkJXQZYsHs4t3T0dTxyyCl41RkubUnnRo1SqD1RNToJVZvxjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726653437; c=relaxed/simple;
	bh=aEqJqQ0vfTH55PbtK6DICNgoEj/MVMbz7QyQlBQBPKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozxjSGa1yAO43RWw1N1qD4Dv3YEDfAo1WeFwuhErQNY1O54S78rNIMXZJbB8YzUTFmU2s9Vqc2TjivAfhd0Rh3WSrjDfEOefjxD7tzUUYGyyxKC2zpG5t8MT7Se02HUWJXJ+rjlg8U8faBbXvfnORF5/kSbfcVTKQhJlEay/JiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=pWjsrlsV; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso5624137276.1
        for <stable@vger.kernel.org>; Wed, 18 Sep 2024 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1726653434; x=1727258234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIx4pdRT/KSGss++ze3hxTvzw9zHVXZXZfsOwRj2D3Y=;
        b=pWjsrlsVcXWVVoMWDu4OlsK82ij14Xjz6KR6kLzYE6CLGE480rv+DvQd6Iqf7L29KC
         28gjeaPgHSSXn6WPpuH7ZDuYCZkbK1dUkTe6e8CgR3OmrtwBILqRPdfHOnckchevvyOc
         p+s/3nx5B2QTIowzNX4OuUX0S/D4KVt3jU/3LFJ8wJs0BeANr65l8EsmqKHRgf4xWSw7
         WbnoYQZoDcVlcsaWl9tkyBcoZUFcI8O2l434GqknSfKHUg2Cj8MFjiTALahIQt4VMAJO
         3/bigMpUNakJVJFU2arqJ28ZHCb8oy68gPcBlF/uvzFGenAoeQJtJtXKGVaORVQ95fqH
         57cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726653434; x=1727258234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIx4pdRT/KSGss++ze3hxTvzw9zHVXZXZfsOwRj2D3Y=;
        b=pUTy1bl7NDbO2cJ8ayB4GTAbe0ZLcnF+hk9EDEPtzDn/xJO0awUJlsSECO5U/QOg2G
         OGvAXOfwBec6suSA/5K+7XRxRbvs1kUnKB3plogP7kk/1pMzA6qCOqFfOgWvEveoMLnX
         /pjAVKrxzm5KIDPcaL0JJXPD6wgbEtjbEDMua0L4VXfJsPfYI31shSfnVA9RCfFsscU6
         OCzZd14eabDz15Yh0lZMqniTbaDE0H3gO40diTAB4AoL9wnz3B/jCpVZEitl820R10I0
         LCTzVW3rSccGBwN4sjhEr4ljHbfljUOYNCJ9SPAEuyYqCThiDIK/Vo/qoMSkt/dh3/8b
         PrBA==
X-Forwarded-Encrypted: i=1; AJvYcCXVk9NoJ1K2m646/rAzQjAQsjSFbnxCpV8k9eM3s6qPYIKvR2AdgCoyACbkErrd1ICR3gC9KBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHU8rWylsTRy0FeSITUpa7uY18Csxnp3TC6NvpB/ecs8Skm7vK
	XUqOtss2MNe1IjWYXdNtth+fEUTYlpYMu0zEJ+6FPKJx8103eE5uI0r4Fld3EvIzMhDWCMk+/Bi
	6h1BCAn27hGeNON4EuIaGuqsia1NQ1NxDRODsdw==
X-Google-Smtp-Source: AGHT+IHKpu7IV4bd4CPt8Iw9ri5vOZYDoXO50FkG8TLq2+PTVeUoLayDJEH63zGUtyeaY5AvRD4j8/cMEDxNpzcidho=
X-Received: by 2002:a05:6902:200c:b0:e0e:cd17:610a with SMTP id
 3f1490d57ef6-e1d9db98c4fmr19075343276.6.1726653434435; Wed, 18 Sep 2024
 02:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913083504.10549-1-chenqiuji666@gmail.com>
In-Reply-To: <20240913083504.10549-1-chenqiuji666@gmail.com>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Wed, 18 Sep 2024 11:57:03 +0200
Message-ID: <CADGDV=Vhx79JmTSzSJ+KN_236vKD0mZD6u3_23WRmte2wXW3fg@mail.gmail.com>
Subject: Re: [PATCH] drbd: Fix atomicity violation in drbd_uuid_set_bm()
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, 
	axboe@kernel.dk, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Qiu-ji Chen,

The code change looks okay to me.

Reviewed-by: Philipp Reisner <philipp.reisner@linbit.com>

On Fri, Sep 13, 2024 at 10:35=E2=80=AFAM Qiu-ji Chen <chenqiuji666@gmail.co=
m> wrote:
>
> The violation of atomicity occurs when the drbd_uuid_set_bm function is
> executed simultaneously with modifying the value of
> device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
> device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
> is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
> zero. In this case, the check in drbd_uuid_set_bm might refer to the old
> value of device->ldev->md.uuid[UI_BITMAP] (before locking), which allows
> an invalid value to pass the validity check, resulting in inconsistency.
>
> To address this issue, it is recommended to include the data validity che=
ck
> within the locked section of the function. This modification ensures that
> the value of device->ldev->md.uuid[UI_BITMAP] does not change during the
> validation process, thereby maintaining its integrity.
>
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency bug=
s
> including data races and atomicity violations.
>
> Fixes: 9f2247bb9b75 ("drbd: Protect accesses to the uuid set with a spinl=
ock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
> ---
>  drivers/block/drbd/drbd_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_mai=
n.c
> index a9e49b212341..abafc4edf9ed 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -3399,10 +3399,12 @@ void drbd_uuid_new_current(struct drbd_device *de=
vice) __must_hold(local)
>  void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(l=
ocal)
>  {
>         unsigned long flags;
> -       if (device->ldev->md.uuid[UI_BITMAP] =3D=3D 0 && val =3D=3D 0)
> +       spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
> +       if (device->ldev->md.uuid[UI_BITMAP] =3D=3D 0 && val =3D=3D 0) {
> +               spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags=
);
>                 return;
> +       }
>
> -       spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
>         if (val =3D=3D 0) {
>                 drbd_uuid_move_history(device);
>                 device->ldev->md.uuid[UI_HISTORY_START] =3D device->ldev-=
>md.uuid[UI_BITMAP];
> --
> 2.34.1
>

