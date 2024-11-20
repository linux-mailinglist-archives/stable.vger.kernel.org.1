Return-Path: <stable+bounces-94430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D29D3E94
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 16:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121CE1F27447
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1B11DF25A;
	Wed, 20 Nov 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+1F921w"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AE1DEFDD
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114616; cv=none; b=BlTgYcwRw7F2V/x2Fji+hJ5RUtzwPXDliQ+3UdA6+cLN3kk9YY/cT7b5FjY/k9Amgh4zl33vs/N3qALTlOwf1lJJN2AW4Rs6fLvTa1lPfo16zYPG2wljyiqsDz0kgK3cUyrUp0hxxq2+bySls4ZwXiYRybvZF50i77O92WaSt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114616; c=relaxed/simple;
	bh=Sdrpx2VPHJkkk8R9qLhdWl2/2DIy6v4cR2cwXM8ZlxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFO9wHxP/Qgi/1Cant8KwP9kcc5JNlIDeZdVM+7juZh9bDQsLB2JKWvwlK7ZmHAbM/e6+0IqfnvCEI18kLBITQWIQWRQYNh7LSF3oNFzQWlz344iaj+lZfqoXCFa6kRiGYLVD3lFIYQpDpqJU8zuI4sGVxJAegLlMsq8OYiDExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C+1F921w; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ff550d37a6so26493911fa.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 06:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732114612; x=1732719412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NBsV/rg/DvM7RipSshL11jcFCJtCro+s6m5KThfTUg=;
        b=C+1F921wLH97NjKiGYUo3kD/ZBtTgmz4cORSOi0eTfFNAWVbkVdxGx4zSWRdY5lb44
         OErxKvmWm5xsHYrsbQ0qXvdnZJjHqobrqc/yZXqmV2p/zaLm4TlmH97LM7lqF3iMEkRW
         a8vvyylHD96nNA8K/Gu8jRmw4OT6EGN2EpCkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114612; x=1732719412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NBsV/rg/DvM7RipSshL11jcFCJtCro+s6m5KThfTUg=;
        b=nAuPXG/luVknyoHWVEBn3sNieYbBk4PyBMkAj2wOFPwBEbJnKOMpG0tAYSv1jlwQte
         cgoX0mA8cC3VRAe0Y9SoBvl7NedPIqJl1dPsl17yvltRpKyO95mg/1+fS7+OmLyixiRM
         rolLlvPBuI6dVGHXDq9vcDTa/MMe7D7/7OosdfoJHvWfgJNrKcHfaEc/OJZPb2JSWSrI
         kjP0WMx/NSm8C0khHh4woPOEFbsZlVSELfYLtz/Psin8RYG2UbpBsAlOe+5HG0667FrM
         FtP7qhgwYTyHmJSTUINAxiYv/3L/OHdGbXLWd67vtdHU1JuJiLXBsN/NUxHshxN4Xp1o
         AQqw==
X-Forwarded-Encrypted: i=1; AJvYcCWxbkcEI13G8UUdLG75hjPt0ELFPha97gMYshxJLU9p0Fbc/ZRW+oZDXjWziGSm3LU9gZjJCL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfHIiJEDa1mCYmc6OoCvUT1pttQwNdeo2L3tCip9+Rj3MB17FY
	9Gqnqrf0A3AUXr9QZDEgDSRyOaUp5NJ6MXRi9WK2WajLXxv+Ew7+flSE6oYSWzugAAAy54WNj7y
	zHIHkgbzNgQ9OVEeK24fe++EZbYbk05gQKmU=
X-Google-Smtp-Source: AGHT+IE34no18QMiQZWPw8C1ekAOHMd7xhhyFqGs9+uBMiogoqk1//tsHgwT+WkuzpTcz4PGs/pTNf6Y7b/DV/9f2jI=
X-Received: by 2002:a05:651c:12c4:b0:2fb:607b:4cde with SMTP id
 38308e7fff4ca-2ff8dcd2f96mr16013621fa.39.1732114612186; Wed, 20 Nov 2024
 06:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104154252.1463188-1-ukaszb@chromium.org> <5iacpnq5akk3gk7kdg5wkbaohbtwtuc6cl7xyubsh2apkteye3@2ztqtkpoauyg>
In-Reply-To: <5iacpnq5akk3gk7kdg5wkbaohbtwtuc6cl7xyubsh2apkteye3@2ztqtkpoauyg>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Wed, 20 Nov 2024 15:56:41 +0100
Message-ID: <CALwA+Nb31ukU2Ox782Mq+ucBvEqm9_SioSAE23ifhX7DsHayhA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: ucsi: Fix completion notifications
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, linux-usb@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 6:58=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Mon, Nov 04, 2024 at 03:42:52PM +0000, =C5=81ukasz Bartosik wrote:
> > OPM                         PPM                         LPM
> >  |        1.send cmd         |                           |
> >  |-------------------------->|                           |
> >  |                           |--                         |
> >  |                           |  | 2.set busy bit in CCI  |
> >  |                           |<-                         |
> >  |      3.notify the OPM     |                           |
> >  |<--------------------------|                           |
> >  |                           | 4.send cmd to be executed |
> >  |                           |-------------------------->|
> >  |                           |                           |
> >  |                           |      5.cmd completed      |
> >  |                           |<--------------------------|
> >  |                           |                           |
> >  |                           |--                         |
> >  |                           |  | 6.set cmd completed    |
> >  |                           |<-       bit in CCI        |
> >  |                           |                           |
> >  |   7.handle notification   |                           |
> >  |   from point 3, read CCI  |                           |
> >  |<--------------------------|                           |
> >  |                           |                           |
> >  |     8.notify the OPM      |                           |
> >  |<--------------------------|                           |
> >  |                           |                           |
> >
> > When the PPM receives command from the OPM (p.1) it sets the busy bit
> > in the CCI (p.2), sends notification to the OPM (p.3) and forwards the
> > command to be executed by the LPM (p.4). When the PPM receives command
> > completion from the LPM (p.5) it sets command completion bit in the CCI
> > (p.6) and sends notification to the OPM (p.8). If command execution by
> > the LPM is fast enough then when the OPM starts handling the notificati=
on
> > from p.3 in p.7 and reads the CCI value it will see command completion =
bit
> > and will call complete(). Then complete() might be called again when th=
e
> > OPM handles notification from p.8.
>
> I think the change is fine, but I'd like to understand, what code path
> causes the first read from the OPM side before the notification from
> the PPM?
>

The read from the OPM in p.7 is a result of notification in p.3 but I agree
it is misleading since you pointed it out. I will reorder p.7 and p.8.

Thanks,
Lukasz

> >
> > This fix replaces test_bit() with test_and_clear_bit()
> > in ucsi_notify_common() in order to call complete() only
> > once per request.
> >
> > Fixes: 584e8df58942 ("usb: typec: ucsi: extract common code for command=
 handling")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: =C5=81ukasz Bartosik <ukaszb@chromium.org>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucs=
i.c
> > index e0f3925e401b..7a9b987ea80c 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -46,11 +46,11 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
> >               ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
> >
> >       if (cci & UCSI_CCI_ACK_COMPLETE &&
> > -         test_bit(ACK_PENDING, &ucsi->flags))
> > +         test_and_clear_bit(ACK_PENDING, &ucsi->flags))
> >               complete(&ucsi->complete);
> >
> >       if (cci & UCSI_CCI_COMMAND_COMPLETE &&
> > -         test_bit(COMMAND_PENDING, &ucsi->flags))
> > +         test_and_clear_bit(COMMAND_PENDING, &ucsi->flags))
> >               complete(&ucsi->complete);
> >  }
> >  EXPORT_SYMBOL_GPL(ucsi_notify_common);
> > --
> > 2.47.0.199.ga7371fff76-goog
> >
>
> --
> With best wishes
> Dmitry

