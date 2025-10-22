Return-Path: <stable+bounces-189038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18630BFE20D
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 22:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C2BA4EF474
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 20:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36092F8BFC;
	Wed, 22 Oct 2025 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJtg2ADQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847A2F83C2
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163827; cv=none; b=Z5io0P3lvZSNwaI1b0YElv/et1vd55ByPMism+swNsFtv2qD8LFMV9VIFU6thUpmOa7WooJ8KVHNLcRufXYOtDTrQhMr++7XqBDz1xnyT0qTeFe32CVoVOiMDxKoTZFEeuxwQF9JsmutjCY1Fcw8829+SCfGb05W67PXzSk6qiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163827; c=relaxed/simple;
	bh=Ek3haOYmPyu4dgOa5C0zgHctdofHHVO9EUyqAYNfa2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyBkTgLj8dstboonyrtnddJ/DafwQNZFI0DwpdjQJXieh484N/9XDW8F6SM8BmSkQPmo1rzOdQtMv7Ov0PK3eqZMF7hKnng3SxqGCaGVK6QVdw1XtU4cCGexkhdyq36k8CnfEFt+tM5KVN8VXGJtxBQzZ21ImmBsV65vo659bwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJtg2ADQ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d40e0106b6so3352289137.2
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761163825; x=1761768625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn5VKrdn1aznBkaeIAwzuNTcwHsl29o2bnaUn9NgWHw=;
        b=dJtg2ADQlG39P/7E15ZCN14M1JcnfeGwn8Jh5dVPvJ9O/kq75zKSJkxJfrC3sJAr4o
         +VWwO1l0Lxx9DzzAARu5Rs2c+2xXmC3SHPY7FpEypfGSNND3HOQ+03gndGGTe03K3SiQ
         IEuM8Emo6TVAaTC0GETRGviXvh76X2Hwytua6kTTf5szKjFpoHS7wYdpROBGXEBW3V2x
         ZFcNmQmSJ7v+MHIq1cchaBOekrFfXxZf3srpXHbD9XKVZp56jXAdAFDS79yeRoNrNpHi
         APpdAHD8/pxbnjx2WuladnFsEDc96LfmDnKpn1KQdZQlZe9M3/v3ytYSXzMVBW4ry7bV
         E4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761163825; x=1761768625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn5VKrdn1aznBkaeIAwzuNTcwHsl29o2bnaUn9NgWHw=;
        b=FG0AgDXUPaPbkd0bAMWBSfeVgRHduUl32A0dxtKU8eS7L/bZjLO3v30/504TiMS6gx
         hBBkGiEZOsC9yOe1QXuZvuez4rF5QpXzvN6iHk05Hmjo4jRj2ZkIqkhozjlPywW9mElq
         BC0qid2I9ZZ07ok6o0aJyI+AMTiHMHQ2tRJ7k/ZxYymaCU82ufC8euR8N+sx59TtUGmm
         AUEhMlA3PN04VlDVr+o35vwR6bExVTlSzVzsYADAQq2pA15KpTWP7/SFN7aH6l7KsmUo
         YGVRiGiEoqhSmQ82Fy6ZMkS+YXnjs2FhlqJ0nsemas+T4mz/IAovrDr8EFeczKyatKTN
         PYtg==
X-Forwarded-Encrypted: i=1; AJvYcCUTOxUKOsbidrGPPVNlq+lWSF5iecJE8QnNIFmJKEf2L2mqWbJUrZ0G25o9UQkuxgkx4L/zklA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBverVGLF3U4RY13wFhD/QCKNwRXZZjxbfrhtbv3Y54IH4iel
	7OJBho0W9mUk8mkJmG+ASB8yFafIQgCuD49EV5CTMVFeb6FUzkn/++dj6Vzc5ZM9vSIfmAFgaGk
	DCHnqst47wR8vGpbbD35MWqwhHGNNRTw=
X-Gm-Gg: ASbGncsP7X6O9MGpRIcJchn+rGYPo0S9WMIpbtN/TK6Z/Vq5mG50hY+ZMgCTNxVQ6qm
	cSbI5pBLFRNwz1H5Qsp/acavnQU52WYtopXNu6pgtAf24iVDwOupG3htnnHbNAfIgStRiPBISSl
	8d+oCYKT9/wmAp7ZOXjKnUu1QY/y38wyMq0XzzauUNnOS+WhNsDaTrk48LTp0Q4SfduiOwIBOli
	jem2kq+PqNrue9yneRAlcTuHYuzOIybfqMKCepfXaAv6V7DuHJG9DbzQqXWhFhC8P+9ZqvqUXPG
	6MUdMxxeacSHXAgPcaduIR+CSQ==
X-Google-Smtp-Source: AGHT+IEAmpCYQ3I3CaF01f4rD5k8jsO3VFkaaCggeAPNetgcdL42bDO5ziQu0Y8LVdLou4hTbEHf9n0KaVc/TOKWEY4=
X-Received: by 2002:a05:6102:c48:b0:5d5:f6ae:74b4 with SMTP id
 ada2fe7eead31-5d7dd62a873mr7028676137.40.1761163824525; Wed, 22 Oct 2025
 13:10:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022042514.2167599-1-danisjiang@gmail.com> <cf501c1e-94eb-4855-b3ad-e0b8c68d1a74@kernel.org>
In-Reply-To: <cf501c1e-94eb-4855-b3ad-e0b8c68d1a74@kernel.org>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Wed, 22 Oct 2025 15:10:12 -0500
X-Gm-Features: AWmQ_blNULWk3f3C_pQvJ7TQXzRfUECTP0SyTqgDO42bYPywBEVt3wfIIpRq2Ys
Message-ID: <CAHYQsXRpG9LL5cL9w_UPWpZpR-TiOp2QZzF5k69NiEzT8+oOFg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Fix use-after-free in acpi_video_switch_brightness()
To: Hans de Goede <hansg@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

Thanks for the feedback! I've submitted it in patch v3:
https://lore.kernel.org/all/20251022200704.2655507-1-danisjiang@gmail.com/.

Best regards,
Yuhao

On Wed, Oct 22, 2025 at 4:28=E2=80=AFAM Hans de Goede <hansg@kernel.org> wr=
ote:
>
> Hi Yuhao,
>
> On 22-Oct-25 6:25 AM, Yuhao Jiang wrote:
> > The switch_brightness_work delayed work accesses device->brightness
> > and device->backlight, which are freed by
> > acpi_video_dev_unregister_backlight() during device removal.
> >
> > If the work executes after acpi_video_bus_unregister_backlight()
> > frees these resources, it causes a use-after-free when
> > acpi_video_switch_brightness() dereferences device->brightness or
> > device->backlight.
> >
> > Fix this by calling cancel_delayed_work_sync() for each device's
> > switch_brightness_work before unregistering its backlight resources.
> > This ensures the work completes before the memory is freed.
> >
> > Fixes: 8ab58e8e7e097 ("ACPI / video: Fix backlight taking 2 steps on a =
brightness up/down keypress")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
>
> Thank you for your patch, this is a good catch.
>
> > ---
> > Changes in v2:
> > - Move cancel_delayed_work_sync() to acpi_video_bus_unregister_backligh=
t()
> >   instead of acpi_video_bus_put_devices() for better logic clarity and =
to
> >   prevent potential UAF of device->brightness
> > - Correct Fixes tag to point to 8ab58e8e7e097 which introduced the dela=
yed work
> > - Link to v1: https://lore.kernel.org/all/20251022040859.2102914-1-dani=
sjiang@gmail.com
> > ---
> >  drivers/acpi/acpi_video.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 103f29661576..64709658bdc4 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c
> > @@ -1869,8 +1869,10 @@ static int acpi_video_bus_unregister_backlight(s=
truct acpi_video_bus *video)
> >       error =3D unregister_pm_notifier(&video->pm_nb);
> >
> >       mutex_lock(&video->device_list_lock);
> > -     list_for_each_entry(dev, &video->video_device_list, entry)
> > +     list_for_each_entry(dev, &video->video_device_list, entry) {
> > +             cancel_delayed_work_sync(&dev->switch_brightness_work);
> >               acpi_video_dev_unregister_backlight(dev);
> > +     }
> >       mutex_unlock(&video->device_list_lock);
> >
> >       video->backlight_registered =3D false;
>
> As you mention in your changelog, the cancel_delayed_work_sync() needs
> to happen before acpi_video_dev_unregister_backlight().
>
> Since this needs to happen before unregistering things I think it would b=
e
> more logical to put the cancel_delayed_work_sync(&dev->switch_brightness_=
work);
> call inside acpi_video_bus_remove_notify_handler().
>
> So do the cancel in the loop there, directly after the
> acpi_video_dev_remove_notify_handler(dev) call which removes the handler
> which queues the work.
>
> E.g. make the loop inside acpi_video_bus_remove_notify_handler() look lik=
e
> this:
>
>         mutex_lock(&video->device_list_lock);
>         list_for_each_entry(dev, &video->video_device_list, entry) {
>                 acpi_video_dev_remove_notify_handler(dev);
>                 cancel_delayed_work_sync(&dev->switch_brightness_work);
>         }
>         mutex_unlock(&video->device_list_lock);
>
> This cancels the work a bit earlier, but more importantly this feels
> like the more logical place to put the cancel call.
>
> Regards,
>
> Hans
>
>

