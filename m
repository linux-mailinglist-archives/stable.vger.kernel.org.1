Return-Path: <stable+bounces-73655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5593E96E1B1
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D85D1F233F0
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2569158D66;
	Thu,  5 Sep 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWrHhTek"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5917BA5;
	Thu,  5 Sep 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560118; cv=none; b=oFx1nFWzSSaCl6uvTAeqAbf96hQBgPDmbzZjPzqMEeRAvFB/ADA75ahXEon+a4PlvhiY2w+9rFZ9ZUjthttRX3roSxbaGDgusdw9WzMdQ8kyFxHdrgMRpGpitP5YTr2yAQTiEnWTWd8kf9TRu9EXtJdE5HWRGYaecm6xJo43m1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560118; c=relaxed/simple;
	bh=wBY56xNa4zBgPpQmv5VPfBEbmmka+4hgb56iBDGetBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8ww2WSTQrEctOHRQ99hA6djvD0seqLv92xNZnRg6UvFPfE4MqmNvDBd5cHdYDxyFrVXV2qYRcqxhZwPA9Gk6N2zOpzCObNaDaJJFOrwFZ5K3SX3OMjC4EXggCL97nFo7mWA6rVVfezXEIvHycgzDDtmvUT3KGXReeIbu8Pxh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWrHhTek; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86b46c4831so159225266b.1;
        Thu, 05 Sep 2024 11:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725560115; x=1726164915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcA+x0ODc8xoGJ8BqRFK8Egx+E/gQmMNIkHt2OnASKY=;
        b=UWrHhTekYof4l/3qJbZCkka+UFocGPYOwbOLOWOqjXQ5wgjj5uSJou4rq5BNx//rm6
         S0+honPkRqxhUSZeHec7ju+uqrJN2il46GsZ0L14O7cA6gtJnx9Iwkr6AySdhAtdEQQq
         DdDSY3KD6mAQZRdELK0ROizDZI4JWxQ66Npe9agsSg0y2ayLd72mfy36uH8KHXiOrB4a
         XSwwKaOjnm4CfxMSfDCYHroW6PHrx6watnkbnj9xxML8uLKnkbiUvqsFhX1SnAHIBIHn
         FZ7Y+/sMzNNN0DWFQYX2JM0hjxGicIXHKI0UQmh0nOnwEQD1FfvpF8LFo/YARq7KYYYF
         1r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725560115; x=1726164915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcA+x0ODc8xoGJ8BqRFK8Egx+E/gQmMNIkHt2OnASKY=;
        b=Enq1cmcMFCmvq0PYA5TV8IRWDSu7FvRU67RPP1OoFNh/Xu5er/VeJCjDcVnZ+LPpz1
         4v4uDk5yf0sLo9kqwhAZZL6KRIBvXTvwaQxHZAgzizxFRROTTQzoj+VAC3RL4SyL3mC9
         a8VtgvpIl57UXN4SfID20rynCQH30YtlUQwb3OesfFg75YFmh0X4AcFB+YZY/Ci14TRx
         O5BDxs59KmldhAcQHPWSS4Zt+2ELhIm3WAlTa6zxIOOwEalFMm8+T/lRacmV+4iXaa74
         gMMRqrnvw/ENgEeIu2qxATWbMdpJP6igyK+HLMadS4VjJz8SrnjNdDIgx1w3Dz5Xo96s
         PCyw==
X-Forwarded-Encrypted: i=1; AJvYcCWLXhplWi/oM4ne3yPfbJafeb9PpwE6JUDtj5CYjt1TQhq1J0jIvCBmzWiPdD7CkecqfT+hB9W7nTo=@vger.kernel.org, AJvYcCWdZOkqMqt9shnuxGjKdpADX/BwQ1W6WWZslNiJ/2Eo81DotVSvbrGpobM37cad3FG7sEnRTuDK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5QDkHLLSOkn9stj8xPje6vHCYpKsUKJcoTZZXzrYwoS6IEEk
	Cm+UFF1DegVko/M3IITmnbAN3o3HdL6qEEwGxmJHEI+cHmOSI3fDXoAVn0EaaZuE0rJ3fZCH9R0
	YY9xKRegAp5Z53Igd8cSW9XdoYIY=
X-Google-Smtp-Source: AGHT+IGZCmcWILKokyJAuv/JPY1blcvNwDmAwjypzokG4Q6agCxbzv4A9BVWJ4h59GzoL1m1Of0OIujvYG9B+DuPdy8=
X-Received: by 2002:a17:907:980f:b0:a77:d85c:86fa with SMTP id
 a640c23a62f3a-a89d87204ebmr1247479066b.13.1725560115216; Thu, 05 Sep 2024
 11:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904201839.2901330-1-bvanassche@acm.org> <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
 <8feac105-fa35-4c35-bbac-5d0265761c2d@acm.org> <d50e3406-1379-4eff-a8c1-9cae89659e3b@google.com>
 <bcfc0db2-d183-4e7b-b9fd-50d370cc0e9b@acm.org> <CAHp75VeA6N_jmkz0-asjogYx4ig8Q=zxnNM7C4m5FV94pH-nCg@mail.gmail.com>
In-Reply-To: <CAHp75VeA6N_jmkz0-asjogYx4ig8Q=zxnNM7C4m5FV94pH-nCg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Sep 2024 21:14:39 +0300
Message-ID: <CAHp75Ve4qfvBDgDHnjDbRW5buXnhGSp1aOQ6avOLGYnBY8UggQ@mail.gmail.com>
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking complaint
To: Bart Van Assche <bvanassche@acm.org>
Cc: Amit Sunil Dhamne <amitsd@google.com>, Badhri Jagan Sridharan <badhri@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 9:13=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Sep 5, 2024 at 6:01=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
> > On 9/4/24 3:34 PM, Amit Sunil Dhamne wrote:
> > > However, I have seen almost 30+ instances of the prior
> > > method
> > > (https://lore.kernel.org/all/20240822223717.253433-1-amitsd@google.co=
m/)
> > > of registering lockdep key, which is what I followed.
> >
> > Many of these examples are for spinlocks. It would be good to have a
> > variant of spin_lock_init() that does not instantiate a struct
> > lock_class_key and instead accepts a lock_class_key pointer as argument=
.
> >
> > > However, if that's is not the right way, it brings into question the
> > > purpose
> > > of lockdep_set_class() considering I would always and unconditionally=
 use
> > > __mutex_init()  if I want to manage the lockdep class keys myself or
> > > mutex_init() if I didn't.
> > What I'm proposing is not a new pattern. There are multiple examples
> > in the kernel tree of lockdep_register_key() calls followed by a
> > __mutex_init() call:
> >
> > $ git grep -wB3 __mutex_init | grep lockdep_register_key | wc -l
> > 5
>
> I see pros and cons for both approaches, but I take Bart's as the simpler=
 one.
> However, since it might be confusing, what I would suggest is to add a
> respective wrapper to mutex.h and have a non-__ named macro for this
> case.

To be clear, something like

#define mutex_init_with_lockdep(...)
do {
  ...
  __mutex_init();
} while (0)

in the mutex.h.

--=20
With Best Regards,
Andy Shevchenko

