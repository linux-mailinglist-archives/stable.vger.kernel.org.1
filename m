Return-Path: <stable+bounces-163493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B2B0BAD4
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 04:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6C01699FE
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5472745E;
	Mon, 21 Jul 2025 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0WwHctJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D8C148;
	Mon, 21 Jul 2025 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753065252; cv=none; b=JF2ab+YdmrnpCRDds2T4XqWShsALZPsagWClksHn0O1ofl8dH4rWOws9ckouR8gSXiky1rf3qnjk7/9I6iSqcxvgIRq7WS+qNQap9cL1jP3Ab7zF3UWVvFxMWpX5Kn5pMypRNGwiF416GjRVSVAa/pHNES4sjg8wVQIjiGyUgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753065252; c=relaxed/simple;
	bh=PopoNCPq9ppiCWC+dl5GgdYqCQe8ryfKGMsbDlVoKR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqOxLlVyvaz5LLHdEUOLLuQeS0TYbY7ZdLs4xFu5X3Mc3vRFYwa+5YtTFZl3WTagrRj9Q8el0q41WPZ2aPJ3WBB/UzroULNhEWWftL7yO3srUK8YnA+KXq1+5uXJiUCdll+/O94zjOlP7NrfrtlKMIm7Vf0CjPr2/nMw0zNyOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0WwHctJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so621513966b.0;
        Sun, 20 Jul 2025 19:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753065248; x=1753670048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kBgf/fjjAiaMnIaqjQvfUG02VDiWQa+NjmrJXxmXHE=;
        b=K0WwHctJe7iOatadoFuulQgOUJS8BdojNg3qf4jdymN9D+xEZ3wJGVzVZEqZoW5kpq
         8j9IGixBWywkH7wgoK1+jAhVnnU0UuAdrekzhvD7g5/4jGvGkBNnv1B0VeGzswlq9vdt
         5Qh738VCcwz+4yJBIsd2XH8062sSPzK7wEnMhzcF+Fubupw79/D7xnvqs1AYjyldp2yj
         mJmR3jgbFW/Jf8A3dkJVwZIqzxGPw3TeX8T+GFmxmm9b0qFpy5BZurKVLn9aAGA4vUmN
         GttFK6C89PSFyBIDUAogezHkfiLcEIgR0ZJE72/bcwpQYelH7X3rLwoXhZw5PM9hkKB9
         ojMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753065248; x=1753670048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kBgf/fjjAiaMnIaqjQvfUG02VDiWQa+NjmrJXxmXHE=;
        b=L+NxtHppNT35j5QwVcXVf2fnkmYvbC5xAPBVMQXyPilN3NEJ4eeFEN3Lw09n1UXi8v
         o8hzXFP99F4BKj3uvm7e5QCkVEcE7IXMKf4DRF4CKaM5uHHbHI6OpqwlIGvcxJRKr/9L
         idU84aF0oWB/lhARmVRojd0h1uLEFzbqMxK3oo0Wn3rNFzKmT4BtjDRB/8wpYU36BIN2
         p8C9eUrYPwDUYSU4wWV71qztzteZqqQm4CAWlk0aSUGOXFaLfx8xglnnSoWB62Hx6Ez0
         XMjPdyZsRu5/JGsE9ljTnTMqBPP2U69pqSEUG3BJDuoku2BcmjrlGFDkfHhURI8vElzE
         X9JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY2dzsfh2WLTuMGw0r3gZQbhfs70tvnNMgb9ai1/wT95vn18K8/6k6fOcDZHFkLx80hoB17YbpH6ETWpY=@vger.kernel.org, AJvYcCWFksBpE3cGAdZrIwhmlBYDlTHEtSjKD9Q27Mz3slkUZ8mItB9uf9LVCB5vgS0sbFgBKdo81ncM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5nNc5g7NnllGaNo3nXbtHThditzYs9qfz7aFqR9RjfeHR7CXm
	ijGdTJgtL9b9HXdc9qw58U7Fdfc0SPetuaj0GM3kqF3Y5wvIr9f4Kbcz5gaLi8maJAuqfg1AaC6
	kSWM0FXoSwIhTVVZcJ8ClwHpimHlPf4E=
X-Gm-Gg: ASbGncvUj4Yjc9cnZbgLdddOlXQdM+Yxy1F92+9GubQfGn08SQ/MqwK7Nx8UeMC0FCn
	AfU7ClgiKQ8vjA7Abn3ykxz3v8fXnxDrfUp0jy4U0jX9C5/gGPymYo0H6BNRZbvYpwcwO3zX68O
	3Ylo+suk4iPOjwi0q07zV44HuqqdR8IuhW/Irm7tpRFa6WDKQ/hZvxcqJMmjtLvrSIwNooEOp4j
	Qp6eV8=
X-Google-Smtp-Source: AGHT+IFzgPvwol0/zp/kUvQjkOlGAw5nsXcbgbAIewV/J/HVbTbxn/Gm7xN4fFzMnDfpkB1fheu6mxhWCT+AMJcMHVA=
X-Received: by 2002:a17:906:d54d:b0:aec:578e:caef with SMTP id
 a640c23a62f3a-aec578ecd38mr1262813566b.35.1753065247785; Sun, 20 Jul 2025
 19:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711140143.2105224-1-ricky_wu@realtek.com> <CAPDyKFpmt4eTfBOWphH3LtoW9jAujBs7oAFqqnxkJvP+r83tkw@mail.gmail.com>
In-Reply-To: <CAPDyKFpmt4eTfBOWphH3LtoW9jAujBs7oAFqqnxkJvP+r83tkw@mail.gmail.com>
From: Gavin Li <gfl3162@gmail.com>
Date: Sun, 20 Jul 2025 22:33:56 -0400
X-Gm-Features: Ac12FXxwmPKz7Qquc_zyZCFjOxIdrUEka9rluxakzV1DaHgWkr2db9qUIElP6Zk
Message-ID: <CA+GxvY4x99MO-bd4s_ZRq54-+ELZ7UVPTFK0Fk=H1pnEGkPyxQ@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: usb: Ensure mmc child device is active when
 card is present
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, mingo@kernel.org, kai.heng.feng@canonical.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just tested out this patch, and it unfortunately does not address
the issue I was running into (where the driver fails to detect
inserting a SD card after the initial driver probe).

On Wed, Jul 16, 2025 at 6:39=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> + Gavin
>
> On Fri, 11 Jul 2025 at 16:02, Ricky Wu <ricky_wu@realtek.com> wrote:
> >
> > When a card is present in the reader, the driver currently defers
> > autosuspend by returning -EAGAIN during the suspend callback to
> > trigger USB remote wakeup signaling. However, this does not guarantee
> > that the mmc child device has been resumed, which may cause issues if
> > it remains suspended while the card is accessible.
> > This patch ensures that all child devices, including the mmc host
> > controller, are explicitly resumed before returning -EAGAIN. This
> > fixes a corner case introduced by earlier remote wakeup handling,
> > improving reliability of runtime PM when a card is inserted.
> >
> > Fixes: 883a87ddf2f1 ("misc: rtsx_usb: Use USB remote wakeup signaling f=
or card insertion detection")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
>
> This seems reasonable to me, but perhaps some of the USB maintainers
> should have a closer look to see if this makes sense. Nevertheless,
> feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Moreover, we had a related bug-report/fix posted for the
> rtsx_usb_sdmmc driver [1] not that long ago. Do you know if $subject
> patch solves this problem too? I have looped in Gavin, if he has some
> additional comments around this.
>
> Kind regards
> Uffe
>
> [1]
> https://lore.kernel.org/all/20250510031945.1004129-1-git@thegavinli.com/
>
> > ---
> >  drivers/misc/cardreader/rtsx_usb.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardread=
er/rtsx_usb.c
> > index 148107a4547c..d007a4455ce5 100644
> > --- a/drivers/misc/cardreader/rtsx_usb.c
> > +++ b/drivers/misc/cardreader/rtsx_usb.c
> > @@ -698,6 +698,12 @@ static void rtsx_usb_disconnect(struct usb_interfa=
ce *intf)
> >  }
> >
> >  #ifdef CONFIG_PM
> > +static int rtsx_usb_resume_child(struct device *dev, void *data)
> > +{
> > +       pm_request_resume(dev);
> > +       return 0;
> > +}
> > +
> >  static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t m=
essage)
> >  {
> >         struct rtsx_ucr *ucr =3D
> > @@ -713,8 +719,10 @@ static int rtsx_usb_suspend(struct usb_interface *=
intf, pm_message_t message)
> >                         mutex_unlock(&ucr->dev_mutex);
> >
> >                         /* Defer the autosuspend if card exists */
> > -                       if (val & (SD_CD | MS_CD))
> > +                       if (val & (SD_CD | MS_CD)) {
> > +                               device_for_each_child(&intf->dev, NULL,=
 rtsx_usb_resume_child);
> >                                 return -EAGAIN;
> > +                       }
> >                 } else {
> >                         /* There is an ongoing operation*/
> >                         return -EAGAIN;
> > @@ -724,12 +732,6 @@ static int rtsx_usb_suspend(struct usb_interface *=
intf, pm_message_t message)
> >         return 0;
> >  }
> >
> > -static int rtsx_usb_resume_child(struct device *dev, void *data)
> > -{
> > -       pm_request_resume(dev);
> > -       return 0;
> > -}
> > -
> >  static int rtsx_usb_resume(struct usb_interface *intf)
> >  {
> >         device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
> > --
> > 2.25.1
> >

