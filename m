Return-Path: <stable+bounces-95927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1139DFAFB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CBCD281B85
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 07:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F471F8F10;
	Mon,  2 Dec 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UNaNCV0y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321878489
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123952; cv=none; b=iqbxES678Q2QMhq/74n6daRxqbg9TNVOIxgnliyvgUlsHYlZtRONCS7kmHCNmTBbUN+o0X1yQCKKalQPBUiOe7DeeThIRt8Ue6ukwx4FWevhSJXz4A7t/k/GiYSSPeTfvKQ4CWpcTCM2sqhO0vS5Zil85gxa9OTqUtppQk31vpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123952; c=relaxed/simple;
	bh=hf+j1g7yW69ryzI+X5FfA9uPgl1kewffZVhpIIVWCJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P14lmspa4MAWL4ILhubbQ/oZfwiFQBGpdaMDh3LmqiiUnPE0yL44j978VYVCPUr5SiIBsgLAK9n1HhW6O40Zs5NzuWHsi7Szq0z64tVtCAtSv5Kg/qqKB0QC0rdLh9o9Sd6n3Gfpiy4Zg/3oXGxyk/fE1dTqoWM1BRc8jkPCmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UNaNCV0y; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2eecc01b5ebso451587a91.1
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 23:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733123949; x=1733728749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SPZJ5SXB7m8Dqvv2I1ZRy2n3cYkDrshlZ9d02Y7QxTY=;
        b=UNaNCV0yzT6CJ8rzxOJxNjD9UTkxZNgf4xc+UEcvcKMSHybiDOlCi5J7hkH210/a0F
         OLEgJqO2g4APQuR/2SBdhwlx2gVaL64mAu72xmmFAdRurb/B+RZSCXAHL51eERDIX2qD
         VnA8xs9oAwyUS9rVNyXwaILOLMWU95qmRo5J8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733123949; x=1733728749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPZJ5SXB7m8Dqvv2I1ZRy2n3cYkDrshlZ9d02Y7QxTY=;
        b=J3ICRDkWEICCZr9RVSD6me8BMQlRBUa8A3WeP7ww+zWSwXAsPUC+f94+IR9qGcm8WB
         /t+VKw2XO3XqjRctXeNG9zbWhmGNuxEUtrcBPz17EKfRV37qi0OBDXHTRpltZQkp2JUS
         cpzH4qW0UtSQi446zTmY9UQDP7RNVTCgk4R4myOYiykbFWDplNaCgTG1zvkM7zdxm7mG
         QhKn1VwIjWzh+jfvtKPNTXHWic9i4mS9Sg0ovhRhH1OnizUJ/kAiG5842q7z9TcIyKyz
         JR+t6f9LD2KpsBG2j6wFC2JSYIXjsrP1AFJixdQhZRD0ZD7F3AZwA1vJbk6ODqCLWGPe
         nXhg==
X-Forwarded-Encrypted: i=1; AJvYcCX+ScjAcnI/36QF4omE4UIG/mDNRTn6INaZ8nHT0WfIuGVQeiSEJ0kZuqXVPG9r8OJu+X2yREE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynHizcuxdFrn2p6UnPBDTjdlaNOAylmBS89BMV8Py/g9dG0/Cs
	XpQfojM1LC37sW07e1UHqJX36CpjOW3t4d/Bwp0J1wXDOeJyqEiXWUrQ9tkVc77dFxMIoCfYWHM
	=
X-Gm-Gg: ASbGncuvOx47VwYbrI8CfWEtf5gZ+OORKD0a4/9XS5B3hNWEXiNhh9Yqgdc3kNiVpfr
	sZPAZCnMeId7AP37csKabXznxs1DkOYcB5RoUZ3Sv2fPva5SorSem93n3FGc+FAMbCXbANC/ovK
	joZZ0XgnaZm8db/CYJNA8kOyAUbOjm0FeVBA1pEhrgBYHXE++XTGjoiYIFXP7UEYPCYKlf1dgQ0
	jraPLc2hujTN7+gp2J41GFl8t4kuc9ehGp06g5fLQty+xTIxJbzvVX/9Dkm33dBJN81CgQ7iPvI
	xaLWpwbEkzs/
X-Google-Smtp-Source: AGHT+IHQ1RARjr1Q5ethpPNDV1zjsu+vMmnmr/03Bhx4AJrpWAlBNLKz+kyBxTCgJIsIRWfC7aZRJg==
X-Received: by 2002:a17:90b:1e11:b0:2ea:9ccb:d1f4 with SMTP id 98e67ed59e1d1-2ee08dae675mr31949332a91.0.1733123948927;
        Sun, 01 Dec 2024 23:19:08 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee9d371f1fsm2611950a91.20.2024.12.01.23.19.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 23:19:08 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so1042163a91.3
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 23:19:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGqxBfN+rC8wyZzf2lnSEIl59QizmNImqom5rGnVR4k+0xUt/FD64bIQnjUx67fhzYODC+bdk=@vger.kernel.org
X-Received: by 2002:a17:90b:17d0:b0:2ee:8abd:7254 with SMTP id
 98e67ed59e1d1-2ee8abd742amr9239433a91.36.1733123947424; Sun, 01 Dec 2024
 23:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
 <20241129-uvc-fix-async-v4-2-f23784dba80f@chromium.org> <CANiDSCv3986=KjwWOXsKGZ58+YMViHeHvam=ax7iKr=x_h_pRw@mail.gmail.com>
In-Reply-To: <CANiDSCv3986=KjwWOXsKGZ58+YMViHeHvam=ax7iKr=x_h_pRw@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Dec 2024 08:18:54 +0100
X-Gmail-Original-Message-ID: <CANiDSCuWwVRdxUR4_Sxt8wCg+459p34t02AdOeD22LaG+AU2pw@mail.gmail.com>
Message-ID: <CANiDSCuWwVRdxUR4_Sxt8wCg+459p34t02AdOeD22LaG+AU2pw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 18:15, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> nit:
>
> After sleeping on it. I think this could be nicer expressed  with:
> uvc_ctrl_get_handle and uvc_ctrl_put_handle
>
> Let me know what do you prefer:
>
>
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 88ef8fdc2be2..d4a010cdf805 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1579,6 +1579,35 @@ static void uvc_ctrl_send_slave_event(struct
> uvc_video_chain *chain,
>         uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
>  }
>
> +static int uvc_ctrl_get_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
> +{
> +       /* NOTE: We must own the chain->ctrl_mutex to run this function. */
We can even:  lockdep_assert_held(&handle->chain->ctrl_mutex);
> +
> +       if (handle == ctrl->handle) /* Nothing to do here. */
> +               return 0;
> +
> +       /* We can't change the original handler. */
> +       if (ctrl->handle)
> +               return -EBUSY;
> +
> +       ctrl->handle = handle;
> +       handle->pending_async_ctrls++;
> +       return 0;
> +}
> +
> +static void uvc_ctrl_put_handle(struct uvc_fh *handle, struct
> uvc_control *ctrl)
> +{
> +       /* NOTE: We must own the chain->ctrl_mutex to run this function. */
> +
> +       if (!ctrl->handle) /* Nothing to do here.*/
> +               return;
> +
> +       ctrl->handle = NULL;
> +       if (WARN_ON(!handle->pending_async_ctrls))
> +               return;
> +       handle->pending_async_ctrls--;
> +}
> +
>  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>                            struct uvc_control *ctrl, const u8 *data)
>  {
> @@ -1589,7 +1618,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>         mutex_lock(&chain->ctrl_mutex);
>
>         handle = ctrl->handle;
> -       ctrl->handle = NULL;
> +       uvc_ctrl_put_handle(handle, ctrl);
>
>         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
>                 s32 value = __uvc_ctrl_get_value(mapping, data);
> @@ -2046,8 +2075,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>         mapping->set(mapping, value,
>                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS && !ctrl->handle)
> -               ctrl->handle = handle;
> +       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> +               uvc_ctrl_get_handle(handle, ctrl);
>
>         ctrl->dirty = 1;
>         ctrl->modified = 1;
> @@ -2770,6 +2799,22 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
>         return 0;
>  }
>
> +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> +{
> +       struct uvc_entity *entity;
> +
> +       guard(mutex)(&handle->chain->ctrl_mutex);
> +
> +       if (!handle->pending_async_ctrls)
> +               return;
> +
> +       list_for_each_entry(entity, &handle->chain->dev->entities, list)
> +               for (unsigned int i = 0; i < entity->ncontrols; ++i)
> +                       uvc_ctrl_put_handle(handle, &entity->controls[i]);
> +
> +       WARN_ON(handle->pending_async_ctrls);
> +}
> +
>  /*
>   * Cleanup device controls.
>   */
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 97c5407f6603..b425306a3b8c 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -652,6 +652,8 @@ static int uvc_v4l2_release(struct file *file)
>
>         uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
>
> +       uvc_ctrl_cleanup_fh(handle);
> +
>         /* Only free resources if this is a privileged handle. */
>         if (uvc_has_privileges(handle))
>                 uvc_queue_release(&stream->queue);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index ce688b80e986..e0e4f099a210 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -340,7 +340,11 @@ struct uvc_video_chain {
>         struct uvc_entity *processing;          /* Processing unit */
>         struct uvc_entity *selector;            /* Selector unit */
>
> -       struct mutex ctrl_mutex;                /* Protects ctrl.info */
> +       struct mutex ctrl_mutex;                /*
> +                                                * Protects ctrl.info,
> +                                                * ctrl.handle and
> +                                                * uvc_fh.pending_async_ctrls
> +                                                */
>
>         struct v4l2_prio_state prio;            /* V4L2 priority state */
>         u32 caps;                               /* V4L2 chain-wide caps */
> @@ -615,6 +619,7 @@ struct uvc_fh {
>         struct uvc_video_chain *chain;
>         struct uvc_streaming *stream;
>         enum uvc_handle_state state;
> +       unsigned int pending_async_ctrls;
>  };
>
>  struct uvc_driver {
> @@ -800,6 +805,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain
> *chain, u32 v4l2_id,
>  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
>                       struct uvc_xu_control_query *xqry);
>
> +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> +
>  /* Utility functions */
>  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
>                                             u8 epaddr);
>
> On Fri, 29 Nov 2024 at 22:30, Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
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
> > operation), a counter has been introduced with some logic to make sure
> > that it is properly handled.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 54 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> >  drivers/media/usb/uvc/uvcvideo.h |  9 ++++++-
> >  3 files changed, 62 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 88ef8fdc2be2..bc96fb475b9c 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1579,6 +1579,33 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
> >         uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
> >  }
> >
> > +static void uvc_ctrl_set_handle(struct uvc_control *ctrl, struct uvc_fh *handle)
> > +{
> > +       /* NOTE: We must own the chain->ctrl_mutex to run this function. */
> > +
> > +       if (handle) {
> > +               if (handle == ctrl->handle) /* Nothing to do here. */
> > +                       return;
> > +
> > +               /* We can't change the original handler. */
> > +               if (WARN_ON(ctrl->handle))
> > +                       return;
> > +
> > +               ctrl->handle = handle;
> > +               handle->pending_async_ctrls++;
> > +               return;
> > +       }
> > +
> > +       if (!ctrl->handle) /* Nothing to do here.*/
> > +               return;
> > +
> > +       handle = ctrl->handle;
> > +       ctrl->handle = NULL;
> > +       if (WARN_ON(!handle->pending_async_ctrls))
> > +               return;
> > +       handle->pending_async_ctrls--;
> > +}
> > +
> >  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >                            struct uvc_control *ctrl, const u8 *data)
> >  {
> > @@ -1589,7 +1616,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >         mutex_lock(&chain->ctrl_mutex);
> >
> >         handle = ctrl->handle;
> > -       ctrl->handle = NULL;
> > +       uvc_ctrl_set_handle(ctrl, NULL);
> >
> >         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> >                 s32 value = __uvc_ctrl_get_value(mapping, data);
> > @@ -2047,7 +2074,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> >
> >         if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS && !ctrl->handle)
> > -               ctrl->handle = handle;
> > +               uvc_ctrl_set_handle(ctrl, handle);
> >
> >         ctrl->dirty = 1;
> >         ctrl->modified = 1;
> > @@ -2770,6 +2797,29 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
> >         return 0;
> >  }
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle)
> > +{
> > +       struct uvc_entity *entity;
> > +
> > +       guard(mutex)(&handle->chain->ctrl_mutex);
> > +
> > +       if (!handle->pending_async_ctrls)
> > +               return;
> > +
> > +       list_for_each_entry(entity, &handle->chain->dev->entities, list) {
> > +               for (unsigned int i = 0; i < entity->ncontrols; ++i) {
> > +                       struct uvc_control *ctrl = &entity->controls[i];
> > +
> > +                       if (ctrl->handle != handle)
> > +                               continue;
> > +
> > +                       uvc_ctrl_set_handle(ctrl, NULL);
> > +               }
> > +       }
> > +
> > +       WARN_ON(handle->pending_async_ctrls);
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
> >         uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> >
> > +       uvc_ctrl_cleanup_fh(handle);
> > +
> >         /* Only free resources if this is a privileged handle. */
> >         if (uvc_has_privileges(handle))
> >                 uvc_queue_release(&stream->queue);
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index ce688b80e986..e0e4f099a210 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -340,7 +340,11 @@ struct uvc_video_chain {
> >         struct uvc_entity *processing;          /* Processing unit */
> >         struct uvc_entity *selector;            /* Selector unit */
> >
> > -       struct mutex ctrl_mutex;                /* Protects ctrl.info */
> > +       struct mutex ctrl_mutex;                /*
> > +                                                * Protects ctrl.info,
> > +                                                * ctrl.handle and
> > +                                                * uvc_fh.pending_async_ctrls
> > +                                                */
> >
> >         struct v4l2_prio_state prio;            /* V4L2 priority state */
> >         u32 caps;                               /* V4L2 chain-wide caps */
> > @@ -615,6 +619,7 @@ struct uvc_fh {
> >         struct uvc_video_chain *chain;
> >         struct uvc_streaming *stream;
> >         enum uvc_handle_state state;
> > +       unsigned int pending_async_ctrls;
> >  };
> >
> >  struct uvc_driver {
> > @@ -800,6 +805,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >                       struct uvc_xu_control_query *xqry);
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> > +
> >  /* Utility functions */
> >  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
> >                                             u8 epaddr);
> >
> > --
> > 2.47.0.338.g60cca15819-goog
> >
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda

