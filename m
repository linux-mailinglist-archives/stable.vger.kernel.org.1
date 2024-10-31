Return-Path: <stable+bounces-89432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25169B80CA
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B86281814
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE361BDA85;
	Thu, 31 Oct 2024 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z4jMgQG2"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1441990AE
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394180; cv=none; b=Y+VIWVwA/SWp8v7jM2Zghx5dS+ZtnN5HY+rUc1ytVfcWCUFxgR0H9/UD33eE04WKd4YA680Wg7C+Mnlf33YCwt2ZtyKEwlQWyn/iNUouHZ+SiTkU1cX2L7Y3mXozGwoxUpaWaGus2/JU1A2wYWLPccVMXIrCRFh0U/yB1QCnCyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394180; c=relaxed/simple;
	bh=rkD19Bqc79gsPO5JVFTOqLgcccwuavxcVndttCcVjlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oysm2QFfXEB4NkdrMGKLplAwSF3nL7Zw7v1YOMzRE7ZJduZvJPfrL2ARtabByfLA4DY9kTCTiS9j98dge6OjKwWaqmDsXB7kuMXHfrAtffkJlF2I30Dou7JNsd7Er7DU0WmJ4e2n4NFygte4qsO7NXZiHr/CKxy6J1rjBls4sLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z4jMgQG2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539fb49c64aso1737874e87.0
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 10:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730394175; x=1730998975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itclNzkuhsNhu+rLimeOXz9VP4f+jH+BEVTSGay6rCw=;
        b=Z4jMgQG22yeSNkBwV+gYoJ2j2ep0LXQMNzfTrLdGWKmj8a+HpKvCuPOEu74hahtPZC
         yvCsrFpvieMYs/dm8OdTlW7WLWhRayqM8hcMBLYwPyteZnKBBFKs1kOzwPOvmbg9Zv1o
         J3VeQ2TiNf7+Q0dVkmXESoODFZjeONZR5Qn9Q6Ao+RD+0A/QARduMBOdQDS0IZ8ifK91
         JaxyduackvfjcGbX9DWTWHJkNHzERp5TQCG5YaVztfqiDAlyA1krBxQGxlzW8EjIqbEg
         Hygc2TC4Fzw+2jbZ2+orotyviyL2tzEs0NHFb/9cgZwjQk4+vxNq3KFX7EeUxI+Q6l1m
         aolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730394175; x=1730998975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itclNzkuhsNhu+rLimeOXz9VP4f+jH+BEVTSGay6rCw=;
        b=mtX4B5m2Qrl1adRCdx0Ir5c9mpPd932N1BuBG4bt69UcS7yoKdKyAB7CXuLqOyPBrH
         pFkt8vhGRO9Mjz0l4CHG26yYBS4cLk5pExizihsUetalHKYw3OpotenWB1XMw5i7a5Cf
         +bkK9o6JikrOWo5tgCYRKHQfMfuI0ubmBgflo3j7ThJnYGlProUNWgAt6tjZLZTT6mza
         9GmnabBhWE5wEcdxOsveSTR6PQWAgHPlKM71Zdns3EOVulBrsHmWJPk+jgG7bas84erG
         SvVyFG5rBBQzMSfgxdUrzxd52EQyWKjFKdDr/oRy3YoRVqwNH3ZeyoiFtY4TBP5FOfpj
         k75A==
X-Forwarded-Encrypted: i=1; AJvYcCXUZvw0UMZ9VSwKlksHObbK7b5ofpsV1ubltdnNzRJtyZjPknwz+5hMQQp0ORjBGy1J3zIUlEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVgZGta/NlCHGkjDoIUCerA+xQsPEHuYTKuAomLYBQ0llTz5bN
	vA+joizzEI665CVqEaOINgbunF+bEeCcGdwsU4lCVZhFtOqxb+WxQks+3gYi4Pp0O3LnutyFyvd
	+hrR9IkjVMsLdxF5OxVZ3woWlcxV5nRa8a9a3Tg==
X-Google-Smtp-Source: AGHT+IFkGhs17fk1WNgW2Lc1+p4at0/K/jnNWJKMySLeyD5thsCli3RrFU2Jul/rDz+A9y3BBriis/mOAyCzaxsMr+U=
X-Received: by 2002:a05:6512:3a8b:b0:539:89a8:600f with SMTP id
 2adb3069b0e04-53d65de5298mr761196e87.23.1730394174627; Thu, 31 Oct 2024
 10:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028125000.24051-1-johan+linaro@kernel.org> <20241028125000.24051-3-johan+linaro@kernel.org>
In-Reply-To: <20241028125000.24051-3-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 31 Oct 2024 18:02:43 +0100
Message-ID: <CAMRc=Mf6yaZMsF5x=vPet=y9fa5ZTuWSAA=oi+Qw07TF8GEFbA@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: fix debugfs dangling chip separator
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 1:50=E2=80=AFPM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Add the missing newline after entries for recently removed gpio chips
> so that the chip sections are separated by a newline as intended.
>
> Fixes: e348544f7994 ("gpio: protect the list of GPIO devices with SRCU")
> Cc: stable@vger.kernel.org      # 6.9
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index e27488a90bc9..2b02655abb56 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -4971,7 +4971,7 @@ static int gpiolib_seq_show(struct seq_file *s, voi=
d *v)
>
>         gc =3D srcu_dereference(gdev->chip, &gdev->srcu);
>         if (!gc) {
> -               seq_printf(s, "%s%s: (dangling chip)",
> +               seq_printf(s, "%s%s: (dangling chip)\n",
>                            priv->newline ? "\n" : "",
>                            dev_name(&gdev->dev));
>                 return 0;
> --
> 2.45.2
>

But with this change we go from an incorrect:

# cat /sys/kernel/debug/gpio
gpiochip0: (dangling chip)
gpiochip1: (dangling chip)
gpiochip2: (dangling chip)root@qemux86-64:~#

to still incorrect:

# cat /sys/kernel/debug/gpio
gpiochip0: (dangling chip)

gpiochip1: (dangling chip)

gpiochip2: (dangling chip)

Bart

