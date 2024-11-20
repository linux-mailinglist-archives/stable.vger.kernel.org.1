Return-Path: <stable+bounces-94437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 197A59D3FF6
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 17:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A23D1B2BA68
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A3C1AA7A6;
	Wed, 20 Nov 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hOcyI2tZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7628D1714CD
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116381; cv=none; b=C2ZC8dR5aY3gFvMcoMZYD1ohTr4Xacn6qtgt4StN5SQPgrDL1UHVE8x1yoZCz5ITROwWa7cYhuMqx9xZ+jgBxyOEBeOH2ecVnwzyW1l5IZT8QChwTkqPj7NHZ4kmeNKA9yuBTSuhiy+A/xG0mi0s5Ijzh+foALPNY+x0srF9rDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116381; c=relaxed/simple;
	bh=aEpeVL2+MvWMIJH2w921LzuXKvdlr+VXZnWB0rIrw7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTMqna8rx2Zjkz2neqXA26mkVTpCDXLv4GatJ0JjrB+qUSEpd2O1NQYzHfjuXaz/CykaCkR41lBuhyjaVEO0EoO1HZj4MvrxNqi9tq4rtBEusM6QfaRMaTJiLmNDvCX4oy4WFRZQM2IgN48zhJgUWdDHu8VxPl2hx0U8P3VnBG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hOcyI2tZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1804515b3a.3
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 07:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732116378; x=1732721178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aiMUFCvmVqIUzNlDz47PSTDNdFjqdtwhxW4WFLT6+Bw=;
        b=hOcyI2tZ3BVEJ5xE9jFYEhgU15hOzPi3Ws2g2YZhrTcN19ZUegdJsZY9PaHcHQOpit
         /StXogj6Vh6PiTGywKOBKWBSLhTX5BvpbqjPqG4YgNWcTsepa4QIhiaP9VwVchVzvYgT
         43HcXzvw67Lz8RyekUUhY0YJAnVyznwB50GCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116378; x=1732721178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiMUFCvmVqIUzNlDz47PSTDNdFjqdtwhxW4WFLT6+Bw=;
        b=nS0/a3mi1GuuODb0sbMsOKElqka+9Ftz0+9c57kZAn7lYbno6LBmEFMPIi7M5tGUP5
         5diLbp6SNxco2+4NniIkes+iaBn/ETLvnKUmYHH1eC91cVwkZNEffrmwwC/URbFkjtrs
         DgsCEsb1E7VrSd5zHFNLczblWF1EIJzWxIc9FWFQCb9OA+nOuxIzvYmRxHONLB9RF73k
         dr3mRj+7rFvJt34EgCBL06FYV9/Dl7Z/de7ULOL8Ja3rhb2tLchPM2zFt6cmRaUQdrHM
         lgfFsmHTijhS+1lRFz191kt9z9Sk8SHwMN53BKjAWMSXIvLUJ010OHWOuPgyaAv5zjLx
         6OUg==
X-Forwarded-Encrypted: i=1; AJvYcCXGUBBPPQLqTY8McMJvGVTzyNws1SU6QM+Rts8Kka1BuVGHclQX1VTnKY7o5sVM8No9FC7W8aU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLY1EU8Lua0vSp1eI+9bLZEfXgq9yG0EYnzCdMhHvyvsWKx8C/
	LKcivrdubn/xmtnYON8+eG0CnK3oMTN5wFrrB8inKKoV/pVRI1nzoyj9JVPE72nhVWU3bsgYkw8
	=
X-Gm-Gg: ASbGncuJV/gF4bI1RDl+e7LrWBkdvsaouGtu5SHEH0KyXig5ARxgUKInARy7x24YOEV
	slWTJMIa3tsyzOCm0AmXOJeEzNjtjAgIFPdHZ6Ya69Tw6TTkKAw/ODSkGr/qXAIIGVA3y6hf7JU
	KmtniWzi55yY0f9U2EHEDTQ7JBmpClAKaR1X5MWW4WGBNLjv14Mn6ShMWdOrv/D4yXWil5SWJbo
	8w9J7dWVpidQ89W+cO7RxWUFEdGJy0y8yGJKzB1SHCgLv+Exvzc5/z+qh7yhZxWLIsB10Z7RUDZ
	KyrcAph6ooe1Fny6
X-Google-Smtp-Source: AGHT+IEcOG9RwUTnoZApKmhd0EpWgVJhA4GiysFfDXzMTlfmVYs/QRA2i+WpMz70cnNh0FSFrI+mig==
X-Received: by 2002:a05:6a00:1305:b0:71e:7ab6:8ea6 with SMTP id d2e1a72fcca58-724bedc52a0mr3828287b3a.25.1732116378403;
        Wed, 20 Nov 2024 07:26:18 -0800 (PST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com. [209.85.210.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beeb84e5sm1761028b3a.37.2024.11.20.07.26.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 07:26:16 -0800 (PST)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72410cc7be9so2158121b3a.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 07:26:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX/CogBV2P/5zRphSTkYErQYmjAXxSPx3vLB2adX6IHtf6Ee2vZOHPH+8wISpzoTk/lvdSmkOk=@vger.kernel.org
X-Received: by 2002:a05:6a00:2355:b0:71d:eb7d:20d5 with SMTP id
 d2e1a72fcca58-724beca42camr4163959b3a.8.1732116376003; Wed, 20 Nov 2024
 07:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
 <20241118-uvc-readless-v3-1-d97c1a3084d0@chromium.org> <20241120140526.GW12409@pendragon.ideasonboard.com>
 <CANiDSCvazZ4Y3OZ9X7chU-_N-4HbeQKUh23eOWkmkAxGaks2QA@mail.gmail.com> <20241120145341.GX12409@pendragon.ideasonboard.com>
In-Reply-To: <20241120145341.GX12409@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 20 Nov 2024 16:26:04 +0100
X-Gmail-Original-Message-ID: <CANiDSCtX9pPS=YLmeCLerbcuvQEwbNiGX4uod=iLSNJnQ9-tQg@mail.gmail.com>
Message-ID: <CANiDSCtX9pPS=YLmeCLerbcuvQEwbNiGX4uod=iLSNJnQ9-tQg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: uvcvideo: Support partial control reads
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 15:53, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 20, 2024 at 03:43:22PM +0100, Ricardo Ribalda wrote:
> > On Wed, 20 Nov 2024 at 15:05, Laurent Pinchart wrote:
> > > On Mon, Nov 18, 2024 at 05:16:51PM +0000, Ricardo Ribalda wrote:
> > > > Some cameras, like the ELMO MX-P3, do not return all the bytes
> > > > requested from a control if it can fit in less bytes.
> > > > Eg: Returning 0xab instead of 0x00ab.
> > > > usb 3-9: Failed to query (GET_DEF) UVC control 3 on unit 2: 1 (exp. 2).
> > > >
> > > > Extend the returned value from the camera and return it.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: a763b9fb58be ("media: uvcvideo: Do not return positive errors in uvc_query_ctrl()")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 16 +++++++++++++++-
> > > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index cd9c29532fb0..e165850397a0 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -76,8 +76,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > > >
> > > >       ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> > > >                               UVC_CTRL_CONTROL_TIMEOUT);
> > > > -     if (likely(ret == size))
> > > > +     if (ret > 0) {
> > > > +             if (size == ret)
> > > > +                     return 0;
> > >
> > > Why is this within the ret > 0 block ? I would write
> > >
> > >         if (likely(ret == size))
> > >                 return 0;
> > >
> > >         if (ret > 0) {
> > >
> > > > +
> > > > +             /*
> > > > +              * In UVC the data is represented in little-endian by default.
> > >
> > > By default, or always ?
> > >
> > > > +              * Some devices return shorter control packages that expected
> > >
> > > What's a "control package" ?
> >
> > usb control transfers.
>
> Ah, did you mean "packet" instead of "package" ?
>
> > > I think you meants "than expected", not "that expected".
> > >
> > > > +              * if the return value can fit in less bytes.
> > > > +              * Zero all the bytes that the device have not written.
> > > > +              */
> > >
> > > Do we want to apply this workaround to GET_INFO and GET_LEN, or can we
> > > restrict it to GET_CUR, GET_MIN, GET_MAX and GET_RES ?
> >
> > I believe that the original behaviour before
> > a763b9fb58be ("media: uvcvideo: Do not return positive errors in
> > uvc_query_ctrl()")
> > was used for all types. I think the safest thing to do is to go back
> > to the old behaviour.
>
> I don't see how reverting that commit would help, or how that's related
> to the question at hand.
>
> I understand the device you're dealing with shortens transfers for
> integer values when they would contain leading 0x00 bytes. The
> workaround should be OK when retrieving the control value or its limits
> and resolution. I wonder if it would be dangerous for GET_INFO, which
> retrieves a bitmask. Does the device you've tested this with skip the
> MSB for GET_INFO as well ?

I have not seen it mangling GET_INFO. Let's exclude GET_INFO it from
the quirk then.



>
> Conceptually GET_LEN could be similarly excluded from the workaround,
> but it will never take this code path as it's a 1 byte value.
>
> > Let me know what you prefer.
> >
> > > > +             memset(data + ret, 0, size - ret);
> > > > +             dev_warn_once(&dev->udev->dev,
> > > > +                           "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > > > +                           uvc_query_name(query), cs, unit, ret, size);
> > > >               return 0;
> > > > +     }
> > > >
> > > >       if (ret != -EPIPE) {
> > > >               dev_err(&dev->udev->dev,
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

