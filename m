Return-Path: <stable+bounces-98175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D699E2E02
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315631604D9
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3231020ADE8;
	Tue,  3 Dec 2024 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GDlXQPtB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6592209F44
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260929; cv=none; b=EXcjSmrAVGsejmuF6MVBLKlp4LBtGNS40kXXYMkbj1k9EXxze00yRRZCd6yC5Z620I3cdyMXqInBLvgBTWWC/aG2V/uRNmhnkyPwBrKGq8de1K4nt/i6eYXnt6K8KxRlMNCdzYjt3oVXd2JNKzETXOglUTQZ9IOo3COh9bJQ34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260929; c=relaxed/simple;
	bh=tFBF6f89BajU89XxB7AxUC/UV/cJJiLYLD8Oma6mD1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wd1kaQppHznCTxet0vj3h446Cz+q6YqC3Cmvd1Odt+hr/hxHzQYhb67nfDPshz4SOVg+JGX3CRinTESyzhB53UThROpkbw4S/xZRFQ7s7JGrgAVbZ0rLu11+IlAAavYiHYMyLKQMF5GBczh5E9UhyNRzAT8pb1B27U2KM1W1BQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GDlXQPtB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso188466b3a.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 13:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733260924; x=1733865724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=36UgWamiPzC0P1+rxa9FT5lzKClXSFQ1ZREByvYdJcg=;
        b=GDlXQPtBawz9S7PKO+04z4/g1sUg+wlelL/i5UMiWk5q25bWL/T7lFDhhBQ6ByrBMO
         b/yhB5p3qJnve9aX1FHCOvIULXg0XdD2hft743jWv+fuq1kQRATqXeDqgAmY6Mn7DMmT
         zlvoLXjqdOMc3+UwIOuP454y8nvZ8TvXsW3wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733260924; x=1733865724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36UgWamiPzC0P1+rxa9FT5lzKClXSFQ1ZREByvYdJcg=;
        b=Q0mgviWe9HZtCp0H8oMkDshSEtkahwNzAAHqcw2hncAyzvj4KlyY6D5Oz+cPRvuX2c
         kqe3rGaxUP8mMbMaluVzHt7SNirdjjAEhucuGDgZx8BPY+7jXgcfq1FD8e0JVYNFcBBI
         1kwjmxCa4rx0iNArrCprXXWBK+1+332eWUbouTl51EZJvKm5PJTTtW3DuqVCT0up0+j9
         UD7VmNaHmJ2oGmQNPIcBu0hA8thTZeCr8jj9kU9ncnadammlHnU4pRv/TxYYjWU0GWVJ
         DIHSRk06SSdWUOKN3/VQmXomB8CuKq9MPrWar8ryyrcrCDCPmMX2cwKgr09ukFF1qvXb
         vaRw==
X-Forwarded-Encrypted: i=1; AJvYcCVAbcVP4obHcZzD9wHTfhJUgvYP1atVJZGlhCMTIOdn+UcMdEs2zEKnJ8zDOpWWmw7+IaX+tEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMVRwNYw5ZqwLybPdAZvKMKZfFfnrdAev7ASBx11rC32Yf1V4
	9z9bShkuTl+1fjQF2c/B8tUFN6vD86Z+NgcsP0QQ+tOw3wIPkyuptqbclsTR5ixfa8RwtV/4vGY
	=
X-Gm-Gg: ASbGncsuqZl5ts/3WuKP89KJ77AywJja4OEF/3ENI2xkDDrtpjHk380h7JQEbR3ycj4
	ax089PoWGHK+KQDwQRTnh/Qr0rm+5X2AR6Gnl9yol2eHyjiu89LZ/zpl3PJ5JmswRCa9HkAl5n4
	wT7b6PdXgQMIbTpuEJcqWlnks9EYxbEP9yOcTynEVDe7JzeC3iuevVE1NZtn0vjX33KUA9CBpoS
	8xPyM2EpBKXGNAJkHIJfISIC/salSrIWF+kbSnH4R9UJFuPyjOXQ6xZDaLZzp2hwrtMzpBkMEAo
	Fy243cMoxCcDax7+
X-Google-Smtp-Source: AGHT+IEhNargww/njicMH3yzjCdLe55Ojqt90hatn/Ffc1m2oVrJxpNzvWGPp0Zp4GLIwkeFCpmxaw==
X-Received: by 2002:a05:6a00:2e0f:b0:725:4915:c10 with SMTP id d2e1a72fcca58-72549151038mr33419320b3a.10.1733260923811;
        Tue, 03 Dec 2024 13:22:03 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2f7802sm10095858a12.27.2024.12.03.13.22.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 13:22:01 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fc8f0598cdso163623a12.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 13:22:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX4DlyQf9ouBb5WMJqXKgtADczRxmOO2Kao7qwR8mLdz/jLtSpIU6HKyUcLW27vEPBFLrH0JZ4=@vger.kernel.org
X-Received: by 2002:a17:90b:8f:b0:2ee:4b72:fb47 with SMTP id
 98e67ed59e1d1-2ee4b72fcfbmr30541408a91.6.1733260920876; Tue, 03 Dec 2024
 13:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
 <20241202-uvc-fix-async-v5-2-6658c1fe312b@chromium.org> <20241203203557.GC5196@pendragon.ideasonboard.com>
In-Reply-To: <20241203203557.GC5196@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 3 Dec 2024 22:21:49 +0100
X-Gmail-Original-Message-ID: <CANiDSCuyhd3TAP63+LAOjsO2VdGoWKCRspNLWpOU_GW_bwoMvQ@mail.gmail.com>
Message-ID: <CANiDSCuyhd3TAP63+LAOjsO2VdGoWKCRspNLWpOU_GW_bwoMvQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Dec 2024 at 21:36, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, Dec 02, 2024 at 02:24:36PM +0000, Ricardo Ribalda wrote:
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
> >  drivers/media/usb/uvc/uvc_ctrl.c | 52 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
> >  drivers/media/usb/uvc/uvcvideo.h |  9 ++++++-
> >  3 files changed, 60 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 9a80a7d8e73a..af1e38f5c6e9 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1579,6 +1579,37 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
> >       uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
> >  }
> >
> > +static void uvc_ctrl_get_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
> > +{
> > +     lockdep_assert_held(&handle->chain->ctrl_mutex);
> > +
> > +     if (ctrl->handle)
> > +             dev_warn_ratelimited(&handle->stream->dev->udev->dev,
> > +                                  "UVC non compliance: Setting an async control with a pending operation.");
> > +
> > +     if (handle == ctrl->handle)
> > +             return;
> > +
> > +     if (ctrl->handle)
> > +             ctrl->handle->pending_async_ctrls--;
> > +
> > +     ctrl->handle = handle;
> > +     handle->pending_async_ctrls++;
> > +}
> > +
> > +static void uvc_ctrl_put_handle(struct uvc_fh *handle, struct uvc_control *ctrl)
> > +{
> > +     lockdep_assert_held(&handle->chain->ctrl_mutex);
> > +
> > +     if (ctrl->handle != handle) /* Nothing to do here.*/
> > +             return;
> > +
> > +     ctrl->handle = NULL;
> > +     if (WARN_ON(!handle->pending_async_ctrls))
> > +             return;
> > +     handle->pending_async_ctrls--;
> > +}
>
> get/put have strong connotations in the kernel, related to acquiring a
> reference to a given object, and releasing it. The usage here is
> different, and I think it makes the usage below confusing. I prefer the
> original single function.

I just uploaded a new version... not sure if it looks nicer though.

Regards!

>
> > +
> >  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >                          struct uvc_control *ctrl, const u8 *data)
> >  {
> > @@ -1589,7 +1620,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >       mutex_lock(&chain->ctrl_mutex);
> >
> >       handle = ctrl->handle;
> > -     ctrl->handle = NULL;
> > +     if (handle)
> > +             uvc_ctrl_put_handle(handle, ctrl);
> >
> >       list_for_each_entry(mapping, &ctrl->info.mappings, list) {
> >               s32 value = __uvc_ctrl_get_value(mapping, data);
> > @@ -1865,7 +1897,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
> >
> >               if (!rollback && handle &&
> >                   ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > -                     ctrl->handle = handle;
> > +                     uvc_ctrl_get_handle(handle, ctrl);
> >       }
> >
> >       return 0;
> > @@ -2774,6 +2806,22 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
> > +     list_for_each_entry(entity, &handle->chain->dev->entities, list)
>
>         list_for_each_entry(entity, &handle->chain->dev->entities, list) {
>
> > +             for (unsigned int i = 0; i < entity->ncontrols; ++i)
> > +                     uvc_ctrl_put_handle(handle, &entity->controls[i]);
>
>         }
>
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
> > index 07f9921d83f2..92ecdd188587 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -337,7 +337,11 @@ struct uvc_video_chain {
> >       struct uvc_entity *processing;          /* Processing unit */
> >       struct uvc_entity *selector;            /* Selector unit */
> >
> > -     struct mutex ctrl_mutex;                /* Protects ctrl.info */
> > +     struct mutex ctrl_mutex;                /*
> > +                                              * Protects ctrl.info,
> > +                                              * ctrl.handle and
> > +                                              * uvc_fh.pending_async_ctrls
> > +                                              */
> >
> >       struct v4l2_prio_state prio;            /* V4L2 priority state */
> >       u32 caps;                               /* V4L2 chain-wide caps */
> > @@ -612,6 +616,7 @@ struct uvc_fh {
> >       struct uvc_video_chain *chain;
> >       struct uvc_streaming *stream;
> >       enum uvc_handle_state state;
> > +     unsigned int pending_async_ctrls;
> >  };
> >
> >  struct uvc_driver {
> > @@ -797,6 +802,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
> >  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
> >                     struct uvc_xu_control_query *xqry);
> >
> > +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> > +
> >  /* Utility functions */
> >  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
> >                                           u8 epaddr);
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

