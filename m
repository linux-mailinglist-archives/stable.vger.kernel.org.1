Return-Path: <stable+bounces-95765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4F9DBD85
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 23:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DB82822FB
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 22:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA51C4A15;
	Thu, 28 Nov 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ElrmuM1z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF31C3045
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 22:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732832926; cv=none; b=WLMRL0q86ieesd2rlA7cSapToYoZ3c17L4NGJqhQkZ/ghjQXfZIyE/+uJLOBP6tV4DhBx1FIfhOH9Rn8VYijcZouOqJSmz6alXDYLCVC4fNVPvKksCAyBm5FFfRZnBx+IeG9ki96k5UvwQ77IqaEm/2N3+G9DN9QSdE3ntXQNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732832926; c=relaxed/simple;
	bh=8lq5+GM4KnxEtuVXVOGIdvmiEazYybHaFmVLqIFcr8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHWTzug4XbdtOZeTITtktg49s9t69ca4FTbwt+Pbrgy3FYjxLZEztnVA4Bwsk837u17f/5klPnFuwJGz2eJ7ZfzT5PfWCHjU3ge9XsUmkdld2cb3dQrgAZTBfNbavp9WKV0hAV8s0AgayxEiXlzltRVHbFSLqQsGOV77L41e5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ElrmuM1z; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fbc29b3145so1709527a12.0
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 14:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732832924; x=1733437724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6YHsdk6gFEBYCcBAXe7bD6v4I0e45HlFShaBv7kWeI4=;
        b=ElrmuM1z5quPTdnVr36T6WABEzJO/y2HM6Bfrm0YIyCSpS9tqO6eEFPywtrOFt8h5j
         05dE5BSo99KUOh0oxD0Znwh8b3m4DYtqIkhRnsndFABMETo3BWrZNZbZ/WJoyiukpVuF
         DMcTu8v6Qh0rZ/k1cqGiiEzs600NhqPbhVZDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732832924; x=1733437724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YHsdk6gFEBYCcBAXe7bD6v4I0e45HlFShaBv7kWeI4=;
        b=MvOu4iZwmG9vodBBCnDAeOXnItJGRGdm7ZozM9DfCnAqi2+XFOTplmDjT23EOEmnLv
         jC42W6zSguud75nl1BvzYqJey2rs79bx35YAdTN126b2hAKqUUGoUA7B83FJbB8ChSNc
         0NzEH9FFDnx5iqxCEzHeSrKBiUmFcJuqRCvoRof34MA5HtBtTKpw0T6k73FLaFn4zS4o
         z9idkQJFt4elLDPrP66mrZHQbamOUjTgguTx3vz5zs74HgEyLJF7nabwW5/3F0hZzYO9
         FYnfVp/yQmSC1t5ACzSSN7gpLYNUY+4DKQfn7+C9uO8xhFIFVbgvji1UlkYFAR6HnCwA
         98SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVDz9POypW+Scw8oxOFjQzlUqmRkvbcg/WgoiNHpgjkfchP+y126HIxZPd3JdWA1aQfcRLYuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNNC6jBuFAclgNLP7e52LrtuAyUORBxzA03SHSOWxfmqTYgzH
	u6LAmwjA2Z/U6huq3UqHSMGJgTTM/+fGhrPCJstmvUpvwVRvGsYuWUF7Z/lasOO8gfSr3rzni/k
	=
X-Gm-Gg: ASbGncslRgy/RgUOqCBIsnVADucDvgXgOE9ZVlQeGQC01JTZaIL0vBBKtmD8j4/2boz
	vNMu4W+y7AUOnRPNDaL2G9+YxwrJ9fj91xFPF5IUOUZwtJE6sF1dZgakiU7JHAOvoncjy362JA9
	qpRv3daovMRK7SY4KCxo5Zx0TX7lyYtxrEGT5Wk2HEoHd+cKft1etyGBSqGwILfr2w1AEBf6m1n
	9/PqAvg4zEasWCI2/RgPbC2OfZ/gj5MqqCc9PcUQyty/7YJptmI1fdXdk2YkgHs77O0NMF+HA+R
	C/b7APxYM0nW
X-Google-Smtp-Source: AGHT+IHFBUlZZlVX1dCadMbDu6cXwxm9cFfxjkzAnkmzf/XKr4F7KlUjM9wwjc8UJ6nm1k3rucj5QQ==
X-Received: by 2002:a05:6a20:4327:b0:1d9:761:8ad8 with SMTP id adf61e73a8af0-1e0ec8a13damr8506202637.21.1732832924518;
        Thu, 28 Nov 2024 14:28:44 -0800 (PST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d555csm1874860a12.6.2024.11.28.14.28.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 14:28:42 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ea4c5b8fbcso888649a91.0
        for <stable@vger.kernel.org>; Thu, 28 Nov 2024 14:28:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvAITSFqCzt086I/MIfwO4i8vmKH3B33Vif7Zt8mThAnjnkynpL+Z5Dyxz/ctHg/Ol6vVwqlk=@vger.kernel.org
X-Received: by 2002:a17:90a:9f93:b0:2ea:5658:9ed6 with SMTP id
 98e67ed59e1d1-2ee25b38db4mr7346429a91.12.1732832921898; Thu, 28 Nov 2024
 14:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-2-510aab9570dd@chromium.org> <20241128222232.GF25731@pendragon.ideasonboard.com>
In-Reply-To: <20241128222232.GF25731@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 23:28:29 +0100
X-Gmail-Original-Message-ID: <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
Message-ID: <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> (CC'ing Hans Verkuil)
>
> Thank you for the patch.
>
> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> > If a file handle is waiting for a response from an async control, avoid
> > that other file handle operate with it.
> >
> > Without this patch, the first file handle will never get the event
> > associated with that operation, which can lead to endless loops in
> > applications. Eg:
> > If an application A wants to change the zoom and to know when the
> > operation has completed:
> > it will open the video node, subscribe to the zoom event, change the
> > control and wait for zoom to finish.
> > If before the zoom operation finishes, another application B changes
> > the zoom, the first app A will loop forever.
>
> Hans, the V4L2 specification isn't very clear on this. I see pros and
> cons for both behaviours, with a preference for the current behaviour,
> as with this patch the control will remain busy until the file handle is
> closed if the device doesn't send the control event for any reason. What
> do you think ?

Just one small clarification. The same file handler can change the
value of the async control as many times as it wants, even if the
operation has not finished.

It will be other file handles that will get -EBUSY if they try to use
an async control with an unfinished operation started by another fh.

>
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index b6af4ff92cbd..3f8ae35cb3bc 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >               return -EACCES;
> >
> > +     /* Other file handle is waiting a response from this async control. */
> > +     if (ctrl->handle && ctrl->handle != handle)
> > +             return -EBUSY;
> > +
> >       /* Clamp out of range values. */
> >       switch (mapping->v4l2_type) {
> >       case V4L2_CTRL_TYPE_INTEGER:
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

