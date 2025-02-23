Return-Path: <stable+bounces-118689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC024A41148
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 20:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D61A3A7FF3
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 19:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AA15747D;
	Sun, 23 Feb 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jT86Dv4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D412111
	for <stable@vger.kernel.org>; Sun, 23 Feb 2025 19:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740339163; cv=none; b=XqALFX5vvU8HqrDg9NUKqDCwedIEDUl5AWqqgJAMdfsneqO4BSIkTF73XwQPQ5B8VG6k6Y1C5H6rqvqkNN3SNVxMFeOGHls96Hpau8WNnRg8qTVKFF+Gsh8z5ZrW4wDkPO77gVqq0oEmAg521rr3N+2iDp4roKdPDgxkkuq+xyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740339163; c=relaxed/simple;
	bh=ZAUvJY754rggryTC2ahWK68Vo7OkVEGJzzBE/hxnpps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eT4sW6OEgviTFJF+wa+0wQnT1581a3/5l0ncGsCVAzY20GYgD/2iKiar1mCQvQqzadDQoJ3swGMGWTcELi88YboENfCmzan0KAxO8/b4jl07tFPNm8kIH6pQpiGyFlDxVaMCd8diS1XXpwp6VF92OO7HYRGgm3I6Z+hdrlAupuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jT86Dv4O; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30a2594435dso47925321fa.1
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 11:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740339159; x=1740943959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7zznMgxYxrARWKQINL/Oo45oo2+34QKcLqU//MIFPe8=;
        b=jT86Dv4OHhwYLGguBWE/Mh0MwSi1My86S9T1Kn3pHbTgaaCYfgcA2k+cKvAhEon9Z2
         s+M+MMTTb6M30X6piQfTT+Kv7ZRSjp0kX8FGzGE4/1Gm1WkytdwODv5VGcpoEPsUPw/t
         x4kre238MRruHfow31QWteIuULUBvcqbmWaAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740339159; x=1740943959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zznMgxYxrARWKQINL/Oo45oo2+34QKcLqU//MIFPe8=;
        b=Y/1rWAhcsSXtvSgcikuraiStoYpFjiRaAPXqlGf4k8y3ATnCAunW7Yi7aLnS07pCpM
         tglFj45r1J+tBgd8qNNwK4Z3WgvronR0byU6lFQesq+gHztVqZHSl09rGSm7fQz85EN6
         bWPuxVD5ex7EstKxO2xtZlmTSWUPQxi7LxSPUA83K8SThcOi2vWPDsq3YIXLao6ooU//
         5xeXLVWmrn1ftEUrHEYN9H9g8K4Dx93aG548MaMPjqjsRlsxcgQzjiNt+0pQwrLK1tPr
         Fy4DCCF9kks9mVzLsigM9HFfmo0hbHmXkaPiWKVVjfZueVjQgHAGEkAVeoOouJSTNi4I
         xpEg==
X-Forwarded-Encrypted: i=1; AJvYcCXOq/rUcWLymuTs1Y4wGJtZy41JnMUNzOjLnLxgHmYuYmk3gJELV0VY7c/NV/+7Jv2niD6hx6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCDp+1TlLJQXyAyiYA2vlcPC0XH+00nBBUJHkhH6aA+PMNVy/7
	SWYBVhAoKRC4mgr4v3vcfmb7MoyJwBvX2KRLkLgfDJ0BRMlH4CaLU6/GbDZfEBEjndp/ki3No7S
	XOg==
X-Gm-Gg: ASbGncs1vhfG9mumWABcyVn+tE0+qUJ0YR/M2xfOiytU8RR8XSvjMWHn14ciSkGrX46
	3k8OvW8T6dihTuuTtCx8+FRchXrtArbsn7DW2kMVSx6T88tyZBKm55YMiU2YdDPKA2jMpteSy2Q
	hC8iNsETbpCgo1vkZ/GUqQjayI5cZViIIHtQYBytVrob63WoTwpOxc7bVixhNe5+oH8nkAgtlF0
	iJ65xaZSoGCACJfTK2eUvbYegljH80QuWsJRfTmrhY60jqP24PZXW5I+Jur9bwGyEBtXe5DwXOR
	w0uNTwbl+SybJUTBZcPFTl1AMNyav9dR1qNh+WwrkWqURCgflNKds94lxcVLE0Vf
X-Google-Smtp-Source: AGHT+IFFkzWY8TNcv4p83UFwfbI7nLXPOpQvegYjyyszY9bgsKMsrpATaGCgZ/hoxtIhWyEKqnBvqA==
X-Received: by 2002:a2e:8954:0:b0:2ff:b8f5:5a17 with SMTP id 38308e7fff4ca-30a59892d3emr41717421fa.5.1740339159290;
        Sun, 23 Feb 2025 11:32:39 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a28f69ef5sm24619251fa.75.2025.02.23.11.32.38
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 11:32:38 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5439a6179a7so4160332e87.1
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 11:32:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrSK0ueCFVoy5FWdJingNDrDh/sjPfgjsJgt0piriF0uxpyDBJ/FnpAMzJp+lFWm9aZIOqekc=@vger.kernel.org
X-Received: by 2002:a05:6512:138c:b0:545:2cb2:8b25 with SMTP id
 2adb3069b0e04-54838c72c15mr3279598e87.14.1740339157875; Sun, 23 Feb 2025
 11:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org> <20250223143617.GA27463@pendragon.ideasonboard.com>
In-Reply-To: <20250223143617.GA27463@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 20:32:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCupq4A=ctR=Kkp7VxB+gvw=Z8MdDZHDShVMMAzms0VUAg@mail.gmail.com>
X-Gm-Features: AWEUYZk4BCUlhZfDAEyMq_DXEXIN0g964L9anV-yYjRBNI9yv9NV-k2f4kKSGpc
Message-ID: <CANiDSCupq4A=ctR=Kkp7VxB+gvw=Z8MdDZHDShVMMAzms0VUAg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix deferred probing error
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 15:36, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Jan 29, 2025 at 12:39:46PM +0000, Ricardo Ribalda wrote:
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
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index a10d4f4d9f95..73a7f23b616c 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2253,9 +2253,10 @@ static int uvc_probe(struct usb_interface *intf,
> >       }
> >
> >       /* Parse the associated GPIOs. */
> > -     if (uvc_gpio_parse(dev) < 0) {
> > +     ret = uvc_gpio_parse(dev);
> > +     if (ret < 0) {
> >               uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
> > -             goto error;
> > +             goto error_retcode;
> >       }
> >
> >       dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
> > @@ -2328,9 +2329,11 @@ static int uvc_probe(struct usb_interface *intf,
> >       return 0;
> >
> >  error:
> > +     ret = -ENODEV;
> > +error_retcode:
>
> This isn't very nice. Could we instead also propagate error codes from
> other locations in the uvc_probe() function ? If you want to minimize
> changes, you can initialize ret to -ENODEV, and turn the (ret < 0) check
> for uvc_gpio_parse() to a (ret) check.

Not very nice, but easy to backport to stables. What about a follow-up
change like this:

index c93abe2367aa..8c67feca1688 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2261,7 +2261,7 @@ static int uvc_probe(struct usb_interface *intf,
        ret = uvc_gpio_parse(dev);
        if (ret < 0) {
                uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
-               goto error_retcode;
+               goto error;
        }

        dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
@@ -2285,24 +2285,32 @@ static int uvc_probe(struct usb_interface *intf,
        }

        /* Register the V4L2 device. */
-       if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
+       ret = v4l2_device_register(&intf->dev, &dev->vdev);
+       if (ret < 0)
                goto error;

        /* Scan the device for video chains. */
-       if (uvc_scan_device(dev) < 0)
+       if (uvc_scan_device(dev) < 0) {
+               ret = -ENODEV;
                goto error;
+       }

        /* Initialize controls. */
-       if (uvc_ctrl_init_device(dev) < 0)
+       if (uvc_ctrl_init_device(dev) < 0) {
+               ret = -ENODEV;
                goto error;
+       }

        /* Register video device nodes. */
-       if (uvc_register_chains(dev) < 0)
+       if (uvc_register_chains(dev) < 0) {
+               ret = -ENODEV;
                goto error;
+       }

 #ifdef CONFIG_MEDIA_CONTROLLER
        /* Register the media device node */
-       if (media_device_register(&dev->mdev) < 0)
+       ret = media_device_register(&dev->mdev);
+       if (ret < 0)
                goto error;
 #endif
        /* Save our data pointer in the interface data. */
@@ -2334,8 +2342,6 @@ static int uvc_probe(struct usb_interface *intf,
        return 0;

 error:
-       ret = -ENODEV;
-error_retcode:
        uvc_unregister_video(dev);
        kref_put(&dev->ref, uvc_delete);
        return ret;


>
> >       uvc_unregister_video(dev);
> >       kref_put(&dev->ref, uvc_delete);
> > -     return -ENODEV;
> > +     return ret;
> >  }
> >
> >  static void uvc_disconnect(struct usb_interface *intf)
> >
> > ---
> > base-commit: c4b7779abc6633677e6edb79e2809f4f61fde157
> > change-id: 20250129-uvc-eprobedefer-b5ebb4db63cc
>
> --
> Regards,
>
> Laurent Pinchart

Let me know what do you think so I can send a v2 with the change
proposed by Doug.

Regards!

-- 
Ricardo Ribalda

