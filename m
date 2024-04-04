Return-Path: <stable+bounces-35898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F289830E
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 10:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BA9D281EA4
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2166367750;
	Thu,  4 Apr 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nlb9scJe"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7084210E4
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218844; cv=none; b=HuOaCp7xYnhegwTVU6S122oAAvZjkZV2mlBR84bMzjVH6b3TKRtCxrHD3kGaU+T1zB1x/QM2vzktqfL1nApBW1JVWXrNyZE9DqJf/Tny+BWj4Te0O2Thfydizga7z9gojDEFUW1d1s2wpKKn2Kta6PZVJewJ4y0jxz8bH+jsnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218844; c=relaxed/simple;
	bh=DEtDOgJjtwKHKgzbnFh+oYPDkv4+cFLZBBuu6/r7Tl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2YlDfW4KKGZeowAwxMYGciBMdhZw+KcNaIgqF/4wkrurtvBhwTPNFEppBpTRncpaM3YA7ps8dLGDZGAPi5E6cg6jSh2I9lJJ0a1Kmp9korhd2kaGrcoNH8OqdKIgbmoa5P70Eqp4Eh893CftRi4rdU8RAjhf0OVh9Mts+mc5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nlb9scJe; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso493878e87.2
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712218841; x=1712823641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hA1F4ecNFaqy2INS6J/CJxJtqMknUSKBTL4J/GsVmSk=;
        b=nlb9scJeU/urPmrMrLDA0q2D5EsO4K3OsvIw/tE2jt1ryGv7LhnOnG7Xw6viXkXWy8
         um/+EtNsCGYppQWT73cq5I3jmdLJe8cA2P456b5F9M2St/wKNhI9THg9R+og4HozGsCq
         JdxoS3F8079o9IgkfmLGsoYEddsXZHP0XDlrLso2w1l7v7BW7MU7KGR7GTsER2tQfT6r
         whx0QarqmEv5xPpV41ZfH0wzf1zidzSnxYK2y/TEOEor2BI+KanLJ0ysKVUVWpfUFwTV
         pRGWMP36gkvxbl9rBeQTp5Xk6jFpAhTRDdyVGv76UCfsWQMfuyVrk9DiONbwdSjaELQP
         3A1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218841; x=1712823641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA1F4ecNFaqy2INS6J/CJxJtqMknUSKBTL4J/GsVmSk=;
        b=nf2v4sn/3Q90q1UKH5zQtOWlbdjjgy/EpbAQ8IsgtUptYP/hh4qUf8r1p+Xi3MFHBc
         /bKr1ynRRdEmhjWaOGxvc96UF8PcRcoKJHbzpUc41eNU6nbsrklwiA/TcVwFjayLvcPQ
         hTFJlyVv9ZEUZTOXFlKI7QQ0M0KFUqxTkmhFRjsLnCvAEvlHL1WO+4xJH4GBk3jAuedR
         +v460BAkUpJXFNJfT57XYUE4kbZgv2vnf4am0Ef2LXG3bzXcHeM3DyCSUzFyKLMH2CP4
         zpHedxx6pCL3nLWbXsJQePB5oGKtpWLTIu/qM+EG5UEvycUMcwSwf6tSyPGyPGSUUsKh
         j17g==
X-Forwarded-Encrypted: i=1; AJvYcCX1UMMnDtbJEUnTWWYTC8RvZJ8EmwdxSvffaBQCmrtMReMMISlmM6zCZCSPQqassuPnVHf6yaNbMGO0ZwcxddC0ezScXFdK
X-Gm-Message-State: AOJu0YwI09K19kX2QN8tQVLacaaPVDUKsaddEztNJH2RBP1GeD6Cu1cl
	DV89tTEccNlvrGMtNA+eNFMea0eHznPJZutLdzl46PKJBNKKiochf2TqoVa7MmqQx5kvi9c0owk
	4heZSZPdu+iyUp3h1fPJrIp8vCqzaLYHR9v4Evw==
X-Google-Smtp-Source: AGHT+IFyqOnNuajgEhPN2lGMEjaFHW2VF+WxCqdJBjBZlhWSuMK+lQfoZZNQECArc2FTcemx21az6fM07HImxUt/XlA=
X-Received: by 2002:a05:6512:6c4:b0:516:c763:b4f9 with SMTP id
 u4-20020a05651206c400b00516c763b4f9mr1773698lff.14.1712218840661; Thu, 04 Apr
 2024 01:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403131518.61392-1-warthog618@gmail.com> <20240403131518.61392-2-warthog618@gmail.com>
In-Reply-To: <20240403131518.61392-2-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Apr 2024 10:20:29 +0200
Message-ID: <CAMRc=Mf0DPN1-npNPQA=3ivQd-PMhf_ZAa6eSFjmQ26Y8_Gv=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: cdev: fix missed label sanitizing in debounce_setup()
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 3:15=E2=80=AFPM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> When adding sanitization of the label, the path through
> edge_detector_setup() that leads to debounce_setup() was overlooked.
> A request taking this path does not allocate a new label and the
> request label is freed twice when the request is released, resulting
> in memory corruption.
>
> Add label sanitization to debounce_setup().
>
> Cc: stable@vger.kernel.org
> Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting th=
e interrupt")
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index fa9635610251..f4c2da2041e5 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -728,6 +728,16 @@ static u32 line_event_id(int level)
>                        GPIO_V2_LINE_EVENT_FALLING_EDGE;
>  }
>
> +static inline char *make_irq_label(const char *orig)
> +{
> +       return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> +}
> +
> +static inline void free_irq_label(const char *label)
> +{
> +       kfree(label);
> +}
> +
>  #ifdef CONFIG_HTE
>
>  static enum hte_return process_hw_ts_thread(void *p)
> @@ -1015,6 +1025,7 @@ static int debounce_setup(struct line *line, unsign=
ed int debounce_period_us)
>  {
>         unsigned long irqflags;
>         int ret, level, irq;
> +       char *label;
>
>         /* try hardware */
>         ret =3D gpiod_set_debounce(line->desc, debounce_period_us);
> @@ -1037,11 +1048,17 @@ static int debounce_setup(struct line *line, unsi=
gned int debounce_period_us)
>                         if (irq < 0)
>                                 return -ENXIO;
>
> +                       label =3D make_irq_label(line->req->label);

Now that I look at the actual patch, I don't really like it. We
introduce a bug just to fix it a commit later. Such things have been
frowned upon in the past.

Let me shuffle the code a bit, I'll try to make it a bit more correct.

Bart

> +                       if (!label)
> +                               return -ENOMEM;
> +
>                         irqflags =3D IRQF_TRIGGER_FALLING | IRQF_TRIGGER_=
RISING;
>                         ret =3D request_irq(irq, debounce_irq_handler, ir=
qflags,
> -                                         line->req->label, line);
> -                       if (ret)
> +                                         label, line);
> +                       if (ret) {
> +                               free_irq_label(label);
>                                 return ret;
> +                       }
>                         line->irq =3D irq;
>                 } else {
>                         ret =3D hte_edge_setup(line, GPIO_V2_LINE_FLAG_ED=
GE_BOTH);
> @@ -1083,16 +1100,6 @@ static u32 gpio_v2_line_config_debounce_period(str=
uct gpio_v2_line_config *lc,
>         return 0;
>  }
>
> -static inline char *make_irq_label(const char *orig)
> -{
> -       return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> -}
> -
> -static inline void free_irq_label(const char *label)
> -{
> -       kfree(label);
> -}
> -
>  static void edge_detector_stop(struct line *line)
>  {
>         if (line->irq) {
> --
> 2.39.2
>

