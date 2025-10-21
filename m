Return-Path: <stable+bounces-188338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A1BF6BCF
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BD448507C
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5A3370F5;
	Tue, 21 Oct 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KxDEMFrQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1495C334C28
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761052903; cv=none; b=Stn6oDPsF0b8sIt7wIpgoQ3unzESFkzKkY/t9lVpxoxbVC0gsyZfxkAX4Pz0Raw3kky+4Z/EPqd50/6IcbFibFBfIyGWy07BF0KAxrtpW+5VlALlZ1OFRbeBj4En1x7FHnUaLHYFk1PMootwkfutcxXBaRvS/vLwAyIiBA2QiDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761052903; c=relaxed/simple;
	bh=skb9hQ3bPDQ//+qmxKEwi9qpg4pair4gGJB5W3yGr4o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gy6of9SoYaJd2rlEzQAm9EfOCPXXixla39CuYgYFWnoTht6Zv6gbSAqJJa1IEHjNeXenp7bCqfLNIeMzKl0Ii+P81D79Dzp+FumHMCtkO+nToxz2N9Fo1UQEYWOQlyMrJvvfOl/9h890NHMqZy0r/49x91nCFeOs962T8DKdxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KxDEMFrQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so6356855e87.0
        for <stable@vger.kernel.org>; Tue, 21 Oct 2025 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761052899; x=1761657699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QB/8i9gcDwYx9MPZY12QJM3i5Ad8FHrbygJGWykWY6U=;
        b=KxDEMFrQoC2JLkZqQg0/N/oQcpw+fH8JIqkDdOdzxrevNjMrv/dC+IzEf1xYhiOP2b
         Hjh5aCNtbM3thD5FBUtbW/42/nD5gA9PHTJj71Gw/6m4YQhgfih6S0zJu3lGMC44cB2E
         4oaS30vxwTj0Ch9aryiWDR2rArlcE07z2/x+JIradcTjetFoViMJWib257+/C6JHvEJA
         82voJqIoj7OfSq4wkUxNr1i67gcRqBCGTRUhGSI/lv5Ll+rjVlVuVBQizv9o5KqiCeXU
         jOjw+rmsVjHWJ49BYX8IAPeucQp0MoEpPGWgUFXlcFNy7+GlV3Syq2rqAQ99NVCbIYFp
         +wrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761052899; x=1761657699;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB/8i9gcDwYx9MPZY12QJM3i5Ad8FHrbygJGWykWY6U=;
        b=f/8lntNtxT+rUlBSVs3FXsysr+j7+L1fulZXZIR1px0kCtLv01oT9Kyrc7uH8wHoJM
         Qfp+94SuYL9pCS5zXvJ58LQeatUv9CaHoWxn7Ia3QfVT8IS5hLZ/owscSxYPe4HUkBUM
         ImFg5mFKOgSSZgfnZi/krVs/2iXuayd3YiS7GkGPWKTM5N1eOw2IYosrHapWrjtv+IZl
         So5XjZsFNzYiOMtKtDsBvMO6mJA8ue61L85bOeW5vNDh8EoyJZs4P65KQSXQdF7XLrIz
         vYdFWk0Sz9XdmrgMLRDG2jIhsrw/rSAhRUQO92Z8hYAZYOhqFjCU9ZfD+9pIz3QCFJ5i
         GM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxxGz7ssCWwXW32NzRwI9oYYZFOIGcDj3RCXGPlO8Z41UfZoHZ2Jtb84V1aE1TdCW+JTVsLmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBBpQUMUMFF138hYxedWoMSTAkCJrwlDIuFG04qU7TtWBtk7Zf
	gCHeruj2bKHM5oMnQ4nhB58Gel/20t2gOjr3lhOvFJVzzEBpW11Nca2hLl0YppVYJ+gxNXquG5i
	91cb68ZJjNON9VgLOlmMDAZXTzbJ5g/GxLPYhvyrmXA==
X-Gm-Gg: ASbGncsUeBweIpy05p61z1hBcdkGsRFMCCvmFuZK0QluSdEz28MQ9IEI75330GXymaj
	+oCtW+MjkX5v+mk6s5hheDJgvSW1z3y/cRALVGkiewMViYNgr/s904yxT4NRSckiamEOifwOkFE
	UWRT4xx5KW0WtBZ96VIpUsbAQBiPb43RtIQdkRvVJvW71pLZMBo0QsOHUsRlkZ0g/tOHaUYtnsg
	IvC28yyLNqBVuZ4lyx9jyNSqny5zsdJHH5EpcZNTXkwzrAafOYldXhx5Qu2LHylGRhvNUfVpcEt
	xVN4CDZ5yvx8dmy++jXFjlqRa0E=
X-Google-Smtp-Source: AGHT+IFU9Qs1FF3tvhuZ5QNpuWHEjsct+r642wNfUlzflw0GmkJA6bzYaO33fmeXk7R1wFoOfbXFWOTQ8VOF5mms5iA=
X-Received: by 2002:a05:6512:ea8:b0:55f:489d:7bd with SMTP id
 2adb3069b0e04-591d84689e0mr5110249e87.0.1761052899116; Tue, 21 Oct 2025
 06:21:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Oct 2025 09:21:38 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Oct 2025 09:21:38 -0400
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org> <20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org>
Date: Tue, 21 Oct 2025 09:21:38 -0400
X-Gm-Features: AS18NWA1C6wtwpPuGtGISwiqHUwqLrfrlE6ZnSP2lWK50cndlklyKCnzfgz1HbQ
Message-ID: <CAMRc=MeFZTDk4cgzEJNnkrJOEneFUBLwtKjkpV3-cLSm=xsxNg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: idio-16: Define fixed direction of the GPIO lines
To: William Breathitt Gray <wbg@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 10:51:46 +0200, William Breathitt Gray
<wbg@kernel.org> said:
> The direction of the IDIO-16 GPIO lines is fixed with the first 16 lines
> as output and the remaining 16 lines as input. Set the gpio_config
> fixed_direction_output member to represent the fixed direction of the
> GPIO lines.
>
> Fixes: db02247827ef ("gpio: idio-16: Migrate to the regmap API")
> Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nutanix.com
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fixed_direction_output configuration parameter
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> ---
>  drivers/gpio/gpio-idio-16.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
> index 0103be977c66bb8d165c1c92123368be6832d120..4fbae6f6a49727df40f2793b42ca207d78ec272b 100644
> --- a/drivers/gpio/gpio-idio-16.c
> +++ b/drivers/gpio/gpio-idio-16.c
> @@ -6,6 +6,7 @@
>
>  #define DEFAULT_SYMBOL_NAMESPACE "GPIO_IDIO_16"
>
> +#include <linux/bitmap.h>
>  #include <linux/bits.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -107,6 +108,7 @@ int devm_idio_16_regmap_register(struct device *const dev,
>  	struct idio_16_data *data;
>  	struct regmap_irq_chip *chip;
>  	struct regmap_irq_chip_data *chip_data;
> +	DECLARE_BITMAP(fixed_direction_output, IDIO_16_NGPIO);
>
>  	if (!config->parent)
>  		return -EINVAL;
> @@ -164,6 +166,9 @@ int devm_idio_16_regmap_register(struct device *const dev,
>  	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
>  	gpio_config.reg_mask_xlate = idio_16_reg_mask_xlate;
>
> +	bitmap_from_u64(fixed_direction_output, GENMASK_U64(15, 0));
> +	gpio_config.fixed_direction_output = fixed_direction_output;
> +
>  	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
>  }
>  EXPORT_SYMBOL_GPL(devm_idio_16_regmap_register);
>
> --
> 2.51.0
>
>

Turns out, this requires commit ae495810cffe ("gpio: regmap: add the
.fixed_direction_output configuration parameter") so I cannot queue it for
v6.18. What do you want me to do? Send the first two ones upstream and apply
this for v6.19?

Bartosz

