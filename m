Return-Path: <stable+bounces-95841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CDF9DECDF
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 22:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6653216379B
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4ED1A01BD;
	Fri, 29 Nov 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YdnVg9nC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C06155300
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915370; cv=none; b=kPEpLTTwW/kOrGaifexsEY94rkOseNg/pQROmUG6gHVb6vtWNLLfe7/qSp81/GdSB1LKywnzjbzo0WxqTL+h8rhLjeJb2UZZ5WWyjXGhroduPbEYiPXJQ01PXytHCwyDbbyjzn3cV1lmxaeTy6vcuB5leOH2KeCGj5MFSWTB9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915370; c=relaxed/simple;
	bh=80ZvND0vrv1LGQrThwq1XamSj43hNvKpegvZ/7CMUZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOxuJsk5aD9svlz2ZQnitTqMt2cFE6kW+2hlhXSvWjPXY9W3LgMY/BYO26D37w68JuK1A/KUbXUqI6Ui2NyBSJVT+JOr/6+Xq6WMx+Gim1j8DmpQQn/eWX2YWbcROqZyZZQLzCwHOnqWf0teY/Hw1meZIFHRd3dC35get4hKl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YdnVg9nC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724ffe64923so2379458b3a.2
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732915368; x=1733520168; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H4e3sx4dJc7nOwA8uivkLR2rCCckmz0cOxuXR8yppGM=;
        b=YdnVg9nC+vFampjvO9EK3/7uRhYOkSkeZgvMe1VUknOEIzXfIDIhyN7FRIrvOjCoN9
         Taxe0dvxpG9P9JCb/UnTaiikgzrLv8zNpRtmakVoryvVJ1cA6sTqB1k4AMejLrGoi4RF
         dYaFuSFRuTpCBLBRmkRzS2Tx/+0dgpIOOqJmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915368; x=1733520168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H4e3sx4dJc7nOwA8uivkLR2rCCckmz0cOxuXR8yppGM=;
        b=LmYafDQOG1u8OPWvsVnve0Oj2LZbagdECkveBthTV/LjVKopyIYcC5RTOLXtr+l99E
         G7SfTEjOK91o8jGPF7B7bXkhctW2v2udetriCoVdJQEMVRiB8zGQx7qlj/ONuIilSbyo
         ncvhf/vs24WeQr6/jPAUnWDkoiWL9PrKpS99XfC/J7NaUlaxS5KF6490nEStPivBcvDI
         lSv1YRfZGdfYkwvIyZF37CRGAC6yt/blw39J0WW2nyi0QM16Wzh8z/KQ+HGRwn2M4Ezv
         2C/YfJf3jlzSt39jU9Ke+CYgQ3aEhLhIg59j8310DKaCCUYLubYKcmJ0RN67VEdFKwlx
         QGag==
X-Forwarded-Encrypted: i=1; AJvYcCXz9WHMlpqCTW76WeSyGTEhwVBQkaKnjibom/MWuLzrM/yDJZMxIQS/4Eimdn9UV1nqqOGNjzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLrb6IVePGqUMaEvaXmFtHR+laFZy2+yPeZ37dqEq1TENN/XMK
	6hO3vpjQCDtS2lsTHTgHF6tCqBdSU3ZzgYHKkT/U5nvR8IRsmw96fDioctVMoOQ0Soe7tJvlII8
	=
X-Gm-Gg: ASbGnctpinkys6jsN5+d6mnYQ8Pqwc65vyuetkbUCo+jHBrDRKLDwdGwvF/pNAFJbMB
	Z+QwvH9dGsam3E1DKNTpGfZxWdvIF+vzF3ZVGiZAn3kmj9OKyEe1pBb5vroEcpejZ6jOhkTKVSM
	aaO5ujwzwFMQzusgf9osSjH9iqSx+nKBQ4mowa8H4vkLmK86MMsrXQjOOJoDvtRQfgiAbzeDy4o
	vx5S7tczHoQmcr+8XWERkpchD1NYs7g+dEm9r9aurRRUTKisWccgOklqa+mRKakZBuucAc9Eeas
	3h2nozrXqp3vwxIp
X-Google-Smtp-Source: AGHT+IGmdzP3PFiMxLsIEgj5ikmmv0ld2JaUAOOKPw9hvUmG1jZs/TiuPl51n3WE5S2mrC0CLifSVg==
X-Received: by 2002:a05:6a00:4fd1:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-72530045b1fmr17387270b3a.13.1732915367929;
        Fri, 29 Nov 2024 13:22:47 -0800 (PST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com. [209.85.210.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725442c086csm3801988b3a.189.2024.11.29.13.22.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 13:22:46 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724ffe64923so2379437b3a.2
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:22:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjF9ZbjqekD4tKjGTisTJjAAzOJz8OZ9B0C7pofoWp78ZBtJLZLiSERnIjmE3xcCgTotvBhX0=@vger.kernel.org
X-Received: by 2002:a17:90b:1d86:b0:2ee:7c02:8f08 with SMTP id
 98e67ed59e1d1-2ee7c029c75mr874584a91.37.1732915365753; Fri, 29 Nov 2024
 13:22:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-1-510aab9570dd@chromium.org> <20241128221649.GE25731@pendragon.ideasonboard.com>
In-Reply-To: <20241128221649.GE25731@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 22:22:33 +0100
X-Gmail-Original-Message-ID: <CANiDSCv3xtV-AN1P_d+gPog8OJ9gBD9iD_AWi78s8oNJKzRuBg@mail.gmail.com>
Message-ID: <CANiDSCv3xtV-AN1P_d+gPog8OJ9gBD9iD_AWi78s8oNJKzRuBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 23:17, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Nov 27, 2024 at 12:14:49PM +0000, Ricardo Ribalda wrote:
> > When an async control is written, we copy a pointer to the file handle
> > that started the operation. That pointer will be used when the device is
> > done. Which could be anytime in the future.
> >
> > If the user closes that file descriptor, its structure will be freed,
> > and there will be one dangling pointer per pending async control, that
> > the driver will try to use.
> >
> > Clean all the dangling pointers during release().
> >
> > To avoid adding a performance penalty in the most common case (no async
> > operation). A counter has been introduced with some logic to make sure
>
> s/). A/), a/
>
> > that it is properly handled.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 38 ++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> >  drivers/media/usb/uvc/uvcvideo.h |  8 +++++++-
> >  3 files changed, 45 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 4fe26e82e3d1..b6af4ff92cbd 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>
> How about adding
>
> static void uvc_ctrl_set_handle(struct uvc_control *ctrl, uvc_fh *handle)
> {
>         if (handle) {
>                 if (!ctrl->handle)
>                         handle->pending_async_ctrls++;
>                 ctrl->handle = handle;
>         } else if (ctrl->handle) {
>                 ctrl->handle = NULL;
>                 if (!WARN_ON(!handle->pending_async_ctrls))
>                         handle->pending_async_ctrls--;

handle is NULL here. Luckily smatch found it :)

I am rewriting it a bit.



>         }
> }
>
> >       mutex_lock(&chain->ctrl_mutex);
> >
> >       handle = ctrl->handle;
> > -     ctrl->handle = NULL;
> > +     if (handle) {
> > +             ctrl->handle = NULL;
> > +             WARN_ON(!handle->pending_async_ctrls);
> > +             if (handle->pending_async_ctrls)
> > +                     handle->pending_async_ctrls--;
> > +     }
>
> This would become
>
>         handle = ctrl->handle;
>         uvc_ctrl_set_handle(ctrl, NULL);
>
> >
> >       list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> >               s32 value = __uvc_ctrl_get_value(mapping, data);
> > @@ -2046,8 +2051,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >       mapping->set(mapping, value,
> >               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> >
> > -     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > +     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> > +             if (!ctrl->handle)
> > +                     handle->pending_async_ctrls++;
> >               ctrl->handle = handle;
> > +     }
>
> Here
>
>         if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
>                 uvc_ctrl_set_handle(ctrl, handle);
>
> >
> >       ctrl->dirty = 1;
> >       ctrl->modified = 1;
> > @@ -2770,6 +2778,32 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
> >       return 0;
> >  }
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> > +{
> > +     struct uvc_entity *entity;
> > +
> > +     guard(mutex)(&handle->chain->ctrl_mutex);
> > +
> > +     if (!handle->pending_async_ctrls)
> > +             return;
> > +
> > +     list_for_each_entry(entity, &handle->chain->dev->entities, list) {
> > +             for (unsigned int i = 0; i < entity->ncontrols; ++i) {
> > +                     struct uvc_control *ctrl = &entity->controls[i];
> > +
> > +                     if (ctrl->handle != handle)
> > +                             continue;
> > +
> > +                     ctrl->handle = NULL;
> > +                     if (WARN_ON(!handle->pending_async_ctrls))
> > +                             continue;
> > +                     handle->pending_async_ctrls--;
>
> And here
>
>                         uvc_ctrl_set_handle(ctrl, NULL);
>
> It seems less error-prone to centralize the logic. I'd add a
> lockdep_assert() in uvc_ctrl_set_handle(), but there's no easy access to
> the chain there.
>
> > +             }
> > +     }
> > +
> > +     WARN_ON(handle->pending_async_ctrls);
> > +}
> > +
> >  /*
> >   * Cleanup device controls.
> >   */
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 97c5407f6603..b425306a3b8c 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -652,6 +652,8 @@ static int uvc_v4l2_release(struct file *file)
> >
> >       uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> >
> > +     uvc_ctrl_cleanup_fh(handle);
> > +
> >       /* Only free resources if this is a privileged handle. */
> >       if (uvc_has_privileges(handle))
> >               uvc_queue_release(&stream->queue);
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 07f9921d83f2..c68659b70221 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -337,7 +337,10 @@ struct uvc_video_chain {
> >       struct uvc_entity *processing;          /* Processing unit */
> >       struct uvc_entity *selector;            /* Selector unit */
> >
> > -     struct mutex ctrl_mutex;                /* Protects ctrl.info */
> > +     struct mutex ctrl_mutex;                /*
> > +                                              * Protects ctrl.info and
> > +                                              * uvc_fh.pending_async_ctrls
> > +                                              */
> >
> >       struct v4l2_prio_state prio;            /* V4L2 priority state */
> >       u32 caps;                               /* V4L2 chain-wide caps */
> > @@ -612,6 +615,7 @@ struct uvc_fh {
> >       struct uvc_video_chain *chain;
> >       struct uvc_streaming *stream;
> >       enum uvc_handle_state state;
> > +     unsigned int pending_async_ctrls;
> >  };
> >
> >  struct uvc_driver {
> > @@ -797,6 +801,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >                     struct uvc_xu_control_query *xqry);
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> > +
> >  /* Utility functions */
> >  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
> >                                           u8 epaddr);
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

