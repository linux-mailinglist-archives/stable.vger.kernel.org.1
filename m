Return-Path: <stable+bounces-40407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005258AD6C1
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FC11C211AF
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0F71CD39;
	Mon, 22 Apr 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YEhU+RcZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7C1CD20
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822870; cv=none; b=QFcA9wKew9r1KT+XFb/YRvjeuEC69hD5AnSzVvbmFSiUFiWrjXwi02lEtZiIGLXwr2h2oDxfJNAcmF7gX4XiE5988MbHHZX8vWmFNwi/MmQ6V+OrslzsH+cV15+wdhkK4o9bpcobkFQuCVe7dXoWgaXbZ9t6gZ9zXNEMEQD/hxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822870; c=relaxed/simple;
	bh=Cbt4igSSEOCM0YFndB3iSaxU9eb8wKebvbCilWGRQq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ByD5r0tfTNIdGLEVyLJ4jJxycidAvxUSfSDEvE0Pd8eYLIzvGyHHj9A/+rDbzv8Vdb37zkeAJev3dehqc2w9fDs/ZBOpELe+K25afPbfnJX6uVZZsmOWGUfFD3P3/G3SCt2qDPAzd63UQe9yb01C7wQoY/2wzu2ZqLp08sXJyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YEhU+RcZ; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa2a74c238so3158715eaf.3
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713822866; x=1714427666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4TkjiOmnf7EkU2uUP7WyZ/U9eWwbiO9i0mpJYmLC7M=;
        b=YEhU+RcZ9DG2o7bbTF66ZGEe048wtODeAHs9XyalWF2RbKwputMXN8iO6AKtloNE2h
         w91eHwIG6eQck4zCHy2TtyZIn1XkQ27G/BuAhLRzlXmz6x93m7BuHDy9ehA753o6M+7l
         uEFucKm4ECEWoun3DuBvQN9DpWAaINC+Z5wL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713822866; x=1714427666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4TkjiOmnf7EkU2uUP7WyZ/U9eWwbiO9i0mpJYmLC7M=;
        b=gZWajbnfm1tisWqMj/4uxV/q7Ga5BBK/F0sRsdtmq+FyvUFNK7V/X8phNa0f1fiemc
         znSGIw6nrdlnfwJcESbt9dTsCneWBoDpZ5rCxSxqlo/HpviUrHb/0b4BwdEd/NDAeYBM
         0lzIV8DVHeXdZc2wyLDEz6hv2/HEZwndwAuWiPhNePGt342v6TWbm68c+UV/Eb4l1eK8
         /B9LTtUL0Q1EK+KZ7WtNuXzmbS8xYTwKthg0Ah1SalHRpN9tRDTc23b9DsQeCbyVALe7
         yAiVd/BWSA5Qr6HK2zP70JYFCSn7tY5LfLuXY+WBW90CzDohIjecFGzY7aaxawoq9Fzz
         LQpg==
X-Forwarded-Encrypted: i=1; AJvYcCWUXGV8+rV/KFoaNlEWU9LoBX5pk9Sx6MrYQv2som0qDXk/hi9PMprEr/tJ6cUC+x1z8u/ETYELBJyhpvHIbnZoy34G2AkM
X-Gm-Message-State: AOJu0YyLBMDsDjEtoO0uxBWHG63jL+RWboS1yEKy6rlBsXjB4CkPP8wn
	4rLm6h/E9AS13gkdGGdVbFPfcyY/K4m0pqLSf9Bq22SWY73+lOJ4yafiortZwuYrNkIVhPANTQL
	jm4Zf
X-Google-Smtp-Source: AGHT+IEucZnGBV7k7SzGE3NmERUiMiZYUMLRqna9K0My8+2xFxhPCcLmpRF6v2fEbkYA+Jtf52eDAw==
X-Received: by 2002:a05:6358:78d:b0:186:2852:a923 with SMTP id n13-20020a056358078d00b001862852a923mr12956412rwj.27.1713822866378;
        Mon, 22 Apr 2024 14:54:26 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id q6-20020ac87346000000b004372541e823sm4608185qtp.79.2024.04.22.14.54.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 14:54:25 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-439b1c72676so60281cf.1
        for <stable@vger.kernel.org>; Mon, 22 Apr 2024 14:54:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXy967D5fzCZmTeKVbb1KZj1Kxt0WNKfVZtS+jYiti+B3cvYoQ05M4eH3BVUFuc1tMtnmfFScihQ2E2AzlPjefOuwF+HeoN
X-Received: by 2002:ac8:550d:0:b0:439:9aa4:41ed with SMTP id
 j13-20020ac8550d000000b004399aa441edmr95963qtq.16.1713822864486; Mon, 22 Apr
 2024 14:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419-kgdboc_fix_schedule_work-v1-1-ff19881677e5@linaro.org>
In-Reply-To: <20240419-kgdboc_fix_schedule_work-v1-1-ff19881677e5@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 14:54:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UHt7Pm-qEBs7vtK0B0DCbu9YbU465OdpSKCYZVpNuOaA@mail.gmail.com>
Message-ID: <CAD=FV=UHt7Pm-qEBs7vtK0B0DCbu9YbU465OdpSKCYZVpNuOaA@mail.gmail.com>
Subject: Re: [PATCH] serial: kgdboc: Fix NMI-safety problems from keyboard
 reset code
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Liuye <liu.yeC@h3c.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 19, 2024 at 3:30=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently, when kdb is compiled with keyboard support, then we will use
> schedule_work() to provoke reset of the keyboard status.  Unfortunately
> schedule_work() gets called from the kgdboc post-debug-exception
> handler.  That risks deadlock since schedule_work() is not NMI-safe and,
> even on platforms where the NMI is not directly used for debugging, the
> debug trap can have NMI-like behaviour depending on where breakpoints
> are placed.
>
> Fix this by using the irq work system, which is NMI-safe, to defer the
> call to schedule_work() to a point when it is safe to call.
>
> Reported-by: Liuye <liu.yeC@h3c.com>
> Closes: https://lore.kernel.org/all/20240228025602.3087748-1-liu.yeC@h3c.=
com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/tty/serial/kgdboc.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 7ce7bb1640054..adcea70fd7507 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -19,6 +19,7 @@
>  #include <linux/console.h>
>  #include <linux/vt_kern.h>
>  #include <linux/input.h>
> +#include <linux/irq_work.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/serial_core.h>
> @@ -48,6 +49,25 @@ static struct kgdb_io                kgdboc_earlycon_i=
o_ops;
>  static int                      (*earlycon_orig_exit)(struct console *co=
n);
>  #endif /* IS_BUILTIN(CONFIG_KGDB_SERIAL_CONSOLE) */
>
> +/*
> + * When we leave the debug trap handler we need to reset the keyboard st=
atus
> + * (since the original keyboard state gets partially clobbered by kdb us=
e of
> + * the keyboard).
> + *
> + * The path to deliver the reset is somewhat circuitous.
> + *
> + * To deliver the reset we register an input handler, reset the keyboard=
 and
> + * then deregister the input handler. However, to get this done right, w=
e do
> + * have to carefully manage the calling context because we can only regi=
ster
> + * input handlers from task context.
> + *
> + * In particular we need to trigger the action from the debug trap handl=
er with
> + * all its NMI and/or NMI-like oddities. To solve this the kgdboc trap e=
xit code
> + * (the "post_exception" callback) uses irq_work_queue(), which is NMI-s=
afe, to
> + * schedule a callback from a hardirq context. From there we have to def=
er the
> + * work again, this time using schedule_Work(), to get a callback using =
the

nit: schedule_work() (no capital "W").

> + * system workqueue, which runs in task context.

Thank you for the comment. It makes the double-jump through IRQ work
and then normal work clearer.


Other than the nit in the comment, this looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

