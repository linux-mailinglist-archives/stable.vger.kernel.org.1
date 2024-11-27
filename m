Return-Path: <stable+bounces-95611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F38F9DA54F
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 11:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F616283BC2
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5C0194A7C;
	Wed, 27 Nov 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="TIborYry"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308818DF62
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732701880; cv=none; b=AI8qt94ilzLEfTahaflmzY1CcAir0xA/7PQ3Eew2tnKL37NhCRoz/zPySbhvqpJF7Dzeq+mOAy+mdX/kGOhHVxFnyOs6d0p//t5VgpBf8W8QDrIv/K7EnMVkdFLDmE8sbHU+wPPFOxC98B1TD6r4hHrOyh9I5E0zlICIjIT779w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732701880; c=relaxed/simple;
	bh=wNSW+FIAoqdK+JFp7CNVFvLcbUwf12stFr8KcvLvM+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvsdvEJCur3o2JUl16e60G0MjgIGsIUBgfXB6FecrqdCa8/CI6BKe9weQD2K4BZQqzvxhhSVKhyliE6t+igrZvgPLy/Ig9q89F6husz7NtXHofAmwoAg4fUgwatfU3gAxozAcQru7DqFcAKZogJ3PK/KyMadt2nex73V0Gruass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=TIborYry; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso1928153e87.2
        for <stable@vger.kernel.org>; Wed, 27 Nov 2024 02:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732701877; x=1733306677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vf1wKRQe6FutxLcxtYMQtFIbCMrmTBRP7ZXF6k4oMIM=;
        b=TIborYry8hM8nN4Js1j3Pv8UisDZ/aA0FgnM1ByC0dIKviGYPsm+NnrvKVy3u6hmSp
         c1KgH+RPssw2YJt9n2uykzFT56LxwVGaBbpz0kQuBFCraySmtkIumwwzNuqrY0gspSII
         4rmEbDdXHxCuHH4hK1Wjf64RBNZD3VhVuCqb1quE31Zf2TRWGhsagS3G7ELDrpju4ucT
         fKQzbpIzYKT64e1FI23zaFu0IQe54BIeu7H24qCwTvy2LPJ/Tgmo7hVFqF0tIKHPGhZl
         w8k4hbm6IDhymKdGNamxlPvSdfvJmGbCcuAVNLrhJKkQevR/yRhRKn391jWHggHK7nOq
         cLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732701877; x=1733306677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vf1wKRQe6FutxLcxtYMQtFIbCMrmTBRP7ZXF6k4oMIM=;
        b=ibZF3Bgy36/ARncbcExBcPsfBESGQXVlbZ9pdiNm3GtsOv5SjF0Ib7BTZooRFvUVjM
         YE+kEpv5T3yBa6NIhOzREfWNY3KYka/vkB+dyvjcAk90tIvSkYEdd3PUSx+d2//DnQsb
         ZSUK3rXlFDVyRvhZULZewniqQvOtjpz6luCRI3R8qsMaiePICy9LqdleXKCBWMT8xsN6
         t1eE7kUKW4mx8cNO95Gt02ECqCWVLC/gUAnrdqYSor++8o9yDCQjfwHreAdqsFxlWCJR
         inV7wVOn2vKCzi4AKj0G0TTMl4RZ8PxtOHB4QWfLXcEP0nM+Pp4xDpfOD1lpUtNALw6r
         fTag==
X-Gm-Message-State: AOJu0YxMMVXkpUvM9JPdkn+2EAj+sSJ3Kowp5Ex2sfOQ/3jp6EE3ooU5
	wIcUY3astivGhBwt12cc5Pr7g55uUtGBVngiipxJsW71+2oYIdTQm7ocEXrzxZgUEkJzuh/Jmwn
	wZisXR6e6irhFKV1fO8Lj0yoSLIZv7/98whRZHg==
X-Gm-Gg: ASbGnctzZU+nbZr8Lw7wGuNYDjI6TN2jJbNfU4ES9qtLh4ltDfV2ShHFvtGMaZ37ave
	vo0QlI6/oTPur13dvb4+gfaWZYjOoBQe2QUUvJIZSSSHuZmi9AvIfVz6+d3S9qGc=
X-Google-Smtp-Source: AGHT+IGveN0IV2OvJiUHdP1fItf0srV3Qo3ILoto0JMQSeR9WrrvS4nGF/+8MBrRzMMrZZ/G4EsFWKMavI5zqh+TSwA=
X-Received: by 2002:a05:6512:3b96:b0:53d:e691:8471 with SMTP id
 2adb3069b0e04-53df00dc89emr1102825e87.30.1732701877026; Wed, 27 Nov 2024
 02:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125080530.777123-1-alexander.sverdlin@siemens.com>
 <CAMRc=Md03oSc6jkib=g9B7C51i4aAD6LdXGHsmXuRxB7VjDxaA@mail.gmail.com> <0f5f4cca8b7f69b4b9cd3c34abceb7846e4cc187.camel@siemens.com>
In-Reply-To: <0f5f4cca8b7f69b4b9cd3c34abceb7846e4cc187.camel@siemens.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Nov 2024 11:04:26 +0100
Message-ID: <CAMRc=Mc6D=isJCWzZekx8p9RYXG3Bmr39u15bThEeXbzKgAbEQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: Silence lockdep "Invalid wait context"
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "ssantosh@kernel.org" <ssantosh@kernel.org>, 
	"khilman@kernel.org" <khilman@kernel.org>, "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 9:59=E2=80=AFPM Sverdlin, Alexander
<alexander.sverdlin@siemens.com> wrote:
>
> Hi Bartosz!
>
> On Tue, 2024-11-26 at 21:37 +0100, Bartosz Golaszewski wrote:
> > > @@ -647,6 +656,13 @@ static void omap_gpio_irq_shutdown(struct irq_da=
ta *d)
> > >          unsigned long flags;
> > >          unsigned offset =3D d->hwirq;
> > >
> > > +       /*
> > > +        * Enable the clock here so that the nested clk_disable() in =
the
> > > +        * following omap_clear_gpio_debounce() is lockless
> > > +        */
> > > +       if (bank->dbck_flag)
> > > +               clk_enable(bank->dbck);
> > > +
> >
> > But this looks like a functional change. You effectively bump the
> > clock enable count but don't add a corresponding clk_disable() in the
> > affected path. Is the clock ever actually disabled then?
> >
> > Am I not getting something?
>
> Actually I though I enable and disable them in the very same function, so=
 for the
> first enable above...
>
> >
> > >          raw_spin_lock_irqsave(&bank->lock, flags);
> > >          bank->irq_usage &=3D ~(BIT(offset));
> > >          omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> > > @@ -656,6 +672,9 @@ static void omap_gpio_irq_shutdown(struct irq_dat=
a *d)
> > >                  omap_clear_gpio_debounce(bank, offset);
> > >          omap_disable_gpio_module(bank, offset);
> > >          raw_spin_unlock_irqrestore(&bank->lock, flags);
> > > +
> > > +       if (bank->dbck_flag)
> > > +               clk_disable(bank->dbck);
>                     ^^^^^^^^^^^^^^^^^^^^^^^^
>
> this would be the corresponding disable.
>
> > >   }
> > >
> > >   static void omap_gpio_irq_bus_lock(struct irq_data *data)
> > > @@ -827,6 +846,13 @@ static void omap_gpio_free(struct gpio_chip *chi=
p, unsigned offset)
> > >          struct gpio_bank *bank =3D gpiochip_get_data(chip);
> > >          unsigned long flags;
> > >
> > > +       /*
> > > +        * Enable the clock here so that the nested clk_disable() in =
the
> > > +        * following omap_clear_gpio_debounce() is lockless
> > > +        */
> > > +       if (bank->dbck_flag)
> > > +               clk_enable(bank->dbck);
>                     ^^^^^^^^^^^^^^^^^^^^^^
> And for this second enable....
>
> > > +
> > >          raw_spin_lock_irqsave(&bank->lock, flags);
> > >          bank->mod_usage &=3D ~(BIT(offset));
> > >          if (!LINE_USED(bank->irq_usage, offset)) {
> > > @@ -836,6 +862,9 @@ static void omap_gpio_free(struct gpio_chip *chip=
, unsigned offset)
> > >          omap_disable_gpio_module(bank, offset);
> > >          raw_spin_unlock_irqrestore(&bank->lock, flags);
> > >
> > > +       if (bank->dbck_flag)
> > > +               clk_disable(bank->dbck);
>                     ^^^^^^^^^^^^^^^^^^^^^^^
> ... this would be the corresponding 2nd disable.
>
> > > +
> > >          pm_runtime_put(chip->parent);
> > >   }
> > >
>
> Aren't they paired from your PoV?
>

Ok, I needed to take a long look at this driver.

IIUC what happens now:

In omap_gpio_irq_shutdown() and omap_gpio_free() you now enable the
clock (really just bumping its enable count) before entering
omap_clear_gpio_debounce() so that its internal call do clk_disable()
only decreases the reference count without actually disabling it and
the clock is really disabled one level up the stack.

If that's correct, isn't it unnecessarily convoluted?
omap_clear_gpio_debounce() is only called from these two functions so
why not just move the clk_disable() out of it and into them?

Bartosz

