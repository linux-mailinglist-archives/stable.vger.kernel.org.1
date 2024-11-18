Return-Path: <stable+bounces-93788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602FD9D0F17
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 12:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2BEC1F21554
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 11:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAFA194A5A;
	Mon, 18 Nov 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="20YtopcG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A68192D66
	for <stable@vger.kernel.org>; Mon, 18 Nov 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731927615; cv=none; b=bIZ/jD4eJLnhKIqsZH8nNB5aEvEcrvroikQ+KXbDN0y1EdJwQsFX22JNoBabuGRvQODo/nVtzRjt4KU3Skcof9DIiKXbg67RjRx6Ny2xTBu6pWKCfSxG4sLcyGcjUmNnQxNFw7uVFYy3QV25kiBAaPQ6Ma/FpFEMeRGvXIkzPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731927615; c=relaxed/simple;
	bh=+xnek6Wh0IPQp2lxAxisV9ZqQmC5DXcU0tVBwhOmqbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te0lXbRBLn+np1YQtroX5e+MWbw+yy4EoOnuHO3sDayNVe2dX+sDihHtdvupTTQcW87CpTAZEZD7oISBgqhdUZuqOru/jjs1uHJQasKSFwvvY7o3DpHGZOw+TegFqPlHlYLL0c0ZxYYp/rNcyOmio9MpJ0IX1DSPj67T/YJddDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=20YtopcG; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da353eb2eso2373624e87.3
        for <stable@vger.kernel.org>; Mon, 18 Nov 2024 03:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731927612; x=1732532412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKJAAp8SoaxPkgWLz00EhCBjpjxNk0qC3KM0z2OVqfY=;
        b=20YtopcGOLHHPQWSkTAycbGTesNE1237DrzOEnAp9S2+CFGBbtlL7lI1zQ/hihJ6e3
         apdvFXchI7QXtADam4D/p4iRXrs/L8vwyazoz281A2HRvKZnhCz58CEKweT/NRZdbNHK
         IBUR7zyeVwMY7ncNwMmdwfzl6WaYQFHvJD2OwGr42TZTs4EAP5vX8Ame2rhnHswYFltv
         lEr3jKmlIJfDJO7jhwQqogxeoPYIyNKD6ea2nlCSyp+4sZd2aBN0yHTyCoXkLIVXnm6Q
         A1lKVbOrSVqHv/0ktwT49GMYYJHzoTOgKm0S3LObHC5ZkLfnrwwjz4a7EEpB8PdKGzOM
         /G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731927612; x=1732532412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKJAAp8SoaxPkgWLz00EhCBjpjxNk0qC3KM0z2OVqfY=;
        b=p6b21/eiJVOVdkD2AQoH8SHorAonKeZILgDTngUF6d8UBJ5dVWhEV3uLU9GOuU9meu
         JgXuDrmsg7Z8t0/S6+aQUz3JKaFi8DUjjDY8AY8zOEBsn8kWiReDYTtnHRV1mrJ7UeoB
         C3KRDAh0pqbC4yWnXzqCEd7jpwuKguD1qeygCJrPSJ+ZD5/kboGyw/xwVlOjrqpvo/1C
         CJfTOK6em8mmKF4YH0rHzkfyhvwnrTGbs/ieIIDRLBdXo3FV9nfP++iKofEwND7hJGtl
         z9HMjiHL7iUt1GaIip8zdiq3F6KgaFczp+bLbJz4JCQeCtQCN45umjpD+mEM50taiphw
         8VyA==
X-Forwarded-Encrypted: i=1; AJvYcCW42GQsGxlze2LWr16I2JLOHAAcpBgjETBi1vYMXqhGYRo97KnQuQjT5NFuG6XRm+PKp7s3OL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6R5iHTCY2YubdpgXzhzRptppc2AiYP2b6+90zfOZkLyTdJH91
	5PJpyTDDgqp9F42/bodGiPuwaIHzs9fhlR+DAKjnKWZaKVQ0J8gOSo+dEpj0oTo+GXzsQj4HKJ8
	D36mY4lEpSPXEuXXZumS2C7/CyNSx2sbm6wURIQ==
X-Google-Smtp-Source: AGHT+IERHUB92QGdKcUJGTcL3aVcrxHgtUlcoHFmwwDkZ+am4Lp5JmzuTgwRTDMkHhd4Bmv/CYTq7vCPVthcVsCxwOI=
X-Received: by 2002:a05:6512:282b:b0:53d:a0a7:1a8d with SMTP id
 2adb3069b0e04-53dab3b16b6mr6936141e87.46.1731927611787; Mon, 18 Nov 2024
 03:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZykY251SaLeksh9T@smile.fi.intel.com> <20241105071523.2372032-1-skmr537@gmail.com>
 <ZyouKu8_vfFs20CB@smile.fi.intel.com> <ZzN0nn6WFw2J8HTF@smile.fi.intel.com>
In-Reply-To: <ZzN0nn6WFw2J8HTF@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 18 Nov 2024 12:00:00 +0100
Message-ID: <CAMRc=Md=tv6QapMCoiLf6eeK9qOtG1jvENHnKdTk2i6U+=8p5A@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: exar: set value when external pull-up or
 pull-down is present
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sai Kumar Cholleti <skmr537@gmail.com>, bgolaszewski@baylibre.com, 
	linux-gpio@vger.kernel.org, mmcclain@noprivs.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 5:09=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 05, 2024 at 04:39:38PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 05, 2024 at 12:45:23PM +0530, Sai Kumar Cholleti wrote:
> > > Setting GPIO direction =3D high, sometimes results in GPIO value =3D =
0.
> > >
> > > If a GPIO is pulled high, the following construction results in the
> > > value being 0 when the desired value is 1:
> > >
> > > $ echo "high" > /sys/class/gpio/gpio336/direction
> > > $ cat /sys/class/gpio/gpio336/value
> > > 0
> > >
> > > Before the GPIO direction is changed from an input to an output,
> > > exar_set_value() is called with value =3D 1, but since the GPIO is an
> > > input when exar_set_value() is called, _regmap_update_bits() reads a =
1
> > > due to an external pull-up.  regmap_set_bits() sets force_write =3D
> > > false, so the value (1) is not written.  When the direction is then
> > > changed, the GPIO becomes an output with the value of 0 (the hardware
> > > default).
> > >
> > > regmap_write_bits() sets force_write =3D true, so the value is always
> > > written by exar_set_value() and an external pull-up doesn't affect th=
e
> > > outcome of setting direction =3D high.
> > >
> > >
> > > The same can happen when a GPIO is pulled low, but the scenario is a
> > > little more complicated.
> > >
> > > $ echo high > /sys/class/gpio/gpio351/direction
> > > $ cat /sys/class/gpio/gpio351/value
> > > 1
> > >
> > > $ echo in > /sys/class/gpio/gpio351/direction
> > > $ cat /sys/class/gpio/gpio351/value
> > > 0
> > >
> > > $ echo low > /sys/class/gpio/gpio351/direction
> > > $ cat /sys/class/gpio/gpio351/value
> > > 1
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Does this need to be applied, Bart?
> Seems it is missed in your branches...
>

Maybe if the author used get_maintainers.pl as they should, I would
have noticed this earlier?

I have some other fixes to pick up so I'll send this later in the merge win=
dow.

Bart

