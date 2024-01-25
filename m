Return-Path: <stable+bounces-15781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCABC83BD57
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 10:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F78D1F2DC00
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 09:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC48E1CA89;
	Thu, 25 Jan 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EO4lUot8"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F521CA85
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174941; cv=none; b=o93eNBF39zkuJuFzwChUlR1Hzy7UhFfjK9fxo00Ikb16aaNIrM2PpphWuM1ZgW3f+rXgQJTD9AdId5we52ShWMmT4dQNCtAAjjq1/Ppd5MEUvjsMh2aSad7hyJFbc6ZHE7LlqiccZthr4CQr4Ct9K4M7UXFlKYK/t66pu7CwP0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174941; c=relaxed/simple;
	bh=Czou+Fc09Tc9zXH0osqCab6GeZhYtdc1i9VY6/QvHgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Llx2Dow7htx++sHj45AiwnVqzzCa3fMF/hujLOnbcgZmqN7MaDUdgvMdUOs1s7NWB96hK+icvavWYWU9YUFJpRoRlXaveSV/NNwhQo1hiXDl6TI8rxcaWako/TprbaCE4YkcbaCflXNAHiNY2QNp+/8HVA30yoCDBQESQ99hn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EO4lUot8; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-467e4a04086so1226863137.3
        for <stable@vger.kernel.org>; Thu, 25 Jan 2024 01:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706174938; x=1706779738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Czou+Fc09Tc9zXH0osqCab6GeZhYtdc1i9VY6/QvHgU=;
        b=EO4lUot8LR7hgPhWJYLxHCjBv8kbKrmGEL9z8122OztI2VoIlcXC80zxo+KWHk1wco
         BtZVXt+fyruJQHOHpva4ZjcZCnpYR4o0QO7F/1ge2HmuPai+Sr2gcvUc3q0U+/oYeiY/
         bBG7GsXLHnUyxWZ7OBn9ubY30eoMcw8stn/Z9JlF9dUzqt6oYq5T9yAIIPFc4BD0XltD
         3NRRaiUPAI9iNW/Se7qH9ajoORJM9XNxb1z7o5bRNQgadfwdExQByHpphgo8W89uvotH
         bhzgFCDrkDZHe3PBqEf2feMvr2d8/stKCh9sZ8YnfXs/a3AsKWOd0+a8veVmTqIKQKmT
         ydCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706174938; x=1706779738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Czou+Fc09Tc9zXH0osqCab6GeZhYtdc1i9VY6/QvHgU=;
        b=bSQ24OhoclFXkAwUtksclDkBpuYXXVuuDVOz2jDbGXs5/BrTDXpLjY7F4GEveOqFH0
         QZV9z9ki4rSuwA251RyPB5wJedSnNuEGNKLeMSk4ACnyGljEqo0hm9a7c8BoLvVtWwCC
         /gK7H5r1rc1lrl3O+Edb40fxkgMUBBYWpsJaMDrIrPkuUsZCjRh4zq/JtiQ3ZouIcUtW
         Ub8kIPsv6ULBAqc7EpIabsIpWJOtmcXL2HR7K6ZY7X8fqiPe98xsV37UgKP1aLk/xKzk
         wsWDsPH5yQn/00ZfITJ0ZZytu9VQvt/HRHVoImpbtDAcS5OOVjZFqsxEL0pO3fB3Qs6V
         0JHQ==
X-Gm-Message-State: AOJu0Yxed4wQgiQUGonEHquMMW6Oua4fwnxEnjbGtjUz8i44o8kvSWNx
	ibucoutxM/mhIYPXLCiMnZ2s+7FXBNBiGVW9oEcqz4+Efh+wDIy3CGp87Jiw3mfTBFFwJQ6Dvtn
	5OwEq08WTUezJ+uEuWFxAG99m5y1Z3xC8P9f5Wg==
X-Google-Smtp-Source: AGHT+IHWAK75KO7eUDVgQBY7634AqsxBL1EjuJMZm7NIdfKFtDNBo90CuaLYi3Ma2HadkTIgwjVGLskQhMUPcf+OjRY=
X-Received: by 2002:a67:c413:0:b0:46b:528:d5e1 with SMTP id
 c19-20020a67c413000000b0046b0528d5e1mr258950vsk.8.1706174938055; Thu, 25 Jan
 2024 01:28:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
 <20240125081601.118051-3-krzysztof.kozlowski@linaro.org> <CAMRc=MfYg5MgndDZtrAaScmtjXm4-AX6y1np7V3p4ngBKZG-pw@mail.gmail.com>
 <0039e8e3-bfb7-43af-ab04-53aeaa02f4b0@linaro.org>
In-Reply-To: <0039e8e3-bfb7-43af-ab04-53aeaa02f4b0@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Jan 2024 10:28:46 +0100
Message-ID: <CAMRc=MdXRm5UGu3abXXwtGhw5TG7NC0O5w6_X_RoZRH_C6YgdA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpiolib: add gpio_device_get_label() stub for !GPIOLIB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:14=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/01/2024 10:04, Bartosz Golaszewski wrote:
> > On Thu, Jan 25, 2024 at 9:16=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> Add empty stub of gpio_device_get_label() when GPIOLIB is not enabled.
> >>
> >> Cc: <stable@vger.kernel.org>
> >> Fixes: d1f7728259ef ("gpiolib: provide gpio_device_get_label()")
> >> Suggested-by: kernel test robot <lkp@intel.com>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>
> >> ---
> >>
> >> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> >>
> >> Reset framework will need it:
> >> https://lore.kernel.org/oe-kbuild-all/202401250958.YksQmnWj-lkp@intel.=
com/
> >
> > And I suppose you'll want an immutable branch for that?
>
> I guess that's the question to Philipp, but other way could be an Ack.
>

I prefer it to go through my tree in case of conflicts as I have a big
refactor coming up. I'll give it a day or two on the list and set up a
tag for Philipp.

Bartosz

> Best regards,
> Krzysztof
>

