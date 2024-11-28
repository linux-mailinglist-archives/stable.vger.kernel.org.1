Return-Path: <stable+bounces-95763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6479DBD7E
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 23:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76A2282260
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 22:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658771C3F28;
	Thu, 28 Nov 2024 22:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TjYt0ze2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE91C1F21
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732832744; cv=none; b=HLPxeQligGp01k3mPmdpiGpYp1+FozbJY67zH3HznFh6tR7fmPleQJjhwvfNA3NblyROsrFApxWNo/ex7kKhRhYK+/y52EKRC97kwz08w679N34oxQy/4LFiThXSUTlF6+S86kgyskOuC34+PN900qPY9IETws1vntW6HgiCBEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732832744; c=relaxed/simple;
	bh=mMtRrLQO53zORy9ZIEwuUhpvEMU3X/83C/CmDJGNnaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+mihoMSqRizz5erSN0Pbrd55wMX1PDVofobaLclQT3MkJVDPno7SFBd3dvOpGz5QA/HvhGfzCx60fp8eBAxSTa1cWa0qeIUAjy9i1UbQL7b2isSYqcrH9q1pH4gLEXzFqF+XGnCUXHNqkESdZDFp5DfMtfSAtnDqdBX/EqJoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TjYt0ze2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fc88476a02so1030242a12.2
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 14:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732832741; x=1733437541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ut8x+sUZ+v+YLgFB8VOlkYtRBt/+qI6uve6IatC5zR8=;
        b=TjYt0ze2idp51Qe5qomYFMnoqC+gRK+VawTEHHNnyCGkQU2NhcipoR9xP5uFSJ8KFm
         gVISmi8X2wpe7kfPSTqVOuH5czpFN+3G0i4a6di2R/oR1z3znaBh8+xTpZmG5Yam9GGE
         13FtjfgI/l2Uk0zgJ/5u/xb7+/23E52ftgfbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732832741; x=1733437541;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ut8x+sUZ+v+YLgFB8VOlkYtRBt/+qI6uve6IatC5zR8=;
        b=srXk7NQiG0SZXmtUdP/Z0CBb15BMtf8vB1517othAHCQ4/ThqQu9151fPJkxIPCCdt
         kKVpm2xJ7iZaJkFZU3B97YUb59n3nOr5W627n8hgknGYX1pttAqdll8KdJc4h4ZPDyov
         jXAX4qVFuZWeWzHcgQ3rT6d5eWHs8S9E6TTW+lLWzBLpO0wrRTgTsw/5SqET4ELhEZUc
         gaIDzUW0kF8HyAQCl2n8ZtNvmrMMeh8+fR5bYxNy6m+k3dsxBxtvdOdx5sAXEr3lPFtX
         qslYrtPoj0/UapqU/5hoB/fa6iMI+YMBKtyaAtygtJAej4YMxBQ/jMNpWbXfCAD3bkz4
         YByQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaM6aJiYV0FtxE5x6JfvWdczkfKWxT1NlR3IRlBo7J2Jq5xXaxEEUVM+xP12UPQ38JwlQHiAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaVHyPmY3yV/JZ5NquYvmdlVwNrf37WGPIbDaKk+HfnLyz7JPt
	FEsFrnJIN9drNCXK+Z4aGKewFOmAGPuAykGr1cRSji5MIYAChT9+mWeGEMsGan86IBnJEsg+LPM
	=
X-Gm-Gg: ASbGnct5HOL1lBToczcgZIaoo/Br9HqvVzJynlll07XiU6JBe6NbavPn3lp+42MvI/X
	xY9ZYsC/39CAWfCdvcavpcZzA9wZyGC1H7h4w+XaRO7gfDdMD5a0Pm1lpWDTPNC8+FT1mU8niYw
	j2AxAwp9gQG5z0xUmeedkREyc3aFqPLMzuUgUs4rd1x1q2MWSvFU/Urz/UzGD8HOCUUDxZgEBe/
	dJUBRU0aKjxT3xnEd4HWoas7laMl1bx7OBEM6+UGQL6uXSDtPCUgXsfbFPZwLAFkKTAz+iPTaeG
	0v1c+pYzIG/0
X-Google-Smtp-Source: AGHT+IENcRNnPDX5hjNCp3FuquDXNBkoC29OTZ+lZVn9cno8Fr3IS1B7+XMKsaiF8BKB6M2zlmREVg==
X-Received: by 2002:a05:6a21:2d87:b0:1e0:c954:ea7c with SMTP id adf61e73a8af0-1e0e0b16a5emr12737208637.27.1732832740019;
        Thu, 28 Nov 2024 14:25:40 -0800 (PST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com. [209.85.216.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d4946sm1866493a12.14.2024.11.28.14.25.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 14:25:38 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so896461a91.2
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 14:25:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVF8ypLeNi8r5E72NZx9yl0jnNAHw0TAFewWwxLx64P+KZDtH9iE+rFf0zXET5z/qCM41FIwPE=@vger.kernel.org
X-Received: by 2002:a17:90b:35cb:b0:2ea:6f19:180b with SMTP id
 98e67ed59e1d1-2ee097cf0d5mr9964775a91.36.1732832737842; Thu, 28 Nov 2024
 14:25:37 -0800 (PST)
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
Date: Thu, 28 Nov 2024 23:25:25 +0100
X-Gmail-Original-Message-ID: <CANiDSCuEPPoLjukjoO_BVVsRL22kebUnCxo3eTKJqMRg6J0fSw@mail.gmail.com>
Message-ID: <CANiDSCuEPPoLjukjoO_BVVsRL22kebUnCxo3eTKJqMRg6J0fSw@mail.gmail.com>
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

SGTM.

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
Unless you think otherwise. I will make this:

WARN_ON(!handle->pending_async_ctrls);
if (handle->pending_async_ctrls)
   handle->pending_async_ctrls--;

The double negation is difficult to read. I am pretty sure the
compiler will do its magic and merge the two checks.
>                         handle->pending_async_ctrls--;
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

