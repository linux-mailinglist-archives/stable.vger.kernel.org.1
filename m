Return-Path: <stable+bounces-95590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751999DA311
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 08:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8CCEB25A74
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BF714EC46;
	Wed, 27 Nov 2024 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K30XBOsG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6AE149E0E
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 07:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692432; cv=none; b=C1oMcF9b5Zfb3RKCOs+jhToDL68XrspxNJnwIetz7qO39VHHvc6h8qOUoqaoBdxdXThoGq8a9Lu6w9Y5U64hGoooDCHfFZ9AZ9gX/jDqwgyzlgESP6gGjRolUdPOladYA34VE/fSdoYB++WgmHdIcYcIdqcXegkmT2i3DCI/Ko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692432; c=relaxed/simple;
	bh=VEeTdkPIshGtUMIjF1+MQ8SsBy4eSEWr18q7NQ2DlmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ubxb091blUOybVw5FtNXdtMH0WPl66US9nitcXsZHL3S/RnlZaTk0G1eDKYo3KVNfyk8r4PCUBJAB95TtpNFYZZP8tW0oJjswg20wfInC5PgpGWsi8Tu8cCuaMzYCsxo+yvdCpGad2w96uDIzot+US15FSlhPx7cJD3Mi4QOjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=K30XBOsG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so4296565b3a.3
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732692430; x=1733297230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWsPbH9Ey/0wa0vmOqHRbHISu5d2cxb8zw/sMgDSg6c=;
        b=K30XBOsG4CKLedDWW1KfUkGuNWC5dpbQtn9C0GYRuP76CWIR1MvYAZ63uRHI+WPE8K
         AS96BSbStMZ7YFVoYnWXnp/RQDCFgcmVqUgXK33f+A4lalijRsQCKPtoJ6XA/VAdMYL/
         4cKqvJI36bbUgVIGKzCqObwxaN9cHlbISKd9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692430; x=1733297230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWsPbH9Ey/0wa0vmOqHRbHISu5d2cxb8zw/sMgDSg6c=;
        b=wRLch6wBmS6LVRZrwCLQ5AG8826Q4GmHqUm5eVeCZ56kdrkOLHq6ceW4mV89slrVGw
         cNhd1249wb/js7Vx9A6NN+67OJ2zh46/m5GsItrt5OgO9q4Hrf+ZVYcgmrwJRnZb5Tav
         I1xB8rbnEOOFWfxn7lpa7yX6VUi7fVSSdCQRNaQ0FvocBYB9kUOSFL5TUMQTFBjQqw6u
         IvoyGfRCVZkkPiykIY7HFH9ZTn4qr6XX9MoaYhee4F2Hr1qMkMHTdMf6VJcaYqcSb0Rx
         5tYmrtEb82OH1OuVmJqurQbSsRIO9TIYU7pyFrGTb8mcnpjxUyvxStkifa5gsjebVITi
         5AWQ==
X-Forwarded-Encrypted: i=1; AJvYcCViUU14V+ITJ0jKFRR6GwKo7dy/FES92CfhrH+LSjH5+6qn1c9loAPKOOOupjKOLne4WR2JqPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycaxGX3oBGNfroQrR80CXPWXDLUUm7ZxPj4WKpKuKs5WhqjToQ
	HOEmYBiUqnvWPVXRWSIzB6uhqP0fScCXMIiCHALRu5WKAPpfNKe4fuE5jfCc9psxnuUP1nF/mKA
	=
X-Gm-Gg: ASbGncuzMsmJPlacFutq6f8N+wC3mEiKTbWJj5nFuqABcSvxL+Rb87c7UmntMA+Tb2a
	z8ytndIb0fTqYgeabkKGoFBycbid98OnalNIu4hzQjxP93MdhkTZvbGwi7LsYpGHxSBsvKg+coT
	z6jegvoY9RTc/OiOyr2raOHx3gIcm/aWlk/iMaOtMJoO6ejG/EBc815YXUsO05G5G6kj5n5Ah9g
	Djd3Y5NXZG3IR5UeZ6vjLMbX3CAztx8v9aNokklL0R5c/ABuI7rX6G3zR3UUmWStJhle4PE6rgQ
	eDdHAz3sah/wkO/+
X-Google-Smtp-Source: AGHT+IEPyNEhcMrspwduCzxDnWwzUGriVc4d9AIf0OT5vamzGXaf4Zy9lPyCPI5WzX+dS8lRPjH1fQ==
X-Received: by 2002:a17:903:94d:b0:20c:ecca:432b with SMTP id d9443c01a7336-21501c60adamr30326515ad.35.1732692430199;
        Tue, 26 Nov 2024 23:27:10 -0800 (PST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8d578sm95931925ad.31.2024.11.26.23.27.08
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 23:27:08 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so4296545b3a.3
        for <stable@vger.kernel.org>; Tue, 26 Nov 2024 23:27:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXksVcQ8ocRDhWox7IYHKZcfe/irNS11vxgyYBn+lVd8QXHm70ZPl/ZNAeyE8rEXBlRpmrghi4=@vger.kernel.org
X-Received: by 2002:a05:6a00:3c91:b0:724:f6a2:7b77 with SMTP id
 d2e1a72fcca58-7253013312cmr3529250b3a.17.1732692427462; Tue, 26 Nov 2024
 23:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org> <20241126-uvc-granpower-ng-v1-2-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-2-6312bf26549c@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 08:26:56 +0100
X-Gmail-Original-Message-ID: <CANiDSCu+v+nf3tifsbybf8a5Ea54c7ag4B61BDkN9FA9ogM+SA@mail.gmail.com>
Message-ID: <CANiDSCu+v+nf3tifsbybf8a5Ea54c7ag4B61BDkN9FA9ogM+SA@mail.gmail.com>
Subject: Re: [PATCH 2/9] media: uvcvideo: Remove dangling pointers
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[Resending in plain text, seem like today is not may day]

On Tue, 26 Nov 2024 at 17:20, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> When an async control is written, we copy a pointer to the file handle
> that started the operation. That pointer will be used when the device is
> done. Which could be anytime in the future.
>
> If the user closes that file descriptor, its structure will be freed,
> and there will be one dangling pointer per pending async control, that
> the driver will try to use.
>
> Keep a counter of all the pending async controls and clean all the
> dangling pointers during release().
>
> Cc: stable@vger.kernel.org
> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 40 ++++++++++++++++++++++++++++++++++++++--
>  drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
>  drivers/media/usb/uvc/uvcvideo.h |  3 +++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 5d3a28edf7f0..11287e81d91c 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1589,7 +1589,12 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>         mutex_lock(&chain->ctrl_mutex);
>
>         handle = ctrl->handle;
> -       ctrl->handle = NULL;
> +       if (handle) {
> +               ctrl->handle = NULL;
> +               WARN_ON(!handle->pending_async_ctrls)
There is obviously a missing semicolon here.
I screwed it up when I reordered the patches to move it to the first
part of the set.
Luckily we have CI :).

You can see the fixed version here:
https://gitlab.freedesktop.org/linux-media/users/ribalda/-/commits/b4/uvc-granpower-ng

I do not plan to resend the whole series until there are more comments.
But I am sending the first two patches as a new set, they are fixes. I
will also send the last patch alone, it is unrelated to this.

> +               if (handle->pending_async_ctrls)
> +                       handle->pending_async_ctrls--;
> +       }
>
>         list_for_each_entry(mapping, &ctrl->info.mappings, list) {
>                 s32 value = __uvc_ctrl_get_value(mapping, data);
> @@ -2050,8 +2055,11 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>         mapping->set(mapping, value,
>                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> +       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> +               if (!ctrl->handle)
> +                       handle->pending_async_ctrls++;
>                 ctrl->handle = handle;
> +       }
>
>         ctrl->dirty = 1;
>         ctrl->modified = 1;
> @@ -2774,6 +2782,34 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
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
> +               int i;
> +
> +               for (i = 0; i < entity->ncontrols; ++i) {
> +                       struct uvc_control *ctrl = &entity->controls[i];
> +
> +                       if (!ctrl->handle || ctrl->handle != handle)
> +                               continue;
> +
> +                       ctrl->handle = NULL;
> +                       if (WARN_ON(!handle->pending_async_ctrls))
> +                               continue;
> +                       handle->pending_async_ctrls--;
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
> index 07f9921d83f2..2f8a9c48e32a 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -612,6 +612,7 @@ struct uvc_fh {
>         struct uvc_video_chain *chain;
>         struct uvc_streaming *stream;
>         enum uvc_handle_state state;
> +       unsigned int pending_async_ctrls; /* Protected by ctrl_mutex. */
>  };
>
>  struct uvc_driver {
> @@ -797,6 +798,8 @@ int uvc_ctrl_is_accessible(struct uvc_video_chain *chain, u32 v4l2_id,
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

