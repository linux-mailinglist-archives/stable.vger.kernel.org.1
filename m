Return-Path: <stable+bounces-93814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C939D1692
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BCE1F22508
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE40A1C07DA;
	Mon, 18 Nov 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gi4e7kLa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE71B21A0
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949091; cv=none; b=RZLvRszedXesQ8t+TuOit1QhJ9kI98MkitpexhwAaNepsSa3FSrbstWz8KtX3JjR8CTyYNbnlviiUAwhP4BjoabzEeD8zyrd6xmMfAO+k+aOOENmufRT/pcF7a9q2IEH1+MKsDau2FI6xan1DwebBQ9ClK4162FxUOoyiunUlc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949091; c=relaxed/simple;
	bh=b+qjRPJJgFh/DH2mn8cdZ+TY0xPgQ1QeLHwseux++Tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bugD9I8K59HbfXDjqib3k9vVsv5716uuRpqJMCsXK9TsXiTXEu9T7acI5JbvBybXz0Qh8EJazL917ehZ/a2h70A2XoCs0NvFI6zcbnbPHNgE60jcYm1yb3Yn9lhMlEa0aoBhb9gDNp0l0FDC0W1Ff37+l8BoBdQUpv7ba1Q3RvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gi4e7kLa; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71811c7eb8dso865981a34.0
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 08:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731949085; x=1732553885; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M67tOapBFVJdyFLK/dKrm6uvvMAbWzWdqgLPM/DLv6o=;
        b=gi4e7kLaucGzLNNAjqxFpxvtpV97N4rkAi415MnYbVkHbfSQZPx0BOO9wtohlQYxFK
         ZRLE45soaabRl0xmp/sFnycB4qPxSk6j9Hlu0hY2e93drRClY+CUgGfjeLaD6Jumek9+
         d5NqfzzY2A2/7VKvpVO6gD3hn2VtFxnUNyiqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949085; x=1732553885;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M67tOapBFVJdyFLK/dKrm6uvvMAbWzWdqgLPM/DLv6o=;
        b=miXhL2ZGLF2773ha0S8yUJucGY7tGqEa3e/4Bj1jJayv76FIUi32MwukWIIH2V/k4w
         35Kf0VV59u9a8AX9Wo55d8O2Em5NWPonHTLxHqebZH4tEfTKV+bzKGSLbuxPhWHlNV5W
         1z+b/Dbbh235EVsu2eKXHr2075W5eHl5RTAf44+PweE12rQicj0RCSzF5XURnLQVBI09
         +pMUsAHdoD3PTzPNtY+WrB5ejxvhs9R6e67b2l3ZzGc7YMcdgqRHKM8llb1e/I2Sb1Au
         pl5O3svc3aJnmRl92KNaBcwbyJG4kADzc3PSawyxdJ5vXo2S0+9BvahSxjvyMY3WYPNc
         p/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBBEQHXCSY5jEnYGEvw3YPqdaEgTmzaO9+Ojs86GA0ZccV7LhbIulLWt4oxpggjFNC3Ul7xxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn+vCC10eGXkI1zNvtHLLM14g9Bnu9ocT324qa89zzc2hiwAQY
	PiitzjI0pq7oKhfoop8ngjQEKtdRiaibDak+zsxQ7ceuKAMfK2ItjB9dUVwZvZvguFbx5ufjA3k
	=
X-Google-Smtp-Source: AGHT+IHanMLSk+1wsrPrAXI0My4QYNsFFvwimoSwyvj5VRT1Ob7z4jbkBiMAzHkLqecaUEPAW1zRkw==
X-Received: by 2002:a05:6830:6811:b0:710:ec4a:b394 with SMTP id 46e09a7af769-71a77a075f2mr11770131a34.29.1731949084913;
        Mon, 18 Nov 2024 08:58:04 -0800 (PST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c63d3asm6170030a12.44.2024.11.18.08.58.03
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 08:58:03 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72061bfec2dso1759302b3a.2
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 08:58:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEuQGN5sz0PE7MUg/ZeXlXLaNsy36qTFUS6/XOEIUuxQIegzmgLIlIvISuXIZD17AlFHMuYUQ=@vger.kernel.org
X-Received: by 2002:a05:6a00:1902:b0:724:6bac:1003 with SMTP id
 d2e1a72fcca58-7247709df42mr18330165b3a.24.1731949082889; Mon, 18 Nov 2024
 08:58:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-uvc-readless-v2-0-04d9d51aee56@chromium.org>
 <20241008-uvc-readless-v2-1-04d9d51aee56@chromium.org> <5a5de76c-31a4-47af-bd31-b3a09b411663@redhat.com>
In-Reply-To: <5a5de76c-31a4-47af-bd31-b3a09b411663@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 18 Nov 2024 17:57:49 +0100
X-Gmail-Original-Message-ID: <CANiDSCtXfdCT=-56m9crxW6hmVjuqBKvRE3NRQBf7nftW=OpNg@mail.gmail.com>
Message-ID: <CANiDSCtXfdCT=-56m9crxW6hmVjuqBKvRE3NRQBf7nftW=OpNg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Support partial control reads
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 17:41, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> Thank you for your patch.
>
> On 8-Oct-24 5:00 PM, Ricardo Ribalda wrote:
> > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > requested from a control if it can fit in less bytes.
> > Eg: Returning 0xab instead of 0x00ab.
> > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> >
> > Extend the returned value from the camera and return it.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index cd9c29532fb0..f125b3ba50f2 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -76,14 +76,29 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >
> >       ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> >                               UVC_CTRL_CONTROL_TIMEOUT);
> > -     if (likely(ret == size))
> > +     if (ret > 0) {
> > +             if (size == ret)
> > +                     return 0;
> > +
> > +             /*
> > +              * In UVC the data is represented in little-endian by default.
> > +              * Some devices return shorter control packages that expected
> > +              * for GET_DEF/MAX/MIN if the return value can fit in less
> > +              * bytes.
>
> What about GET_CUR/GET_RES ? are those not affected?
>
> And if it is not affected should we limit this special handling to
> GET_DEF/MAX/MIN ?

I have only seen it with GET_DEF, but I would not be surprised if it
happens for all of them.

before:
a763b9fb58be ("media: uvcvideo: Do not return positive errors in
uvc_query_ctrl()")
We were applying the quirk to all the call types, so I'd rather keep
the old behaviour.

The extra logging will help us find bugs (if any).

Let me fix the doc.

>
>
> > +              * Zero all the bytes that the device have not written.
> > +              */
> > +             memset(data + ret, 0, size - ret);
>
> So your new work around automatically applies to all UVC devices which
> gives us a short return. I think that is both good and bad at the same
> time. Good because it avoids the need to add quirks. Bad because what
> if we get a short return for another reason.
>
> You do warn on the short return. So if we get bugs due to hitting the short
> return for another reason the warning will be i the logs.
>
> So all in all think the good outways the bad.
>
> So yes this seems like a good solution.
>
> > +             dev_warn(&dev->udev->dev,
> > +                      "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > +                      uvc_query_name(query), cs, unit, ret, size);
>
> I do wonder if we need to use dev_warn_ratelimited()
> or dev_warn_once() here though.
>
> If this only impacts GET_DEF/MAX/MIN we will only hit this
> once per ctrl, after which the cache will be populated.
>
> But if GET_CUR is also affected then userspace can trigger
> this warning. So in that case I think we really should use
> dev_warn_once() or have a flag per ctrl to track this
> and only warn once per ctrl if we want to know which
> ctrls exactly are buggy.

Let me use dev_warn_once()

>
> What we really do not want is userspace repeatedly calling
> VIDIOC_G_CTRL / VIDIOC_G_EXT_CTRLS resulting in a message
> in dmesg every call.
>
> >               return 0;
> > +     }
> >
> >       if (ret != -EPIPE) {
> >               dev_err(&dev->udev->dev,
> >                       "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
> >                       uvc_query_name(query), cs, unit, ret, size);
> > -             return ret < 0 ? ret : -EPIPE;
> > +             return ret ? ret : -EPIPE;
>
> It took me a minute to wrap my brain around this and even
> though I now understand this change I do not like it.
>
> There is no need to optimize an error-handling path like this
> and IMHO the original code is much easier to read:
>
>                 return ret < 0 ? ret : -ESOMETHING;
>
> is a well known pattern to check results from functions which
> return a negative errno, or the amount of bytes read, combined
> with an earlier success check for ret == amount-expected .
>
> By changing this to:
>
>                 return ret ? ret : -EPIPE;
>
> You are breaking the pattern recognition people familiar with
> this kinda code have and IMHO this is not necessary.
>
> Also not changing this reduces the patch-size / avoids code-churn
> which also is a good thing.
>
> Please drop this part of the patch.
ack
>
> Regards,
>
> Hans
>
>


-- 
Ricardo Ribalda

