Return-Path: <stable+bounces-135210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2512EA97AF7
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 01:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B7617EF24
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 23:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B3520127B;
	Tue, 22 Apr 2025 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PFWpnae/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4251EF39A
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745363918; cv=none; b=ZGMoBDziBtV7N/py+DV9fMGzHrwZ6kGllwxTI0r9fO90ZSI+8lN0qdqnztTbqZi09EYEVoaP0ymQCmZgGA+cEFVosYEAbLIBn1Ess4NEmbQKezSwQc/ZBvVj6O0G0fW/YN1dvKUCi31HCUZ3Apn9Q8P56l3XdbA+8obbZxUh6VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745363918; c=relaxed/simple;
	bh=QuB8Gjw+RfSX/s5bV7YLthr8S4ItqWWROGytUMe/6qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wvc9FcGLSw0Y/0Y95yDK2g7HlDDPdIVXwbE/ovF8AuzoDuiy4RL8+QBUAhhoiEzgj+2ENZAbn5SZAMF+3AEG99/p7nFdxAveBPUJINnAoN/iUO+UfO2rqLmeSxwPlQJptStI9sa+Hzy+GxCV2Om3HcbrOtycCQMHdVLqBbD2Mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PFWpnae/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5499c5d9691so6496408e87.2
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745363914; x=1745968714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TzfZueCNs06IErw8Nx2tIZlpeBLYieWxJQnlfkBvHwg=;
        b=PFWpnae/6kq795PZmcyXPBMNzesNHrW3oYqA5V+fgjMCxEJoZtePnZeTFJKnefHQ4H
         Jj34KQnpupKjLEQhO9KsF/QrvZtejCVFeup6MkqyzLrOIzpeZfDvaxmLAlmBaGpvb5nw
         lcLobWNEGXl7pnKH10V3EayF7w788bbTAmBMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745363914; x=1745968714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TzfZueCNs06IErw8Nx2tIZlpeBLYieWxJQnlfkBvHwg=;
        b=ESroChFqScM2gp3R+D15WiiRpeB3cp1zZ7Xrc03ieAYEyNfIl2S3/UqpbwDYCOcWME
         zki5hL/+yHAiW8eT0kaLMo08n17oKM1knQ0ARNk0Gz1lUZCsxl2TY+bVuNNOwsznIbKo
         2bsZ+HqunlD6mDtvDapzniyNpVJS4GCu0IwW1aclUIHzXZVcGjD26Y91Jqaybnw+BqkI
         OhR8o0JuouL3JFzugDfUnr7LD2AfSka5wpmXHEbbtxAFcHuT//BRBnWQJ3R8earG1Xlk
         Lnh/0wtE4rGPUYlZM05/Ksu6piYZ+kM75pSYvVJUCasl8n7AxuYFhlGG64hNIALA0KdZ
         o7og==
X-Forwarded-Encrypted: i=1; AJvYcCULJ53/bYs+w//wL/wKckZ9c2OjZE9y8cMIkQ/f9/3q7Ztdt0sVXJyI8ltAHChL2OhxFD0TrlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7L9ERHM0tiB+7JDwV2drKgAUqlCmib/gyTSgPAPgtvIkLxj/H
	KbmS75nHgtJ64oZ+Yo5hdQNXPLhhnWLhOvo4n9hLR+kIMwI4K8sued2EfouVA0aYlYlkEuLczxP
	bFw==
X-Gm-Gg: ASbGncuCfxsTJV4nKWVEF/GjKnWJBiqTsWqsbqu6rxFs7EI/iIJJLoIbdzEHzo46Cuv
	bJAW/0zwu9/agmkgYr4Mw0KrgBqmBama8z3NjiEXBmqzVo+3tK50LUJxXyyej8TGd6xXjH9KOpz
	n94z8u7fbW2fo4yK30yWubfzvoApXdQLEyicHZjTvOp1SwTlbSKZAbZHJUDuMo2MxbPTZ/+AHWp
	tXN2lom9oPK94UhXzXhpyFUWqghOne1WvRxBMWq3AJZlepI18cxuft08FZwO4T8RzlX47f5CGSL
	1C1iord4od3iKg1Ku0xWPiy5uYhJs0MbL6/Pzfif2rjqryrWkyVrv/DBmQuiEm1k3zEvOJanaCd
	ZEaHSAUM=
X-Google-Smtp-Source: AGHT+IEkf7MPMS7Ttgx9xV9c8Oe62/oYONEug6fWBG9m8En9ZdJ1DNsFvQmXxUgVyBTofmYLEuXL4Q==
X-Received: by 2002:a05:6512:3f24:b0:54a:f757:f8b3 with SMTP id 2adb3069b0e04-54d6e5566abmr4173328e87.0.1745363914176;
        Tue, 22 Apr 2025 16:18:34 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d6e540dc4sm1353540e87.70.2025.04.22.16.18.32
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 16:18:32 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30effbfaf4aso56489611fa.3
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:18:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzKxcKx8l9k5PTdc5C91YSp5xksYsmaKyQFVaJBLYxukmsyj5LffUl1+3duaiX9rm7LNJmfkU=@vger.kernel.org
X-Received: by 2002:a2e:bc82:0:b0:30b:b908:ce1e with SMTP id
 38308e7fff4ca-31090553f0dmr68294081fa.29.1745363911890; Tue, 22 Apr 2025
 16:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313-uvc-eprobedefer-v3-0-a1d312708eef@chromium.org>
 <20250313-uvc-eprobedefer-v3-1-a1d312708eef@chromium.org> <20250422180630.GJ17813@pendragon.ideasonboard.com>
 <CANiDSCuO+dHOBtW4yvy1n25QWEs-WdQ9H8Lh2rUtcPbUq3hBkQ@mail.gmail.com> <20250422230513.GX17813@pendragon.ideasonboard.com>
In-Reply-To: <20250422230513.GX17813@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 23 Apr 2025 07:18:18 +0800
X-Gmail-Original-Message-ID: <CANiDSCssyAVoyvsiO8thGwUFc_boA_jhBxYDif32Hxh40fhf-Q@mail.gmail.com>
X-Gm-Features: ATxdqUEDSEbHKCZeCwxeZY8tESjmDWJXIzIiNSsM2g3Q15qo52D4m0v7Y_22dXw
Message-ID: <CANiDSCssyAVoyvsiO8thGwUFc_boA_jhBxYDif32Hxh40fhf-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: uvcvideo: Fix deferred probing error
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 07:05, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Apr 23, 2025 at 06:50:10AM +0800, Ricardo Ribalda wrote:
> > On Wed, 23 Apr 2025 at 02:06, Laurent Pinchart wrote:
> > > On Thu, Mar 13, 2025 at 12:20:39PM +0000, Ricardo Ribalda wrote:
> > > > uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
> > > > have not yet been probed. This return code should be propagated to the
> > > > caller of uvc_probe() to ensure that probing is retried when the required
> > > > GPIOs become available.
> > > >
> > > > Currently, this error code is incorrectly converted to -ENODEV,
> > > > causing some internal cameras to be ignored.
> > > >
> > > > This commit fixes this issue by propagating the -EPROBE_DEFER error.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
> > > > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_driver.c | 27 +++++++++++++++++++--------
> > > >  1 file changed, 19 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > index deadbcea5e227c832976fd176c7cdbfd7809c608..e966bdb9239f345fd157588ebdad2b3ebe45168d 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -2231,13 +2231,16 @@ static int uvc_probe(struct usb_interface *intf,
> > > >  #endif
> > > >
> > > >       /* Parse the Video Class control descriptor. */
> > > > -     if (uvc_parse_control(dev) < 0) {
> > > > +     ret = uvc_parse_control(dev);
> > > > +     if (ret < 0) {
> > > > +             ret = -ENODEV;
> > >
> > > Why do you set ret to -ENODEV here...
> > >
> > > >               uvc_dbg(dev, PROBE, "Unable to parse UVC descriptors\n");
> > > >               goto error;
> > > >       }
> > > >
> > > >       /* Parse the associated GPIOs. */
> > > > -     if (uvc_gpio_parse(dev) < 0) {
> > > > +     ret = uvc_gpio_parse(dev);
> > > > +     if (ret < 0) {
> > > >               uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
> > > >               goto error;
> > > >       }
> > > > @@ -2263,24 +2266,32 @@ static int uvc_probe(struct usb_interface *intf,
> > > >       }
> > > >
> > > >       /* Register the V4L2 device. */
> > > > -     if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
> > > > +     ret = v4l2_device_register(&intf->dev, &dev->vdev);
> > > > +     if (ret < 0)
> > >
> > > ... but not here ? The code below is also not very consistant.
> >
> > For all the "external" functions I was looking into populating their
> > error code to probe(). Other drivers (check vivid for example) do
> > exactly this.
> >
> > There is more value in returning the real cause of the error (ENOMEM,
> > EINVAL) that the plain ENODEV.
>
> Yes, I got that, my question was why you override the return value of
> e.g. uvc_parse_control() or uvc_scan_device() with -ENODEV, but not for
> e.g. uvc_gpio_parse() or v4l2_device_register(). There's no explanation
> in the commit message regarding why they're treated differently.

Because it is less risky that way. There are plenty of examples where
the framework functions return code is passed to probe().

The uvc_* functions might or might not work this way. When I do that
assessment for every function I can post a different patch. I thought
that this approach was safer, especially if we are cc-ing stable.

A note in the commit message would have been a nice thing to have I agree :).


>
> > > >               goto error;
> > > >
> > > >       /* Scan the device for video chains. */
> > > > -     if (uvc_scan_device(dev) < 0)
> > > > +     if (uvc_scan_device(dev) < 0) {
> > > > +             ret = -ENODEV;
> > > >               goto error;
> > > > +     }
> > > >
> > > >       /* Initialize controls. */
> > > > -     if (uvc_ctrl_init_device(dev) < 0)
> > > > +     if (uvc_ctrl_init_device(dev) < 0) {
> > > > +             ret = -ENODEV;
> > > >               goto error;
> > > > +     }
> > > >
> > > >       /* Register video device nodes. */
> > > > -     if (uvc_register_chains(dev) < 0)
> > > > +     if (uvc_register_chains(dev) < 0) {
> > > > +             ret = -ENODEV;
> > > >               goto error;
> > > > +     }
> > > >
> > > >  #ifdef CONFIG_MEDIA_CONTROLLER
> > > >       /* Register the media device node */
> > > > -     if (media_device_register(&dev->mdev) < 0)
> > > > +     ret = media_device_register(&dev->mdev);
> > > > +     if (ret < 0)
> > > >               goto error;
> > > >  #endif
> > > >       /* Save our data pointer in the interface data. */
> > > > @@ -2314,7 +2325,7 @@ static int uvc_probe(struct usb_interface *intf,
> > > >  error:
> > > >       uvc_unregister_video(dev);
> > > >       kref_put(&dev->ref, uvc_delete);
> > > > -     return -ENODEV;
> > > > +     return ret;
> > > >  }
> > > >
> > > >  static void uvc_disconnect(struct usb_interface *intf)
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

