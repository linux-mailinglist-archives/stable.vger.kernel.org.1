Return-Path: <stable+bounces-95842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD96F9DECE2
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 22:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C49163798
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 21:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2831A08AB;
	Fri, 29 Nov 2024 21:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pj/Yexjv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD0155300
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915425; cv=none; b=gHJJwRoxbXsluyAnvoh5+XxSWhT/bEq2kkb6tEKV3WaLEw3WIeOpF4STDZFSd16Nw9Om+RfeuGbNoL5zl2thCVCYtp+L+HbLSR1kv8W9aclmXTmxZ3zJz403/xebPTZhoiSStZPK+xYuLHO8OyN94SNrzIvtRviJMBCGJSwwko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915425; c=relaxed/simple;
	bh=H+pt1YX92D8b0xsAk6x1oHhj9BYBNM6ur0sFrZX8/r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsikWilaYIEG46XmoRAcoPAGhxb0anana6VHJK8SMPjYDzfzpLlUg9mQoGK+mNzyJAg2ehYHxHWD01E97xzkym6XtvWgJRLB+rCsVR8F3nGAx2ECDkdkSkuM4opsB12Jxrn5ucvo76v01KZR5ERPZnhcwkRJuoqH8WdT0KTbJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pj/Yexjv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21260209c68so22622325ad.0
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732915423; x=1733520223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6+yDaUyQ9Dovj6g5WwtyLbdYrdVmmg1F93HxsG1jRsE=;
        b=Pj/Yexjv7PNhFbG0H7oRIEkB7UB5x+cIVtj+4CxtMhInayiyzIHEto6CFjmEHprPnE
         RHvEBk6DF+LkFClnJrLxzoC4ezrR78V8vgP3Ka5mPR5+ICilga+UjqPiOJ+HmHNUY0le
         e7LpjmtS3QTSPO8qTzYNRrIRaiN0FIiEEUpw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915423; x=1733520223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+yDaUyQ9Dovj6g5WwtyLbdYrdVmmg1F93HxsG1jRsE=;
        b=pE4uP0t8bMGY7OcXgMCSSNxNlJ6oclsKScrhfIk/pilCPKDq4ggZbkoz/IaEeHu0Nn
         2ygFPNIOHxR0u5j4ZxfuT9tqa/MCZEmj0K40TZV3YuK7CmaFe5bmETU1plYhrbosFBX8
         Wa+mPJPuvh12Jeh/Q49sJtp4Dz17YKvwpfvFBud/MZS9EM7tuiYfygzrSy8BELK8LgkX
         nQ8wVUe0Ibw5GdSHyO1pkz119dvY0WbMIdFSx/fq40C/EaLRmCQ7qLAlwUVxVgHaYycJ
         dfy9zqTOUAyZO/ZlGEI3ki6wLqCx/v8LXdrugL+64su/miEgXwPjgjp6Xboc1Mygg1Ad
         k9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCW4bUd8ftHGW+l1pzdSHrm58dV2PvaV6bYwlKmHyg/BlLR+MDriPiPEvOoxdbiK92fQyoPH0j4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHjaoH/IaoMm03IVgrscjlHeRk9qlk0JLjgMXvziAydIViDOZ5
	U3D4uS7hKGuxMwAUOaH4Xg3whqXNGuf+knAAma7Kq+W+ho7hIZYXRNM2K2tlqXx7mtdqKFCAUxQ
	=
X-Gm-Gg: ASbGncsdBmrbqVkN5dwSi0oJikzyIZSDjJdT8CjtWCMoVPNFRFsoXj0p9lvOoBAOmwk
	eqDM7RkhnHONICTG9/IGoN6ZT15OrbHZMPKwbMmj8snwKSmovhk4XsW/wStkxUf48eq3BNKvep8
	/3hQHhfpzZIXrBaN6W9271usuX5CbQ9diymYXJekybW1IyBVKQz9sCPwjIwnfr855rhQK3ia5LD
	GS4bqn7NWmSeXUs78NcLC8eKU4jN7oKHBf48mjvUl2C+DStuyxVSe4HMnr3HxmfHuFMuEATGHnm
	5O6tsjYJRBhHvTSK
X-Google-Smtp-Source: AGHT+IEtfMRCkefsM0UskDZiRBrVzJJPuay9jAdmlqBPoPtO6sNos82FtHOahCmwwv6/FMPzCn8z0g==
X-Received: by 2002:a17:902:ccd2:b0:205:5d71:561e with SMTP id d9443c01a7336-2151d8631a1mr161818035ad.26.1732915422941;
        Fri, 29 Nov 2024 13:23:42 -0800 (PST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219ac8f3sm34930065ad.240.2024.11.29.13.23.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 13:23:41 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7251731d2b9so2405493b3a.1
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:23:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWutQepNfdT3DaT57iDN0uzEx8u4P/KTUuFgq+d7kJzxgh0sJSjPzZDOXO8ffzofTtg4DBJ71M=@vger.kernel.org
X-Received: by 2002:a17:90b:8f:b0:2ee:4b72:fb47 with SMTP id
 98e67ed59e1d1-2ee4b72fcfbmr8253541a91.6.1732915420986; Fri, 29 Nov 2024
 13:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org> <20241129-uvc-fix-async-v3-2-ab675ce66db7@chromium.org>
In-Reply-To: <20241129-uvc-fix-async-v3-2-ab675ce66db7@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 22:23:28 +0100
X-Gmail-Original-Message-ID: <CANiDSCsRRBs8dEbyamD+xj1t_M_x6r9MU2_T4RmzEwHygxz_ZQ@mail.gmail.com>
Message-ID: <CANiDSCsRRBs8dEbyamD+xj1t_M_x6r9MU2_T4RmzEwHygxz_ZQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 20:25, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> When an async control is written, we copy a pointer to the file handle
> that started the operation. That pointer will be used when the device is
> done. Which could be anytime in the future.
>
> If the user closes that file descriptor, its structure will be freed,
> and there will be one dangling pointer per pending async control, that
> the driver will try to use.
>
> Clean all the dangling pointers during release().
>
> To avoid adding a performance penalty in the most common case (no async
> operation), a counter has been introduced with some logic to make sure
> that it is properly handled.
>
> Cc: stable@vger.kernel.org
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 44 ++++++++++++++++++++++++++++++++++++++--
>  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
>  drivers/media/usb/uvc/uvcvideo.h |  9 +++++++-
>  3 files changed, 52 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 88ef8fdc2be2..0a79a3def017 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1579,6 +1579,23 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
>         uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
>  }
>
> +static void uvc_ctrl_set_handle(struct uvc_control *ctrl, struct uvc_fh *handle)
> +{
> +       /* NOTE: We must own the chain->ctrl_mutex to run this function. */
> +
> +       if (handle) {
> +               if (WARN_ON(ctrl->handle))
> +                       return;
> +               handle->pending_async_ctrls++;
> +               ctrl->handle = handle;
> +       } else if (ctrl->handle) {
> +               ctrl->handle = NULL;
> +               if (WARN_ON(!handle->pending_async_ctrls))
> +                       return;
> +               handle->pending_async_ctrls--;
This is wrong, handle is NULL here. Sorry about that.

Uploading a new version.

> +       }
> +}
> +
>  void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>                            struct uvc_control *ctrl, const u8 *data)
>  {
> @@ -1589,7 +1606,7 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>         mutex_lock(&chain->ctrl_mutex);
>
>         handle = ctrl->handle;
> -       ctrl->handle = NULL;
> +       uvc_ctrl_set_handle(ctrl, NULL);
>
>         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
>                 s32 value = __uvc_ctrl_get_value(mapping, data);
> @@ -2047,7 +2064,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>
>         if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS && !ctrl->handle)
> -               ctrl->handle = handle;
> +               uvc_ctrl_set_handle(ctrl, handle);
>
>         ctrl->dirty = 1;
>         ctrl->modified = 1;
> @@ -2770,6 +2787,29 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
> +       list_for_each_entry(entity, &handle->chain->dev->entities, list) {
> +               for (unsigned int i = 0; i < entity->ncontrols; ++i) {
> +                       struct uvc_control *ctrl = &entity->controls[i];
> +
> +                       if (ctrl->handle != handle)
> +                               continue;
> +
> +                       uvc_ctrl_set_handle(ctrl, NULL);
> +               }
> +       }
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
> @@ -800,6 +805,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
>  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
>                       struct uvc_xu_control_query *xqry);
>
> +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> +
>  /* Utility functions */
>  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
>                                             u8 epaddr);
>
> --
> 2.47.0.338.g60cca15819-goog
>


-- 
Ricardo Ribalda

