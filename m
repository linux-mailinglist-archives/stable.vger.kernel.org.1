Return-Path: <stable+bounces-95767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47A9DBE39
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 01:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D134FB225B4
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 00:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA88AD23;
	Fri, 29 Nov 2024 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AjUpjtai"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43F4683
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839705; cv=none; b=NKt1mONy7n7hin8TrOudEVxE6HCSZ//4/r7Sk9v90JCLrgfum8RrjZJX+N4awjSVH4ETDOMHI/iS9vQN/h810A1b4tvn5TuODBduFbW1DIdcJq3sCW53DHqFn0+M0tvWL7l3P7Ok0B8Dvne0U1UJo3a+80evmqyerxB6020YadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839705; c=relaxed/simple;
	bh=0oqamsEkXX4bYHIVWICaGV7yM8vIVxO5+Ns44FFffEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpI8Ua+0+1+cAb27IQmwraXsLD/lZ4iECASu3E0MGhyYZhynS0nVV1Mfg+RoDXix0TTAXYSDH8L5HzaWv8mR7bx+LbLm/D6rxE90+7aAxlk9kPmM6hwoOepMEEnpkDsJGnK4BuDFZVdC4aqWTW7FAxLw54kVet3MemEdVql0Opk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AjUpjtai; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2129fd7b1a5so10358885ad.1
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 16:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732839703; x=1733444503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e63Qh8yDCGpehSbTHGGffUHGEEyMaGUtLTTzMlKXbLM=;
        b=AjUpjtaicT39BtuntQup/RhFBy4cipmjiJSXD3JEKmsUsiWjVrNKvd7YdDUnenadlx
         G1aDmyWCmSSzx+gJklDVoGpWVnXcaJi4tSysPQreK4akkFHvSvX8Lt5ceb9stcMC3LNQ
         ULZZGdhe9I8qxLIZykLlxeqPYOejXvkf9RHsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839703; x=1733444503;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e63Qh8yDCGpehSbTHGGffUHGEEyMaGUtLTTzMlKXbLM=;
        b=t9w3pdfT2jhnpEutidUbcfCUm2J+kFP03X98EiRg6bk28jInJ8EyFUQqNgckTe9Aj5
         22gDGuX0SiFGuTDlAsuVBx9nU99Alx61sND7dJxBiPcoEzTR0xoJmJ3EKBTLePFZuVeX
         GXIy8eRMFv7U18TTs9yH2TAw60u4P4qAWxOD9Joh0oALVXGhT9dMZSMwMZrjAlNxh9UE
         gjc98yT0tU9y5YZ6Sv7s7bO2OnwrghdX14+Z84JTxxvBUhB8GL0XrhxOSeoo/Ykk8DSA
         F3O8uKCa+91ABv6M1wxZwF0GVsqEo2TK6MXM2fQeVKU4Ja7brBu/uXHyjq2GKn7Psb5p
         B0MA==
X-Forwarded-Encrypted: i=1; AJvYcCVcYGypYU+PIzIyLqW7e6J0we6+0FDaqtZ4UdQiDV2srUjIC4SfvqK01YAov38okaNW3mFx8AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJswYSCdNAaPdu5q1jpYzQWd5FWs7BkjljkD/wFBhVA3YNSXxr
	mjbSvFHncnsS6bPo2g5+LpN+mmKktdyImhmgkQLxFMbBjiKuataUUKH5PBdpm2leZ9ivoeIwFV0
	=
X-Gm-Gg: ASbGncvGuIRVxydRVoErRviVv68BG0+/Bk/ElHDiqQvwzgaTxAzg2X518PXUflpyuyQ
	MfXiZHqg/nc2YUWLHgBWxdd65u4cP9rX7ZLCE3xSUAAFdQ4PKTARW1gEjDGQZ+FTAsi3DFEt8zY
	nGjEmpJA+XFZuH7F1H2FnBLpgYkF+bR67BNiUhjryJBj/RkCjkRlBd9+7PZ8qQ6dK0wHG/Hu8h7
	KhNwaDsdLZ/yO604uOiC+b2RCzM46G9jjIJPix22zS/J7DPvRP1VzqQenBNFMEGk1jPoKu5zp+W
	2IvMfMTRiHLK
X-Google-Smtp-Source: AGHT+IGGvVto1nm7VUb1pdet/WhMGotTvH9SmI0xxz8yKW95gXXLgz3EMuFh0dmTEgXmTuSmBLdpuQ==
X-Received: by 2002:a17:902:f645:b0:211:eb00:63bf with SMTP id d9443c01a7336-21501e5bef1mr121780575ad.42.1732839703174;
        Thu, 28 Nov 2024 16:21:43 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f2448sm19538225ad.5.2024.11.28.16.21.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 16:21:41 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea8b039ddcso947922a91.0
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 16:21:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtP4l03inBf7TAuD5xpKdDW2cJ6sBl22oavj+svKssbHFlG7Gei2DCMD6by6LMS4ow68mq3FA=@vger.kernel.org
X-Received: by 2002:a17:90b:548f:b0:2ea:2a8d:dd2a with SMTP id
 98e67ed59e1d1-2ee095bff07mr10855096a91.27.1732839700516; Thu, 28 Nov 2024
 16:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-1-510aab9570dd@chromium.org> <20241128221649.GE25731@pendragon.ideasonboard.com>
 <CANiDSCuEPPoLjukjoO_BVVsRL22kebUnCxo3eTKJqMRg6J0fSw@mail.gmail.com> <20241128222807.GG25731@pendragon.ideasonboard.com>
In-Reply-To: <20241128222807.GG25731@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 01:21:28 +0100
X-Gmail-Original-Message-ID: <CANiDSCt2SyDn48OsdNVV4aieWvpDBzEiAxboONprOuqkbBYf+Q@mail.gmail.com>
Message-ID: <CANiDSCt2SyDn48OsdNVV4aieWvpDBzEiAxboONprOuqkbBYf+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 23:28, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Nov 28, 2024 at 11:25:25PM +0100, Ricardo Ribalda wrote:
> > On Thu, 28 Nov 2024 at 23:17, Laurent Pinchart wrote:
> > > On Wed, Nov 27, 2024 at 12:14:49PM +0000, Ricardo Ribalda wrote:
> > > > When an async control is written, we copy a pointer to the file handle
> > > > that started the operation. That pointer will be used when the device is
> > > > done. Which could be anytime in the future.
> > > >
> > > > If the user closes that file descriptor, its structure will be freed,
> > > > and there will be one dangling pointer per pending async control, that
> > > > the driver will try to use.
> > > >
> > > > Clean all the dangling pointers during release().
> > > >
> > > > To avoid adding a performance penalty in the most common case (no async
> > > > operation). A counter has been introduced with some logic to make sure
> > >
> > > s/). A/), a/
> > >
> > > > that it is properly handled.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 38 ++++++++++++++++++++++++++++++++++++--
> > > >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> > > >  drivers/media/usb/uvc/uvcvideo.h |  8 +++++++-
> > > >  3 files changed, 45 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 4fe26e82e3d1..b6af4ff92cbd 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> > >
> > > How about adding
> >
> > SGTM.
> >
> > >
> > > static void uvc_ctrl_set_handle(struct uvc_control *ctrl, uvc_fh *handle)
> > > {
> > >         if (handle) {
> > >                 if (!ctrl->handle)
> > >                         handle->pending_async_ctrls++;
> > >                 ctrl->handle = handle;
> > >         } else if (ctrl->handle) {
> > >                 ctrl->handle = NULL;
> > >                 if (!WARN_ON(!handle->pending_async_ctrls))
> >
> > Unless you think otherwise. I will make this:
> >
> > WARN_ON(!handle->pending_async_ctrls);
> > if (handle->pending_async_ctrls)
> >    handle->pending_async_ctrls--;
>
> I'm fine with that, I went back and forth between the two.
>
> > The double negation is difficult to read. I am pretty sure the
> > compiler will do its magic and merge the two checks.
> >
> > >                         handle->pending_async_ctrls--;
> > >         }
> > > }

Now that I think about it. Now that we have inverted the patches 1 and
2 we need to add the following change to your function:

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index d8d4bd2254ec..5ce9be812559 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1584,8 +1584,14 @@ static void uvc_ctrl_set_handle(struct
uvc_control *ctrl, struct uvc_fh *handle)
        /* chain->ctrl_mutex must be held. */

        if (handle) {
-               if (!ctrl->handle)
-                       handle->pending_async_ctrls++;
+               if (ctrl->handle) {
+                       if (ctrl->handle == handle)
+                               return;
+                       WARN_ON(!ctrl->handle->pending_async_ctrls);
+                       if (ctrl->handle->pending_async_ctrls)
+                               ctrl->handle->pending_async_ctrls--;
+               }
+               handle->pending_async_ctrls++;
                ctrl->handle = handle;
        } else if (ctrl->handle) {
                ctrl->handle = NULL;

Otherwise, if the control is handled by another fh,
pending_async_ctrls will be unbalanced.

> > >
> > > >       mutex_lock(&chain->ctrl_mutex);
> > > >
> > > >       handle = ctrl->handle;
> > > > -     ctrl->handle = NULL;
> > > > +     if (handle) {
> > > > +             ctrl->handle = NULL;
> > > > +             WARN_ON(!handle->pending_async_ctrls);
> > > > +             if (handle->pending_async_ctrls)
> > > > +                     handle->pending_async_ctrls--;
> > > > +     }
> > >
> > > This would become
> > >
> > >         handle = ctrl->handle;
> > >         uvc_ctrl_set_handle(ctrl, NULL);
> > >
> > > >
> > > >       list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> > > >               s32 value = __uvc_ctrl_get_value(mapping, data);
> > > > @@ -2046,8 +2051,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> > > >       mapping->set(mapping, value,
> > > >               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> > > >
> > > > -     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > > > +     if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> > > > +             if (!ctrl->handle)
> > > > +                     handle->pending_async_ctrls++;
> > > >               ctrl->handle = handle;
> > > > +     }
> > >
> > > Here
> > >
> > >         if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > >                 uvc_ctrl_set_handle(ctrl, handle);
> > >
> > > >
> > > >       ctrl->dirty = 1;
> > > >       ctrl->modified = 1;
> > > > @@ -2770,6 +2778,32 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
> > > >       return 0;
> > > >  }
> > > >
> > > > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> > > > +{
> > > > +     struct uvc_entity *entity;
> > > > +
> > > > +     guard(mutex)(&handle->chain->ctrl_mutex);
> > > > +
> > > > +     if (!handle->pending_async_ctrls)
> > > > +             return;
> > > > +
> > > > +     list_for_each_entry(entity, &handle->chain->dev->entities, list) {
> > > > +             for (unsigned int i = 0; i < entity->ncontrols; ++i) {
> > > > +                     struct uvc_control *ctrl = &entity->controls[i];
> > > > +
> > > > +                     if (ctrl->handle != handle)
> > > > +                             continue;
> > > > +
> > > > +                     ctrl->handle = NULL;
> > > > +                     if (WARN_ON(!handle->pending_async_ctrls))
> > > > +                             continue;
> > > > +                     handle->pending_async_ctrls--;
> > >
> > > And here
> > >
> > >                         uvc_ctrl_set_handle(ctrl, NULL);
> > >
> > > It seems less error-prone to centralize the logic. I'd add a
> > > lockdep_assert() in uvc_ctrl_set_handle(), but there's no easy access to
> > > the chain there.
> > >
> > > > +             }
> > > > +     }
> > > > +
> > > > +     WARN_ON(handle->pending_async_ctrls);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Cleanup device controls.
> > > >   */
> > > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > index 97c5407f6603..b425306a3b8c 100644
> > > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > @@ -652,6 +652,8 @@ static int uvc_v4l2_release(struct file *file)
> > > >
> > > >       uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> > > >
> > > > +     uvc_ctrl_cleanup_fh(handle);
> > > > +
> > > >       /* Only free resources if this is a privileged handle. */
> > > >       if (uvc_has_privileges(handle))
> > > >               uvc_queue_release(&stream->queue);
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index 07f9921d83f2..c68659b70221 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -337,7 +337,10 @@ struct uvc_video_chain {
> > > >       struct uvc_entity *processing;          /* Processing unit */
> > > >       struct uvc_entity *selector;            /* Selector unit */
> > > >
> > > > -     struct mutex ctrl_mutex;                /* Protects ctrl.info */
> > > > +     struct mutex ctrl_mutex;                /*
> > > > +                                              * Protects ctrl.info and
> > > > +                                              * uvc_fh.pending_async_ctrls
> > > > +                                              */
> > > >
> > > >       struct v4l2_prio_state prio;            /* V4L2 priority state */
> > > >       u32 caps;                               /* V4L2 chain-wide caps */
> > > > @@ -612,6 +615,7 @@ struct uvc_fh {
> > > >       struct uvc_video_chain *chain;
> > > >       struct uvc_streaming *stream;
> > > >       enum uvc_handle_state state;
> > > > +     unsigned int pending_async_ctrls;
> > > >  };
> > > >
> > > >  struct uvc_driver {
> > > > @@ -797,6 +801,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> > > >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> > > >                     struct uvc_xu_control_query *xqry);
> > > >
> > > > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> > > > +
> > > >  /* Utility functions */
> > > >  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
> > > >                                           u8 epaddr);
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

