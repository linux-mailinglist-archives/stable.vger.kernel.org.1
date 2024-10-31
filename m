Return-Path: <stable+bounces-89441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A199B8249
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 19:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CA681F234B1
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1DD1C2456;
	Thu, 31 Oct 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SI9umZaB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A913DDB9
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730398144; cv=none; b=k92yrHLI5wwGqD+KfMA5vMXERImrWVuaq5RrCEvKjCMiDObSGdkf5e23IEngnSGp8J7zu4KU93tWCEaTltOCs7mVuRB2c+zcL9KW0uUl6urBXkvur9H+IY+np8ZgeXTVkbvag9Qrbcjbo0j1xsUYpK4M9p615vLBgnqucvLsss8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730398144; c=relaxed/simple;
	bh=6WL9U/tBdUVYMgXRPydT0ne2ZCMff3C3b0xsaExMkHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZvTIbVA6T8bnexs5B0Rwb07qLry4DxsR4nIy5qEwDOv3DeQn5SK1v3yHZWn1GFQH6/DMjOQp2aPyYiO2jknNv9DEqNLIt9SLK+QKV6mAm9qQqToTb/jbwxeF5Jp/h+oZz1qM5ZPUDsnu39P/cO/AhO9XIxwj9r0eKdXNn9witY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SI9umZaB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso1647316b3a.0
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730398142; x=1731002942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pVgOa/QZhTZiBeHtmf8e1CXBuckyslnnwRoxjZXX1w=;
        b=SI9umZaBptNkIvlZPZlfM5a7FMdP7lhzzaDPWYIjk23de2IFzG8IOhjoA9y419c3F5
         o1JJtQ87CTv45r9g0aUH63/LYoUj0fRIsogmf2UrgXpInldQmyBRLiIg1q5FDzh+wwBd
         79EKho0d3nRe2l7yaX6ByD5+FBEMcZ8VN57YHJGmDZuSeIcTlPp9ufdL8l9Kv904pmXj
         SnrkFputUY5ETtIoZbt4y7HNAzWBTQHcVrGb9hbNUm0XMtMIpE25HsnzwvIXEFhG4wse
         xzil2oyQv+yIM9SkCX01kcHFutnjToKd/fANehEBDm9WNCnUPYiK2THA5ZVCaFp71vHQ
         aNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730398142; x=1731002942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pVgOa/QZhTZiBeHtmf8e1CXBuckyslnnwRoxjZXX1w=;
        b=Xz9GRTst06wCzgIgQL6XbypzhrkR+74IVS8hO7DmWcvi8XFapuBvcDTJ2nXjAKVqsr
         Vbx59hiMCqKsuqD6plA+fgyewUm88M4TPyOv6oBC1C2IS0Ov5QiTSK/3NleHFsarwVIA
         WBQ+v66gUemArcEw5CNyY7NCfKY+E6RMHjmJ4febBz3LeBHH26kchq46g9G7CVRbTj8t
         Vrz1lHDuRYUpXGoAXJiMYU4n6jn7/024KrroIK0H4yRvfQhE5p9lSxEQV9BRP5FzPae4
         m4MRBNajBOVRjNI0TxpTqBS8kUvIFets4WcRW52Ue7C9L0Ly8J021uqmAmzMQOeqB1J+
         Fjtw==
X-Forwarded-Encrypted: i=1; AJvYcCWaORRMtquN0aqm14t4EwYfm+PMo/WJ4MFUyVLXWYyjE19KE4tQ9qZ9cIOhbdbsZaJQIOcvH3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKe/IuJv9mCOgSdYVvmLlszbiKBK31rqBE6eb05yWXoCIKrSSb
	6X0MztHwuGP/EtRq7jbUAiUMGFKT57rqANpfl5cTs5GhWdRgvRvHF52yfq1FdF9vD+qK1iWkYOV
	/wMv+vtePQMJTMs84b5GH4rwpFm/wQkOaZpet4A==
X-Google-Smtp-Source: AGHT+IHF0fGwSEx/W18Jo8oLBr+O/BniQBYcRyrEnRYItjHhfVVikd1Y59KcKL8mYSIwO64USidkVsxeZVVb2mmWfl4=
X-Received: by 2002:a17:90b:540c:b0:2e2:b94c:d6a2 with SMTP id
 98e67ed59e1d1-2e93ddf4d4fmr5247891a91.0.1730398141765; Thu, 31 Oct 2024
 11:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028125000.24051-1-johan+linaro@kernel.org>
 <20241028125000.24051-3-johan+linaro@kernel.org> <CAMRc=Mf6yaZMsF5x=vPet=y9fa5ZTuWSAA=oi+Qw07TF8GEFbA@mail.gmail.com>
 <ZyO5a85wq1fKD-ln@hovoldconsulting.com>
In-Reply-To: <ZyO5a85wq1fKD-ln@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 19:08:48 +0100
Message-ID: <CAMRc=MeC85QLFYXdq3v_4rC=jst3PoSTOJz61GFEpw_yKa+iMw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: fix debugfs dangling chip separator
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 6:07=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Oct 31, 2024 at 06:02:43PM +0100, Bartosz Golaszewski wrote:
>
> > But with this change we go from an incorrect:
> >
> > # cat /sys/kernel/debug/gpio
> > gpiochip0: (dangling chip)
> > gpiochip1: (dangling chip)
> > gpiochip2: (dangling chip)root@qemux86-64:~#
> >
> > to still incorrect:
> >
> > # cat /sys/kernel/debug/gpio
> > gpiochip0: (dangling chip)
> >
> > gpiochip1: (dangling chip)
> >
> > gpiochip2: (dangling chip)
>
> Why do you think this is incorrect? Every chip section is separated by
> an empty line, just as it should be:
>
> gpiochip0: GPIOs 512-517, parent: platform/c42d000.spmi:pmic@0:gpio@8800,=
 c42d000.spmi:pmic@0:gpio@8800:
>  gpio1 : in   low  normal  vin-0 no pull                     push-pull  l=
ow     atest-1 dtest-0
>  gpio2 : in   low  normal  vin-0 no pull                     push-pull  l=
ow     atest-1 dtest-0
>  gpio3 : out  low  func1   vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio4 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio5 : ---
>  gpio6 : in   high normal  vin-0 pull-up 30uA                push-pull  l=
ow     atest-1 dtest-0
>
> gpiochip1: GPIOs 518-529, parent: platform/c42d000.spmi:pmic@1:gpio@8800,=
 c42d000.spmi:pmic@1:gpio@8800:
>  gpio1 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio2 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio3 : ---
>  gpio4 : ---
>  gpio5 : in   high normal  vin-0 pull-up 30uA                push-pull  l=
ow     atest-1 dtest-0
>  gpio6 : in   high normal  vin-1 pull-up 30uA                push-pull  l=
ow     atest-1 dtest-0
>  gpio7 : out  high func1   vin-1 no pull                     push-pull  l=
ow     atest-1 dtest-0
>  gpio8 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio9 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio10: out  high normal  vin-1 no pull                     push-pull  l=
ow     atest-1 dtest-0
>  gpio11: out  high normal  vin-1 no pull                     push-pull  l=
ow     atest-1 dtest-0
>  gpio12: in   low  normal  vin-1 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>
> gpiochip2: GPIOs 530-537, parent: platform/c42d000.spmi:pmic@2:gpio@8800,=
 c42d000.spmi:pmic@2:gpio@8800:
>  gpio1 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio2 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio3 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio4 : out  high normal  vin-1 pull-down 10uA              push-pull  m=
edium  atest-1 dtest-0
>  gpio5 : in   low  normal  vin-1 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio6 : out  high normal  vin-1 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio7 : in   low  normal  vin-0 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>  gpio8 : out  low  normal  vin-1 pull-down 10uA              push-pull  l=
ow     atest-1 dtest-0
>
> Johan

Ah, makes more sense in the context of mixed good and dangling output.

Nevermind my comment.

Bart

