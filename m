Return-Path: <stable+bounces-95821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 766969DE7DE
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 14:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2A89B21A00
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E319E98A;
	Fri, 29 Nov 2024 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kzUSN6yE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75319E806
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887729; cv=none; b=Jv5I9nZoMVhFunTb83yk8T3xCQlisVK85/PkQR1sL37nSWc2A/jbetI9VDjUdnCb3YBinxVRWN2mhqGsM9GPHg97F10MqBHImBNWKDQ41F+oH5MJuaqsrx6y+3FZJBoM3fSx9Vvn/haqB3Fyw4NmZpNEaa1TMHpNMrhuG/f6Whs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887729; c=relaxed/simple;
	bh=sVgv3ksXvpteRZEYd8JPzQOo44HSIW5lgB3anwK3PPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfAkxDB7sgK8uOQ8KQdfHjHEsEpcnOIJb6dnzj91RxuU383zkvweoekgsQxf3Q+WYtw/87ZuPlFtX9hLws5khRwOBXzkVTVqfvC1ELyy8uT4BQ2sT7arWBapidoUzK3Tmp1wmAtAjx3R58ArLkKjgoOn0crPAUFaGHgnYEaS8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kzUSN6yE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724e113c821so1744395b3a.3
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 05:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732887726; x=1733492526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kSFitEdT2rCfLfdfH1IWUyxop2r79Nc9DFx17hzOekQ=;
        b=kzUSN6yEhc6W9jumWzeaFKwEaXt6MOCpTC5pLXz6kellRhiIs5HL5Q4OvTqAbIg6ZP
         eMfYrlQzw5JPxnQ+LFlt4P0Ae1l8kVMKDb107mb5dhd8vBwUaOCp+cLMh3Iof7NbzR8b
         fkf1SMbxqPQGbcQOvYWNNg8pjR0lU9S5QuF4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732887726; x=1733492526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSFitEdT2rCfLfdfH1IWUyxop2r79Nc9DFx17hzOekQ=;
        b=KOo/MnYLrkVIm0w1BTIZVXQPYkI6+8lXCgnHwL/9np4f1FElVTBUhBZ6/HthYYAwOX
         ay7wAqwnMpjHpw09SOD6is3nKlBLNyv7l7jlpip6hcA4oHKB2jib9/JOc8kMU03zGvT/
         43X1ZjvFz5CYUCLtYrlXBZkMFm1QWxfW2RGAohxtcm8hOtIQS7jpAN52c5+eJE3OEqnJ
         Sf0RtnqYGo4WFk5abgQc/G4O8GS5or8ctPIz7Fc4EOCvfMnzGlYCwUYWPvFct02M3abl
         R3RS7EtDRhkBXt/x05GZykXsLZFqkygKaPiOQidnswCTwqwu6MiaPy91d4ONgiCbozuj
         xWmw==
X-Forwarded-Encrypted: i=1; AJvYcCX5bsdec7RGCkm9V+cM6c5JdYsOrxZ8TXQdRxF5NvX83dbBDP1weQrJsc/jTr5uXNTKm8FRseE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztcwdEKQZURTmpP73BSQJbBEAU43wFm1MOoxBiB/odoDJFxpnb
	E6udATCPJTvvf7w3Wa1+mNwqZeZOgqe8gXh5ol0rucPmgkN7MGTZ56GTwcJzNROT0tjlZKDpEk0
	=
X-Gm-Gg: ASbGncvzjP8dYzidXpOlYqryN3ea6bvVIU29T2RHzW84DgY9P0anzVP4JhZU8bJwQFb
	2yzpAFVctt+u/fqAKMbYWCLUagmnQ23/cdTpdl8xManbKhqcDbU7PjzrlgrxiZFfy3Y5nkS0TkL
	C1D/aqCtl7NJ3UUSfD6F9S0k1CkwBnY/i53MO8oKheIZdFn86UR0wOUoCDI5eCtiNkC//EYPWE4
	WQATxRq28ogMb5pQZLzwWGiS0vZAkzsRXpYjo+nQL8Xbss509Sp4HMzyOQZj3rktx2nCjhiq6vh
	+hvP0ItmQjAS
X-Google-Smtp-Source: AGHT+IENwOm7Jh/2otyhM0LCsFjH4SJ2LqIjagMqLbTMwQUdhzTB/gpGKVOcwgz/Uinjv7DhGvq7zQ==
X-Received: by 2002:a17:903:244d:b0:211:e9c0:31c6 with SMTP id d9443c01a7336-21501096504mr148149805ad.12.1732887726585;
        Fri, 29 Nov 2024 05:42:06 -0800 (PST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com. [209.85.216.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f1da4sm30775925ad.12.2024.11.29.05.42.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:42:05 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea8b039ddcso1348198a91.0
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 05:42:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUL/DC29ZHVty0V1tfFpAtMlOYHNuQoKeAGtfT32nm4azS74W7ClHADpe0OY61HXhgrl5p5j2U=@vger.kernel.org
X-Received: by 2002:a17:90b:35cb:b0:2ea:6f19:180b with SMTP id
 98e67ed59e1d1-2ee097cf0d5mr12912335a91.36.1732887724820; Fri, 29 Nov 2024
 05:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-2-510aab9570dd@chromium.org> <20241128222232.GF25731@pendragon.ideasonboard.com>
 <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
 <20241128223343.GH25731@pendragon.ideasonboard.com> <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl>
 <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
 <20241129110640.GB4108@pendragon.ideasonboard.com> <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
 <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl>
In-Reply-To: <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 14:41:52 +0100
X-Gmail-Original-Message-ID: <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
Message-ID: <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 14:13, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 29/11/2024 12:54, Ricardo Ribalda wrote:
> > On Fri, 29 Nov 2024 at 12:06, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> >>
> >> On Fri, Nov 29, 2024 at 11:59:27AM +0100, Ricardo Ribalda wrote:
> >>> On Fri, 29 Nov 2024 at 11:36, Hans Verkuil wrote:
> >>>> On 28/11/2024 23:33, Laurent Pinchart wrote:
> >>>>> On Thu, Nov 28, 2024 at 11:28:29PM +0100, Ricardo Ribalda wrote:
> >>>>>> On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart wrote:
> >>>>>>>
> >>>>>>> Hi Ricardo,
> >>>>>>>
> >>>>>>> (CC'ing Hans Verkuil)
> >>>>>>>
> >>>>>>> Thank you for the patch.
> >>>>>>>
> >>>>>>> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> >>>>>>>> If a file handle is waiting for a response from an async control, avoid
> >>>>>>>> that other file handle operate with it.
> >>>>>>>>
> >>>>>>>> Without this patch, the first file handle will never get the event
> >>>>>>>> associated with that operation, which can lead to endless loops in
> >>>>>>>> applications. Eg:
> >>>>>>>> If an application A wants to change the zoom and to know when the
> >>>>>>>> operation has completed:
> >>>>>>>> it will open the video node, subscribe to the zoom event, change the
> >>>>>>>> control and wait for zoom to finish.
> >>>>>>>> If before the zoom operation finishes, another application B changes
> >>>>>>>> the zoom, the first app A will loop forever.
> >>>>>>>
> >>>>>>> Hans, the V4L2 specification isn't very clear on this. I see pros and
> >>>>>>> cons for both behaviours, with a preference for the current behaviour,
> >>>>>>> as with this patch the control will remain busy until the file handle is
> >>>>>>> closed if the device doesn't send the control event for any reason. What
> >>>>>>> do you think ?
> >>>>>>
> >>>>>> Just one small clarification. The same file handler can change the
> >>>>>> value of the async control as many times as it wants, even if the
> >>>>>> operation has not finished.
> >>>>>>
> >>>>>> It will be other file handles that will get -EBUSY if they try to use
> >>>>>> an async control with an unfinished operation started by another fh.
> >>>>>
> >>>>> Yes, I should have been more precised. If the device doesn't send the
> >>>>> control event, then all other file handles will be prevented from
> >>>>> setting the control until the file handle that set it first gets closed.
> >>>>
> >>>> I think I need a bit more background here:
> >>>>
> >>>> First of all, what is an asynchronous control in UVC? I think that means
> >>>> you can set it, but it takes time for that operation to finish, so you
> >>>> get an event later when the operation is done. So zoom and similar operations
> >>>> are examples of that.
> >>>>
> >>>> And only when the operation finishes will the control event be sent, correct?
> >>>
> >>> You are correct.  This diagrams from the spec is more or less clear:
> >>> https://ibb.co/MDGn7F3
> >>>
> >>>> While the operation is ongoing, if you query the control value, is that reporting
> >>>> the current position or the final position?
> >>>
> >>> I'd expect hardware will return either the current position, the start
> >>> position or the final position. I could not find anything in the spec
> >>> that points in one direction or the others.
> >>
> >> Figure 2-21 in UVC 1.5 indicates that the device should STALL the
> >> GET_CUR and SET_CUR requests if a state change is in progress.
> >>
> >>> And in the driver I believe that we might have a bug handling this
> >>> case (will send a patch if I can confirm it)
> >>> the zoom is at 0 and you set it 10
> >>> if you read the value 2 times before the camera reaches value 10:
> >>> - First value will come from the hardware and the response will be cached
> >>
> >> Only if the control doesn't have the auto-update flag set, so it will be
> >> device-dependent. As GET_CUR should stall that's not really relevant,
> >> except for the fact that devices may not stall the request.
> >
> > I missed that the device will likely stall during async operations.
> >
> > What do you think of something like this? I believe it can work with
> > compliant and non compliant devices.
> > Note that the event will be received by the device that originated the
> > operation, not to the second one that might receive an error during
> > write/read.
> >
> >
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 4fe26e82e3d1..9a86c912e7a2 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1826,14 +1826,15 @@ static int uvc_ctrl_commit_entity(struct
> > uvc_device *dev,
> >                         continue;
> >
> >                 /*
> > -                * Reset the loaded flag for auto-update controls that were
> > +                * Reset the loaded flag for auto-update controls and for
> > +                * asynchronous controls with pending operations, that were
> >                  * marked as loaded in uvc_ctrl_get/uvc_ctrl_set to prevent
> >                  * uvc_ctrl_get from using the cached value, and for write-only
> >                  * controls to prevent uvc_ctrl_set from setting bits not
> >                  * explicitly set by the user.
> >                  */
> >                 if (ctrl->info.flags & UVC_CTRL_FLAG_AUTO_UPDATE ||
> > -                   !(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> > +                   !(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) || ctrl->handle)
> >                         ctrl->loaded = 0;
> >
> >                 if (!ctrl->dirty)
> > @@ -2046,8 +2047,18 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >         mapping->set(mapping, value,
> >                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> >
> > -       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > -               ctrl->handle = handle;
> > +       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> > +               /*
> > +                * Other file handle is waiting for an operation on
> > +                * this asynchronous control. If the device is compliant
> > +                * this operation will fail.
> > +                *
> > +                * Do not replace the handle pointer, so the original file
> > +                * descriptor will get the completion event.
> > +                */
> > +               if (!ctrl->handle)
> > +                       ctrl->handle = handle;
>
> I don't think this is right: you want the completion event for async
> controls to go to all filehandles that are subscribed to that control.
>
> Which is what happens if handle == NULL (as I understand the code).
>
> Regards,

The code is correct, but the comment is not :). It should say:
 * Do not replace the handle pointer, or the originator of
 * the operation will receive an event.

The originar should NOT receive the event.
From uvc_ctrl_send_event():
/*
 * Send control change events to all subscribers for the @ctrl control. By
 * default the subscriber that generated the event, as identified by @handle,
 * is not notified unless it has set the V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK flag.
 * @handle can be NULL for asynchronous events related to auto-update controls,
 * in which case all subscribers are notified.
 */



>
>         Hans
>
> > +       }
> >
> >         ctrl->dirty = 1;
> >         ctrl->modified = 1;
> >
> >>
> >>> - Second value will be the cached one
> >>>
> >>> now the camera  is at zoom 10
> >>> If you read the value, you will read the cached value
> >>>
> >>>> E.g.: the zoom control is at value 0 and I set it to 10, then I poll the zoom control
> >>>> value: will that report the intermediate values until it reaches 10? And when it is
> >>>> at 10, the control event is sent?
> >>>>
> >>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> >>>>>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>>>>>>> ---
> >>>>>>>>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >>>>>>>>  1 file changed, 4 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>>> index b6af4ff92cbd..3f8ae35cb3bc 100644
> >>>>>>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>>> @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >>>>>>>>       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >>>>>>>>               return -EACCES;
> >>>>>>>>
> >>>>>>>> +     /* Other file handle is waiting a response from this async control. */
> >>>>>>>> +     if (ctrl->handle && ctrl->handle != handle)
> >>>>>>>> +             return -EBUSY;
> >>>>>>>> +
> >>>>>>>>       /* Clamp out of range values. */
> >>>>>>>>       switch (mapping->v4l2_type) {
> >>>>>>>>       case V4L2_CTRL_TYPE_INTEGER:
> >>
> >> --
> >> Regards,
> >>
> >> Laurent Pinchart
> >
> >
> >
>


-- 
Ricardo Ribalda

