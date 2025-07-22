Return-Path: <stable+bounces-164266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D5B0DFBE
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9250188BFBE
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092BF2EBDD9;
	Tue, 22 Jul 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Rylzj8wd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6602EBB9C
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 14:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753195936; cv=none; b=cOUSyVMvdQn5eK1gqPgyWnCrvb+NcdVmE1VgBKz0+IT6BwzoyWvRjZm5jGJQoEknB2ETS8KZG0P0goLcYy96T+EWr6E98XF8MBIDY8hq2rhIwsAJWq78jTcQ89dkHX6id1Y2ucYXvb9c9ormBQlcB2a6BgBJpGB2jnmozwqOlLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753195936; c=relaxed/simple;
	bh=QptCdfvykdDw3mSwfgLPntt5smoEgwzkhb48jG2MnBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKmQHDDS5qFiv60faOGu21Un5SgbVN9d5dE7oIOjLv6Qfaoiny6snjKpRI33Cexa295y9bo/oeVhDnVwitlHOj1rzPZ0ZKFFZnMG4g4w6SfsVNPYM/As/tS5/qWMr73f2Eyney8iQyIGtyNTJ1P1a3IirqSCBLlGHIE96d7YUZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Rylzj8wd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b4876dfecso58566231fa.1
        for <stable@vger.kernel.org>; Tue, 22 Jul 2025 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753195933; x=1753800733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASqqLKV7bTOZHh+QoLYPQiepbbVzcIRPmS7WnFNjHYU=;
        b=Rylzj8wdII24dUVahw5uUpv+ZlivET4HvEkoifNSSJ5MAMYXNePHa/g9enfiiaelK4
         atgI1Nt9Xq7A69iLf67O7QgUJF5uIN09pvzK/CKkbW7vACpzsOmwnUYOYHlxyvLbmBWi
         RDWm48OYFiGN0IJdNtDC1DDK/JSB/HH4Rz4hQzJ78TpvAywuXlzqhXIa/WWQaxWAVKkC
         omk/5rY1TKOD83TIpMCrb1lCEi0VjVnmnTEHeP5un0D9fLQ3T9PEuLzvLQzhvulON4Ug
         w+qB4mpbJzRV//eEnjUvKL8F4ObVwZLL4XAAVNFWBeCgScguFVfKuydvhmS8ywk7irMg
         6FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753195933; x=1753800733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASqqLKV7bTOZHh+QoLYPQiepbbVzcIRPmS7WnFNjHYU=;
        b=uAGfR/VE3DEhwYOkAYrnxI58UFdvUMQ1bqR7gO1iLB1uqwPuIU6WH3sw1cuUFJgKjj
         Ou0A0SNQSiU74ln934g8tgWG1eg+7laLmSkjOTOzOzbSDOk6xacaGIWZYlSsek2MKNUV
         CRGq2oCjeV5oGsGxeoO4Pf7V9LWb2T4aKWriIUP8UKnd+eDig3sEMJy7pcj9gDqrfFvg
         0z+eJr3bdfeeqoGegWkubF4+wMHKYIjI8hR0+VQ59zAW9X8WcbWxk0ymv3CxUV5yuyip
         HRf5kTQdSpljGQBtLJkv4Mcd9QsI2iABGXAjeuWG/CJ3zT04hmAc4339ASjDmdViK0Mz
         yW9A==
X-Forwarded-Encrypted: i=1; AJvYcCXaiyFOjMekfoi0B5F9FCA83qo0Ot70HkaUeCxuCVtoxlaaM09lpxpFJam7mLOZvEAXkpWPrcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tkzBxdAAvX2tdsHtIdoLC0zZIlcIkOyAWxIxTGCURmy+Teko
	giM5ZMNGxXTcX5LwTYxitMFXmM48cSCUYD481frvDIeeEDJ5fgqwgM8agj5x0g9ZUFdt0G62ZDP
	CsvLmVIfrposchBvqyBeiZPZyBYvCJoAH8UdOO3Ml4w==
X-Gm-Gg: ASbGncvBMYc3Sf3qWBImK3yYnsNctyhx+gOJBS15GaPPdyK4TUph1byGTagdvVgr3KT
	K+NlL1EeewmK6P/m8tL6qwTXeJoSsAvG8gvOl57EdAvKOgAq8DwobynuzDLLVs5yQTNWYtP9a/s
	CHxXnD/hnhMCzgyLIPU8Arz3Q4xMAMmDRm6BsgvKsIpgIF9RSI/JMR0s5xGPsqBLSl5qWo0TCoW
	8S6iU/4+qnM3mvuDUro63ctHeYwEfQ8c/ZyKw==
X-Google-Smtp-Source: AGHT+IFFeuzQyysu6UbiTgYyXjNhyet5KnMKaIrTOY6lGXsapE59WD9CvOGRswKVyAeZi1GXx6ySe7/m8egNRed2iQY=
X-Received: by 2002:a05:651c:2221:b0:329:136e:300f with SMTP id
 38308e7fff4ca-330d2615568mr12136631fa.13.1753195932997; Tue, 22 Jul 2025
 07:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721162215.30327-1-davthompson@nvidia.com>
In-Reply-To: <20250721162215.30327-1-davthompson@nvidia.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 22 Jul 2025 16:52:02 +0200
X-Gm-Features: Ac12FXxEPv4XqzBEYN1mC45x64VjToB_w4CqfiuYbLU7-hd--JtE0CqJrybcrak
Message-ID: <CAMRc=Mfg42wvT9qdYrhvFq_wdvThmWpbvvo-p9bHSsyK0pn+bw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio-mlxbf2: only get IRQ for device instances 0 and 3
To: David Thompson <davthompson@nvidia.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linus.walleij@linaro.org, davem@davemloft.net, asmaa@nvidia.com, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Shravan Kumar Ramani <shravankr@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:22=E2=80=AFPM David Thompson <davthompson@nvidia.=
com> wrote:
>
> The gpio-mlxbf2 driver interfaces with four GPIO controllers,
> device instances 0-3. There are two IRQ resources shared between
> the four controllers, and they are found in the ACPI table for
> device instances 0 and 3.  The driver should not attempt to get
> an IRQ resource when probing device instance 1 or 2, otherwise
> the following error is logged:
>   mlxbf2_gpio MLNXBF22:01: error -ENXIO: IRQ index 0 not found
>
> Fixes: 2b725265cb08 ("gpio: mlxbf2: Introduce IRQ support")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> ---
> v3: added version history
> v2: added tag "Cc: stable@vger.kernel.org"
>
>  drivers/gpio/gpio-mlxbf2.c | 56 ++++++++++++++++++++++++--------------
>  1 file changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
> index 6f3dda6b635f..fc56ac81e344 100644
> --- a/drivers/gpio/gpio-mlxbf2.c
> +++ b/drivers/gpio/gpio-mlxbf2.c
> @@ -353,7 +353,9 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
>         struct gpio_chip *gc;
>         unsigned int npins;
>         const char *name;
> +       char *colon_ptr;
>         int ret, irq;
> +       long num;
>
>         name =3D dev_name(dev);
>
> @@ -397,26 +399,40 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
>         gc->ngpio =3D npins;
>         gc->owner =3D THIS_MODULE;
>
> -       irq =3D platform_get_irq(pdev, 0);
> -       if (irq >=3D 0) {
> -               girq =3D &gs->gc.irq;
> -               gpio_irq_chip_set_chip(girq, &mlxbf2_gpio_irq_chip);
> -               girq->handler =3D handle_simple_irq;
> -               girq->default_type =3D IRQ_TYPE_NONE;
> -               /* This will let us handle the parent IRQ in the driver *=
/
> -               girq->num_parents =3D 0;
> -               girq->parents =3D NULL;
> -               girq->parent_handler =3D NULL;
> -
> -               /*
> -                * Directly request the irq here instead of passing
> -                * a flow-handler because the irq is shared.
> -                */
> -               ret =3D devm_request_irq(dev, irq, mlxbf2_gpio_irq_handle=
r,
> -                                      IRQF_SHARED, name, gs);
> -               if (ret) {
> -                       dev_err(dev, "failed to request IRQ");
> -                       return ret;
> +       colon_ptr =3D strchr(dev_name(dev), ':');
> +       if (!colon_ptr) {
> +               dev_err(dev, "invalid device name format\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D kstrtol(++colon_ptr, 16, &num);
> +       if (ret) {
> +               dev_err(dev, "invalid device instance\n");
> +               return ret;
> +       }
> +

That is *really* fragile. Andy, Mika: does this look remotely correct
to you? I don't know much about ACPI systems.

Bart

> +       if (!num || num =3D=3D 3) {
> +               irq =3D platform_get_irq(pdev, 0);
> +               if (irq >=3D 0) {
> +                       girq =3D &gs->gc.irq;
> +                       gpio_irq_chip_set_chip(girq, &mlxbf2_gpio_irq_chi=
p);
> +                       girq->handler =3D handle_simple_irq;
> +                       girq->default_type =3D IRQ_TYPE_NONE;
> +                       /* This will let us handle the parent IRQ in the =
driver */
> +                       girq->num_parents =3D 0;
> +                       girq->parents =3D NULL;
> +                       girq->parent_handler =3D NULL;
> +
> +                       /*
> +                        * Directly request the irq here instead of passi=
ng
> +                        * a flow-handler because the irq is shared.
> +                        */
> +                       ret =3D devm_request_irq(dev, irq, mlxbf2_gpio_ir=
q_handler,
> +                                              IRQF_SHARED, name, gs);
> +                       if (ret) {
> +                               dev_err(dev, "failed to request IRQ");
> +                               return ret;
> +                       }
>                 }
>         }
>
> --
> 2.30.1
>

