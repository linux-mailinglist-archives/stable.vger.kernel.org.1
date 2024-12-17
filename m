Return-Path: <stable+bounces-104482-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A5D9F4B31
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86EE7A31FA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AEE1F03D5;
	Tue, 17 Dec 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34YtLn5q"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE681F03DE
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734439584; cv=none; b=A1IVZGsA+6rCnknlOkKLx1jHuscm/DJwAuVkYTux8xVr6EUdqC90Hd+uXpBgiES7Lttr2NnEaODf9FvF6ChoKpY7FuitcUpMRyIQlBnfumRxINP3k2PnDXQTJ5eWHn6EJUlgwb5NXRfWwiAcSPb9T9RdvUS2ncouYcOxTyIlABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734439584; c=relaxed/simple;
	bh=FF8ASMQZ8mAceWL/SIxpneVfLyKYwmHtZbXuihoGtpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWqnw1HT696vi7acFAU7c5V2duNkRcgQQfIdWPY1+5XRA6V2lebKzE+QlzsBgzEC4LvsEOjm/SUh+HbHrezMqSr+jYNC/Kue5ca1K/6mG3iEXrwX4ZQXim3H+C1snEx8tP9nMHo+8rV21a1+H3cl7hj6IsqB4LRxOJMkSZGIy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34YtLn5q; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d91653e9d7so49199076d6.1
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 04:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734439582; x=1735044382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbsrzDXIKf0447ujFK6NSPVqBAmKwJrOAESHFW+5XKI=;
        b=34YtLn5qxInEeGSMbEmQ6joJv2Gl8AGxwReXtKGj8qiB9oLF1fWPm/5mGjxg9lGW//
         rb5KFUr1ptvFEuHG/j6NzkjwdP2PQp68TR9HAQ9sTyuJhXcF2vTqkvvHG92g+HdTJafX
         Gq+ZE7GtEhOGPXwp8SjVp7YKpaMH3navjMhnfVY9nt/00QeLCmeJCF8IlUAAnrjF5p0J
         wWBxVoOP1qJqkh5dpatbamZjBQ170dEogzxI5y2EuelArUc1Wnwc0tiCNwr443J6CXVr
         zX62OcRZelrBv3agsx3hkOi8hYoSsiPWu36HXsGWjP3e/U1Qt84iOV+PZZVy5uK4Ejtv
         Ih9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734439582; x=1735044382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbsrzDXIKf0447ujFK6NSPVqBAmKwJrOAESHFW+5XKI=;
        b=FBEiYQuz8YhsU5tkwjOreJJJlQWCpiVpSVnKKd3ewcj6sTO3omsMDB5FSNNogds0CA
         GiV1HKYByCp0eDW4gGSPLvcgeXPY3d3g0/UywDTnlmmmgRrwK1YMxog7IY6MxuFSZURt
         ZLEaP/yFgnF/ZrNimdZ21zy9L40IZeMkh/2A1DCnO7h0yt3rqoz5T5TVf0G6gIobQPfj
         ymqz2gQMpiK2ZWwUfiRVfKpI12lzvUOFBskpJvJ61e4kW9rqcHw4bCLuUqRivgq0Yve1
         wD8bXwXl+0M56Tdb2lSrTpBACrMQ6Hm5mM269NaeJOJ2aAAaTxW8sTO3TeewLZhYUAB0
         Efmg==
X-Gm-Message-State: AOJu0YyedlT3i2wJa5yGtyNz7LrMkYH5r4A8icpvb5pYJi1glU0ITkVg
	MI8E3TzB1Gt0ga8wyyFcRFgIAQyz3H9I5dk8NsZPkYQeKDmvCSDQ/EBqIDi2gn3BBUMTCtsUfQR
	2cKG09oDgwAQokPMPmQAilJdFpP6+tqG+Uoo91xPUhDrM9++U4mgv
X-Gm-Gg: ASbGncvoUMTAqyHKHoM1hDFutpU7b4r5THk8YwcQnSj5NLfDFxWKn7D2AhFdhFoSh86
	RFC/AMfPGwsqS4KUMDIsDs+11vtcKxIniVxG3ZA2qAcTVwLets6akW1ToqrThc7MgJKGU
X-Google-Smtp-Source: AGHT+IG/oRjHQ3G17gOkTKwHyj5mQ3sOfOe6Avq3ZX8wH222IF2FIUuGwCJaJtO+oZKBhskGSQa+qXkJSwXje3RmZtc=
X-Received: by 2002:a05:6214:5090:b0:6d8:916b:1caa with SMTP id
 6a1803df08f44-6dcf428172emr53100396d6.27.1734439581682; Tue, 17 Dec 2024
 04:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024121040-distant-throng-b534@gregkh> <20241217123933.732180-1-bsevens@google.com>
In-Reply-To: <20241217123933.732180-1-bsevens@google.com>
From: =?UTF-8?Q?Beno=C3=AEt_Sevens?= <bsevens@google.com>
Date: Tue, 17 Dec 2024 13:46:10 +0100
Message-ID: <CAGCho0Xk-wRUf0GCBh0nio-Yirf6XRz-KykjXCjnB4t8gYSASQ@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] ALSA: usb-audio: Fix a DMA to stack memory bug
To: stable@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>, stable@kernel.org, 
	Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Dec 2024 at 13:39, Beno=C3=AEt Sevens <bsevens@google.com> wrote=
:
>
> From: Dan Carpenter <dan.carpenter@linaro.org>
>
> The usb_get_descriptor() function does DMA so we're not allowed
> to use a stack buffer for that.  Doing DMA to the stack is not portable
> all architectures.  Move the "new_device_descriptor" from being stored
> on the stack and allocate it with kmalloc() instead.
>
> Fixes: b909df18ce2a ("ALSA: usb-audio: Fix potential out-of-bound accesse=
s for Extigy and Mbox devices")
> Cc: stable@kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://patch.msgid.link/60e3aa09-039d-46d2-934c-6f123026c2eb@stanl=
ey.mountain
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> (cherry picked from commit f7d306b47a24367302bd4fe846854e07752ffcd9)
> [Beno=C3=AEt: there is no mbox3 suppport and no __free macro in 5.15]
> Signed-off-by: Beno=C3=AEt Sevens <bsevens@google.com>
> ---
>  sound/usb/quirks.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 9d98a0e6a9f4..4c28a27aafdf 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -591,7 +591,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
>  static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_=
interface *intf)
>  {
>         struct usb_host_config *config =3D dev->actconfig;
> -       struct usb_device_descriptor new_device_descriptor;
> +       struct usb_device_descriptor *new_device_descriptor __free(kfree)=
 =3D NULL;
>         int err;
>
>         if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) =3D=3D EXTIGY=
_FIRMWARE_SIZE_OLD ||
> @@ -602,15 +602,19 @@ static int snd_usb_extigy_boot_quirk(struct usb_dev=
ice *dev, struct usb_interfac
>                                       0x10, 0x43, 0x0001, 0x000a, NULL, 0=
);
>                 if (err < 0)
>                         dev_dbg(&dev->dev, "error sending boot message: %=
d\n", err);
> +
> +               new_device_descriptor =3D kmalloc(sizeof(*new_device_desc=
riptor), GFP_KERNEL);
> +               if (!new_device_descriptor)
> +                       return -ENOMEM;
>                 err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0,
> -                               &new_device_descriptor, sizeof(new_device=
_descriptor));
> +                               new_device_descriptor, sizeof(*new_device=
_descriptor));
>                 if (err < 0)
>                         dev_dbg(&dev->dev, "error usb_get_descriptor: %d\=
n", err);
> -               if (new_device_descriptor.bNumConfigurations > dev->descr=
iptor.bNumConfigurations)
> +               if (new_device_descriptor->bNumConfigurations > dev->desc=
riptor.bNumConfigurations)
>                         dev_dbg(&dev->dev, "error too large bNumConfigura=
tions: %d\n",
> -                               new_device_descriptor.bNumConfigurations)=
;
> +                               new_device_descriptor->bNumConfigurations=
);
>                 else
> -                       memcpy(&dev->descriptor, &new_device_descriptor, =
sizeof(dev->descriptor));
> +                       memcpy(&dev->descriptor, new_device_descriptor, s=
izeof(dev->descriptor));
>                 err =3D usb_reset_configuration(dev);
>                 if (err < 0)
>                         dev_dbg(&dev->dev, "error usb_reset_configuration=
: %d\n", err);
> @@ -942,7 +946,7 @@ static void mbox2_setup_48_24_magic(struct usb_device=
 *dev)
>  static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
>  {
>         struct usb_host_config *config =3D dev->actconfig;
> -       struct usb_device_descriptor new_device_descriptor;
> +       struct usb_device_descriptor *new_device_descriptor __free(kfree)=
 =3D NULL;
>         int err;
>         u8 bootresponse[0x12];
>         int fwsize;
> @@ -977,15 +981,19 @@ static int snd_usb_mbox2_boot_quirk(struct usb_devi=
ce *dev)
>
>         dev_dbg(&dev->dev, "device initialised!\n");
>
> +       new_device_descriptor =3D kmalloc(sizeof(*new_device_descriptor),=
 GFP_KERNEL);
> +       if (!new_device_descriptor)
> +               return -ENOMEM;
> +
>         err =3D usb_get_descriptor(dev, USB_DT_DEVICE, 0,
> -               &new_device_descriptor, sizeof(new_device_descriptor));
> +               new_device_descriptor, sizeof(*new_device_descriptor));
>         if (err < 0)
>                 dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err)=
;
> -       if (new_device_descriptor.bNumConfigurations > dev->descriptor.bN=
umConfigurations)
> +       if (new_device_descriptor->bNumConfigurations > dev->descriptor.b=
NumConfigurations)
>                 dev_dbg(&dev->dev, "error too large bNumConfigurations: %=
d\n",
> -                       new_device_descriptor.bNumConfigurations);
> +                       new_device_descriptor->bNumConfigurations);
>         else
> -               memcpy(&dev->descriptor, &new_device_descriptor, sizeof(d=
ev->descriptor));
> +               memcpy(&dev->descriptor, new_device_descriptor, sizeof(de=
v->descriptor));
>
>         err =3D usb_reset_configuration(dev);
>         if (err < 0)
> --
> 2.47.1.613.gc27f4b7a9f-goog
>

Please disregard, this does not build. I will submit a working patch.

