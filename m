Return-Path: <stable+bounces-47689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 162BC8D485E
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 11:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412871C20C4A
	for <lists+stable@lfdr.de>; Thu, 30 May 2024 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D42C14C5BE;
	Thu, 30 May 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fii79ogI"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68625152790
	for <stable@vger.kernel.org>; Thu, 30 May 2024 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060938; cv=none; b=BbUPXhAMmi4EnnKjYspUJhQvJTBpCej9ZMvjnUICi0kd+oV5KglA3gTeaPzrbFIE5rdRwmZUKqWOgK02bjYBncYukyIW3xjxp9NisHEJXB3IUPsRnQTaMQWjXBaloRvv+VgoS5/9pQObhNe54sniGm7BM8IqBmkxOhgheAJGux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060938; c=relaxed/simple;
	bh=qOALaBFtiFKu1Kyw1uTvIGvPyHrAyxbJXFr9phnkPyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JL99c7ckuffWcV4tHgTzo/ESRifz/m0uOHZ/QKCMLbSbQ0GKJ8yhIsJY/2lUOVK479tmnObPrCsnsH9zW04jrtt7nsfFajdx6ZS1sxKwzQRjGz4zN27Dws3X3xH38bQxVvpOVR+oLz8NX6ifH1Zlj3VIeRDph3GsDSVS6sRKquU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fii79ogI; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e724bc46bfso6849981fa.3
        for <stable@vger.kernel.org>; Thu, 30 May 2024 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717060934; x=1717665734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/z6JrsczbGlJdeagCzokQ7NOChpkizM9tHLk7nwYHc=;
        b=fii79ogIkC7xdQ1nsc6mICrncqiHNkHV8jApegjieRDlTLV9ThjAUQm2XM7riBUT9S
         9+1egyZekVeo5VhlqLN3tn2SzD0QH7E+SJAx454M9YbasrQQ12dUVCOSzwOoVvSC4pFR
         UZcXjJ/ULNmP1GZ229seLXhThI0HMVAiWS5uTYRyZYI9+RO9jIcUWrbqrKbuXoh+tARk
         6RpkKOC49RIKt/4BAf62EAnxpPbOte9dOyxfDLoOXnAO9xWp5r3jw+IRcUo5bPA4Dq4C
         AZJJVlb66Ba6NBG3kQrZMms8EK6ftju6AKQM2WR2gH9ARy6Hsgj8KBMiEn7a1yJ1y7og
         cLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060934; x=1717665734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/z6JrsczbGlJdeagCzokQ7NOChpkizM9tHLk7nwYHc=;
        b=ncdDq68GpjwgfNiaaBL8GWUPcwwm8ZezGFghjcRTt3y/E5HvkdI2gar6nl0Euq8Nhq
         H4euWYA065Yajki0tdr+5yseZYjNQoqNR9HSSNrm2/+ZY16MQ2Iyy0h/kWGaLudSDJPM
         RJtJqE1b0AvXUSGd2UyTWlN88B42GuBvLRzpkxe7dfJJowqI+3v7Hb5KOKovIsTtkRqu
         7/YwUuJtj4k4Z8Jgk+IuAHje2pcam7bO6n8lrorDGt0zjT3QyklvrUx0q7JgjuVL9zFw
         zZcofMyP/4wbcqvKur3AhWgYgnhFNYplD0/IVppAwTpEuPEWtbdQy/JMIschd+S9sEbG
         F2uA==
X-Forwarded-Encrypted: i=1; AJvYcCW3GlYm5ELk5/hoT7rZgiCADuR9NNsPXQHKch29wiqO5x9Ci/6KXqfN9uGkrGy8jDLnieoYCG+XNbp9hJoWJbfGqvAQXvoL
X-Gm-Message-State: AOJu0Yy2FdPEiGqEvjZ6GH+nOmRai/zm6D5hDYuRHcEb5r/RdHLSprSa
	cOrBgazdC9wnv59JYRi0JZ0wJGmYqjBsDGjDKe2qdkvRKO8RwjkRa37/qMl2XcCJ92TPN4wQ1Zu
	rA8MNUkBD9cu/WzhW3sS92fNuQ4ZHAo1AmTG1xg==
X-Google-Smtp-Source: AGHT+IGRJ3Rf6Gezxv9hcamuYQlhVWVAgV+Pbef78MTY3m0hnhXDE53keEkjqkBHl1Toem6mykR6y8+l+5Vju2z3wBI=
X-Received: by 2002:a2e:87d4:0:b0:2ea:8027:a6a7 with SMTP id
 38308e7fff4ca-2ea8488ac29mr6544131fa.50.1717060933982; Thu, 30 May 2024
 02:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240527132345.13956-1-ilpo.jarvinen@linux.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 30 May 2024 11:22:02 +0200
Message-ID: <CAMRc=MdWLzA=PYJg_6pq-doZ807S2w4Lo6SyLMkbVi41zdzzTg@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: amd8111: Convert PCIBIOS_* return codes to errnos
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Baryshkov <dbaryshkov@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 3:23=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> amd_gpio_init() uses pci_read_config_dword() that returns PCIBIOS_*
> codes. The return code is then returned as is but amd_gpio_init() is
> a module init function that should return normal errnos.
>
> Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
> errno before returning it from amd_gpio_init().
>
> Fixes: f942a7de047d ("gpio: add a driver for GPIO pins found on AMD-8111 =
south bridge chips")
> Cc: stable@vger.kernel.org

I dropped these.

Bart

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/gpio/gpio-amd8111.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-amd8111.c b/drivers/gpio/gpio-amd8111.c
> index 6f3ded619c8b..3377667a28de 100644
> --- a/drivers/gpio/gpio-amd8111.c
> +++ b/drivers/gpio/gpio-amd8111.c
> @@ -195,8 +195,10 @@ static int __init amd_gpio_init(void)
>
>  found:
>         err =3D pci_read_config_dword(pdev, 0x58, &gp.pmbase);
> -       if (err)
> +       if (err) {
> +               err =3D pcibios_err_to_errno(err);
>                 goto out;
> +       }
>         err =3D -EIO;
>         gp.pmbase &=3D 0x0000FF00;
>         if (gp.pmbase =3D=3D 0)
> --
> 2.39.2
>

