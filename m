Return-Path: <stable+bounces-94426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4029D3DCF
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2204284B02
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84EE1A9B5A;
	Wed, 20 Nov 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V2eiVaol"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ADB1AC423
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113819; cv=none; b=D2ijf58hiIQz7gqXeUyADdAISIpoQ+Lz+6CH2yd7Ili99TD+YMp3ErlA6G2agpVN/g++WSkgXqDX5RaRCBhIm+fIP2spWhjSTeJvVJchV6e+ef9XIAohtz31fIRcF9fbogKg5wPmfrJSzOvQO+BzWlOw9Cx4nYizTNtcLJOKodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113819; c=relaxed/simple;
	bh=3H0qJXOUKg7BZKQpQxV+nwwmTnCQUnU4BeIQFsGiWSs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrfCrcgT+UOXraKcKGRylT2emqFDdM3afG5zQrMd3dbfPENVit+kxubtPPYRrWVNdggVB70qyAKlbdhlSXaaXb+1730r+M+fMDjaOtRs4WF4pjUpFnkAtz7PRsWeik54lPB7hdr7KlBFE2zAVrU3tOthD1c/0aSzQl4pMAV4SQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V2eiVaol; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso4638567a12.3
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 06:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732113816; x=1732718616; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r2sFP2NARD2FOImCkIlq0O7UZoSIEEdwWYR8ebMsnZM=;
        b=V2eiVaolQu4fccQ3F50ghvTq/VMQjUFyb0Bs+/xs1wgMDepi3QiziyjxEVb9d9QoCe
         lUWL7BxcYCKdYrfuJ2mNwjhOct80YAjcQ+EAAPzZt6z8Pq7I3gT/ciJPIvrkSzfff7Xx
         tqtfKBy1IfA6j6aRiN9QyyiR5Xv0MKgYlIpoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732113816; x=1732718616;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r2sFP2NARD2FOImCkIlq0O7UZoSIEEdwWYR8ebMsnZM=;
        b=bGRkBD5qquvAE/Ngn6XecMYDMh0POhAq/F4mtiQlUyOYKspgeAGnLc6PK7HZQc5DB6
         nbxP3iMqXAHbgpdDwzpMBhBlHX0FKwQQKdPCSUPC+cbphssnFVNNDNqj0tQW+CcUy1Eb
         kH3/O6HmTfA+ujpT1a7pDu+/iKR8zwQj1k9lsCHqOq5V0GLcqcbxTE2POoZKQDHuMmwo
         StEr1m//DKb1IDPs4GxhL3/zOz2IJuG7xHS0+GqNSZzSW0NRzbQ3lxwx8950GrIXTf0R
         4a9P6JZ61JtYCSK2znl1LL0ihvWANocyIUpktSUHtQXp/i6VFjCS1F8YezRPaVjtKlSi
         b2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbEFplqNZltcQHHWtn8svYBBXBwrLPuLt9bLkDymiIndlus9Ktu/JwHq4qqDOwiBnb0cno898=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxSsrY2eDh9mHcie/H3aOAcjucW3+thHckwDYGOZ4Y5BomBtKL
	XyMBv5MNJg8sIyP9AQrYcKS3ieQsb4rJtm6hfzaCWpaIFv6xDj+BJJcU/cdLU/+gr7rtoEnMcxM
	=
X-Google-Smtp-Source: AGHT+IH34bgvxhr7o7H4s3hF0sovl+wsyEOrRjWOIg3/f5ZNwQmjdBtGe41K3v6bU/Kh+YoyRv4WEQ==
X-Received: by 2002:a05:6a20:4327:b0:1d9:c5ad:c995 with SMTP id adf61e73a8af0-1ddae00ae07mr4346711637.9.1732113815794;
        Wed, 20 Nov 2024 06:43:35 -0800 (PST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com. [209.85.215.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f470adsm92679705ad.188.2024.11.20.06.43.34
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:43:34 -0800 (PST)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7f8b37edeb7so5153436a12.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 06:43:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8W9cPLYDs4uJ0rAmX8/cZIeqxSz9fSlolYcWcjUoDn/R+KWubXXE5tEauOYsXgaHoW+qNVTo=@vger.kernel.org
X-Received: by 2002:a05:6a20:9f09:b0:1db:d980:440e with SMTP id
 adf61e73a8af0-1ddae5e0c52mr4938722637.14.1732113813781; Wed, 20 Nov 2024
 06:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-uvc-readless-v3-0-d97c1a3084d0@chromium.org>
 <20241118-uvc-readless-v3-1-d97c1a3084d0@chromium.org> <20241120140526.GW12409@pendragon.ideasonboard.com>
In-Reply-To: <20241120140526.GW12409@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 20 Nov 2024 15:43:22 +0100
X-Gmail-Original-Message-ID: <CANiDSCvazZ4Y3OZ9X7chU-_N-4HbeQKUh23eOWkmkAxGaks2QA@mail.gmail.com>
Message-ID: <CANiDSCvazZ4Y3OZ9X7chU-_N-4HbeQKUh23eOWkmkAxGaks2QA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: uvcvideo: Support partial control reads
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Wed, 20 Nov 2024 at 15:05, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, Nov 18, 2024 at 05:16:51PM +0000, Ricardo Ribalda wrote:
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
> >  drivers/media/usb/uvc/uvc_video.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index cd9c29532fb0..e165850397a0 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -76,8 +76,22 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >
> >       ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> >                               UVC_CTRL_CONTROL_TIMEOUT);
> > -     if (likely(ret == size))
> > +     if (ret > 0) {
> > +             if (size == ret)
> > +                     return 0;
>
> Why is this within the ret > 0 block ? I would write
>
>         if (likely(ret == size))
>                 return 0;
>
>         if (ret > 0) {
>
> > +
> > +             /*
> > +              * In UVC the data is represented in little-endian by default.
>
> By default, or always ?
>
> > +              * Some devices return shorter control packages that expected
>
> What's a "control package" ?

usb control transfers.
>
> I think you meants "than expected", not "that expected".
>
> > +              * if the return value can fit in less bytes.
> > +              * Zero all the bytes that the device have not written.
> > +              */
>
> Do we want to apply this workaround to GET_INFO and GET_LEN, or can we
> restrict it to GET_CUR, GET_MIN, GET_MAX and GET_RES ?

I believe that the original behaviour before
a763b9fb58be ("media: uvcvideo: Do not return positive errors in
uvc_query_ctrl()")
was used for all types. I think the safest thing to do is to go back
to the old behaviour.

Let me know what you prefer.


>
> > +             memset(data + ret, 0, size - ret);
> > +             dev_warn_once(&dev->udev->dev,
> > +                           "UVC non compliance: %s control %u on unit %u returned %d bytes when we expected %u.\n",
> > +                           uvc_query_name(query), cs, unit, ret, size);
> >               return 0;
> > +     }
> >
> >       if (ret != -EPIPE) {
> >               dev_err(&dev->udev->dev,
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

