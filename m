Return-Path: <stable+bounces-158973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A311AEE222
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC901726EC
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC5028D8CF;
	Mon, 30 Jun 2025 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a4o9yTwb"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F128C014
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751296557; cv=none; b=P+AM0rjuu4cj7+j3dCX4jJ+BHg12owHZaneidB4e2QT2QS7oD6gOI1zUy/FfHX0QPoO8nKPpcKCA+lEwJgVzxLYK55RhuUatfoYoEUCZ9eZU3guCu9aoL4c4yj2IlgMkIbTUrUz4Lm3erTQiEOPzTu7+ejlnhxDVjpd11r97rEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751296557; c=relaxed/simple;
	bh=qUjuLTmNcbaEXQsGgwDbeTL7U1+S0S4WiD49WjSD3hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvGj228UXvv0mosGCsdwHP/6tqRyRGZEV/PrHTwv0czGQLcAjnD3v7eRylOAB/yAf+mAvxB+9fppjnhZc7Nxpq2B0vNb5Wku7rNUF5/RS5AqjUN+aAbwHGoCwzNjfnLQ80r85GQAkR9Z2eOI46ZfS7tIfxJXlu7dL2tTnfyDJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a4o9yTwb; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-555024588a8so2301191e87.0
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751296553; x=1751901353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1AOLwFTOE5XzMvxlxFognU3FkvdviGhVUSRhoNGQGM=;
        b=a4o9yTwbjw/bm8Kx8RyJAD4oIxxveHQ7YiiMEO16uOk3A37C63lU4l4rxH126fG1IS
         q6dK0fHxizluJARSwuHiBIvMVuzEec3gjkG49vFEWTCTuU9/xRweVSA47hUvEFYWbnhO
         4EpIyDlNxsmxFkMyMEdWfZT/zvQ2/qHoI3K0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751296553; x=1751901353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1AOLwFTOE5XzMvxlxFognU3FkvdviGhVUSRhoNGQGM=;
        b=HOOcKhQrEfsEYdbMF8mbNtsnRhlh3fMTTLyK1h5UnvEWqO2Gqvm2PpIAE5GeqSro+U
         lrrqA+3jbZOCxe1kooVNp6SbJa/cIgJvOTiNsBNZqm8KDDA4MbdraD0+mvWn+GL1MAjR
         y55fizbCKUzxQ+60yOcCCGQtu0XKKKsl+Bn1txrwjzScWS6fEp5mbucXwDndPcnsRq3K
         +0UA/4QgreTlMZzYrn9G1o4HLzB49Trpnmywzyo2zT5EFp86QU6aXLEUjUOzXn/Wk+EA
         iMNW6E/Poric8Nxtpk6OfFBwBGKqXBzj8zhATBzWFiHrLB6M513D+DxQF4ggquF9iZG1
         kmeg==
X-Forwarded-Encrypted: i=1; AJvYcCXlIhiDVqVOHdWera+E7UZ3M3g6FwokOrk2hKSp509icUagELiOcHOM4B1xl8HM4sZKDJPclJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfJuOB6UZuORZwqUncms7ruftiRAkxe9qscLo18pnpzFHwmkk
	RCfVBaPdv9QBByq3vyB3wKZZRluYUK1EmmZDzo1n/y2lCtCeQ4jCeU6h3ObQ/fxEqAfEVBlU/xl
	qwxeQIg==
X-Gm-Gg: ASbGncuxqkCmMOG6jfDXYI1av0eRhrhlPppQoQs18fI3KExsXBfKNDmQ3KEvOseEFXu
	W8wjEG5oULrUcw0dMpLaPjK/W+3f/lsQFk0aqEejjUUV1NjV3MRubDzlIXXlci1qQ9fa3UHq807
	cadE6BIMcG6XkwBBd6tv89s6uaWcirgaH+bdU5M26wUUbr+PRBOCiiRPcTsebUpZTgOmJTxeX2n
	kL71pApMU+DOpU5dL76HVhzOtXGcYTbwI2jDA3QZgQPBDC6E9/eQcaeLViV/KlmFG419EQH2KsV
	xqdPxtyhn4JiCPiUNEIq8w5ykOA2j3o0U99BOJLFKKmMMabGrdsdjgG6BptVUXbnq/5Et/HS6DS
	gnYDFUC+qcyuUzqFxb8pTcdd7
X-Google-Smtp-Source: AGHT+IEn/YZ6qtwLFLGlEF8WMksz8l2CHPTabrRm6PLsszmNAZDynRkgrzcaQ4OZ1pcO6xONMKpW1g==
X-Received: by 2002:a05:6512:ac1:b0:553:350a:32d9 with SMTP id 2adb3069b0e04-5550b890e86mr4317466e87.23.1751296553133;
        Mon, 30 Jun 2025 08:15:53 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2cddd0sm1451829e87.162.2025.06.30.08.15.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 08:15:52 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b10594812so2616730e87.1
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 08:15:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmAAjWvea8gdiCyS1zOjFOSQ92VmmDAq1i+jf+GZQpVbK7AeKaNypa+j3ORfYfRIO8Axb/Jlk=@vger.kernel.org
X-Received: by 2002:a05:6512:3d1d:b0:553:2f8c:e631 with SMTP id
 2adb3069b0e04-5550b860cc9mr4540604e87.9.1751296552162; Mon, 30 Jun 2025
 08:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630150107.23421-1-desnesn@redhat.com>
In-Reply-To: <20250630150107.23421-1-desnesn@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 30 Jun 2025 17:15:38 +0200
X-Gmail-Original-Message-ID: <CANiDSCu83Ky-604gu2Yt34Wj1Km6Xh+TcPYzQxKZJNWdT7=m8A@mail.gmail.com>
X-Gm-Features: Ac12FXygYZhncua2VSpYRf_F0i2gDNxE8CXtvpMAoS-xI7uTpLX06TMihRMBcX8
Message-ID: <CANiDSCu83Ky-604gu2Yt34Wj1Km6Xh+TcPYzQxKZJNWdT7=m8A@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: fix build error in uvc_ctrl_cleanup_fh
To: Desnes Nunes <desnesn@redhat.com>
Cc: laurent.pinchart@ideasonboard.com, hansg@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Desdes

How did you trigger this build warning? I believe we use C11

https://www.kernel.org/doc/html/latest/process/programming-language.html


Regards!

On Mon, 30 Jun 2025 at 17:07, Desnes Nunes <desnesn@redhat.com> wrote:
>
> This fixes the following compilation failure: "error: =E2=80=98for=E2=80=
=99 loop
> initial declarations are only allowed in C99 or C11 mode"
>
> Cc: stable@vger.kernel.org
> Fixes: 221cd51efe45 ("media: uvcvideo: Remove dangling pointers")
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc=
_ctrl.c
> index 44b6513c5264..532615d8484b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -3260,7 +3260,7 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
>  void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
>  {
>         struct uvc_entity *entity;
> -       int i;
> +       unsigned int i;
>
>         guard(mutex)(&handle->chain->ctrl_mutex);
>
> @@ -3268,7 +3268,7 @@ void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
>                 return;
>
>         list_for_each_entry(entity, &handle->chain->dev->entities, list) =
{
> -               for (unsigned int i =3D 0; i < entity->ncontrols; ++i) {
> +               for (i =3D 0; i < entity->ncontrols; ++i) {
>                         if (entity->controls[i].handle !=3D handle)
>                                 continue;
>                         uvc_ctrl_set_handle(handle, &entity->controls[i],=
 NULL);
> --
> 2.49.0
>
>


--=20
Ricardo Ribalda

