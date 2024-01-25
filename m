Return-Path: <stable+bounces-15772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D389F83BC1D
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 09:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E21B217EB
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 08:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A3B1B969;
	Thu, 25 Jan 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="P12TEnux"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2773134C9
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171787; cv=none; b=gXzTgYKFngtg5YLOFY6jPKk6bW+xThV7qweNPtDoakpxa52CvNBRN5J2PrihBNfUYuv1wK/R3TkEzXYZJRniJ+iCjnqooIKxjZ5TigcA0m79xYGVKqChaf0A0h2SSr8yY3I+O5MPRlm5N3r4FbKcwTBPz1HQyIy8vJRMH3mxaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171787; c=relaxed/simple;
	bh=qooEtGvBQ+blKW5h4z3pxUBP8ioX7XV+ZmoVKK10Hxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/Au9sh8/q1EUhxApO0Pco6iw0HFqUwjSWBbuKao5APa2E7F7fdTgG1BPGtxm9FOGlz63uedqElexJXSofeR4HR5P556co3kiQpMkyWnXtV5A2HHnmr28ngSmaWnNaO26WZStlXSr+cXXcflunVm/VIjOiL6+ClGW1R7HEdMWdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=P12TEnux; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d2e15193bbso1974870241.0
        for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706171784; x=1706776584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yfrj1tSmrxaEJmK1wFt8ZyU62zaatrSaUH2xIk0e35c=;
        b=P12TEnuxcH1nAFTrJfddf97upD3yAMsK2NKhOWNgbNL3XvAH7vlnKD+SPYQy9kTk0F
         fxfh92VBVw8MUiHQ+KAKBX79LCQZzPnFDFk4ugB+r6oyoXGm6OWhJRJogXSK4Fo55xnP
         xLZwcfO981SITTNErLpBQrANOfBvIXpN9uibpgCIwUPopqzjnx93m1y57tcW2q2ony2m
         4rqTaNkUXA1m+SaihTlVbMmb6KqsglaV34zxQqrz4vybOfn6Ush4z7us2IpDzYZL6QpF
         5KxL0nPj+4UGUVlA60y3dX4GE8WZ2WD3NAqVXgVwoZzurxRVcGv4Kg1QSjZB/4O0MmrA
         fNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706171784; x=1706776584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yfrj1tSmrxaEJmK1wFt8ZyU62zaatrSaUH2xIk0e35c=;
        b=s1mlHy2vwR3lm1o2I4gQsOUqqccZzDFqtgkL4hQF222450JWYQjSAuVIyANtyCRyUn
         6ntACGST6eBBiumIAIfnZ6Z4DEorNINc7VD+6a9MkkrOj8d8w507G9ufuX7pNEveodUD
         ScYOXXkd5zvB8ctrrlkvmikzxO4Ytfw9XtOq2RYbW7WmeJ8fqMe3dgZ0teCEnXXBTAIS
         uIH56YyRrmiCL4w/F79Ju1kuqnFMnUj6OILz6kC5Ff/xXaaYx8DcGtFqEgZS3uXMUczI
         tVSWr3dP1hERtoAAvqcndzOhDCYLqlzgzFE1w7lnblPG42CUvMctI+7TlTyfbo1qZwur
         7aSQ==
X-Gm-Message-State: AOJu0YwtsIMZyWaoFgLxTsdjQUNaVt557FnEgn1VkK8iItOJY/9ymf+6
	AmbDzK0fySuDIiPNrToJMOHIEGWFm5fVoSP87cB3YqAu2cpw4RmtkxF+pRyJW5DLP9kYtLB51TM
	CR3SzSbMdXcRczN/iHCwpSM8DsMsLM4//FxBUIw==
X-Google-Smtp-Source: AGHT+IGjDrSN9NH9Q8W6iSCVre2BCEXpLwCYGPA1USwtRfIaGkgUmdH12KfPvs9ADyh4WxKD9T9WUXSiryfPlu5NEsE=
X-Received: by 2002:a05:6122:148e:b0:4bd:5edc:26c8 with SMTP id
 z14-20020a056122148e00b004bd5edc26c8mr290683vkp.32.1706171784583; Thu, 25 Jan
 2024 00:36:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240125081601.118051-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 25 Jan 2024 09:36:13 +0100
Message-ID: <CAMRc=MesG1nYSxx0osmQEEXCvs-6B4s4=TFYW5wD8pOXpV+OcQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Rosin <peda@axentia.se>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 9:16=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Add empty stub of gpiod_to_gpio_device() when GPIOLIB is not enabled.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 370232d096e3 ("gpiolib: provide gpiod_to_gpio_device()")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  include/linux/gpio/driver.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index 9a5c6c76e653..012797e7106d 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -819,6 +819,12 @@ static inline struct gpio_chip *gpiod_to_chip(const =
struct gpio_desc *desc)
>         return ERR_PTR(-ENODEV);
>  }
>
> +static inline struct gpio_device *gpiod_to_gpio_device(struct gpio_desc =
*desc)
> +{
> +       WARN_ON(1);
> +       return ERR_PTR(-ENODEV);
> +}
> +
>  static inline int gpiochip_lock_as_irq(struct gpio_chip *gc,
>                                        unsigned int offset)
>  {
> --
> 2.34.1
>

Why is this needed? Users of gpio/driver.h should select GPIOLIB.

Bart

