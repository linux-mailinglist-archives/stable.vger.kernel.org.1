Return-Path: <stable+bounces-35610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFDF895713
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 16:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F421C2230C
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B312C53A;
	Tue,  2 Apr 2024 14:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfs30WC1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8B21292D1
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068655; cv=none; b=imKGflQXtvw20uGGh3dlG0q3uLFEgKET6WBaPInS14MDB8GkDc2KKUraNAH+qbl1TBLbLx7VaxqWFVT2Zh4+Z7GIA7lIYEG4yFQLaL/9j9nKE3CmtDazov54vZxoDu+acENi6w/jJ1Grh+a6Q58jzbugBEi0f/YPXW2N69Sq49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068655; c=relaxed/simple;
	bh=Fd/HwzaztITUJxMyj+qfecZwF8tVFkeNovH6sh9rg4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBpWT+zONnQBCyIRH61kQ2GCbHtaQKW6FoA4iAfdeNxbLSB+5PJQGLqFBD6fwrwwUka359rQzSiJiM9B30aNAbxW+wKIvH0oJeRJkZpJO4AmNZ0QUO64gp/Dbb6lIlIr5VoKfRXebwLCmTwxdggoxaoEh+tNQTtsI2DUu7mYK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pfs30WC1; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78c4db9fc7fso40687585a.1
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712068653; x=1712673453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yj505szOiMmI3AOU7YTk/JHlLza6EgQ1B7WbRbTjg30=;
        b=pfs30WC1dMzVm/JgbPXfR3mN+GP6iCqOUiugP3PSLcu4uQZwcUtg41EhCHaaQTpYVH
         uXh/fTM3Ydag3huc4gXZ0rbLS6Fqgg23zMdHw11DkZGiGp1fO9HzI9DWBIcT+g6dF20Y
         WGhsMshyQhoWmLwLMt6fh6ZcvWJhlt2EQz4j1knhU1sBlcsB6RKK1+dSQHEbPXhMuczh
         Oh50zjupfH3Lgn5F9iyq9unLVsM1J3B/JwzTYQpSa2qGTJ3MF/zly5RqJX+jGJVjbaNa
         1K4P2ytWxGY+lxkC1kE6WlnkoV07qxK2Qn+en1P7D0P9frBDKgQe1WMEAhY8lSVF1imy
         tM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068653; x=1712673453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yj505szOiMmI3AOU7YTk/JHlLza6EgQ1B7WbRbTjg30=;
        b=F1a8YxnvXqW/v0xpECE3U/+FIg2vZVBTSsoaQE+xEpgIHJsAPfezsirqrydBYtaLbs
         ubvmfgDYV0UDMsHxO56oE8KGKJPEmlsIwWN/hVPgqvsBBY8AKUAIJ+NC0yQIZjKaPsqF
         I7WCDWKjG41uQa93GY4q1slnxBVwUFTSQdn8lqTXc+HIthtIABkd0jxCT49gTVbwg5Mc
         2FKYQOtRj1UsLp1gRyEBxZU2Ntc+030yDEmvkqfXE0BdQiHA54UQmtn0oxHPVqRDfbo7
         9oHbBKCu4YQZyZAWLQociJrL9SVi0IKUGBCcikjHAvYFPoW1rAcVwBxN1jRRqC0V3f95
         nDZw==
X-Forwarded-Encrypted: i=1; AJvYcCUXJqCq63GWl6IT4lqIqxKMCUDfGLtobog+nHgJYZCxV3mcU1Jrhcu2NscBKHTd/cD8gE1dmkDwOza/qQ8FLd0Aogyma69m
X-Gm-Message-State: AOJu0YyoQw6pkAJjibaJWeefB13g8tLrVDa3+361mxSOf8NhhrIslfBl
	yZx6l27/CLWAje4a3TX4t2nYVPPD3Wf/bWlPr8frXkC1p2b1g2YIBCj+T+hXDMDH3O4YdJrwuZb
	Q16c4qwU1pI9jsum0uXjApvGnszK9m6953yxq6g==
X-Google-Smtp-Source: AGHT+IFyEOBYmCLSqQYNdbqQlreYLQqXbs4IG0N6ntPCkLO4z9b5DuFz0gSNB5+cj3PS0S8i6gj1En3J70FKvsWu9Vg=
X-Received: by 2002:a0c:ff4b:0:b0:698:ff7e:7ad6 with SMTP id
 y11-20020a0cff4b000000b00698ff7e7ad6mr8744063qvt.15.1712068652960; Tue, 02
 Apr 2024 07:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402114159.32920-1-brgl@bgdev.pl>
In-Reply-To: <20240402114159.32920-1-brgl@bgdev.pl>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 2 Apr 2024 16:37:21 +0200
Message-ID: <CADYN=9+Cz=MSLq++P6e+VOYo=ndP-nrjY2gj0LhV2Jvba2hMEw@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: check for NULL labels when sanitizing them
 for irqs
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexey Dobriyan <adobriyan@gmail.com>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 13:42, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We need to take into account that a line's consumer label may be NULL
> and not try to kstrdup() it in that case but rather pass the NULL
> pointer up the stack to the interrupt request function.
>
> To that end: let make_irq_label() return NULL as a valid return value
> and use ERR_PTR() instead to signal an allocation failure to callers.
>
> Cc: stable@vger.kernel.org
> Fixes: b34490879baa ("gpio: cdev: sanitize the label before requesting the interrupt")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/20240402093534.212283-1-naresh.kamboju@linaro.org/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Thank you for the quick fix Bartosz,
I applied this patch ontop of linux-next, tag next-20240402. the
libgpiod testsuite passed.

Cheers,
Anders

> ---
>  drivers/gpio/gpiolib-cdev.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index fa9635610251..1426cc1c4a28 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -1085,7 +1085,16 @@ static u32 gpio_v2_line_config_debounce_period(struct gpio_v2_line_config *lc,
>
>  static inline char *make_irq_label(const char *orig)
>  {
> -       return kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> +       char *new;
> +
> +       if (!orig)
> +               return NULL;
> +
> +       new = kstrdup_and_replace(orig, '/', ':', GFP_KERNEL);
> +       if (!new)
> +               return ERR_PTR(-ENOMEM);
> +
> +       return new;
>  }
>
>  static inline void free_irq_label(const char *label)
> @@ -1158,8 +1167,8 @@ static int edge_detector_setup(struct line *line,
>         irqflags |= IRQF_ONESHOT;
>
>         label = make_irq_label(line->req->label);
> -       if (!label)
> -               return -ENOMEM;
> +       if (IS_ERR(label))
> +               return PTR_ERR(label);
>
>         /* Request a thread to read the events */
>         ret = request_threaded_irq(irq, edge_irq_handler, edge_irq_thread,
> @@ -2217,8 +2226,8 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>                 goto out_free_le;
>
>         label = make_irq_label(le->label);
> -       if (!label) {
> -               ret = -ENOMEM;
> +       if (IS_ERR(label)) {
> +               ret = PTR_ERR(label);
>                 goto out_free_le;
>         }
>
> --
> 2.40.1
>

