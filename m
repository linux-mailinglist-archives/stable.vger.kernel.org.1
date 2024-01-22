Return-Path: <stable+bounces-12351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975CC835DA0
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 10:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96631C22E2D
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8F38F94;
	Mon, 22 Jan 2024 09:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FqAtyt4T"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0734A3717F
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914383; cv=none; b=AoHtiHFTi5OhxgD//Xn4xm9JRScxn26wbTvFinot3EHSk7tTzCxLAnu1HygBmf4TZYnpTJzaoQDeV6Oib3rF58yvs4lN59os3/wUQoB7wInqOn6fUFHJsPa9vUvoAu3947cfG9BIebJWga+ycuHMtOJE/v8p6ORF6+ZIphONeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914383; c=relaxed/simple;
	bh=Ohy0ZGwqVFZ2Ynmb7PAYjwQ1AwA+GNIglKipPv38KOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTYFl0PnBxsmk6KIh0JFZqDJLTGK8hbrElZtZbfH/Eys0rtkNsZtAyv4NcsEmoGnTS1yNpqDv53pIBxbTL+qkpdpLTpRhQju+zCQfxWmRN2fwWIs6M3YPVRCEK9TYnCt7hoFQVOPj9Irz5VbsaQ3OUShaYu7odUqsTsjrGYnhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FqAtyt4T; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-466fb1cbfe9so622975137.0
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 01:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705914381; x=1706519181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp5tgkDSgj11h88t3e/z7UEfT/WURUMZNCx4eihIQpI=;
        b=FqAtyt4T5z2R4h3yKIT8Q8g+SIEah/KSfX4E3GL29mSUBgH7KlL3jDyU/FMDBUNVJG
         Q+p99BTjC2Wz2G4XJCQvUJZSwR7K2PflT3SFRaDhQNR3iZr2QcTJYQJI9u59vX6YPm+m
         OL00+6Qd0w6VwS3LwcsbHKHjX0kW1eMSDAb1OQfGNN8QRBg0xT/UaszAO7PZ04AIzLRW
         8A/2Fss21nwRpIOnVtjHV2iXkatseMBi0LkXsnAu38DgeomRb6LcIN57Zi0yugjw9gWh
         t2v8BjcdQWAyitzXnBiLzZEvHIO6zBz443+QWhIcfX9+C1nB2Hj+ssj255k0VkPVLR0Z
         UYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914381; x=1706519181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gp5tgkDSgj11h88t3e/z7UEfT/WURUMZNCx4eihIQpI=;
        b=R13OLsHEm1cQIMd4fQbFB8IOrGKcjgxevzBgB7SeNGnFE4LdIgHFEGffyq8E4/ixSc
         sW3Xf9Gw3IWnjs0F1CZE6bswx06G8MKYrhfxCgrBtfFkzcCJQaRXO8wFGQtolrue7/Od
         nXJNGGAV/3M8OzlIv1iq6Hx/wbEszbU0JlYUbpcvqLNX/irhb/jgoVcOcKumaCzL5nQG
         iTG+6OIxxeVV/8617nWfuSaPGw83e7+uGvbLaJ+aS8gc5QBH7idu839t8TCWy3RjnWQr
         guk4W6yYG2LAzQLj+9Zs/8xHKyj5EusImn33lca7c+7JgW/DtJgO+cQy7q7tlRsVklw/
         T22w==
X-Gm-Message-State: AOJu0YzwKyPs32/oZ5qX4i6gn/KSOiveHr/LKdDb2Y5s4nl20DSSr9ct
	UXJuzsndM8lB2xukDUQAaTc2OswxtIfagrVFlIOvYttSTK3U4gdAAT6qEGDTOVFZxtKvccEMw7l
	kSZRjXGGwUlKEDm3SWqzGtmr4CEtYPUJg3N1LRopVn5L+KLF4
X-Google-Smtp-Source: AGHT+IFfrOIr9bAUFkITg4Xb0WVWPc4vGtm9WQHIVP2Np7ndI6gmd4BUBnYr0dkPWJxnfhMP9tfiz9rZimSYJWdhN5M=
X-Received: by 2002:a05:6102:419e:b0:469:b52c:cdac with SMTP id
 cd30-20020a056102419e00b00469b52ccdacmr398531vsb.5.1705914381000; Mon, 22 Jan
 2024 01:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117142942.5924-1-mario.limonciello@amd.com>
In-Reply-To: <20240117142942.5924-1-mario.limonciello@amd.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 10:06:10 +0100
Message-ID: <CAMRc=MeUr6UYdWUudsF+6RvoCXsYxBDtw+2k2oJANvpNsBHPAg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-acpi@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, stable@vger.kernel.org, 
	George Melikov <mail@gmelikov.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:29=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Spurious wakeups are reported on the GPD G1619-04 which
> can be absolved by programming the GPIO to ignore wakeups.
>
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: George Melikov <mail@gmelikov.ru>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3073
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 88066826d8e5..cd3e9657cc36 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -1651,6 +1651,20 @@ static const struct dmi_system_id gpiolib_acpi_qui=
rks[] __initconst =3D {
>                         .ignore_interrupt =3D "INT33FC:00@3",
>                 },
>         },
> +       {
> +               /*
> +                * Spurious wakeups from TP_ATTN# pin
> +                * Found in BIOS 0.35
> +                * https://gitlab.freedesktop.org/drm/amd/-/issues/3073
> +                */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "G1619-04"),
> +               },
> +               .driver_data =3D &(struct acpi_gpiolib_dmi_quirk) {
> +                       .ignore_wake =3D "PNP0C50:00@8",
> +               },
> +       },
>         {} /* Terminating entry */
>  };
>
> --
> 2.34.1
>

Queued for fixes, thanks!

Bart

