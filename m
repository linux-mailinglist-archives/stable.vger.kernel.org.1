Return-Path: <stable+bounces-91901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAE9C16FF
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 08:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8404B22005
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32201D0E35;
	Fri,  8 Nov 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X0vfjyDu"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0131F5FA
	for <stable@vger.kernel.org>; Fri,  8 Nov 2024 07:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731050639; cv=none; b=WKuBbbb0kqZUJgrTOJ27xTE2G9e1mugRchGMXaBpk7/UYaOdLKBolpUYbzMGuaFhcKM/UVTphs8kpnit0ZSYrMhF4it2Q+Zhji1W4DyUwY5Bpzk3UvbO5+IKMLzo1UiD7WfNqa88piXyhl4k0DANx79V/yOi7F+x3Aw4Ike6UWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731050639; c=relaxed/simple;
	bh=ht9l2ZSUWXc5h2NR9cMi0Gb1yeSAariDbq8iV0J2AZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSzhRjKQCCQUiiEQwBXTxsh70uQaFrgkpK9dRLr9BxCJOWydM2lQLo9a/v/2Oy80bwOoj/FHvdDzD5k+Jo36FG3TiJnHEfDdLdVG6kqcxuvG8laZwLPmUOE/xA8FpkICgMZoU3+tmMxs5YMUYJEwFluuSqZet6AtbgIBDWLZ05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X0vfjyDu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4e481692so1685569b3a.1
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 23:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731050637; x=1731655437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZsX92SEPfX9pZYxHimQ3VDSrQrPgT/IDDI/YMUQaqAk=;
        b=X0vfjyDud8Rwh5WNQDmp4PZLXdsdf0D4LuLO4yDVC/My47bsDeLaGSdGxTRSG07Dms
         sXAX3mYGajdv2mZW5A5k8gD1RZgc743lNeDVCFfrNuGt288LbjRksxMzZSPfz+tJA61a
         ikLJLyrPhQurO1P4Z/EqHIdzteCs8Z/KswGbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731050637; x=1731655437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZsX92SEPfX9pZYxHimQ3VDSrQrPgT/IDDI/YMUQaqAk=;
        b=QaVSPZdfr9l5oNCkr0qM3hTtrkTetTbv7shWbbiO/bq2ilbG1xuMCkmFBshK0b7ZQs
         PFmcfzyenYBkDuQMZL1HzFMvZRoyFwL+KaIa+MtNmZI7dlpQJHy3xQEvnErzmfO7XbeT
         MNjaI6k3/p7zJ9WE9DJq7uZ1bBGVG0qNIntj3ETlK2bLljb7GpDIIGvEJIuetu84wWWC
         Qrp2Ii8XIziu+xCf0tgj1/s98X7H0jysQh7eywW62BBs5DUQCZFqEgetL+oZjvxL7u1F
         a62kasVUYxwsrvdhWZAvfHzVa7RSB+AqV5QSAswwbXJZQ+Y1p3+QSx4n0Z+r9LMeGGIG
         h8og==
X-Forwarded-Encrypted: i=1; AJvYcCVC3N+d7rsgZJX+osoWrrCFDAj2NlPdoJvCkz9zju9YH6fD3XEfmmcKMjRwfKmiakazY20lTxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8Vmn/iR6fJiIkCcCD+DdA0XNgdWwJZJbSXwDd+BCg8oywJnG
	W7D7wlyMkC/ui6wx+suLGLneU0FnTvy/bjp8ohgnOjSWe0dfGR7fhXqGL+FlTlQV+Ds/pcFrNhg
	=
X-Google-Smtp-Source: AGHT+IEevya9vfzb7PjGi5XZUsQP20UBXN6RCLf/34zBQ2fRmL/XIC6m5+JeZJRKNknAcfaXSLFyiQ==
X-Received: by 2002:a05:6a00:2d9c:b0:71d:fe19:83ee with SMTP id d2e1a72fcca58-724132a62f4mr2795056b3a.10.1731050637060;
        Thu, 07 Nov 2024 23:23:57 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a3d29sm3075703b3a.123.2024.11.07.23.23.55
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 23:23:56 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso1459341a91.3
        for <stable@vger.kernel.org>; Thu, 07 Nov 2024 23:23:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXfdQgd9gc9MDyFPdRGyIXgdVIELmksnR0H3xI9t8ziqv8KTFmrAsXZtwyzPXoCAdGmzl22FB8=@vger.kernel.org
X-Received: by 2002:a17:90b:3847:b0:2e2:e159:8f7b with SMTP id
 98e67ed59e1d1-2e9b16e6415mr2416277a91.3.1731050635305; Thu, 07 Nov 2024
 23:23:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107235130.31372-1-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20241107235130.31372-1-laurent.pinchart@ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 8 Nov 2024 08:23:43 +0100
X-Gmail-Original-Message-ID: <CANiDSCtUR16eJUOaiQ7VatAk5rTy4WMmxUmtCZv=0mUxSES_kQ@mail.gmail.com>
Message-ID: <CANiDSCtUR16eJUOaiQ7VatAk5rTy4WMmxUmtCZv=0mUxSES_kQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix double free in error path
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 00:51, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> If the uvc_status_init() function fails to allocate the int_urb, it will
> free the dev->status pointer but doesn't reset the pointer to NULL. This
> results in the kfree() call in uvc_status_cleanup() trying to
> double-free the memory. Fix it by resetting the dev->status pointer to
> NULL after freeing it.
>
> Fixes: a31a4055473b ("V4L/DVB:usbvideo:don't use part of buffer for USB transfer #4")
> Cc: stable@vger.kernel.org
Reviewed by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/usb/uvc/uvc_status.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index 02c90acf6964..d269d163b579 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -269,6 +269,7 @@ int uvc_status_init(struct uvc_device *dev)
>         dev->int_urb = usb_alloc_urb(0, GFP_KERNEL);
>         if (!dev->int_urb) {
>                 kfree(dev->status);
> +               dev->status = NULL;
>                 return -ENOMEM;
>         }
>
>
> base-commit: ed61c59139509f76d3592683c90dc3fdc6e23cd6
> --
> Regards,
>
> Laurent Pinchart
>


-- 
Ricardo Ribalda

