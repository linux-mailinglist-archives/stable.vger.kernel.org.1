Return-Path: <stable+bounces-237656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gG/0ESpX3WkFcQkAu9opvQ
	(envelope-from <stable+bounces-237656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:50:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7963F33E0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36FC4301FCD3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5E63822B4;
	Mon, 13 Apr 2026 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MKKsazu5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E737E306
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113448; cv=none; b=gAo6nFfKiAlGL9B/vpqDYjy1rPdmk15qnnwrx7zJTb208Eiah0yhpHJkWVda3ccShmMujri4nKlPBE7HK5Wlb2PruAXQfqsoS9lHFsR40XjZYecil56VNMgKhuDPYMUfWuHWXkVRUX1fIRoTpG1Emm6nu/X4Pixln07OPJUSWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113448; c=relaxed/simple;
	bh=phu48ISBgFzloGx3bFM/4hErH7fJS3B/cwB4bdAFvLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3wS6R6/djSRU6KqIp3z85tGFt5LxJweZtIYzP5n5mcEE69kXn38auaLVc13iOCKshBg7MrG6oxU30S9vukG35R24y/p36Z1MtNmBXWiQIVEhLEhoG5UDjHx/bLWaHTd/ZzXjMSwfyj1izsScsVeze8qZwSXzLMyA6rdvcxQP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MKKsazu5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9e04b80692so112977266b.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776113444; x=1776718244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zVPUv+wqfybhPNC6whwT8hRPdxEZtWnFtuiq+gFIrwY=;
        b=MKKsazu5t698t2AOdc8RMTEDyu1pzMz4kMW78KeZH5RQ4oXSTMXKP7T5DMh0CHeaBM
         GmZR3nHvsBo6bVLm42uKjcEqYEtasswc2PXDYZ1djfN2L+r86ZOxycVrYINFPQTuD1z1
         950bCpPP9tzgoXy8qMGvxOsyGEKhca0Kffl90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776113444; x=1776718244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVPUv+wqfybhPNC6whwT8hRPdxEZtWnFtuiq+gFIrwY=;
        b=MkbS4Ivz3XH5Cy4NDRqsPJDc1C9cFKqSPflHhAdnKEB5NMBYqV0ukWqAUH5TRIshTT
         hFBIpByeeRzPH1yBvUheEJTpg1uvW7Y5Yf7mqw24PFQkCfZz3bebWU9YQlePhFojl8Gj
         UwK4qCm+LUwNz+DoomuhK1k/ehbbgQcS8ZKt/aRARf/q5W11BSatIoFztuMnnEYZezfT
         pOswr9a50bpTFPtSJDtpgGzhNVDF55ZMrOAyyGfcaxh4Rd+9OaCZn3PEQqcCtKw0baJB
         X06lzqjs5Md1QOogIz38i3PvrpwcqJcziOjEzdqmQmkKEIUpK1cGSL3VXsRo8OVnLm0y
         416Q==
X-Forwarded-Encrypted: i=1; AFNElJ8UnqJUR+MjpdPTYQi0rGdghDrcBOXRQMXx80Rd2kc9PYLyah0wUuIAF6YDNsDf5qW8icz33lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRm1NY7i2B59clEbTtrH6nCjA/wTfgYlPAruJTkNM1ho/oxnfN
	6DRNakpVUsceb1DACKojUb+X70gGYYLr2t8T/BjLMzOiKVgQ/5MTkDnoTIeN0x6mSfM3bCZAZ4q
	xi/g=
X-Gm-Gg: AeBDiesziPHA7hEHaFHhIjPLB3a5Q2zyoEik/mw14wgPQJSpUAqjTm68o++TqsGSfSl
	N1FErIbZoZSNQmsdTArLkxOjbfK3+wfnNxovGGiFHK/j/Kd49p/otsNCQekRbZPqeFiz3xxV76s
	U3Y8A9Yxm9baOZmJI/z9uVRSdPytLMJ/Umgro27t/ox5b3L2QDDUk8/BhmO3PbzZhi2t6Dwy8Y6
	vRzx8INKkRqRdqPqVlcZuNP0GEY5psO0ow3TVXBE14BGiqDcBvNUqfQPz+7Ww5WZGWD/Z8qYUE6
	lpP3DDntPeKIPq1P+K3ES4ZSf5zwk+HypflWTQFjlzgU2GwfWpt1aLplJNmyi/JwPTiZyvbzpXj
	64ve5SeXsUkulxEfEwiCtfE1qVHdnbHutoHVf2NdLmuwCCgU3wr0DEm4e/WOHgI+LDCdoiB3GKQ
	6xZKXFAtP02Z126jH7l9Tn/mbIQWcV3uzbtA5kaGEElpK3+gmUNuf4leH/C70D
X-Received: by 2002:a17:907:78c:b0:b96:ef71:49f9 with SMTP id a640c23a62f3a-b9d724f02f4mr844441666b.9.1776113444244;
        Mon, 13 Apr 2026 13:50:44 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67070815733sm3014568a12.21.2026.04.13.13.50.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 13:50:43 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b97f9587e6eso668919266b.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:50:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/leyTpegeSambOMtAFX5p2sXivOqEDQmh1+RGIHy91TKE/P+Z7kbHxHLPYp9FwcSFGy35VcgQ=@vger.kernel.org
X-Received: by 2002:a17:907:e110:b0:b97:8503:8313 with SMTP id
 a640c23a62f3a-b9d727aa2a5mr567836466b.27.1776113441514; Mon, 13 Apr 2026
 13:50:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155819.042779211@linuxfoundation.org> <20260413155835.015055819@linuxfoundation.org>
 <673ddf965a5af7b881e86cb2e22055d4fcbb2dfc.camel@decadent.org.uk>
In-Reply-To: <673ddf965a5af7b881e86cb2e22055d4fcbb2dfc.camel@decadent.org.uk>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 13 Apr 2026 22:50:28 +0200
X-Gmail-Original-Message-ID: <CANiDSCt44g9PYddX1bYw+OASwV=Ah2XOKmKmf0aeXSCKZ7i7EA@mail.gmail.com>
X-Gm-Features: AQROBzC_h9nhOHxtr7G1YxDXbqLWLzbLM63nuJ9k1lJ_PFCs9CEKXTUPrPthIfo
Message-ID: <CANiDSCt44g9PYddX1bYw+OASwV=Ah2XOKmKmf0aeXSCKZ7i7EA@mail.gmail.com>
Subject: Re: [PATCH 5.10 427/491] media: uvcvideo: Implement UVC_EXT_GPIO_UNIT
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237656-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,huawei];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ideasonboard.com:email,mail.gmail.com:mid,chromium.org:dkim,chromium.org:email,decadent.org.uk:email]
X-Rspamd-Queue-Id: DA7963F33E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 at 22:43, Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Mon, 2026-04-13 at 18:01 +0200, Greg Kroah-Hartman wrote:
> > 5.10-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Ricardo Ribalda <ribalda@chromium.org>
> >
> > [ Upstream commit 2886477ff98740cc3333cf785e4de0b1ff3d7a28 ]
>
> This is a new feature, not obviously suitable for stable.

Agree with Ben here.

if the reason for this patch is to get  "media: uvcvideo: Use
heuristic to find stream entity" in 5.10 I can work on a backport that
only adds this feature without GPIO it should be pretty easy.


>
> If it really is needed for 5.10 then there are a number of bug fixes
> that also need to follow: 387e89393071 ["media: uvcvideo: Fix deferred
> probing error"), a9ea1a3d88b7 ("media: uvcvideo: Fix crash during unbind
> if gpio unit is in use"), and f0f078457f18 ("media: uvcvideo: Fix memory
> leak in uvc_gpio_parse").
>
> Ben.
>
> > Some devices can implement a physical switch to disable the input of the
> > camera on demand. Think of it like an elegant privacy sticker.
> >
> > The system can read the status of the privacy switch via a GPIO.
> >
> > It is important to know the status of the switch, e.g. to notify the
> > user when the camera will produce black frames and a videochat
> > application is used.
> >
> > In some systems, the GPIO is connected to the main SoC instead of the
> > camera controller, with the connection reported by the system firmware
> > (ACPI or DT). In that case, the UVC device isn't aware of the GPIO. We
> > need to implement a virtual entity to handle the GPIO fully on the
> > driver side.
> >
> > For example, for ACPI-based systems, the GPIO is reported in the USB
> > device object:
> >
> >   Scope (\_SB.PCI0.XHCI.RHUB.HS07)
> >   {
> >
> >         /.../
> >
> >     Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> >     {
> >         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> >             "\\_SB.PCI0.GPIO", 0x00, ResourceConsumer, ,
> >             )
> >             {   // Pin list
> >                 0x0064
> >             }
> >     })
> >     Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
> >     {
> >         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
> >         Package (0x01)
> >         {
> >             Package (0x02)
> >             {
> >                 "privacy-gpio",
> >                 Package (0x04)
> >                 {
> >                     \_SB.PCI0.XHCI.RHUB.HS07,
> >                     Zero,
> >                     Zero,
> >                     One
> >                 }
> >             }
> >         }
> >     })
> >   }
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Stable-dep-of: 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c   |   3 +
> >  drivers/media/usb/uvc/uvc_driver.c | 127 +++++++++++++++++++++++++++++
> >  drivers/media/usb/uvc/uvc_entity.c |   1 +
> >  drivers/media/usb/uvc/uvcvideo.h   |  16 ++++
> >  4 files changed, 147 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 698bf5bb896ec..fc23e53c0d38b 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -2378,6 +2378,9 @@ int uvc_ctrl_init_device(struct uvc_device *dev)
> >               } else if (UVC_ENTITY_TYPE(entity) == UVC_ITT_CAMERA) {
> >                       bmControls = entity->camera.bmControls;
> >                       bControlSize = entity->camera.bControlSize;
> > +             } else if (UVC_ENTITY_TYPE(entity) == UVC_EXT_GPIO_UNIT) {
> > +                     bmControls = entity->gpio.bmControls;
> > +                     bControlSize = entity->gpio.bControlSize;
> >               }
> >
> >               /* Remove bogus/blacklisted controls */
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index e1d3e753e80ed..b86e46fa7c0af 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -7,6 +7,7 @@
> >   */
> >
> >  #include <linux/atomic.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/kernel.h>
> >  #include <linux/list.h>
> >  #include <linux/module.h>
> > @@ -1033,6 +1034,7 @@ static int uvc_parse_streaming(struct uvc_device *dev,
> >  }
> >
> >  static const u8 uvc_camera_guid[16] = UVC_GUID_UVC_CAMERA;
> > +static const u8 uvc_gpio_guid[16] = UVC_GUID_EXT_GPIO_CONTROLLER;
> >  static const u8 uvc_media_transport_input_guid[16] =
> >       UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
> >  static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
> > @@ -1064,6 +1066,9 @@ static struct uvc_entity *uvc_alloc_entity(u16 type, u16 id,
> >        * is initialized by the caller.
> >        */
> >       switch (type) {
> > +     case UVC_EXT_GPIO_UNIT:
> > +             memcpy(entity->guid, uvc_gpio_guid, 16);
> > +             break;
> >       case UVC_ITT_CAMERA:
> >               memcpy(entity->guid, uvc_camera_guid, 16);
> >               break;
> > @@ -1467,6 +1472,108 @@ static int uvc_parse_control(struct uvc_device *dev)
> >       return 0;
> >  }
> >
> > +/* -----------------------------------------------------------------------------
> > + * Privacy GPIO
> > + */
> > +
> > +static void uvc_gpio_event(struct uvc_device *dev)
> > +{
> > +     struct uvc_entity *unit = dev->gpio_unit;
> > +     struct uvc_video_chain *chain;
> > +     u8 new_val;
> > +
> > +     if (!unit)
> > +             return;
> > +
> > +     new_val = gpiod_get_value_cansleep(unit->gpio.gpio_privacy);
> > +
> > +     /* GPIO entities are always on the first chain. */
> > +     chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);
> > +     uvc_ctrl_status_event(chain, unit->controls, &new_val);
> > +}
> > +
> > +static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> > +                         u8 cs, void *data, u16 size)
> > +{
> > +     if (cs != UVC_CT_PRIVACY_CONTROL || size < 1)
> > +             return -EINVAL;
> > +
> > +     *(u8 *)data = gpiod_get_value_cansleep(entity->gpio.gpio_privacy);
> > +
> > +     return 0;
> > +}
> > +
> > +static int uvc_gpio_get_info(struct uvc_device *dev, struct uvc_entity *entity,
> > +                          u8 cs, u8 *caps)
> > +{
> > +     if (cs != UVC_CT_PRIVACY_CONTROL)
> > +             return -EINVAL;
> > +
> > +     *caps = UVC_CONTROL_CAP_GET | UVC_CONTROL_CAP_AUTOUPDATE;
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t uvc_gpio_irq(int irq, void *data)
> > +{
> > +     struct uvc_device *dev = data;
> > +
> > +     uvc_gpio_event(dev);
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static int uvc_gpio_parse(struct uvc_device *dev)
> > +{
> > +     struct uvc_entity *unit;
> > +     struct gpio_desc *gpio_privacy;
> > +     int irq;
> > +
> > +     gpio_privacy = devm_gpiod_get_optional(&dev->udev->dev, "privacy",
> > +                                            GPIOD_IN);
> > +     if (IS_ERR_OR_NULL(gpio_privacy))
> > +             return PTR_ERR_OR_ZERO(gpio_privacy);
> > +
> > +     unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
> > +     if (!unit)
> > +             return -ENOMEM;
> > +
> > +     irq = gpiod_to_irq(gpio_privacy);
> > +     if (irq < 0) {
> > +             if (irq != EPROBE_DEFER)
> > +                     dev_err(&dev->udev->dev,
> > +                             "No IRQ for privacy GPIO (%d)\n", irq);
> > +             return irq;
> > +     }
> > +
> > +     unit->gpio.gpio_privacy = gpio_privacy;
> > +     unit->gpio.irq = irq;
> > +     unit->gpio.bControlSize = 1;
> > +     unit->gpio.bmControls = (u8 *)unit + sizeof(*unit);
> > +     unit->gpio.bmControls[0] = 1;
> > +     unit->get_cur = uvc_gpio_get_cur;
> > +     unit->get_info = uvc_gpio_get_info;
> > +     strncpy(unit->name, "GPIO", sizeof(unit->name) - 1);
> > +
> > +     list_add_tail(&unit->list, &dev->entities);
> > +
> > +     dev->gpio_unit = unit;
> > +
> > +     return 0;
> > +}
> > +
> > +static int uvc_gpio_init_irq(struct uvc_device *dev)
> > +{
> > +     struct uvc_entity *unit = dev->gpio_unit;
> > +
> > +     if (!unit || unit->gpio.irq < 0)
> > +             return 0;
> > +
> > +     return devm_request_threaded_irq(&dev->udev->dev, unit->gpio.irq, NULL,
> > +                                      uvc_gpio_irq,
> > +                                      IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
> > +                                      IRQF_TRIGGER_RISING,
> > +                                      "uvc_privacy_gpio", dev);
> > +}
> > +
> >  /* ------------------------------------------------------------------------
> >   * UVC device scan
> >   */
> > @@ -1988,6 +2095,13 @@ static int uvc_scan_device(struct uvc_device *dev)
> >               return -1;
> >       }
> >
> > +     /* Add GPIO entity to the first chain. */
> > +     if (dev->gpio_unit) {
> > +             chain = list_first_entry(&dev->chains,
> > +                                      struct uvc_video_chain, list);
> > +             list_add_tail(&dev->gpio_unit->chain, &chain->entities);
> > +     }
> > +
> >       return 0;
> >  }
> >
> > @@ -2350,6 +2464,12 @@ static int uvc_probe(struct usb_interface *intf,
> >               goto error;
> >       }
> >
> > +     /* Parse the associated GPIOs. */
> > +     if (uvc_gpio_parse(dev) < 0) {
> > +             uvc_trace(UVC_TRACE_PROBE, "Unable to parse UVC GPIOs\n");
> > +             goto error;
> > +     }
> > +
> >       uvc_printk(KERN_INFO, "Found UVC %u.%02x device %s (%04x:%04x)\n",
> >               dev->uvc_version >> 8, dev->uvc_version & 0xff,
> >               udev->product ? udev->product : "<unnamed>",
> > @@ -2394,6 +2514,13 @@ static int uvc_probe(struct usb_interface *intf,
> >                       "supported.\n", ret);
> >       }
> >
> > +     ret = uvc_gpio_init_irq(dev);
> > +     if (ret < 0) {
> > +             dev_err(&dev->udev->dev,
> > +                     "Unable to request privacy GPIO IRQ (%d)\n", ret);
> > +             goto error;
> > +     }
> > +
> >       uvc_trace(UVC_TRACE_PROBE, "UVC device initialized.\n");
> >       usb_enable_autosuspend(udev);
> >       return 0;
> > diff --git a/drivers/media/usb/uvc/uvc_entity.c b/drivers/media/usb/uvc/uvc_entity.c
> > index 7c9895377118c..96e965a16d061 100644
> > --- a/drivers/media/usb/uvc/uvc_entity.c
> > +++ b/drivers/media/usb/uvc/uvc_entity.c
> > @@ -105,6 +105,7 @@ static int uvc_mc_init_entity(struct uvc_video_chain *chain,
> >               case UVC_OTT_DISPLAY:
> >               case UVC_OTT_MEDIA_TRANSPORT_OUTPUT:
> >               case UVC_EXTERNAL_VENDOR_SPECIFIC:
> > +             case UVC_EXT_GPIO_UNIT:
> >               default:
> >                       function = MEDIA_ENT_F_V4L2_SUBDEV_UNKNOWN;
> >                       break;
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 0e4209dbf307f..e9eef2170d866 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -6,6 +6,7 @@
> >  #error "The uvcvideo.h header is deprecated, use linux/uvcvideo.h instead."
> >  #endif /* __KERNEL__ */
> >
> > +#include <linux/atomic.h>
> >  #include <linux/kernel.h>
> >  #include <linux/poll.h>
> >  #include <linux/usb.h>
> > @@ -37,6 +38,8 @@
> >       (UVC_ENTITY_IS_TERM(entity) && \
> >       ((entity)->type & 0x8000) == UVC_TERM_OUTPUT)
> >
> > +#define UVC_EXT_GPIO_UNIT            0x7ffe
> > +#define UVC_EXT_GPIO_UNIT_ID         0x100
> >
> >  /* ------------------------------------------------------------------------
> >   * GUIDs
> > @@ -56,6 +59,9 @@
> >  #define UVC_GUID_UVC_SELECTOR \
> >       {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> >        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02}
> > +#define UVC_GUID_EXT_GPIO_CONTROLLER \
> > +     {0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> > +      0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x03}
> >
> >  #define UVC_GUID_FORMAT_MJPEG \
> >       { 'M',  'J',  'P',  'G', 0x00, 0x00, 0x10, 0x00, \
> > @@ -213,6 +219,7 @@
> >   * Structures.
> >   */
> >
> > +struct gpio_desc;
> >  struct uvc_device;
> >
> >  /* TODO: Put the most frequently accessed fields at the beginning of
> > @@ -354,6 +361,13 @@ struct uvc_entity {
> >                       u8  *bmControls;
> >                       u8  *bmControlsType;
> >               } extension;
> > +
> > +             struct {
> > +                     u8  bControlSize;
> > +                     u8  *bmControls;
> > +                     struct gpio_desc *gpio_privacy;
> > +                     int irq;
> > +             } gpio;
> >       };
> >
> >       u8 bNrInPins;
> > @@ -696,6 +710,8 @@ struct uvc_device {
> >               struct uvc_control *ctrl;
> >               const void *data;
> >       } async_ctrl;
> > +
> > +     struct uvc_entity *gpio_unit;
> >  };
> >
> >  enum uvc_handle_state {
>
> --
> Ben Hutchings
> When in doubt, use brute force. - Ken Thompson



-- 
Ricardo Ribalda

