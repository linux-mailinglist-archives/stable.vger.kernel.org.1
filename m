Return-Path: <stable+bounces-95819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A00709DE7BC
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C25B20587
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554BD19F40A;
	Fri, 29 Nov 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQqpZley"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CE119CC3F
	for <stable@vger.kernel.org>; Fri, 29 Nov 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887459; cv=none; b=LYYE0lEQuigTdu5Bl+FpXyeldw+lSFJzELIeSwkOOYqtmy5e2nPYzyRfWAC3988csTkQsJmzSsRAIvp52pPCRmwwrV0sse+7EaVy8vS4kM7Q7F2zi5jYjnUjIxtOJgcZo2PiRpeJJqNXX7JLyklC0GP/DYP8laf+m8Gqmwhsmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887459; c=relaxed/simple;
	bh=R2rjNShv5veEDBGPHePYhobrJs9IB4FV7Vw1BACRxt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI5k2CReD+xCN9ox7xyX2aaXshyRbwl13SjwkES7ku3qNCwPhu9ey/hHJgao3YmsFOlgCzFOht72sZ7/8lF+dLqKH/zX41YAOuVW46AMyRC97mflaFrQA/rlG+myub7EStq6gP/beyvrqDrpWuaHpmUHEvAzZMgdioFi5dw6Ng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mQqpZley; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so1325760a91.2
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 05:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732887456; x=1733492256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tzqnSLR2tYzoidyvIFlVXcbBt6VVSOo2C3FzIud4FBg=;
        b=mQqpZleyqbbTWiCvAexM+zW7acv3WXLZ/mLkuLPWmvP8qAb13AWSjynQF1gxoBDPmo
         NUW+Ol3K6ehA/990zIdjpoS28nmRgby4R//d6bEkDAaxry9uDOsIrcAB+DlFvYJf107l
         qBSLuJfQDOOIev04/muVZnI0urOKIw9vGpn7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732887456; x=1733492256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzqnSLR2tYzoidyvIFlVXcbBt6VVSOo2C3FzIud4FBg=;
        b=ru2/Qc1Fy3vbLIwRkeNH2QkZ64AlEZnADZ/5Yj2D5pV5+MIwEidlGIXJBkFVSNX6Ti
         951yEtGR3Ki1Jc5MxFHL0GZzkexN+nhouRuXOsHCzkreTAHmY3sqdPAKJUWGy47RzXuN
         fYThpV3583hFNgNw+1WU0YHrFK4uYnuGkewAitLTTqOzcFAV2/ykbxOyObXkEfOSnxpl
         ZDr6Ui9iUqw81JrrK0ieATETVAFKOuIOm39N7fGy3NDthtSBnD0kVNz/mUFHfZkPZMJx
         okcOxA4kjfHeh2jawItXNalzpJasqlkb9MIXeEw6fJZ+v8c/Aa5Zuj0rE4fZgAhHQsL/
         o+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVo/MA+YfN7TDOWv2fe/1E3Cg7UgTUIBYx2hiTq21oGQXh3Cb0AkvDR4qsN51BtyJjzSq+//cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC+yxVV4ahoKVAEvKCI0GH3hiYJ2T4s4UQU+3/JjVVRRmF+Mpn
	bv5N1hD6yKMUkMA8UfHXqtTQxkTfb6S1cynX3nR/Ifbux/NmTyP/3APA0Kh2t2l34lxlI2PgsmI
	=
X-Gm-Gg: ASbGncskapC9hwW+PahoYJUvuJ9b7RmshI703q7mo6cuYwlRcn35Rm2+HUq064nKDU7
	FP3CotfPcx1Ec890b3pBmpYye5XrsHhe4sD3PWW//KgjVXIJ9dRZIBnfBzJ8Jv6SOQdxkiqtp7Q
	tv/FISdFpdbMD8JB+17Hvam+qHmR8xMpHLNUYZ2KlLBkYVkr7Q3iglIxiWW1TpPcPR+k7ccHR/i
	9A9rIlL7PUu7vBdg0AKwmg+NCufPQykFC68Gg0nsLSznEYIYN4rw2DWczKSgzp8E5iiD/FrSy5W
	jsKTB8NQNN2qRISu
X-Google-Smtp-Source: AGHT+IE9P0EjC9a6TBIUuTeEjZs03D714XElQ5uZEK1Tlrjv66ZxUUDtVhuo2HNZTLAMXbrR/foS1w==
X-Received: by 2002:a17:90a:d890:b0:2ea:61de:38f7 with SMTP id 98e67ed59e1d1-2ee095bff75mr14859400a91.29.1732887456408;
        Fri, 29 Nov 2024 05:37:36 -0800 (PST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa48134sm5273567a91.18.2024.11.29.05.37.34
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:37:34 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-724f41d550cso1122368b3a.2
        for <stable@vger.kernel.org>; Fri, 29 Nov 2024 05:37:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/T0cR6r3Bb/Ncp4k5qNvbYYBcLbps0MS8FrOFEwQMi2yD2t2+QEI1F+SFN+2I9iPC90J6Lfw=@vger.kernel.org
X-Received: by 2002:a17:90b:1d81:b0:2ea:4e9e:df87 with SMTP id
 98e67ed59e1d1-2ee08eb62b0mr14233938a91.19.1732887453826; Fri, 29 Nov 2024
 05:37:33 -0800 (PST)
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
 <20241129110640.GB4108@pendragon.ideasonboard.com> <e6eeb2fc-7951-4ef2-afc5-5147d78ec2e8@xs4all.nl>
In-Reply-To: <e6eeb2fc-7951-4ef2-afc5-5147d78ec2e8@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 14:37:21 +0100
X-Gmail-Original-Message-ID: <CANiDSCsVdv2dE4jtkVD0Xk2ji=tGPH6zNAHWCwxUHKv6i==RTg@mail.gmail.com>
Message-ID: <CANiDSCsVdv2dE4jtkVD0Xk2ji=tGPH6zNAHWCwxUHKv6i==RTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 14:10, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 29/11/2024 12:06, Laurent Pinchart wrote:
> > On Fri, Nov 29, 2024 at 11:59:27AM +0100, Ricardo Ribalda wrote:
> >> On Fri, 29 Nov 2024 at 11:36, Hans Verkuil wrote:
> >>> On 28/11/2024 23:33, Laurent Pinchart wrote:
> >>>> On Thu, Nov 28, 2024 at 11:28:29PM +0100, Ricardo Ribalda wrote:
> >>>>> On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart wrote:
> >>>>>>
> >>>>>> Hi Ricardo,
> >>>>>>
> >>>>>> (CC'ing Hans Verkuil)
> >>>>>>
> >>>>>> Thank you for the patch.
> >>>>>>
> >>>>>> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> >>>>>>> If a file handle is waiting for a response from an async control, avoid
> >>>>>>> that other file handle operate with it.
> >>>>>>>
> >>>>>>> Without this patch, the first file handle will never get the event
> >>>>>>> associated with that operation, which can lead to endless loops in
> >>>>>>> applications. Eg:
> >>>>>>> If an application A wants to change the zoom and to know when the
> >>>>>>> operation has completed:
> >>>>>>> it will open the video node, subscribe to the zoom event, change the
> >>>>>>> control and wait for zoom to finish.
> >>>>>>> If before the zoom operation finishes, another application B changes
> >>>>>>> the zoom, the first app A will loop forever.
> >>>>>>
> >>>>>> Hans, the V4L2 specification isn't very clear on this. I see pros and
> >>>>>> cons for both behaviours, with a preference for the current behaviour,
> >>>>>> as with this patch the control will remain busy until the file handle is
> >>>>>> closed if the device doesn't send the control event for any reason. What
> >>>>>> do you think ?
> >>>>>
> >>>>> Just one small clarification. The same file handler can change the
> >>>>> value of the async control as many times as it wants, even if the
> >>>>> operation has not finished.
> >>>>>
> >>>>> It will be other file handles that will get -EBUSY if they try to use
> >>>>> an async control with an unfinished operation started by another fh.
> >>>>
> >>>> Yes, I should have been more precised. If the device doesn't send the
> >>>> control event, then all other file handles will be prevented from
> >>>> setting the control until the file handle that set it first gets closed.
> >>>
> >>> I think I need a bit more background here:
> >>>
> >>> First of all, what is an asynchronous control in UVC? I think that means
> >>> you can set it, but it takes time for that operation to finish, so you
> >>> get an event later when the operation is done. So zoom and similar operations
> >>> are examples of that.
> >>>
> >>> And only when the operation finishes will the control event be sent, correct?
> >>
> >> You are correct.  This diagrams from the spec is more or less clear:
> >> https://ibb.co/MDGn7F3
> >>
> >>> While the operation is ongoing, if you query the control value, is that reporting
> >>> the current position or the final position?
> >>
> >> I'd expect hardware will return either the current position, the start
> >> position or the final position. I could not find anything in the spec
> >> that points in one direction or the others.
> >
> > Figure 2-21 in UVC 1.5 indicates that the device should STALL the
> > GET_CUR and SET_CUR requests if a state change is in progress.
> >
> >> And in the driver I believe that we might have a bug handling this
> >> case (will send a patch if I can confirm it)
> >> the zoom is at 0 and you set it 10
> >> if you read the value 2 times before the camera reaches value 10:
> >> - First value will come from the hardware and the response will be cached
> >
> > Only if the control doesn't have the auto-update flag set, so it will be
> > device-dependent. As GET_CUR should stall that's not really relevant,
> > except for the fact that devices may not stall the request.
>
> OK, that helps a lot.
>
> If an operation is in progress, then setting a new control value should
> result in -EBUSY. Based on the description above, I gather that even the
> same fh that made the request cannot update it while the operation is
> ongoing?

That is correct according to the spec. But both Laurent (correct me if
I am wrong) and me suspect that there are devices that do not
implement this properly.


>
> Getting the control should just return the value that was set. I assume
> that is cached in uvc?

If I get the code right... we only return the cached value when the
field "loaded" is true. That happens when we read the device. So if
the driver is just loaded

write(full controlA)
read(full controlA)
read(full controlA)

The first read will get the value from the hardware, the second will be cached.


>
> Regards,
>
>         Hans
>
> >
> >> - Second value will be the cached one
> >>
> >> now the camera  is at zoom 10
> >> If you read the value, you will read the cached value
> >>
> >>> E.g.: the zoom control is at value 0 and I set it to 10, then I poll the zoom control
> >>> value: will that report the intermediate values until it reaches 10? And when it is
> >>> at 10, the control event is sent?
> >>>
> >>>>>>> Cc: stable@vger.kernel.org
> >>>>>>> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> >>>>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>>>>>> ---
> >>>>>>>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >>>>>>>  1 file changed, 4 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>> index b6af4ff92cbd..3f8ae35cb3bc 100644
> >>>>>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>> @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >>>>>>>       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >>>>>>>               return -EACCES;
> >>>>>>>
> >>>>>>> +     /* Other file handle is waiting a response from this async control. */
> >>>>>>> +     if (ctrl->handle && ctrl->handle != handle)
> >>>>>>> +             return -EBUSY;
> >>>>>>> +
> >>>>>>>       /* Clamp out of range values. */
> >>>>>>>       switch (mapping->v4l2_type) {
> >>>>>>>       case V4L2_CTRL_TYPE_INTEGER:
> >
>


--
Ricardo Ribalda

