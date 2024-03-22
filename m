Return-Path: <stable+bounces-28612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4EE886B9A
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 12:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CF3284B2F
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091763FB87;
	Fri, 22 Mar 2024 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ur8jCYAx"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE33FB19
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108363; cv=none; b=PRsRnDM7sR2ky+uj9gTJ0vblH3clczHjxck2WNJZ2pMqg//dojnOzXFB5TLB365CWflOTGv1hFGVJWP5BtvTJnXJ9ifoJCBNzdnK7i30iIvR2bO6r684bjkMcqLKke2ITShkq7iy7g/Cb20RA5j4ApIQvGIqCbUuMo9nnkuHTsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108363; c=relaxed/simple;
	bh=x+a9e6Frx0VlBb4fwtx3sGzeXPW2PGanVCb6UGSYC30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJ72p3EetPj8IYerLajKa0h1BKOoDcyJbB0OLZySQAIuTWfdkc+ouilP7GmnX5zt+QAtRRQjug/Qtz5LO1G896G17EIJU4KvdhzMRqiRsikKoySrkKTwmZRMb712dNm9GSgfNah6V3Bcu5exXqV+XUHfTs6GOj2AvBW768LnwxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ur8jCYAx; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d687da75c4so24448511fa.0
        for <stable@vger.kernel.org>; Fri, 22 Mar 2024 04:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711108360; x=1711713160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVWFUDwpLHRWKDYEaq1Gc8i1EAEVOWiexCNmJxdcxRk=;
        b=ur8jCYAx2yLsvFWywcV8HOlgN7UrRzXgONknLA60UdcW1j6X3pkVAK9rt96aOVQHIk
         EowLG+h1vT/ysD77+Ale4zyHM6NCeEtPdq6Oyl49TmyD7TdkDsg3dTEcrHNa6S3Z8sWd
         7w+VfoNG4N7AbOAAiSaNwH0uwazh1fGQJycwLhV5RZ0fMDORjAZ8BNk5ZV3yO2Akv+sL
         tlwInav+rH1WY6Q8tzuZMhopPRZGiJwghgR09as5xH5lAsj4auONK0uFRRMKoKn+yUKl
         WOkomPl7gTjf92SuDFh9XYZ6tcImsWCqZYb7u7aSH4RvdRpUTftIapD0MxWs8S8EZ7ak
         COMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711108360; x=1711713160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVWFUDwpLHRWKDYEaq1Gc8i1EAEVOWiexCNmJxdcxRk=;
        b=w9gfn0aG5woTAK7iTIfGYqPsHXxLYMtcNhm07tGi/G2DWmAvvNnalPZnP+Q3eigWjP
         VSs5kFnoltd89B+dB0QmgFVIVBQZLOaWn95Tci4fkYPjfCKQBOZGYdL+vSTa78OfVIWl
         ea8vOU1LuhC24c/8qw3r+Nx6E4C5aSSTb/oseXRNcuxbwbbmEzoQKdD+SBcyCCTl7a8Q
         kNsM8LpBXOcm0cXCeoYdV0jPLHnKT+Xdu9wYnyPKaDSUUbg2b5GJYEPtT46QzQ9tau+S
         ImqmlpFAybtwVGKxNozNtgx0Y/N53CDwm+8k7Kqdq7rekZhlnarKYt0xnUsX6N09P1ha
         z0lw==
X-Forwarded-Encrypted: i=1; AJvYcCVP8fyadndzqm0p0PbyU7hN7DO+WXV59cfJgR+Z6y552SHp4RzfWC70jCSWtvHAWk8oxAzrmwR70TW0n0puPZqXPWWvRbql
X-Gm-Message-State: AOJu0YwW2E1QJFomyNWEwtgJbYDCuWzN0MviudGQDjZkqpQIKPtnJrXg
	f2FYF8oJAP0vWHZ1oMS0BNfpwvwCBzvsNVctmkhJSTM368PRyJR0aMLbzLXGOc/oMGAenusRs4n
	6Gc29y101MIMB/kq8zUPkjctz6ArnhdKwe/90yg==
X-Google-Smtp-Source: AGHT+IF/QBC/XHMCsVWI52LV3ij5tlkUWiGM7xOVip6HJdc4V/iuOPS3esn/2MrMi3SBgwp8I6jTFKtKxXphgBDt0MI=
X-Received: by 2002:a2e:9056:0:b0:2d4:76d6:e9c9 with SMTP id
 n22-20020a2e9056000000b002d476d6e9c9mr1542931ljg.52.1711108360010; Fri, 22
 Mar 2024 04:52:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322090209.13384-1-brgl@bgdev.pl> <20240322111835.GA24228@rigel>
In-Reply-To: <20240322111835.GA24228@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 22 Mar 2024 12:52:29 +0100
Message-ID: <CAMRc=Md87eGmjehSEegdFCdv6D3H1p2On153JowY5cDnW9iw8Q@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: cdev: sanitize the label before requesting the interrupt
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:18=E2=80=AFPM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Fri, Mar 22, 2024 at 10:02:08AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > @@ -2198,12 +2216,18 @@ static int lineevent_create(struct gpio_device =
*gdev, void __user *ip)
> >       if (ret)
> >               goto out_free_le;
> >
> > +     label =3D make_irq_label(le->label);
> > +     if (!label) {
> > +             ret =3D -ENOMEM;
> > +             goto out_free_le;
> > +     }
> > +
> >       /* Request a thread to read the events */
> >       ret =3D request_threaded_irq(irq,
> >                                  lineevent_irq_handler,
> >                                  lineevent_irq_thread,
> >                                  irqflags,
> > -                                le->label,
> > +                                label,
> >                                  le);
> >       if (ret)
> >               goto out_free_le;
>
> Leaks label if the request_threaded_irq() fails.
>

Ah, dammit, I didn't catch the fact that irq_free() will not return
the label address if the request failed.

Nice catch.

Bart

