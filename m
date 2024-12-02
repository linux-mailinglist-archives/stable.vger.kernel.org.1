Return-Path: <stable+bounces-95928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A259DFB38
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A081624E6
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C31F9418;
	Mon,  2 Dec 2024 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FoIlXw+Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0761C760D
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733124546; cv=none; b=oGLJb7s81TBtUhMhYUKRlgup4FiDMXQZVyeeOKNQ7DUiizLph1n+QF9vv2Ud+2i803o73cGCfFMV9EWq/8sMTP71cw1Tckk8C0FLZhuLsbA60FY0ZHIzktWwcotLXqzt8YKYs5OectmjfGJ0XgKELea9gej8ALo63jGcYKYiYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733124546; c=relaxed/simple;
	bh=4xFHZCMeM1ebewrJ52e6BCosJsqby3iOQCUOZJHm3qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD9/kCxXFRmYJC12wjdjOvdXYE1glnoY6OFuiDzd3Mklo3DmzWUEEDsv/JIwFynwElODM4mxhtZNEOhbTiZ/i3Ru4SRSjd9dEMv+bMX/JZc9so4XRKaiUkbRLiboLvM9uiCgZl3YqTUbss/GOH/aQ9JbMXTi6q/mPkzsKfUT5Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FoIlXw+Z; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fccc26ad01so570452a12.2
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 23:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733124543; x=1733729343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr2WFkuVXCFpk9dYa8NAo4k/WPqL0eglJtEmC1nkDsU=;
        b=FoIlXw+ZGKhiqhg7ZMonKYRzu4D7YL4k/Is9hmS27NNXU7Q+HzdDELhD96dwHhsTuj
         bzpA60fa/xdoiGkykeJG0jBJNPLug2K3hi/LsgcWQ+V7YnFSR7nfkKB6FHPRYu3YW9tN
         PADBlV6AMj2XuFufB/ciTEVw9vFfw7ayXBjjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733124543; x=1733729343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hr2WFkuVXCFpk9dYa8NAo4k/WPqL0eglJtEmC1nkDsU=;
        b=Xrb18SVdGNp2D2gYJcPzRR2s1ulizMvXXCoaMwDah0XeNGZZq13uRekcO366MRyzOk
         yDVUX8Dxjem5fDtEtjgViFyD13w4j/L2DXTdpgcGE4GfF8oV/A9u641t/gCT5InV8ojs
         5oDldDlZlmyZKx6tJVQrv+SLTifaipXMQo2IadnHKBs15U8VpCYqxlVeot3l06Sy+OW2
         wbtiGrJGCfa7o4tewsSr516iafpZ43O8dUQgPZbdukwVeh62YI2sEcs+pAa80+wSs0Hl
         ua56yU5SSNeMXK7cGl5z4lioZjQijWh0VAMXktIQl3IVv90zbk3MqcdQrvCE6OTEN4et
         tZvw==
X-Forwarded-Encrypted: i=1; AJvYcCWjYCFurD5W+FdoiygCqnEggL5hSooxqK1TVIB7L9m7L0R9yfxSH0mVuVnU30sLjb/wcV85BJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZxoRlkXBgc3tLqqgAk/mIaQQZNNPpSSMKW/7pc6sqT2NrVcEi
	3Hny4Bq+Fjwh8mMyvu6sFGXJ7u6flLUzg1XjWEYFKYN6oxAogDE8Hp23o0NOeYjX1CrzNzi08sI
	=
X-Gm-Gg: ASbGnctGEVTIMBQlm4bk5w/d6NAxfvmrEsc7ZjfeeRl9PQkmiE4OrLYs5KrjvUsrIG/
	iIkBiHNp7/lEXyvLIeQZ60HjwunCCTBGJ/EA5ATe4Q6961ZN7x/KMKYL8rSbr6RoHDQz8uLwRk/
	fpk09Ghj81PFRejEOqZvCWYGhVcdfFnxPPJ7qrXCbV3yquvGXxx678t5Pf9n5gAHAymud5ZzIKV
	BNRm5P1iVv+CJM4frV9jlH2Oe6SoYAbXyuNXIb2aK+navrDP16U35wzg04NQS4J5M6x0WAZwnvQ
	UTmvrsX7YBpTOzyc
X-Google-Smtp-Source: AGHT+IGqXONSwgU7D7VP9awwD+nR3YxQ9AyZNCtAE6hUmrepFDQxQWF026mx/HmeDfjX8VbNtYuykw==
X-Received: by 2002:a05:6a20:748f:b0:1e0:d10f:806c with SMTP id adf61e73a8af0-1e0e0afa675mr31489915637.6.1733124543126;
        Sun, 01 Dec 2024 23:29:03 -0800 (PST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com. [209.85.215.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f3ccsm7767814b3a.56.2024.12.01.23.29.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 23:29:02 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fccc26ad01so570427a12.2
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 23:29:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqiKv7NK6QxatBKFwi4HlsNAo8/U3ROGUKespcFmYM6699o03Q+gc0JBw6ZEH1I3pc64JdTL4=@vger.kernel.org
X-Received: by 2002:a05:6a21:789a:b0:1db:ffb9:f359 with SMTP id
 adf61e73a8af0-1e0e0b60ae2mr32388588637.24.1733124541599; Sun, 01 Dec 2024
 23:29:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128223343.GH25731@pendragon.ideasonboard.com>
 <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl> <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
 <20241129110640.GB4108@pendragon.ideasonboard.com> <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
 <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl> <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
 <CANiDSCvwzY3DJ+U3EyzA7TCQu2qMUL6L1eTmZYbM+_Tk6DsPaA@mail.gmail.com>
 <20241129220339.GD2652@pendragon.ideasonboard.com> <CANiDSCsXi-WQLpbeXMat5FoM8AnYoJ0nVeCkTDMvEus8pXCC3w@mail.gmail.com>
 <20241202001846.GD6105@pendragon.ideasonboard.com>
In-Reply-To: <20241202001846.GD6105@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Dec 2024 08:28:48 +0100
X-Gmail-Original-Message-ID: <CANiDSCuf=YN0=Q+ariHRPUAhacd=s5SFRHsySXWDowaiJxMa3A@mail.gmail.com>
Message-ID: <CANiDSCuf=YN0=Q+ariHRPUAhacd=s5SFRHsySXWDowaiJxMa3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Dec 2024 at 01:19, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Nov 29, 2024 at 11:18:54PM +0100, Ricardo Ribalda wrote:
> > On Fri, 29 Nov 2024 at 23:03, Laurent Pinchart wrote:
> > > On Fri, Nov 29, 2024 at 07:47:31PM +0100, Ricardo Ribalda wrote:
> > > > Before we all go on a well deserved weekend, let me recap what we
> > > > know. If I did not get something correctly, let me know.
> > > >
> > > > 1) Well behaved devices do not allow to set or get an incomplete async
> > > > control. They will stall instead (ref: Figure 2-21 in UVC 1.5 )
> > > > 2) Both Laurent and Ricardo consider that there is a big chance that
> > > > some camera modules do not implement this properly. (ref: years of
> > > > crying over broken module firmware :) )
> > > >
> > > > 3) ctrl->handle is designed to point to the fh that originated the
> > > > control. So the logic can decide if the originator needs to be
> > > > notified or not. (ref: uvc_ctrl_send_event() )
> > > > 4) Right now we replace the originator in ctrl->handle for unfinished
> > > > async controls.  (ref:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/media/usb/uvc/uvc_ctrl.c#n2050)
> > > >
> > > > My interpretation is that:
> > > > A) We need to change 4). We shall not change the originator of
> > > > unfinished ctrl->handle.
> > > > B) Well behaved cameras do not need the patch "Do not set an async
> > > > control owned by another fh"
> > > > C) For badly behaved cameras, it is fine if we slightly break the
> > > > v4l2-compliance in corner cases, if we do not break any internal data
> > > > structure.
> > >
> > > The fact that some devices may not implement the documented behaviour
> > > correctly may not be a problem. Well-behaved devices will stall, which
> > > means we shouldn't query the device while as async update is in
> > > progress. Badly-behaved devices, whatever they do when queried, should
> > > not cause any issue if we don't query them.
> >
> > I thought we could detect the stall and return safely. Isn't that the case?
>
> We could, but if we know the device will stall anyway, is there a reason
> not to avoid issuing the request in the first place ?

Because there are always going to be devices that do not send the
event when the control has finished.

It is impossible to know the state of the device: Is the zoom still
moving or the device is not compliant?


>
> > Why we have not seen issues with this?
>
> I haven't tested a PTZ device for a very long time, and you would need
> to hit a small time window to see the issue.

Not that small, some devices take up to 10 seconds to go from the
smallest zoom to the biggest zoom.
I'd say that v4l2-ctl has a very big chance to hit any error.

BTW, homing can take an even longer time.

>
> > > We should not send GET_CUR and SET_CUR requests to the device while an
> > > async update is in progress, and use cached values instead. When we
> > > receive the async update event, we should clear the cache. This will be
> > > the same for both well-behaved and badly-behaved devices, so we can
> > > expose the same behaviour towards userspace.
> >
> > seting ctrl->loaded = 0 when we get an event sounds like a good idea
> > and something we can implement right away.
> > If I have to resend the set I will add it to the end.
> >
> > > We possibly also need some kind of timeout mechanism to cope with the
> > > async update event not being delivered by the device.
> >
> > This is the part that worries me the most:
> > - timeouts make the code fragile
> > - What is a good value for timeout? 1 second, 30, 300? I do not think
> > that we can find a value.
>
> I've been thinking about the implementation of uvc_fh cleanup over the
> weekend, and having a timeout would have the nice advantage that we
> could reference-count uvc_fh instead of implementing a cleanup that
> walks over all controls when closing a file handle. I think it would
> make the code simpler, and possibly safer too.

The problem with a timeout is:
- We do not know what is the right value for the timeout.
- We need to have one timeout per control, or implement a timeout
dispatcher mechanism, and that is racy by nature
- It will require introducing a new locking mechanism to avoid races
between the timeout handler and the event completion
- It introduces a new lifetime in the driver... I'd argue that it is
best to have less, not more.

I do not see many benefits....

What we can introduce on top of my set is something like this (just
pseudocode, do not scream at me :P)  That code can prevent stalls and
will work with misbehaving hardware.... (But I still do not know a
good value for timeout) and solve some of the issues that I mention.

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index f0e8a436a306..a55bd4b3ac07 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1132,6 +1132,9 @@ static int __uvc_ctrl_get(struct uvc_video_chain *chain,
        if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0)
                return -EACCES;

+       if (ctrl->handle && ( NOW - ctrl->async_start_time ) < TIMEOUT)
+               return -EBUSY;
+
        ret = __uvc_ctrl_load_cur(chain, ctrl);
        if (ret < 0)
                return ret;
@@ -1591,6 +1594,7 @@ static int uvc_ctrl_get_handle(struct uvc_fh
*handle, struct uvc_control *ctrl)
                return -EBUSY;

        ctrl->handle = handle;
+       ctrl->async_start_time = NOW;
        handle->pending_async_ctrls++;
        return 0;
 }
@@ -1982,6 +1986,9 @@ int uvc_ctrl_set(struct uvc_fh *handle,
        if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
                return -EACCES;

+       if (ctrl->handle && ( NOW - ctrl->async_start_time ) < TIMEOUT)
+               return -EBUSY;
+
        /* Clamp out of range values. */
        switch (mapping->v4l2_type) {
        case V4L2_CTRL_TYPE_INTEGER:
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index e0e4f099a210..5c82fae94dff 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -154,6 +154,8 @@ struct uvc_control {
                                 * File handle that initially changed the
                                 * async control.
                                 */
+
+       TIME async_start_time;
 };


In any case. Can we solve this in incremental steps? I think the
current patch seems simple and correct. We can introduce the timeout
later.


Thanks!

>
> > > Regarding the userspace behaviour during an auto-update, we have
> > > multiple options:
> > >
> > > For control get,
> > >
> > > - We can return -EBUSY
> > > - We can return the old value from the cache
> > > - We can return the new value fromt he cache
> > >
> > > Returning -EBUSY would be simpler to implement.
> >
> > Not only easy, I think it is the most correct,
> >
> > > I don't think the behaviour should depend on whether the control is read
> > > on the file handle that initiated the async operation or on a different
> > > file handle.
> > >
> > > For control set, I don't think we can do much else than returning
> > > -EBUSY, regardless of which file handle the control is set on.
> >
> > ACK.
> >
> > > > I will send a new version with my interpretation.
> > > >
> > > > Thanks for a great discussion
> >
> > Looking with some perspective... I believe that we should look into
> > the "userspace behaviour for auto controls" in a different patchset.
> > It is slightly unrelated to this discussion.
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

