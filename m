Return-Path: <stable+bounces-95796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A4B9DC26F
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 11:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08731B210D8
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C30A198E91;
	Fri, 29 Nov 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="doOynHnx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6A719882F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 10:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732877984; cv=none; b=d7hg6FsJ6Nr+l1E3EB9P5LRCxrrYaFdqEKoxlu/2WDYAkplLpOuh5yTyP6YfV1jv2BbeB95PTSJXX0VbBbMUrnfpDc4IKefetHJ/9RAOILRBil3yVoRhFCRV39mY7naYjkgh6dndI59tvm+3lamm/sJpuvDqdOcjs6vJkkmXjxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732877984; c=relaxed/simple;
	bh=LvK9ek1qytL/0nRFg8sPALh26iCrGrpMHaJkB3WI40c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwQDr0tX3pxjIdKmXbY/j1sikks1nWVH9iwin+25b8yTUvC/FYvHHOhVib3yabEaSpJSg1z21Hnwv6NSYWSMlTl88kWE+6DoQCFRRo/fjIsSNzxyWbXrewr8mF2R4JzmTYDqblT5/9RsyY3f1Q/rwgmzPPdDXQLlhJ83rDto6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=doOynHnx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724f0f6300aso1879703b3a.2
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 02:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732877981; x=1733482781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDjy0MV4148joBtQzxlgNjU2q8U1MtS3upsI0Kv1yqg=;
        b=doOynHnx/XTR/ellalePOVu9++vbWkm9dkPJOWvhkaykIgcBHG+FvfS2LtfWP0Cown
         50EI51/FKhId73hd8mm565cyLb/KjeCejAI/kRvyAtgVxs/dPKReaE1l4YRE1KkjbQDE
         VvQZAj5ih61H26CohodOLgpdMLO6GuRghQabE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732877981; x=1733482781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDjy0MV4148joBtQzxlgNjU2q8U1MtS3upsI0Kv1yqg=;
        b=Hm0O1ewCQIL82sbuGdvxkdn8ZEIapRyCyJXByD5WG92DLEJt3p9yhaeecGbFWSyuC7
         azhT2w7Bi8HYpiH+s91Ze0z9NyQMybb+bJjhzTl0O50iY+nknOjFWSamKKPoReSi//4Z
         2fxU2JLD/mhA1/wQuQJ4Lnq9mB7vZwVS6WTug9P0gJwIOXcx3BFz5wAs6rH4OopGiWod
         LvamDw8h/IPBMVUDYXqnHvOVHZ4guuEEWZeYu7lgNFDt+0D3bloGVaBlaGEnXkU6Sufa
         M6Z3cH1+5V7F0fwElA1m7+jT3oRM346Q2DzDZE5NrB7eFRveQDPP0V4awKNB31Rnsm1P
         7juw==
X-Forwarded-Encrypted: i=1; AJvYcCWu4gqrqMYbRDOB6CPYk/zjUHfnxJH3TfmwD6lIbuztyamklOebYGpj0yEGVFn1/i/j6M3FJHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nOQN88lYWnProjKVT3CVUoID7DUT35fT8rIINErnrj7lQ+Pv
	bI+YfWZwHzVsZCVs3MMUYgs/ckRAjVFcwZs9SSZPvdEutIwDKS5D32PIt8UE1pRN/Etma5LQo00
	=
X-Gm-Gg: ASbGncssFKaHHKc7nxdPvSnldhfYesC3ffF6vO1esrlsId95LCUl+6MxPNl3nA2IWke
	u3Yy4bxKiJ6u9mw3ZEbSswjTYXw5l8UECsXKv8JaVlWSqsJNI3EP4SgZDg5Wjn77zDdEpdnDj5w
	tnEZE9+3qEni/HBoPnvaCNS6qh4RqW28UtMnV3NFBI0L/QZii2eWkhIGKzPT4bBaynss6Hk9tP4
	K6U53Y9+ReQOMZyU9/X8A1rZszesxwpvVitgQLN3dbd26yrG+Vivw4Yxe9xBlQcmTUi2pp43GVF
	Cp9hD4nphVjS
X-Google-Smtp-Source: AGHT+IF+81q1Jd7VbBoU1/R1lw4mIcHoi0O4V2kdsOrSLPpG2ORmxq1uAT5hK8k/6zJVnFAHOiJhrA==
X-Received: by 2002:a17:90b:54c4:b0:2ea:498d:809f with SMTP id 98e67ed59e1d1-2ee093d5a9fmr11697062a91.26.1732877981128;
        Fri, 29 Nov 2024 02:59:41 -0800 (PST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2b2b84fesm2994963a91.47.2024.11.29.02.59.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 02:59:40 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea45dac86eso1347178a91.3
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 02:59:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX670T+e2ASx8AzkuKg+cfQeD8sjJJOJ2oxzm6dMzV7mjoYZt5+LtIvNj85PNQUC6kW4g+LuHo=@vger.kernel.org
X-Received: by 2002:a17:90b:38cd:b0:2ea:addc:9f51 with SMTP id
 98e67ed59e1d1-2ee08e5e3e0mr13083763a91.2.1732877979790; Fri, 29 Nov 2024
 02:59:39 -0800 (PST)
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
In-Reply-To: <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 11:59:27 +0100
X-Gmail-Original-Message-ID: <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
Message-ID: <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 11:36, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Hi Laurent, Ricardo,
>
> On 28/11/2024 23:33, Laurent Pinchart wrote:
> > On Thu, Nov 28, 2024 at 11:28:29PM +0100, Ricardo Ribalda wrote:
> >> On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart wrote:
> >>>
> >>> Hi Ricardo,
> >>>
> >>> (CC'ing Hans Verkuil)
> >>>
> >>> Thank you for the patch.
> >>>
> >>> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> >>>> If a file handle is waiting for a response from an async control, avoid
> >>>> that other file handle operate with it.
> >>>>
> >>>> Without this patch, the first file handle will never get the event
> >>>> associated with that operation, which can lead to endless loops in
> >>>> applications. Eg:
> >>>> If an application A wants to change the zoom and to know when the
> >>>> operation has completed:
> >>>> it will open the video node, subscribe to the zoom event, change the
> >>>> control and wait for zoom to finish.
> >>>> If before the zoom operation finishes, another application B changes
> >>>> the zoom, the first app A will loop forever.
> >>>
> >>> Hans, the V4L2 specification isn't very clear on this. I see pros and
> >>> cons for both behaviours, with a preference for the current behaviour,
> >>> as with this patch the control will remain busy until the file handle is
> >>> closed if the device doesn't send the control event for any reason. What
> >>> do you think ?
> >>
> >> Just one small clarification. The same file handler can change the
> >> value of the async control as many times as it wants, even if the
> >> operation has not finished.
> >>
> >> It will be other file handles that will get -EBUSY if they try to use
> >> an async control with an unfinished operation started by another fh.
> >
> > Yes, I should have been more precised. If the device doesn't send the
> > control event, then all other file handles will be prevented from
> > setting the control until the file handle that set it first gets closed.
>
> I think I need a bit more background here:
>
> First of all, what is an asynchronous control in UVC? I think that means
> you can set it, but it takes time for that operation to finish, so you
> get an event later when the operation is done. So zoom and similar operations
> are examples of that.
>
> And only when the operation finishes will the control event be sent, correct?

You are correct.  This diagrams from the spec is more or less clear:
https://ibb.co/MDGn7F3

>
> While the operation is ongoing, if you query the control value, is that reporting
> the current position or the final position?

I'd expect hardware will return either the current position, the start
position or the final position. I could not find anything in the spec
that points in one direction or the others.

And in the driver I believe that we might have a bug handling this
case (will send a patch if I can confirm it)
the zoom is at 0 and you set it 10
if you read the value 2 times before the camera reaches value 10:
- First value will come from the hardware and the response will be cached
- Second value will be the cached one

now the camera  is at zoom 10
If you read the value, you will read the cached value


>
> E.g.: the zoom control is at value 0 and I set it to 10, then I poll the zoom control
> value: will that report the intermediate values until it reaches 10? And when it is
> at 10, the control event is sent?
>
> Regards,
>
>         Hans
>
> >
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> >>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>>> ---
> >>>>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >>>>  1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> index b6af4ff92cbd..3f8ae35cb3bc 100644
> >>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >>>>       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >>>>               return -EACCES;
> >>>>
> >>>> +     /* Other file handle is waiting a response from this async control. */
> >>>> +     if (ctrl->handle && ctrl->handle != handle)
> >>>> +             return -EBUSY;
> >>>> +
> >>>>       /* Clamp out of range values. */
> >>>>       switch (mapping->v4l2_type) {
> >>>>       case V4L2_CTRL_TYPE_INTEGER:
> >
>


-- 
Ricardo Ribalda

