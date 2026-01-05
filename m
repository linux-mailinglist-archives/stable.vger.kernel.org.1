Return-Path: <stable+bounces-204867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D68CCF4FED
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AC97301B66C
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990003168F7;
	Mon,  5 Jan 2026 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bBO9/wRN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CD2ECEBB
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634116; cv=none; b=axDbLEwSbsY3TWjBIuhcgDi7GiIZO2yOxCYQeVADr1at3vgMlEdK7iZN07fqutHCRg5dj0Abcrhnj5cIHuusSIpRPw8PfSjfq5xyuNfmN8y0FiWV7KX9AjDhAeE7DDRWLMxX9QAS2hXcDAR84lREhv7csW+HyiyATNJoUvA/eXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634116; c=relaxed/simple;
	bh=X+w4qyFtEyMwzhhxgFY/CtE0PdRwRP2uvw32cpV5NjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu26QSVvg+/srRtdKczXjUpV+I88Th+KGjUapsoR2jigRhOymWHVlS01FEuFHqLpVC7YMVp6S52FOs7hvABCwC8QLregecXDi92g91xDxFyKlbnUCCGO5u7/xQmEMYcxGw2BKhxYPEwekm2Y5ZAIjosiPrIRze5bwRHuEb3NiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bBO9/wRN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0d6f647e2so1720825ad.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 09:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767634114; x=1768238914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/1XjgDM2zvwUKqTXN8xIQijd7DIn4lsKVtfgTVJNUw=;
        b=bBO9/wRNMv/MaOa3XFvMlFYfyO2Erv3AR+KkhTmok70fewjn2iap2Tfg23rk/mlSTO
         H3YwOa1r+gdwJTVpYuP+PCd/si2gEVaLOrujAf1RAh/2R6WgIMCnosGIDgJRqpCHV7JK
         QYSonb4bxWrdRqF9ypC7y03LsbQFgW3ogy4XovMJiYNCylZjXR6v5bQ45M6GsICOu7aN
         L0AHyFDgSDoXBSlMJT1OsphByVoufnwLh/AILI1VV4HIBTXG/1Yb+bXx0vv0mLIepysi
         oHuEP8VHStRzuBu7yN6jUEDfyv7qhKXlEbGhEuOs1nuv4pb8QBVLoJ+TWofGxBbQZ6Lr
         +a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634114; x=1768238914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y/1XjgDM2zvwUKqTXN8xIQijd7DIn4lsKVtfgTVJNUw=;
        b=QndZVpNxbypP4SuqctcR03QcbTku7jqQE+7yj+NtwYiMqUZlDVowcUV5iiIzW+ioC8
         mJRr0BIZvcnOYY/PyrNOdW4GMBq34eURsFY6C//UL2xPQK496ZFzPzLtMffUavx072b9
         ygZS9UyH+5Lub+BoLc6/JBEt1h8xux+S9MYP1satNDgYlNRRSfiRwY8HTvuq69L37Acf
         Oyz7UmRcbae4z8ZtnMXbSPbLj5SYKmm1hXvlJ7f6lm6N8etTwis5FbgaGO7VcwMVrKt1
         QncoaRzIoyugsnqVKWez9riXj5EoFFEkdM42PSuS64x7HZWgTC7NzFbK3vn21qqY2LkK
         j5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWmuS5iAL+EbKhzG/BSAeiww0Fyy7+nyLmyaOgWpF/Xrev0zi9peVOQ9M0YO04zPdgSm6xvKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNSfo4BvGsQ/bllbkc4Ygqo8Ot0zxlVRw4kvRhjeVBRGX4Mu7
	l6roMO8DKxdXBOA1k7TedIK0/Z4Xgur6DBktoAu+O3my1v4tHZ2mJmukv42Ec7ovvBVT61T7eDu
	fHpgza6p93LVOTWDr4QC9USCpvMr9dF4=
X-Gm-Gg: AY/fxX4tyoNPraS3gyEk923QQoozEqyrM17aHGgFAm3aWdwikCfnl4dDn2gJ8xAk4tW
	jyvmxru9c50KoMXuQUFzPHdFC7smmyUh02VCa57ET1Jsx2JHAT/zcbJsdMiAy/9qWCRamn3h3oD
	QHL08XSa1ud0ApMWfmZaRfWGtltwpCd0cUlIHy4FLhs11Mq8vT0tqMI6ilS0x0SgqCQf0IwSD4H
	VKW8cbD1DqVfoFYQ+Xl/RchJnp8bHY46kuOFGJvjhCUwShKExr/Du60TbNJNEuJ4n8iCWgYtYU0
	5R/UDZ3RtH9NWmJ+ztUeZIZ6m+vG
X-Google-Smtp-Source: AGHT+IGpy3FSTV06PFzbySqT0GxE+YkHmWqyF+kpdkmaFPx4+wxyXnjiYwrYZ6SYwKhEXTYGmchl6zZMo9euRvgtVx8=
X-Received: by 2002:a17:902:d547:b0:2a0:d692:5681 with SMTP id
 d9443c01a7336-2a3e2da7892mr3742555ad.24.1767634114320; Mon, 05 Jan 2026
 09:28:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105150509.56537-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260105150509.56537-1-bartosz.golaszewski@oss.qualcomm.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 5 Jan 2026 18:28:23 +0100
X-Gm-Features: AQt7F2r1mVRbDaQh2zFy4l3agObZCNqWz_Ifa4aviOfolqOQgQGGMy9JJh7ZWmA
Message-ID: <CAFBinCAc7CO8gfNQakCu3LfkYXuyTd2iRpMRm8EKXSL0mwOnJw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: mark the GPIO controller as sleeping
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Mon, Jan 5, 2026 at 4:05=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
[...]
>   mutex_lock_nested+0x24/0x30
>   pinctrl_get_device_gpio_range+0x44/0x128
>   pinctrl_gpio_set_config+0x40/0xdc
>   gpiochip_generic_config+0x28/0x3c
>   gpio_do_set_config+0xa8/0x194
$ git grep gpiochip_generic_config drivers/pinctrl/meson/
drivers/pinctrl/meson/pinctrl-amlogic-a4.c:     .set_config
 =3D gpiochip_generic_config,
drivers/pinctrl/meson/pinctrl-meson.c:  pc->chip.set_config =3D
gpiochip_generic_config;

pinctrl-amlogic-a4.c still has:
  .can_sleep =3D false,

Are there plans to send a separate fix for pinctrl-amlogic-a4.c - or
was the intention to fix "all" Amlogic pin controllers in this patch
(which would mean that the change to pinctrl-amlogic-a4.c is missing)?


Best regards,
Martin

