Return-Path: <stable+bounces-95801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2169DC322
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 12:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE742820D2
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C871991D2;
	Fri, 29 Nov 2024 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LhR6Tfs+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C033C5
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 11:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732881311; cv=none; b=Sc0Lrp/i709dntk2RWqUPutUaQI0NZUFmmcobCxtxJ7zk2yUKNzhk82Xbz213d9JrHxxPCmXtjcKquqHrvIr4rdsQDc4Q2F91SX52lpsrnoyiDoc97DDOHCY4ng5t4Qi3EY52/lnmJyzefqaPMjOrUnkKqIGJGBrvdnY0WlIBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732881311; c=relaxed/simple;
	bh=H94fonH0/iS0Ya400lkWzBlZTIYjE5AlSJn+rurzY0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fk7t51KVyjCB0fEvGgfjkMrB3qvDvaRJcrMP+alEkW9zdncxmgosx1urCWNYSADkt2xHUc8M6nwXWNNPYNAZnWhHN8aptnYtoyL8tMvTdpGB8f1ZJukEBoSSepx3ykL8BzPh8v44yn6U+p//IaCRB/bui/rc058U7WK9b0+qGYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LhR6Tfs+; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so1249402a12.1
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 03:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732881309; x=1733486109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=49ZRrxTPw/7ckWBIVJ4Tn6I41BTVjNlZXEsLbt2obgk=;
        b=LhR6Tfs+u98kEDgLyFNpL39dyq2P6A6Wi1MvYLSadswy0cqQgAdaLPLvhl393F+E/Q
         P9q1wY+BtFs8wAGzIyZdgL7IUf8hJ6pVT2hXBmmqhDmRQEITXL9E3KIvcofbpehXQ/bz
         b4JTQnxLkZjyilswIGwy8vrlu5KkPAhaKxNns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732881309; x=1733486109;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49ZRrxTPw/7ckWBIVJ4Tn6I41BTVjNlZXEsLbt2obgk=;
        b=mBrjN5/eh+j1j7AZ8vyjaN+0i+y+ovMxDOt0bsJQI6niqN5I8SrWBsjInHYesD30aD
         w1/70lHaPkTbnQUFKkVw7hAYAK9yuT5Y8amxTOltr/DoEDkM/j+xfQCsLVqJmYCHQ5Dp
         0d+kElWjmlJXtkGu/y28CW2c4779zz7SDpKiZgyLtNBK/P6/shm0s/386zWqX8PSgbS+
         yQgpibV5z3+6LcIo0bi8oI9cRMPnQeUY5VFsxJ/QOeXxKi/RuVOvzzfhUgteh5zueSkW
         MmBhoh5yL69lbDzo1MqSmONf/yaDh7SV8nby5gVZEvN9Tj2SEE5ufgCI3xRHTtfbLOIE
         Xn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXso5/S3bGiTMuJpuC0Z2nR7JM56ZYkJdUOMJvm2EYGBMjGOG0zGGCGq+UifdYI2XHeWGphSI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuvBn1UgZvWhIovsZc+n7Ab4DWUCxVNJi7jZgzQ847dKlqMxv
	57nzC2v95aByutmbvyjYMQmoN7zijsIVqbJnJ+bfAEFWEJL7ZNtCzGBm8+faP6AT5/ThJLiU/4U
	=
X-Gm-Gg: ASbGncuCsqAmqTB5vilcZMW72h1wuPeu+QDkzFy/iXl94eRH3EUxf/E5HXu8EVKLwCa
	T+YHrZyMNH53JGTU6WtnLlHssdwta/ZZZcdLlkRhLs0lTyqjJcKiXKA0LVmTCT35zlJbXZy+0lc
	0CwWnpA37IK1G0ArsV0rX7ElR/cZ4/K9mZ9ye/IGVGJrD4CeLQIg0OAG6wdoYq4mOciXg+KsREz
	Hv9WZnSkig2XUcYB1fN5TyPOKRFyxRpvfn+dxttH/PC653zy43hj8OLHWIZ1EzZQS5b8exR/fwr
	/LcFhNnw0mzjsK60
X-Google-Smtp-Source: AGHT+IE1Ci2P2bl9k3FTD4CUHgsKOPalYv/MXAO0e4hFEyeBoj4FgSMXWrsI42vCWdGKwxsAxANGjQ==
X-Received: by 2002:a05:6a21:2d8f:b0:1e0:bedf:5902 with SMTP id adf61e73a8af0-1e0e0aa73ecmr15081262637.6.1732881308857;
        Fri, 29 Nov 2024 03:55:08 -0800 (PST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848b4dsm3379924b3a.186.2024.11.29.03.55.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:55:07 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-724f0f6300aso1930833b3a.2
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 03:55:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyxjnKsdSbJmZfhyg10JioNso22+ahYceW222n437zWJFF7y8OU65AyRxwKprP2GRLBdcOR9g=@vger.kernel.org
X-Received: by 2002:a17:90b:33ce:b0:2ea:6f90:ce09 with SMTP id
 98e67ed59e1d1-2ee094caf5amr12809220a91.27.1732881306860; Fri, 29 Nov 2024
 03:55:06 -0800 (PST)
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
 <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com> <20241129110640.GB4108@pendragon.ideasonboard.com>
In-Reply-To: <20241129110640.GB4108@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 12:54:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
Message-ID: <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 12:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Nov 29, 2024 at 11:59:27AM +0100, Ricardo Ribalda wrote:
> > On Fri, 29 Nov 2024 at 11:36, Hans Verkuil wrote:
> > > On 28/11/2024 23:33, Laurent Pinchart wrote:
> > > > On Thu, Nov 28, 2024 at 11:28:29PM +0100, Ricardo Ribalda wrote:
> > > >> On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart wrote:
> > > >>>
> > > >>> Hi Ricardo,
> > > >>>
> > > >>> (CC'ing Hans Verkuil)
> > > >>>
> > > >>> Thank you for the patch.
> > > >>>
> > > >>> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> > > >>>> If a file handle is waiting for a response from an async control, avoid
> > > >>>> that other file handle operate with it.
> > > >>>>
> > > >>>> Without this patch, the first file handle will never get the event
> > > >>>> associated with that operation, which can lead to endless loops in
> > > >>>> applications. Eg:
> > > >>>> If an application A wants to change the zoom and to know when the
> > > >>>> operation has completed:
> > > >>>> it will open the video node, subscribe to the zoom event, change the
> > > >>>> control and wait for zoom to finish.
> > > >>>> If before the zoom operation finishes, another application B changes
> > > >>>> the zoom, the first app A will loop forever.
> > > >>>
> > > >>> Hans, the V4L2 specification isn't very clear on this. I see pros and
> > > >>> cons for both behaviours, with a preference for the current behaviour,
> > > >>> as with this patch the control will remain busy until the file handle is
> > > >>> closed if the device doesn't send the control event for any reason. What
> > > >>> do you think ?
> > > >>
> > > >> Just one small clarification. The same file handler can change the
> > > >> value of the async control as many times as it wants, even if the
> > > >> operation has not finished.
> > > >>
> > > >> It will be other file handles that will get -EBUSY if they try to use
> > > >> an async control with an unfinished operation started by another fh.
> > > >
> > > > Yes, I should have been more precised. If the device doesn't send the
> > > > control event, then all other file handles will be prevented from
> > > > setting the control until the file handle that set it first gets closed.
> > >
> > > I think I need a bit more background here:
> > >
> > > First of all, what is an asynchronous control in UVC? I think that means
> > > you can set it, but it takes time for that operation to finish, so you
> > > get an event later when the operation is done. So zoom and similar operations
> > > are examples of that.
> > >
> > > And only when the operation finishes will the control event be sent, correct?
> >
> > You are correct.  This diagrams from the spec is more or less clear:
> > https://ibb.co/MDGn7F3
> >
> > > While the operation is ongoing, if you query the control value, is that reporting
> > > the current position or the final position?
> >
> > I'd expect hardware will return either the current position, the start
> > position or the final position. I could not find anything in the spec
> > that points in one direction or the others.
>
> Figure 2-21 in UVC 1.5 indicates that the device should STALL the
> GET_CUR and SET_CUR requests if a state change is in progress.
>
> > And in the driver I believe that we might have a bug handling this
> > case (will send a patch if I can confirm it)
> > the zoom is at 0 and you set it 10
> > if you read the value 2 times before the camera reaches value 10:
> > - First value will come from the hardware and the response will be cached
>
> Only if the control doesn't have the auto-update flag set, so it will be
> device-dependent. As GET_CUR should stall that's not really relevant,
> except for the fact that devices may not stall the request.

I missed that the device will likely stall during async operations.

What do you think of something like this? I believe it can work with
compliant and non compliant devices.
Note that the event will be received by the device that originated the
operation, not to the second one that might receive an error during
write/read.



diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..9a86c912e7a2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1826,14 +1826,15 @@ static int uvc_ctrl_commit_entity(struct
uvc_device *dev,
                        continue;

                /*
-                * Reset the loaded flag for auto-update controls that were
+                * Reset the loaded flag for auto-update controls and for
+                * asynchronous controls with pending operations, that were
                 * marked as loaded in uvc_ctrl_get/uvc_ctrl_set to prevent
                 * uvc_ctrl_get from using the cached value, and for write-only
                 * controls to prevent uvc_ctrl_set from setting bits not
                 * explicitly set by the user.
                 */
                if (ctrl->info.flags & UVC_CTRL_FLAG_AUTO_UPDATE ||
-                   !(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
+                   !(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) || ctrl->handle)
                        ctrl->loaded = 0;

                if (!ctrl->dirty)
@@ -2046,8 +2047,18 @@ int uvc_ctrl_set(struct uvc_fh *handle,
        mapping->set(mapping, value,
                uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));

-       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-               ctrl->handle = handle;
+       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
+               /*
+                * Other file handle is waiting for an operation on
+                * this asynchronous control. If the device is compliant
+                * this operation will fail.
+                *
+                * Do not replace the handle pointer, so the original file
+                * descriptor will get the completion event.
+                */
+               if (!ctrl->handle)
+                       ctrl->handle = handle;
+       }

        ctrl->dirty = 1;
        ctrl->modified = 1;

>
> > - Second value will be the cached one
> >
> > now the camera  is at zoom 10
> > If you read the value, you will read the cached value
> >
> > > E.g.: the zoom control is at value 0 and I set it to 10, then I poll the zoom control
> > > value: will that report the intermediate values until it reaches 10? And when it is
> > > at 10, the control event is sent?
> > >
> > > >>>> Cc: stable@vger.kernel.org
> > > >>>> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > > >>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > >>>> ---
> > > >>>>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> > > >>>>  1 file changed, 4 insertions(+)
> > > >>>>
> > > >>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > >>>> index b6af4ff92cbd..3f8ae35cb3bc 100644
> > > >>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > >>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > >>>> @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> > > >>>>       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> > > >>>>               return -EACCES;
> > > >>>>
> > > >>>> +     /* Other file handle is waiting a response from this async control. */
> > > >>>> +     if (ctrl->handle && ctrl->handle != handle)
> > > >>>> +             return -EBUSY;
> > > >>>> +
> > > >>>>       /* Clamp out of range values. */
> > > >>>>       switch (mapping->v4l2_type) {
> > > >>>>       case V4L2_CTRL_TYPE_INTEGER:
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

