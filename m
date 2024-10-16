Return-Path: <stable+bounces-86514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FD9A0D67
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 16:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE152881B3
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C0320E023;
	Wed, 16 Oct 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVhI0dlK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70920E012;
	Wed, 16 Oct 2024 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090381; cv=none; b=YJbv2XN9IRGgI5NUhwaWnuoL09iI1LsIUOGcLK78j3/3jM5OcY36DoZagK/Iq5E26AGlSu4naIoUSjzms2uznwR5CmSeyJiGc5LUPLcPI7Y0eUA7h/5+Ot1cxJRP6LihvxCCfb/KtVVPpaK2lfpbSgnMl4ljam4iRizsfgwWQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090381; c=relaxed/simple;
	bh=uA1XOwFgRsIEk0Sn+4hyN4zB571af+CZ+WkJvLKZ80g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lupl/dl1uhZQ7VrYhzsrKjUau/J3TX5D+rnJx3G5j5Uuem3pIb16RqD/kb3He2LxrR0XqdqoABNnjHDtZGS+FG8ALrDdYCwGdHPxLP12FsTwbaYUXyrKhf6vCPs8dez0zk6LW3GUEqmcOi3+31Hsspg4gTHMtLx9gVHxIU5V718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVhI0dlK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so3371298a12.1;
        Wed, 16 Oct 2024 07:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729090379; x=1729695179; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WqaHzTXb3EYsFR+TrFKuj3DUg8JmTWCmD6QeLvYOQKk=;
        b=WVhI0dlKf8ghrL7rTMaeMkbcdzdeh2OyMdjpNMabw5girreZRf4N239sUcNUn4+W6d
         32qBo3hHVPm3lvh65pOb7aasot3Agvg7ar96zC2zmIQHgMQPnQFWEjPrBrfXEisAinlx
         1POgCPJf/HNwwzQpPeuLH9NGN/QRGelGNB9Gcf2EU7icw87jPNV3YZ763V7aBQ57uWbC
         3nAkJMQKJTo2M9IxP26KFoQXkM8oS7g54bmFWweAoMxIyZblq9uVlWE/3rtLk86PAE5Z
         f8kgpYyjizmdA1zhZdjfOXbKQs7UAtfWtWeeQXXJslbtG8VFvglx54C5DOEppv64IZ4u
         recA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729090379; x=1729695179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WqaHzTXb3EYsFR+TrFKuj3DUg8JmTWCmD6QeLvYOQKk=;
        b=fxBV410czGWCqOUFkSoScfD91OA3aILLHJ3oV8yD1+2EpY+F9irF4IGyt+Dit03MMC
         sSCbZwz6IAtPdTzgCjNTO40A5Cw4erm0uwqYvutgIaFy5J2/gveD49Sc8lWU48jvQPJX
         P0sUOkGlIyree9oXBEH9MsUoPDiDe55PpnpiRxhN8I/11DhfsZxgNsy+1C1wUMXRjqYa
         RO8Y+EfiAiGKCkYMT1hnzEqMHJ24ag6mDzFdSNWKl6poOH5UPUcrD9Xjn/18jBpPQ2Fz
         5jGfzgkQ8y/Sb8GWueOObatSSEe6vIa/dN7w3Y+JktcIBXzTq0zyS4kXfdP+CbQgteVq
         kZlw==
X-Forwarded-Encrypted: i=1; AJvYcCU1DXaSBALdj47ej/qRrn23Ym5K4LNPgthJbNkIVsbaWI3/qVyPqSdzgQqRwnCUJIDBTNxod6rQ@vger.kernel.org, AJvYcCWGlrNqo4s7tdmpOdJc1kC+vvKjRmneTn08r3re7GPJPSIUlh95eTonrgO0DnO/2+eoES9etk3lptAD@vger.kernel.org, AJvYcCWdv4V82eA35lln95tJhrWlts79Yq/+vZn9Yos2pjlNYg599alQ18rOeSE5wyRbqQK4eY8vnrQ3l8P4Azw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXB9eXidiM4jlekYHgbbuPI9Ds3ROLL4sn1VndRBCYQvtH4wFS
	mJAnXExXlXflEchf7kTCaWr8BvKtRKy/LJ5NQMF2mdjF26IbgahQJrlzDaOztj9GZkEsjOl5s/d
	UF5VxpIbnoVNJ+2mm2pv191AmJ6fC3jg1
X-Google-Smtp-Source: AGHT+IGpO0lm6WWsi1VfJG4NOgrjc4r6LGzQbumUxwFDZ5MWErkaI0YwZ7RSyrf11QIXXvc9iTyf9q698j19mWB2/v4=
X-Received: by 2002:a05:6a21:150a:b0:1d2:ba7c:c6e7 with SMTP id
 adf61e73a8af0-1d8bcf5abaamr22834524637.30.1729090378945; Wed, 16 Oct 2024
 07:52:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919103403.3986-1-aha310510@gmail.com>
In-Reply-To: <20240919103403.3986-1-aha310510@gmail.com>
From: Jeongjun Park <aha310510@gmail.com>
Date: Wed, 16 Oct 2024 23:52:47 +0900
Message-ID: <CAO9qdTHgSwtaVfwzUYgSNX_3Yx=hmyYQnUb-OpP6k2u_gRZVGg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: using mutex lock and supporting O_NONBLOCK flag
 in iowarrior_read()
To: gregkh@linuxfoundation.org, oneukum@suse.com
Cc: colin.i.king@gmail.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Jeongjun Park <aha310510@gmail.com> wrote:
>
> iowarrior_read() uses the iowarrior dev structure, but does not use any
> lock on the structure. This can cause various bugs including data-races,
> so it is more appropriate to use a mutex lock to safely protect the
> iowarrior dev structure. When using a mutex lock, you should split the
> branch to prevent blocking when the O_NONBLOCK flag is set.
>
> In addition, it is unnecessary to check for NULL on the iowarrior dev
> structure obtained by reading file->private_data. Therefore, it is
> better to remove the check.
>
> Cc: stable@vger.kernel.org
> Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

I think this patch should be moved to the usb-linus tree to be applied in the
next rc version. iowarrior_read() is very vulnerable to a data-race because it
reads a struct iowarrior without a mutex_lock. I think this almost certainly
leads to a data-race, so I think this function should be moved to the
usb-linus tree to be fixed as soon as possible.

I would appreciate it if you could review this.

Regards,

Jeongjun Park

> ---
> v1 -> v2: Added cc tag and change log
>
>  drivers/usb/misc/iowarrior.c | 46 ++++++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> index 6d28467ce352..a513766b4985 100644
> --- a/drivers/usb/misc/iowarrior.c
> +++ b/drivers/usb/misc/iowarrior.c
> @@ -277,28 +277,45 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
>         struct iowarrior *dev;
>         int read_idx;
>         int offset;
> +       int retval;
>
>         dev = file->private_data;
>
> +       if (file->f_flags & O_NONBLOCK) {
> +               retval = mutex_trylock(&dev->mutex);
> +               if (!retval)
> +                       return -EAGAIN;
> +       } else {
> +               retval = mutex_lock_interruptible(&dev->mutex);
> +               if (retval)
> +                       return -ERESTARTSYS;
> +       }
> +
>         /* verify that the device wasn't unplugged */
> -       if (!dev || !dev->present)
> -               return -ENODEV;
> +       if (!dev->present) {
> +               retval = -ENODEV;
> +               goto exit;
> +       }
>
>         dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
>                 dev->minor, count);
>
>         /* read count must be packet size (+ time stamp) */
>         if ((count != dev->report_size)
> -           && (count != (dev->report_size + 1)))
> -               return -EINVAL;
> +           && (count != (dev->report_size + 1))) {
> +               retval = -EINVAL;
> +               goto exit;
> +       }
>
>         /* repeat until no buffer overrun in callback handler occur */
>         do {
>                 atomic_set(&dev->overflow_flag, 0);
>                 if ((read_idx = read_index(dev)) == -1) {
>                         /* queue empty */
> -                       if (file->f_flags & O_NONBLOCK)
> -                               return -EAGAIN;
> +                       if (file->f_flags & O_NONBLOCK) {
> +                               retval = -EAGAIN;
> +                               goto exit;
> +                       }
>                         else {
>                                 //next line will return when there is either new data, or the device is unplugged
>                                 int r = wait_event_interruptible(dev->read_wait,
> @@ -309,28 +326,37 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
>                                                                   -1));
>                                 if (r) {
>                                         //we were interrupted by a signal
> -                                       return -ERESTART;
> +                                       retval = -ERESTART;
> +                                       goto exit;
>                                 }
>                                 if (!dev->present) {
>                                         //The device was unplugged
> -                                       return -ENODEV;
> +                                       retval = -ENODEV;
> +                                       goto exit;
>                                 }
>                                 if (read_idx == -1) {
>                                         // Can this happen ???
> -                                       return 0;
> +                                       retval = 0;
> +                                       goto exit;
>                                 }
>                         }
>                 }
>
>                 offset = read_idx * (dev->report_size + 1);
>                 if (copy_to_user(buffer, dev->read_queue + offset, count)) {
> -                       return -EFAULT;
> +                       retval = -EFAULT;
> +                       goto exit;
>                 }
>         } while (atomic_read(&dev->overflow_flag));
>
>         read_idx = ++read_idx == MAX_INTERRUPT_BUFFER ? 0 : read_idx;
>         atomic_set(&dev->read_idx, read_idx);
> +       mutex_unlock(&dev->mutex);
>         return count;
> +
> +exit:
> +       mutex_unlock(&dev->mutex);
> +       return retval;
>  }
>
>  /*
> --

