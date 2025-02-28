Return-Path: <stable+bounces-119911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD4CA49369
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 09:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8D5188D6DC
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B26244E8C;
	Fri, 28 Feb 2025 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KtMvGuxR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E57209F5B
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731171; cv=none; b=T1ialGvJuU5plfS33TUd+wY3Tr/YVo1dJ2cJr1AkYfNoAGgPCnCnQRTmh4ajzziDmjOHLEPuLF7TAfLjvbH7jOx9j7s459N2slm4aMKDq53yezX+cHzeRLkuwT5Jqh+3Cwwn9JhRHm3qv6wd87QQVqOJcnEpM0pkU19n9t8edpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731171; c=relaxed/simple;
	bh=lsNadwoJJaj9XRR3NqV/nFBBhCq9kATCkGy/OAmI0Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPbgwYtYO8lM3E5KrE+RoziUTnX2oU7Q9E5xhUcdWWuBTPPECTuQw/KaOP0Q2yiXJX9ra3N+CJLdJvkmeY4TUEJ82rn0oOxUdrPhkf9LN/tyy5kPsbbnG28TPTnrRFywiXWRuQFMO1DfFdHaSWjhLmnAaAQaBzWcSDMBTcB7lU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KtMvGuxR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5494bc8a526so906082e87.0
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740731166; x=1741335966; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hmz9bmPmJffy9tkkw/l1Q6liipjF5DkE5SiVA+z4zrI=;
        b=KtMvGuxRstdWJfEXFZwPzOvyizyFbih89B5b8zg7YjwIpate6MDY9mOaeu8V1AI8Ft
         TddiuMCBPDSCzdlvVZeOgVA7eKaVyuNh80R1n7SecxaN/o6U6sh0WdIpZEy8IfWuwN6j
         b7Pb05NbETn96hLDpeAUXO46VXQikmgP8As38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740731166; x=1741335966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hmz9bmPmJffy9tkkw/l1Q6liipjF5DkE5SiVA+z4zrI=;
        b=CwCtF9qyiZkk3cydq6q+Q+SFcX0/vsPUjIsAlYQg7TTCKwa3tDbIW3jpgIVutPlwWU
         tZtO03D4JZ1TfC8MXQIGv7VxRglq1WH+PW9Y89ZIKqfQMGKdKaGadc53IiDEIKPA1474
         D2oFDjp7LmK9m40VmEGcRCK6Ulc6eZ4wz+5Rqe/kKb1HUPx6e1xnDttVTFeKOZpsTErO
         K7U+fIrjufV9mV0pXOsh1KKg7wCj4sNpfeU8OOtHwFJebVoHvad3rWWaIMC0HpTJicML
         jAabOiLKd9Lv5kNtnQzhu48CiGIoUp4jFa72pyccFaaPETWTvxeFGCCYgxpXh3Ezfcz2
         ldEA==
X-Forwarded-Encrypted: i=1; AJvYcCWtSr93RZRZrmQ6PyRul/guVk4HeIH/VMKk/NuI5Amr/Tr/33GWyCH/aQChxbBOLtJMzvYcqZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYJuQour/5i2vnLs68g536ijTGkEclBDjxSWSwxi9pmufA3QC5
	iu9FMzRN5IOZfn0D9OcahqHelx2b9n9dM00H4NDlIr/nDDdUoh76oEJBqIokpUBcR8MXbJRgu6p
	7Lw==
X-Gm-Gg: ASbGnctGdTd6ZfnF+KPvPI6b6i2brc7Mcoui63o8ZlnXRnYvwLvt9//PQzjYb5fqyPA
	irC7YzGaT/xBOQzYxWgPv/fSZDilfoo+D3PeoZ6fUoHN8s1w2RAxpZ7cFNY6Ao4GGaNFuuUMivl
	7eMycAAx4KxIWsXaMRKP6MV45t92qmEy4NBJYmrWIPyYBlNvcTtS/cARbrIjncLfAGWeL8mx4og
	JDi46MShYvPY/+M05YqmTPP5hyHzddMe7neLK7n0JDDilQzWsuzxB65A2xF9AXPbcgnI6zCQx3W
	fp5L8vEq1wBpxMvndpXm9JlO+tnmjiwSSt2a/o6rpY0dr7UDYFr4Wy6f2JSydLMxOnNv
X-Google-Smtp-Source: AGHT+IG8FwCFtbabfOcbPkbxyisz3oGLPTYqfiqBPYHwCB/gxvCQFEWdxkEy4gp7ovF2sjQn2NxivA==
X-Received: by 2002:a05:6512:a8b:b0:545:d70:1d0e with SMTP id 2adb3069b0e04-5494c10c660mr1274952e87.3.1740731165626;
        Fri, 28 Feb 2025 00:26:05 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494e7bb9dasm167824e87.195.2025.02.28.00.26.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 00:26:04 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30737db1aa9so16931791fa.1
        for <stable@vger.kernel.org>; Fri, 28 Feb 2025 00:26:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtBgd3PDbzZvf6QPE5ncXjhjEikU1jEaHB6H6DF/S7g0B9IO5cZvlu4WJWd0SofnLBFq0OqCM=@vger.kernel.org
X-Received: by 2002:a2e:be15:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30b9326afc7mr10110311fa.18.1740731163241; Fri, 28 Feb 2025
 00:26:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025021035-alarm-cautious-b382@gregkh>
In-Reply-To: <2025021035-alarm-cautious-b382@gregkh>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 28 Feb 2025 09:25:50 +0100
X-Gmail-Original-Message-ID: <CANiDSCsmFNmqBg-wrGZgMfRNS8tqz_St2DKuMPkZB5cYHka3bw@mail.gmail.com>
X-Gm-Features: AQ5f1JrY1eWLLqoh5HRFNAd5AcPGxiPTjWhW0_CmegGu7Nv8aaGpLrWI5Fppa-U
Message-ID: <CANiDSCsmFNmqBg-wrGZgMfRNS8tqz_St2DKuMPkZB5cYHka3bw@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] media: uvcvideo: Remove dangling pointers"
 failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com, laurent.pinchart@ideasonboard.com, 
	mchehab+huawei@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch has been already merged in stable

https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/media/usb/uvc?h=linux-6.6.y&id=4dbaa738c583a0e947803c69e8996e88cf98d971

On Mon, 10 Feb 2025 at 16:12, <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following commands:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 221cd51efe4565501a3dbf04cc011b537dcce7fb
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021035-alarm-cautious-b382@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>
> Possible dependencies:
>
>
>
> thanks,
>
> greg k-h
>
> ------------------ original commit in Linus's tree ------------------
>
> From 221cd51efe4565501a3dbf04cc011b537dcce7fb Mon Sep 17 00:00:00 2001
> From: Ricardo Ribalda <ribalda@chromium.org>
> Date: Tue, 3 Dec 2024 21:20:10 +0000
> Subject: [PATCH] media: uvcvideo: Remove dangling pointers
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
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Link: https://lore.kernel.org/r/20241203-uvc-fix-async-v6-3-26c867231118@chromium.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index b05b84887e51..4837d8df9c03 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1579,6 +1579,40 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
>         uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
>  }
>
> +static void uvc_ctrl_set_handle(struct uvc_fh *handle, struct uvc_control *ctrl,
> +                               struct uvc_fh *new_handle)
> +{
> +       lockdep_assert_held(&handle->chain->ctrl_mutex);
> +
> +       if (new_handle) {
> +               if (ctrl->handle)
> +                       dev_warn_ratelimited(&handle->stream->dev->udev->dev,
> +                                            "UVC non compliance: Setting an async control with a pending operation.");
> +
> +               if (new_handle == ctrl->handle)
> +                       return;
> +
> +               if (ctrl->handle) {
> +                       WARN_ON(!ctrl->handle->pending_async_ctrls);
> +                       if (ctrl->handle->pending_async_ctrls)
> +                               ctrl->handle->pending_async_ctrls--;
> +               }
> +
> +               ctrl->handle = new_handle;
> +               handle->pending_async_ctrls++;
> +               return;
> +       }
> +
> +       /* Cannot clear the handle for a control not owned by us.*/
> +       if (WARN_ON(ctrl->handle != handle))
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
> @@ -1589,7 +1623,8 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>         mutex_lock(&chain->ctrl_mutex);
>
>         handle = ctrl->handle;
> -       ctrl->handle = NULL;
> +       if (handle)
> +               uvc_ctrl_set_handle(handle, ctrl, NULL);
>
>         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
>                 s32 value = __uvc_ctrl_get_value(mapping, data);
> @@ -1863,7 +1898,7 @@ static int uvc_ctrl_commit_entity(struct uvc_device *dev,
>
>                 if (!rollback && handle &&
>                     ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> -                       ctrl->handle = handle;
> +                       uvc_ctrl_set_handle(handle, ctrl, handle);
>         }
>
>         return 0;
> @@ -2772,6 +2807,26 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
> +                       if (entity->controls[i].handle != handle)
> +                               continue;
> +                       uvc_ctrl_set_handle(handle, &entity->controls[i], NULL);
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
> index dee6feeba274..93c6cdb23881 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -671,6 +671,8 @@ static int uvc_v4l2_release(struct file *file)
>
>         uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
>
> +       uvc_ctrl_cleanup_fh(handle);
> +
>         /* Only free resources if this is a privileged handle. */
>         if (uvc_has_privileges(handle))
>                 uvc_queue_release(&stream->queue);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 965a789ed03e..5690cfd61e23 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -338,7 +338,11 @@ struct uvc_video_chain {
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
> @@ -613,6 +617,7 @@ struct uvc_fh {
>         struct uvc_video_chain *chain;
>         struct uvc_streaming *stream;
>         enum uvc_handle_state state;
> +       unsigned int pending_async_ctrls;
>  };
>
>  struct uvc_driver {
> @@ -798,6 +803,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
>  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
>                       struct uvc_xu_control_query *xqry);
>
> +void uvc_ctrl_cleanup_fh(struct uvc_fh *handle);
> +
>  /* Utility functions */
>  struct usb_host_endpoint *uvc_find_endpoint(struct usb_host_interface *alts,
>                                             u8 epaddr);
>


-- 
Ricardo Ribalda

