Return-Path: <stable+bounces-135208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B06A97AB1
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 00:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB84A16815D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A26244677;
	Tue, 22 Apr 2025 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QXaW4SZC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1602C256C
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745362232; cv=none; b=m9uTNDjFIzQBHL89vjs3p06ewBHyeS+wgb/mr0Q4o5H32eP6uUV3xI5LntIO4YQ8fUQOmAGV+j3gN3ZA8+gFahLcwjMrdNjeBacvRXeY/zWZAkDBAAMzXtrOYhOe+wlnB3yDSMDRXj5v92PGjmBr4Sto9OP5RyOrY1br5q7u81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745362232; c=relaxed/simple;
	bh=a4EcOav03n+HBGzNSNuTxKZNDu09J/N3p9II0SkD8xQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luSFPm/dhzVJv0lfJ9MKV+9dHqGMmr3odakWKrEkMTNmxGT62jC1kK9W8cRwvfd6jF1ReaYkFMeVQ7ODh8tNIAtpdYNvGz0MLcKzsAa1haqdMSI0Yn8tWLJemwbCnwefqM+dpPbophAuAExHRIVdBP3QnvKct8AgA2T1J4Du1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QXaW4SZC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30eef9ce7feso56243801fa.0
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745362228; x=1745967028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oZCFkPT9VQDSYU37yasnvmuyi6JQuptLSL8TbX1/xkM=;
        b=QXaW4SZC5MRGYVpzH3y8jXhPTiv1HLkKUSBxEyn3rMw6jYiy8CWU2VT76bTi1jB2Xk
         +tUZ71aH6L2NiHp9In7NaWelLrw6oMlRs0XH36fAhWyzmGJXz8KIr2kh+CNpCURDXTOV
         J+wMhfHjM6rhkuSm3yjv/fW0pqW9sFJGMWXXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745362228; x=1745967028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZCFkPT9VQDSYU37yasnvmuyi6JQuptLSL8TbX1/xkM=;
        b=iDRyci69MdE56oRy6WbxyCQYarLAx2c0bVKBCY5ol03QuSHwW4a5r14IPbvO4IlcSe
         1iJnBV7BollnUSOcHvkK9E/YZhdU4fpttU7T8ksUBJEj8gtgXvXUhZZcZObbnHXT1GVQ
         H1tlU9DJaiCz0J85vwv548eiddWG/q2E3QYZWUBJAdQ/yyqjGYmPbRXKxxgaeN2qxoPs
         NZWnnmreoC9prNp8qMwx6GIOGZ6kvmRqYaB+keZHKNKIXUTTFsKY2eepYHTOmC2ozqGr
         D1uOXs8lI/VbsK7MpnVIKgjCWge5KIusg1vQRcLt4OMxixaLPqXQoxfi5lc/ksQZzzN/
         3+pw==
X-Forwarded-Encrypted: i=1; AJvYcCXH3IZWj1EVGZ5o7yAdjNxoG3yXO7OjtTjVWcRtJ6RbERjTR3B/4AxnWyjhS7Tu10l/zNG319Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCSwg2E3H+Ovd68m3fdHvTMjmaj9Ru4C7Bzx7JGgL43bxMvy2
	U9LfmzAtgyIPKp1J4fi2jRffWA+14GzKBPDDV2eNsPpLy4CD5DgfCR+oHkgvAUUftolzeYTs4yV
	x4A==
X-Gm-Gg: ASbGncuMvrFkiml/7rA9KVuXXYld83L+Msyywdz6EmYZgkFiTHToS6WrBSDswLPOGMJ
	9Xx4ElvRpFqf1vh8pu8CWNwZVyTfI59TfsoZLo5HYQFhq8/ZEnGvUXNoCb1moXbB5MpP81CZ/OG
	Ul+I77hqGjS7DHZCAouN8ikYS7Z/zm6iwafcB1PyZDLAetkSD1ed2zyEa2pKDTX8IFlqGsPOtkI
	AZmbaqgAaOo82KZcNHCuCXoxO7FUbph4vDQmDBSHX48lXVyZ5/o4BXI6FDtnqS2GWwFycTMO7tT
	moN1P083vb7LUg4p2bUBCl+73Md3pLXod+2Ill0Yn61Ss+e9mJ4nYDyFouxyVP2hkpYwOEXcdmM
	BY4Lg3uRlN/oeu1Tc+w==
X-Google-Smtp-Source: AGHT+IFZCoB6AYKRleeFiqN+6XeRUQ3mW76uJEvg5ysmTzLLZ4phHgWh0DFCwxhLW0s8rk3zO1+cEA==
X-Received: by 2002:a2e:a906:0:b0:308:e8d3:7578 with SMTP id 38308e7fff4ca-310905791b4mr47022821fa.35.1745362228208;
        Tue, 22 Apr 2025 15:50:28 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-310907844f3sm16047901fa.38.2025.04.22.15.50.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 15:50:26 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30db3f3c907so51797531fa.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:50:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0KFUg9qg1G65QVAbcUMe9nAjkZEqulsEVnVwhgMuOKq+JAeXWo/jXU6H5uhQ7/yoWnYGU1cY=@vger.kernel.org
X-Received: by 2002:a05:651c:220e:b0:30d:e104:b594 with SMTP id
 38308e7fff4ca-31090579a68mr48817081fa.40.1745362224964; Tue, 22 Apr 2025
 15:50:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
 <20250313-uvc-eprobedefer-v3-1-a1d312708eef@chromium.org> <20250422180630.GJ17813@pendragon.ideasonboard.com>
In-Reply-To: <20250422180630.GJ17813@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 23 Apr 2025 06:50:10 +0800
X-Gmail-Original-Message-ID: <CANiDSCuO+dHOBtW4yvy1n25QWEs-WdQ9H8Lh2rUtcPbUq3hBkQ@mail.gmail.com>
X-Gm-Features: ATxdqUHelesrjtdLbpQ4wqs-_HLIDR_oOasDUe41GrOFPkA28vVRIy-nBpD1INE
Message-ID: <CANiDSCuO+dHOBtW4yvy1n25QWEs-WdQ9H8Lh2rUtcPbUq3hBkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: uvcvideo: Fix deferred probing error
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 02:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Thu, Mar 13, 2025 at 12:20:39PM +0000, Ricardo Ribalda wrote:
> > uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
> > have not yet been probed. This return code should be propagated to the
> > caller of uvc_probe() to ensure that probing is retried when the required
> > GPIOs become available.
> >
> > Currently, this error code is incorrectly converted to -ENODEV,
> > causing some internal cameras to be ignored.
> >
> > This commit fixes this issue by propagating the -EPROBE_DEFER error.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 27 +++++++++++++++++++--------
> >  1 file changed, 19 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index deadbcea5e227c832976fd176c7cdbfd7809c608..e966bdb9239f345fd157588ebdad2b3ebe45168d 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2231,13 +2231,16 @@ static int uvc_probe(struct usb_interface *intf,
> >  #endif
> >
> >       /* Parse the Video Class control descriptor. */
> > -     if (uvc_parse_control(dev) < 0) {
> > +     ret = uvc_parse_control(dev);
> > +     if (ret < 0) {
> > +             ret = -ENODEV;
>
> Why do you set ret to -ENODEV here...
>
> >               uvc_dbg(dev, PROBE, "Unable to parse UVC descriptors\n");
> >               goto error;
> >       }
> >
> >       /* Parse the associated GPIOs. */
> > -     if (uvc_gpio_parse(dev) < 0) {
> > +     ret = uvc_gpio_parse(dev);
> > +     if (ret < 0) {
> >               uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
> >               goto error;
> >       }
> > @@ -2263,24 +2266,32 @@ static int uvc_probe(struct usb_interface *intf,
> >       }
> >
> >       /* Register the V4L2 device. */
> > -     if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
> > +     ret = v4l2_device_register(&intf->dev, &dev->vdev);
> > +     if (ret < 0)
>
> ... but not here ? The code below is also not very consistant.

For all the "external" functions I was looking into populating their
error code to probe(). Other drivers (check vivid for example) do
exactly this.

There is more value in returning the real cause of the error (ENOMEM,
EINVAL) that the plain ENODEV.

>
> >               goto error;
> >
> >       /* Scan the device for video chains. */
> > -     if (uvc_scan_device(dev) < 0)
> > +     if (uvc_scan_device(dev) < 0) {
> > +             ret = -ENODEV;
> >               goto error;
> > +     }
> >
> >       /* Initialize controls. */
> > -     if (uvc_ctrl_init_device(dev) < 0)
> > +     if (uvc_ctrl_init_device(dev) < 0) {
> > +             ret = -ENODEV;
> >               goto error;
> > +     }
> >
> >       /* Register video device nodes. */
> > -     if (uvc_register_chains(dev) < 0)
> > +     if (uvc_register_chains(dev) < 0) {
> > +             ret = -ENODEV;
> >               goto error;
> > +     }
> >
> >  #ifdef CONFIG_MEDIA_CONTROLLER
> >       /* Register the media device node */
> > -     if (media_device_register(&dev->mdev) < 0)
> > +     ret = media_device_register(&dev->mdev);
> > +     if (ret < 0)
> >               goto error;
> >  #endif
> >       /* Save our data pointer in the interface data. */
> > @@ -2314,7 +2325,7 @@ static int uvc_probe(struct usb_interface *intf,
> >  error:
> >       uvc_unregister_video(dev);
> >       kref_put(&dev->ref, uvc_delete);
> > -     return -ENODEV;
> > +     return ret;
> >  }
> >
> >  static void uvc_disconnect(struct usb_interface *intf)
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

